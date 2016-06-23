From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/16] tty: vt, consw->con_set_palette cleanup
Date: Thu, 23 Jun 2016 13:34:27 +0200
Message-ID: <20160623113437.28416-6-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Winischhofer <thomas@winischhofer.net>, linux-usb@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

* allow NULL consw->con_set_palette (some consoles define an empty
  hook)
* => remove empty hooks now
* return value of consw->con_set_palette is never checked => make the
  function void
* document consw->con_set_palette a bit

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
 drivers/usb/misc/sisusbvga/sisusb_con.c | 11 ++++-------
 drivers/video/console/dummycon.c        |  1 -
 drivers/video/console/fbcon.c           | 10 +++++-----
 drivers/video/console/mdacon.c          |  6 ------
 drivers/video/console/newport_con.c     |  6 ------
 drivers/video/console/sticon.c          |  6 ------
 drivers/video/console/vgacon.c          |  7 ++-----
 include/linux/console.h                 |  4 +++-
 9 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 365a91d01a0e..d5d906051613 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3978,7 +3978,7 @@ static void set_palette(struct vc_data *vc)
 {
 	WARN_CONSOLE_UNLOCKED();
 
-	if (vc->vc_mode != KD_GRAPHICS)
+	if (vc->vc_mode != KD_GRAPHICS && vc->vc_sw->con_set_palette)
 		vc->vc_sw->con_set_palette(vc, color_table);
 }
 
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index a8244ebeb7a7..4112835f4aed 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -595,7 +595,7 @@ sisusbcon_save_screen(struct vc_data *c)
 }
 
 /* interface routine */
-static int
+static void
 sisusbcon_set_palette(struct vc_data *c, const unsigned char *table)
 {
 	struct sisusb_usb_data *sisusb;
@@ -604,17 +604,17 @@ sisusbcon_set_palette(struct vc_data *c, const unsigned char *table)
 	/* Return value not used by vt */
 
 	if (!CON_IS_VISIBLE(c))
-		return -EINVAL;
+		return;
 
 	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
 	if (!sisusb)
-		return -EINVAL;
+		return;
 
 	/* sisusb->lock is down */
 
 	if (sisusb_is_inactive(c, sisusb)) {
 		mutex_unlock(&sisusb->lock);
-		return -EINVAL;
+		return;
 	}
 
 	for (i = j = 0; i < 16; i++) {
@@ -629,8 +629,6 @@ sisusbcon_set_palette(struct vc_data *c, const unsigned char *table)
 	}
 
 	mutex_unlock(&sisusb->lock);
-
-	return 0;
 }
 
 /* interface routine */
@@ -1428,7 +1426,6 @@ static const struct consw sisusb_dummy_con = {
 	.con_font_get =		SISUSBCONDUMMY,
 	.con_font_default =	SISUSBCONDUMMY,
 	.con_font_copy =	SISUSBCONDUMMY,
-	.con_set_palette =	SISUSBCONDUMMY,
 };
 
 int
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 9ce03b9aba88..0ef544ef5634 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -71,6 +71,5 @@ const struct consw dummy_con = {
     .con_font_get =	DUMMY,
     .con_font_default =	DUMMY,
     .con_font_copy =	DUMMY,
-    .con_set_palette =	DUMMY,
 };
 EXPORT_SYMBOL_GPL(dummy_con);
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index eadc7bf62eb3..9359b06377cf 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -170,7 +170,7 @@ static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 			int height, int width);
 static int fbcon_switch(struct vc_data *vc);
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch);
-static int fbcon_set_palette(struct vc_data *vc, const unsigned char *table);
+static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table);
 
 /*
  *  Internal routines
@@ -2651,17 +2651,17 @@ static struct fb_cmap palette_cmap = {
 	0, 16, palette_red, palette_green, palette_blue, NULL
 };
 
-static int fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
+static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	int i, j, k, depth;
 	u8 val;
 
 	if (fbcon_is_inactive(vc, info))
-		return -EINVAL;
+		return;
 
 	if (!CON_IS_VISIBLE(vc))
-		return 0;
+		return;
 
 	depth = fb_get_color_depth(&info->var, &info->fix);
 	if (depth > 3) {
@@ -2683,7 +2683,7 @@ static int fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 	} else
 		fb_copy_cmap(fb_default_cmap(1 << depth), &palette_cmap);
 
-	return fb_set_cmap(&palette_cmap, info);
+	fb_set_cmap(&palette_cmap, info);
 }
 
 static u16 *fbcon_screen_pos(struct vc_data *vc, int offset)
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 234af26b4829..1fe5245eb6dd 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -481,11 +481,6 @@ static int mdacon_switch(struct vc_data *c)
 	return 1;	/* redrawing needed */
 }
 
-static int mdacon_set_palette(struct vc_data *c, const unsigned char *table)
-{
-	return -EINVAL;
-}
-
 static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
 {
 	if (mda_type == TYPE_MDA) {
@@ -572,7 +567,6 @@ static const struct consw mda_con = {
 	.con_bmove =		mdacon_bmove,
 	.con_switch =		mdacon_switch,
 	.con_blank =		mdacon_blank,
-	.con_set_palette =	mdacon_set_palette,
 	.con_build_attr =	mdacon_build_attr,
 	.con_invert_region =	mdacon_invert_region,
 };
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index eb3d4ce12cd5..a436930f9e5d 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -574,11 +574,6 @@ static int newport_font_set(struct vc_data *vc, struct console_font *font, unsig
 	return newport_set_font(vc->vc_num, font);
 }
 
-static int newport_set_palette(struct vc_data *vc, const unsigned char *table)
-{
-	return -EINVAL;
-}
-
 static int newport_scroll(struct vc_data *vc, int t, int b, int dir,
 			  int lines)
 {
@@ -728,7 +723,6 @@ const struct consw newport_con = {
 	.con_blank	  = newport_blank,
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
-	.con_set_palette  = newport_set_palette,
 	.con_set_origin	  = DUMMY,
 	.con_save_screen  = DUMMY
 };
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 20f6a2f5d4a7..fe7c4dbb676e 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -79,11 +79,6 @@ static const char *sticon_startup(void)
     return "STI console";
 }
 
-static int sticon_set_palette(struct vc_data *c, const unsigned char *table)
-{
-    return -EINVAL;
-}
-
 static void sticon_putc(struct vc_data *conp, int c, int ypos, int xpos)
 {
     int redraw_cursor = 0;
@@ -353,7 +348,6 @@ static const struct consw sti_con = {
 	.con_bmove		= sticon_bmove,
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
-	.con_set_palette	= sticon_set_palette,
 	.con_set_origin		= sticon_set_origin,
 	.con_save_screen	= sticon_save_screen, 
 	.con_build_attr		= sticon_build_attr,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index f447d6916991..aaae9bd23900 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -856,16 +856,13 @@ static void vga_set_palette(struct vc_data *vc, const unsigned char *table)
 	}
 }
 
-static int vgacon_set_palette(struct vc_data *vc, const unsigned char *table)
+static void vgacon_set_palette(struct vc_data *vc, const unsigned char *table)
 {
 #ifdef CAN_LOAD_PALETTE
 	if (vga_video_type != VIDEO_TYPE_VGAC || vga_palette_blanked
 	    || !CON_IS_VISIBLE(vc))
-		return -EINVAL;
+		return;
 	vga_set_palette(vc, table);
-	return 0;
-#else
-	return -EINVAL;
 #endif
 }
 
diff --git a/include/linux/console.h b/include/linux/console.h
index d175de8d7006..382a527104c4 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -31,6 +31,7 @@ struct tty_struct;
 /**
  * struct consw - callbacks for consoles
  *
+ * @con_set_palette: sets the palette of the console to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
  */
@@ -53,7 +54,8 @@ struct consw {
 	int	(*con_font_copy)(struct vc_data *, int);
 	int     (*con_resize)(struct vc_data *, unsigned int, unsigned int,
 			       unsigned int);
-	int	(*con_set_palette)(struct vc_data *, const unsigned char *);
+	void	(*con_set_palette)(struct vc_data *,
+			const unsigned char *table);
 	void	(*con_scrolldelta)(struct vc_data *, int lines);
 	int	(*con_set_origin)(struct vc_data *);
 	void	(*con_save_screen)(struct vc_data *);
-- 
2.9.0
