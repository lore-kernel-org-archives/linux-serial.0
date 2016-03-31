From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/4] tty: vt, use proper type for default colors
Date: Thu, 31 Mar 2016 10:08:17 +0200
Message-ID: <1459411697-26019-4-git-send-email-jslaby@suse.cz>
References: <1459411697-26019-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459411697-26019-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Every user of default_red, default_grn, and default_blu treats them as
unsigned char. So make it really unsigned char.

And indent the initializers and module_param properly.

This saves ~ 100 bytes of data.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c       | 27 +++++++++++++++++----------
 include/linux/selection.h |  6 +++---
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2c71b3bde174..8f9f8ed3ed09 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1043,16 +1043,23 @@ const unsigned char color_table[] = { 0, 4, 2, 6, 1, 5, 3, 7,
 				       8,12,10,14, 9,13,11,15 };
 
 /* the default colour table, for VGA+ colour systems */
-int default_red[] = {0x00,0xaa,0x00,0xaa,0x00,0xaa,0x00,0xaa,
-    0x55,0xff,0x55,0xff,0x55,0xff,0x55,0xff};
-int default_grn[] = {0x00,0x00,0xaa,0x55,0x00,0x00,0xaa,0xaa,
-    0x55,0x55,0xff,0xff,0x55,0x55,0xff,0xff};
-int default_blu[] = {0x00,0x00,0x00,0x00,0xaa,0xaa,0xaa,0xaa,
-    0x55,0x55,0x55,0x55,0xff,0xff,0xff,0xff};
-
-module_param_array(default_red, int, NULL, S_IRUGO | S_IWUSR);
-module_param_array(default_grn, int, NULL, S_IRUGO | S_IWUSR);
-module_param_array(default_blu, int, NULL, S_IRUGO | S_IWUSR);
+unsigned char default_red[] = {
+	0x00, 0xaa, 0x00, 0xaa, 0x00, 0xaa, 0x00, 0xaa,
+	0x55, 0xff, 0x55, 0xff, 0x55, 0xff, 0x55, 0xff
+};
+module_param_array(default_red, byte, NULL, S_IRUGO | S_IWUSR);
+
+unsigned char default_grn[] = {
+	0x00, 0x00, 0xaa, 0x55, 0x00, 0x00, 0xaa, 0xaa,
+	0x55, 0x55, 0xff, 0xff, 0x55, 0x55, 0xff, 0xff
+};
+module_param_array(default_grn, byte, NULL, S_IRUGO | S_IWUSR);
+
+unsigned char default_blu[] = {
+	0x00, 0x00, 0x00, 0x00, 0xaa, 0xaa, 0xaa, 0xaa,
+	0x55, 0x55, 0x55, 0x55, 0xff, 0xff, 0xff, 0xff
+};
+module_param_array(default_blu, byte, NULL, S_IRUGO | S_IWUSR);
 
 /*
  * gotoxy() must verify all boundaries, because the arguments
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 7e6c4450b8a5..8e4624efdb6f 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -25,9 +25,9 @@ extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
 extern int console_blanked;
 
 extern const unsigned char color_table[];
-extern int default_red[];
-extern int default_grn[];
-extern int default_blu[];
+extern unsigned char default_red[];
+extern unsigned char default_grn[];
+extern unsigned char default_blu[];
 
 extern unsigned short *screen_pos(struct vc_data *vc, int w_offset, int viewed);
 extern u16 screen_glyph(struct vc_data *vc, int offset);
-- 
2.7.4
