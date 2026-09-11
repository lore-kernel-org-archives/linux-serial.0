Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C173B19D9;
	Fri, 11 Sep 2026 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119936; cv=none; b=WT2yO4Jo0Y+yupYOMmc+KVNRUrDt0nbwzzXNtB6x/f/7M/6qI/nF0sLFdDlBBmUygghqlScZqdlVAM7vBEijBg3EQlkAymudpIeV5bmXBSX3BN0ra5NFPXymVl0w136RqSHqd47I5Wca5/uhtzVXESa2ViTq4cBR/Z9xfSiWFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119936; c=relaxed/simple;
	bh=k2Dm94Y3d4p7SGRWBnWhAxOu4DsQsquBBeBfyQNpNFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZThCRKRlvN0J2n5/drinfPVrKuvRV6HSZ9tGknev1OPxUtAqF6hTRBhi8kEmPrscP9uoXLufyiAJceZop4CEhF46MctyAqMlEjtFBZF3WAekU08l9I9l+P0cjeUE4U9EkLMn9c1ef6DKhvlJ+ov762w3acI2zh7mMsdyBhXGZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xxV2zY8Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rJsj6nMz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=APieSNrS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U8trrY++; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xxV2zY8Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rJsj6nMz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="APieSNrS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U8trrY++"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D89A1FF19;
	Fri, 11 Sep 2026 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789119928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWeikUh1PlMPfJvdPvsGSFVGxTlTdB+riXuPS8fsbew=;
	b=xxV2zY8ZiA9UY50UAV+uSKwFkPWq6a/yxqaPNUF/4AYOGI+cLcE+4wE3xxxaWzqCbZnNER
	aElBECAgpjFKyAPDfa5cYHa340LHPNBjQcbyJ/Qb0UMo4yK4riC1Hvmy5bY+wjQ67eKl7p
	WW8PG4b3/7PewI8xPv5liAEid6+JTTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789119928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWeikUh1PlMPfJvdPvsGSFVGxTlTdB+riXuPS8fsbew=;
	b=rJsj6nMzfAeMaR8dYK5MfKIlKyCy2z9s4JeoA3F4K1xsILX1p1lgYdK5T0vnGxTDXYfJzi
	0dd2oovsSyG5rGBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789119924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWeikUh1PlMPfJvdPvsGSFVGxTlTdB+riXuPS8fsbew=;
	b=APieSNrS23N+wVZq5DrqkLS0VR/e2OhucVGsfklZAY0KRYiUChU8Nob5Zp/tLhnzzoo9t7
	RyGI+ZBGAW6FB/7VaE0fs+fN0bcb9cQ/MdY1o//a3Kx9w8VKBdmAsjln/6aQL/cveR5yyq
	iKwp/jbdIY9LV3xZBWuVchzu+rA+m/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789119924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWeikUh1PlMPfJvdPvsGSFVGxTlTdB+riXuPS8fsbew=;
	b=U8trrY++BcCyBXbKBLSl/jNW4TNkXaBTf77CCCQIh+lZCCv/W5elFy4nz8wyAtyYUmbr6m
	C7I29x976LNc4uDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F326413794;
	Fri, 11 Sep 2026 09:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ODkJOrPNo2oFVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 09:45:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-serial@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/5] vgacon: Use vt_font_cursor_{start,end}()
Date: Fri, 11 Sep 2026 11:25:21 +0200
Message-ID: <20260911094518.78093-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911094518.78093-1-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

Replace vgacon's custom cursor metrics with the shared helpers
vc_font_cursor_start() and vc_font_cursor_end(). Note that the
_end() function returns the index of the scanline below the cursor,
while VGA hardware expects the cursor's final scanline. Hence vgacon
subtracts 1 from the end value.

The cursor shapes remain mostly unchanged, except that non-underline
cursors now also use the glyph's top-most and bottom-most scanline.
This follows the style used by fbcon.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/vgacon.c | 36 ++++++----------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 536e7fe4d142..b16ddb1b09a7 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -36,6 +36,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/font.h>
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/string.h>
@@ -505,18 +506,18 @@ static void vgacon_set_cursor_size(int from, int to)
 
 static void vgacon_cursor(struct vc_data *c, bool enable)
 {
-	unsigned int c_height;
+	unsigned int c_type;
 
 	if (c->vc_mode != KD_TEXT)
 		return;
 
 	vgacon_restore_screen(c);
 
-	c_height = c->vc_cell_height;
+	c_type = c->vc_cursor_type;
 
 	write_vga(14, (c->vc_pos - vga_vram_base) / 2);
 
-	if (!enable) {
+	if (!enable || CUR_SIZE(c_type) == CUR_NONE) {
 	        if (vga_video_type >= VIDEO_TYPE_VGAC)
 			vgacon_set_cursor_size(31, 30);
 		else
@@ -524,33 +525,8 @@ static void vgacon_cursor(struct vc_data *c, bool enable)
 		return;
 	}
 
-	switch (CUR_SIZE(c->vc_cursor_type)) {
-	case CUR_UNDERLINE:
-		vgacon_set_cursor_size(c_height - (c_height < 10 ? 2 : 3),
-				       c_height - (c_height < 10 ? 1 : 2));
-		break;
-	case CUR_TWO_THIRDS:
-		vgacon_set_cursor_size(c_height / 3,
-				       c_height - (c_height < 10 ? 1 : 2));
-		break;
-	case CUR_LOWER_THIRD:
-		vgacon_set_cursor_size(c_height * 2 / 3,
-				       c_height - (c_height < 10 ? 1 : 2));
-		break;
-	case CUR_LOWER_HALF:
-		vgacon_set_cursor_size(c_height / 2,
-				       c_height - (c_height < 10 ? 1 : 2));
-		break;
-	case CUR_NONE:
-		if (vga_video_type >= VIDEO_TYPE_VGAC)
-			vgacon_set_cursor_size(31, 30);
-		else
-			vgacon_set_cursor_size(31, 31);
-		break;
-	default:
-		vgacon_set_cursor_size(1, c_height);
-		break;
-	}
+	vgacon_set_cursor_size(vc_font_cursor_start(&c->vc_font, c_type),
+			       vc_font_cursor_end(&c->vc_font, c_type) - 1);
 }
 
 static void vgacon_doresize(struct vc_data *c,
-- 
2.55.0

