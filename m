Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA13A6EFD
	for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554005; cv=none; b=jiDReeWldAUbnaQ5eTyd4vHfN78IX8QocQWZauZkmbiI+Hd4/AVv6vCO0D1TJjbmstJNRbg1f2zA8HVabdHrnHEkd6zrMG0CIAVCgMxewx+D0orYb+2L1sUOaUhmPGa9DmwR1S/QPJN7XXoLXeL9kfqfDgpnmoCNDkte700409U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554005; c=relaxed/simple;
	bh=g1rGNX/bXlKdjwtDqDMFgZJbJEwu3pOd1L0E8WPENRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmVqZAh7/6vef3EyZbc6QiBeq4V5/mdBjKyDCjstwYr0Iyh3G4q9ID6V4QFn20ZvrXuATJShQryviV8yGy8qk6FFkgxjw7MuZcfdZdhOzKIxA/tmCTwqn3fToM7OFQ3YoM9X3OLwSKDj4uKlRdcioFWO4W1fJnZPH2AzN5hjfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B07BE4E3A8;
	Tue,  7 Apr 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A3D04A0B2;
	Tue,  7 Apr 2026 09:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFS5GKvN1GmDVwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 07 Apr 2026 09:26:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert@linux-m68k.org,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 10/10] fbcon: Put font-rotation state into separate struct
Date: Tue,  7 Apr 2026 11:23:21 +0200
Message-ID: <20260407092555.58816-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407092555.58816-1-tzimmermann@suse.de>
References: <20260407092555.58816-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B07BE4E3A8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Move all temporary state of the font-rotation code into the struct
rotated in struct fbcon_par. Protect it with the Kconfig symbol
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION. Avoids mixing it up with fbcon's
regular state.

v2:
- fix typos

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
index ff4c69e971f8..b0e3e765360d 100644
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
index bb0727b70631..321cc7f44baa 100644
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
+		u8 *buf;                /* rotated glyphs */
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

