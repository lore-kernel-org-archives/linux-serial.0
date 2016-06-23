From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/16] tty: vt, convert more macros to functions
Date: Thu, 23 Jun 2016 13:34:35 +0200
Message-ID: <20160623113437.28416-14-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Namely convert:
* IS_FG -> con_is_fg
* DO_UPDATE -> con_should_update
* CON_IS_VISIBLE -> con_is_visible

DO_UPDATE was a weird name for a yes/no answer, so the new name is
con_should_update.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/tty/vt/vt.c                     | 62 ++++++++++++++++++---------------
 drivers/usb/misc/sisusbvga/sisusb_con.c |  4 +--
 drivers/video/console/fbcon.c           | 26 +++++++-------
 drivers/video/console/vgacon.c          |  8 ++---
 include/linux/console_struct.h          |  5 ++-
 5 files changed, 57 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8ceabfd20561..26de5c0fc056 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -277,8 +277,15 @@ static void notify_update(struct vc_data *vc)
  *	Low-Level Functions
  */
 
-#define IS_FG(vc)	((vc)->vc_num == fg_console)
-#define DO_UPDATE(vc)	(CON_IS_VISIBLE(vc) && !console_blanked)
+static inline bool con_is_fg(const struct vc_data *vc)
+{
+	return vc->vc_num == fg_console;
+}
+
+static inline bool con_should_update(const struct vc_data *vc)
+{
+	return con_is_visible(vc) && !console_blanked;
+}
 
 static inline unsigned short *screenpos(struct vc_data *vc, int offset, int viewed)
 {
@@ -316,7 +323,7 @@ static void scrup(struct vc_data *vc, unsigned int t, unsigned int b, int nr)
 		nr = b - t - 1;
 	if (b > vc->vc_rows || t >= b || nr < 1)
 		return;
-	if (CON_IS_VISIBLE(vc) && vc->vc_sw->con_scroll(vc, t, b, SM_UP, nr))
+	if (con_is_visible(vc) && vc->vc_sw->con_scroll(vc, t, b, SM_UP, nr))
 		return;
 	d = (unsigned short *)(vc->vc_origin + vc->vc_size_row * t);
 	s = (unsigned short *)(vc->vc_origin + vc->vc_size_row * (t + nr));
@@ -334,7 +341,7 @@ static void scrdown(struct vc_data *vc, unsigned int t, unsigned int b, int nr)
 		nr = b - t - 1;
 	if (b > vc->vc_rows || t >= b || nr < 1)
 		return;
-	if (CON_IS_VISIBLE(vc) && vc->vc_sw->con_scroll(vc, t, b, SM_DOWN, nr))
+	if (con_is_visible(vc) && vc->vc_sw->con_scroll(vc, t, b, SM_DOWN, nr))
 		return;
 	s = (unsigned short *)(vc->vc_origin + vc->vc_size_row * t);
 	step = vc->vc_cols * nr;
@@ -390,7 +397,7 @@ void update_region(struct vc_data *vc, unsigned long start, int count)
 {
 	WARN_CONSOLE_UNLOCKED();
 
-	if (DO_UPDATE(vc)) {
+	if (con_should_update(vc)) {
 		hide_cursor(vc);
 		do_update_region(vc, start, count);
 		set_cursor(vc);
@@ -490,7 +497,7 @@ void invert_screen(struct vc_data *vc, int offset, int count, int viewed)
 		}
 	}
 
-	if (DO_UPDATE(vc))
+	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) p, count);
 	notify_update(vc);
 }
@@ -507,7 +514,7 @@ void complement_pos(struct vc_data *vc, int offset)
 	if (old_offset != -1 && old_offset >= 0 &&
 	    old_offset < vc->vc_screenbuf_size) {
 		scr_writew(old, screenpos(vc, old_offset, 1));
-		if (DO_UPDATE(vc))
+		if (con_should_update(vc))
 			vc->vc_sw->con_putc(vc, old, oldy, oldx);
 		notify_update(vc);
 	}
@@ -522,7 +529,7 @@ void complement_pos(struct vc_data *vc, int offset)
 		old = scr_readw(p);
 		new = old ^ vc->vc_complement_mask;
 		scr_writew(new, p);
-		if (DO_UPDATE(vc)) {
+		if (con_should_update(vc)) {
 			oldx = (offset >> 1) % vc->vc_cols;
 			oldy = (offset >> 1) / vc->vc_cols;
 			vc->vc_sw->con_putc(vc, new, oldy, oldx);
@@ -538,7 +545,7 @@ static void insert_char(struct vc_data *vc, unsigned int nr)
 	scr_memmovew(p + nr, p, (vc->vc_cols - vc->vc_x - nr) * 2);
 	scr_memsetw(p, vc->vc_video_erase_char, nr * 2);
 	vc->vc_need_wrap = 0;
-	if (DO_UPDATE(vc))
+	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) p,
 			vc->vc_cols - vc->vc_x);
 }
@@ -551,7 +558,7 @@ static void delete_char(struct vc_data *vc, unsigned int nr)
 	scr_memsetw(p + vc->vc_cols - vc->vc_x - nr, vc->vc_video_erase_char,
 			nr * 2);
 	vc->vc_need_wrap = 0;
-	if (DO_UPDATE(vc))
+	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) p,
 			vc->vc_cols - vc->vc_x);
 }
@@ -571,7 +578,7 @@ static void add_softcursor(struct vc_data *vc)
 	if ((type & 0x20) && ((softcursor_original & 0x7000) == (i & 0x7000))) i ^= 0x7000;
 	if ((type & 0x40) && ((i & 0x700) == ((i & 0x7000) >> 4))) i ^= 0x0700;
 	scr_writew(i, (u16 *) vc->vc_pos);
-	if (DO_UPDATE(vc))
+	if (con_should_update(vc))
 		vc->vc_sw->con_putc(vc, i, vc->vc_y, vc->vc_x);
 }
 
@@ -579,7 +586,7 @@ static void hide_softcursor(struct vc_data *vc)
 {
 	if (softcursor_original != -1) {
 		scr_writew(softcursor_original, (u16 *)vc->vc_pos);
-		if (DO_UPDATE(vc))
+		if (con_should_update(vc))
 			vc->vc_sw->con_putc(vc, softcursor_original,
 					vc->vc_y, vc->vc_x);
 		softcursor_original = -1;
@@ -596,8 +603,7 @@ static void hide_cursor(struct vc_data *vc)
 
 static void set_cursor(struct vc_data *vc)
 {
-	if (!IS_FG(vc) || console_blanked ||
-	    vc->vc_mode == KD_GRAPHICS)
+	if (!con_is_fg(vc) || console_blanked || vc->vc_mode == KD_GRAPHICS)
 		return;
 	if (vc->vc_deccm) {
 		if (vc == sel_cons)
@@ -613,7 +619,7 @@ static void set_origin(struct vc_data *vc)
 {
 	WARN_CONSOLE_UNLOCKED();
 
-	if (!CON_IS_VISIBLE(vc) ||
+	if (!con_is_visible(vc) ||
 	    !vc->vc_sw->con_set_origin ||
 	    !vc->vc_sw->con_set_origin(vc))
 		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
@@ -661,12 +667,12 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 		struct vc_data *old_vc = vc_cons[fg_console].d;
 		if (old_vc == vc)
 			return;
-		if (!CON_IS_VISIBLE(vc))
+		if (!con_is_visible(vc))
 			redraw = 1;
 		*vc->vc_display_fg = vc;
 		fg_console = vc->vc_num;
 		hide_cursor(old_vc);
-		if (!CON_IS_VISIBLE(old_vc)) {
+		if (!con_is_visible(old_vc)) {
 			save_screen(old_vc);
 			set_origin(old_vc);
 		}
@@ -941,7 +947,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 		tty_do_resize(tty, &ws);
 	}
 
-	if (CON_IS_VISIBLE(vc))
+	if (con_is_visible(vc))
 		update_screen(vc);
 	vt_event_post(VT_EVENT_RESIZE, vc->vc_num, vc->vc_num);
 	return err;
@@ -1171,7 +1177,7 @@ static void csi_J(struct vc_data *vc, int vpar)
 			scr_memsetw(vc->vc_screenbuf, vc->vc_video_erase_char,
 				    vc->vc_screenbuf_size >> 1);
 			set_origin(vc);
-			if (CON_IS_VISIBLE(vc))
+			if (con_is_visible(vc))
 				update_screen(vc);
 			/* fall through */
 		case 2: /* erase whole display */
@@ -1182,7 +1188,7 @@ static void csi_J(struct vc_data *vc, int vpar)
 			return;
 	}
 	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
-	if (DO_UPDATE(vc))
+	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) start, count);
 	vc->vc_need_wrap = 0;
 }
@@ -1210,7 +1216,7 @@ static void csi_K(struct vc_data *vc, int vpar)
 	}
 	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
 	vc->vc_need_wrap = 0;
-	if (DO_UPDATE(vc))
+	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) start, count);
 }
 
@@ -1223,7 +1229,7 @@ static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar posi
 	count = (vpar > vc->vc_cols - vc->vc_x) ? (vc->vc_cols - vc->vc_x) : vpar;
 
 	scr_memsetw((unsigned short *)vc->vc_pos, vc->vc_video_erase_char, 2 * count);
-	if (DO_UPDATE(vc))
+	if (con_should_update(vc))
 		vc->vc_sw->con_clear(vc, vc->vc_y, vc->vc_x, 1, count);
 	vc->vc_need_wrap = 0;
 }
@@ -2208,7 +2214,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	charmask = himask ? 0x1ff : 0xff;
 
 	/* undraw cursor first */
-	if (IS_FG(vc))
+	if (con_is_fg(vc))
 		hide_cursor(vc);
 
 	param.vc = vc;
@@ -2380,7 +2386,7 @@ rescan_last_byte:
 					     ((vc_attr << 8) & ~himask) + ((tc & 0x100) ? himask : 0) + (tc & 0xff) :
 					     (vc_attr << 8) + tc,
 					   (u16 *) vc->vc_pos);
-				if (DO_UPDATE(vc) && draw_x < 0) {
+				if (con_should_update(vc) && draw_x < 0) {
 					draw_x = vc->vc_x;
 					draw_from = vc->vc_pos;
 				}
@@ -2564,7 +2570,7 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 		goto quit;
 
 	/* undraw cursor first */
-	if (IS_FG(vc))
+	if (con_is_fg(vc))
 		hide_cursor(vc);
 
 	start = (ushort *)vc->vc_pos;
@@ -2575,7 +2581,7 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 		c = *b++;
 		if (c == 10 || c == 13 || c == 8 || vc->vc_need_wrap) {
 			if (cnt > 0) {
-				if (CON_IS_VISIBLE(vc))
+				if (con_is_visible(vc))
 					vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, vc->vc_x);
 				vc->vc_x += cnt;
 				if (vc->vc_need_wrap)
@@ -2607,7 +2613,7 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 		myx++;
 	}
 	if (cnt > 0) {
-		if (CON_IS_VISIBLE(vc))
+		if (con_is_visible(vc))
 			vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, vc->vc_x);
 		vc->vc_x += cnt;
 		if (vc->vc_x == vc->vc_cols) {
@@ -3154,7 +3160,7 @@ static int do_bind_con_driver(const struct consw *csw, int first, int last,
 
 		j = i;
 
-		if (CON_IS_VISIBLE(vc)) {
+		if (con_is_visible(vc)) {
 			k = i;
 			save_screen(vc);
 		}
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 52a6da991165..460cebf322e3 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -570,7 +570,7 @@ sisusbcon_set_palette(struct vc_data *c, const unsigned char *table)
 
 	/* Return value not used by vt */
 
-	if (!CON_IS_VISIBLE(c))
+	if (!con_is_visible(c))
 		return;
 
 	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
@@ -1226,7 +1226,7 @@ sisusbcon_do_font_op(struct sisusb_usb_data *sisusb, int set, int slot,
 			struct vc_data *vc = vc_cons[i].d;
 
 			if (vc && vc->vc_sw == &sisusb_con) {
-				if (CON_IS_VISIBLE(vc)) {
+				if (con_is_visible(vc)) {
 					vc->vc_sw->con_cursor(vc, CM_DRAW);
 				}
 				vc->vc_font.height = fh;
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index eef8a8b7274f..b87f5cfdaea5 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -380,7 +380,7 @@ static void fb_flashcursor(struct work_struct *work)
 	if (ops && ops->currcon != -1)
 		vc = vc_cons[ops->currcon].d;
 
-	if (!vc || !CON_IS_VISIBLE(vc) ||
+	if (!vc || !con_is_visible(vc) ||
  	    registered_fb[con2fb_map[vc->vc_num]] != info ||
 	    vc->vc_deccm != 1) {
 		console_unlock();
@@ -618,7 +618,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		    erase,
 		    vc->vc_size_row * logo_lines);
 
-	if (CON_IS_VISIBLE(vc) && vc->vc_mode == KD_TEXT) {
+	if (con_is_visible(vc) && vc->vc_mode == KD_TEXT) {
 		fbcon_clear_margins(vc, 0);
 		update_screen(vc);
 	}
@@ -1112,7 +1112,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	 *
 	 * We need to do it in fbcon_init() to prevent screen corruption.
 	 */
-	if (CON_IS_VISIBLE(vc) && vc->vc_mode == KD_TEXT) {
+	if (con_is_visible(vc) && vc->vc_mode == KD_TEXT) {
 		if (info->fbops->fb_set_par &&
 		    !(ops->flags & FBCON_FLAGS_INIT)) {
 			ret = info->fbops->fb_set_par(info);
@@ -1192,7 +1192,7 @@ static void fbcon_deinit(struct vc_data *vc)
 	if (!ops)
 		goto finished;
 
-	if (CON_IS_VISIBLE(vc))
+	if (con_is_visible(vc))
 		fbcon_del_cursor_timer(info);
 
 	ops->flags &= ~FBCON_FLAGS_INIT;
@@ -1397,7 +1397,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	rows /= vc->vc_font.height;
 	vc_resize(vc, cols, rows);
 
-	if (CON_IS_VISIBLE(vc)) {
+	if (con_is_visible(vc)) {
 		update_screen(vc);
 		if (softback_buf)
 			fbcon_update_softback(vc);
@@ -2145,7 +2145,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 			return -EINVAL;
 
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
-		if (CON_IS_VISIBLE(vc)) {
+		if (con_is_visible(vc)) {
 			var.activate = FB_ACTIVATE_NOW |
 				FB_ACTIVATE_FORCE;
 			fb_set_var(info, &var);
@@ -2448,7 +2448,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 	int cnt;
 	char *old_data = NULL;
 
-	if (CON_IS_VISIBLE(vc) && softback_lines)
+	if (con_is_visible(vc) && softback_lines)
 		fbcon_set_origin(vc);
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
@@ -2529,9 +2529,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 		cols /= w;
 		rows /= h;
 		vc_resize(vc, cols, rows);
-		if (CON_IS_VISIBLE(vc) && softback_buf)
+		if (con_is_visible(vc) && softback_buf)
 			fbcon_update_softback(vc);
-	} else if (CON_IS_VISIBLE(vc)
+	} else if (con_is_visible(vc)
 		   && vc->vc_mode == KD_TEXT) {
 		fbcon_clear_margins(vc, 0);
 		update_screen(vc);
@@ -2660,7 +2660,7 @@ static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 	if (fbcon_is_inactive(vc, info))
 		return;
 
-	if (!CON_IS_VISIBLE(vc))
+	if (!con_is_visible(vc))
 		return;
 
 	depth = fb_get_color_depth(&info->var, &info->fix);
@@ -2902,7 +2902,7 @@ static void fbcon_modechanged(struct fb_info *info)
 	p = &fb_display[vc->vc_num];
 	set_blitting_type(vc, info);
 
-	if (CON_IS_VISIBLE(vc)) {
+	if (con_is_visible(vc)) {
 		var_to_display(p, &info->var, info);
 		cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
 		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
@@ -2941,7 +2941,7 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 		    registered_fb[con2fb_map[i]] != info)
 			continue;
 
-		if (CON_IS_VISIBLE(vc)) {
+		if (con_is_visible(vc)) {
 			fg = i;
 			continue;
 		}
@@ -3180,7 +3180,7 @@ static void fbcon_fb_blanked(struct fb_info *info, int blank)
 			registered_fb[con2fb_map[ops->currcon]] != info)
 		return;
 
-	if (CON_IS_VISIBLE(vc)) {
+	if (con_is_visible(vc)) {
 		if (blank)
 			do_blank_screen(0);
 		else
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index e280b3ceebd9..11576611a974 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -589,7 +589,7 @@ static void vgacon_init(struct vc_data *c, int init)
 static void vgacon_deinit(struct vc_data *c)
 {
 	/* When closing the active console, reset video origin */
-	if (CON_IS_VISIBLE(c)) {
+	if (con_is_visible(c)) {
 		c->vc_visible_origin = vga_vram_base;
 		vga_set_mem_top(c);
 	}
@@ -860,7 +860,7 @@ static void vgacon_set_palette(struct vc_data *vc, const unsigned char *table)
 {
 #ifdef CAN_LOAD_PALETTE
 	if (vga_video_type != VIDEO_TYPE_VGAC || vga_palette_blanked
-	    || !CON_IS_VISIBLE(vc))
+	    || !con_is_visible(vc))
 		return;
 	vga_set_palette(vc, table);
 #endif
@@ -1248,7 +1248,7 @@ static int vgacon_adjust_height(struct vc_data *vc, unsigned fontheight)
 		struct vc_data *c = vc_cons[i].d;
 
 		if (c && c->vc_sw == &vga_con) {
-			if (CON_IS_VISIBLE(c)) {
+			if (con_is_visible(c)) {
 			        /* void size to cause regs to be rewritten */
 				cursor_size_lastfrom = 0;
 				cursor_size_lastto = 0;
@@ -1312,7 +1312,7 @@ static int vgacon_resize(struct vc_data *c, unsigned int width,
 		   return success */
 		return (user) ? 0 : -EINVAL;
 
-	if (CON_IS_VISIBLE(c) && !vga_is_gfx) /* who knows */
+	if (con_is_visible(c) && !vga_is_gfx) /* who knows */
 		vgacon_doresize(c, width, height);
 	return 0;
 }
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 5fa605c93428..a12d3f2899a8 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -168,6 +168,9 @@ extern void vc_SAK(struct work_struct *work);
 
 #define CUR_DEFAULT CUR_UNDERLINE
 
-#define CON_IS_VISIBLE(conp) (*conp->vc_display_fg == conp)
+static inline bool con_is_visible(const struct vc_data *vc)
+{
+	return *vc->vc_display_fg == vc;
+}
 
 #endif /* _LINUX_CONSOLE_STRUCT_H */
-- 
2.9.0
