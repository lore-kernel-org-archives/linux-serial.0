Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE21FAC4C;
	Thu, 20 Feb 2025 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050188; cv=none; b=N1UrA42KWO2mFMMlczVZgnckG0vSQRBvfqX8jkcnvJkg5+nGHQZ3H13b9V6bWqCQgbwBWjq3CiXo9ChvvQofARPAmFWrdu2gN7s1bCWXeI/EpUhNR7yo+w6NRe6ouJvDEG2kyS8J1cGLyaXDFe8UGevWxwP8a1Wcjx7X7O5CUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050188; c=relaxed/simple;
	bh=qhyJ5nurd/KtDfxYFGukXboD8bJm+cxcpPMnMsiAeBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlTgaTp07BPL/zLTdRfqfurxZrXHnrnyobf/WoexmU1XRGEW8cbhjBbq1ZweAJWF5IAZsRXAzNVdbCTIQtx/J4fIdzT3pgCsQLGauJC1xMloltCTsKdeNX1C6qJdEdf3BIB7BL9GtXSE7hYJ35qFZiBMH3CzP8o0RmZwzDQoMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3L20lp/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3L20lp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF68BC4CEE3;
	Thu, 20 Feb 2025 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050187;
	bh=qhyJ5nurd/KtDfxYFGukXboD8bJm+cxcpPMnMsiAeBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3L20lp/DyVHCn3x9pgSw1hKsQqgbruu1gxEhQAU0SOUEvqGxA7hE8UFRgjZgSUyG
	 td4V8ed9pn4UBpijGxO3aKNb5zpZxE5lqOVnTOJuBp73CtipZ7vVdM+SIbshhp+SZ6
	 qABzigljUvpjKt/MODuySnNdZWNym9ifNOWKheSbV42LfTLvI/bP65d0VMx9CgZkFl
	 5nZTkq/xO6TmwaQ6AtoVImlLY2Ees1vbMMVhpqipBcLsVY+b6A/oxCMEnmRG2q2WHc
	 SUNG+5vv+1XrE2/i3/jJdESsaav4dYjLLE18iLCcut2cf7bG6anh+5wC8PiiaDOy00
	 KPimNJ+chGzfg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/29] tty: n_tty: extract n_tty_continue_cookie() from n_tty_read()
Date: Thu, 20 Feb 2025 12:15:46 +0100
Message-ID: <20250220111606.138045-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

n_tty_read() is a very long function doing too much of different stuff.
Extract the "cookie" (continuation read) handling to a separate
function: n_tty_continue_cookie().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 43ba740792d9..88aa5f9cbe5e 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2111,6 +2111,39 @@ static int job_control(struct tty_struct *tty, struct file *file)
 	return __tty_check_change(tty, SIGTTIN);
 }
 
+/*
+ * We still hold the atomic_read_lock and the termios_rwsem, and can just
+ * continue to copy data.
+ */
+static ssize_t n_tty_continue_cookie(struct tty_struct *tty, u8 *kbuf,
+				   size_t nr, void **cookie)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	u8 *kb = kbuf;
+
+	if (ldata->icanon && !L_EXTPROC(tty)) {
+		/*
+		 * If we have filled the user buffer, see if we should skip an
+		 * EOF character before releasing the lock and returning done.
+		 */
+		if (!nr)
+			canon_skip_eof(ldata);
+		else if (canon_copy_from_read_buf(tty, &kb, &nr))
+			return kb - kbuf;
+	} else {
+		if (copy_from_read_buf(tty, &kb, &nr))
+			return kb - kbuf;
+	}
+
+	/* No more data - release locks and stop retries */
+	n_tty_kick_worker(tty);
+	n_tty_check_unthrottle(tty);
+	up_read(&tty->termios_rwsem);
+	mutex_unlock(&ldata->atomic_read_lock);
+	*cookie = NULL;
+
+	return kb - kbuf;
+}
 
 /**
  * n_tty_read		-	read function for tty
@@ -2144,36 +2177,9 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 	bool packet;
 	size_t old_tail;
 
-	/*
-	 * Is this a continuation of a read started earler?
-	 *
-	 * If so, we still hold the atomic_read_lock and the
-	 * termios_rwsem, and can just continue to copy data.
-	 */
-	if (*cookie) {
-		if (ldata->icanon && !L_EXTPROC(tty)) {
-			/*
-			 * If we have filled the user buffer, see
-			 * if we should skip an EOF character before
-			 * releasing the lock and returning done.
-			 */
-			if (!nr)
-				canon_skip_eof(ldata);
-			else if (canon_copy_from_read_buf(tty, &kb, &nr))
-				return kb - kbuf;
-		} else {
-			if (copy_from_read_buf(tty, &kb, &nr))
-				return kb - kbuf;
-		}
-
-		/* No more data - release locks and stop retries */
-		n_tty_kick_worker(tty);
-		n_tty_check_unthrottle(tty);
-		up_read(&tty->termios_rwsem);
-		mutex_unlock(&ldata->atomic_read_lock);
-		*cookie = NULL;
-		return kb - kbuf;
-	}
+	/* Is this a continuation of a read started earlier? */
+	if (*cookie)
+		return n_tty_continue_cookie(tty, kbuf, nr, cookie);
 
 	retval = job_control(tty, file);
 	if (retval < 0)
-- 
2.48.1

