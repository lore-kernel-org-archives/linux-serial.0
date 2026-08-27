Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3194A3418
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856525; cv=none; b=SIDsZqtlz92Rx94lBztqeBDXegUNkrh5KoDotu7tcG20HD3z5rTAikllNHfJn+iIDRUSmmUtgOQKD2PDpXKfaQ7jiTPGpzKIQjVK7AlqaVYi+Gxp43waNflP7Jk96CrVm4cztpKX6iMXBq0zj64VhefBnIn4Wv4j6aHN7p3BrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856525; c=relaxed/simple;
	bh=xA7nua4i0j4lsbT5sJOF/FOITIgN0FRPZBOEnsNks8k=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=kAa39RLL473IudtxJwdwc4xsHEmB667ubYer7sSpj3PZ3Lbiy0idbuvuFovMaOdOcsb5L1ZoYKmf9PlyrRsOEKQP7esaEJ/bsxuNbjLOT1rjYw7EWwukGGahRUHkRPiTXHAtAw6nmwoF/Hi2h3wUH+bxFxgq4M/wDRXgbVYvTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 18454 invoked by uid 3782); 27 Aug 2026 20:48:41 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 20:48:40 +0200
Received: (qmail 31067 invoked by uid 1000); 27 Aug 2026 18:48:39 -0000
Date: Thu, 27 Aug 2026 18:48:39 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: acm@muc.de
Subject: [Patch 4/9]: Amend internal manipulation of glyph structure
Message-ID: <apCGh2y_Ole8rAGT@MAC.fritz.box>
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


vt: 32b glyph: 4. Amend internal manipulation of glyph structure

This manipulation is the extraction/insertion of bit fields from/into the
16-bit/32-bit glyph.  It uses the new fields of struct vc_data,
vc_char_mask, vc_attr_mask, vc_attr_shift_pos in place of old hard coded
constants such as 0xff, 0xff00, 8.

Signed-off-by: Alan Mackenzie <acm@muc.de>

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 7d40eacc21b3..f23d61fe10c1 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -272,6 +273,10 @@ static int vcs_read_buf_uni(struct vc_data *vc, char *con_buf,
 	return 0;
 }
 
+/*
+ * NOTE: This function returns the bottom 8 bits of the glyph for each pertinent
+ * screen character.  It is not very useful for a 9-bit or 21-bit glyph setup.
+ */
 static void vcs_read_buf_noattr(const struct vc_data *vc, char *con_buf,
 		unsigned int pos, unsigned int count, bool viewed)
 {
@@ -470,6 +499,10 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	return ret;
 }
 
+/*
+ * NOTE: This function writes the bottom 8-bits of the glyph code into the
+ * screen buffer.  It is not very useful for 9-bit or 21-bit glyphs.
+ */
 static u16 *vcs_write_buf_noattr(struct vc_data *vc, const char *con_buf,
 		unsigned int pos, unsigned int count, bool viewed, u16 **org0)
 {
@@ -497,25 +533,15 @@ static u16 *vcs_write_buf_noattr(struct vc_data *vc, const char *con_buf,
 	return org;
 }
 
-/*
- * Compilers (gcc 10) are unable to optimize the swap in cpu_to_le16. So do it
- * the poor man way.
- */
-static inline u16 vc_compile_le16(u8 hi, u8 lo)
-{
-#ifdef __BIG_ENDIAN
-	return (lo << 8u) | hi;
-#else
-	return (hi << 8u) | lo;
-#endif
-}
-
 static u16 *vcs_write_buf(struct vc_data *vc, const char *con_buf,
 		unsigned int pos, unsigned int count, bool viewed, u16 **org0)
 {
 	u16 *org;
 	unsigned int col, maxcol = vc->vc_cols;
 	unsigned char c;
+	unsigned int sz = GLYPH_SZ;
+	int i;
+	u8 lo_to_hi[4];
 
 	/* header */
 	if (pos < HEADER_SIZE) {
@@ -573,11 +619,27 @@ static u16 *vcs_write_buf(struct vc_data *vc, const char *con_buf,
 	if (!count)
 		return org;
 
-	/* odd pos -- the remaining character */
-	c = *con_buf++;
-	vcs_scr_writew(vc, vc_compile_le16(vcs_scr_readw(vc, org) >> 8, c),
-				org);
+	/* Unaligned bytes at end of buffer */
+	{
+		u32 old_char = vcs_scr_readw(vc, org);
+		u32 new_char = 0;
 
+		for (i = 0; i < sz; i++, old_char >>= 8)
+			lo_to_hi[i] = old_char & 0xff;
+		for (i = 0; i < count; i++) {
+			c = *con_buf++;
+#ifdef __BIG_ENDIAN
+			lo_to_hi[sz - i - 1] = c;
+#else
+			lo_to_hi[i] = c;
+#endif
+		}
+		for (i = sz - 1; i >= 0; i--) {
+			new_char <<= 8;
+			new_char |= lo_to_hi[i];
+		}
+		vcs_scr_writew(vc, new_char, org);
+	}
 	return org;
 }
 
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..0c389a564357 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -543,7 +544,7 @@ int vc_uniscr_check(struct vc_data *vc)
 	 * unicode content will be available after a complete screen refresh.
 	 */
 	p = (unsigned short *)vc->vc_origin;
-	mask = vc->vc_hi_font_mask | 0xff;
+	mask = vc->vc_char_mask;
 	for (y = 0; y < vc->vc_rows; y++) {
 		u32 *line = uni_lines[y];
 		for (x = 0; x < vc->vc_cols; x++) {
@@ -713,8 +719,6 @@ static u8 build_attr(struct vc_data *vc, u8 _color,
 		a ^= 0x80;
 	if (_intensity == VCI_BOLD)
 		a ^= 0x08;
-	if (vc->vc_hi_font_mask == 0x100)
-		a <<= 1;
 	return a;
 	}
 }
@@ -726,11 +730,11 @@ static void update_attr(struct vc_data *vc)
 	              vc->state.reverse ^ vc->vc_decscnm, vc->state.italic);
 	vc->vc_video_erase_char = ' ' | (build_attr(vc, vc->state.color,
 				VCI_NORMAL, vc->state.blink, false,
-				vc->vc_decscnm, false) << 8);
+				vc->vc_decscnm, false) << vc->vc_attr_shift_pos);
 }
 
-/* Note: inverting the screen twice should revert to the original state */
+/* Note: inverting the screen twice should revert to the original state.  */
 void invert_screen(struct vc_data *vc, int offset, int count, bool viewed)
 {
 	u16 *p;
 
@@ -742,34 +746,21 @@ void invert_screen(struct vc_data *vc, int offset, int count, bool viewed)
 		vc->vc_sw->con_invert_region(vc, p, count);
 	} else {
 		u16 *q = p;
 		int cnt = count;
-		u16 a;
-
-		if (!vc->vc_can_do_color) {
-			while (cnt--) {
-			    a = scr_readw(q);
-			    a ^= 0x0800;
-			    scr_writew(a, q);
-			    q++;
-			}
-		} else if (vc->vc_hi_font_mask == 0x100) {
-			while (cnt--) {
-				a = scr_readw(q);
-				a = (a & 0x11ff) |
-				   ((a & 0xe000) >> 4) |
-				   ((a & 0x0e00) << 4);
-				scr_writew(a, q);
-				q++;
-			}
-		} else {
-			while (cnt--) {
-				a = scr_readw(q);
-				a = (a & 0x88ff) |
-				   ((a & 0x7000) >> 4) |
-				   ((a & 0x0700) << 4);
-				scr_writew(a, q);
-				q++;
-			}
+		u32 a, c;
+
+		while (cnt--) {
+			c = scr_readg(q);
+			a = c >> vc->vc_attr_shift_pos;
+			if (!vc->vc_can_do_color)
+				a ^= 0x08;
+			else
+				a = (a & 0x88) |
+					((a & 0x70) >> 4) |
+					((a & 0x07) << 4);
+			c = (c & vc->vc_char_mask) |
+				(a << vc->vc_attr_shift_pos);
+			scr_writeg_plusplus(c, q++);
 		}
 	}
 
@@ -1041,19 +1037,37 @@ static void visual_init(struct vc_data *vc, int num, bool init)
 		con_free_unimap(vc);
 	vc->uni_pagedict_loc = &vc->uni_pagedict;
 	vc->uni_pagedict = NULL;
-	vc->vc_hi_font_mask = 0;
+	vc->vc_hi_font_mask = 0; /* Probably redundant, 2025-01-16. */
 	vc->vc_complement_mask = 0;
 	vc->vc_can_do_color = 0;
 	vc->vc_cur_blink_ms = DEFAULT_CURSOR_BLINK_MS;
+
 	vc->vc_sw->con_init(vc, init);
+	if (init) {
+#ifdef CONFIG_FB_GLYPH_21BIT
+		vc->vc_char_mask = 0x1fffff;
+		vc->vc_attr_mask = 0xff000000;
+		vc->vc_attr_shift_pos = 24;
+#else
+		if (vc->vc_font.charcount == 256) {
+			vc->vc_char_mask = 0xff;
+			vc->vc_attr_mask = 0xff00;
+			vc->vc_attr_shift_pos = 8;
+		} else {
+			vc->vc_char_mask = 0x1ff;
+			vc->vc_attr_mask = 0xfe00;
+			vc->vc_attr_shift_pos = 9;
+		}
+#endif
+	}
 	if (!vc->vc_complement_mask)
-		vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
+		vc->vc_complement_mask = (vc->vc_can_do_color ? 0x77 : 0x08)
+			<< vc->vc_attr_shift_pos;
 	vc->vc_s_complement_mask = vc->vc_complement_mask;
-	vc->vc_size_row = vc->vc_cols << 1;
+	vc->vc_size_row = vc->vc_cols * GLYPH_SZ;
 	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
 }
 
-
 static void visual_deinit(struct vc_data *vc)
 {
 	vc->vc_sw->con_deinit(vc);
@@ -1175,11 +1189,30 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
 	unsigned short *oldscreen, *newscreen;
 	u32 **new_uniscr = NULL;
-
+	unsigned int new_vc_char_mask = vc->vc_char_mask;
+	unsigned int new_vc_attr_mask = vc->vc_attr_mask;
+	unsigned int new_vc_attr_shift_pos = vc->vc_attr_shift_pos;
+	unsigned int new_vc_video_erase_char = vc->vc_video_erase_char;
 	WARN_CONSOLE_UNLOCKED();
 
 	if (cols > VC_MAXCOL || lines > VC_MAXROW)
 		return -EINVAL;
 
+#ifndef CONFIG_FB_GLYPH_21BIT
+	if (vc->vc_hi_font_mask == 0x100) {
+		new_vc_char_mask = 0x1ff;
+		new_vc_attr_mask = 0xfe00;
+		new_vc_attr_shift_pos = 9;
+	} else {
+		new_vc_char_mask = 0xff;
+		new_vc_attr_mask = 0xff00;
+		new_vc_attr_shift_pos = 8;
+	}
+#endif
+	new_vc_video_erase_char =
+		(vc->vc_video_erase_char & vc->vc_char_mask) |
+		((vc->vc_video_erase_char >> vc->vc_attr_shift_pos) <<
+		 new_vc_attr_shift_pos);
+
 	new_cols = (cols ? cols : vc->vc_cols);
 	new_rows = (lines ? lines : vc->vc_rows);
@@ -2114,8 +2164,10 @@ static void csi_RSB(struct vc_data *vc)
 		break;
 	case CSI_RSB_MAKE_CUR_COLOR_DEFAULT:
 		vc->vc_def_color = vc->vc_attr;
+#ifndef CONFIG_FB_GLYPH_21BIT
 		if (vc->vc_hi_font_mask == 0x100)
 			vc->vc_def_color >>= 1;
+#endif
 		default_attr(vc);
 		update_attr(vc);
 		break;
@@ -2856,11 +2908,13 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		if (c == '8') {
 			/* DEC screen alignment test. kludge :-) */
 			vc->vc_video_erase_char =
-				(vc->vc_video_erase_char & 0xff00) | 'E';
+				(vc->vc_video_erase_char & vc->vc_attr_mask) | 'E';
 			csi_J(vc, CSI_J_VISIBLE);
 			vc->vc_video_erase_char =
-				(vc->vc_video_erase_char & 0xff00) | ' ';
-			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
+				(vc->vc_video_erase_char & vc->vc_attr_mask) | ' ';
+			do_update_region(vc, vc->vc_origin,
+					 vc->vc_screenbuf_size /
+					 GLYPH_SZ);
 		}
 		return;
 	case ESsetG0:	/* ESC ( */
@@ -3021,10 +3076,12 @@ static inline unsigned char vc_invert_attr(const struct vc_data *vc)
 	if (!vc->vc_can_do_color)
 		return vc->vc_attr ^ 0x08;
 
+#ifndef CONFIG_FB_GLYPH_21BIT
 	if (vc->vc_hi_font_mask == 0x100)
 		return   (vc->vc_attr & 0x11) |
 			((vc->vc_attr & 0xe0) >> 4) |
 			((vc->vc_attr & 0x0e) << 4);
+#endif
 
 	return   (vc->vc_attr & 0x88) |
 		((vc->vc_attr & 0x70) >> 4) |
@@ -3153,16 +3210,15 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 static int vc_get_glyph(struct vc_data *vc, int tc)
 {
 	int glyph = conv_uni_to_pc(vc, tc);
-	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 
-	if (!(glyph & ~charmask))
+	if (!(glyph & ~vc->vc_char_mask))
 		return glyph;
 
 	if (glyph == -1)
 		return -1; /* nothing to display */
 
 	/* Glyph not found */
-	if ((!vc->vc_utf || vc->vc_disp_ctrl || tc < 128) && !(tc & ~charmask)) {
+	if ((!vc->vc_utf || vc->vc_disp_ctrl || tc < 128) && !(tc & ~vc->vc_char_mask)) {
 		/*
 		 * In legacy mode use the glyph we get by a 1:1 mapping.
 		 * This would make absolutely no sense with Unicode in mind, but do this for
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 65681dcc5930..84e073162311 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -77,8 +77,8 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				     u32 d_pitch, u32 s_pitch, u32 cellsize,
 				     struct fb_image *image, u8 *buf, u8 *dst)
 {
-	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int charcnt = vc->vc_font.charcount;
+	u32 charmask = vc->vc_char_mask;
 	u32 idx = vc->vc_font.width >> 3;
 	const u8 *src;
 
@@ -114,8 +113,8 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 				       struct fb_image *image, u8 *buf,
 				       u8 *dst)
 {
-	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int charcnt = vc->vc_font.charcount;
+	u32 charmask = vc->vc_char_mask;
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
@@ -261,7 +260,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 {
 	struct fb_cursor cursor;
 	struct fbcon_par *par = info->fbcon_par;
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	unsigned int charmask = vc->vc_char_mask;
 	int w = DIV_ROUND_UP(vc->vc_font.width, 8), c;
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9f5c4c101581..18fbf7cf11dd 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -319,14 +319,14 @@ static int get_color(struct vc_data *vc, struct fb_info *info,
 	int color = 0;
 
 	if (console_blanked) {
-		unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+		unsigned int charmask = vc->vc_char_mask;
 
 		c = vc->vc_video_erase_char & charmask;
 	}
 
 	if (depth != 1)
-		color = (is_fg) ? attr_fgcol((vc->vc_hi_font_mask) ? 9 : 8, c)
-			: attr_bgcol((vc->vc_hi_font_mask) ? 13 : 12, c);
+		color = (is_fg) ? ((c >> vc->vc_attr_shift_pos) & 0x0f)
+			: (c >> (vc->vc_attr_shift_pos + 4));
 
 	switch (depth) {
 	case 1:
@@ -1150,14 +1157,8 @@ static void fbcon_init(struct vc_data *vc, bool init)
 	}
 
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
-	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
-	if (vc->vc_font.charcount == 256) {
-		vc->vc_hi_font_mask = 0;
-	} else {
-		vc->vc_hi_font_mask = 0x100;
-		if (vc->vc_can_do_color)
-			vc->vc_complement_mask <<= 1;
-	}
+	vc->vc_complement_mask = (vc->vc_can_do_color ? 0x77 : 0x08) <<
+		(vc->vc_attr_shift_pos ? vc->vc_attr_shift_pos : 8);
 
 	if (!*svc->uni_pagedict_loc)
 		con_set_default_unimap(svc);
@@ -1242,7 +1244,9 @@ static void fbcon_free_font(struct fbcon_display *p)
 	}
 }
 
+#ifndef CONFIG_FB_GLYPH_21BIT
 static void set_vc_hi_font(struct vc_data *vc, bool set);
+#endif
 
 static void fbcon_release_all(void)
 {
@@ -1298,8 +1302,10 @@ static void fbcon_deinit(struct vc_data *vc)
 	fbcon_free_font(p);
 	vc->vc_font.data = NULL;
 
+#ifndef CONFIG_FB_GLYPH_21BIT
 	if (vc->vc_hi_font_mask && vc->vc_screenbuf)
 		set_vc_hi_font(vc, false);
+#endif
 
 	if (!con_is_bound(&fb_con))
 		fbcon_release_all();
@@ -1471,16 +1477,28 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	var->xoffset = info->var.xoffset;
 	fb_set_var(info, var);
 	par->var = info->var;
-	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
-	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
+#ifdef CONFIG_FB_GLYPH_21BIT
+	vc->vc_hi_font_mask = 0;
+	vc->vc_char_mask = 0x1fffff;
+	vc->vc_attr_mask = 0xff000000;
+	vc->vc_attr_shift_pos = 24;
+#else
 	if (vc->vc_font.charcount == 256) {
 		vc->vc_hi_font_mask = 0;
+		vc->vc_char_mask = 0xff;
+		vc->vc_attr_mask = 0xff00;
+		vc->vc_attr_shift_pos = 8;
 	} else {
 		vc->vc_hi_font_mask = 0x100;
-		if (vc->vc_can_do_color)
-			vc->vc_complement_mask <<= 1;
+		vc->vc_char_mask = 0x1ff;
+		vc->vc_attr_mask = 0xfe00;
+		vc->vc_attr_shift_pos = 9;
 	}
+#endif
 
+	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix) != 1);
+	vc->vc_complement_mask = (vc->vc_can_do_color ? 0x77 : 0x08) <<
+		(vc->vc_attr_shift_pos ? vc->vc_attr_shift_pos : 8);
 	if (!*svc->uni_pagedict_loc)
 		con_set_default_unimap(svc);
 	if (!*vc->uni_pagedict_loc)
@@ -2220,10 +2258,8 @@ static bool fbcon_switch(struct vc_data *vc)
 	}
 
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
-	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
-
-	if (vc->vc_font.charcount > 256)
-		vc->vc_complement_mask <<= 1;
+	vc->vc_complement_mask = (vc->vc_can_do_color ? 0x77 : 0x08) <<
+		(vc->vc_attr_shift_pos ? vc->vc_attr_shift_pos : 8);
 
 	updatescrollmode(p, info, vc);
 
@@ -2270,9 +2306,8 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 				int blank)
 {
 	if (blank) {
-		unsigned short charmask = vc->vc_hi_font_mask ?
-			0x1ff : 0xff;
-		unsigned short oldc;
+		unsigned int charmask = vc->vc_char_mask;
+		unsigned int oldc;
 
 		oldc = vc->vc_video_erase_char;
 		vc->vc_video_erase_char &= charmask;
@@ -2336,11 +2373,15 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigned int vpitch)
 	return font_data_export(p->fontdata, font, vpitch);
 }
 
+#ifndef CONFIG_FB_GLYPH_21BIT
 /* set/clear vc_hi_font_mask and update vc attrs accordingly */
 static void set_vc_hi_font(struct vc_data *vc, bool set)
 {
 	if (!set) {
 		vc->vc_hi_font_mask = 0;
+		vc->vc_attr_mask = 0xff00;
+		vc->vc_char_mask = 0xff;
+		vc->vc_attr_shift_pos = 8;
 		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask >>= 1;
 			vc->vc_s_complement_mask >>= 1;
@@ -2406,7 +2452,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	int resize, ret, old_width, old_height, old_charcount;
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
+#ifndef CONFIG_FB_GLYPH_21BIT
 	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
+#endif
 
 	font_data_get(data);
 
@@ -2453,11 +2504,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	vc->vc_font.height = old_height;
 	vc->vc_font.charcount = old_charcount;
 
+#ifndef CONFIG_FB_GLYPH_21BIT
 	/* Restore the hi_font state and screen buffer */
 	if (old_hi_font_mask && !vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, true);
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
+#endif
 
 	font_data_put(data);
 
@@ -2583,19 +2645,23 @@ static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 
 /* As we might be inside of softback, we may work with non-contiguous buffer,
    that's why we have to use a separate routine. */
-static void fbcon_invert_region(struct vc_data *vc, u16 * p, int cnt)
+static void fbcon_invert_region(struct vc_data *vc, u16 *p, int cnt)
 {
+	u32 attr;
+
 	while (cnt--) {
-		u16 a = scr_readw(p);
+		u32 a = scr_readg(p);
+
+		attr = a >> vc->vc_attr_shift_pos;
 		if (!vc->vc_can_do_color)
-			a ^= 0x0800;
-		else if (vc->vc_hi_font_mask == 0x100)
-			a = ((a) & 0x11ff) | (((a) & 0xe000) >> 4) |
-			    (((a) & 0x0e00) << 4);
+			attr ^= 0x08;
 		else
-			a = ((a) & 0x88ff) | (((a) & 0x7000) >> 4) |
-			    (((a) & 0x0700) << 4);
-		scr_writew(a, p++);
+			attr = (attr & 0x88) |
+				((attr & 0x70) >> 4) |
+				((attr & 0x07) << 4);
+		a = (a & vc->vc_char_mask) |
+			(attr << vc->vc_attr_shift_pos);
+		scr_writeg_plusplus(a, p++);
 	}
 }
 
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 407d207b14f1..5aaef363a343 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -105,12 +105,6 @@ struct fbcon_par {
      *  Attribute Decoding
      */
 
-/* Color */
-#define attr_fgcol(fgshift,s)    \
-	(((s) >> (fgshift)) & 0x0f)
-#define attr_bgcol(bgshift,s)    \
-	(((s) >> (bgshift)) & 0x0f)
-
 /* Monochrome */
 #define attr_bold(s) \
 	((s) & 0x200)
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fe915afdece5..5afce52057ca 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -144,13 +153,16 @@ struct vc_data {
 	unsigned char	vc_halfcolor;		/* Color for half intensity mode */
 	/* cursor */
 	unsigned int	vc_cursor_type;
-	unsigned short	vc_complement_mask;	/* [#] Xor mask for mouse pointer */
-	unsigned short	vc_s_complement_mask;	/* Saved mouse pointer mask */
+	unsigned int	vc_complement_mask;	/* [#] Xor mask for mouse pointer */
+	unsigned int	vc_s_complement_mask;	/* Saved mouse pointer mask */
 	unsigned long	vc_pos;			/* Cursor address */
 	/* fonts */
 	unsigned short	vc_hi_font_mask;	/* [#] Attribute set for upper 256 chars of font or 0 if not supported */
-	struct vc_font vc_font;			/* Current VC font set */
-	unsigned short	vc_video_erase_char;	/* Background erase character */
+	unsigned int	vc_char_mask;		/* Character mask.  0x1fffff, 0x1ff, or 0xff. */
+	unsigned int	vc_attr_mask;		/* Attribute mask.  0xff000000, 0xfe00, 0xff00. */
+	unsigned int	vc_attr_shift_pos;	/* Position of 8-bit attributes: 24, 9, or 8. */
+	struct vc_font	vc_font;		/* Current VC font set */
+	unsigned int	vc_video_erase_char;	/* Background erase character */
 	/* VT terminal data */
 	unsigned int	vc_state;		/* Escape sequence parser state */
 	unsigned int	vc_npar,vc_par[NPAR];	/* Parameters of current escape sequence */
@@ -217,9 +229,18 @@ extern void vc_SAK(struct work_struct *work);
 #define CUR_SW				0x000010
 #define CUR_ALWAYS_BG			0x000020
 #define CUR_INVERT_FG_BG		0x000040
+
+#ifdef CONFIG_FB_GLYPH_21BIT
+#define CUR_FG (0x07 << vc->vc_attr_shift_pos)
+#define CUR_BG (0x70 << vc->vc_attr_shift_pos)
+#define CUR_TYPE_CHANGE			0x00ff00
+#define CUR_CHANGE(c) (((c) & CUR_TYPE_CHANGE) << (vc->vc_attr_shift_pos - 8))
+#else
 #define CUR_FG				0x000700
 #define CUR_BG				0x007000
 #define CUR_CHANGE(c)		 ((c) & 0x00ff00)
+#endif
+
 #define CUR_SET(c)		(((c) & 0xff0000) >> 8)
 
 bool con_is_visible(const struct vc_data *vc);


-- 
Alan Mackenzie (Nuremberg, Germany).
