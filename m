From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 7/7] vgacon: remove prehistoric macros
Date: Mon,  3 Oct 2016 11:18:39 +0200
Message-ID: <20161003091839.29379-7-jslaby@suse.cz>
References: <20161003091839.29379-1-jslaby@suse.cz>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20161003091839.29379-1-jslaby@suse.cz>
Sender: linux-doc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

These macros:
* CAN_LOAD_EGA_FONTS
* CAN_LOAD_PALETTE
* TRIDENT_GLITCH
* VGA_CAN_DO_64KB
* SLOW_VGA
are either always set or always unset. They come from the linux 2.1
times. And given nobody switched them to some configurable options, I
assume nobody actually uses them.

So remove the macros and leave in place appropriate branches of the
conditional code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>
Cc: <linux-doc@vger.kernel.org>
---
 Documentation/VGA-softcursor.txt | 12 ++++------
 drivers/video/console/vgacon.c   | 49 ----------------------------------------
 2 files changed, 5 insertions(+), 56 deletions(-)

diff --git a/Documentation/VGA-softcursor.txt b/Documentation/VGA-softcursor.txt
index 70acfbf399eb..2ea8968b64a6 100644
--- a/Documentation/VGA-softcursor.txt
+++ b/Documentation/VGA-softcursor.txt
@@ -2,13 +2,11 @@ Software cursor for VGA    by Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>
 =======================    and Martin Mares <mj@atrey.karlin.mff.cuni.cz>
 
    Linux now has some ability to manipulate cursor appearance. Normally, you
-can set the size of hardware cursor (and also work around some ugly bugs in
-those miserable Trident cards--see #define TRIDENT_GLITCH in drivers/video/
-vgacon.c). You can now play a few new tricks:  you can make your cursor look
-like a non-blinking red block, make it inverse background of the character it's
-over or to highlight that character and still choose whether the original
-hardware cursor should remain visible or not.  There may be other things I have
-never thought of.
+can set the size of hardware cursor. You can now play a few new tricks:  you
+can make your cursor look like a non-blinking red block, make it inverse
+background of the character it's over or to highlight that character and still
+choose whether the original hardware cursor should remain visible or not.
+There may be other things I have never thought of.
 
    The cursor appearance is controlled by a "<ESC>[?1;2;3c" escape sequence
 where 1, 2 and 3 are parameters described below. If you omit any of them,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index d13d5d372604..c22a56232b7c 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -60,15 +60,6 @@ static struct vgastate vgastate;
 
 #define BLANK 0x0020
 
-#define CAN_LOAD_EGA_FONTS	/* undefine if the user must not do this */
-#define CAN_LOAD_PALETTE	/* undefine if the user must not do this */
-
-/* You really do _NOT_ want to define this, unless you have buggy
- * Trident VGA which will resize cursor when moving it between column
- * 15 & 16. If you define this and your VGA is OK, inverse bug will
- * appear.
- */
-#undef TRIDENT_GLITCH
 #define VGA_FONTWIDTH       8   /* VGA does not support fontwidths != 8 */
 /*
  *  Interface used by the world
@@ -157,18 +148,10 @@ static inline void write_vga(unsigned char reg, unsigned int val)
 	 * handlers, thus the write has to be IRQ-atomic.
 	 */
 	raw_spin_lock_irqsave(&vga_lock, flags);
-
-#ifndef SLOW_VGA
 	v1 = reg + (val & 0xff00);
 	v2 = reg + 1 + ((val << 8) & 0xff00);
 	outw(v1, vga_video_port_reg);
 	outw(v2, vga_video_port_reg);
-#else
-	outb_p(reg, vga_video_port_reg);
-	outb_p(val >> 8, vga_video_port_val);
-	outb_p(reg + 1, vga_video_port_reg);
-	outb_p(val & 0xff, vga_video_port_val);
-#endif
 	raw_spin_unlock_irqrestore(&vga_lock, flags);
 }
 
@@ -426,18 +409,6 @@ static const char *vgacon_startup(void)
 				request_resource(&ioport_resource,
 						 &vga_console_resource);
 
-#ifdef VGA_CAN_DO_64KB
-				/*
-				 * get 64K rather than 32K of video RAM.
-				 * This doesn't actually work on all "VGA"
-				 * controllers (it seems like setting MM=01
-				 * and COE=1 isn't necessarily a good idea)
-				 */
-				vga_vram_base = 0xa0000;
-				vga_vram_size = 0x10000;
-				outb_p(6, VGA_GFX_I);
-				outb_p(6, VGA_GFX_D);
-#endif
 				/*
 				 * Normalise the palette registers, to point
 				 * the 16 screen colours to the first 16
@@ -627,11 +598,6 @@ static void vgacon_set_cursor_size(int xpos, int from, int to)
 	unsigned long flags;
 	int curs, cure;
 
-#ifdef TRIDENT_GLITCH
-	if (xpos < 16)
-		from--, to--;
-#endif
-
 	if ((from == cursor_size_lastfrom) && (to == cursor_size_lastto))
 		return;
 	cursor_size_lastfrom = from;
@@ -833,12 +799,10 @@ static void vga_set_palette(struct vc_data *vc, const unsigned char *table)
 
 static void vgacon_set_palette(struct vc_data *vc, const unsigned char *table)
 {
-#ifdef CAN_LOAD_PALETTE
 	if (vga_video_type != VIDEO_TYPE_VGAC || vga_palette_blanked
 	    || !con_is_visible(vc))
 		return;
 	vga_set_palette(vc, table);
-#endif
 }
 
 /* structure holding original VGA register settings */
@@ -1021,8 +985,6 @@ static int vgacon_blank(struct vc_data *c, int blank, int mode_switch)
  * (sizif@botik.yaroslavl.su).
  */
 
-#ifdef CAN_LOAD_EGA_FONTS
-
 #define colourmap 0xa0000
 /* Pauline Middelink <middelin@polyware.iaf.nl> reports that we
    should use 0xA0000 for the bwmap as well.. */
@@ -1039,10 +1001,6 @@ static int vgacon_do_font_op(struct vgastate *state, char *arg, int set,
 	if (vga_video_type != VIDEO_TYPE_EGAM) {
 		charmap = (char *) VGA_MAP_MEM(colourmap, 0);
 		beg = 0x0e;
-#ifdef VGA_CAN_DO_64KB
-		if (vga_video_type == VIDEO_TYPE_VGAC)
-			beg = 0x06;
-#endif
 	} else {
 		charmap = (char *) VGA_MAP_MEM(blackwmap, 0);
 		beg = 0x0a;
@@ -1271,13 +1229,6 @@ static int vgacon_font_get(struct vc_data *c, struct console_font *font)
 	return vgacon_do_font_op(&vgastate, font->data, 0, vga_512_chars);
 }
 
-#else
-
-#define vgacon_font_set NULL
-#define vgacon_font_get NULL
-
-#endif
-
 static int vgacon_resize(struct vc_data *c, unsigned int width,
 			 unsigned int height, unsigned int user)
 {
-- 
2.10.0

