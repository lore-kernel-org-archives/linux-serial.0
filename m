From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/16] sisusb: remove dummy variables
Date: Thu, 23 Jun 2016 13:34:25 +0200
Message-ID: <20160623113437.28416-4-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Winischhofer <thomas@winischhofer.net>, linux-usb@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

bytes_written parameter of sisusb_copy_memory and sisusb_read_memory
is an out parameter, but its value is never used. So remove it and
pass a dummy variable down to sisusb_read_mem_bulk.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/misc/sisusbvga/sisusb.c      | 28 +++++++++++++---------------
 drivers/usb/misc/sisusbvga/sisusb_con.c  | 28 ++++++++++------------------
 drivers/usb/misc/sisusbvga/sisusb_init.h |  2 +-
 3 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index 15666ad7c772..02abfcdfbf7b 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -1285,18 +1285,22 @@ int sisusb_readb(struct sisusb_usb_data *sisusb, u32 adr, u8 *data)
 }
 
 int sisusb_copy_memory(struct sisusb_usb_data *sisusb, char *src,
-		u32 dest, int length, size_t *bytes_written)
+		u32 dest, int length)
 {
+	size_t dummy;
+
 	return sisusb_write_mem_bulk(sisusb, dest, src, length,
-			NULL, 0, bytes_written);
+			NULL, 0, &dummy);
 }
 
 #ifdef SISUSBENDIANTEST
-int sisusb_read_memory(struct sisusb_usb_data *sisusb, char *dest,
-		u32 src, int length, size_t *bytes_written)
+static int sisusb_read_memory(struct sisusb_usb_data *sisusb, char *dest,
+		u32 src, int length)
 {
+	size_t dummy;
+
 	return sisusb_read_mem_bulk(sisusb, src, dest, length,
-			NULL, bytes_written);
+			NULL, &dummy);
 }
 #endif
 #endif
@@ -1306,16 +1310,14 @@ static void sisusb_testreadwrite(struct sisusb_usb_data *sisusb)
 {
 	static char srcbuffer[] = { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77 };
 	char destbuffer[10];
-	size_t dummy;
 	int i, j;
 
-	sisusb_copy_memory(sisusb, srcbuffer, sisusb->vrambase, 7, &dummy);
+	sisusb_copy_memory(sisusb, srcbuffer, sisusb->vrambase, 7);
 
 	for (i = 1; i <= 7; i++) {
 		dev_dbg(&sisusb->sisusb_dev->dev,
 				"sisusb: rwtest %d bytes\n", i);
-		sisusb_read_memory(sisusb, destbuffer, sisusb->vrambase,
-				i, &dummy);
+		sisusb_read_memory(sisusb, destbuffer, sisusb->vrambase, i);
 		for (j = 0; j < i; j++) {
 			dev_dbg(&sisusb->sisusb_dev->dev,
 					"rwtest read[%d] = %x\n",
@@ -2276,7 +2278,6 @@ int sisusb_reset_text_mode(struct sisusb_usb_data *sisusb, int init)
 	const struct font_desc *myfont;
 	u8 *tempbuf;
 	u16 *tempbufb;
-	size_t written;
 	static const char bootstring[] =
 		"SiSUSB VGA text console, (C) 2005 Thomas Winischhofer.";
 	static const char bootlogo[] = "(o_ //\\ V_/_";
@@ -2343,18 +2344,15 @@ int sisusb_reset_text_mode(struct sisusb_usb_data *sisusb, int init)
 				*(tempbufb++) = 0x0700 | bootstring[i++];
 
 			ret |= sisusb_copy_memory(sisusb, tempbuf,
-					sisusb->vrambase, 8192, &written);
+					sisusb->vrambase, 8192);
 
 			vfree(tempbuf);
 
 		}
 
 	} else if (sisusb->scrbuf) {
-
 		ret |= sisusb_copy_memory(sisusb, (char *)sisusb->scrbuf,
-				sisusb->vrambase, sisusb->scrbuf_size,
-				&written);
-
+				sisusb->vrambase, sisusb->scrbuf_size);
 	}
 
 	if (sisusb->sisusb_cursor_size_from >= 0 &&
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index afa853209f1d..0ebbf49cd649 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -370,7 +370,6 @@ static void
 sisusbcon_putc(struct vc_data *c, int ch, int y, int x)
 {
 	struct sisusb_usb_data *sisusb;
-	ssize_t written;
 
 	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
 	if (!sisusb)
@@ -384,7 +383,7 @@ sisusbcon_putc(struct vc_data *c, int ch, int y, int x)
 
 
 	sisusb_copy_memory(sisusb, (char *)SISUSB_VADDR(x, y),
-				(long)SISUSB_HADDR(x, y), 2, &written);
+				(long)SISUSB_HADDR(x, y), 2);
 
 	mutex_unlock(&sisusb->lock);
 }
@@ -395,7 +394,6 @@ sisusbcon_putcs(struct vc_data *c, const unsigned short *s,
 		         int count, int y, int x)
 {
 	struct sisusb_usb_data *sisusb;
-	ssize_t written;
 	u16 *dest;
 	int i;
 
@@ -420,7 +418,7 @@ sisusbcon_putcs(struct vc_data *c, const unsigned short *s,
 	}
 
 	sisusb_copy_memory(sisusb, (char *)SISUSB_VADDR(x, y),
-				(long)SISUSB_HADDR(x, y), count * 2, &written);
+				(long)SISUSB_HADDR(x, y), count * 2);
 
 	mutex_unlock(&sisusb->lock);
 }
@@ -431,7 +429,6 @@ sisusbcon_clear(struct vc_data *c, int y, int x, int height, int width)
 {
 	struct sisusb_usb_data *sisusb;
 	u16 eattr = c->vc_video_erase_char;
-	ssize_t written;
 	int i, length, cols;
 	u16 *dest;
 
@@ -475,7 +472,7 @@ sisusbcon_clear(struct vc_data *c, int y, int x, int height, int width)
 
 
 	sisusb_copy_memory(sisusb, (unsigned char *)SISUSB_VADDR(x, y),
-				(long)SISUSB_HADDR(x, y), length, &written);
+				(long)SISUSB_HADDR(x, y), length);
 
 	mutex_unlock(&sisusb->lock);
 }
@@ -486,7 +483,6 @@ sisusbcon_bmove(struct vc_data *c, int sy, int sx,
 			 int dy, int dx, int height, int width)
 {
 	struct sisusb_usb_data *sisusb;
-	ssize_t written;
 	int cols, length;
 
 	if (width <= 0 || height <= 0)
@@ -509,7 +505,7 @@ sisusbcon_bmove(struct vc_data *c, int sy, int sx,
 
 
 	sisusb_copy_memory(sisusb, (unsigned char *)SISUSB_VADDR(dx, dy),
-				(long)SISUSB_HADDR(dx, dy), length, &written);
+				(long)SISUSB_HADDR(dx, dy), length);
 
 	mutex_unlock(&sisusb->lock);
 }
@@ -519,7 +515,6 @@ static int
 sisusbcon_switch(struct vc_data *c)
 {
 	struct sisusb_usb_data *sisusb;
-	ssize_t written;
 	int length;
 
 	/* Returnvalue 0 means we have fully restored screen,
@@ -559,7 +554,7 @@ sisusbcon_switch(struct vc_data *c)
 
 	sisusb_copy_memory(sisusb, (unsigned char *)c->vc_origin,
 				(long)SISUSB_HADDR(0, 0),
-				length, &written);
+				length);
 
 	mutex_unlock(&sisusb->lock);
 
@@ -644,7 +639,6 @@ sisusbcon_blank(struct vc_data *c, int blank, int mode_switch)
 {
 	struct sisusb_usb_data *sisusb;
 	u8 sr1, cr17, pmreg, cr63;
-	ssize_t written;
 	int ret = 0;
 
 	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
@@ -672,7 +666,7 @@ sisusbcon_blank(struct vc_data *c, int blank, int mode_switch)
 				(unsigned char *)c->vc_origin,
 				(u32)(sisusb->vrambase +
 					(c->vc_origin - sisusb->scrbuf)),
-				c->vc_screenbuf_size, &written);
+				c->vc_screenbuf_size);
 		sisusb->con_blanked = 1;
 		ret = 1;
 		break;
@@ -860,7 +854,6 @@ sisusbcon_scroll_area(struct vc_data *c, struct sisusb_usb_data *sisusb,
 	int cols = sisusb->sisusb_num_columns;
 	int length = ((b - t) * cols) * 2;
 	u16 eattr = c->vc_video_erase_char;
-	ssize_t written;
 
 	/* sisusb->lock is down */
 
@@ -890,7 +883,7 @@ sisusbcon_scroll_area(struct vc_data *c, struct sisusb_usb_data *sisusb,
 	}
 
 	sisusb_copy_memory(sisusb, (char *)SISUSB_VADDR(0, t),
-				(long)SISUSB_HADDR(0, t), length, &written);
+				(long)SISUSB_HADDR(0, t), length);
 
 	mutex_unlock(&sisusb->lock);
 
@@ -903,7 +896,6 @@ sisusbcon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
 {
 	struct sisusb_usb_data *sisusb;
 	u16 eattr = c->vc_video_erase_char;
-	ssize_t written;
 	int copyall = 0;
 	unsigned long oldorigin;
 	unsigned int delta = lines * c->vc_size_row;
@@ -996,18 +988,18 @@ sisusbcon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
 		sisusb_copy_memory(sisusb,
 			(char *)c->vc_origin,
 			(u32)(sisusb->vrambase + originoffset),
-			c->vc_screenbuf_size, &written);
+			c->vc_screenbuf_size);
 	else if (dir == SM_UP)
 		sisusb_copy_memory(sisusb,
 			(char *)c->vc_origin + c->vc_screenbuf_size - delta,
 			(u32)sisusb->vrambase + originoffset +
 					c->vc_screenbuf_size - delta,
-			delta, &written);
+			delta);
 	else
 		sisusb_copy_memory(sisusb,
 			(char *)c->vc_origin,
 			(u32)(sisusb->vrambase + originoffset),
-			delta, &written);
+			delta);
 
 	c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 	c->vc_visible_origin = c->vc_origin;
diff --git a/drivers/usb/misc/sisusbvga/sisusb_init.h b/drivers/usb/misc/sisusbvga/sisusb_init.h
index c46ce42d4489..e79a616f0d26 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_init.h
+++ b/drivers/usb/misc/sisusbvga/sisusb_init.h
@@ -828,7 +828,7 @@ void sisusb_delete(struct kref *kref);
 int sisusb_writeb(struct sisusb_usb_data *sisusb, u32 adr, u8 data);
 int sisusb_readb(struct sisusb_usb_data *sisusb, u32 adr, u8 * data);
 int sisusb_copy_memory(struct sisusb_usb_data *sisusb, char *src,
-		       u32 dest, int length, size_t * bytes_written);
+		       u32 dest, int length);
 int sisusb_reset_text_mode(struct sisusb_usb_data *sisusb, int init);
 int sisusbcon_do_font_op(struct sisusb_usb_data *sisusb, int set, int slot,
 			 u8 * arg, int cmapsz, int ch512, int dorecalc,
-- 
2.9.0
