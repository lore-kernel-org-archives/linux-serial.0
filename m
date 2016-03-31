From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/4] tty: vt, make color_table const
Date: Thu, 31 Mar 2016 10:08:16 +0200
Message-ID: <1459411697-26019-3-git-send-email-jslaby@suse.cz>
References: <1459411697-26019-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459411697-26019-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

This means all ->con_set_palette have to have the second parameter
const too now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c                     | 2 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c | 2 +-
 drivers/video/console/fbcon.c           | 4 ++--
 drivers/video/console/mdacon.c          | 2 +-
 drivers/video/console/newport_con.c     | 2 +-
 drivers/video/console/sticon.c          | 2 +-
 drivers/video/console/vgacon.c          | 5 ++---
 include/linux/console.h                 | 2 +-
 include/linux/selection.h               | 2 +-
 9 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d1da391febb4..2c71b3bde174 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1039,7 +1039,7 @@ struct vc_data *vc_deallocate(unsigned int currcons)
 #define VT100ID "\033[?1;2c"
 #define VT102ID "\033[?6c"
 
-unsigned char color_table[] = { 0, 4, 2, 6, 1, 5, 3, 7,
+const unsigned char color_table[] = { 0, 4, 2, 6, 1, 5, 3, 7,
 				       8,12,10,14, 9,13,11,15 };
 
 /* the default colour table, for VGA+ colour systems */
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index ace343088915..afa853209f1d 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -601,7 +601,7 @@ sisusbcon_save_screen(struct vc_data *c)
 
 /* interface routine */
 static int
-sisusbcon_set_palette(struct vc_data *c, unsigned char *table)
+sisusbcon_set_palette(struct vc_data *c, const unsigned char *table)
 {
 	struct sisusb_usb_data *sisusb;
 	int i, j;
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 6e92917ba77a..afd3301ac40c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -170,7 +170,7 @@ static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 			int height, int width);
 static int fbcon_switch(struct vc_data *vc);
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch);
-static int fbcon_set_palette(struct vc_data *vc, unsigned char *table);
+static int fbcon_set_palette(struct vc_data *vc, const unsigned char *table);
 static int fbcon_scrolldelta(struct vc_data *vc, int lines);
 
 /*
@@ -2652,7 +2652,7 @@ static struct fb_cmap palette_cmap = {
 	0, 16, palette_red, palette_green, palette_blue, NULL
 };
 
-static int fbcon_set_palette(struct vc_data *vc, unsigned char *table)
+static int fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	int i, j, k, depth;
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 296e94561556..8edc062536a8 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -481,7 +481,7 @@ static int mdacon_switch(struct vc_data *c)
 	return 1;	/* redrawing needed */
 }
 
-static int mdacon_set_palette(struct vc_data *c, unsigned char *table)
+static int mdacon_set_palette(struct vc_data *c, const unsigned char *table)
 {
 	return -EINVAL;
 }
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index bb4e96255974..0553dfe684ef 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -574,7 +574,7 @@ static int newport_font_set(struct vc_data *vc, struct console_font *font, unsig
 	return newport_set_font(vc->vc_num, font);
 }
 
-static int newport_set_palette(struct vc_data *vc, unsigned char *table)
+static int newport_set_palette(struct vc_data *vc, const unsigned char *table)
 {
 	return -EINVAL;
 }
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 026fd1215933..e440c2d9fe7c 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -79,7 +79,7 @@ static const char *sticon_startup(void)
     return "STI console";
 }
 
-static int sticon_set_palette(struct vc_data *c, unsigned char *table)
+static int sticon_set_palette(struct vc_data *c, const unsigned char *table)
 {
     return -EINVAL;
 }
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 517f565b65d7..8bf911002cba 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -80,7 +80,6 @@ static void vgacon_deinit(struct vc_data *c);
 static void vgacon_cursor(struct vc_data *c, int mode);
 static int vgacon_switch(struct vc_data *c);
 static int vgacon_blank(struct vc_data *c, int blank, int mode_switch);
-static int vgacon_set_palette(struct vc_data *vc, unsigned char *table);
 static int vgacon_scrolldelta(struct vc_data *c, int lines);
 static int vgacon_set_origin(struct vc_data *c);
 static void vgacon_save_screen(struct vc_data *c);
@@ -847,7 +846,7 @@ static int vgacon_switch(struct vc_data *c)
 	return 0;		/* Redrawing not needed */
 }
 
-static void vga_set_palette(struct vc_data *vc, unsigned char *table)
+static void vga_set_palette(struct vc_data *vc, const unsigned char *table)
 {
 	int i, j;
 
@@ -860,7 +859,7 @@ static void vga_set_palette(struct vc_data *vc, unsigned char *table)
 	}
 }
 
-static int vgacon_set_palette(struct vc_data *vc, unsigned char *table)
+static int vgacon_set_palette(struct vc_data *vc, const unsigned char *table)
 {
 #ifdef CAN_LOAD_PALETTE
 	if (vga_video_type != VIDEO_TYPE_VGAC || vga_palette_blanked
diff --git a/include/linux/console.h b/include/linux/console.h
index ea731af2451e..137ac1a1c16f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -47,7 +47,7 @@ struct consw {
 	int	(*con_font_copy)(struct vc_data *, int);
 	int     (*con_resize)(struct vc_data *, unsigned int, unsigned int,
 			       unsigned int);
-	int	(*con_set_palette)(struct vc_data *, unsigned char *);
+	int	(*con_set_palette)(struct vc_data *, const unsigned char *);
 	int	(*con_scrolldelta)(struct vc_data *, int);
 	int	(*con_set_origin)(struct vc_data *);
 	void	(*con_save_screen)(struct vc_data *);
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 85193aa8c1e3..7e6c4450b8a5 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -24,7 +24,7 @@ extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
 
 extern int console_blanked;
 
-extern unsigned char color_table[];
+extern const unsigned char color_table[];
 extern int default_red[];
 extern int default_grn[];
 extern int default_blu[];
-- 
2.7.4
