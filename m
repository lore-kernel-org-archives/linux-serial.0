From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/7] tty: vt, unify scrolling functions
Date: Mon,  3 Oct 2016 11:18:34 +0200
Message-ID: <20161003091839.29379-2-jslaby@suse.cz>
References: <20161003091839.29379-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161003091839.29379-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Both scrup and scrdown are copies of the same code except source and
destination pointers computation. Unify those functions into a single
one named con_scroll.

Note that scrdown used step to compute the destination, while scrup
did the computation explicitly. We sticked to the latter here.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 47 +++++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a0ccb3950a50..ecabed91f444 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -315,40 +315,27 @@ void schedule_console_callback(void)
 	schedule_work(&console_work);
 }
 
-static void scrup(struct vc_data *vc, unsigned int t, unsigned int b,
-		unsigned int nr)
+static void con_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
+		enum con_scroll dir, unsigned int nr)
 {
-	unsigned short *d, *s;
+	u16 *clear, *d, *s;
 
-	if (t+nr >= b)
+	if (t + nr >= b)
 		nr = b - t - 1;
 	if (b > vc->vc_rows || t >= b || nr < 1)
 		return;
-	if (con_is_visible(vc) && vc->vc_sw->con_scroll(vc, t, b, SM_UP, nr))
+	if (con_is_visible(vc) && vc->vc_sw->con_scroll(vc, t, b, dir, nr))
 		return;
-	d = (unsigned short *)(vc->vc_origin + vc->vc_size_row * t);
-	s = (unsigned short *)(vc->vc_origin + vc->vc_size_row * (t + nr));
-	scr_memmovew(d, s, (b - t - nr) * vc->vc_size_row);
-	scr_memsetw(d + (b - t - nr) * vc->vc_cols, vc->vc_video_erase_char,
-		    vc->vc_size_row * nr);
-}
 
-static void scrdown(struct vc_data *vc, unsigned int t, unsigned int b,
-		unsigned int nr)
-{
-	unsigned short *s;
-	unsigned int step;
+	s = clear = (u16 *)(vc->vc_origin + vc->vc_size_row * t);
+	d = (u16 *)(vc->vc_origin + vc->vc_size_row * (t + nr));
 
-	if (t+nr >= b)
-		nr = b - t - 1;
-	if (b > vc->vc_rows || t >= b || nr < 1)
-		return;
-	if (con_is_visible(vc) && vc->vc_sw->con_scroll(vc, t, b, SM_DOWN, nr))
-		return;
-	s = (unsigned short *)(vc->vc_origin + vc->vc_size_row * t);
-	step = vc->vc_cols * nr;
-	scr_memmovew(s + step, s, (b - t - nr) * vc->vc_size_row);
-	scr_memsetw(s, vc->vc_video_erase_char, 2 * step);
+	if (dir == SM_UP) {
+		clear = s + (b - t - nr) * vc->vc_cols;
+		swap(s, d);
+	}
+	scr_memmovew(d, s, (b - t - nr) * vc->vc_size_row);
+	scr_memsetw(clear, vc->vc_video_erase_char, vc->vc_size_row * nr);
 }
 
 static void do_update_region(struct vc_data *vc, unsigned long start, int count)
@@ -1117,7 +1104,7 @@ static void lf(struct vc_data *vc)
 	 * if below scrolling region
 	 */
     	if (vc->vc_y + 1 == vc->vc_bottom)
-		scrup(vc, vc->vc_top, vc->vc_bottom, 1);
+		con_scroll(vc, vc->vc_top, vc->vc_bottom, SM_UP, 1);
 	else if (vc->vc_y < vc->vc_rows - 1) {
 	    	vc->vc_y++;
 		vc->vc_pos += vc->vc_size_row;
@@ -1132,7 +1119,7 @@ static void ri(struct vc_data *vc)
 	 * if above scrolling region
 	 */
 	if (vc->vc_y == vc->vc_top)
-		scrdown(vc, vc->vc_top, vc->vc_bottom, 1);
+		con_scroll(vc, vc->vc_top, vc->vc_bottom, SM_DOWN, 1);
 	else if (vc->vc_y > 0) {
 		vc->vc_y--;
 		vc->vc_pos -= vc->vc_size_row;
@@ -1628,7 +1615,7 @@ static void csi_L(struct vc_data *vc, unsigned int nr)
 		nr = vc->vc_rows - vc->vc_y;
 	else if (!nr)
 		nr = 1;
-	scrdown(vc, vc->vc_y, vc->vc_bottom, nr);
+	con_scroll(vc, vc->vc_y, vc->vc_bottom, SM_DOWN, nr);
 	vc->vc_need_wrap = 0;
 }
 
@@ -1649,7 +1636,7 @@ static void csi_M(struct vc_data *vc, unsigned int nr)
 		nr = vc->vc_rows - vc->vc_y;
 	else if (!nr)
 		nr=1;
-	scrup(vc, vc->vc_y, vc->vc_bottom, nr);
+	con_scroll(vc, vc->vc_y, vc->vc_bottom, SM_UP, nr);
 	vc->vc_need_wrap = 0;
 }
 
-- 
2.10.0
