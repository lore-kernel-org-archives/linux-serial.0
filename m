Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D704746BD
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856776; cv=none; b=pasv+4tJ4p0MAvukoS0SiRYLjSIGa1s2eWtUg0QnFcMOuYrdz1PmdUj16Fimnq+EQs+kWZewUlYMZO/zVimOEFIiiCUxHcATGgaadYHgEEMdsADEG7AbTA4AFraBREnCU8o3dfQ0IdS6E8W0Mx+smIpIUxYTOECI5dUcGIJkufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856776; c=relaxed/simple;
	bh=Kvce6yieCudu+/9pDz/WS/3YBvKiVqD/uWc/BTwazh0=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=X9LVoVBnGPbD0eg9NKRnfY2gVHpvhQH4YyO654BtidiWI3dFKDiNqe3KfVL6qC9DaWzGBxZQes0pocReMNFh6mEYZ7MQSk0fHOpPxkaP3ixMM/GLC+2rT99/9bpE0ZC2ZE/Mmc/oUEX/du6gTTUkfEhquKlt9UoYi6Y47+zHW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 21438 invoked by uid 3782); 27 Aug 2026 20:52:50 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 20:52:49 +0200
Received: (qmail 31137 invoked by uid 1000); 27 Aug 2026 18:52:48 -0000
Date: Thu, 27 Aug 2026 18:52:48 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: acm@muc.de
Subject: [Patch 6/9]: vt: Use u32 and typedef u1632 to handle whole glyphs
Message-ID: <apCHgPpGWGfVz2cI@MAC.fritz.box>
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

vt: 32b glyph: 6. Use u32 and typedef u1632 to handle whole glyphs

The glyph size u1632 is an either 32- or 16-bit unsigned word
depending on whether or not CONFIG_FB_GLYPH_21BIT is #defined.

Signed-off-by: Alan Mackenzie <acm@muc.de>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..0c389a564357 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -322,12 +323,12 @@ static inline u16 *screenpos(const struct vc_data *vc, unsigned int offset,
 	return (u16 *)(origin + offset);
 }
 
-static void con_putc(struct vc_data *vc, u16 ca, unsigned int y, unsigned int x)
+static void con_putc(struct vc_data *vc, u32 ca, unsigned int y, unsigned int x)
 {
 	if (vc->vc_sw->con_putc)
 		vc->vc_sw->con_putc(vc, ca, y, x);
 	else
-		vc->vc_sw->con_putcs(vc, &ca, 1, y, x);
+		vc->vc_sw->con_putcs(vc, (u16 *)&ca, 1, y, x);
 }
 
 /* Called  from the keyboard irq path.. */
@@ -782,7 +773,7 @@ void invert_screen(struct vc_data *vc, int offset, int count, bool viewed)
 void complement_pos(struct vc_data *vc, int offset)
 {
 	static int old_offset = -1;
-	static unsigned short old;
+	static unsigned int old;
 	static unsigned short oldx, oldy;
 
 	WARN_CONSOLE_UNLOCKED();
@@ -3194,7 +3250,7 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 {
 	int next_c;
 	unsigned char vc_attr = vc->vc_attr;
-	u16 himask = vc->vc_hi_font_mask;
+	u32 himask = vc->vc_hi_font_mask;
 	u8 width = 1;
 	bool inverse = false;
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9f5c4c101581..18fbf7cf11dd 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -313,7 +313,7 @@ static inline bool fbcon_is_active(struct vc_data *vc, struct fb_info *info)
 }
 
 static int get_color(struct vc_data *vc, struct fb_info *info,
-		     u16 c, bool is_fg)
+		     u32 c, bool is_fg)
 {
 	int depth = fb_get_color_depth(&info->var, &info->fix);
 	int color = 0;
@@ -379,12 +379,12 @@ static int get_color(struct vc_data *vc, struct fb_info *info,
 	return color;
 }
 
-static int get_fg_color(struct vc_data *vc, struct fb_info *info, u16 c)
+static int get_fg_color(struct vc_data *vc, struct fb_info *info, u32 c)
 {
 	return get_color(vc, info, c, true);
 }
 
-static int get_bg_color(struct vc_data *vc, struct fb_info *info, u16 c)
+static int get_bg_color(struct vc_data *vc, struct fb_info *info, u32 c)
 {
 	return get_color(vc, info, c, false);
 }
@@ -1639,8 +1657,8 @@ static void fbcon_redraw_move(struct vc_data *vc, struct fbcon_display *p,
 	while (count--) {
 		unsigned short *start = s;
 		unsigned short *le = advance_row(s, 1);
-		unsigned short c;
+		unsigned int c;
 		int x = 0;
-		unsigned short attr = 1;
+		unsigned int attr = 1;
 
 		do {
@@ -1668,7 +1688,7 @@ static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
 	int offset = ycount * vc->vc_cols;
 	unsigned short *d = (unsigned short *)
 	    (vc->vc_origin + vc->vc_size_row * line);
-	unsigned short *s = d + offset;
+	unsigned short *s = d + ((long) offset) * GLYPH_HW;
 	struct fbcon_par *par = info->fbcon_par;
 
 	while (count--) {
@@ -1719,8 +1739,8 @@ static void fbcon_redraw(struct vc_data *vc, int line, int count, int offset)
 	while (count--) {
 		unsigned short *start = s;
 		unsigned short *le = advance_row(s, 1);
-		unsigned short c;
+		unsigned int c;
 		int x = 0;
-		unsigned short attr = 1;
+		unsigned int attr = 1;
 
 		do {
@@ -2030,7 +2052,7 @@ static void updatescrollmode_accel(struct fbcon_display *p,
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
 	struct fbcon_par *par = info->fbcon_par;
 	int cap = info->flags;
-	u16 t = 0;
+	u32 t = 0;
 	int ypan = FBCON_SWAP(par->rotate, info->fix.ypanstep, info->fix.xpanstep);
 	int ywrap = FBCON_SWAP(par->rotate, info->fix.ywrapstep, t);
 	int yres = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
@@ -2146,6 +2168,7 @@ static bool fbcon_switch(struct vc_data *vc)
 	struct fbcon_par *par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
+	unsigned short *d, *s;
 	int i, ret, prev_console;
 
 	info = fbcon_info_from_console(vc->vc_num);
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 407d207b14f1..5aaef363a343 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -217,7 +211,7 @@ static inline int real_y(struct fbcon_display *p, int ypos)
 }
 
 
-static inline int get_attribute(struct fb_info *info, u16 c)
+static inline int get_attribute(struct fb_info *info, u32 c)
 {
 	int attribute = 0;
 
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fe915afdece5..5afce52057ca 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -110,7 +119,7 @@ unsigned int vc_font_size(const struct vc_font *font);
  * (vc_origin +            |                      |  \ EMPTY, to be filled by
  *  vc_screenbuf_size)     |                      |  / vc_video_erase_char
  *                         +----------------------+-'
- *                         <---- 2 * vc_cols ----->
+ *                         <--- 2/4 * vc_cols ---->
  *                         <---- vc_size_row ----->
  *
  * Note that every character in the console buffer is accompanied with an
@@ -178,7 +190,7 @@ struct vc_data {
 		 int	vc_utf_char;
 	DECLARE_BITMAP(vc_tab_stop, VC_TABSTOPS_COUNT);	/* Tab stops. 256 columns. */
 	unsigned char   vc_palette[16*3];       /* Colour palette for VGA+ */
-	unsigned short * vc_translate;
+	u1632		*vc_translate;
 	unsigned int	vc_bell_pitch;		/* Console bell pitch */
 	unsigned int	vc_bell_duration;	/* Console bell duration */
 	unsigned short	vc_cur_blink_ms;	/* Cursor blink duration */
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 539d488fdc03..5e50b4d4bd0b 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -19,11 +19,21 @@ enum translation_map {
 
 #include <linux/types.h>
 
+#ifdef CONFIG_FB_GLYPH_21BIT
+#define u1632 u32
+#else
+#define u1632 u16
+#endif
+
 struct vc_data;
 
+extern u8 dfont_unicount[];	/* Defined in consolemap_deftbl.c */
+extern u16 dfont_unitable[];	/* Ditto */
+
 #ifdef CONFIG_CONSOLE_TRANSLATIONS
-u16 inverse_translate(const struct vc_data *conp, u16 glyph, bool use_unicode);
-unsigned short *set_translate(enum translation_map m, struct vc_data *vc);
+u1632 inverse_translate(const struct vc_data *conp, u1632 glyph,
+			bool use_unicode);
+u1632 *set_translate(enum translation_map m, struct vc_data *vc);
 int conv_uni_to_pc(struct vc_data *conp, long ucs);
 u32 conv_8bit_to_uni(unsigned char c);
 int conv_uni_to_8bit(u32 uni);
@@ -32,7 +42,7 @@ unsigned int ucs_get_width(uint32_t cp);
 u32 ucs_recompose(u32 base, u32 mark);
 u32 ucs_get_fallback(u32 cp);
 #else
-static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
+static inline u1632 inverse_translate(const struct vc_data *conp, u16 glyph,
 		bool use_unicode)
 {
 	return glyph;
diff --git a/include/linux/selection.h b/include/linux/selection.h
index bab7d30d3446..44bc2b2892d8 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -33,7 +33,7 @@ extern unsigned char default_grn[];
 extern unsigned char default_blu[];
 
 unsigned short *screen_pos(const struct vc_data *vc, int w_offset, bool viewed);
-u16 screen_glyph(const struct vc_data *vc, int offset);
+u32 screen_glyph(const struct vc_data *vc, int offset);
 u32 screen_glyph_unicode(const struct vc_data *vc, int offset);
 void complement_pos(struct vc_data *vc, int offset);
 void invert_screen(struct vc_data *vc, int offset, int count, bool viewed);
@@ -41,8 +41,8 @@ void invert_screen(struct vc_data *vc, int offset, int count, bool viewed);
 void getconsxy(const struct vc_data *vc, unsigned char xy[static 2]);
 void putconsxy(struct vc_data *vc, unsigned char xy[static const 2]);
 
-u16 vcs_scr_readw(const struct vc_data *vc, const u16 *org);
-void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
+u32 vcs_scr_readw(const struct vc_data *vc, const u16 *org);
+void vcs_scr_writew(struct vc_data *vc, u32 val, u16 *org);
 void vcs_scr_updated(struct vc_data *vc);
 
 int vc_uniscr_check(struct vc_data *vc);
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index d008c3d0a9bb..af99aeefe177 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -56,14 +56,20 @@ int tioclinux(struct tty_struct *tty, unsigned long arg);
 /* consolemap.c */
 
 struct unipair;
+struct unipair21;
+#ifdef CONFIG_FB_GLYPH_21BIT
+#define unipair8_21 unipair21
+#else
+#define unipair8_21 unipair
+#endif
 
 int con_set_trans_old(unsigned char __user * table);
 int con_get_trans_old(unsigned char __user * table);
 int con_set_trans_new(unsigned short __user * table);
 int con_get_trans_new(unsigned short __user * table);
 int con_clear_unimap(struct vc_data *vc);
-int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list);
-int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct unipair __user *list);
+int con_set_unimap(struct vc_data *vc, u32 ct, struct unipair8_21 *list);
+int con_get_unimap(struct vc_data *vc, u32 ct, u1632 __user *uct, struct unipair8_21 *list);
 int con_set_default_unimap(struct vc_data *vc);
 void con_free_unimap(struct vc_data *vc);
 int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc);


-- 
Alan Mackenzie (Nuremberg, Germany).
