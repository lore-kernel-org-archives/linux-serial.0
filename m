Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE823E9F9D
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616686; cv=none; b=Cl4H5OPuRcZHQVwBEnw/HQFggf7c1PZKOEiF18Mz6aJPAyhimxdUcWGq2NcoQLZJCmPgelQeZTODnCzVHHWbwsjbDjtPFENBaXAVpLyWrAFrG1Bx7mJTXTTLIiuO3VFmkb7YARcaD2zVfMcbzoq2aIms7ohViC07oiW3jMUu0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616686; c=relaxed/simple;
	bh=bEeVkLLDZ7r9bPa02ZXAwIpFbTAvlYuoLbgETZyDsxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW8bXTjf79ltOOwwsXBMXEMUI67TAeRbB333V/tSv9DDzC/hvM4tNRrdaY1NnS8QoyRTslUOg2RUXKeWwcxG7kzegFcu+5eN2trMJ//ZaIyLcURa9T5Whafza6nDIWpBiIqySsVMbx541Z/f7qkMSH05WFPvzWS69Xw2GkBFww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6A1B4D34D;
	Fri, 27 Mar 2026 13:04:36 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8661F4A0B1;
	Fri, 27 Mar 2026 13:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cOSGH2SAxmmweQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:04:36 +0000
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
Subject: [PATCH 03/10] lib/fonts: Provide helpers for calculating glyph pitch and size
Date: Fri, 27 Mar 2026 13:49:36 +0100
Message-ID: <20260327130431.59481-4-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: C6A1B4D34D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Implement pitch and size calculation for a single font glyph in the
new helpers font_glyph_pitch() and font_glyph_size(). Replace the
instances where the calculations are opencoded.

Note that in the case of fbcon console rotation, the parameters for
a glyph's width and height might be reversed. This is intentionally.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/tty/vt/vt.c                     |  5 ++--
 drivers/video/fbdev/core/fbcon_ccw.c    | 11 +++----
 drivers/video/fbdev/core/fbcon_cw.c     | 11 +++----
 drivers/video/fbdev/core/fbcon_rotate.c |  6 ++--
 drivers/video/fbdev/core/fbcon_ud.c     |  7 +++--
 include/linux/font.h                    | 40 +++++++++++++++++++++++++
 lib/fonts/fonts.c                       |  2 +-
 7 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3d89d30c9596..23b9683b52a5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -71,7 +71,6 @@
  * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
  */
 
-#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/sched/signal.h>
@@ -244,7 +243,7 @@ enum {
  */
 unsigned int vc_font_pitch(const struct vc_font *font)
 {
-	return DIV_ROUND_UP(font->width, 8);
+	return font_glyph_pitch(font->width);
 }
 EXPORT_SYMBOL_GPL(vc_font_pitch);
 
@@ -261,7 +260,7 @@ EXPORT_SYMBOL_GPL(vc_font_pitch);
  */
 unsigned int vc_font_size(const struct vc_font *font)
 {
-	return font->height * vc_font_pitch(font) * font->charcount;
+	return font_glyph_size(font->width, font->height) * font->charcount;
 }
 EXPORT_SYMBOL_GPL(vc_font_size);
 
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 2f394b5a17f7..96ef449ee6ac 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -26,7 +26,7 @@ static void ccw_update_attr(u8 *dst, u8 *src, int attribute,
 				  struct vc_data *vc)
 {
 	int i, j, offset = (vc->vc_font.height < 10) ? 1 : 2;
-	int width = (vc->vc_font.height + 7) >> 3;
+	int width = font_glyph_pitch(vc->vc_font.height);
 	int mod = vc->vc_font.height % 8;
 	u8 c, msk = ~(0xff << offset), msk1 = 0;
 
@@ -101,7 +101,7 @@ static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 {
 	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	u32 idx = (vc->vc_font.height + 7) >> 3;
+	u32 idx = font_glyph_pitch(vc->vc_font.height);
 	u8 *src;
 
 	while (cnt--) {
@@ -131,7 +131,7 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 {
 	struct fb_image image;
 	struct fbcon_par *par = info->fbcon_par;
-	u32 width = (vc->vc_font.height + 7)/8;
+	u32 width = font_glyph_pitch(vc->vc_font.height);
 	u32 cellsize = width * vc->vc_font.width;
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
@@ -223,7 +223,8 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	struct fb_cursor cursor;
 	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	int w = (vc->vc_font.height + 7) >> 3, c;
+	int w = font_glyph_pitch(vc->vc_font.height);
+	int c;
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1, dx, dy;
@@ -297,7 +298,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		char *tmp, *mask = kmalloc_array(w, vc->vc_font.width,
 						 GFP_ATOMIC);
 		int cur_height, size, i = 0;
-		int width = (vc->vc_font.width + 7)/8;
+		int width = font_glyph_pitch(vc->vc_font.width);
 
 		if (!mask)
 			return;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 3c3ad3471ec4..ea712654edae 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -26,7 +26,7 @@ static void cw_update_attr(u8 *dst, u8 *src, int attribute,
 				  struct vc_data *vc)
 {
 	int i, j, offset = (vc->vc_font.height < 10) ? 1 : 2;
-	int width = (vc->vc_font.height + 7) >> 3;
+	int width = font_glyph_pitch(vc->vc_font.height);
 	u8 c, msk = ~(0xff >> offset);
 
 	for (i = 0; i < vc->vc_font.width; i++) {
@@ -86,7 +86,7 @@ static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 {
 	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	u32 idx = (vc->vc_font.height + 7) >> 3;
+	u32 idx = font_glyph_pitch(vc->vc_font.height);
 	u8 *src;
 
 	while (cnt--) {
@@ -116,7 +116,7 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 {
 	struct fb_image image;
 	struct fbcon_par *par = info->fbcon_par;
-	u32 width = (vc->vc_font.height + 7)/8;
+	u32 width = font_glyph_pitch(vc->vc_font.height);
 	u32 cellsize = width * vc->vc_font.width;
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
@@ -206,7 +206,8 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	struct fb_cursor cursor;
 	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	int w = (vc->vc_font.height + 7) >> 3, c;
+	int w = font_glyph_pitch(vc->vc_font.height);
+	int c;
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1, dx, dy;
@@ -280,7 +281,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		char *tmp, *mask = kmalloc_array(w, vc->vc_font.width,
 						 GFP_ATOMIC);
 		int cur_height, size, i = 0;
-		int width = (vc->vc_font.width + 7)/8;
+		int width = font_glyph_pitch(vc->vc_font.width);
 
 		if (!mask)
 			return;
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 5348f6c6f57c..18575c5182db 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -33,14 +33,12 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	src = par->fontdata = vc->vc_font.data;
 	par->cur_rotate = par->p->con_rotate;
 	len = vc->vc_font.charcount;
-	s_cellsize = ((vc->vc_font.width + 7)/8) *
-		vc->vc_font.height;
+	s_cellsize = font_glyph_size(vc->vc_font.width, vc->vc_font.height);
 	d_cellsize = s_cellsize;
 
 	if (par->rotate == FB_ROTATE_CW ||
 	    par->rotate == FB_ROTATE_CCW)
-		d_cellsize = ((vc->vc_font.height + 7)/8) *
-			vc->vc_font.width;
+		d_cellsize = font_glyph_size(vc->vc_font.height, vc->vc_font.width);
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index 6fc30cad5b19..f7cd89c42b01 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -26,7 +26,7 @@ static void ud_update_attr(u8 *dst, u8 *src, int attribute,
 				  struct vc_data *vc)
 {
 	int i, offset = (vc->vc_font.height < 10) ? 1 : 2;
-	int width = (vc->vc_font.width + 7) >> 3;
+	int width = font_glyph_pitch(vc->vc_font.width);
 	unsigned int cellsize = vc->vc_font.height * width;
 	u8 c;
 
@@ -153,7 +153,7 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 {
 	struct fb_image image;
 	struct fbcon_par *par = info->fbcon_par;
-	u32 width = (vc->vc_font.width + 7)/8;
+	u32 width = font_glyph_pitch(vc->vc_font.width);
 	u32 cellsize = width * vc->vc_font.height;
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
@@ -253,7 +253,8 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	struct fb_cursor cursor;
 	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	int w = (vc->vc_font.width + 7) >> 3, c;
+	int w = font_glyph_pitch(vc->vc_font.width);
+	int c;
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1, dx, dy;
diff --git a/include/linux/font.h b/include/linux/font.h
index 5401f07dd6ce..3bd49d914b22 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -11,10 +11,50 @@
 #ifndef _VIDEO_FONT_H
 #define _VIDEO_FONT_H
 
+#include <linux/math.h>
 #include <linux/types.h>
 
 struct console_font;
 
+/*
+ * Glyphs
+ */
+
+/**
+ * font_glyph_pitch - Calculates the number of bytes per scanline
+ * @width: The glyph width in bits per scanline
+ *
+ * A glyph's pitch is the number of bytes in a single scanline, rounded
+ * up to the next full byte. The parameter @width receives the number
+ * of visible bits per scanline. For example, if width is 14 bytes per
+ * scanline, the pitch is 2 bytes per scanline. If width is 8 bits per
+ * scanline, the pitch is 1 byte per scanline.
+ *
+ * Returns:
+ * The number of bytes in a single scanline of the glyph
+ */
+static inline unsigned int font_glyph_pitch(unsigned int width)
+{
+	return DIV_ROUND_UP(width, 8);
+}
+
+/**
+ * font_glyph_size - Calculates the number of bytes per glyph
+ * @width: The glyph width in bits per scanline
+ * @vpitch: The number of scanlines in the glyph
+ *
+ * The number of bytes in a glyph depends on the pitch and the number
+ * of scanlines. font_glyph_size automatically calculates the pitch
+ * from the given width. The parameter @vpitch gives the number of
+ * scanlines, which is usually the glyph's height in scanlines. Fonts
+ * coming from user space can sometimes have a different vertical pitch
+ * with empty scanlines between two adjacent glyphs.
+ */
+static inline unsigned int font_glyph_size(unsigned int width, unsigned int vpitch)
+{
+	return font_glyph_pitch(width) * vpitch;
+}
+
 /*
  * font_data_t and helpers
  */
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 5938f542906b..f5d5333450a0 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -26,7 +26,7 @@
 
 #include "font.h"
 
-#define console_font_pitch(font) DIV_ROUND_UP((font)->width, 8)
+#define console_font_pitch(font) font_glyph_pitch((font)->width)
 
 /*
  * Helpers for font_data_t
-- 
2.53.0

