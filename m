Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D18240604;
	Fri, 25 Apr 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579600; cv=none; b=LUysVKE5PVC1yIsz98kGKESQv2iFyxUc/LltU10b4y4KKVwv4TY8sk8PLJARiJXiWRQgc1iw1kdBRZYmhEW9BDwkHlGkmuAmgaEkt9dIQYxd0/pQbnyW4D0p8ZwY0eyWqJp+EitBrw0N0QMDjCiJlM8yXzL7qqKxnnq0C1DBLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579600; c=relaxed/simple;
	bh=c3F1gW9ZPCR5oHtLAFds0q5hpGxchQa902GwA8/ZnVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oN8I2kGEt6Bb6Dd9xhUH5lytg7YEc7FseEE2NwcZ70bAHrN7vWouTmBJ+Ug7rOtKYj69HZ8CaY9bfzvOhmAoYpnQWsmCVB7ETvc11wkxtTGSRTBruSjlhkVyHAR4cS04D0xm5ExecvNMrxFa+1ZqWtfbqXRg8Wx3ByNYP91Bgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbvtIGdY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbvtIGdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD83C4CEEB;
	Fri, 25 Apr 2025 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745579600;
	bh=c3F1gW9ZPCR5oHtLAFds0q5hpGxchQa902GwA8/ZnVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbvtIGdYxF4RFuOhlej2+RLOUz7SFQ9JsUnKoUHFceBhcL0f94AtmbtNOXrkxJpob
	 xjJbRz7zCzO/nTy+j++nTSVAr+XuDvJmyQAsZkwHw3tKQyiQsKTzo6zUMZ+jHYPZvm
	 Gs2aoGXwSL0I0ohYHJnm7FBRlfkrD30wEpz1iVmz3f0Jv94Nbpu1lfPb4mOnydZmQJ
	 uNhpUrBGh3o3yA6xQnXSL6bNPttwwcSvbdVhCcUEFz91+3wXEIhfMm3FmpYslRqxeF
	 wFFEHLjcwpMeOqugXDtKQMuvy/66t3wtX7hFn0M+/QOvS/pSARt4hfQmWdlk9T4gZi
	 +QjfE1lFQG85A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 1/6] tty: simplify throttling using guard()s
Date: Fri, 25 Apr 2025 13:13:10 +0200
Message-ID: <20250425111315.1036184-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111315.1036184-1-jirislaby@kernel.org>
References: <20250425111315.1036184-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_throttle_safe() and tty_unthrottle_safe can be made less convoluted
using guard()s. Switch them.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_ioctl.c | 50 +++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 85de90eebc7b..90c70d8d14e3 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -122,21 +122,19 @@ EXPORT_SYMBOL(tty_unthrottle);
  */
 bool tty_throttle_safe(struct tty_struct *tty)
 {
-	bool ret = true;
-
-	mutex_lock(&tty->throttle_mutex);
-	if (!tty_throttled(tty)) {
-		if (tty->flow_change != TTY_THROTTLE_SAFE)
-			ret = false;
-		else {
-			set_bit(TTY_THROTTLED, &tty->flags);
-			if (tty->ops->throttle)
-				tty->ops->throttle(tty);
-		}
-	}
-	mutex_unlock(&tty->throttle_mutex);
+	guard(mutex)(&tty->throttle_mutex);
 
-	return ret;
+	if (tty_throttled(tty))
+		return true;
+
+	if (tty->flow_change != TTY_THROTTLE_SAFE)
+		return false;
+
+	set_bit(TTY_THROTTLED, &tty->flags);
+	if (tty->ops->throttle)
+		tty->ops->throttle(tty);
+
+	return true;
 }
 
 /**
@@ -152,21 +150,19 @@ bool tty_throttle_safe(struct tty_struct *tty)
  */
 bool tty_unthrottle_safe(struct tty_struct *tty)
 {
-	bool ret = true;
+	guard(mutex)(&tty->throttle_mutex);
 
-	mutex_lock(&tty->throttle_mutex);
-	if (tty_throttled(tty)) {
-		if (tty->flow_change != TTY_UNTHROTTLE_SAFE)
-			ret = false;
-		else {
-			clear_bit(TTY_THROTTLED, &tty->flags);
-			if (tty->ops->unthrottle)
-				tty->ops->unthrottle(tty);
-		}
-	}
-	mutex_unlock(&tty->throttle_mutex);
+	if (!tty_throttled(tty))
+		return true;
 
-	return ret;
+	if (tty->flow_change != TTY_UNTHROTTLE_SAFE)
+		return false;
+
+	clear_bit(TTY_THROTTLED, &tty->flags);
+	if (tty->ops->unthrottle)
+		tty->ops->unthrottle(tty);
+
+	return true;
 }
 
 /**
-- 
2.49.0

