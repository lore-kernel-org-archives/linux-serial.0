Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753814C9564
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856431; cv=none; b=pDAPCH0Adh1Patg+o+DhybNKM9ykWYrRHhsY10aDlfd8VA4so/a/TBLHOVnxKmDFYVGO7iWsw7M/ELngg8+s2WuBtGd/qyQaWNVBZOs7h20FhhM4Ma6m3EO4ZSqZ9Gz0ZlKObzxsfKaDQN15qS2ekwezAgjTwcGWckAU6qS0Q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856431; c=relaxed/simple;
	bh=5sEG2Kwa6SgLSIQ9fPoms19pSd37nFKyC+H6n1dG9mo=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=Gu6lhsNGagq6QKsvtbbLFkq4UpCBCtaEBJRbttnvOWsoYxrMDMwdI5r0AaMRP2Jkiw9QWHXwUNeBkXM29aqLdlgXXgX6rPTsCAOn2s9Ld+DrKV53oRzQhfwXYL9NSVjiaQv7PXRh2nB7XDs3u8tvyAQHHBTTc/6kkLMWR0VbRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 17187 invoked by uid 3782); 27 Aug 2026 20:47:06 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 20:47:06 +0200
Received: (qmail 31034 invoked by uid 1000); 27 Aug 2026 18:47:05 -0000
Date: Thu, 27 Aug 2026 18:47:05 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: acm@muc.de
Subject: [Patch 3/9]: Replace scr_readw/writew by scr_readg/writeg, etc
Message-ID: <apCGKUotSUZLvngV@MAC.fritz.box>
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


vt: 32b glyph: 3. replace scr_readw/writew by scr_readg/writeg, etc.

The former are hardcoded to work with 16-bit glyphs, the latter
handle glyphs correctly regardless of whether they are 16-bit
or 32-bit.  Introduce scr_readg/writeg_plusplus correctly to
handle post-increment operands for these functions.

Signed-off-by: Alan Mackenzie <acm@muc.de>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..0c389a564357 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -547,7 +548,7 @@ int vc_uniscr_check(struct vc_data *vc)
 	for (y = 0; y < vc->vc_rows; y++) {
 		u32 *line = uni_lines[y];
 		for (x = 0; x < vc->vc_cols; x++) {
-			u16 glyph = scr_readw(p++) & mask;
+			u32 glyph = scr_readg_plusplus(p++) & vc->vc_char_mask;
 			line[x] = inverse_translate(vc, glyph, true);
 		}
 	}
@@ -593,7 +595,7 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 		int mask = vc->vc_hi_font_mask | 0xff;
 		u32 *uni_buf = dest;
 		while (nr--) {
-			u16 glyph = scr_readw(p++) & mask;
+			u32 glyph = scr_readg_plusplus(p++) & mask;
 			*uni_buf++ = inverse_translate(vc, glyph, true);
 		}
 	}
@@ -624,7 +626,7 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
 		swap(src, dst);
 	}
 	scr_memmovew(dst, src, (rows - nr) * vc->vc_size_row);
-	scr_memsetw(clear, vc->vc_video_erase_char, vc->vc_size_row * nr);
+	scr_memset_worl(clear, vc->vc_video_erase_char, vc->vc_size_row * nr);
 }
 
 static void do_update_region(struct vc_data *vc, unsigned long start, int count)
@@ -637,18 +639,20 @@ static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 	yy = offset / vc->vc_cols;
 
 	for(;;) {
-		u16 attrib = scr_readw(p) & 0xff00;
+		u32 attrib = scr_readg(p) & vc->vc_attr_mask;
 		int startx = xx;
 		u16 *q = p;
 		while (xx < vc->vc_cols && count) {
-			if (attrib != (scr_readw(p) & 0xff00)) {
+			if (attrib != (scr_readg(p) & vc->vc_attr_mask)) {
 				if (p > q)
-					vc->vc_sw->con_putcs(vc, q, p-q, yy, startx);
+					vc->vc_sw->con_putcs(vc, q,
+							     (p-q) / GLYPH_HW,
+							     yy, startx);
 				startx = xx;
 				q = p;
-				attrib = scr_readw(p) & 0xff00;
+				attrib = scr_readg(p) & vc->vc_attr_mask;
 			}
-			p++;
+			p += GLYPH_HW;
 			xx++;
 			count--;
 		}
@@ -789,7 +780,7 @@ void complement_pos(struct vc_data *vc, int offset)
 
 	if (old_offset != -1 && old_offset >= 0 &&
 	    old_offset < vc->vc_screenbuf_size) {
-		scr_writew(old, screenpos(vc, old_offset, true));
+		scr_writeg(old, screenpos(vc, old_offset, true));
 		if (con_should_update(vc))
 			con_putc(vc, old, oldy, oldx);
 		notify_update(vc);
@@ -799,14 +790,14 @@ void complement_pos(struct vc_data *vc, int offset)
 
 	if (offset != -1 && offset >= 0 &&
 	    offset < vc->vc_screenbuf_size) {
-		unsigned short new;
+		unsigned int new;
 		u16 *p = screenpos(vc, offset, true);
-		old = scr_readw(p);
+		old = scr_readg(p);
 		new = old ^ vc->vc_complement_mask;
-		scr_writew(new, p);
+		scr_writeg(new, p);
 		if (con_should_update(vc)) {
-			oldx = (offset >> 1) % vc->vc_cols;
-			oldy = (offset >> 1) / vc->vc_cols;
+			oldx = (offset / GLYPH_SZ) % vc->vc_cols;
+			oldy = (offset / GLYPH_SZ) / vc->vc_cols;
 			con_putc(vc, new, oldy, oldx);
 		}
 		notify_update(vc);
@@ -844,7 +837,7 @@ static int softcursor_original = -1;
 
 static void add_softcursor(struct vc_data *vc)
 {
-	int i = scr_readw((u16 *) vc->vc_pos);
+	int i = scr_readg((u16 *) vc->vc_pos);
 	u32 type = vc->vc_cursor_type;
 
 	if (!(type & CUR_SW))
@@ -859,7 +852,7 @@ static void add_softcursor(struct vc_data *vc)
 		i ^= CUR_BG;
 	if ((type & CUR_INVERT_FG_BG) && (i & CUR_FG) == ((i & CUR_BG) >> 4))
 		i ^= CUR_FG;
-	scr_writew(i, (u16 *)vc->vc_pos);
+	scr_writeg(i, (u16 *)vc->vc_pos);
 	if (con_should_update(vc))
 		con_putc(vc, i, vc->state.y, vc->state.x);
 }
@@ -867,7 +860,7 @@ static void add_softcursor(struct vc_data *vc)
 static void hide_softcursor(struct vc_data *vc)
 {
 	if (softcursor_original != -1) {
-		scr_writew(softcursor_original, (u16 *)vc->vc_pos);
+		scr_writeg(softcursor_original, (u16 *)vc->vc_pos);
 		if (con_should_update(vc))
 			con_putc(vc, softcursor_original, vc->state.y,
 				 vc->state.x);
@@ -946,11 +939,12 @@ static void flush_scrollback(struct vc_data *vc)
 void clear_buffer_attributes(struct vc_data *vc)
 {
 	unsigned short *p = (unsigned short *)vc->vc_origin;
-	int count = vc->vc_screenbuf_size / 2;
-	int mask = vc->vc_hi_font_mask | 0xff;
+	int count = vc->vc_screenbuf_size / GLYPH_SZ;
+	unsigned int mask = vc->vc_char_mask;
 
-	for (; count > 0; count--, p++) {
-		scr_writew((scr_readw(p)&mask) | (vc->vc_video_erase_char & ~mask), p);
+	for (; count > 0; count--, p += GLYPH_HW) {
+		scr_writeg((scr_readg(p)&mask) |
+			   (vc->vc_video_erase_char & ~mask), p);
 	}
 }
 
@@ -3231,11 +3287,10 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		vc_uniscr_putc(vc, next_c);
 
 		if (himask)
-			tc = ((tc & 0x100) ? himask : 0) |
-			      (tc &  0xff);
-		tc |= (vc_attr << 8) & ~himask;
+			tc = tc & vc->vc_char_mask;
+		tc |= (vc_attr << vc->vc_attr_shift_pos);
 
-		scr_writew(tc, (u16 *)vc->vc_pos);
+		scr_writeg(tc, (u16 *)vc->vc_pos);
 
 		if (con_should_update(vc) && draw->x < 0) {
 			draw->x = vc->state.x;
@@ -3502,7 +3557,8 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 				continue;
 		}
 		vc_uniscr_putc(vc, c);
-		scr_writew((vc->vc_attr << 8) + c, (unsigned short *)vc->vc_pos);
+		scr_writeg((vc->vc_attr << vc->vc_attr_shift_pos) + c,
+			   (unsigned short *)vc->vc_pos);
 		notify_write(vc, c);
 		cnt++;
 		if (vc->state.x == vc->vc_cols - 1) {
@@ -5047,13 +5110,10 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
  */
 
 /* used by selection */
-u16 screen_glyph(const struct vc_data *vc, int offset)
+u32 screen_glyph(const struct vc_data *vc, int offset)
 {
-	u16 w = scr_readw(screenpos(vc, offset, true));
-	u16 c = w & 0xff;
-
-	if (w & vc->vc_hi_font_mask)
-		c |= 0x100;
+	u32 w = scr_readg(screenpos(vc, offset, true));
+	u32 c = w & vc->vc_char_mask;
 	return c;
 }
 EXPORT_SYMBOL_GPL(screen_glyph);
@@ -5090,16 +5151,16 @@ void putconsxy(struct vc_data *vc, unsigned char xy[static const 2])
 	set_cursor(vc);
 }
 
-u16 vcs_scr_readw(const struct vc_data *vc, const u16 *org)
+u32 vcs_scr_readw(const struct vc_data *vc, const u16 *org)
 {
 	if ((unsigned long)org == vc->vc_pos && softcursor_original != -1)
 		return softcursor_original;
-	return scr_readw(org);
+	return scr_readg(org);
 }
 
-void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org)
+void vcs_scr_writew(struct vc_data *vc, u32 val, u16 *org)
 {
-	scr_writew(val, org);
+	scr_writeg(val, org);
 	if ((unsigned long)org == vc->vc_pos) {
 		softcursor_original = -1;
 		add_softcursor(vc);
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 65681dcc5930..84e073162311 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -83,12 +83,11 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	const u8 *src;
 
 	while (cnt--) {
-		u16 ch = scr_readw(s++) & charmask;
+		u32 ch = scr_readg_plusplus(s++) & charmask;
 
 		if (ch >= charcnt)
 			ch = 0;
-		src = vc->vc_font.data + (unsigned int)ch * cellsize;
-
+		src = vc->vc_font.data + ch * cellsize;
 		if (attr) {
 			update_attr(buf, src, attr, vc);
 			src = buf;
@@ -122,7 +121,7 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 	const u8 *src;
 
 	while (cnt--) {
-		u16 ch = scr_readw(s++) & charmask;
+		u32 ch = scr_readg_plusplus(s++) & charmask;
 
 		if (ch >= charcnt)
 			ch = 0;
@@ -157,7 +156,7 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 scan_align = info->pixmap.scan_align - 1;
 	u32 buf_align = info->pixmap.buf_align - 1;
 	u32 mod = vc->vc_font.width % 8, cnt, pitch, size;
-	u32 attribute = get_attribute(info, scr_readw(s));
+	u32 attribute = get_attribute(info, scr_readg(s));
 	u8 *dst, *buf = NULL;
 
 	image.fg_color = fg;
@@ -273,7 +272,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	if (!vc->vc_font.data)
 		return;
 
- 	c = scr_readw((u16 *) vc->vc_pos);
+	c = scr_readg((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
 	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9f5c4c101581..18fbf7cf11dd 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -418,7 +418,7 @@ static void fb_flashcursor(struct work_struct *work)
 		return;
 	}
 
-	c = scr_readw((u16 *) vc->vc_pos);
+	c = scr_readg((u16 *) vc->vc_pos);
 	enable = par->cursor_flash && !par->cursor_state.enable;
 	par->bitops->cursor(vc, info, enable,
 			    get_fg_color(vc, info, c),
@@ -663,7 +663,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 	q = (unsigned short *) (vc->vc_origin +
 				vc->vc_size_row * rows);
 	step = logo_lines * cols;
-	for (r = q - logo_lines * cols; r < q; r++)
-		if (scr_readw(r) != vc->vc_video_erase_char)
+	for (r = q - logo_lines * cols * GLYPH_HW; r < q; r++)
+		if (scr_readg(r) != vc->vc_video_erase_char)
 			break;
 	if (r != q && new_rows >= rows + logo_lines) {
@@ -695,9 +701,9 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 			vc->vc_pos += lines * vc->vc_size_row;
 		}
 	}
-	scr_memsetw((unsigned short *) vc->vc_origin,
-		    erase,
-		    vc->vc_size_row * logo_lines);
+	scr_memset_worl((unsigned short *) vc->vc_origin,
+			erase,
+			vc->vc_size_row * logo_lines);
 
 	if (con_is_visible(vc) && vc->vc_mode == KD_TEXT) {
 		fbcon_clear_margins(vc, 0);
@@ -1390,8 +1396,8 @@ static void fbcon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 
 	if (fbcon_is_active(vc, info))
 		par->bitops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
-				   get_fg_color(vc, info, scr_readw(s)),
-				   get_bg_color(vc, info, scr_readw(s)));
+				   get_fg_color(vc, info, scr_readg(s)),
+				   get_bg_color(vc, info, scr_readg(s)));
 }
 
 static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
@@ -1407,7 +1413,7 @@ static void fbcon_cursor(struct vc_data *vc, bool enable)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_par *par = info->fbcon_par;
- 	int c = scr_readw((u16 *) vc->vc_pos);
+	int c = scr_readg((u16 *) vc->vc_pos);
 
 	par->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 
@@ -1645,19 +1663,21 @@ static void fbcon_redraw_move(struct vc_data *vc, struct fbcon_display *p,
 
 		do {
-			c = scr_readw(s);
-			if (attr != (c & 0xff00)) {
-				attr = c & 0xff00;
+			c = scr_readg(s);
+			if (attr != (c & vc->vc_attr_mask)) {
+				attr = c & vc->vc_attr_mask;
 				if (s > start) {
-					fbcon_putcs(vc, start, s - start,
+					fbcon_putcs(vc, start,
+						    (s - start) / GLYPH_HW,
 						    dy, x);
-					x += s - start;
+					x += (s - start) / GLYPH_HW;
 					start = s;
 				}
 			}
-			s++;
+			s += GLYPH_HW;
 		} while (s < le);
 		if (s > start)
-			fbcon_putcs(vc, start, s - start, dy, x);
+			fbcon_putcs(vc, start, (s - start) / GLYPH_HW,
+				    dy, x);
 		dy++;
 	}
 }
@@ -1674,31 +1694,31 @@ static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
 	while (count--) {
 		unsigned short *start = s;
 		unsigned short *le = advance_row(s, 1);
-		unsigned short c;
+		unsigned int c;
 		int x = 0;
 
 		do {
-			c = scr_readw(s);
+			c = scr_readg(s);
 
-			if (c == scr_readw(d)) {
+			if (c == scr_readg(d)) {
 				if (s > start) {
 					par->bitops->bmove(vc, info, line + ycount, x,
-							   line, x, 1, s - start);
-					x += s - start + 1;
-					start = s + 1;
+							   line, x, 1,
+							   (s - start) / GLYPH_HW);
+					x += (s - start) / GLYPH_HW + 1;
+					start = s + GLYPH_HW;
 				} else {
 					x++;
-					start++;
+					start += GLYPH_HW;
 				}
 			}
 
-			scr_writew(c, d);
-			s++;
-			d++;
+			scr_writeg_plusplus(c, d++);
+			s += GLYPH_HW;
 		} while (s < le);
 		if (s > start)
 			par->bitops->bmove(vc, info, line + ycount, x, line, x, 1,
-					     s - start);
+					   (s - start) / GLYPH_HW);
 		if (ycount > 0)
 			line++;
 		else {
@@ -1725,32 +1745,34 @@ static void fbcon_redraw(struct vc_data *vc, int line, int count, int offset)
 
 		do {
-			c = scr_readw(s);
-			if (attr != (c & 0xff00)) {
-				attr = c & 0xff00;
+			c = scr_readg(s);
+			if (attr != (c & vc->vc_attr_mask)) {
+				attr = c & vc->vc_attr_mask;
 				if (s > start) {
-					fbcon_putcs(vc, start, s - start,
+					fbcon_putcs(vc, start,
+						    (s - start) / GLYPH_HW,
 						    line, x);
-					x += s - start;
+					x += (s - start) / GLYPH_HW;
 					start = s;
 				}
 			}
-			if (c == scr_readw(d)) {
+			if (c == scr_readg(d)) {
 				if (s > start) {
-					fbcon_putcs(vc, start, s - start,
-						     line, x);
-					x += s - start + 1;
-					start = s + 1;
+					fbcon_putcs(vc, start,
+						    (s - start) / GLYPH_HW,
+						    line, x);
+					x += (s - start) / GLYPH_HW + 1;
+					start = s + GLYPH_HW;
 				} else {
 					x++;
-					start++;
+					start += GLYPH_HW;
 				}
 			}
-			scr_writew(c, d);
-			s++;
-			d++;
+			scr_writeg_plusplus(c, d++);
+			s += GLYPH_HW;
 		} while (s < le);
 		if (s > start)
-			fbcon_putcs(vc, start, s - start, line, x);
+			fbcon_putcs(vc, start, (s - start) / GLYPH_HW,
+				    line, x);
 		if (offset > 0)
 			line++;
 		else {
@@ -1854,7 +1876,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			fbcon_redraw_blit(vc, info, p, t, b - t - count,
 				     count);
 			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
-			scr_memsetw((unsigned short *) (vc->vc_origin +
+			scr_memset_worl((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							(b - count)),
 				    vc->vc_video_erase_char,
@@ -1925,7 +1947,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			fbcon_redraw(vc, t, b - t - count,
 				     count * vc->vc_cols);
 			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
-			scr_memsetw((unsigned short *) (vc->vc_origin +
+			scr_memset_worl((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							(b - count)),
 				    vc->vc_video_erase_char,
@@ -1942,7 +1964,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			fbcon_redraw_blit(vc, info, p, b - 1, b - t - count,
 				     -count);
 			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
-			scr_memsetw((unsigned short *) (vc->vc_origin +
+			scr_memset_worl((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							t),
 				    vc->vc_video_erase_char,
@@ -2011,7 +2033,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			fbcon_redraw(vc, b - 1, b - t - count,
 				     -count * vc->vc_cols);
 			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
-			scr_memsetw((unsigned short *) (vc->vc_origin +
+			scr_memset_worl((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							t),
 				    vc->vc_video_erase_char,
@@ -2155,8 +2178,23 @@ static bool fbcon_switch(struct vc_data *vc)
 		struct vc_data *conp2 = vc_cons[logo_shown].d;
 
 		if (conp2->vc_top == logo_lines
-		    && conp2->vc_bottom == conp2->vc_rows)
+		    && conp2->vc_bottom == conp2->vc_rows) {
+			/* Scroll the bottom part of the screen up to fill the
+			 * logo lines.
+			 */
+			i = conp2->vc_bottom - conp2->vc_top;
+			d = (unsigned short *)conp2->vc_origin;
+			s = (unsigned short *)(conp2->vc_origin +
+					       logo_lines * conp2->vc_size_row);
+			while (i--) {
+				scr_memcpyw(d, s, conp2->vc_size_row);
+				d += conp2->vc_cols;
+				s += conp2->vc_cols;
+			}
+			scr_memset_worl(d, conp2->vc_video_erase_char,
+				    conp2->vc_size_row * logo_lines);
 			conp2->vc_top = 0;
+		}
 		logo_shown = FBCON_LOGO_CANSHOW;
 	}
 
@@ -2350,20 +2391,23 @@ static void set_vc_hi_font(struct vc_data *vc, bool set)
 		if (vc->vc_can_do_color) {
 			unsigned short *cp =
 			    (unsigned short *) vc->vc_origin;
-			int count = vc->vc_screenbuf_size / 2;
-			unsigned short c;
-			for (; count > 0; count--, cp++) {
-				c = scr_readw(cp);
-				scr_writew(((c & 0xfe00) >> 1) |
-					   (c & 0xff), cp);
+			int count = vc->vc_screenbuf_size / GLYPH_SZ;
+			unsigned int c;
+
+			for (; count > 0; count--) {
+				c = scr_readg(cp);
+				scr_writeg_plusplus(((c & 0xfe00) >> 1) |
+						    (c & 0xff), cp++);
 			}
 			c = vc->vc_video_erase_char;
 			vc->vc_video_erase_char =
 			    ((c & 0xfe00) >> 1) | (c & 0xff);
-			vc->vc_attr >>= 1;
 		}
 	} else {
 		vc->vc_hi_font_mask = 0x100;
+		vc->vc_attr_mask = 0xfe00;
+		vc->vc_char_mask = 0x1ff;
+		vc->vc_attr_shift_pos = 9;
 		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask <<= 1;
 			vc->vc_s_complement_mask <<= 1;
@@ -2373,29 +2417,31 @@ static void set_vc_hi_font(struct vc_data *vc, bool set)
 		{
 			unsigned short *cp =
 			    (unsigned short *) vc->vc_origin;
-			int count = vc->vc_screenbuf_size / 2;
-			unsigned short c;
-			for (; count > 0; count--, cp++) {
-				unsigned short newc;
-				c = scr_readw(cp);
+			int count = vc->vc_screenbuf_size / GLYPH_SZ;
+			unsigned int c;
+
+			for (; count > 0; count--) {
+				unsigned int newc;
+
+				c = scr_readg(cp);
 				if (vc->vc_can_do_color)
 					newc =
 					    ((c & 0xff00) << 1) | (c &
 								   0xff);
 				else
 					newc = c & ~0x100;
-				scr_writew(newc, cp);
+				scr_writeg_plusplus(newc, cp++);
 			}
 			c = vc->vc_video_erase_char;
-			if (vc->vc_can_do_color) {
+			if (vc->vc_can_do_color)
 				vc->vc_video_erase_char =
 				    ((c & 0xff00) << 1) | (c & 0xff);
-				vc->vc_attr <<= 1;
-			} else
+			else
 				vc->vc_video_erase_char = c & ~0x100;
 		}
 	}
 }
+#endif
 
 static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 			     font_data_t *data)
diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index 6c15c6a15f74..714ce5f75c7e 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -25,6 +25,32 @@
 #define scr_readw(addr) (*(addr))
 #endif
 
+#ifdef CONFIG_FB_GLYPH_21BIT
+#define scr_writeg(val, addr)			\
+	(*((u32 *)(addr)) = (val))
+#define scr_readg(addr)				\
+	(*((u32 *)(addr)))
+/* The following two macros must be invoked with ADDR being a post-increment
+ * of a u16 *variable.  The pointer will be correctly incremented by 4 bytes.
+ */
+#define scr_writeg_plusplus(val, addr)		\
+	do {					\
+		*((u32 *)(addr)) = (val);	\
+		(addr);				\
+	} while (0)
+#define scr_readg_plusplus(addr)		\
+	(*(u32 *)((addr), ((addr) - 1)))
+#else
+#define scr_writeg(val, addr) scr_writew(val, addr)
+#define scr_readg(addr) scr_readw(addr)
+
+/* The following two macros must be invoked with ADDR being a post-increment
+ * of a u16 *variable.  The pointer will be correctly incremented by 2 bytes.
+ */
+#define scr_writeg_plusplus(val, addr) scr_writew(val, addr)
+#define scr_readg_plusplus(addr) scr_readw(addr)
+#endif
+
 #ifndef VT_BUF_HAVE_MEMSETW
 static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
 {
@@ -46,4 +72,17 @@ static inline void scr_memmovew(u16 *d, const u16 *s, unsigned int count)
 }
 #endif
 
+static inline void scr_memsetl(u16 *s, u32 c, unsigned int count)
+{
+	count /= 4;
+	memset32((u32 *)s, c, count);
+}
+
+#ifdef CONFIG_FB_GLYPH_21BIT
+#define scr_memset_worl(s, c, count)		\
+	scr_memsetl((s), (c), (count))
+#else
+#define scr_memset_worl(s, c, count)		\
+	scr_memsetw((s), (c), (count))
+#endif
 #endif


-- 
Alan Mackenzie (Nuremberg, Germany).
