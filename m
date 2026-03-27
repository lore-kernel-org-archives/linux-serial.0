Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050003E6393
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616705; cv=none; b=ko96B4EL2uujKwSFkdOwh7U7tkfgaV3iPd8VixWq25KWrPUarRKQozuD9ocUxq5HmrlEmcUK1+OyejfAjtiRUd3Dc7EzqsbcBraRP5bGtHWWvSdSFb3YHVIuj2ehsnSz3lpbBrG74UfNHIYoup+RcylOaUk46ZKD+WC/M1/50To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616705; c=relaxed/simple;
	bh=DS/q87OVT+9erS5Tcvn8vIFJCscEEij4sUfH+johEzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huurZ4py2JNjZzIV9b8R4+JOHMX1d3b83waaH5NYjDX9Zry72KZeUhbesf/29lDuP2D8MlJ7HGheou92lpoZp0DPArILSoXMfMmwhaBJzZgTEfBe/ETckaNQVSyy//sqBr6J3inJFWbPtcwaORqMbN5JhmJN+HBA7XtkhdhjkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TKikD3n6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=42V2IK1l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TKikD3n6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=42V2IK1l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TKikD3n6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="42V2IK1l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TKikD3n6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="42V2IK1l"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEA375BE69;
	Fri, 27 Mar 2026 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8N0WqiipsboIKRPSmJKTFrwk5c0sveM2dZgxXJLu0I=;
	b=TKikD3n684ivSUGP+4hweAApPk+H2bl6CqhLJJnI1hQMLDBptxssFRZ30u+jDKcta1TmqV
	CWx75yeN54TXv85PkpQ2/jZRsPBAjZGamoRjhmLmqxfvQfrKCjDgKV4897FvBok1ILjj+/
	j/t3V24MaXDBKvICax5bexqeIHr/yrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8N0WqiipsboIKRPSmJKTFrwk5c0sveM2dZgxXJLu0I=;
	b=42V2IK1lQcc4vOhUI+yq6wYgcC73IlsJytUA3+AEx0WSuADtY3ue0uczefmFU/K6uMvm9X
	eM/AHdkNUV1O0aBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8N0WqiipsboIKRPSmJKTFrwk5c0sveM2dZgxXJLu0I=;
	b=TKikD3n684ivSUGP+4hweAApPk+H2bl6CqhLJJnI1hQMLDBptxssFRZ30u+jDKcta1TmqV
	CWx75yeN54TXv85PkpQ2/jZRsPBAjZGamoRjhmLmqxfvQfrKCjDgKV4897FvBok1ILjj+/
	j/t3V24MaXDBKvICax5bexqeIHr/yrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8N0WqiipsboIKRPSmJKTFrwk5c0sveM2dZgxXJLu0I=;
	b=42V2IK1lQcc4vOhUI+yq6wYgcC73IlsJytUA3+AEx0WSuADtY3ue0uczefmFU/K6uMvm9X
	eM/AHdkNUV1O0aBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CD2B4A0A2;
	Fri, 27 Mar 2026 13:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gFAZJWaAxmmweQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:04:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 10/10] fbcon: Put font-rotation state into separate struct
Date: Fri, 27 Mar 2026 13:49:43 +0100
Message-ID: <20260327130431.59481-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327130431.59481-1-tzimmermann@suse.de>
References: <20260327130431.59481-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,ravnborg.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Move all temporary state of the font-rotation code into the struct
rotated in struct fbcon_par. Protect it with the Kconfig symbol
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION. Avoids mixing it up with fbcon's
regular state.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c        |  8 ++++++--
 drivers/video/fbdev/core/fbcon.h        | 12 +++++++----
 drivers/video/fbdev/core/fbcon_ccw.c    |  8 ++++----
 drivers/video/fbdev/core/fbcon_cw.c     |  8 ++++----
 drivers/video/fbdev/core/fbcon_rotate.c | 27 +++++++++++++------------
 drivers/video/fbdev/core/fbcon_ud.c     | 10 ++++-----
 6 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 345d9aa193f0..00fa5990dfc5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -787,7 +787,9 @@ static void fbcon_release(struct fb_info *info)
 		kfree(par->cursor_state.mask);
 		kfree(par->cursor_data);
 		kfree(par->cursor_src);
-		kfree(par->fontbuffer);
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+		kfree(par->rotated.buf);
+#endif
 		kfree(info->fbcon_par);
 		info->fbcon_par = NULL;
 	}
@@ -1040,7 +1042,9 @@ static const char *fbcon_startup(void)
 	par = info->fbcon_par;
 	par->currcon = -1;
 	par->graphics = 1;
-	par->cur_rotate = -1;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	par->rotated.buf_rotate = -1;
+#endif
 
 	p->con_rotate = initial_rotation;
 	if (p->con_rotate == -1)
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index bb0727b70631..5a3866b7ee33 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -80,13 +80,17 @@ struct fbcon_par {
 	int    graphics;
 	bool   initialized;
 	int    rotate;
-	int    cur_rotate;
 	char  *cursor_data;
-	u8          *fontbuffer;
-	const u8    *fontdata;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	struct {
+		font_data_t *fontdata;  /* source font */
+		u8 *buf;                /* rotated glphys */
+		size_t bufsize;
+		int buf_rotate;         /* rotation of buf */
+	} rotated;
+#endif
 	u8    *cursor_src;
 	u32    cursor_size;
-	size_t fd_size;
 
 	const struct fbcon_bitops *bitops;
 };
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 723d9a33067f..33f02d579e02 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -106,7 +106,7 @@ static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	u8 *src;
 
 	while (cnt--) {
-		src = par->fontbuffer + (scr_readw(s--) & charmask) * cellsize;
+		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
 
 		if (attr) {
 			ccw_update_attr(buf, src, attr, vc);
@@ -142,7 +142,7 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 	u8 *dst, *buf = NULL;
 	u32 vyres = GETVYRES(par->p, info);
 
-	if (!par->fontbuffer)
+	if (!par->rotated.buf)
 		return;
 
 	image.fg_color = fg;
@@ -232,14 +232,14 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	char *src;
 	u32 vyres = GETVYRES(par->p, info);
 
-	if (!par->fontbuffer)
+	if (!par->rotated.buf)
 		return;
 
 	cursor.set = 0;
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->fontbuffer + ((c & charmask) * (w * vc->vc_font.width));
+	src = par->rotated.buf + ((c & charmask) * (w * vc->vc_font.width));
 
 	if (par->cursor_state.image.data != src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 732d093d462f..bde820967eb9 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -91,7 +91,7 @@ static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	u8 *src;
 
 	while (cnt--) {
-		src = par->fontbuffer + (scr_readw(s++) & charmask) * cellsize;
+		src = par->rotated.buf + (scr_readw(s++) & charmask) * cellsize;
 
 		if (attr) {
 			cw_update_attr(buf, src, attr, vc);
@@ -127,7 +127,7 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 	u8 *dst, *buf = NULL;
 	u32 vxres = GETVXRES(par->p, info);
 
-	if (!par->fontbuffer)
+	if (!par->rotated.buf)
 		return;
 
 	image.fg_color = fg;
@@ -215,14 +215,14 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	char *src;
 	u32 vxres = GETVXRES(par->p, info);
 
-	if (!par->fontbuffer)
+	if (!par->rotated.buf)
 		return;
 
 	cursor.set = 0;
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->fontbuffer + ((c & charmask) * (w * vc->vc_font.width));
+	src = par->rotated.buf + ((c & charmask) * (w * vc->vc_font.width));
 
 	if (par->cursor_state.image.data != src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 74206f5a6e98..6cdbc96eeca6 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -18,34 +18,35 @@
 int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 {
 	struct fbcon_par *par = info->fbcon_par;
-	unsigned char *fontbuffer;
+	unsigned char *buf;
 	int ret;
 
-	if (vc->vc_font.data == par->fontdata &&
-	    par->p->con_rotate == par->cur_rotate)
+	if (par->p->fontdata == par->rotated.fontdata && par->rotate == par->rotated.buf_rotate)
 		return 0;
 
-	par->fontdata = vc->vc_font.data;
-	par->cur_rotate = par->p->con_rotate;
+	par->rotated.fontdata = par->p->fontdata;
+	par->rotated.buf_rotate = par->rotate;
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
 
-	fontbuffer = font_data_rotate(par->p->fontdata, vc->vc_font.width,
-				      vc->vc_font.height, vc->vc_font.charcount,
-				      par->rotate, par->fontbuffer, &par->fd_size);
-	if (IS_ERR(fontbuffer)) {
-		ret = PTR_ERR(fontbuffer);
+	buf = font_data_rotate(par->rotated.fontdata, vc->vc_font.width,
+			       vc->vc_font.height, vc->vc_font.charcount,
+			       par->rotated.buf_rotate, par->rotated.buf,
+			       &par->rotated.bufsize);
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
 		goto err_kfree;
 	}
 
-	par->fontbuffer = fontbuffer;
+	par->rotated.buf = buf;
 
 	return 0;
 
 err_kfree:
-	kfree(par->fontbuffer);
-	par->fontbuffer = NULL; /* clear here to avoid output */
+	kfree(par->rotated.buf);
+	par->rotated.buf = NULL; /* clear here to avoid output */
+	par->rotated.bufsize = 0;
 
 	return ret;
 }
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index a1981fa4701a..eaf08999e249 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -92,7 +92,7 @@ static inline void ud_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	u8 *src;
 
 	while (cnt--) {
-		src = par->fontbuffer + (scr_readw(s--) & charmask) * cellsize;
+		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -127,7 +127,7 @@ static inline void ud_putcs_unaligned(struct vc_data *vc,
 	u8 *src;
 
 	while (cnt--) {
-		src = par->fontbuffer + (scr_readw(s--) & charmask) * cellsize;
+		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -164,7 +164,7 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 vyres = GETVYRES(par->p, info);
 	u32 vxres = GETVXRES(par->p, info);
 
-	if (!par->fontbuffer)
+	if (!par->rotated.buf)
 		return;
 
 	image.fg_color = fg;
@@ -262,14 +262,14 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	u32 vyres = GETVYRES(par->p, info);
 	u32 vxres = GETVXRES(par->p, info);
 
-	if (!par->fontbuffer)
+	if (!par->rotated.buf)
 		return;
 
 	cursor.set = 0;
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->fontbuffer + ((c & charmask) * (w * vc->vc_font.height));
+	src = par->rotated.buf + ((c & charmask) * (w * vc->vc_font.height));
 
 	if (par->cursor_state.image.data != src ||
 	    par->cursor_reset) {
-- 
2.53.0

