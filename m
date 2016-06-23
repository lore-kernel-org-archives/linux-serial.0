From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/16] tty: vt, get rid of ugly FLUSH macro
Date: Thu, 23 Jun 2016 13:34:30 +0200
Message-ID: <20160623113437.28416-9-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

It's a macro accessing and changing some local variables. And the code
uses it without appending semicolon which confuses everybody too.

Switch from this bad guy to a sane standard function.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 600c3bb706a5..6e12d9c0ea41 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2163,14 +2163,20 @@ static int is_double_width(uint32_t ucs)
 	return bisearch(ucs, double_width, ARRAY_SIZE(double_width) - 1);
 }
 
+static void con_flush(struct vc_data *vc, unsigned long draw_from,
+		unsigned long draw_to, int *draw_x)
+{
+	if (*draw_x < 0)
+		return;
+
+	vc->vc_sw->con_putcs(vc, (u16 *)draw_from,
+			(u16 *)draw_to - (u16 *)draw_from, vc->vc_y, *draw_x);
+	*draw_x = -1;
+}
+
 /* acquires console_lock */
 static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
-#define FLUSH if (draw_x >= 0) { \
-	vc->vc_sw->con_putcs(vc, (u16 *)draw_from, (u16 *)draw_to - (u16 *)draw_from, vc->vc_y, draw_x); \
-	draw_x = -1; \
-	}
-
 	int c, tc, ok, n = 0, draw_x = -1;
 	unsigned int currcons;
 	unsigned long draw_from = 0, draw_to = 0;
@@ -2362,12 +2368,13 @@ rescan_last_byte:
 				} else {
 					vc_attr = ((vc->vc_attr) & 0x88) | (((vc->vc_attr) & 0x70) >> 4) | (((vc->vc_attr) & 0x07) << 4);
 				}
-				FLUSH
+				con_flush(vc, draw_from, draw_to, &draw_x);
 			}
 
 			while (1) {
 				if (vc->vc_need_wrap || vc->vc_decim)
-					FLUSH
+					con_flush(vc, draw_from, draw_to,
+							&draw_x);
 				if (vc->vc_need_wrap) {
 					cr(vc);
 					lf(vc);
@@ -2397,9 +2404,8 @@ rescan_last_byte:
 			}
 			notify_write(vc, c);
 
-			if (inverse) {
-				FLUSH
-			}
+			if (inverse)
+				con_flush(vc, draw_from, draw_to, &draw_x);
 
 			if (rescan) {
 				rescan = 0;
@@ -2410,15 +2416,14 @@ rescan_last_byte:
 			}
 			continue;
 		}
-		FLUSH
+		con_flush(vc, draw_from, draw_to, &draw_x);
 		do_con_trol(tty, vc, orig);
 	}
-	FLUSH
+	con_flush(vc, draw_from, draw_to, &draw_x);
 	console_conditional_schedule();
 	console_unlock();
 	notify_update(vc);
 	return n;
-#undef FLUSH
 }
 
 /*
-- 
2.9.0
