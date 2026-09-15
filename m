Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6C4A2078;
	Tue, 15 Sep 2026 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475613; cv=none; b=nFz5tpVtTuc0zyy6PQoyBFbcJdqIiwcMikgPho0LKhfCS7zKd4emIfMO78IRzHQr5HNLByJY/Qt8oKjmfQo1xmbu5LBh/gbz7lV0ym4Swi8YG1WE6JEeHo4AMOsBP6V4phVApVEnuxqms0aelg88fsLQyHJabgh+o0hudZR45qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475613; c=relaxed/simple;
	bh=JsKAJx8BMfZHoE7fTfSMmLBTHvQ4HXUbc3J/MfRdqnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpNjQ672AbmIkTfnalq9Evl/d8eJU3j5G0tI3QgAwiZarT3JUbGLD2D5UVGd+q7XVTNBhpaCqref6TSpSzZ7HBhbdGROXYjuHeor88KbnYThfMXI2BHJGCd+FKWV5afZqW8wa0gFyE2fGFOYtzINtWPqeRzoHUKSdf8VEpwWw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yv7m8Q9b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IaA3xu58; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o0nc7zne; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7++Z3ipM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yv7m8Q9b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IaA3xu58";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o0nc7zne";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7++Z3ipM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E4E01FD8D;
	Tue, 15 Sep 2026 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQInQiSoFgN20FwPZAQkSimSNxx0P+gPkILtWae2sXM=;
	b=Yv7m8Q9btdhRjYaQJx8JUkDBPlIqE17zSROy1zXVnVb7LkJ9xtzpmIxVJhRj9razsJGlej
	G10hhlI2gYPQcDK7v11x59+EUliHrp2gRkMJaL33eAoRLUxdQa31cop3WVe6LqkTBn36G5
	8goE0OCCleBM/8+vNRBeIpczeJ/vI+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQInQiSoFgN20FwPZAQkSimSNxx0P+gPkILtWae2sXM=;
	b=IaA3xu585043qmgM5HELOzRWlTgA6kPfkE1UFiT6J/PaFsO0e2LCX9DFPA3JeGsg5Tqjoh
	nVpEHDzBg5oMWTDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQInQiSoFgN20FwPZAQkSimSNxx0P+gPkILtWae2sXM=;
	b=o0nc7zne/xS0WSUBj74F2SlIuS2UkZBrJuyZP7Pv06B5qW2nZkSp9nu8fPKOKJ3ht5G+o7
	GPsm41oHtNzT24tg89kxzfFHBwMp4yd8Dn8qTMHw8zQU7DdJn+lglOYpxklFxg25e6W1Jn
	muSFLIU33IJL6dlSS2Xl7aKGeRjdJHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQInQiSoFgN20FwPZAQkSimSNxx0P+gPkILtWae2sXM=;
	b=7++Z3ipMK8zi+b6/ntUpxeNwWNWMtbDcOHpIbQPTHH7A9pw30R5i0gh32Rvctb4qKpJIUw
	irwTRLJerPrw6yBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADF0613890;
	Tue, 15 Sep 2026 12:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id COmnAwk7qWpGNQAAD6G6ig:T6
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Sep 2026 12:33:14 +0000
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
Subject: [PATCH v2 5/5] fbcon: Replace fbcon_fill_cursor_mask() with fbcon_cursor_glyph()
Date: Tue, 15 Sep 2026 14:29:16 +0200
Message-ID: <20260915123304.1027277-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915123304.1027277-1-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,gmx.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

The kernel's font library provides font_glyph_cursor() to create cursor
glyphs. Replace fbcon's fbcon_fill_cursor_mask() with a new helper that
uses font_glyph_cursor().

The cursor shapes remain mostly unchanged. The only exception is in
underline cursors for fonts with a size larger than 10. The underlining
dash is now one pixel closer to the font-glyph data, so that the cursor
looks less detached. This follows the style used by vgacon.

v2:
- adapt to new VT interface

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/bitblit.c   |  3 +-
 drivers/video/fbdev/core/fbcon.c     | 45 +++++++---------------------
 drivers/video/fbdev/core/fbcon.h     |  2 +-
 drivers/video/fbdev/core/fbcon_ccw.c |  3 +-
 drivers/video/fbdev/core/fbcon_cw.c  |  3 +-
 drivers/video/fbdev/core/fbcon_ud.c  |  3 +-
 6 files changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 39f44258d793..03b3b18e1fe9 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -334,11 +334,10 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	    vc->vc_cursor_type != par->p->cursor_shape ||
 	    par->cursor_state.mask == NULL ||
 	    par->cursor_reset) {
-		unsigned char *mask = kmalloc_array(vc->vc_font.height, w, GFP_ATOMIC);
+		unsigned char *mask = fbcon_cursor_glyph(&vc->vc_font, vc->vc_cursor_type);
 
 		if (!mask)
 			return;
-		fbcon_fill_cursor_mask(par, vc, mask);
 
 		kfree(par->cursor_state.mask);
 		par->cursor_state.mask = (const char *)mask;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 615fa596b7cc..8581b7a9b3b7 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -444,44 +444,21 @@ static void fbcon_del_cursor_work(struct fb_info *info)
 	cancel_delayed_work_sync(&par->cursor_work);
 }
 
-void fbcon_fill_cursor_mask(struct fbcon_par *par, struct vc_data *vc, unsigned char *mask)
+unsigned char *fbcon_cursor_glyph(const struct vc_font *font, unsigned int cursor_type)
 {
-	static const unsigned int pattern = 0xffffffff;
-	unsigned int pitch = vc_font_pitch(&vc->vc_font);
-	unsigned int cur_height, size;
+	unsigned int height = font->height;
+	unsigned int cursor_size = CUR_SIZE(cursor_type);
+	unsigned char *glyph;
 
-	switch (CUR_SIZE(vc->vc_cursor_type)) {
-	case CUR_NONE:
-		cur_height = 0;
-		break;
-	case CUR_UNDERLINE:
-		if (vc->vc_font.height < 10)
-			cur_height = 1;
-		else
-			cur_height = 2;
-		break;
-	case CUR_LOWER_THIRD:
-		cur_height = vc->vc_font.height / 3;
-		break;
-	case CUR_LOWER_HALF:
-		cur_height = vc->vc_font.height / 2;
-		break;
-	case CUR_TWO_THIRDS:
-		cur_height = (vc->vc_font.height * 2) / 3;
-		break;
-	case CUR_BLOCK:
-	default:
-		cur_height = vc->vc_font.height;
-		break;
-	}
+	glyph = kmalloc_array(height, vc_font_pitch(font), GFP_ATOMIC);
+	if (!glyph)
+		return NULL;
 
-	size = (vc->vc_font.height - cur_height) * pitch;
-	while (size--)
-		*mask++ = (unsigned char)~pattern;
+	font_glyph_cursor(font->width, height,
+			  vc_cursor_start(height, cursor_size),
+			  vc_cursor_end(height, cursor_size), glyph);
 
-	size = cur_height * pitch;
-	while (size--)
-		*mask++ = (unsigned char)pattern;
+	return glyph;
 }
 
 #ifndef MODULE
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 407d207b14f1..054cf66b15fa 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -202,7 +202,7 @@ extern void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info);
 extern void fbcon_set_bitops_ur(struct fbcon_par *par);
 extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
 
-void fbcon_fill_cursor_mask(struct fbcon_par *par, struct vc_data *vc, unsigned char *mask);
+unsigned char *fbcon_cursor_glyph(const struct vc_font *font, unsigned int cursor_type);
 
 #define FBCON_ATTRIBUTE_UNDERLINE 1
 #define FBCON_ATTRIBUTE_REVERSE   2
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 33f02d579e02..9a9839631cc5 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -298,10 +298,9 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	    par->cursor_reset) {
 		unsigned char *tmp, *mask;
 
-		tmp = kmalloc_array(vc->vc_font.height, vc_font_pitch(&vc->vc_font), GFP_ATOMIC);
+		tmp = fbcon_cursor_glyph(&vc->vc_font, vc->vc_cursor_type);
 		if (!tmp)
 			return;
-		fbcon_fill_cursor_mask(par, vc, tmp);
 
 		mask = kmalloc_array(vc->vc_font.width, w, GFP_ATOMIC);
 		if (!mask) {
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index bde820967eb9..4cb20337cf79 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -281,10 +281,9 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	    par->cursor_reset) {
 		unsigned char *tmp, *mask;
 
-		tmp = kmalloc_array(vc->vc_font.height, vc_font_pitch(&vc->vc_font), GFP_ATOMIC);
+		tmp = fbcon_cursor_glyph(&vc->vc_font, vc->vc_cursor_type);
 		if (!tmp)
 			return;
-		fbcon_fill_cursor_mask(par, vc, tmp);
 
 		mask = kmalloc_array(vc->vc_font.width, w, GFP_ATOMIC);
 		if (!mask) {
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index eaf08999e249..ac22b9846b79 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -328,10 +328,9 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	    par->cursor_reset) {
 		unsigned char *tmp, *mask;
 
-		tmp = kmalloc_array(vc->vc_font.height, w, GFP_ATOMIC);
+		tmp = fbcon_cursor_glyph(&vc->vc_font, vc->vc_cursor_type);
 		if (!tmp)
 			return;
-		fbcon_fill_cursor_mask(par, vc, tmp);
 
 		mask = kmalloc_array(vc->vc_font.height, w, GFP_ATOMIC);
 		if (!mask) {
-- 
2.55.0

