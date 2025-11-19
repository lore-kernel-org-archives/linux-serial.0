Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299433C523;
	Wed, 19 Nov 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544303; cv=none; b=T/7wARhmzYvwfrCi1CneQgVk8fwzkkMKlQB/9Y7jtExv2TgoMudZAY3TWl/x9DupfNziFEbLrdZiSCYj3/pgz1AWQuN25sDvvT9WR/hyo/MAxBNJGMCBsuA4e7fI7nQ12T+qRKCzjFbUnNBAXgsdVSh8m0n1dwwUCLqXtQVNvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544303; c=relaxed/simple;
	bh=Wf88PMb/UGXyIpHUPPH2JLfgFSr11ineysPvYpjmVDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVO4TkMhittjtIa0tTE7PohwyyqgiLaXo0pHApc53tRCO0ttqhDjFPQWCNIP96aNQKZAdHPnb5fukSai9yF1OxxQtx3tAmng29e6r+5lQbzmvRcUX4rFcC4D/yIn8ybiz79Hd7mA8XtgHVhPCKse+t2f05pIkLEgPQwg3IFJBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeEyKc34; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeEyKc34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C8BC19425;
	Wed, 19 Nov 2025 09:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763544303;
	bh=Wf88PMb/UGXyIpHUPPH2JLfgFSr11ineysPvYpjmVDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AeEyKc34mEhVwmF5j/hTy5r2RqT5Zx4PpKWJ1X07xf0JNNuTRac3AfiL5amSXuTmf
	 CKAeNfsdKKHBqiiWeT73h/yGn1rqDBTt8v7yItrXO7knKLunl6RCWHm0VF0A2tvCoW
	 G47tcIfiIPSkQGG1hmzTAYgT5rGzudXW3VtYqcAd7Q5w+oPp9m3ozGadnMg5+EL4kR
	 VtjQE4O3pyX/TCUoTSE+3eM0eaaJOoit0dugls/Sv/rl0TByofbDfDhXSHCCuWvwP/
	 K0ydHX27O8ftcEMOQIQJyJVl8xrUsczmk9bHf+ouML3p6b/qNKrr26tWBAVCxHrZWj
	 skhb9+5FqkqIQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 1/6] tty: vt: do not open code DIV_ROUND_UP()
Date: Wed, 19 Nov 2025 10:24:52 +0100
Message-ID: <20251119092457.826789-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119092457.826789-1-jirislaby@kernel.org>
References: <20251119092457.826789-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the designated DIV_ROUND_UP() macro instead of explicit addition
with division.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 6e0089b85c27..59b4b5e126ba 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4862,7 +4862,7 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 			return ret;
 	}
 
-	c = (font.width+7)/8 * vpitch * font.charcount;
+	c = DIV_ROUND_UP(font.width, 8) * vpitch * font.charcount;
 
 	if (op->data && font.charcount > op->charcount)
 		return -ENOSPC;
@@ -4894,7 +4894,7 @@ static int con_font_set(struct vc_data *vc, const struct console_font_op *op)
 		return -EINVAL;
 	if (vpitch < op->height)
 		return -EINVAL;
-	size = (op->width+7)/8 * vpitch * op->charcount;
+	size = DIV_ROUND_UP(op->width, 8) * vpitch * op->charcount;
 	if (size > max_font_size)
 		return -ENOSPC;
 
-- 
2.51.1

