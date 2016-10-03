From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/7] vgacon: switch boolean variables to bool
Date: Mon,  3 Oct 2016 11:18:38 +0200
Message-ID: <20161003091839.29379-6-jslaby@suse.cz>
References: <20161003091839.29379-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161003091839.29379-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

These variables:
* vga_can_do_color
* vgacon_text_mode_force
* vga_font_is_default
* vga_hardscroll_enabled
* vga_hardscroll_user_enable
* vga_init_done
* vga_is_gfx
* vga_palette_blanked
* vga_512_chars
are used exclusively as a boolean value, so make them really a bool.

Remove also useless "? true : false".

__read_mostly annotations removed too as they obfuscate the code and I
doubt they improve anything measurable given the variables are used
from .con_scroll, .con_startup and such.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>
---
 drivers/video/console/vgacon.c | 45 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index ede6a5a85ccd..d13d5d372604 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -88,7 +88,7 @@ static struct uni_pagedir *vgacon_uni_pagedir;
 static int vgacon_refcount;
 
 /* Description of the hardware situation */
-static int		vga_init_done		__read_mostly;
+static bool		vga_init_done;
 static unsigned long	vga_vram_base		__read_mostly;	/* Base of video memory */
 static unsigned long	vga_vram_end		__read_mostly;	/* End of video memory */
 static unsigned int	vga_vram_size		__read_mostly;	/* Size of video memory */
@@ -96,31 +96,31 @@ static u16		vga_video_port_reg	__read_mostly;	/* Video register select port */
 static u16		vga_video_port_val	__read_mostly;	/* Video register value port */
 static unsigned int	vga_video_num_columns;			/* Number of text columns */
 static unsigned int	vga_video_num_lines;			/* Number of text lines */
-static int		vga_can_do_color	__read_mostly;	/* Do we support colors? */
+static bool		vga_can_do_color;			/* Do we support colors? */
 static unsigned int	vga_default_font_height __read_mostly;	/* Height of default screen font */
 static unsigned char	vga_video_type		__read_mostly;	/* Card type */
-static unsigned char	vga_hardscroll_enabled	__read_mostly;
-static unsigned char	vga_hardscroll_user_enable __read_mostly = 1;
-static unsigned char	vga_font_is_default = 1;
+static bool		vga_font_is_default = true;
 static int		vga_vesa_blanked;
-static int 		vga_palette_blanked;
-static int 		vga_is_gfx;
-static int 		vga_512_chars;
+static bool 		vga_palette_blanked;
+static bool 		vga_is_gfx;
+static bool 		vga_512_chars;
 static int 		vga_video_font_height;
 static int 		vga_scan_lines		__read_mostly;
 static unsigned int 	vga_rolled_over;
 
-static int vgacon_text_mode_force;
+static bool vgacon_text_mode_force;
+static bool vga_hardscroll_enabled;
+static bool vga_hardscroll_user_enable = true;
 
 bool vgacon_text_force(void)
 {
-	return vgacon_text_mode_force ? true : false;
+	return vgacon_text_mode_force;
 }
 EXPORT_SYMBOL(vgacon_text_force);
 
 static int __init text_mode(char *str)
 {
-	vgacon_text_mode_force = 1;
+	vgacon_text_mode_force = true;
 	return 1;
 }
 
@@ -134,7 +134,7 @@ static int __init no_scroll(char *str)
 	 * Braille reader made by F.H. Papenmeier (Germany).
 	 * Use the "no-scroll" bootflag.
 	 */
-	vga_hardscroll_user_enable = vga_hardscroll_enabled = 0;
+	vga_hardscroll_user_enable = vga_hardscroll_enabled = false;
 	return 1;
 }
 
@@ -402,7 +402,7 @@ static const char *vgacon_startup(void)
 		}
 	} else {
 		/* If not, it is color. */
-		vga_can_do_color = 1;
+		vga_can_do_color = true;
 		vga_vram_base = 0xb8000;
 		vga_video_port_reg = VGA_CRT_IC;
 		vga_video_port_val = VGA_CRT_DC;
@@ -517,7 +517,7 @@ static const char *vgacon_startup(void)
 
 	if (!vga_init_done) {
 		vgacon_scrollback_startup();
-		vga_init_done = 1;
+		vga_init_done = true;
 	}
 
 	return display_desc;
@@ -609,7 +609,7 @@ static u8 vgacon_build_attr(struct vc_data *c, u8 color, u8 intensity,
 
 static void vgacon_invert_region(struct vc_data *c, u16 * p, int count)
 {
-	int col = vga_can_do_color;
+	const bool col = vga_can_do_color;
 
 	while (count--) {
 		u16 a = scr_readw(p);
@@ -981,24 +981,24 @@ static int vgacon_blank(struct vc_data *c, int blank, int mode_switch)
 		}
 		if (vga_palette_blanked) {
 			vga_set_palette(c, color_table);
-			vga_palette_blanked = 0;
+			vga_palette_blanked = false;
 			return 0;
 		}
-		vga_is_gfx = 0;
+		vga_is_gfx = false;
 		/* Tell console.c that it has to restore the screen itself */
 		return 1;
 	case 1:		/* Normal blanking */
 	case -1:	/* Obsolete */
 		if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
 			vga_pal_blank(&vgastate);
-			vga_palette_blanked = 1;
+			vga_palette_blanked = true;
 			return 0;
 		}
 		vgacon_set_origin(c);
 		scr_memsetw((void *) vga_vram_base, BLANK,
 			    c->vc_screenbuf_size);
 		if (mode_switch)
-			vga_is_gfx = 1;
+			vga_is_gfx = true;
 		return 1;
 	default:		/* VESA blanking */
 		if (vga_video_type == VIDEO_TYPE_VGAC) {
@@ -1029,7 +1029,8 @@ static int vgacon_blank(struct vc_data *c, int blank, int mode_switch)
 #define blackwmap 0xa0000
 #define cmapsz 8192
 
-static int vgacon_do_font_op(struct vgastate *state,char *arg,int set,int ch512)
+static int vgacon_do_font_op(struct vgastate *state, char *arg, int set,
+		bool ch512)
 {
 	unsigned short video_port_status = vga_video_port_reg + 6;
 	int font_select = 0x00, beg, i;
@@ -1055,7 +1056,7 @@ static int vgacon_do_font_op(struct vgastate *state,char *arg,int set,int ch512)
 	if (!arg)
 		return -EINVAL;	/* Return to default font not supported */
 
-	vga_font_is_default = 0;
+	vga_font_is_default = false;
 	font_select = ch512 ? 0x04 : 0x00;
 #else
 	/*
@@ -1066,7 +1067,7 @@ static int vgacon_do_font_op(struct vgastate *state,char *arg,int set,int ch512)
 	if (set) {
 		vga_font_is_default = !arg;
 		if (!arg)
-			ch512 = 0;	/* Default font is always 256 */
+			ch512 = false;	/* Default font is always 256 */
 		font_select = arg ? (ch512 ? 0x0e : 0x0a) : 0x00;
 	}
 
-- 
2.10.0
