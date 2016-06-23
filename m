From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/16] tty: vt, remove consw->con_bmove
Date: Thu, 23 Jun 2016 13:34:28 +0200
Message-ID: <20160623113437.28416-7-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Winischhofer <thomas@winischhofer.net>, linux-usb@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

It is never called since commit 81732c3b2fede (tty vt: Fix line
garbage in virtual console on command line edition) in 3.7. So remove
all the callbacks.

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
 drivers/usb/misc/sisusbvga/sisusb_con.c | 35 ---------------------------------
 drivers/video/console/dummycon.c        |  1 -
 drivers/video/console/fbcon.c           |  1 -
 drivers/video/console/mdacon.c          | 33 -------------------------------
 drivers/video/console/newport_con.c     | 29 ---------------------------
 drivers/video/console/sticon.c          | 17 ----------------
 drivers/video/console/vgacon.c          |  1 -
 include/linux/console.h                 |  1 -
 8 files changed, 118 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 4112835f4aed..52a6da991165 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -477,39 +477,6 @@ sisusbcon_clear(struct vc_data *c, int y, int x, int height, int width)
 	mutex_unlock(&sisusb->lock);
 }
 
-/* Interface routine */
-static void
-sisusbcon_bmove(struct vc_data *c, int sy, int sx,
-			 int dy, int dx, int height, int width)
-{
-	struct sisusb_usb_data *sisusb;
-	int cols, length;
-
-	if (width <= 0 || height <= 0)
-		return;
-
-	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
-	if (!sisusb)
-		return;
-
-	/* sisusb->lock is down */
-
-	cols = sisusb->sisusb_num_columns;
-
-	if (sisusb_is_inactive(c, sisusb)) {
-		mutex_unlock(&sisusb->lock);
-		return;
-	}
-
-	length = ((height * cols) - dx - (cols - width - dx)) * 2;
-
-
-	sisusb_copy_memory(sisusb, (unsigned char *)SISUSB_VADDR(dx, dy),
-				(long)SISUSB_HADDR(dx, dy), length);
-
-	mutex_unlock(&sisusb->lock);
-}
-
 /* interface routine */
 static int
 sisusbcon_switch(struct vc_data *c)
@@ -1371,7 +1338,6 @@ static const struct consw sisusb_con = {
 	.con_putcs =		sisusbcon_putcs,
 	.con_cursor =		sisusbcon_cursor,
 	.con_scroll =		sisusbcon_scroll,
-	.con_bmove =		sisusbcon_bmove,
 	.con_switch =		sisusbcon_switch,
 	.con_blank =		sisusbcon_blank,
 	.con_font_set =		sisusbcon_font_set,
@@ -1419,7 +1385,6 @@ static const struct consw sisusb_dummy_con = {
 	.con_putcs =		SISUSBCONDUMMY,
 	.con_cursor =		SISUSBCONDUMMY,
 	.con_scroll =		SISUSBCONDUMMY,
-	.con_bmove =		SISUSBCONDUMMY,
 	.con_switch =		SISUSBCONDUMMY,
 	.con_blank =		SISUSBCONDUMMY,
 	.con_font_set =		SISUSBCONDUMMY,
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 0ef544ef5634..9269d5685239 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -64,7 +64,6 @@ const struct consw dummy_con = {
     .con_putcs =	DUMMY,
     .con_cursor =	DUMMY,
     .con_scroll =	DUMMY,
-    .con_bmove =	DUMMY,
     .con_switch =	DUMMY,
     .con_blank =	DUMMY,
     .con_font_set =	DUMMY,
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 9359b06377cf..eef8a8b7274f 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3334,7 +3334,6 @@ static const struct consw fb_con = {
 	.con_putcs 		= fbcon_putcs,
 	.con_cursor 		= fbcon_cursor,
 	.con_scroll 		= fbcon_scroll,
-	.con_bmove 		= fbcon_bmove,
 	.con_switch 		= fbcon_switch,
 	.con_blank 		= fbcon_blank,
 	.con_font_set 		= fbcon_set_font,
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 1fe5245eb6dd..bacbb044d77c 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -444,38 +444,6 @@ static void mdacon_clear(struct vc_data *c, int y, int x,
 	}
 }
                         
-static void mdacon_bmove(struct vc_data *c, int sy, int sx, 
-			 int dy, int dx, int height, int width)
-{
-	u16 *src, *dest;
-
-	if (width <= 0 || height <= 0)
-		return;
-		
-	if (sx==0 && dx==0 && width==mda_num_columns) {
-		scr_memmovew(MDA_ADDR(0,dy), MDA_ADDR(0,sy), height*width*2);
-
-	} else if (dy < sy || (dy == sy && dx < sx)) {
-		src  = MDA_ADDR(sx, sy);
-		dest = MDA_ADDR(dx, dy);
-
-		for (; height > 0; height--) {
-			scr_memmovew(dest, src, width*2);
-			src  += mda_num_columns;
-			dest += mda_num_columns;
-		}
-	} else {
-		src  = MDA_ADDR(sx, sy+height-1);
-		dest = MDA_ADDR(dx, dy+height-1);
-
-		for (; height > 0; height--) {
-			scr_memmovew(dest, src, width*2);
-			src  -= mda_num_columns;
-			dest -= mda_num_columns;
-		}
-	}
-}
-
 static int mdacon_switch(struct vc_data *c)
 {
 	return 1;	/* redrawing needed */
@@ -564,7 +532,6 @@ static const struct consw mda_con = {
 	.con_putcs =		mdacon_putcs,
 	.con_cursor =		mdacon_cursor,
 	.con_scroll =		mdacon_scroll,
-	.con_bmove =		mdacon_bmove,
 	.con_switch =		mdacon_switch,
 	.con_blank =		mdacon_blank,
 	.con_build_attr =	mdacon_build_attr,
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index a436930f9e5d..e3b9521e4ec3 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -673,34 +673,6 @@ static int newport_scroll(struct vc_data *vc, int t, int b, int dir,
 	return 1;
 }
 
-static void newport_bmove(struct vc_data *vc, int sy, int sx, int dy,
-			  int dx, int h, int w)
-{
-	short xs, ys, xe, ye, xoffs, yoffs;
-
-	xs = sx << 3;
-	xe = ((sx + w) << 3) - 1;
-	/*
-	 * as bmove is only used to move stuff around in the same line
-	 * (h == 1), we don't care about wrap arounds caused by topscan != 0
-	 */
-	ys = ((sy << 4) + topscan) & 0x3ff;
-	ye = (((sy + h) << 4) - 1 + topscan) & 0x3ff;
-	xoffs = (dx - sx) << 3;
-	yoffs = (dy - sy) << 4;
-	if (xoffs > 0) {
-		/* move to the right, exchange starting points */
-		swap(xe, xs);
-	}
-	newport_wait(npregs);
-	npregs->set.drawmode0 = (NPORT_DMODE0_S2S | NPORT_DMODE0_BLOCK |
-				 NPORT_DMODE0_DOSETUP | NPORT_DMODE0_STOPX
-				 | NPORT_DMODE0_STOPY);
-	npregs->set.xystarti = (xs << 16) | ys;
-	npregs->set.xyendi = (xe << 16) | ye;
-	npregs->go.xymove = (xoffs << 16) | yoffs;
-}
-
 static int newport_dummy(struct vc_data *c)
 {
 	return 0;
@@ -718,7 +690,6 @@ const struct consw newport_con = {
 	.con_putcs	  = newport_putcs,
 	.con_cursor	  = newport_cursor,
 	.con_scroll	  = newport_scroll,
-	.con_bmove 	  = newport_bmove,
 	.con_switch	  = newport_switch,
 	.con_blank	  = newport_blank,
 	.con_font_set	  = newport_font_set,
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index fe7c4dbb676e..3a10ac19598f 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -177,22 +177,6 @@ static int sticon_scroll(struct vc_data *conp, int t, int b, int dir, int count)
     return 0;
 }
 
-static void sticon_bmove(struct vc_data *conp, int sy, int sx, 
-	int dy, int dx, int height, int width)
-{
-    if (!width || !height)
-	    return;
-#if 0
-    if (((sy <= p->cursor_y) && (p->cursor_y < sy+height) &&
-	(sx <= p->cursor_x) && (p->cursor_x < sx+width)) ||
-	((dy <= p->cursor_y) && (p->cursor_y < dy+height) &&
-	(dx <= p->cursor_x) && (p->cursor_x < dx+width)))
-		sticon_cursor(p, CM_ERASE /*|CM_SOFTBACK*/);
-#endif
-
-    sti_bmove(sticon_sti, sy, sx, dy, dx, height, width);
-}
-
 static void sticon_init(struct vc_data *c, int init)
 {
     struct sti_struct *sti = sticon_sti;
@@ -345,7 +329,6 @@ static const struct consw sti_con = {
 	.con_putcs		= sticon_putcs,
 	.con_cursor		= sticon_cursor,
 	.con_scroll		= sticon_scroll,
-	.con_bmove		= sticon_bmove,
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
 	.con_set_origin		= sticon_set_origin,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index aaae9bd23900..e280b3ceebd9 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1421,7 +1421,6 @@ const struct consw vga_con = {
 	.con_putcs = DUMMY,
 	.con_cursor = vgacon_cursor,
 	.con_scroll = vgacon_scroll,
-	.con_bmove = DUMMY,
 	.con_switch = vgacon_switch,
 	.con_blank = vgacon_blank,
 	.con_font_set = vgacon_font_set,
diff --git a/include/linux/console.h b/include/linux/console.h
index 382a527104c4..d530c4627e54 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -45,7 +45,6 @@ struct consw {
 	void	(*con_putcs)(struct vc_data *, const unsigned short *, int, int, int);
 	void	(*con_cursor)(struct vc_data *, int);
 	int	(*con_scroll)(struct vc_data *, int, int, int, int);
-	void	(*con_bmove)(struct vc_data *, int, int, int, int, int, int);
 	int	(*con_switch)(struct vc_data *);
 	int	(*con_blank)(struct vc_data *, int, int);
 	int	(*con_font_set)(struct vc_data *, struct console_font *, unsigned);
-- 
2.9.0
