Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0339DBD9
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616693; cv=none; b=NEbOAOGwCmLveNZi442u4UNvPs4bYYXjMilrhU9JiMA9A8dqv8qeJrESrZxdXZ4ibIZcpeJAmFqkF+ZOf/siOaMoNxTvWfHAMbJV/ap8h7UPaEovGd8MSIkcSFdPSj4MESrPsNXl7KaULLw/iGRQO6y23zZ+lJNLo0gOSnT5OVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616693; c=relaxed/simple;
	bh=GOIWEa9RuQ1ASPmVdz6+dIKrANd1nAtM9ByQxIsBqNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqSQwiUn/Gn9imH3jY5JNjYVtG9FJPWYrXVNbKJjO3EghfmakccTXMe76u0HEqJDEhoC7xmHo5OkaS0JirlHK2Esk/JyhIuZRllDI3F6y9tKrhGMCLgObnn/JjFf1Prfs9NeCbxClBTBjueQmedC7UAQpjcBz3dWQI+uHz4XoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 661965BE43;
	Fri, 27 Mar 2026 13:04:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23B064A0B1;
	Fri, 27 Mar 2026 13:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oDCMB2WAxmmweQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:04:37 +0000
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
Subject: [PATCH 05/10] lib/fonts: Implement glyph rotation
Date: Fri, 27 Mar 2026 13:49:38 +0100
Message-ID: <20260327130431.59481-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327130431.59481-1-tzimmermann@suse.de>
References: <20260327130431.59481-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 661965BE43
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

Move the glphy rotation helpers from fbcon to the font library. Wrap them
behind clean interfaces. Also clear the output memory to zero. Previously,
the implementation relied on the caller to do that.

Go through the fbcon code and callers of the glyph-rotation helpers. In
addition to the font rotation, there's also the cursor code, which uses
the rotation helpers.

The font-rotation relied on a single memset to zero for the whole font.
This is now multiple memsets on each glyph. This will be sorted out when
the font library also implements font rotation.

Building glyph rotation in the font library still depends on
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y. If we get more users of the code,
we can still add a dedicated Kconfig symbol to the font library.

No changes have been made to the actual implementation of the rotate_*()
and pattern_*() functions. These will be refactored as separate changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon_ccw.c    |   4 +-
 drivers/video/fbdev/core/fbcon_cw.c     |   4 +-
 drivers/video/fbdev/core/fbcon_rotate.c |  12 +-
 drivers/video/fbdev/core/fbcon_rotate.h |  71 -----------
 include/linux/font.h                    |   8 ++
 lib/fonts/Makefile                      |   1 +
 lib/fonts/font_rotate.c                 | 150 ++++++++++++++++++++++++
 7 files changed, 167 insertions(+), 83 deletions(-)
 create mode 100644 lib/fonts/font_rotate.c

diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 96ef449ee6ac..72453a2aaca8 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <linux/font.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
 #include <asm/types.h>
@@ -344,8 +345,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		size = cur_height * width;
 		while (size--)
 			tmp[i++] = 0xff;
-		memset(mask, 0, w * vc->vc_font.width);
-		rotate_ccw(tmp, mask, vc->vc_font.width, vc->vc_font.height);
+		font_glyph_rotate_270(tmp, vc->vc_font.width, vc->vc_font.height, mask);
 		kfree(tmp);
 	}
 
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index ea712654edae..5690fc1d7854 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <linux/font.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
 #include <asm/types.h>
@@ -327,8 +328,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		size = cur_height * width;
 		while (size--)
 			tmp[i++] = 0xff;
-		memset(mask, 0, w * vc->vc_font.width);
-		rotate_cw(tmp, mask, vc->vc_font.width, vc->vc_font.height);
+		font_glyph_rotate_90(tmp, vc->vc_font.width, vc->vc_font.height, mask);
 		kfree(tmp);
 	}
 
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 18575c5182db..588dc9d6758a 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <linux/font.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
 #include <asm/types.h>
@@ -60,30 +61,25 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	}
 
 	dst = par->fontbuffer;
-	memset(dst, 0, par->fd_size);
 
 	switch (par->rotate) {
 	case FB_ROTATE_UD:
 		for (i = len; i--; ) {
-			rotate_ud(src, dst, vc->vc_font.width,
-				  vc->vc_font.height);
-
+			font_glyph_rotate_180(src, vc->vc_font.width, vc->vc_font.height, dst);
 			src += s_cellsize;
 			dst += d_cellsize;
 		}
 		break;
 	case FB_ROTATE_CW:
 		for (i = len; i--; ) {
-			rotate_cw(src, dst, vc->vc_font.width,
-				  vc->vc_font.height);
+			font_glyph_rotate_90(src, vc->vc_font.width, vc->vc_font.height, dst);
 			src += s_cellsize;
 			dst += d_cellsize;
 		}
 		break;
 	case FB_ROTATE_CCW:
 		for (i = len; i--; ) {
-			rotate_ccw(src, dst, vc->vc_font.width,
-				   vc->vc_font.height);
+			font_glyph_rotate_270(src, vc->vc_font.width, vc->vc_font.height, dst);
 			src += s_cellsize;
 			dst += d_cellsize;
 		}
diff --git a/drivers/video/fbdev/core/fbcon_rotate.h b/drivers/video/fbdev/core/fbcon_rotate.h
index 8cb019e8a9c0..725bcae2df61 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.h
+++ b/drivers/video/fbdev/core/fbcon_rotate.h
@@ -19,77 +19,6 @@
         (fb_scrollmode(s) == SCROLL_REDRAW || fb_scrollmode(s) == SCROLL_MOVE || !(i)->fix.xpanstep) ? \
         (i)->var.xres : (i)->var.xres_virtual; })
 
-
-static inline int pattern_test_bit(u32 x, u32 y, u32 pitch, const char *pat)
-{
-	u32 tmp = (y * pitch) + x, index = tmp / 8,  bit = tmp % 8;
-
-	pat +=index;
-	return (*pat) & (0x80 >> bit);
-}
-
-static inline void pattern_set_bit(u32 x, u32 y, u32 pitch, char *pat)
-{
-	u32 tmp = (y * pitch) + x, index = tmp / 8, bit = tmp % 8;
-
-	pat += index;
-
-	(*pat) |= 0x80 >> bit;
-}
-
-static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
-{
-	int i, j;
-	int shift = (8 - (width % 8)) & 7;
-
-	width = (width + 7) & ~7;
-
-	for (i = 0; i < height; i++) {
-		for (j = 0; j < width - shift; j++) {
-			if (pattern_test_bit(j, i, width, in))
-				pattern_set_bit(width - (1 + j + shift),
-						height - (1 + i),
-						width, out);
-		}
-
-	}
-}
-
-static inline void rotate_cw(const char *in, char *out, u32 width, u32 height)
-{
-	int i, j, h = height, w = width;
-	int shift = (8 - (height % 8)) & 7;
-
-	width = (width + 7) & ~7;
-	height = (height + 7) & ~7;
-
-	for (i = 0; i < h; i++) {
-		for (j = 0; j < w; j++) {
-			if (pattern_test_bit(j, i, width, in))
-				pattern_set_bit(height - 1 - i - shift, j,
-						height, out);
-
-		}
-	}
-}
-
-static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
-{
-	int i, j, h = height, w = width;
-	int shift = (8 - (width % 8)) & 7;
-
-	width = (width + 7) & ~7;
-	height = (height + 7) & ~7;
-
-	for (i = 0; i < h; i++) {
-		for (j = 0; j < w; j++) {
-			if (pattern_test_bit(j, i, width, in))
-				pattern_set_bit(i, width - 1 - j - shift,
-						height, out);
-		}
-	}
-}
-
 int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc);
 
 #if defined(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION)
diff --git a/include/linux/font.h b/include/linux/font.h
index 3bd49d914b22..0a240dd70422 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -104,6 +104,14 @@ unsigned int font_data_size(font_data_t *fd);
 bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
 int font_data_export(font_data_t *fd, struct console_font *font, unsigned int vpitch);
 
+/* font_rotate.c */
+void font_glyph_rotate_90(const unsigned char *glyph, unsigned int width, unsigned int height,
+			  unsigned char *out);
+void font_glyph_rotate_180(const unsigned char *glyph, unsigned int width, unsigned int height,
+			   unsigned char *out);
+void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsigned int height,
+			   unsigned char *out);
+
 /*
  * Font description
  */
diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
index 3268d344c0a1..32ece0e265c8 100644
--- a/lib/fonts/Makefile
+++ b/lib/fonts/Makefile
@@ -2,6 +2,7 @@
 # Font handling
 
 font-y := fonts.o
+font-$(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION) += font_rotate.o
 
 # Built-in fonts
 font-$(CONFIG_FONT_10x18)     += font_10x18.o
diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
new file mode 100644
index 000000000000..3e0a19c889f3
--- /dev/null
+++ b/lib/fonts/font_rotate.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Font rotation
+ *
+ *    Copyright (C) 2005 Antonino Daplas <adaplas @pol.net>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive for
+ * more details.
+ */
+
+#include <linux/export.h>
+#include <linux/math.h>
+#include <linux/string.h>
+
+#include "font.h"
+
+static inline int pattern_test_bit(u32 x, u32 y, u32 pitch, const char *pat)
+{
+	u32 tmp = (y * pitch) + x, index = tmp / 8,  bit = tmp % 8;
+
+	pat += index;
+	return (*pat) & (0x80 >> bit);
+}
+
+static inline void pattern_set_bit(u32 x, u32 y, u32 pitch, char *pat)
+{
+	u32 tmp = (y * pitch) + x, index = tmp / 8, bit = tmp % 8;
+
+	pat += index;
+
+	(*pat) |= 0x80 >> bit;
+}
+
+static inline void rotate_cw(const char *in, char *out, u32 width, u32 height)
+{
+	int i, j, h = height, w = width;
+	int shift = (8 - (height % 8)) & 7;
+
+	width = (width + 7) & ~7;
+	height = (height + 7) & ~7;
+
+	for (i = 0; i < h; i++) {
+		for (j = 0; j < w; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(height - 1 - i - shift, j,
+						height, out);
+		}
+	}
+}
+
+/**
+ * font_glyph_rotate_90 - Rotate a glyph pattern by 90° in clockwise direction
+ * @glyph: The glyph to rotate
+ * @width: The glyph width in bits per scanline
+ * @height: The number of scanlines in the glyph
+ * @out: The rotated glyph bitmap
+ *
+ * The parameters @width and @height refer to the input glyph given in @glyph.
+ * The caller has to provide the output buffer @out of sufficient size to hold
+ * the rotated glyph. Rotating by 90° flips the width and height for the output
+ * glyph. Depending on the glyph pitch, the size of the output glyph can be
+ * different then the size of the input. Caller shave to take this into account
+ * when allocating the output memory.
+ */
+void font_glyph_rotate_90(const unsigned char *glyph, unsigned int width, unsigned int height,
+			  unsigned char *out)
+{
+	memset(out, 0, font_glyph_size(height, width)); /* flip width/height */
+
+	rotate_cw(glyph, out, width, height);
+}
+EXPORT_SYMBOL_GPL(font_glyph_rotate_90);
+
+static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
+{
+	int i, j;
+	int shift = (8 - (width % 8)) & 7;
+
+	width = (width + 7) & ~7;
+
+	for (i = 0; i < height; i++) {
+		for (j = 0; j < width - shift; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(width - (1 + j + shift),
+						height - (1 + i),
+						width, out);
+		}
+	}
+}
+
+/**
+ * font_glyph_rotate_180 - Rotate a glyph pattern by 180°
+ * @glyph: The glyph to rotate
+ * @width: The glyph width in bits per scanline
+ * @height: The number of scanlines in the glyph
+ * @out: The rotated glyph bitmap
+ *
+ * The parameters @width and @height refer to the input glyph given in @glyph.
+ * The caller has to provide the output buffer @out of sufficient size to hold
+ * the rotated glyph.
+ */
+void font_glyph_rotate_180(const unsigned char *glyph, unsigned int width, unsigned int height,
+			   unsigned char *out)
+{
+	memset(out, 0, font_glyph_size(width, height));
+
+	rotate_ud(glyph, out, width, height);
+}
+EXPORT_SYMBOL_GPL(font_glyph_rotate_180);
+
+static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
+{
+	int i, j, h = height, w = width;
+	int shift = (8 - (width % 8)) & 7;
+
+	width = (width + 7) & ~7;
+	height = (height + 7) & ~7;
+
+	for (i = 0; i < h; i++) {
+		for (j = 0; j < w; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(i, width - 1 - j - shift,
+						height, out);
+		}
+	}
+}
+
+/**
+ * font_glyph_rotate_270 - Rotate a glyph pattern by 270° in clockwise direction
+ * @glyph: The glyph to rotate
+ * @width: The glyph width in bits per scanline
+ * @height: The number of scanlines in the glyph
+ * @out: The rotated glyph bitmap
+ *
+ * The parameters @width and @height refer to the input glyph given in @glyph.
+ * The caller has to provide the output buffer @out of sufficient size to hold
+ * the rotated glyph. Rotating by 270° flips the width and height for the output
+ * glyph. Depending on the glyph pitch, the size of the output glyph can be
+ * different then the size of the input. Caller shave to take this into account
+ * when allocating the output memory.
+ */
+void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsigned int height,
+			   unsigned char *out)
+{
+	memset(out, 0, font_glyph_size(height, width)); /* flip width/height */
+
+	rotate_ccw(glyph, out, width, height);
+}
+EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
-- 
2.53.0

