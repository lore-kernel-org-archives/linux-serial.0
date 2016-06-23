From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/16] tty: vt, consw->con_scrolldelta cleanup
Date: Thu, 23 Jun 2016 13:34:26 +0200
Message-ID: <20160623113437.28416-5-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Winischhofer <thomas@winischhofer.net>, linux-usb@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

* allow NULL consw->con_scrolldelta (some consoles define an empty
  hook)
* => remove empty hooks now
* return value of consw->con_scrolldelta is never checked => make the
  function void
* document consw->con_scrolldelta a bit

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-usb@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
---
 drivers/tty/vt/vt.c                     |  2 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c | 11 +++--------
 drivers/video/console/dummycon.c        |  1 -
 drivers/video/console/fbcon.c           | 16 +++++++---------
 drivers/video/console/mdacon.c          |  6 ------
 drivers/video/console/newport_con.c     |  7 -------
 drivers/video/console/sticon.c          |  6 ------
 drivers/video/console/vgacon.c          | 13 +++++--------
 include/linux/console.h                 |  8 +++++++-
 9 files changed, 23 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index abc79ae19079..365a91d01a0e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2468,7 +2468,7 @@ static void console_callback(struct work_struct *ignored)
 	if (scrollback_delta) {
 		struct vc_data *vc = vc_cons[fg_console].d;
 		clear_selection();
-		if (vc->vc_mode == KD_TEXT)
+		if (vc->vc_mode == KD_TEXT && vc->vc_sw->con_scrolldelta)
 			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);
 		scrollback_delta = 0;
 	}
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 0ebbf49cd649..a8244ebeb7a7 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -717,24 +717,22 @@ sisusbcon_blank(struct vc_data *c, int blank, int mode_switch)
 }
 
 /* interface routine */
-static int
+static void
 sisusbcon_scrolldelta(struct vc_data *c, int lines)
 {
 	struct sisusb_usb_data *sisusb;
 	int margin = c->vc_size_row * 4;
 	int ul, we, p, st;
 
-	/* The return value does not seem to be used */
-
 	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
 	if (!sisusb)
-		return 0;
+		return;
 
 	/* sisusb->lock is down */
 
 	if (sisusb_is_inactive(c, sisusb)) {
 		mutex_unlock(&sisusb->lock);
-		return 0;
+		return;
 	}
 
 	if (!lines)		/* Turn scrollback off */
@@ -774,8 +772,6 @@ sisusbcon_scrolldelta(struct vc_data *c, int lines)
 	sisusbcon_set_start_address(sisusb, c);
 
 	mutex_unlock(&sisusb->lock);
-
-	return 1;
 }
 
 /* Interface routine */
@@ -1433,7 +1429,6 @@ static const struct consw sisusb_dummy_con = {
 	.con_font_default =	SISUSBCONDUMMY,
 	.con_font_copy =	SISUSBCONDUMMY,
 	.con_set_palette =	SISUSBCONDUMMY,
-	.con_scrolldelta =	SISUSBCONDUMMY,
 };
 
 int
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 0efc52f11ad0..9ce03b9aba88 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -72,6 +72,5 @@ const struct consw dummy_con = {
     .con_font_default =	DUMMY,
     .con_font_copy =	DUMMY,
     .con_set_palette =	DUMMY,
-    .con_scrolldelta =	DUMMY,
 };
 EXPORT_SYMBOL_GPL(dummy_con);
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index afd3301ac40c..eadc7bf62eb3 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -171,7 +171,6 @@ static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 static int fbcon_switch(struct vc_data *vc);
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch);
 static int fbcon_set_palette(struct vc_data *vc, const unsigned char *table);
-static int fbcon_scrolldelta(struct vc_data *vc, int lines);
 
 /*
  *  Internal routines
@@ -2765,7 +2764,7 @@ static void fbcon_invert_region(struct vc_data *vc, u16 * p, int cnt)
 	}
 }
 
-static int fbcon_scrolldelta(struct vc_data *vc, int lines)
+static void fbcon_scrolldelta(struct vc_data *vc, int lines)
 {
 	struct fb_info *info = registered_fb[con2fb_map[fg_console]];
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -2774,9 +2773,9 @@ static int fbcon_scrolldelta(struct vc_data *vc, int lines)
 
 	if (softback_top) {
 		if (vc->vc_num != fg_console)
-			return 0;
+			return;
 		if (vc->vc_mode != KD_TEXT || !lines)
-			return 0;
+			return;
 		if (logo_shown >= 0) {
 			struct vc_data *conp2 = vc_cons[logo_shown].d;
 
@@ -2809,11 +2808,11 @@ static int fbcon_scrolldelta(struct vc_data *vc, int lines)
 		fbcon_cursor(vc, CM_ERASE | CM_SOFTBACK);
 		fbcon_redraw_softback(vc, disp, lines);
 		fbcon_cursor(vc, CM_DRAW | CM_SOFTBACK);
-		return 0;
+		return;
 	}
 
 	if (!scrollback_phys_max)
-		return -ENOSYS;
+		return;
 
 	scrollback_old = scrollback_current;
 	scrollback_current -= lines;
@@ -2822,10 +2821,10 @@ static int fbcon_scrolldelta(struct vc_data *vc, int lines)
 	else if (scrollback_current > scrollback_max)
 		scrollback_current = scrollback_max;
 	if (scrollback_current == scrollback_old)
-		return 0;
+		return;
 
 	if (fbcon_is_inactive(vc, info))
-		return 0;
+		return;
 
 	fbcon_cursor(vc, CM_ERASE);
 
@@ -2852,7 +2851,6 @@ static int fbcon_scrolldelta(struct vc_data *vc, int lines)
 
 	if (!scrollback_current)
 		fbcon_cursor(vc, CM_DRAW);
-	return 0;
 }
 
 static int fbcon_set_origin(struct vc_data *vc)
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 8edc062536a8..234af26b4829 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -505,11 +505,6 @@ static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
 	}
 }
 
-static int mdacon_scrolldelta(struct vc_data *c, int lines)
-{
-	return 0;
-}
-
 static void mdacon_cursor(struct vc_data *c, int mode)
 {
 	if (mode == CM_ERASE) {
@@ -578,7 +573,6 @@ static const struct consw mda_con = {
 	.con_switch =		mdacon_switch,
 	.con_blank =		mdacon_blank,
 	.con_set_palette =	mdacon_set_palette,
-	.con_scrolldelta =	mdacon_scrolldelta,
 	.con_build_attr =	mdacon_build_attr,
 	.con_invert_region =	mdacon_invert_region,
 };
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 0553dfe684ef..eb3d4ce12cd5 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -579,12 +579,6 @@ static int newport_set_palette(struct vc_data *vc, const unsigned char *table)
 	return -EINVAL;
 }
 
-static int newport_scrolldelta(struct vc_data *vc, int lines)
-{
-	/* there is (nearly) no off-screen memory, so we can't scroll back */
-	return 0;
-}
-
 static int newport_scroll(struct vc_data *vc, int t, int b, int dir,
 			  int lines)
 {
@@ -735,7 +729,6 @@ const struct consw newport_con = {
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
 	.con_set_palette  = newport_set_palette,
-	.con_scrolldelta  = newport_scrolldelta,
 	.con_set_origin	  = DUMMY,
 	.con_save_screen  = DUMMY
 };
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index e440c2d9fe7c..20f6a2f5d4a7 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -256,11 +256,6 @@ static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
     return 1;
 }
 
-static int sticon_scrolldelta(struct vc_data *conp, int lines)
-{
-    return 0;
-}
-
 static u16 *sticon_screen_pos(struct vc_data *conp, int offset)
 {
     int line;
@@ -359,7 +354,6 @@ static const struct consw sti_con = {
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
 	.con_set_palette	= sticon_set_palette,
-	.con_scrolldelta	= sticon_scrolldelta,
 	.con_set_origin		= sticon_set_origin,
 	.con_save_screen	= sticon_save_screen, 
 	.con_build_attr		= sticon_build_attr,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 8bf911002cba..f447d6916991 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -80,7 +80,7 @@ static void vgacon_deinit(struct vc_data *c);
 static void vgacon_cursor(struct vc_data *c, int mode);
 static int vgacon_switch(struct vc_data *c);
 static int vgacon_blank(struct vc_data *c, int blank, int mode_switch);
-static int vgacon_scrolldelta(struct vc_data *c, int lines);
+static void vgacon_scrolldelta(struct vc_data *c, int lines);
 static int vgacon_set_origin(struct vc_data *c);
 static void vgacon_save_screen(struct vc_data *c);
 static int vgacon_scroll(struct vc_data *c, int t, int b, int dir,
@@ -248,18 +248,18 @@ static void vgacon_restore_screen(struct vc_data *c)
 	}
 }
 
-static int vgacon_scrolldelta(struct vc_data *c, int lines)
+static void vgacon_scrolldelta(struct vc_data *c, int lines)
 {
 	int start, end, count, soff;
 
 	if (!lines) {
 		c->vc_visible_origin = c->vc_origin;
 		vga_set_mem_top(c);
-		return 1;
+		return;
 	}
 
 	if (!vgacon_scrollback)
-		return 1;
+		return;
 
 	if (!vgacon_scrollback_save) {
 		vgacon_cursor(c, CM_ERASE);
@@ -320,8 +320,6 @@ static int vgacon_scrolldelta(struct vc_data *c, int lines)
 			scr_memcpyw(d, s, diff * c->vc_size_row);
 	} else
 		vgacon_cursor(c, CM_MOVE);
-
-	return 1;
 }
 #else
 #define vgacon_scrollback_startup(...) do { } while (0)
@@ -334,7 +332,7 @@ static void vgacon_restore_screen(struct vc_data *c)
 		vgacon_scrolldelta(c, 0);
 }
 
-static int vgacon_scrolldelta(struct vc_data *c, int lines)
+static void vgacon_scrolldelta(struct vc_data *c, int lines)
 {
 	if (!lines)		/* Turn scrollback off */
 		c->vc_visible_origin = c->vc_origin;
@@ -362,7 +360,6 @@ static int vgacon_scrolldelta(struct vc_data *c, int lines)
 		c->vc_visible_origin = vga_vram_base + (p + ul) % we;
 	}
 	vga_set_mem_top(c);
-	return 1;
 }
 #endif /* CONFIG_VGACON_SOFT_SCROLLBACK */
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 98c8615dc300..d175de8d7006 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -28,6 +28,12 @@ struct tty_struct;
 #define VT100ID "\033[?1;2c"
 #define VT102ID "\033[?6c"
 
+/**
+ * struct consw - callbacks for consoles
+ *
+ * @con_scrolldelta: the contents of the console should be scrolled by @lines.
+ *		     Invoked by user. (optional)
+ */
 struct consw {
 	struct module *owner;
 	const char *(*con_startup)(void);
@@ -48,7 +54,7 @@ struct consw {
 	int     (*con_resize)(struct vc_data *, unsigned int, unsigned int,
 			       unsigned int);
 	int	(*con_set_palette)(struct vc_data *, const unsigned char *);
-	int	(*con_scrolldelta)(struct vc_data *, int);
+	void	(*con_scrolldelta)(struct vc_data *, int lines);
 	int	(*con_set_origin)(struct vc_data *);
 	void	(*con_save_screen)(struct vc_data *);
 	u8	(*con_build_attr)(struct vc_data *, u8, u8, u8, u8, u8, u8);
-- 
2.9.0
