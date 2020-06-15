Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252A7C433E3
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD812068E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgFOHtT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:39900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgFOHtS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20EF0ACF9;
        Mon, 15 Jun 2020 07:49:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/38] vc: separate state
Date:   Mon, 15 Jun 2020 09:48:33 +0200
Message-Id: <20200615074910.19267-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are two copies of some members of struct vc_data. This is because
we need to save them and restore later. Move these memebers to a
separate structure called vc_state. So now instead of members like:
  vc_x, vc_y and vc_saved_x, vc_saved_y
we have
  state and saved_state (of type: struct vc_state)
containing
  state.x, state.y and saved_state.x, saved_state.y

This change:
* makes clear what is saved & restored
* eases save & restore by using memcpy (see save_cur and restore_cur)

Finally, we document the newly added struct vc_state using kernel-doc.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 .../accessibility/braille/braille_console.c   |  10 +-
 drivers/staging/speakup/main.c                |  28 +-
 drivers/tty/vt/vt.c                           | 327 +++++++++---------
 drivers/video/console/mdacon.c                |   2 +-
 drivers/video/console/sticon.c                |   6 +-
 drivers/video/console/vgacon.c                |  22 +-
 drivers/video/fbdev/core/bitblit.c            |   6 +-
 drivers/video/fbdev/core/fbcon.c              |   8 +-
 drivers/video/fbdev/core/fbcon_ccw.c          |   4 +-
 drivers/video/fbdev/core/fbcon_cw.c           |   4 +-
 drivers/video/fbdev/core/fbcon_ud.c           |   4 +-
 drivers/video/fbdev/core/tileblit.c           |   4 +-
 include/linux/console_struct.h                |  54 +--
 13 files changed, 239 insertions(+), 240 deletions(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index a8f7c278b691..c2b452af6806 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -109,16 +109,16 @@ static void braille_write(u16 *buf)
 /* Follow the VC cursor*/
 static void vc_follow_cursor(struct vc_data *vc)
 {
-	vc_x = vc->vc_x - (vc->vc_x % WIDTH);
-	vc_y = vc->vc_y;
-	lastvc_x = vc->vc_x;
-	lastvc_y = vc->vc_y;
+	vc_x = vc->state.x - (vc->state.x % WIDTH);
+	vc_y = vc->state.y;
+	lastvc_x = vc->state.x;
+	lastvc_y = vc->state.y;
 }
 
 /* Maybe the VC cursor moved, if so follow it */
 static void vc_maybe_cursor_moved(struct vc_data *vc)
 {
-	if (vc->vc_x != lastvc_x || vc->vc_y != lastvc_y)
+	if (vc->state.x != lastvc_x || vc->state.y != lastvc_y)
 		vc_follow_cursor(vc);
 }
 
diff --git a/drivers/staging/speakup/main.c b/drivers/staging/speakup/main.c
index 02471d932d71..ddfd12afe3b9 100644
--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -263,8 +263,8 @@ static unsigned char get_attributes(struct vc_data *vc, u16 *pos)
 
 static void speakup_date(struct vc_data *vc)
 {
-	spk_x = spk_cx = vc->vc_x;
-	spk_y = spk_cy = vc->vc_y;
+	spk_x = spk_cx = vc->state.x;
+	spk_y = spk_cy = vc->state.y;
 	spk_pos = spk_cp = vc->vc_pos;
 	spk_old_attr = spk_attr;
 	spk_attr = get_attributes(vc, (u_short *)spk_pos);
@@ -1551,9 +1551,9 @@ static void do_handle_cursor(struct vc_data *vc, u_char value, char up_flag)
  */
 	is_cursor = value + 1;
 	old_cursor_pos = vc->vc_pos;
-	old_cursor_x = vc->vc_x;
-	old_cursor_y = vc->vc_y;
-	speakup_console[vc->vc_num]->ht.cy = vc->vc_y;
+	old_cursor_x = vc->state.x;
+	old_cursor_y = vc->state.y;
+	speakup_console[vc->vc_num]->ht.cy = vc->state.y;
 	cursor_con = vc->vc_num;
 	if (cursor_track == CT_Highlight)
 		reset_highlight_buffers(vc);
@@ -1574,8 +1574,8 @@ static void update_color_buffer(struct vc_data *vc, const u16 *ic, int len)
 	i = 0;
 	if (speakup_console[vc_num]->ht.highsize[bi] == 0) {
 		speakup_console[vc_num]->ht.rpos[bi] = vc->vc_pos;
-		speakup_console[vc_num]->ht.rx[bi] = vc->vc_x;
-		speakup_console[vc_num]->ht.ry[bi] = vc->vc_y;
+		speakup_console[vc_num]->ht.rx[bi] = vc->state.x;
+		speakup_console[vc_num]->ht.ry[bi] = vc->state.y;
 	}
 	while ((hi < COLOR_BUFFER_SIZE) && (i < len)) {
 		if (ic[i] > 32) {
@@ -1664,9 +1664,9 @@ static int speak_highlight(struct vc_data *vc)
 		return 0;
 	hc = get_highlight_color(vc);
 	if (hc != -1) {
-		d = vc->vc_y - speakup_console[vc_num]->ht.cy;
+		d = vc->state.y - speakup_console[vc_num]->ht.cy;
 		if ((d == 1) || (d == -1))
-			if (speakup_console[vc_num]->ht.ry[hc] != vc->vc_y)
+			if (speakup_console[vc_num]->ht.ry[hc] != vc->state.y)
 				return 0;
 		spk_parked |= 0x01;
 		spk_do_flush();
@@ -1693,8 +1693,8 @@ static void cursor_done(struct timer_list *unused)
 	}
 	speakup_date(vc);
 	if (win_enabled) {
-		if (vc->vc_x >= win_left && vc->vc_x <= win_right &&
-		    vc->vc_y >= win_top && vc->vc_y <= win_bottom) {
+		if (vc->state.x >= win_left && vc->state.x <= win_right &&
+		    vc->state.y >= win_top && vc->state.y <= win_bottom) {
 			spk_keydown = 0;
 			is_cursor = 0;
 			goto out;
@@ -1757,7 +1757,7 @@ static void speakup_con_write(struct vc_data *vc, u16 *str, int len)
 	if (!spin_trylock_irqsave(&speakup_info.spinlock, flags))
 		/* Speakup output, discard */
 		return;
-	if (spk_bell_pos && spk_keydown && (vc->vc_x == spk_bell_pos - 1))
+	if (spk_bell_pos && spk_keydown && (vc->state.x == spk_bell_pos - 1))
 		bleep(3);
 	if ((is_cursor) || (cursor_track == read_all_mode)) {
 		if (cursor_track == CT_Highlight)
@@ -1766,8 +1766,8 @@ static void speakup_con_write(struct vc_data *vc, u16 *str, int len)
 		return;
 	}
 	if (win_enabled) {
-		if (vc->vc_x >= win_left && vc->vc_x <= win_right &&
-		    vc->vc_y >= win_top && vc->vc_y <= win_bottom) {
+		if (vc->state.x >= win_left && vc->state.x <= win_right &&
+		    vc->state.y >= win_top && vc->state.y <= win_bottom) {
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 			return;
 		}
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 48a8199f7845..76f52935e0c8 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -381,7 +381,7 @@ static void vc_uniscr_putc(struct vc_data *vc, char32_t uc)
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
 
 	if (uniscr)
-		uniscr->lines[vc->vc_y][vc->vc_x] = uc;
+		uniscr->lines[vc->state.y][vc->state.x] = uc;
 }
 
 static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
@@ -389,8 +389,8 @@ static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
 
 	if (uniscr) {
-		char32_t *ln = uniscr->lines[vc->vc_y];
-		unsigned int x = vc->vc_x, cols = vc->vc_cols;
+		char32_t *ln = uniscr->lines[vc->state.y];
+		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
 		memmove(&ln[x + nr], &ln[x], (cols - x - nr) * sizeof(*ln));
 		memset32(&ln[x], ' ', nr);
@@ -402,8 +402,8 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
 
 	if (uniscr) {
-		char32_t *ln = uniscr->lines[vc->vc_y];
-		unsigned int x = vc->vc_x, cols = vc->vc_cols;
+		char32_t *ln = uniscr->lines[vc->state.y];
+		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
 		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
 		memset32(&ln[cols - nr], ' ', nr);
@@ -416,7 +416,7 @@ static void vc_uniscr_clear_line(struct vc_data *vc, unsigned int x,
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
 
 	if (uniscr) {
-		char32_t *ln = uniscr->lines[vc->vc_y];
+		char32_t *ln = uniscr->lines[vc->state.y];
 
 		memset32(&ln[x], ' ', nr);
 	}
@@ -750,10 +750,11 @@ static u8 build_attr(struct vc_data *vc, u8 _color, u8 _intensity, u8 _blink,
 
 static void update_attr(struct vc_data *vc)
 {
-	vc->vc_attr = build_attr(vc, vc->vc_color, vc->vc_intensity,
-	              vc->vc_blink, vc->vc_underline,
-	              vc->vc_reverse ^ vc->vc_decscnm, vc->vc_italic);
-	vc->vc_video_erase_char = (build_attr(vc, vc->vc_color, 1, vc->vc_blink, 0, vc->vc_decscnm, 0) << 8) | ' ';
+	vc->vc_attr = build_attr(vc, vc->state.color, vc->state.intensity,
+	              vc->state.blink, vc->state.underline,
+	              vc->state.reverse ^ vc->vc_decscnm, vc->state.italic);
+	vc->vc_video_erase_char = ' ' | (build_attr(vc, vc->state.color, 1,
+				vc->state.blink, 0, vc->vc_decscnm, 0) << 8);
 }
 
 /* Note: inverting the screen twice should revert to the original state */
@@ -842,12 +843,12 @@ static void insert_char(struct vc_data *vc, unsigned int nr)
 	unsigned short *p = (unsigned short *) vc->vc_pos;
 
 	vc_uniscr_insert(vc, nr);
-	scr_memmovew(p + nr, p, (vc->vc_cols - vc->vc_x - nr) * 2);
+	scr_memmovew(p + nr, p, (vc->vc_cols - vc->state.x - nr) * 2);
 	scr_memsetw(p, vc->vc_video_erase_char, nr * 2);
 	vc->vc_need_wrap = 0;
 	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) p,
-			vc->vc_cols - vc->vc_x);
+			vc->vc_cols - vc->state.x);
 }
 
 static void delete_char(struct vc_data *vc, unsigned int nr)
@@ -855,13 +856,13 @@ static void delete_char(struct vc_data *vc, unsigned int nr)
 	unsigned short *p = (unsigned short *) vc->vc_pos;
 
 	vc_uniscr_delete(vc, nr);
-	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->vc_x - nr) * 2);
-	scr_memsetw(p + vc->vc_cols - vc->vc_x - nr, vc->vc_video_erase_char,
+	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->state.x - nr) * 2);
+	scr_memsetw(p + vc->vc_cols - vc->state.x - nr, vc->vc_video_erase_char,
 			nr * 2);
 	vc->vc_need_wrap = 0;
 	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) p,
-			vc->vc_cols - vc->vc_x);
+			vc->vc_cols - vc->state.x);
 }
 
 static int softcursor_original = -1;
@@ -880,7 +881,7 @@ static void add_softcursor(struct vc_data *vc)
 	if ((type & 0x40) && ((i & 0x700) == ((i & 0x7000) >> 4))) i ^= 0x0700;
 	scr_writew(i, (u16 *) vc->vc_pos);
 	if (con_should_update(vc))
-		vc->vc_sw->con_putc(vc, i, vc->vc_y, vc->vc_x);
+		vc->vc_sw->con_putc(vc, i, vc->state.y, vc->state.x);
 }
 
 static void hide_softcursor(struct vc_data *vc)
@@ -889,7 +890,7 @@ static void hide_softcursor(struct vc_data *vc)
 		scr_writew(softcursor_original, (u16 *)vc->vc_pos);
 		if (con_should_update(vc))
 			vc->vc_sw->con_putc(vc, softcursor_original,
-					vc->vc_y, vc->vc_x);
+					vc->state.y, vc->state.x);
 		softcursor_original = -1;
 	}
 }
@@ -927,7 +928,8 @@ static void set_origin(struct vc_data *vc)
 		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
 	vc->vc_visible_origin = vc->vc_origin;
 	vc->vc_scr_end = vc->vc_origin + vc->vc_screenbuf_size;
-	vc->vc_pos = vc->vc_origin + vc->vc_size_row * vc->vc_y + 2 * vc->vc_x;
+	vc->vc_pos = vc->vc_origin + vc->vc_size_row * vc->state.y +
+		2 * vc->state.x;
 }
 
 static void save_screen(struct vc_data *vc)
@@ -1250,8 +1252,8 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	new_origin = (long) newscreen;
 	new_scr_end = new_origin + new_screen_size;
 
-	if (vc->vc_y > new_rows) {
-		if (old_rows - vc->vc_y < new_rows) {
+	if (vc->state.y > new_rows) {
+		if (old_rows - vc->state.y < new_rows) {
 			/*
 			 * Cursor near the bottom, copy contents from the
 			 * bottom of buffer
@@ -1262,7 +1264,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 			 * Cursor is in no man's land, copy 1/2 screenful
 			 * from the top and bottom of cursor position
 			 */
-			first_copied_row = (vc->vc_y - new_rows/2);
+			first_copied_row = (vc->state.y - new_rows/2);
 		}
 		old_origin += first_copied_row * old_row_size;
 	} else
@@ -1296,7 +1298,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	/* do part of a reset_terminal() */
 	vc->vc_top = 0;
 	vc->vc_bottom = vc->vc_rows;
-	gotoxy(vc, vc->vc_x, vc->vc_y);
+	gotoxy(vc, vc->state.x, vc->state.y);
 	save_cur(vc);
 
 	if (tty) {
@@ -1431,12 +1433,12 @@ static void gotoxy(struct vc_data *vc, int new_x, int new_y)
 	int min_y, max_y;
 
 	if (new_x < 0)
-		vc->vc_x = 0;
+		vc->state.x = 0;
 	else {
 		if (new_x >= vc->vc_cols)
-			vc->vc_x = vc->vc_cols - 1;
+			vc->state.x = vc->vc_cols - 1;
 		else
-			vc->vc_x = new_x;
+			vc->state.x = new_x;
 	}
 
  	if (vc->vc_decom) {
@@ -1447,12 +1449,13 @@ static void gotoxy(struct vc_data *vc, int new_x, int new_y)
 		max_y = vc->vc_rows;
 	}
 	if (new_y < min_y)
-		vc->vc_y = min_y;
+		vc->state.y = min_y;
 	else if (new_y >= max_y)
-		vc->vc_y = max_y - 1;
+		vc->state.y = max_y - 1;
 	else
-		vc->vc_y = new_y;
-	vc->vc_pos = vc->vc_origin + vc->vc_y * vc->vc_size_row + (vc->vc_x<<1);
+		vc->state.y = new_y;
+	vc->vc_pos = vc->vc_origin + vc->state.y * vc->vc_size_row +
+		(vc->state.x << 1);
 	vc->vc_need_wrap = 0;
 }
 
@@ -1479,10 +1482,10 @@ static void lf(struct vc_data *vc)
     	/* don't scroll if above bottom of scrolling region, or
 	 * if below scrolling region
 	 */
-    	if (vc->vc_y + 1 == vc->vc_bottom)
+	if (vc->state.y + 1 == vc->vc_bottom)
 		con_scroll(vc, vc->vc_top, vc->vc_bottom, SM_UP, 1);
-	else if (vc->vc_y < vc->vc_rows - 1) {
-	    	vc->vc_y++;
+	else if (vc->state.y < vc->vc_rows - 1) {
+		vc->state.y++;
 		vc->vc_pos += vc->vc_size_row;
 	}
 	vc->vc_need_wrap = 0;
@@ -1494,10 +1497,10 @@ static void ri(struct vc_data *vc)
     	/* don't scroll if below top of scrolling region, or
 	 * if above scrolling region
 	 */
-	if (vc->vc_y == vc->vc_top)
+	if (vc->state.y == vc->vc_top)
 		con_scroll(vc, vc->vc_top, vc->vc_bottom, SM_DOWN, 1);
-	else if (vc->vc_y > 0) {
-		vc->vc_y--;
+	else if (vc->state.y > 0) {
+		vc->state.y--;
 		vc->vc_pos -= vc->vc_size_row;
 	}
 	vc->vc_need_wrap = 0;
@@ -1505,16 +1508,16 @@ static void ri(struct vc_data *vc)
 
 static inline void cr(struct vc_data *vc)
 {
-	vc->vc_pos -= vc->vc_x << 1;
-	vc->vc_need_wrap = vc->vc_x = 0;
+	vc->vc_pos -= vc->state.x << 1;
+	vc->vc_need_wrap = vc->state.x = 0;
 	notify_write(vc, '\r');
 }
 
 static inline void bs(struct vc_data *vc)
 {
-	if (vc->vc_x) {
+	if (vc->state.x) {
 		vc->vc_pos -= 2;
-		vc->vc_x--;
+		vc->state.x--;
 		vc->vc_need_wrap = 0;
 		notify_write(vc, '\b');
 	}
@@ -1532,16 +1535,16 @@ static void csi_J(struct vc_data *vc, int vpar)
 
 	switch (vpar) {
 		case 0:	/* erase from cursor to end of display */
-			vc_uniscr_clear_line(vc, vc->vc_x,
-					     vc->vc_cols - vc->vc_x);
-			vc_uniscr_clear_lines(vc, vc->vc_y + 1,
-					      vc->vc_rows - vc->vc_y - 1);
+			vc_uniscr_clear_line(vc, vc->state.x,
+					     vc->vc_cols - vc->state.x);
+			vc_uniscr_clear_lines(vc, vc->state.y + 1,
+					      vc->vc_rows - vc->state.y - 1);
 			count = (vc->vc_scr_end - vc->vc_pos) >> 1;
 			start = (unsigned short *)vc->vc_pos;
 			break;
 		case 1:	/* erase from start to cursor */
-			vc_uniscr_clear_line(vc, 0, vc->vc_x + 1);
-			vc_uniscr_clear_lines(vc, 0, vc->vc_y);
+			vc_uniscr_clear_line(vc, 0, vc->state.x + 1);
+			vc_uniscr_clear_lines(vc, 0, vc->state.y);
 			count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
 			start = (unsigned short *)vc->vc_origin;
 			break;
@@ -1571,20 +1574,20 @@ static void csi_K(struct vc_data *vc, int vpar)
 	switch (vpar) {
 		case 0:	/* erase from cursor to end of line */
 			offset = 0;
-			count = vc->vc_cols - vc->vc_x;
+			count = vc->vc_cols - vc->state.x;
 			break;
 		case 1:	/* erase from start of line to cursor */
-			offset = -vc->vc_x;
-			count = vc->vc_x + 1;
+			offset = -vc->state.x;
+			count = vc->state.x + 1;
 			break;
 		case 2: /* erase whole line */
-			offset = -vc->vc_x;
+			offset = -vc->state.x;
 			count = vc->vc_cols;
 			break;
 		default:
 			return;
 	}
-	vc_uniscr_clear_line(vc, vc->vc_x + offset, count);
+	vc_uniscr_clear_line(vc, vc->state.x + offset, count);
 	scr_memsetw(start + offset, vc->vc_video_erase_char, 2 * count);
 	vc->vc_need_wrap = 0;
 	if (con_should_update(vc))
@@ -1597,23 +1600,23 @@ static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar posi
 
 	if (!vpar)
 		vpar++;
-	count = (vpar > vc->vc_cols - vc->vc_x) ? (vc->vc_cols - vc->vc_x) : vpar;
+	count = (vpar > vc->vc_cols - vc->state.x) ? (vc->vc_cols - vc->state.x) : vpar;
 
-	vc_uniscr_clear_line(vc, vc->vc_x, count);
+	vc_uniscr_clear_line(vc, vc->state.x, count);
 	scr_memsetw((unsigned short *)vc->vc_pos, vc->vc_video_erase_char, 2 * count);
 	if (con_should_update(vc))
-		vc->vc_sw->con_clear(vc, vc->vc_y, vc->vc_x, 1, count);
+		vc->vc_sw->con_clear(vc, vc->state.y, vc->state.x, 1, count);
 	vc->vc_need_wrap = 0;
 }
 
 static void default_attr(struct vc_data *vc)
 {
-	vc->vc_intensity = 1;
-	vc->vc_italic = 0;
-	vc->vc_underline = 0;
-	vc->vc_reverse = 0;
-	vc->vc_blink = 0;
-	vc->vc_color = vc->vc_def_color;
+	vc->state.intensity = 1;
+	vc->state.italic = 0;
+	vc->state.underline = 0;
+	vc->state.reverse = 0;
+	vc->state.blink = 0;
+	vc->state.color = vc->vc_def_color;
 }
 
 struct rgb { u8 r; u8 g; u8 b; };
@@ -1649,19 +1652,19 @@ static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
 
 	if (hue == 7 && max <= 0x55) {
 		hue = 0;
-		vc->vc_intensity = 2;
+		vc->state.intensity = 2;
 	} else if (max > 0xaa)
-		vc->vc_intensity = 2;
+		vc->state.intensity = 2;
 	else
-		vc->vc_intensity = 1;
+		vc->state.intensity = 1;
 
-	vc->vc_color = (vc->vc_color & 0xf0) | hue;
+	vc->state.color = (vc->state.color & 0xf0) | hue;
 }
 
 static void rgb_background(struct vc_data *vc, const struct rgb *c)
 {
 	/* For backgrounds, err on the dark side. */
-	vc->vc_color = (vc->vc_color & 0x0f)
+	vc->state.color = (vc->state.color & 0x0f)
 		| (c->r&0x80) >> 1 | (c->g&0x80) >> 2 | (c->b&0x80) >> 3;
 }
 
@@ -1712,13 +1715,13 @@ static void csi_m(struct vc_data *vc)
 			default_attr(vc);
 			break;
 		case 1:
-			vc->vc_intensity = 2;
+			vc->state.intensity = 2;
 			break;
 		case 2:
-			vc->vc_intensity = 0;
+			vc->state.intensity = 0;
 			break;
 		case 3:
-			vc->vc_italic = 1;
+			vc->state.italic = 1;
 			break;
 		case 21:
 			/*
@@ -1726,21 +1729,21 @@ static void csi_m(struct vc_data *vc)
 			 * convert it to a single underline.
 			 */
 		case 4:
-			vc->vc_underline = 1;
+			vc->state.underline = 1;
 			break;
 		case 5:
-			vc->vc_blink = 1;
+			vc->state.blink = 1;
 			break;
 		case 7:
-			vc->vc_reverse = 1;
+			vc->state.reverse = 1;
 			break;
 		case 10: /* ANSI X3.64-1979 (SCO-ish?)
 			  * Select primary font, don't display control chars if
 			  * defined, don't set bit 8 on output.
 			  */
-			vc->vc_translate = set_translate(vc->vc_charset == 0
-					? vc->vc_G0_charset
-					: vc->vc_G1_charset, vc);
+			vc->vc_translate = set_translate(vc->state.charset == 0
+					? vc->state.G0_charset
+					: vc->state.G1_charset, vc);
 			vc->vc_disp_ctrl = 0;
 			vc->vc_toggle_meta = 0;
 			break;
@@ -1761,19 +1764,19 @@ static void csi_m(struct vc_data *vc)
 			vc->vc_toggle_meta = 1;
 			break;
 		case 22:
-			vc->vc_intensity = 1;
+			vc->state.intensity = 1;
 			break;
 		case 23:
-			vc->vc_italic = 0;
+			vc->state.italic = 0;
 			break;
 		case 24:
-			vc->vc_underline = 0;
+			vc->state.underline = 0;
 			break;
 		case 25:
-			vc->vc_blink = 0;
+			vc->state.blink = 0;
 			break;
 		case 27:
-			vc->vc_reverse = 0;
+			vc->state.reverse = 0;
 			break;
 		case 38:
 			i = vc_t416_color(vc, i, rgb_foreground);
@@ -1782,25 +1785,25 @@ static void csi_m(struct vc_data *vc)
 			i = vc_t416_color(vc, i, rgb_background);
 			break;
 		case 39:
-			vc->vc_color = (vc->vc_def_color & 0x0f) |
-				(vc->vc_color & 0xf0);
+			vc->state.color = (vc->vc_def_color & 0x0f) |
+				(vc->state.color & 0xf0);
 			break;
 		case 49:
-			vc->vc_color = (vc->vc_def_color & 0xf0) |
-				(vc->vc_color & 0x0f);
+			vc->state.color = (vc->vc_def_color & 0xf0) |
+				(vc->state.color & 0x0f);
 			break;
 		default:
 			if (vc->vc_par[i] >= 90 && vc->vc_par[i] <= 107) {
 				if (vc->vc_par[i] < 100)
-					vc->vc_intensity = 2;
+					vc->state.intensity = 2;
 				vc->vc_par[i] -= 60;
 			}
 			if (vc->vc_par[i] >= 30 && vc->vc_par[i] <= 37)
-				vc->vc_color = color_table[vc->vc_par[i] - 30]
-					| (vc->vc_color & 0xf0);
+				vc->state.color = color_table[vc->vc_par[i] - 30]
+					| (vc->state.color & 0xf0);
 			else if (vc->vc_par[i] >= 40 && vc->vc_par[i] <= 47)
-				vc->vc_color = (color_table[vc->vc_par[i] - 40] << 4)
-					| (vc->vc_color & 0x0f);
+				vc->state.color = (color_table[vc->vc_par[i] - 40] << 4)
+					| (vc->state.color & 0x0f);
 			break;
 		}
 	update_attr(vc);
@@ -1819,7 +1822,7 @@ static void cursor_report(struct vc_data *vc, struct tty_struct *tty)
 {
 	char buf[40];
 
-	sprintf(buf, "\033[%d;%dR", vc->vc_y + (vc->vc_decom ? vc->vc_top + 1 : 1), vc->vc_x + 1);
+	sprintf(buf, "\033[%d;%dR", vc->state.y + (vc->vc_decom ? vc->vc_top + 1 : 1), vc->state.x + 1);
 	respond_string(buf, tty->port);
 }
 
@@ -1924,14 +1927,14 @@ static void setterm_command(struct vc_data *vc)
 	case 1:	/* set color for underline mode */
 		if (vc->vc_can_do_color && vc->vc_par[1] < 16) {
 			vc->vc_ulcolor = color_table[vc->vc_par[1]];
-			if (vc->vc_underline)
+			if (vc->state.underline)
 				update_attr(vc);
 		}
 		break;
 	case 2:	/* set color for half intensity mode */
 		if (vc->vc_can_do_color && vc->vc_par[1] < 16) {
 			vc->vc_halfcolor = color_table[vc->vc_par[1]];
-			if (vc->vc_intensity == 0)
+			if (vc->state.intensity == 0)
 				update_attr(vc);
 		}
 		break;
@@ -1985,8 +1988,8 @@ static void setterm_command(struct vc_data *vc)
 /* console_lock is held */
 static void csi_at(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_cols - vc->vc_x)
-		nr = vc->vc_cols - vc->vc_x;
+	if (nr > vc->vc_cols - vc->state.x)
+		nr = vc->vc_cols - vc->state.x;
 	else if (!nr)
 		nr = 1;
 	insert_char(vc, nr);
@@ -1995,19 +1998,19 @@ static void csi_at(struct vc_data *vc, unsigned int nr)
 /* console_lock is held */
 static void csi_L(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_rows - vc->vc_y)
-		nr = vc->vc_rows - vc->vc_y;
+	if (nr > vc->vc_rows - vc->state.y)
+		nr = vc->vc_rows - vc->state.y;
 	else if (!nr)
 		nr = 1;
-	con_scroll(vc, vc->vc_y, vc->vc_bottom, SM_DOWN, nr);
+	con_scroll(vc, vc->state.y, vc->vc_bottom, SM_DOWN, nr);
 	vc->vc_need_wrap = 0;
 }
 
 /* console_lock is held */
 static void csi_P(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_cols - vc->vc_x)
-		nr = vc->vc_cols - vc->vc_x;
+	if (nr > vc->vc_cols - vc->state.x)
+		nr = vc->vc_cols - vc->state.x;
 	else if (!nr)
 		nr = 1;
 	delete_char(vc, nr);
@@ -2016,44 +2019,28 @@ static void csi_P(struct vc_data *vc, unsigned int nr)
 /* console_lock is held */
 static void csi_M(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_rows - vc->vc_y)
-		nr = vc->vc_rows - vc->vc_y;
+	if (nr > vc->vc_rows - vc->state.y)
+		nr = vc->vc_rows - vc->state.y;
 	else if (!nr)
 		nr=1;
-	con_scroll(vc, vc->vc_y, vc->vc_bottom, SM_UP, nr);
+	con_scroll(vc, vc->state.y, vc->vc_bottom, SM_UP, nr);
 	vc->vc_need_wrap = 0;
 }
 
 /* console_lock is held (except via vc_init->reset_terminal */
 static void save_cur(struct vc_data *vc)
 {
-	vc->vc_saved_x		= vc->vc_x;
-	vc->vc_saved_y		= vc->vc_y;
-	vc->vc_s_intensity	= vc->vc_intensity;
-	vc->vc_s_italic         = vc->vc_italic;
-	vc->vc_s_underline	= vc->vc_underline;
-	vc->vc_s_blink		= vc->vc_blink;
-	vc->vc_s_reverse	= vc->vc_reverse;
-	vc->vc_s_charset	= vc->vc_charset;
-	vc->vc_s_color		= vc->vc_color;
-	vc->vc_saved_G0		= vc->vc_G0_charset;
-	vc->vc_saved_G1		= vc->vc_G1_charset;
+	memcpy(&vc->saved_state, &vc->state, sizeof(vc->state));
 }
 
 /* console_lock is held */
 static void restore_cur(struct vc_data *vc)
 {
-	gotoxy(vc, vc->vc_saved_x, vc->vc_saved_y);
-	vc->vc_intensity	= vc->vc_s_intensity;
-	vc->vc_italic		= vc->vc_s_italic;
-	vc->vc_underline	= vc->vc_s_underline;
-	vc->vc_blink		= vc->vc_s_blink;
-	vc->vc_reverse		= vc->vc_s_reverse;
-	vc->vc_charset		= vc->vc_s_charset;
-	vc->vc_color		= vc->vc_s_color;
-	vc->vc_G0_charset	= vc->vc_saved_G0;
-	vc->vc_G1_charset	= vc->vc_saved_G1;
-	vc->vc_translate	= set_translate(vc->vc_charset ? vc->vc_G1_charset : vc->vc_G0_charset, vc);
+	memcpy(&vc->state, &vc->saved_state, sizeof(vc->state));
+
+	gotoxy(vc, vc->state.x, vc->state.y);
+	vc->vc_translate = set_translate(vc->state.charset ? vc->state.G1_charset :
+			vc->state.G0_charset, vc);
 	update_attr(vc);
 	vc->vc_need_wrap = 0;
 }
@@ -2070,9 +2057,9 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	vc->vc_state		= ESnormal;
 	vc->vc_priv		= EPecma;
 	vc->vc_translate	= set_translate(LAT1_MAP, vc);
-	vc->vc_G0_charset	= LAT1_MAP;
-	vc->vc_G1_charset	= GRAF_MAP;
-	vc->vc_charset		= 0;
+	vc->state.G0_charset	= LAT1_MAP;
+	vc->state.G1_charset	= GRAF_MAP;
+	vc->state.charset	= 0;
 	vc->vc_need_wrap	= 0;
 	vc->vc_report_mouse	= 0;
 	vc->vc_utf              = default_utf8;
@@ -2136,13 +2123,13 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		bs(vc);
 		return;
 	case 9:
-		vc->vc_pos -= (vc->vc_x << 1);
-		while (vc->vc_x < vc->vc_cols - 1) {
-			vc->vc_x++;
-			if (vc->vc_tab_stop[7 & (vc->vc_x >> 5)] & (1 << (vc->vc_x & 31)))
+		vc->vc_pos -= (vc->state.x << 1);
+		while (vc->state.x < vc->vc_cols - 1) {
+			vc->state.x++;
+			if (vc->vc_tab_stop[7 & (vc->state.x >> 5)] & (1 << (vc->state.x & 31)))
 				break;
 		}
-		vc->vc_pos += (vc->vc_x << 1);
+		vc->vc_pos += (vc->state.x << 1);
 		notify_write(vc, '\t');
 		return;
 	case 10: case 11: case 12:
@@ -2154,13 +2141,13 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		cr(vc);
 		return;
 	case 14:
-		vc->vc_charset = 1;
-		vc->vc_translate = set_translate(vc->vc_G1_charset, vc);
+		vc->state.charset = 1;
+		vc->vc_translate = set_translate(vc->state.G1_charset, vc);
 		vc->vc_disp_ctrl = 1;
 		return;
 	case 15:
-		vc->vc_charset = 0;
-		vc->vc_translate = set_translate(vc->vc_G0_charset, vc);
+		vc->state.charset = 0;
+		vc->vc_translate = set_translate(vc->state.G0_charset, vc);
 		vc->vc_disp_ctrl = 0;
 		return;
 	case 24: case 26:
@@ -2200,7 +2187,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			lf(vc);
 			return;
 		case 'H':
-			vc->vc_tab_stop[7 & (vc->vc_x >> 5)] |= (1 << (vc->vc_x & 31));
+			vc->vc_tab_stop[7 & (vc->state.x >> 5)] |= (1 << (vc->state.x & 31));
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -2347,42 +2334,42 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		case 'G': case '`':
 			if (vc->vc_par[0])
 				vc->vc_par[0]--;
-			gotoxy(vc, vc->vc_par[0], vc->vc_y);
+			gotoxy(vc, vc->vc_par[0], vc->state.y);
 			return;
 		case 'A':
 			if (!vc->vc_par[0])
 				vc->vc_par[0]++;
-			gotoxy(vc, vc->vc_x, vc->vc_y - vc->vc_par[0]);
+			gotoxy(vc, vc->state.x, vc->state.y - vc->vc_par[0]);
 			return;
 		case 'B': case 'e':
 			if (!vc->vc_par[0])
 				vc->vc_par[0]++;
-			gotoxy(vc, vc->vc_x, vc->vc_y + vc->vc_par[0]);
+			gotoxy(vc, vc->state.x, vc->state.y + vc->vc_par[0]);
 			return;
 		case 'C': case 'a':
 			if (!vc->vc_par[0])
 				vc->vc_par[0]++;
-			gotoxy(vc, vc->vc_x + vc->vc_par[0], vc->vc_y);
+			gotoxy(vc, vc->state.x + vc->vc_par[0], vc->state.y);
 			return;
 		case 'D':
 			if (!vc->vc_par[0])
 				vc->vc_par[0]++;
-			gotoxy(vc, vc->vc_x - vc->vc_par[0], vc->vc_y);
+			gotoxy(vc, vc->state.x - vc->vc_par[0], vc->state.y);
 			return;
 		case 'E':
 			if (!vc->vc_par[0])
 				vc->vc_par[0]++;
-			gotoxy(vc, 0, vc->vc_y + vc->vc_par[0]);
+			gotoxy(vc, 0, vc->state.y + vc->vc_par[0]);
 			return;
 		case 'F':
 			if (!vc->vc_par[0])
 				vc->vc_par[0]++;
-			gotoxy(vc, 0, vc->vc_y - vc->vc_par[0]);
+			gotoxy(vc, 0, vc->state.y - vc->vc_par[0]);
 			return;
 		case 'd':
 			if (vc->vc_par[0])
 				vc->vc_par[0]--;
-			gotoxay(vc, vc->vc_x ,vc->vc_par[0]);
+			gotoxay(vc, vc->state.x ,vc->vc_par[0]);
 			return;
 		case 'H': case 'f':
 			if (vc->vc_par[0])
@@ -2412,7 +2399,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			return;
 		case 'g':
 			if (!vc->vc_par[0])
-				vc->vc_tab_stop[7 & (vc->vc_x >> 5)] &= ~(1 << (vc->vc_x & 31));
+				vc->vc_tab_stop[7 & (vc->state.x >> 5)] &= ~(1 << (vc->state.x & 31));
 			else if (vc->vc_par[0] == 3) {
 				vc->vc_tab_stop[0] =
 					vc->vc_tab_stop[1] =
@@ -2497,28 +2484,28 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		return;
 	case ESsetG0:
 		if (c == '0')
-			vc->vc_G0_charset = GRAF_MAP;
+			vc->state.G0_charset = GRAF_MAP;
 		else if (c == 'B')
-			vc->vc_G0_charset = LAT1_MAP;
+			vc->state.G0_charset = LAT1_MAP;
 		else if (c == 'U')
-			vc->vc_G0_charset = IBMPC_MAP;
+			vc->state.G0_charset = IBMPC_MAP;
 		else if (c == 'K')
-			vc->vc_G0_charset = USER_MAP;
-		if (vc->vc_charset == 0)
-			vc->vc_translate = set_translate(vc->vc_G0_charset, vc);
+			vc->state.G0_charset = USER_MAP;
+		if (vc->state.charset == 0)
+			vc->vc_translate = set_translate(vc->state.G0_charset, vc);
 		vc->vc_state = ESnormal;
 		return;
 	case ESsetG1:
 		if (c == '0')
-			vc->vc_G1_charset = GRAF_MAP;
+			vc->state.G1_charset = GRAF_MAP;
 		else if (c == 'B')
-			vc->vc_G1_charset = LAT1_MAP;
+			vc->state.G1_charset = LAT1_MAP;
 		else if (c == 'U')
-			vc->vc_G1_charset = IBMPC_MAP;
+			vc->state.G1_charset = IBMPC_MAP;
 		else if (c == 'K')
-			vc->vc_G1_charset = USER_MAP;
-		if (vc->vc_charset == 1)
-			vc->vc_translate = set_translate(vc->vc_G1_charset, vc);
+			vc->state.G1_charset = USER_MAP;
+		if (vc->state.charset == 1)
+			vc->vc_translate = set_translate(vc->state.G1_charset, vc);
 		vc->vc_state = ESnormal;
 		return;
 	case ESosc:
@@ -2572,7 +2559,7 @@ static void con_flush(struct vc_data *vc, unsigned long draw_from,
 		return;
 
 	vc->vc_sw->con_putcs(vc, (u16 *)draw_from,
-			(u16 *)draw_to - (u16 *)draw_from, vc->vc_y, *draw_x);
+			(u16 *)draw_to - (u16 *)draw_from, vc->state.y, *draw_x);
 	*draw_x = -1;
 }
 
@@ -2788,14 +2775,14 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 					     (vc_attr << 8) + tc,
 					   (u16 *) vc->vc_pos);
 				if (con_should_update(vc) && draw_x < 0) {
-					draw_x = vc->vc_x;
+					draw_x = vc->state.x;
 					draw_from = vc->vc_pos;
 				}
-				if (vc->vc_x == vc->vc_cols - 1) {
+				if (vc->state.x == vc->vc_cols - 1) {
 					vc->vc_need_wrap = vc->vc_decawm;
 					draw_to = vc->vc_pos + 2;
 				} else {
-					vc->vc_x++;
+					vc->state.x++;
 					draw_to = (vc->vc_pos += 2);
 				}
 
@@ -2972,25 +2959,25 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 		hide_cursor(vc);
 
 	start = (ushort *)vc->vc_pos;
-	start_x = vc->vc_x;
+	start_x = vc->state.x;
 	cnt = 0;
 	while (count--) {
 		c = *b++;
 		if (c == 10 || c == 13 || c == 8 || vc->vc_need_wrap) {
 			if (cnt && con_is_visible(vc))
-				vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, start_x);
+				vc->vc_sw->con_putcs(vc, start, cnt, vc->state.y, start_x);
 			cnt = 0;
 			if (c == 8) {		/* backspace */
 				bs(vc);
 				start = (ushort *)vc->vc_pos;
-				start_x = vc->vc_x;
+				start_x = vc->state.x;
 				continue;
 			}
 			if (c != 13)
 				lf(vc);
 			cr(vc);
 			start = (ushort *)vc->vc_pos;
-			start_x = vc->vc_x;
+			start_x = vc->state.x;
 			if (c == 10 || c == 13)
 				continue;
 		}
@@ -2998,15 +2985,15 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 		scr_writew((vc->vc_attr << 8) + c, (unsigned short *)vc->vc_pos);
 		notify_write(vc, c);
 		cnt++;
-		if (vc->vc_x == vc->vc_cols - 1) {
+		if (vc->state.x == vc->vc_cols - 1) {
 			vc->vc_need_wrap = 1;
 		} else {
 			vc->vc_pos += 2;
-			vc->vc_x++;
+			vc->state.x++;
 		}
 	}
 	if (cnt && con_is_visible(vc))
-		vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, start_x);
+		vc->vc_sw->con_putcs(vc, start, cnt, vc->state.y, start_x);
 	set_cursor(vc);
 	notify_update(vc);
 
@@ -3401,7 +3388,7 @@ static int __init con_init(void)
 	master_display_fg = vc = vc_cons[currcons].d;
 	set_origin(vc);
 	save_screen(vc);
-	gotoxy(vc, vc->vc_x, vc->vc_y);
+	gotoxy(vc, vc->state.x, vc->state.y);
 	csi_J(vc, 0);
 	update_screen(vc);
 	pr_info("Console: %s %s %dx%d\n",
@@ -4680,8 +4667,8 @@ EXPORT_SYMBOL_GPL(screen_pos);
 void getconsxy(struct vc_data *vc, unsigned char *p)
 {
 	/* clamp values if they don't fit */
-	p[0] = min(vc->vc_x, 0xFFu);
-	p[1] = min(vc->vc_y, 0xFFu);
+	p[0] = min(vc->state.x, 0xFFu);
+	p[1] = min(vc->state.y, 0xFFu);
 }
 
 void putconsxy(struct vc_data *vc, unsigned char *p)
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index d0d427a2f1a3..d64c5ce84125 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -488,7 +488,7 @@ static void mdacon_cursor(struct vc_data *c, int mode)
 		return;
 	}
 
-	mda_set_cursor(c->vc_y*mda_num_columns*2 + c->vc_x*2);
+	mda_set_cursor(c->state.y * mda_num_columns * 2 + c->state.x * 2);
 
 	switch (c->vc_cursor_type & 0x0f) {
 
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 79c9bd8d3025..90083eb80515 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -132,10 +132,10 @@ static void sticon_cursor(struct vc_data *conp, int mode)
 {
     unsigned short car1;
 
-    car1 = conp->vc_screenbuf[conp->vc_x + conp->vc_y * conp->vc_cols];
+    car1 = conp->vc_screenbuf[conp->state.x + conp->state.y * conp->vc_cols];
     switch (mode) {
     case CM_ERASE:
-	sti_putc(sticon_sti, car1, conp->vc_y, conp->vc_x);
+	sti_putc(sticon_sti, car1, conp->state.y, conp->state.x);
 	break;
     case CM_MOVE:
     case CM_DRAW:
@@ -146,7 +146,7 @@ static void sticon_cursor(struct vc_data *conp, int mode)
 	case CUR_TWO_THIRDS:
 	case CUR_BLOCK:
 	    sti_putc(sticon_sti, (car1 & 255) + (0 << 8) + (7 << 11),
-		     conp->vc_y, conp->vc_x);
+		     conp->state.y, conp->state.x);
 	    break;
 	}
 	break;
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 998b0de1812f..d073fa167e87 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -718,9 +718,9 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 	case CM_ERASE:
 		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
 	        if (vga_video_type >= VIDEO_TYPE_VGAC)
-			vgacon_set_cursor_size(c->vc_x, 31, 30);
+			vgacon_set_cursor_size(c->state.x, 31, 30);
 		else
-			vgacon_set_cursor_size(c->vc_x, 31, 31);
+			vgacon_set_cursor_size(c->state.x, 31, 31);
 		break;
 
 	case CM_MOVE:
@@ -728,7 +728,7 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
 		switch (c->vc_cursor_type & 0x0f) {
 		case CUR_UNDERLINE:
-			vgacon_set_cursor_size(c->vc_x,
+			vgacon_set_cursor_size(c->state.x,
 					       c->vc_font.height -
 					       (c->vc_font.height <
 						10 ? 2 : 3),
@@ -737,21 +737,21 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 						10 ? 1 : 2));
 			break;
 		case CUR_TWO_THIRDS:
-			vgacon_set_cursor_size(c->vc_x,
+			vgacon_set_cursor_size(c->state.x,
 					       c->vc_font.height / 3,
 					       c->vc_font.height -
 					       (c->vc_font.height <
 						10 ? 1 : 2));
 			break;
 		case CUR_LOWER_THIRD:
-			vgacon_set_cursor_size(c->vc_x,
+			vgacon_set_cursor_size(c->state.x,
 					       (c->vc_font.height * 2) / 3,
 					       c->vc_font.height -
 					       (c->vc_font.height <
 						10 ? 1 : 2));
 			break;
 		case CUR_LOWER_HALF:
-			vgacon_set_cursor_size(c->vc_x,
+			vgacon_set_cursor_size(c->state.x,
 					       c->vc_font.height / 2,
 					       c->vc_font.height -
 					       (c->vc_font.height <
@@ -759,12 +759,12 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 			break;
 		case CUR_NONE:
 			if (vga_video_type >= VIDEO_TYPE_VGAC)
-				vgacon_set_cursor_size(c->vc_x, 31, 30);
+				vgacon_set_cursor_size(c->state.x, 31, 30);
 			else
-				vgacon_set_cursor_size(c->vc_x, 31, 31);
+				vgacon_set_cursor_size(c->state.x, 31, 31);
 			break;
 		default:
-			vgacon_set_cursor_size(c->vc_x, 1,
+			vgacon_set_cursor_size(c->state.x, 1,
 					       c->vc_font.height);
 			break;
 		}
@@ -1352,8 +1352,8 @@ static void vgacon_save_screen(struct vc_data *c)
 		 * console initialization routines.
 		 */
 		vga_bootup_console = 1;
-		c->vc_x = screen_info.orig_x;
-		c->vc_y = screen_info.orig_y;
+		c->state.x = screen_info.orig_x;
+		c->state.y = screen_info.orig_y;
 	}
 
 	/* We can't copy in more than the size of the video buffer,
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index ca935c09a261..c750470a31ec 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -240,7 +240,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	struct fbcon_ops *ops = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = DIV_ROUND_UP(vc->vc_font.width, 8), c;
-	int y = real_y(ops->p, vc->vc_y);
+	int y = real_y(ops->p, vc->state.y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
 	int err = 1;
 	char *src;
@@ -286,10 +286,10 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		cursor.set |= FB_CUR_SETCMAP;
 	}
 
-	if ((ops->cursor_state.image.dx != (vc->vc_font.width * vc->vc_x)) ||
+	if ((ops->cursor_state.image.dx != (vc->vc_font.width * vc->state.x)) ||
 	    (ops->cursor_state.image.dy != (vc->vc_font.height * y)) ||
 	    ops->cursor_reset) {
-		ops->cursor_state.image.dx = vc->vc_font.width * vc->vc_x;
+		ops->cursor_state.image.dx = vc->vc_font.width * vc->state.x;
 		ops->cursor_state.image.dy = vc->vc_font.height * y;
 		cursor.set |= FB_CUR_SETPOS;
 	}
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9d28a8e3328f..38d2a00b0ccf 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -655,11 +655,11 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		}
 		if (!save) {
 			int lines;
-			if (vc->vc_y + logo_lines >= rows)
-				lines = rows - vc->vc_y - 1;
+			if (vc->state.y + logo_lines >= rows)
+				lines = rows - vc->state.y - 1;
 			else
 				lines = logo_lines;
-			vc->vc_y += lines;
+			vc->state.y += lines;
 			vc->vc_pos += lines * vc->vc_size_row;
 		}
 	}
@@ -677,7 +677,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 					vc->vc_size_row *
 					rows);
 		scr_memcpyw(q, save, logo_lines * new_cols * 2);
-		vc->vc_y += logo_lines;
+		vc->state.y += logo_lines;
 		vc->vc_pos += logo_lines * vc->vc_size_row;
 		kfree(save);
 	}
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index dfa9a8aa4509..9d06446a1a3b 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -225,7 +225,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	struct fbcon_ops *ops = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.height + 7) >> 3, c;
-	int y = real_y(ops->p, vc->vc_y);
+	int y = real_y(ops->p, vc->state.y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
 	int err = 1, dx, dy;
 	char *src;
@@ -284,7 +284,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	}
 
 	dx = y * vc->vc_font.height;
-	dy = vyres - ((vc->vc_x + 1) * vc->vc_font.width);
+	dy = vyres - ((vc->state.x + 1) * vc->vc_font.width);
 
 	if (ops->cursor_state.image.dx != dx ||
 	    ops->cursor_state.image.dy != dy ||
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index ce08251bfd38..4b5f76bb01e5 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -208,7 +208,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	struct fbcon_ops *ops = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.height + 7) >> 3, c;
-	int y = real_y(ops->p, vc->vc_y);
+	int y = real_y(ops->p, vc->state.y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
 	int err = 1, dx, dy;
 	char *src;
@@ -267,7 +267,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	}
 
 	dx = vxres - ((y * vc->vc_font.height) + vc->vc_font.height);
-	dy = vc->vc_x * vc->vc_font.width;
+	dy = vc->state.x * vc->vc_font.width;
 
 	if (ops->cursor_state.image.dx != dx ||
 	    ops->cursor_state.image.dy != dy ||
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index 1936afc78fec..7e0ae3549dc7 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -255,7 +255,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	struct fbcon_ops *ops = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.width + 7) >> 3, c;
-	int y = real_y(ops->p, vc->vc_y);
+	int y = real_y(ops->p, vc->state.y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
 	int err = 1, dx, dy;
 	char *src;
@@ -315,7 +315,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	}
 
 	dy = vyres - ((y * vc->vc_font.height) + vc->vc_font.height);
-	dx = vxres - ((vc->vc_x * vc->vc_font.width) + vc->vc_font.width);
+	dx = vxres - ((vc->state.x * vc->vc_font.width) + vc->vc_font.width);
 
 	if (ops->cursor_state.image.dx != dx ||
 	    ops->cursor_state.image.dy != dy ||
diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/core/tileblit.c
index 93390312957f..ac51425687e4 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -85,8 +85,8 @@ static void tile_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	struct fb_tilecursor cursor;
 	int use_sw = (vc->vc_cursor_type & 0x10);
 
-	cursor.sx = vc->vc_x;
-	cursor.sy = vc->vc_y;
+	cursor.sx = vc->state.x;
+	cursor.sy = vc->state.y;
 	cursor.mode = (mode == CM_ERASE || use_sw) ? 0 : 1;
 	cursor.fg = fg;
 	cursor.bg = bg;
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 24d4c16e3ae0..162f4337c767 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -22,6 +22,37 @@ struct uni_screen;
 
 #define NPAR 16
 
+/**
+ * struct vc_state -- state of a VC
+ * @x: cursor's x-position
+ * @y: cursor's y-position
+ * @color: foreground & background colors
+ * @G0_charset: what's G0 slot set to (like GRAF_MAP, LAT1_MAP)
+ * @G1_charset: what's G1 slot set to (like GRAF_MAP, LAT1_MAP)
+ * @charset: what character set to use (0=G0 or 1=G1)
+ * @intensity: 0=half-bright, 1=normal, 2=bold
+ * @reverse: reversed foreground/background colors
+ *
+ * These members are defined separately from struct vc_data as we save &
+ * restore them at times.
+ */
+struct vc_state {
+	unsigned int	x, y;
+
+	unsigned char	color;
+
+	unsigned char	G0_charset;
+	unsigned char	G1_charset;
+	unsigned int	charset		: 1;
+
+	/* attribute flags */
+	unsigned int	intensity	: 2;
+	unsigned int	italic		: 1;
+	unsigned int	underline	: 1;
+	unsigned int	blink		: 1;
+	unsigned int	reverse		: 1;
+};
+
 /*
  * Example: vc_data of a console that was scrolled 3 lines down.
  *
@@ -57,6 +88,8 @@ struct uni_screen;
 struct vc_data {
 	struct tty_port port;			/* Upper level data */
 
+	struct vc_state state, saved_state;
+
 	unsigned short	vc_num;			/* Console number */
 	unsigned int	vc_cols;		/* [#] Console size */
 	unsigned int	vc_rows;
@@ -73,8 +106,6 @@ struct vc_data {
 	/* attributes for all characters on screen */
 	unsigned char	vc_attr;		/* Current attributes */
 	unsigned char	vc_def_color;		/* Default colors */
-	unsigned char	vc_color;		/* Foreground & background */
-	unsigned char	vc_s_color;		/* Saved foreground & background */
 	unsigned char	vc_ulcolor;		/* Color for underline mode */
 	unsigned char   vc_itcolor;
 	unsigned char	vc_halfcolor;		/* Color for half intensity mode */
@@ -82,8 +113,6 @@ struct vc_data {
 	unsigned int	vc_cursor_type;
 	unsigned short	vc_complement_mask;	/* [#] Xor mask for mouse pointer */
 	unsigned short	vc_s_complement_mask;	/* Saved mouse pointer mask */
-	unsigned int	vc_x, vc_y;		/* Cursor position */
-	unsigned int	vc_saved_x, vc_saved_y;
 	unsigned long	vc_pos;			/* Cursor address */
 	/* fonts */	
 	unsigned short	vc_hi_font_mask;	/* [#] Attribute set for upper 256 chars of font or 0 if not supported */
@@ -98,8 +127,6 @@ struct vc_data {
 	int		vt_newvt;
 	wait_queue_head_t paste_wait;
 	/* mode flags */
-	unsigned int	vc_charset	: 1;	/* Character set G0 / G1 */
-	unsigned int	vc_s_charset	: 1;	/* Saved character set */
 	unsigned int	vc_disp_ctrl	: 1;	/* Display chars < 32? */
 	unsigned int	vc_toggle_meta	: 1;	/* Toggle high bit? */
 	unsigned int	vc_decscnm	: 1;	/* Screen Mode */
@@ -107,17 +134,6 @@ struct vc_data {
 	unsigned int	vc_decawm	: 1;	/* Autowrap Mode */
 	unsigned int	vc_deccm	: 1;	/* Cursor Visible */
 	unsigned int	vc_decim	: 1;	/* Insert Mode */
-	/* attribute flags */
-	unsigned int	vc_intensity	: 2;	/* 0=half-bright, 1=normal, 2=bold */
-	unsigned int    vc_italic:1;
-	unsigned int	vc_underline	: 1;
-	unsigned int	vc_blink	: 1;
-	unsigned int	vc_reverse	: 1;
-	unsigned int	vc_s_intensity	: 2;	/* saved rendition */
-	unsigned int    vc_s_italic:1;
-	unsigned int	vc_s_underline	: 1;
-	unsigned int	vc_s_blink	: 1;
-	unsigned int	vc_s_reverse	: 1;
 	/* misc */
 	unsigned int	vc_priv		: 3;
 	unsigned int	vc_need_wrap	: 1;
@@ -129,10 +145,6 @@ struct vc_data {
 	unsigned int	vc_tab_stop[8];		/* Tab stops. 256 columns. */
 	unsigned char   vc_palette[16*3];       /* Colour palette for VGA+ */
 	unsigned short * vc_translate;
-	unsigned char 	vc_G0_charset;
-	unsigned char 	vc_G1_charset;
-	unsigned char 	vc_saved_G0;
-	unsigned char 	vc_saved_G1;
 	unsigned int    vc_resize_user;         /* resize request from user */
 	unsigned int	vc_bell_pitch;		/* Console bell pitch */
 	unsigned int	vc_bell_duration;	/* Console bell duration */
-- 
2.27.0

