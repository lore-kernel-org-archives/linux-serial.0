Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AB34C8FF1
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856312; cv=none; b=GxYy+yrF2Tv7J/RLzc2GPFCIkrnJNDE5CAa4cehRS8ToHYqX/K+TCYLFakuOr7vQrcel7ctRf2xe8Ll2+GgogNFwVdeW1B3CM+xcKGlmmfcSv5Je/df4hhHUJDWq++xmAJ7/SNX9Kj5IOKkqyDvppiHRLMSp6OprIcyyXXUGuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856312; c=relaxed/simple;
	bh=L6h65jHKkCnx3vNGz2r94c4Kw7nVNvTqmW0+yguZ05Y=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=RD6meZp+qG71739j6D9afd1lQGSiII3xC+RGyjZOFl2FEh45IVNb1Gyv74dny5U0nW7oONMw37Bt5pMFrUeA5PyRFnnK0foUtTAISMtUJW59dyMAbNb43SvIv9Y/HocLTk/WwO13Dec1WtPmxHYwArSnpDG2AcFJQ8gmMHqhFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 15704 invoked by uid 3782); 27 Aug 2026 20:45:07 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 20:45:06 +0200
Received: (qmail 30995 invoked by uid 1000); 27 Aug 2026 18:45:05 -0000
Date: Thu, 27 Aug 2026 18:45:05 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: acm@muc.de
Subject: [Patch 2/9]: Glyph size: Use GLYPH_SZ/HW rather than hardcoded 2, 1
Message-ID: <apCFsX_JXJ9m3vpr@MAC.fritz.box>
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


vt: 32b glyph: 2. Use GLYPH_SZ, GLYPH_HW rather than hardcoded 2, 1.

These #defines enable the console to be built for either 16-bit or
32-bit glyphs.

Signed-off-by: Alan Mackenzie <acm@muc.de>

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 13f4e48b4142..18affdb3c7c5 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -53,8 +55,8 @@
 
 /* set reverse video on characters s-e of console with selection. */
 static inline void highlight(const int s, const int e)
 {
-	invert_screen(vc_sel.cons, s, e-s+2, true);
+	invert_screen(vc_sel.cons, s, e-s + GLYPH_SZ, true);
 }
 
 /* use complementary color to show the pointer */
@@ -67,7 +69,7 @@ static u32
 sel_pos(int n, bool unicode)
 {
 	if (unicode)
-		return screen_glyph_unicode(vc_sel.cons, n / 2);
+		return screen_glyph_unicode(vc_sel.cons, n / GLYPH_SZ);
 	return inverse_translate(vc_sel.cons, screen_glyph(vc_sel.cons, n),
 			false);
 }
@@ -136,7 +138,7 @@ int sel_loadlut(u32 __user *lut)
 /* does screen address p correspond to character at LH/RH edge of screen? */
 static inline int atedge(const int p, int size_row)
 {
-	return (!(p % size_row)	|| !((p + 2) % size_row));
+	return (!(p % size_row)	|| !((p + GLYPH_SZ) % size_row));
 }
 
 /* stores the char in UTF8 and returns the number of bytes used (1-4) */
@@ -214,8 +216,8 @@ static int vc_selection_store_chars(struct vc_data *vc, bool unicode)
 
 	/* Allocate a new buffer before freeing the old one ... */
 	/* chars can take up to 4 bytes with unicode */
-	bp = kmalloc_array((vc_sel.end - vc_sel.start) / 2 + 1, unicode ? 4 : 1,
-			   GFP_KERNEL | __GFP_NOWARN);
+	bp = kmalloc_array((vc_sel.end - vc_sel.start) / GLYPH_SZ + 1,
+			   unicode ? 4 : 1, GFP_KERNEL | __GFP_NOWARN);
 	if (!bp) {
 		printk(KERN_WARNING "selection: kmalloc() failed\n");
 		clear_selection();
@@ -225,7 +227,7 @@ static int vc_selection_store_chars(struct vc_data *vc, bool unicode)
 	vc_sel.buffer = bp;
 
 	obp = bp;
-	for (i = vc_sel.start; i <= vc_sel.end; i += 2) {
+	for (i = vc_sel.start; i <= vc_sel.end; i += GLYPH_SZ) {
 		u32 c = sel_pos(i, unicode);
 		if (unicode)
 			bp += store_utf8(c, bp);
@@ -233,7 +235,7 @@ static int vc_selection_store_chars(struct vc_data *vc, bool unicode)
 			*bp++ = c;
 		if (!is_space_on_vt(c))
 			obp = bp;
-		if (!((i + 2) % vc->vc_size_row)) {
+		if (!((i + GLYPH_SZ) % size_row)) {
 			/* strip trailing blanks from line and add newline,
 			   unless non-space at end of line. */
 			if (obp != bp) {
@@ -261,7 +263,7 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
 		break;
 	case TIOCL_SELWORD:	/* word-by-word selection */
 		spc = is_space_on_vt(sel_pos(ps, unicode));
-		for (new_sel_start = ps; ; ps -= 2) {
+		for (new_sel_start = ps; ; ps -= GLYPH_SZ) {
 			if ((spc && !is_space_on_vt(sel_pos(ps, unicode))) ||
 			    (!spc && !inword(sel_pos(ps, unicode))))
 				break;
@@ -271,19 +273,19 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
 		}
 
 		spc = is_space_on_vt(sel_pos(pe, unicode));
-		for (new_sel_end = pe; ; pe += 2) {
+		for (new_sel_end = pe; ; pe += GLYPH_SZ) {
 			if ((spc && !is_space_on_vt(sel_pos(pe, unicode))) ||
 			    (!spc && !inword(sel_pos(pe, unicode))))
 				break;
 			new_sel_end = pe;
-			if (!((pe + 2) % vc->vc_size_row))
+			if (!((pe + GLYPH_SZ) % size_row))
 				break;
 		}
 		break;
 	case TIOCL_SELLINE:	/* line-by-line selection */
-		new_sel_start = rounddown(ps, vc->vc_size_row);
-		new_sel_end = rounddown(pe, vc->vc_size_row) +
-			vc->vc_size_row - 2;
+		new_sel_start = rounddown(ps, size_row);
+		new_sel_end = rounddown(pe, size_row) +
+			size_row - GLYPH_SZ;
 		break;
 	case TIOCL_SELPOINTER:
 		highlight_pointer(pe);
@@ -298,8 +300,8 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
 	/* select to end of line if on trailing space */
 	if (new_sel_end > new_sel_start &&
 		!atedge(new_sel_end, vc->vc_size_row) &&
-		is_space_on_vt(sel_pos(new_sel_end, unicode))) {
-		for (pe = new_sel_end + 2; ; pe += 2)
+	    is_space_on_vt(sel_pos(new_sel_end, unicode))) {
+		for (pe = new_sel_end + GLYPH_SZ; ; pe += GLYPH_SZ)
 			if (!is_space_on_vt(sel_pos(pe, unicode)) ||
 			    atedge(pe, vc->vc_size_row))
 				break;
@@ -313,16 +315,16 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
 		if (new_sel_end == vc_sel.end)	/* no action required */
 			return 0;
 		else if (new_sel_end > vc_sel.end)	/* extend to right */
-			highlight(vc_sel.end + 2, new_sel_end);
+			highlight(vc_sel.end + GLYPH_SZ, new_sel_end);
 		else				/* contract from right */
-			highlight(new_sel_end + 2, vc_sel.end);
+			highlight(new_sel_end + GLYPH_SZ, vc_sel.end);
 	}
 	else if (new_sel_end == vc_sel.end)
 	{
 		if (new_sel_start < vc_sel.start) /* extend to left */
-			highlight(new_sel_start, vc_sel.start - 2);
+			highlight(new_sel_start, vc_sel.start - GLYPH_SZ);
 		else				/* contract from left */
-			highlight(vc_sel.start, new_sel_start - 2);
+			highlight(vc_sel.start, new_sel_start - GLYPH_SZ);
 	}
 	else	/* some other case; start selection from scratch */
 	{
@@ -360,8 +363,8 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
 		return 0;
 	}
 
-	ps = v->ys * vc->vc_size_row + (v->xs << 1);
-	pe = v->ye * vc->vc_size_row + (v->xe << 1);
+	ps = v->ys * size_row + (v->xs * GLYPH_SZ);
+	pe = v->ye * size_row + (v->xe * GLYPH_SZ);
 	if (ps > pe)	/* make vc_sel.start <= vc_sel.end */
 		swap(ps, pe);
 
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 7d40eacc21b3..f23d61fe10c1 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -213,16 +215,15 @@ static int vcs_size(const struct vc_data *vc, bool attr, bool unicode)
 
 	WARN_CONSOLE_UNLOCKED();
 
-	size = vc->vc_rows * vc->vc_cols;
-
-	if (attr) {
-		if (unicode)
-			return -EOPNOTSUPP;
-
-		size = 2 * size + HEADER_SIZE;
-	} else if (unicode)
-		size *= 4;
-
+	if (attr && unicode)
+		return -EOPNOTSUPP;
+	else if (unicode)
+		size = (vc->vc_rows * vc->vc_cols) * 4;
+	else if (attr)
+		size = (vc->vc_rows * vc->vc_cols) * GLYPH_SZ +
+			HEADER_SIZE;
+	else
+		size = (vc->vc_rows * vc->vc_cols);
 	return size;
 }
 
@@ -283,7 +288,8 @@ static void vcs_read_buf_noattr(const struct vc_data *vc, char *con_buf,
 	pos += maxcol - col;
 
 	while (count-- > 0) {
-		*con_buf++ = (vcs_scr_readw(vc, org++) & 0xff);
+		*con_buf++ = (vcs_scr_readw(vc, org) & 0xff);
+		org += GLYPH_HW;
 		if (++col == maxcol) {
 			org = screen_pos(vc, pos, viewed);
 			col = 0;
@@ -298,6 +304,7 @@ static unsigned int vcs_read_buf(const struct vc_data *vc, char *con_buf,
 {
 	u16 *org, *con_buf16;
 	unsigned int col, maxcol = vc->vc_cols;
+	unsigned int sz = GLYPH_SZ;
 	unsigned int filled = count;
 
 	if (pos < HEADER_SIZE) {
@@ -315,40 +324,60 @@ static unsigned int vcs_read_buf(const struct vc_data *vc, char *con_buf,
 
 		/* Advance state pointers and move on. */
 		count -= min(HEADER_SIZE, count);
+		/* COUNT is now a count of the number of bytes after the
+		 * header to be read.
+		 */
 		pos = HEADER_SIZE;
 		con_buf += HEADER_SIZE;
 		/* If count >= 0, then pos is even... */
-	} else if (pos & 1) {
+	} else if (pos & (sz - 1)) {
 		/*
-		 * Skip first byte for output if start address is odd. Update
-		 * region sizes up/down depending on free space in buffer.
+		 * Skip any unaligned bytes for output if the start address
+		 * is not on a glyph boundary.  Update region sizes up/down
+		 * depending on free space in buffer.
+		 */
+		(*skip) += (pos & (sz - 1));
+		if (count + (pos & (sz - 1)) <= CON_BUF_SIZE)
+			count += (pos & (sz - 1));
+		/* COUNT is now the number of bytes to be read starting at
+		 * the whole character at or before POS.
 		 */
-		(*skip)++;
-		if (count < CON_BUF_SIZE)
-			count++;
 		else
-			filled--;
+			filled -= (pos & (sz - 1));
 	}
 
 	if (!count)
 		return filled;
 
 	pos -= HEADER_SIZE;
-	pos /= 2;
+	pos /= sz;
 	col = pos % maxcol;
 
 	org = screen_pos(vc, pos, viewed);
 	pos += maxcol - col;
+	/* From now on, POS is the offset from the start of the screen in
+	 * characters of the next end of line.
+	 */
 
 	/*
 	 * Buffer has even length, so we can always copy character + attribute.
-	 * We do not copy last byte to userspace if count is odd.
+	 * We will not copy unaligned last bytes to userspace if count is not a
+	 * multiple of SZ.
+	 */
+	count = (count + sz - 1) / sz;
+	/* COUNT is now the number of screen characters to read, including any
+	 * leading/trailing bytes which the caller will discard.
 	 */
-	count = (count + 1) / 2;
 	con_buf16 = (u16 *)con_buf;
 
 	while (count) {
-		*con_buf16++ = vcs_scr_readw(vc, org++);
+#ifdef CONFIG_FB_GLYPH_21BIT
+		*(u32 *)con_buf16 = vcs_scr_readw(vc, org);
+#else
+		*con_buf16 = vcs_scr_readw(vc, org);
+#endif
+		con_buf16 += GLYPH_HW;
+		org += GLYPH_HW;
 		count--;
 		if (++col == maxcol) {
 			org = screen_pos(vc, pos, viewed);
@@ -481,12 +514,15 @@ static u16 *vcs_write_buf_noattr(struct vc_data *vc, const char *con_buf,
 	pos += maxcol - col;
 
 	while (count > 0) {
-		unsigned char c = *con_buf++;
+		unsigned int c;
 
+		c = *con_buf++;
 		count--;
 		vcs_scr_writew(vc,
-			       (vcs_scr_readw(vc, org) & 0xff00) | c, org);
-		org++;
+			       ((vcs_scr_readw(vc, org) & ~0xffu) |
+				(c & 0xff)),
+			       org);
+		org += GLYPH_HW;
 		if (++col == maxcol) {
 			org = screen_pos(vc, pos, viewed);
 			col = 0;
@@ -534,35 +560,55 @@ static u16 *vcs_write_buf(struct vc_data *vc, const char *con_buf,
 		return NULL;
 
 	pos -= HEADER_SIZE;
-	col = (pos/2) % maxcol;
+	col = (pos / sz) % maxcol;
 
-	*org0 = org = screen_pos(vc, pos/2, viewed);
+	*org0 = org = screen_pos(vc, pos / sz, viewed);
 
-	/* odd pos -- the first single character */
-	if (pos & 1) {
-		count--;
-		c = *con_buf++;
-		vcs_scr_writew(vc, vc_compile_le16(c, vcs_scr_readw(vc, org)),
-				org);
-		org++;
-		pos++;
+	/* Unaligned bytes at start of buffer */
+	if (pos & (sz - 1)) {
+		u32 old_char = vcs_scr_readw(vc, org);
+		u32 new_char = 0;
+		int old_bytes = pos & (sz - 1);
+
+		for (i = 0; i < sz; i++, old_char >>= 8)
+			lo_to_hi[i] = old_char & 0xff;
+		for (i = old_bytes; i < sz && count; i++, count--) {
+			c = *con_buf++;
+			pos++;
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
+		org += GLYPH_HW;
 		if (++col == maxcol) {
-			org = screen_pos(vc, pos/2, viewed);
+			org = screen_pos(vc, pos / sz, viewed);
 			col = 0;
 		}
 	}
 
-	pos /= 2;
+	pos /= sz;
 	pos += maxcol - col;
 
-	/* even pos -- handle attr+character pairs */
-	while (count > 1) {
-		unsigned short w;
+	/* aligned pos -- handle attr+character pairs */
+	while (count >= sz) {
+		unsigned int w;
 
+#ifdef CONFIG_FB_GLYPH_21BIT
+		w = get_unaligned(((unsigned int *)con_buf));
+#else
 		w = get_unaligned(((unsigned short *)con_buf));
-		vcs_scr_writew(vc, w, org++);
-		con_buf += 2;
-		count -= 2;
+#endif
+		vcs_scr_writew(vc, w, org);
+		org += GLYPH_HW;
+		con_buf += sz;
+		count -= sz;
 		if (++col == maxcol) {
 			org = screen_pos(vc, pos, viewed);
 			col = 0;
@@ -592,6 +654,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	ssize_t ret;
 	loff_t pos;
 	bool viewed, attr;
+	int unaligned_before;
 
 	if (use_unicode(inode))
 		return -EOPNOTSUPP;
@@ -620,12 +683,29 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (count > size - pos)
 		count = size - pos;
 	written = 0;
+
+	/* Ensure a region being written, except the last one, ends on a
+	 * character boundary.
+	 */
+	unaligned_before = (-pos) % GLYPH_SZ;
+	if (unaligned_before < 0)
+		unaligned_before += GLYPH_SZ;
+
 	while (count) {
 		unsigned int this_round = count;
 
 		if (this_round > CON_BUF_SIZE)
 			this_round = CON_BUF_SIZE;
 
+		if (unaligned_before) {
+			this_round += unaligned_before;
+			if (this_round > CON_BUF_SIZE)
+				this_round -= GLYPH_SZ;
+			if (this_round > count)
+				this_round = count;
+			unaligned_before = 0;
+		}
+
 		/* Temporarily drop the console lock so that we can read
 		 * in the write data from userspace safely.
 		 */
@@ -681,8 +761,13 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		written += this_round;
 		buf += this_round;
 		pos += this_round;
+		/* update_region needs ORG0 and ORG on character boundaries. */
+		org0 = (u16 *)((unsigned long)org0 & ~((unsigned long)GLYPH_SZ - 1));
+		org = (u16 *)(((unsigned long)org + GLYPH_SZ - 1) &
+			      ~((unsigned long)GLYPH_SZ - 1));
 		if (org)
-			update_region(vc, (unsigned long)(org0), org - org0);
+			update_region(vc, (unsigned long)(org0),
+				      (org - org0) / GLYPH_HW);
 	}
 	*ppos += written;
 	ret = written;
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..0c389a564357 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -566,7 +567,7 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 			 unsigned int row, unsigned int col, unsigned int nr)
 {
 	u32 **uni_lines = vc->vc_uni_lines;
-	int offset = row * vc->vc_size_row + col * 2;
+	int offset = row * vc->vc_size_row + col * GLYPH_SZ;
 	unsigned long pos;
 
 	if (WARN_ON_ONCE(!uni_lines))
@@ -580,7 +581,8 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 		 * scrollback is active.
 		 */
 		row = (pos - vc->vc_origin) / vc->vc_size_row;
-		col = ((pos - vc->vc_origin) % vc->vc_size_row) / 2;
+		col = ((pos - vc->vc_origin) % vc->vc_size_row) /
+			GLYPH_SZ;
 		memcpy(dest, &uni_lines[row][col], nr * sizeof(u32));
 	} else {
 		/*
@@ -620,7 +622,7 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
 	dst = (u16 *)(vc->vc_origin + vc->vc_size_row * (top + nr));
 
 	if (dir == SM_UP) {
-		clear = src + (rows - nr) * vc->vc_cols;
+		clear = src + (rows - nr) * vc->vc_cols * GLYPH_HW;
 		swap(src, dst);
 	}
 	scr_memmovew(dst, src, (rows - nr) * vc->vc_size_row);
@@ -632,7 +634,7 @@ static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 	unsigned int xx, yy, offset;
 	u16 *p = (u16 *)start;
 
-	offset = (start - vc->vc_origin) / 2;
+	offset = (start - vc->vc_origin) / GLYPH_SZ;
 	xx = offset % vc->vc_cols;
 	yy = offset / vc->vc_cols;
 
@@ -653,7 +657,9 @@ static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 			count--;
 		}
 		if (p > q)
-			vc->vc_sw->con_putcs(vc, q, p-q, yy, startx);
+			vc->vc_sw->con_putcs(vc, q,
+					     (p-q) / GLYPH_HW,
+					     yy, startx);
 		if (!count)
 			break;
 		xx = 0;
@@ -736,7 +740,7 @@ void invert_screen(struct vc_data *vc, int offset, int count, bool viewed)
 
 	WARN_CONSOLE_UNLOCKED();
 
-	count /= 2;
+	count /= GLYPH_SZ;
 	p = screenpos(vc, offset, viewed);
 	if (vc->vc_sw->con_invert_region) {
 		vc->vc_sw->con_invert_region(vc, p, count);
@@ -818,8 +809,9 @@ static void insert_char(struct vc_data *vc, unsigned int nr)
 	unsigned short *p = (unsigned short *) vc->vc_pos;
 
 	vc_uniscr_insert(vc, nr);
-	scr_memmovew(p + nr, p, (vc->vc_cols - vc->state.x - nr) * 2);
-	scr_memsetw(p, vc->vc_video_erase_char, nr * 2);
+	scr_memmovew(p + nr * GLYPH_HW,
+		     p, (vc->vc_cols - vc->state.x - nr) * GLYPH_SZ);
+	scr_memset_worl(p, vc->vc_video_erase_char, nr * GLYPH_SZ);
 	vc->vc_need_wrap = 0;
 	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) p,
@@ -831,9 +823,10 @@ static void delete_char(struct vc_data *vc, unsigned int nr)
 	unsigned short *p = (unsigned short *) vc->vc_pos;
 
 	vc_uniscr_delete(vc, nr);
-	scr_memmovew(p, p + nr, (vc->vc_cols - vc->state.x - nr) * 2);
-	scr_memsetw(p + vc->vc_cols - vc->state.x - nr, vc->vc_video_erase_char,
-			nr * 2);
+	scr_memmovew(p, p + nr * GLYPH_HW,
+		     (vc->vc_cols - vc->state.x - nr) * GLYPH_SZ);
+	scr_memset_worl(p + (vc->vc_cols - vc->state.x - nr) * GLYPH_HW,
+		    vc->vc_video_erase_char, nr * GLYPH_SZ);
 	vc->vc_need_wrap = 0;
 	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) p,
@@ -909,7 +902,7 @@ static void set_origin(struct vc_data *vc)
 	vc->vc_visible_origin = vc->vc_origin;
 	vc->vc_scr_end = vc->vc_origin + vc->vc_screenbuf_size;
 	vc->vc_pos = vc->vc_origin + vc->vc_size_row * vc->state.y +
-		2 * vc->state.x;
+		GLYPH_SZ * vc->state.x;
 }
 
 static void save_screen(struct vc_data *vc)
@@ -1005,7 +999,9 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 		}
 
 		if (update && vc->vc_mode != KD_GRAPHICS)
-			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
+			do_update_region(vc, vc->vc_origin,
+					 vc->vc_screenbuf_size /
+					 GLYPH_SZ);
 	}
 	set_cursor(vc);
 	if (is_switch) {
@@ -1184,6 +1217,6 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	new_cols = (cols ? cols : vc->vc_cols);
 	new_rows = (lines ? lines : vc->vc_rows);
-	new_row_size = new_cols << 1;
+	new_row_size = new_cols * GLYPH_SZ;
 	new_screen_size = new_row_size * new_rows;
 
 	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows) {
@@ -1233,13 +1266,9 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 		return err;
 	}
 
-	vc->vc_rows = new_rows;
-	vc->vc_cols = new_cols;
-	vc->vc_size_row = new_row_size;
-	vc->vc_screenbuf_size = new_screen_size;
-
-	rlth = min(old_row_size, new_row_size);
-	rrem = new_row_size - rlth;
+	rlth = min(old_row_size / GLYPH_SZ,
+		   new_row_size / GLYPH_SZ);
+	rrem = (new_row_size / GLYPH_SZ) - rlth;
 	old_origin = vc->vc_origin;
 	new_origin = (long) newscreen;
 	new_scr_end = new_origin + new_screen_size;
@@ -1264,24 +1293,37 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	end = old_origin + old_row_size * min(old_rows, new_rows);
 
 	vc_uniscr_copy_area(new_uniscr, new_cols, new_rows,
-			    vc->vc_uni_lines, rlth/2, first_copied_row,
+			    vc->vc_uni_lines, rlth, first_copied_row,
 			    min(old_rows, new_rows));
 	vc_uniscr_set(vc, new_uniscr);
 
+	vc->vc_cols = new_cols;
+	vc->vc_rows = new_rows;
+	vc->vc_size_row = new_row_size;
+	vc->vc_screenbuf_size = new_screen_size;
+
 	update_attr(vc);
 
 	while (old_origin < end) {
 		scr_memcpyw((unsigned short *) new_origin,
-			    (unsigned short *) old_origin, rlth);
+			    (unsigned short *) old_origin,
+			    rlth * GLYPH_SZ);
 		if (rrem)
-			scr_memsetw((void *)(new_origin + rlth),
-				    vc->vc_video_erase_char, rrem);
+			scr_memset_worl((void *) (new_origin +
+						  rlth * GLYPH_SZ),
+					new_vc_video_erase_char,
+					rrem * GLYPH_SZ);
 		old_origin += old_row_size;
 		new_origin += new_row_size;
 	}
 	if (new_scr_end > new_origin)
-		scr_memsetw((void *)new_origin, vc->vc_video_erase_char,
-			    new_scr_end - new_origin);
+		scr_memset_worl((void *)new_origin,
+				new_vc_video_erase_char,
+				new_scr_end - new_origin);
+	vc->vc_char_mask = new_vc_char_mask;
+	vc->vc_attr_mask = new_vc_attr_mask;
+	vc->vc_attr_shift_pos = new_vc_attr_shift_pos;
+	vc->vc_video_erase_char = new_vc_video_erase_char;
 	oldscreen = vc->vc_screenbuf;
 	vc->vc_screenbuf = newscreen;
 	vc->vc_screenbuf_size = new_screen_size;
@@ -1452,7 +1494,7 @@ static void gotoxy(struct vc_data *vc, int new_x, int new_y)
 	else
 		vc->state.y = new_y;
 	vc->vc_pos = vc->vc_origin + vc->state.y * vc->vc_size_row +
-		(vc->state.x << 1);
+		(vc->state.x * GLYPH_SZ);
 	vc->vc_need_wrap = 0;
 }
 
@@ -1505,7 +1547,7 @@ static void ri(struct vc_data *vc)
 
 static inline void cr(struct vc_data *vc)
 {
-	vc->vc_pos -= vc->state.x << 1;
+	vc->vc_pos -= vc->state.x * GLYPH_SZ;
 	vc->vc_need_wrap = vc->state.x = 0;
 	notify_write(vc, '\r');
 }
@@ -1513,7 +1555,7 @@ static inline void cr(struct vc_data *vc)
 static inline void bs(struct vc_data *vc)
 {
 	if (vc->state.x) {
-		vc->vc_pos -= 2;
+		vc->vc_pos -= GLYPH_SZ;
 		vc->state.x--;
 		vc->vc_need_wrap = 0;
 		notify_write(vc, '\b');
@@ -1543,13 +1585,13 @@ static void csi_J(struct vc_data *vc, enum CSI_J vpar)
 				     vc->vc_cols - vc->state.x);
 		vc_uniscr_clear_lines(vc, vc->state.y + 1,
 				      vc->vc_rows - vc->state.y - 1);
-		count = (vc->vc_scr_end - vc->vc_pos) >> 1;
+		count = (vc->vc_scr_end - vc->vc_pos) / GLYPH_SZ;
 		start = (unsigned short *)vc->vc_pos;
 		break;
 	case CSI_J_START_TO_CURSOR:
 		vc_uniscr_clear_line(vc, 0, vc->state.x + 1);
 		vc_uniscr_clear_lines(vc, 0, vc->state.y);
-		count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
+		count = ((vc->vc_pos - vc->vc_origin) / GLYPH_SZ) + 1;
 		start = (unsigned short *)vc->vc_origin;
 		break;
 	case CSI_J_FULL:
@@ -1563,7 +1605,8 @@ static void csi_J(struct vc_data *vc, enum CSI_J vpar)
 	default:
 		return;
 	}
-	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
+	scr_memset_worl(start, vc->vc_video_erase_char,
+			GLYPH_SZ * count);
 	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) start, count);
 	vc->vc_need_wrap = 0;
@@ -1598,10 +1641,13 @@ static void csi_K(struct vc_data *vc)
 		return;
 	}
 	vc_uniscr_clear_line(vc, vc->state.x + offset, count);
-	scr_memsetw(start + offset, vc->vc_video_erase_char, 2 * count);
+	scr_memset_worl(start + offset * (int)GLYPH_HW,
+			vc->vc_video_erase_char, GLYPH_SZ * count);
 	vc->vc_need_wrap = 0;
 	if (con_should_update(vc))
-		do_update_region(vc, (unsigned long)(start + offset), count);
+		do_update_region(vc, (unsigned long)(start + offset *
+						     (int)GLYPH_HW),
+				 count);
 }
 
 /* erase the following count positions */
@@ -1610,7 +1656,8 @@ static void csi_X(struct vc_data *vc)
 	unsigned int count = clamp(vc->vc_par[0], 1, vc->vc_cols - vc->state.x);
 
 	vc_uniscr_clear_line(vc, vc->state.x, count);
-	scr_memsetw((unsigned short *)vc->vc_pos, vc->vc_video_erase_char, 2 * count);
+	scr_memset_worl((unsigned short *)vc->vc_pos, vc->vc_video_erase_char,
+			GLYPH_SZ * count);
 	if (con_should_update(vc))
 		vc->vc_sw->con_clear(vc, vc->state.y, vc->state.x, count);
 	vc->vc_need_wrap = 0;
@@ -1912,7 +1959,7 @@ static int get_bracketed_paste(struct tty_struct *tty)
 /* console_lock is held */
 static void enter_alt_screen(struct vc_data *vc)
 {
-	unsigned int size = vc->vc_rows * vc->vc_cols * 2;
+	unsigned int size = vc->vc_rows * vc->vc_cols * GLYPH_SZ;
 
 	if (vc->vc_saved_screen != NULL)
 		return; /* Already inside an alt-screen */
@@ -1938,9 +1985,11 @@ static void leave_alt_screen(struct vc_data *vc)
 	if (vc->vc_saved_screen == NULL)
 		return; /* Not inside an alt-screen */
 	for (unsigned int r = 0; r < rows; r++) {
-		src = vc->vc_saved_screen + r * vc->vc_saved_cols;
-		dest = ((u16 *)vc->vc_origin) + r * vc->vc_cols;
-		memcpy(dest, src, 2 * cols);
+		src = vc->vc_saved_screen +
+			GLYPH_HW * r * vc->vc_saved_cols;
+		dest = ((u16 *)vc->vc_origin) +
+			GLYPH_HW * r * vc->vc_cols;
+		memcpy(dest, src, GLYPH_SZ * cols);
 	}
 	/*
 	 * If the console was resized while in the alternate screen,
@@ -1965,7 +2014,8 @@ static void leave_alt_screen(struct vc_data *vc)
 	restore_cur(vc);
 	/* Update the entire screen */
 	if (con_should_update(vc))
-		do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
+		do_update_region(vc, vc->vc_origin,
+				 vc->vc_screenbuf_size / GLYPH_SZ);
 	kfree(vc->vc_saved_screen);
 	vc->vc_saved_screen = NULL;
 }
@@ -2385,7 +2437,7 @@ static bool handle_ascii(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		bs(vc);
 		return true;
 	case ASCII_HTAB:
-		vc->vc_pos -= (vc->state.x << 1);
+		vc->vc_pos -= (vc->state.x * GLYPH_SZ);
 
 		vc->state.x = find_next_bit(vc->vc_tab_stop,
 				min(vc->vc_cols - 1, VC_TABSTOPS_COUNT),
@@ -2393,7 +2445,7 @@ static bool handle_ascii(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		if (vc->state.x >= VC_TABSTOPS_COUNT)
 			vc->state.x = vc->vc_cols - 1;
 
-		vc->vc_pos += (vc->state.x << 1);
+		vc->vc_pos += (vc->state.x * GLYPH_SZ);
 		notify_write(vc, '\t');
 		return true;
 	case ASCII_LINEFEED:
@@ -2895,8 +2949,9 @@ static void con_flush(struct vc_data *vc, struct vc_draw_region *draw)
 		return;
 
 	vc->vc_sw->con_putcs(vc, (u16 *)draw->from,
-			(u16 *)draw->to - (u16 *)draw->from, vc->state.y,
-			draw->x);
+			     (int)((u16 *)draw->to - (u16 *)draw->from) /
+			     GLYPH_HW,
+			     vc->state.y, draw->x);
 	draw->x = -1;
 }
 
@@ -3081,7 +3138,7 @@ static bool vc_is_control(struct vc_data *vc, int tc, int c)
 static void vc_con_rewind(struct vc_data *vc)
 {
 	if (vc->state.x && !vc->vc_need_wrap) {
-		vc->vc_pos -= 2;
+		vc->vc_pos -= GLYPH_SZ;
 		vc->state.x--;
 	}
 	vc->vc_need_wrap = 0;
@@ -3111,7 +3168,7 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 
 	/* From here curr_c is known to be zero-width. */
 
-	if (ucs_get_width(vc_uniscr_getc(vc, -2)) == 2) {
+	if (ucs_get_width(vc_uniscr_getc(vc, -GLYPH_SZ)) == 2) {
 		/*
 		 * Let's merge this zero-width code point with the preceding
 		 * double-width code point by replacing the existing
@@ -3243,10 +3298,10 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		}
 		if (vc->state.x == vc->vc_cols - 1) {
 			vc->vc_need_wrap = vc->vc_decawm;
-			draw->to = vc->vc_pos + 2;
+			draw->to = vc->vc_pos + GLYPH_SZ;
 		} else {
 			vc->state.x++;
-			draw->to = (vc->vc_pos += 2);
+			draw->to = (vc->vc_pos += GLYPH_SZ);
 		}
 
 		if (!--width)
@@ -3508,7 +3564,7 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 		if (vc->state.x == vc->vc_cols - 1) {
 			vc->vc_need_wrap = 1;
 		} else {
-			vc->vc_pos += 2;
+			vc->vc_pos += GLYPH_SZ;
 			vc->state.x++;
 		}
 	}
@@ -5065,14 +5125,15 @@ u32 screen_glyph_unicode(const struct vc_data *vc, int n)
 	if (uni_lines)
 		return uni_lines[n / vc->vc_cols][n % vc->vc_cols];
 
-	return inverse_translate(vc, screen_glyph(vc, n * 2), true);
+	return inverse_translate(vc, screen_glyph(vc, n * GLYPH_SZ),
+				 true);
 }
 EXPORT_SYMBOL_GPL(screen_glyph_unicode);
 
-/* used by vcs - note the word offset */
+/* used by vcs - note the (screen)char sized offset */
 unsigned short *screen_pos(const struct vc_data *vc, int w_offset, bool viewed)
 {
-	return screenpos(vc, 2 * w_offset, viewed);
+	return screenpos(vc, GLYPH_SZ * w_offset, viewed);
 }
 EXPORT_SYMBOL_GPL(screen_pos);
 
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 65681dcc5930..84e073162311 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -214,7 +213,7 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 
 		image.dx += cnt * vc->vc_font.width;
 		count -= cnt;
-		s += cnt;
+		s += GLYPH_HW * cnt;
 	}
 
 	/* buf is always NULL except when in monochrome mode, so in this case
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9f5c4c101581..18fbf7cf11dd 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -668,22 +668,28 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 			break;
 	if (r != q && new_rows >= rows + logo_lines) {
-		save = kmalloc(array3_size(logo_lines, new_cols, 2),
+		save = kmalloc(array3_size(logo_lines, new_cols, GLYPH_SZ),
 			       GFP_KERNEL);
 		if (save) {
 			int i = min(cols, new_cols);
-			scr_memsetw(save, erase, array3_size(logo_lines, new_cols, 2));
-			r = q - step;
-			for (cnt = 0; cnt < logo_lines; cnt++, r += i)
-				scr_memcpyw(save + cnt * new_cols, r, 2 * i);
+			scr_memset_worl(save, erase, array3_size(logo_lines,
+								 new_cols,
+								 GLYPH_SZ));
+			r = q - step * GLYPH_HW;
+			for (cnt = 0; cnt < logo_lines;
+			     cnt++, r += i * GLYPH_HW)
+				scr_memcpyw(save +
+					    cnt * new_cols * GLYPH_HW,
+					    r, GLYPH_SZ * i);
 			r = q;
 		}
 	}
 	if (r == q) {
 		/* We can scroll screen down */
-		r = q - step - cols;
+		r = q - (step + cols) * GLYPH_HW;
 		for (cnt = rows - logo_lines; cnt > 0; cnt--) {
-			scr_memcpyw(r + step, r, vc->vc_size_row);
-			r -= cols;
+			scr_memcpyw(r + step * GLYPH_HW,
+				    r, vc->vc_size_row);
+			r -= cols * GLYPH_HW;
 		}
 		if (!save) {
 			int lines;
@@ -708,7 +714,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		q = (unsigned short *) (vc->vc_origin +
 					vc->vc_size_row *
 					rows);
-		scr_memcpyw(q, save, array3_size(logo_lines, new_cols, 2));
+		scr_memcpyw(q, save, array3_size(logo_lines, new_cols, GLYPH_SZ));
 		vc->state.y += logo_lines;
 		vc->vc_pos += logo_lines * vc->vc_size_row;
 		kfree(save);
@@ -1714,7 +1734,7 @@ static void fbcon_redraw(struct vc_data *vc, int line, int count, int offset)
 {
 	unsigned short *d = (unsigned short *)
 	    (vc->vc_origin + vc->vc_size_row * line);
-	unsigned short *s = d + offset;
+	unsigned short *s = d + ((long) offset) * GLYPH_HW;
 
 	while (count--) {
 		unsigned short *start = s;
@@ -2260,7 +2296,7 @@ static bool fbcon_switch(struct vc_data *vc)
 		update_region(vc,
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
-						 vc->vc_top) / 2);
+						 vc->vc_top) / GLYPH_SZ);
 		return false;
 	}
 	return true;
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fe915afdece5..5afce52057ca 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -29,6 +30,14 @@ enum vc_intensity {
 	VCI_MASK = 0x3,
 };
 
+#ifdef CONFIG_FB_GLYPH_21BIT
+#define GLYPH_SZ 4		/* Size of glyph in bytes */
+#define GLYPH_HW 2		/* Size of glyph in u16s ("Half Words") */
+#else
+#define GLYPH_SZ 2
+#define GLYPH_HW 1
+#endif
+
 /**
  * struct vc_state -- state of a VC
  * @x: cursor's x-position


-- 
Alan Mackenzie (Nuremberg, Germany)
