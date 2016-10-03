From: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Subject: [PATCH 1/7] tty: vt, cleanup and document con_scroll
Date: Mon,  3 Oct 2016 11:18:33 +0200
Message-ID: <20161003091839.29379-1-jslaby@suse.cz>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Thomas Winischhofer <thomas-8tQO0IXuy4gnETEX8uN03g@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Scrolling helpers scrup and scrdown both accept 'top' and 'bottom' as
unsigned int. Number of lines 'nr' is accepted as int, but all callers
pass down unsigned too. So change the type of 'nr' to unsigned too.
Now, promote unsigned int from the helpers up to the con_scroll
hook which actually accepted all those as signed int.

Next, the 'dir' parameter can have only two values and we define
constants for that: SM_UP and SM_DOWN. Switch them to enum and do
proper type checking on 'dir' too.

Finally, document the behaviour of the hook.

Signed-off-by: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: Thomas Winischhofer <thomas-8tQO0IXuy4gnETEX8uN03g@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Cc: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>
Cc: <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
---
 drivers/tty/vt/vt.c                     |  6 ++++--
 drivers/usb/misc/sisusbvga/sisusb_con.c | 18 ++++++++++--------
 drivers/video/console/fbcon.c           | 18 ++++++++----------
 drivers/video/console/mdacon.c          |  7 ++++---
 drivers/video/console/newport_con.c     |  8 ++++----
 drivers/video/console/sticon.c          |  7 ++++---
 drivers/video/console/vgacon.c          | 12 +++++-------
 include/linux/console.h                 | 16 +++++++++++-----
 8 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e2cad4c2ba5a..a0ccb3950a50 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -315,7 +315,8 @@ void schedule_console_callback(void)
 	schedule_work(&console_work);
 }
 
-static void scrup(struct vc_data *vc, unsigned int t, unsigned int b, int nr)
+static void scrup(struct vc_data *vc, unsigned int t, unsigned int b,
+		unsigned int nr)
 {
 	unsigned short *d, *s;
 
@@ -332,7 +333,8 @@ static void scrup(struct vc_data *vc, unsigned int t, unsigned int b, int nr)
 		    vc->vc_size_row * nr);
 }
 
-static void scrdown(struct vc_data *vc, unsigned int t, unsigned int b, int nr)
+static void scrdown(struct vc_data *vc, unsigned int t, unsigned int b,
+		unsigned int nr)
 {
 	unsigned short *s;
 	unsigned int step;
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 460cebf322e3..6331965daa0b 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -808,9 +808,10 @@ sisusbcon_cursor(struct vc_data *c, int mode)
 	mutex_unlock(&sisusb->lock);
 }
 
-static int
+static bool
 sisusbcon_scroll_area(struct vc_data *c, struct sisusb_usb_data *sisusb,
-					int t, int b, int dir, int lines)
+		unsigned int t, unsigned int b, enum con_scroll dir,
+		unsigned int lines)
 {
 	int cols = sisusb->sisusb_num_columns;
 	int length = ((b - t) * cols) * 2;
@@ -852,8 +853,9 @@ sisusbcon_scroll_area(struct vc_data *c, struct sisusb_usb_data *sisusb,
 }
 
 /* Interface routine */
-static int
-sisusbcon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
+static bool
+sisusbcon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
+		enum con_scroll dir, unsigned int lines)
 {
 	struct sisusb_usb_data *sisusb;
 	u16 eattr = c->vc_video_erase_char;
@@ -870,17 +872,17 @@ sisusbcon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
 	 */
 
 	if (!lines)
-		return 1;
+		return true;
 
 	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
 	if (!sisusb)
-		return 0;
+		return false;
 
 	/* sisusb->lock is down */
 
 	if (sisusb_is_inactive(c, sisusb)) {
 		mutex_unlock(&sisusb->lock);
-		return 0;
+		return false;
 	}
 
 	/* Special case */
@@ -971,7 +973,7 @@ sisusbcon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
 
 	mutex_unlock(&sisusb->lock);
 
-	return 1;
+	return true;
 }
 
 /* Interface routine */
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index b87f5cfdaea5..a44f5627b82a 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -164,8 +164,6 @@ static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos);
 static void fbcon_clear_margins(struct vc_data *vc, int bottom_only);
 static void fbcon_cursor(struct vc_data *vc, int mode);
-static int fbcon_scroll(struct vc_data *vc, int t, int b, int dir,
-			int count);
 static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 			int height, int width);
 static int fbcon_switch(struct vc_data *vc);
@@ -1795,15 +1793,15 @@ static inline void fbcon_softback_note(struct vc_data *vc, int t,
 	softback_curr = softback_in;
 }
 
-static int fbcon_scroll(struct vc_data *vc, int t, int b, int dir,
-			int count)
+static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
+		enum con_scroll dir, unsigned int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
 
 	if (fbcon_is_inactive(vc, info))
-		return -EINVAL;
+		return true;
 
 	fbcon_cursor(vc, CM_ERASE);
 
@@ -1831,7 +1829,7 @@ static int fbcon_scroll(struct vc_data *vc, int t, int b, int dir,
 							(b - count)),
 				    vc->vc_video_erase_char,
 				    vc->vc_size_row * count);
-			return 1;
+			return true;
 			break;
 
 		case SCROLL_WRAP_MOVE:
@@ -1903,7 +1901,7 @@ static int fbcon_scroll(struct vc_data *vc, int t, int b, int dir,
 							(b - count)),
 				    vc->vc_video_erase_char,
 				    vc->vc_size_row * count);
-			return 1;
+			return true;
 		}
 		break;
 
@@ -1922,7 +1920,7 @@ static int fbcon_scroll(struct vc_data *vc, int t, int b, int dir,
 							t),
 				    vc->vc_video_erase_char,
 				    vc->vc_size_row * count);
-			return 1;
+			return true;
 			break;
 
 		case SCROLL_WRAP_MOVE:
@@ -1992,10 +1990,10 @@ static int fbcon_scroll(struct vc_data *vc, int t, int b, int dir,
 							t),
 				    vc->vc_video_erase_char,
 				    vc->vc_size_row * count);
-			return 1;
+			return true;
 		}
 	}
-	return 0;
+	return false;
 }
 
 
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 24fe55134eb5..d0d427a2f1a3 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -501,12 +501,13 @@ static void mdacon_cursor(struct vc_data *c, int mode)
 	}
 }
 
-static int mdacon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
+static bool mdacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
+		enum con_scroll dir, unsigned int lines)
 {
 	u16 eattr = mda_convert_attr(c->vc_video_erase_char);
 
 	if (!lines)
-		return 0;
+		return false;
 
 	if (lines > c->vc_rows)   /* maximum realistic size */
 		lines = c->vc_rows;
@@ -527,7 +528,7 @@ static int mdacon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
 		break;
 	}
 
-	return 0;
+	return false;
 }
 
 
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index e3b9521e4ec3..1e11614322fe 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -574,8 +574,8 @@ static int newport_font_set(struct vc_data *vc, struct console_font *font, unsig
 	return newport_set_font(vc->vc_num, font);
 }
 
-static int newport_scroll(struct vc_data *vc, int t, int b, int dir,
-			  int lines)
+static bool newport_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
+		enum con_scroll dir, unsigned int lines)
 {
 	int count, x, y;
 	unsigned short *s, *d;
@@ -595,7 +595,7 @@ static int newport_scroll(struct vc_data *vc, int t, int b, int dir,
 					    (vc->vc_color & 0xf0) >> 4);
 		}
 		npregs->cset.topscan = (topscan - 1) & 0x3ff;
-		return 0;
+		return false;
 	}
 
 	count = (b - t - lines) * vc->vc_cols;
@@ -670,7 +670,7 @@ static int newport_scroll(struct vc_data *vc, int t, int b, int dir,
 			}
 		}
 	}
-	return 1;
+	return true;
 }
 
 static int newport_dummy(struct vc_data *c)
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 3a10ac19598f..79c9bd8d3025 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -153,12 +153,13 @@ static void sticon_cursor(struct vc_data *conp, int mode)
     }
 }
 
-static int sticon_scroll(struct vc_data *conp, int t, int b, int dir, int count)
+static bool sticon_scroll(struct vc_data *conp, unsigned int t,
+		unsigned int b, enum con_scroll dir, unsigned int count)
 {
     struct sti_struct *sti = sticon_sti;
 
     if (vga_is_gfx)
-        return 0;
+        return false;
 
     sticon_cursor(conp, CM_ERASE);
 
@@ -174,7 +175,7 @@ static int sticon_scroll(struct vc_data *conp, int t, int b, int dir, int count)
 	break;
     }
 
-    return 0;
+    return false;
 }
 
 static void sticon_init(struct vc_data *c, int init)
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 11576611a974..4c54a873452e 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -83,8 +83,6 @@ static int vgacon_blank(struct vc_data *c, int blank, int mode_switch);
 static void vgacon_scrolldelta(struct vc_data *c, int lines);
 static int vgacon_set_origin(struct vc_data *c);
 static void vgacon_save_screen(struct vc_data *c);
-static int vgacon_scroll(struct vc_data *c, int t, int b, int dir,
-			 int lines);
 static void vgacon_invert_region(struct vc_data *c, u16 * p, int count);
 static struct uni_pagedir *vgacon_uni_pagedir;
 static int vgacon_refcount;
@@ -1350,17 +1348,17 @@ static void vgacon_save_screen(struct vc_data *c)
 			    c->vc_screenbuf_size > vga_vram_size ? vga_vram_size : c->vc_screenbuf_size);
 }
 
-static int vgacon_scroll(struct vc_data *c, int t, int b, int dir,
-			 int lines)
+static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
+		enum con_scroll dir, unsigned int lines)
 {
 	unsigned long oldo;
 	unsigned int delta;
 
 	if (t || b != c->vc_rows || vga_is_gfx || c->vc_mode != KD_TEXT)
-		return 0;
+		return false;
 
 	if (!vga_hardscroll_enabled || lines >= c->vc_rows / 2)
-		return 0;
+		return false;
 
 	vgacon_restore_screen(c);
 	oldo = c->vc_origin;
@@ -1396,7 +1394,7 @@ static int vgacon_scroll(struct vc_data *c, int t, int b, int dir,
 	c->vc_visible_origin = c->vc_origin;
 	vga_set_mem_top(c);
 	c->vc_pos = (c->vc_pos - oldo) + c->vc_origin;
-	return 1;
+	return true;
 }
 
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 3672809234a7..508b012bd5bd 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -28,9 +28,17 @@ struct tty_struct;
 #define VT100ID "\033[?1;2c"
 #define VT102ID "\033[?6c"
 
+enum con_scroll {
+	SM_UP,
+	SM_DOWN,
+};
+
 /**
  * struct consw - callbacks for consoles
  *
+ * @con_scroll: move lines from @top to @bottom in direction @dir by @lines.
+ *		Return true if no generic handling should be done.
+ *		Invoked by csi_M and printing to the console.
  * @con_set_palette: sets the palette of the console to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
@@ -44,7 +52,9 @@ struct consw {
 	void	(*con_putc)(struct vc_data *, int, int, int);
 	void	(*con_putcs)(struct vc_data *, const unsigned short *, int, int, int);
 	void	(*con_cursor)(struct vc_data *, int);
-	int	(*con_scroll)(struct vc_data *, int, int, int, int);
+	bool	(*con_scroll)(struct vc_data *, unsigned int top,
+			unsigned int bottom, enum con_scroll dir,
+			unsigned int lines);
 	int	(*con_switch)(struct vc_data *);
 	int	(*con_blank)(struct vc_data *, int, int);
 	int	(*con_font_set)(struct vc_data *, struct console_font *, unsigned);
@@ -99,10 +109,6 @@ static inline int con_debug_leave(void)
 }
 #endif
 
-/* scroll */
-#define SM_UP       (1)
-#define SM_DOWN     (2)
