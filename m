Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03A3E929A
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616711; cv=none; b=sep2MxSTmGR1KyzO9lwKvqhiyWj3VxyTdA9chJc5ovtv5Z5jDW0iLDYqyWlW/RPieHMfAkYjubnV8QBN86kWzfSCMY/OjLps049UBbAesLjIZUvSBepFP74S4QMfHS/IVmSXpCCgLoG1MloXR4tYn4RtjzOxUQz2NbWKJM8ssDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616711; c=relaxed/simple;
	bh=RB+M8lR5XN1us0zSmwto8GBAjybD+BpTQhA1a9Wbrt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCf3+qAmMQghCD+HT2uOLHGm3A5TjYGYI+SF0g0OjNcKeVc84G57enO9I6IIIjZg3+hLsi7/gqIIiNSYhhwn3AzYOjx21nzMjdTTO+WQ9gZDb8L6OsO3QrNtG1yDja9aEEhaJ8acL7qeoG98GhEXHXiRO++pbg8QYEknm9mjlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YnqJ4KJJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S5dkZYAR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YnqJ4KJJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S5dkZYAR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YnqJ4KJJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S5dkZYAR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YnqJ4KJJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S5dkZYAR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C2494D347;
	Fri, 27 Mar 2026 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXbch6n2enq8wiRbR7KUsLz+dTkbA9k9SyrEF5tA2ts=;
	b=YnqJ4KJJEjfT9aXeAppynAeWrYSyAI97Qrj+16GoREp8oYEOVcb3L77umwSTKRPL0fp45m
	0Cmt5JMOKZB02D3h8ydah/h4pKmSkwrbX65EEBTb8A9n37ztjGzZuBwT7KnJwtA7UGDbVo
	6c42oTS/mo0aNE9g0T00M3KEy84Dlxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXbch6n2enq8wiRbR7KUsLz+dTkbA9k9SyrEF5tA2ts=;
	b=S5dkZYARHEFkJgd0aRXZ99canoOYm79S2FE5vsmRlYDM1/v1EUFGEm93R1HI1Jx/ri+sh6
	R0uEedLl6Ai/doBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXbch6n2enq8wiRbR7KUsLz+dTkbA9k9SyrEF5tA2ts=;
	b=YnqJ4KJJEjfT9aXeAppynAeWrYSyAI97Qrj+16GoREp8oYEOVcb3L77umwSTKRPL0fp45m
	0Cmt5JMOKZB02D3h8ydah/h4pKmSkwrbX65EEBTb8A9n37ztjGzZuBwT7KnJwtA7UGDbVo
	6c42oTS/mo0aNE9g0T00M3KEy84Dlxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXbch6n2enq8wiRbR7KUsLz+dTkbA9k9SyrEF5tA2ts=;
	b=S5dkZYARHEFkJgd0aRXZ99canoOYm79S2FE5vsmRlYDM1/v1EUFGEm93R1HI1Jx/ri+sh6
	R0uEedLl6Ai/doBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 095744A0A2;
	Fri, 27 Mar 2026 13:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mHQaAWaAxmmweQAAD6G6ig
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
Subject: [PATCH 08/10] lib/fonts: Implement font rotation
Date: Fri, 27 Mar 2026 13:49:41 +0100
Message-ID: <20260327130431.59481-9-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,ravnborg.org];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -7.30
X-Spam-Level: 

Move the core of fbcon's font-rotation code to the font library as
the new helper font_data_rotate(). The code can rotate in steps of
90°. For completeness, it also copies the glyph data for multiples
of 360°.

Bring back the memset optimization. A memset to 0 again clears the
whole glyph output buffer. Then use the internal rotation helpers on
the cleared output. Fbcon's original implementation worked like this,
but lost it during refactoring.

Replace fbcon's font-rotation code with the new implementations.
All that's left to do for fbcon is to maintain its internal fbcon
state.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.h        |   2 +-
 drivers/video/fbdev/core/fbcon_rotate.c |  78 +++++-------------
 include/linux/font.h                    |   3 +
 lib/fonts/font_rotate.c                 | 103 ++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 60 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 1e3c1ef84762..1793f34a6c84 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -86,7 +86,7 @@ struct fbcon_par {
 	const u8    *fontdata;
 	u8    *cursor_src;
 	u32    cursor_size;
-	u32    fd_size;
+	size_t fd_size;
 
 	const struct fbcon_bitops *bitops;
 };
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 588dc9d6758a..74206f5a6e98 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -8,84 +8,44 @@
  *  more details.
  */
 
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/string.h>
+#include <linux/errno.h>
 #include <linux/fb.h>
 #include <linux/font.h>
-#include <linux/vt_kern.h>
-#include <linux/console.h>
-#include <asm/types.h>
+
 #include "fbcon.h"
 #include "fbcon_rotate.h"
 
 int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 {
 	struct fbcon_par *par = info->fbcon_par;
-	int len, err = 0;
-	int s_cellsize, d_cellsize, i;
-	const u8 *src;
-	u8 *dst;
+	unsigned char *fontbuffer;
+	int ret;
 
 	if (vc->vc_font.data == par->fontdata &&
 	    par->p->con_rotate == par->cur_rotate)
-		goto finished;
+		return 0;
 
-	src = par->fontdata = vc->vc_font.data;
+	par->fontdata = vc->vc_font.data;
 	par->cur_rotate = par->p->con_rotate;
-	len = vc->vc_font.charcount;
-	s_cellsize = font_glyph_size(vc->vc_font.width, vc->vc_font.height);
-	d_cellsize = s_cellsize;
-
-	if (par->rotate == FB_ROTATE_CW ||
-	    par->rotate == FB_ROTATE_CCW)
-		d_cellsize = font_glyph_size(vc->vc_font.height, vc->vc_font.width);
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
 
-	if (par->fd_size < d_cellsize * len) {
-		kfree(par->fontbuffer);
-		par->fontbuffer = NULL;
-		par->fd_size = 0;
-
-		dst = kmalloc_array(len, d_cellsize, GFP_KERNEL);
-
-		if (dst == NULL) {
-			err = -ENOMEM;
-			goto finished;
-		}
-
-		par->fd_size = d_cellsize * len;
-		par->fontbuffer = dst;
+	fontbuffer = font_data_rotate(par->p->fontdata, vc->vc_font.width,
+				      vc->vc_font.height, vc->vc_font.charcount,
+				      par->rotate, par->fontbuffer, &par->fd_size);
+	if (IS_ERR(fontbuffer)) {
+		ret = PTR_ERR(fontbuffer);
+		goto err_kfree;
 	}
 
-	dst = par->fontbuffer;
+	par->fontbuffer = fontbuffer;
 
-	switch (par->rotate) {
-	case FB_ROTATE_UD:
-		for (i = len; i--; ) {
-			font_glyph_rotate_180(src, vc->vc_font.width, vc->vc_font.height, dst);
-			src += s_cellsize;
-			dst += d_cellsize;
-		}
-		break;
-	case FB_ROTATE_CW:
-		for (i = len; i--; ) {
-			font_glyph_rotate_90(src, vc->vc_font.width, vc->vc_font.height, dst);
-			src += s_cellsize;
-			dst += d_cellsize;
-		}
-		break;
-	case FB_ROTATE_CCW:
-		for (i = len; i--; ) {
-			font_glyph_rotate_270(src, vc->vc_font.width, vc->vc_font.height, dst);
-			src += s_cellsize;
-			dst += d_cellsize;
-		}
-		break;
-	}
+	return 0;
+
+err_kfree:
+	kfree(par->fontbuffer);
+	par->fontbuffer = NULL; /* clear here to avoid output */
 
-finished:
-	return err;
+	return ret;
 }
diff --git a/include/linux/font.h b/include/linux/font.h
index 0a240dd70422..6845f02d739a 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -111,6 +111,9 @@ void font_glyph_rotate_180(const unsigned char *glyph, unsigned int width, unsig
 			   unsigned char *out);
 void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsigned int height,
 			   unsigned char *out);
+unsigned char *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
+				unsigned int charcount, unsigned int steps,
+				unsigned char *buf, size_t *bufsize);
 
 /*
  * Font description
diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
index f1e441a931ab..d8c8973310c2 100644
--- a/lib/fonts/font_rotate.c
+++ b/lib/fonts/font_rotate.c
@@ -9,8 +9,11 @@
  * more details.
  */
 
+#include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/math.h>
+#include <linux/overflow.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 
 #include "font.h"
@@ -170,3 +173,103 @@ void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsig
 	__font_glyph_rotate_270(glyph, width, height, out);
 }
 EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
+
+/**
+ * font_data_rotate - Rotate font data by multiples of 90°
+ * @fd: The font data to rotate
+ * @width: The glyph width in bits per scanline
+ * @height: The number of scanlines in the glyph
+ * @charcount: The number of glyphs in the font
+ * @steps: Number of rotation steps of 90°
+ * @buf: Preallocated output buffer; can be NULL
+ * @bufsize: The size of @buf in bytes; can be NULL
+ *
+ * The parameters @width and @height refer to the visible number of pixels
+ * and scanlines in a single glyph. The number of glyphs is given in @charcount.
+ * Rotation happens in steps of 90°. The @steps parameter can have any value,
+ * but only 0 to 3 produce distinct results. With 4 or higher, a full rotation
+ * has been performed. You can pass any value for @steps and the helper will
+ * perform the appropriate rotation. Note that the returned buffer is not
+ * compatible with font_data_t. It only contains glphy data in the same format
+ * as returned by font_data_buf(). Callers are responsible to free the returned
+ * buffer with kfree(). Font rotation typically happens when displays get
+ * re-oriented. To avoid unnecessary re-allocation of the memory buffer, the
+ * caller can pass in an earlier result buffer in @buf for reuse. The buffer
+ * size of given and returned in @bufsize. The allocation semantics are compatible
+ * with krealloc().
+ *
+ * Returns:
+ * A buffer with rotated glyphs on success, or an error pointer otherwise
+ */
+unsigned char *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
+				unsigned int charcount, unsigned int steps,
+				unsigned char *buf, size_t *bufsize)
+{
+	const unsigned char *src = font_data_buf(fd);
+	unsigned int s_cellsize = font_glyph_size(width, height);
+	unsigned int d_cellsize, i;
+	unsigned char *dst;
+	size_t size;
+
+	steps %= 4;
+
+	switch (steps) {
+	case 0:
+	case 2:
+		d_cellsize = s_cellsize;
+		break;
+	case 1:
+	case 3:
+		d_cellsize = font_glyph_size(height, width); /* flip width/height */
+		break;
+	}
+
+	if (check_mul_overflow(charcount, d_cellsize, &size))
+		return ERR_PTR(-EINVAL);
+
+	if (!buf || !bufsize || size > *bufsize) {
+		dst = kmalloc_array(charcount, d_cellsize, GFP_KERNEL);
+		if (!dst)
+			return ERR_PTR(-ENOMEM);
+
+		kfree(buf);
+		buf = dst;
+		if (bufsize)
+			*bufsize = size;
+	} else {
+		dst = buf;
+	}
+
+	switch (steps) {
+	case 0:
+		memcpy(dst, src, size);
+		break;
+	case 1:
+		memset(dst, 0, size);
+		for (i = 0; i < charcount; ++i) {
+			__font_glyph_rotate_90(src, width, height, dst);
+			src += s_cellsize;
+			dst += d_cellsize;
+		}
+		break;
+	case 2:
+		memset(dst, 0, size);
+		for (i = 0; i < charcount; ++i) {
+			__font_glyph_rotate_180(src, width, height, dst);
+			src += s_cellsize;
+			dst += d_cellsize;
+		}
+		break;
+	case 3:
+		memset(dst, 0, size);
+		for (i = 0; i < charcount; ++i) {
+			__font_glyph_rotate_270(src, width, height, dst);
+			src += s_cellsize;
+			dst += d_cellsize;
+		}
+		break;
+	}
+
+	return buf;
+}
+EXPORT_SYMBOL_GPL(font_data_rotate);
-- 
2.53.0

