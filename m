Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106351;
	b=wTvseWM6h8hdAObtKK1JklkGzTLq49nQk7nV+GIMLLuM7HvfYCBL/kSagUeQfiYUnYhz
	 kAnQph6bTI20G3+R6oXvve4J+PAaQQy2apDLQGc6f5/1PtzeWLhnJVOHS4dFKVEXSGOiJ
	 1VAR2HA7nSGuqLDGxTpiNUP4GYbTqgIyGxFMEMpGQXQlswZkkQXOFEn5D9wKEboZX9l2u
	 bjpdODdKB31glo2xUshJ1Bwc9z2u8e/e+00g7MFBOX/EmVyPiTcqM7ount3p9y59U5Vyj
	 IF7/Wv9FTZWeih9/oFPkZASP2mzjkWIye8xGK7ZIB3qZjDoYimHAlbJpRd4yr+nOyrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106351;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H39hwnwIg+LDXJYCtYYKzp7/dtZLMvDhXTVKfbzdbhw=;
	b=z8spICf1mOV5A8dnLbjU6HNGZSJ9FclIixBgSlrVPHjyId+9XJpwYMegGzdeY/eKj/2z
	 3WXcBuIZx7sq6roXNoGLtcO3PgFP+KEJ6ZXre7td68vpTOIe1VaTj3QG2D/vLbaq61Poj
	 9aq71qRCPAwBcIsbvWR4owgIU8DMRPgWXxxrtzt5Xa03r9iKtZTNkXNmfAI3x4PHPGe+s
	 NrygxPXur9NLaAgdaRPeHhpAOYgvE2Nm0ppGIhct+G5iBOK5rOLFYZApBbgNOzrlp8gdm
	 CMPNlkDJbALF/iMmaKH+7C5VWAzSaEMXThHMEE6OnL1zWpNjWPxOYlZnf6mnxWayKPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjZuIRDI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C70606A324;
	Thu, 19 Nov 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjZuIRDI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795106350;
	b=WcXBbiZhzDOANJHPdFNho2R7ozMFh2hDxMnxxl6ypi0C2pfzEF70c9G4V1ssyR5M5Igv
	 TWhUH+fQdliwEN9h/uSwLbFqQeGK2VShSaGCqXfZBsYr3XCduivyJTgUSxYCqXLbLm10U
	 /7kDKqiaFCcB3caJPPJDP58ov3tAPW1Nd81RQb2LzcEPv9jV47sjjx53E9PGgq/haz0a8
	 UwjkT/30HjESR8RRvfGCa/8uoFyOT5is+cWhSl8fEkmnntD/Cdn2dMSBwQbg0O4M9nMra
	 DK/O7SSAN/jOMnE/PX9grQX69UMwflV8VGBbkMJEP4+UXaCX4nVk7ktidiE88NovuwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795106350;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H39hwnwIg+LDXJYCtYYKzp7/dtZLMvDhXTVKfbzdbhw=;
	b=ZAizGSKsvr6r9fJiTDsaSs1yCoAMHtbVnSiQc5iaHzUmrTPMNJMQYimnFNVFgknCfST2
	 p3ySZwiVXIfT/0Ne0dBGtSnbjbsd+i6uHw+04RfNB2qbq6ZuBcJQ2CL3qQqyvp/rcqpzw
	 w+O1pR0fNYbuuoSe0zefe9//0EZBWRc4TwqSIxRllTKBpHI9uZWkCMZt5Hd5REcFKpcvD
	 U57fqXmTFzs2y+KncrfMXSczPFFqEyFmHjycnLYNXjMLb7P7XBBm9OIc/aXLusqugp68H
	 9N9V6OK7YHxLtGTxWmwCvKPfCsFi9l9QjqhaAR89yu+mPI28Ba+eP56R7duuRy1NI9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D97EF1F000C4;
	Thu, 19 Nov 2026 16:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106350;
	bh=H39hwnwIg+LDXJYCtYYKzp7/dtZLMvDhXTVKfbzdbhw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=WjZuIRDIXsFLcI5gz/taacrkZ67bc7nXOHxigxi8ZxBDtzUQIkbupieLov0hMq4St
	 8ZMj2g3XGFZTP4jCXlxXSXTTWBkWHRt/nfGh+2i1/mFVBOH8kMS9JMEzzsMJkOOxyn
	 zuSaQNU1BCXKzTSMQomQTSGKSr4E4VnCW7VmZmePmb2RuBSsEt6gPU3kh1Yiu4mbVD
	 njYlfUdQiVYybyT/LtZPHjJ9uHIOyncVb6yG58OAhK3k1iOJbDozQKbJK9JgcPisoY
	 U7q6Lzcwi1ooRx3+LRWq6sHfZIV8qUKQ8YJqA15msZ3n4sOqT3+G0Q0wqi6PhvZBzS
	 2RwiuzXX0vRrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3ACA84B33A;
	Thu, 19 Nov 2026 16:39:09 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 16:39:09 +0000
Subject: [PATCH] vt: allocate the screen buffers with kvzalloc()
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-vt-kvzalloc-v1-1-5e5f59b37f61@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDXREspVxKJqMAjS0ghxd8XyL
 f6/wKIhtFAEFxh0ZGmZPXgYgO7V3CGjxhtEJFLOec7cxkZ3qmlaNMNURLKRmUpkDL5YDbZ0fLe
 y+m33ekC9vQu47wcFkD5UbwAAAA==
X-Change-ID: 20261119-vt-kvzalloc-e6208d87a483
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Nicolas Pitre <nico@fluxnic.net>, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795106349; l=4415;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=83ftxt1Y3R8cULoF8CrapPrLjB8/VCL6Q7syy8fYTqQ=;
 b=cb/1C90W46uJY1W+sHyRgr96rWWZcFm89KMxF4+WT3nuPzc3Bn/lRrxjcGeme3U9TjrPR2mcf
 so5JjuVRguhCihuRTgAKezivDTuv0ms44KLgo3WYGGskr49hILlsjeI
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

A console's screen buffer grows with the display: 480x135 (3840x2160
with the 8x16 font) needs 129600 bytes, an order-5 kzalloc() that can
fail when memory is fragmented. On an Orange Pi Zero2 (1 GiB) under
memory load, plugging in an HDMI monitor gave an order:5 page
allocation failure in vc_do_resize() from fbcon_startup().

Commit 9a98e7a80f95 ("vt: don't use kmalloc() for the unicode screen
buffer") moved the unicode buffer to vmalloc for this reason; let the
screen buffer and its alternate screen copy fall back to vmalloc too.
Nothing needs them physically contiguous. con_init() keeps its
GFP_NOWAIT kzalloc(), which kvfree() also handles.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Tested on an Orange Pi Zero2 (H616) on 7.3.4 with KASAN and the order-5
kmalloc failed by fault injection: 20 of 20 fbcon rebinds fell back to
vmalloc and kept the screen contents (all 20 fail without the patch).

Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed it.
---
 drivers/tty/vt/vt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7dbc0072a40a..cdc862be4d6f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1232,7 +1232,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	    vc->vc_screenbuf_size > KMALLOC_MAX_SIZE || !vc->vc_screenbuf_size)
 		goto err_free;
 	err = -ENOMEM;
-	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
+	vc->vc_screenbuf = kvzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
 	if (!vc->vc_screenbuf)
 		goto err_free;
 
@@ -1324,14 +1324,14 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 
 	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
 		return -EINVAL;
-	newscreen = kzalloc(new_screen_size, GFP_USER);
+	newscreen = kvzalloc(new_screen_size, GFP_USER);
 	if (!newscreen)
 		return -ENOMEM;
 
 	if (vc->vc_uni_lines) {
 		new_uniscr = vc_uniscr_alloc(new_cols, new_rows);
 		if (!new_uniscr) {
-			kfree(newscreen);
+			kvfree(newscreen);
 			return -ENOMEM;
 		}
 	}
@@ -1344,7 +1344,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 
 	err = resize_screen(vc, new_cols, new_rows, from_user);
 	if (err) {
-		kfree(newscreen);
+		kvfree(newscreen);
 		vc_uniscr_free(new_uniscr);
 		return err;
 	}
@@ -1402,7 +1402,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	vc->vc_screenbuf = newscreen;
 	vc->vc_screenbuf_size = new_screen_size;
 	set_origin(vc);
-	kfree(oldscreen);
+	kvfree(oldscreen);
 
 	/* do part of a reset_terminal() */
 	vc->vc_top = 0;
@@ -1483,10 +1483,10 @@ struct vc_data *vc_deallocate(unsigned int currcons)
 		con_free_unimap(vc);
 		put_pid(vc->vt_pid);
 		vc_uniscr_set(vc, NULL);
-		kfree(vc->vc_screenbuf);
+		kvfree(vc->vc_screenbuf);
 		vc_cons[currcons].d = NULL;
 		if (vc->vc_saved_screen != NULL) {
-			kfree(vc->vc_saved_screen);
+			kvfree(vc->vc_saved_screen);
 			vc->vc_saved_screen = NULL;
 		}
 		vc_uniscr_free(vc->vc_saved_uni_lines);
@@ -2032,7 +2032,7 @@ static void enter_alt_screen(struct vc_data *vc)
 
 	if (vc->vc_saved_screen != NULL)
 		return; /* Already inside an alt-screen */
-	vc->vc_saved_screen = kmemdup((u16 *)vc->vc_origin, size, GFP_KERNEL);
+	vc->vc_saved_screen = kvmemdup((u16 *)vc->vc_origin, size, GFP_KERNEL);
 	if (vc->vc_saved_screen == NULL)
 		return;
 	vc->vc_saved_uni_lines = vc->vc_uni_lines;
@@ -2082,7 +2082,7 @@ static void leave_alt_screen(struct vc_data *vc)
 	/* Update the entire screen */
 	if (con_should_update(vc))
 		do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
-	kfree(vc->vc_saved_screen);
+	kvfree(vc->vc_saved_screen);
 	vc->vc_saved_screen = NULL;
 }
 
@@ -2400,7 +2400,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	vc->vc_decim		= 0;
 
 	if (vc->vc_saved_screen != NULL) {
-		kfree(vc->vc_saved_screen);
+		kvfree(vc->vc_saved_screen);
 		vc->vc_saved_screen = NULL;
 		vc_uniscr_free(vc->vc_saved_uni_lines);
 		vc->vc_saved_uni_lines = NULL;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261119-vt-kvzalloc-e6208d87a483

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


