Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904D36B05C
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856891; cv=none; b=pjOpmqrhfyB0rEdr6NuyIq9fpQ9TP3FwOMOQ8gbU5eUQjGhIDxnXUn8+KnGnZ/TkHzV/RHtMzMj36EEIGJnfsGBMsdxRwfcqsvsO7CG7gA16h84ac/2xF9fD2svBX0AfssI7hxjGrE5Dnq2MEV94jQjYZwGa7gvLOumCfN1xotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856891; c=relaxed/simple;
	bh=ef9Whc/ZEsD37TSZMkgMF/IiFIYMPcCyLpRGFv44sJM=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=aNKI9+AvxCRNR/WTc1sVu1xHlA4TtuJwH6pR5Ps8BrCpQ4K62ViHuNUPHjRGMe2i9AQJvN532ILvaJbq2dBL+v1EKL5FLvIg3oPyqYjB058K4V0I2ROMRMcy3DcXBKR6WbUsMMlpKUSotD0aytLo03K03De64ve8LtL3ISbKWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 22941 invoked by uid 3782); 27 Aug 2026 20:54:41 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 20:54:41 +0200
Received: (qmail 31166 invoked by uid 1000); 27 Aug 2026 18:54:40 -0000
Date: Thu, 27 Aug 2026 18:54:40 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: acm@muc.de
Subject: [Patch 7/9]: vt: Handle up to 2^21 glyphs, rather than 256/512
Message-ID: <apCH8Pt7qdDjUWuW@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCEDM2sWv_M354-@MAC.fritz.box>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

vt: 32b glyph: 7. Handle up to 2^21 glyphs, rather than 256/512

Replace/supplement tests for number of glyphs with the full
Unicode limits.

Signed-off-by: Alan Mackenzie <acm@muc.de>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..0c389a564357 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4905,6 +4961,7 @@ void reset_palette(struct vc_data *vc)
 #define max_font_width	64
 #define max_font_height	128
 #define max_font_glyphs	512
+#define max_font_glyphs21 0x110000
 #define max_font_size	(max_font_glyphs*max_font_width*max_font_height)
 
 static int con_font_get(struct vc_data *vc, struct console_font_op *op)
@@ -4960,17 +5017,23 @@ static int con_font_set(struct vc_data *vc, const struct console_font_op *op)
 
 	if (!op->data)
 		return -EINVAL;
+#ifndef CONFIG_FB_GLYPH_21BIT
 	if (op->charcount > max_font_glyphs)
 		return -EINVAL;
+#else
+	if (op->charcount > max_font_glyphs21)
+		return -EINVAL;
+#endif
 	if (op->width <= 0 || op->width > max_font_width || !op->height ||
 	    op->height > max_font_height)
 		return -EINVAL;
 	if (vpitch < op->height)
 		return -EINVAL;
 	size = DIV_ROUND_UP(op->width, 8) * vpitch * op->charcount;
+#ifndef CONFIG_FB_GLYPH_21BIT
 	if (size > max_font_size)
 		return -ENOSPC;
-
+#endif
 	void *font_data __free(kfree) = font.data = memdup_user(op->data, size);
 	if (IS_ERR(font.data))
 		return PTR_ERR(font.data);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9f5c4c101581..18fbf7cf11dd 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2331,7 +2366,9 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigne
 	font->height = vc->vc_font.height;
 	if (font->height > vpitch)
 		return -ENOSPC;
-	font->charcount = vc->vc_hi_font_mask ? 512 : 256;
+	font->charcount = vc->vc_font.charcount;
+	if (!font->data)
+		return 0;
 
 	return font_data_export(p->fontdata, font, vpitch);
 }
@@ -2420,10 +2468,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	vc->vc_font.width = w;
 	vc->vc_font.height = h;
 	vc->vc_font.charcount = charcount;
-	if (vc->vc_hi_font_mask && charcount == 256)
-		set_vc_hi_font(vc, false);
-	else if (!vc->vc_hi_font_mask && charcount == 512)
+
+#ifndef CONFIG_FB_GLYPH_21BIT
+	if (charcount == 512 && !vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, true);
+	else if (charcount == 256 && vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, false);
+#endif
 
 	if (resize) {
 		int cols, rows;
@@ -2465,8 +2518,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 }
 
 /*
- *  User asked to set font; we are guaranteed that charcount does not exceed 512
- *  but lets not assume that, since charcount of 512 is small for unicode support.
+ *  User asked to set font; we were once guaranteed that charcount did not
+ *  exceed 512 but that is no longer the case, since charcount of 512 is too
+ *  small for unicode support.
  */
 
 static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
@@ -2479,10 +2533,18 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	int i, ret;
 	font_data_t *new_data;
 
-	/* Is there a reason why fbconsole couldn't handle any charcount >256?
-	 * If not this check should be changed to charcount < 256 */
+#ifdef CONFIG_FB_GLYPH_21BIT
+	if (charcount < 256)
+		return -EINVAL;
+#else
+	/* There is no longer any reason why fbconsole can't handle
+	 * any charcount >256, when CONFIG_FB_GLYPH_21BIT is #defined.
+	 * Hence this check has been changed to charcount < 256
+	 * above.
+	 */
 	if (charcount != 256 && charcount != 512)
 		return -EINVAL;
+#endif
 
 	/* font bigger than screen resolution ? */
 	if (w > FBCON_SWAP(info->var.rotate, info->var.xres, info->var.yres) ||


-- 
Alan Mackenzie (Nuremberg, Germany).
