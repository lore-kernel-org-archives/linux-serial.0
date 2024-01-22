Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B63CF73;
	Mon, 22 Jan 2024 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921462; cv=none; b=Fc47JQgJADBe0tIur5ZAYlz8Edh00beYHpYnrqIWYUp2ojtydcopKjyTo0BzZhLLoQ+HFQAI+tTMMaEAqMMZs3Xuec3WCTwAYkYkvhdwjnEOc9nZ3cVGD34MeH+sQMOiweF0942Fi0NI8mQB+fLen3U45iUJhIovJABo8jleksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921462; c=relaxed/simple;
	bh=NurnY/n3MIEH+3Fog1rQ9f+5l/LwSVWrvTynpHmGqrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVRFse6cRd9DGU05eP9udCBt9vg1ly9kMQCoQ2L15HaRNdRxIeJd/862xzYOsUiluMvAtE+sC23CCCIo2GI8Yz5ZsO8rUAX7sgKGmwE/G72oZ68V8Xi6OmLPhF2cgAAy/zBMdYGzZrWOFSkNs9ofRRqbAxKcfy51qSPrJwnVkxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLHKdzlg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLHKdzlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DC9C433F1;
	Mon, 22 Jan 2024 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921462;
	bh=NurnY/n3MIEH+3Fog1rQ9f+5l/LwSVWrvTynpHmGqrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLHKdzlgi3bIIPOrhUEIdhNiFg1e1i1Vy9Yg8/vurDD0dHpXXM/uqoBP8julk36vp
	 5IaFXk9eVPDVfIJT/V+CDIy605B5q/vvxZVmr6dmMifxvcoZeDzwQ/d6oC7iJrIwCA
	 PQ4+N82R+/A3JpJ6a6ZNMttSfnmZ+IyXPaEQ1ULEPa+ToF0DaarDwwfprr4MYbsVO+
	 Yd1ucZxw2QIqK+5lwuLXgizp2VrzlIDEosOr8lqV2fvdPKGQdKE+T5nlJ9QF6anRcI
	 Dny2RJyVRBbcSLQI0cCJgYcSi8kktVsx+S9IQ1AE9TvQorYzYFfBRgkUi+uo6hZEit
	 eksVmkSIhsWzg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 08/47] tty: vt: make vc_is_sel()'s vc const
Date: Mon, 22 Jan 2024 12:03:22 +0100
Message-ID: <20240122110401.7289-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's only an aid to people reading the header and/or calling
vc_is_sel(). vc is only tested there, so having it const makes sense.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/selection.c | 2 +-
 include/linux/selection.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 91d789c025c6..34ee09f5a8f4 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -88,7 +88,7 @@ void clear_selection(void)
 }
 EXPORT_SYMBOL_GPL(clear_selection);
 
-bool vc_is_sel(struct vc_data *vc)
+bool vc_is_sel(const struct vc_data *vc)
 {
 	return vc == vc_sel.cons;
 }
diff --git a/include/linux/selection.h b/include/linux/selection.h
index b7cd23e56a2b..533509f6ba4f 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -24,7 +24,7 @@ extern int sel_loadlut(u32 __user *lut);
 extern int mouse_reporting(void);
 extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
 
-bool vc_is_sel(struct vc_data *vc);
+bool vc_is_sel(const struct vc_data *vc);
 
 extern int console_blanked;
 
-- 
2.43.0

