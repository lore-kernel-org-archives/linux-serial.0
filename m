Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D90C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21009206D7
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgFOHut (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:50:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgFOHtS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91E95B035;
        Mon, 15 Jun 2020 07:49:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 19/38] vc: move normal char processing from do_con_write
Date:   Mon, 15 Jun 2020 09:48:51 +0200
Message-Id: <20200615074910.19267-19-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

vc_con_write_normal now handles the complex normal characters
processing. It is no longer a part of do_con_write. So this patch makes
do_con_write pretty clean and obvious.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 198 ++++++++++++++++++++++++--------------------
 1 file changed, 109 insertions(+), 89 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 45d32844e61b..893f72dc812c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2726,21 +2726,116 @@ static bool vc_is_control(struct vc_data *vc, int tc, int c)
 	return false;
 }
 
+static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
+		struct vc_draw_region *draw)
+{
+	int next_c;
+	unsigned char vc_attr;
+	u16 himask = vc->vc_hi_font_mask, charmask = himask ? 0x1ff : 0xff;
+	u8 width = 1;
+	bool inverse = false;
+
+	if (vc->vc_utf && !vc->vc_disp_ctrl) {
+		if (is_double_width(c))
+			width = 2;
+	}
+
+	/* Now try to find out how to display it */
+	tc = conv_uni_to_pc(vc, tc);
+	if (tc & ~charmask) {
+		if (tc == -1 || tc == -2)
+			return -1; /* nothing to display */
+
+		/* Glyph not found */
+		if ((!(vc->vc_utf && !vc->vc_disp_ctrl) || c < 128) &&
+				!(c & ~charmask)) {
+			/*
+			 * In legacy mode use the glyph we get by a 1:1
+			 * mapping.
+			 * This would make absolutely no sense with Unicode in
+			 * mind, but do this for ASCII characters since a font
+			 * may lack Unicode mapping info and we don't want to
+			 * end up with having question marks only.
+			 */
+			tc = c;
+		} else {
+			/*
+			 * Display U+FFFD. If it's not found, display an inverse
+			 * question mark.
+			 */
+			tc = conv_uni_to_pc(vc, 0xfffd);
+			if (tc < 0) {
+				inverse = true;
+				tc = conv_uni_to_pc(vc, '?');
+				if (tc < 0)
+					tc = '?';
+			}
+		}
+	}
+
+	if (!inverse) {
+		vc_attr = vc->vc_attr;
+	} else {
+		vc_attr = vc_invert_attr(vc);
+		con_flush(vc, draw);
+	}
+
+	next_c = c;
+	while (1) {
+		if (vc->vc_need_wrap || vc->vc_decim)
+			con_flush(vc, draw);
+		if (vc->vc_need_wrap) {
+			cr(vc);
+			lf(vc);
+		}
+		if (vc->vc_decim)
+			insert_char(vc, 1);
+		vc_uniscr_putc(vc, next_c);
+		scr_writew(himask ?
+			     ((vc_attr << 8) & ~himask) +
+			     ((tc & 0x100) ? himask : 0) + (tc & 0xff) :
+			     (vc_attr << 8) + tc,
+			   (u16 *)vc->vc_pos);
+		if (con_should_update(vc) && draw->x < 0) {
+			draw->x = vc->state.x;
+			draw->from = vc->vc_pos;
+		}
+		if (vc->state.x == vc->vc_cols - 1) {
+			vc->vc_need_wrap = vc->vc_decawm;
+			draw->to = vc->vc_pos + 2;
+		} else {
+			vc->state.x++;
+			draw->to = (vc->vc_pos += 2);
+		}
+
+		if (!--width)
+			break;
+
+		/* A space is printed in the second column */
+		tc = conv_uni_to_pc(vc, ' ');
+		if (tc < 0)
+			tc = ' ';
+		next_c = ' ';
+	}
+	notify_write(vc, c);
+
+	if (inverse)
+		con_flush(vc, draw);
+
+	return 0;
+}
+
 /* acquires console_lock */
 static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
 	struct vc_draw_region draw = {
 		.x = -1,
 	};
-	int c, next_c, tc, n = 0;
+	int c, tc, n = 0;
 	unsigned int currcons;
 	struct vc_data *vc;
-	unsigned char vc_attr;
 	struct vt_notifier_param param;
-	u16 himask, charmask;
-	u8 width;
 	bool rescan;
-	bool inverse;
 
 	if (in_interrupt())
 		return count;
@@ -2761,8 +2856,6 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 		return 0;
 	}
 
-	himask = vc->vc_hi_font_mask;
-	charmask = himask ? 0x1ff : 0xff;
 
 	/* undraw cursor first */
 	if (con_is_fg(vc))
@@ -2778,8 +2871,6 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 rescan_last_byte:
 		c = orig;
 		rescan = false;
-		inverse = false;
-		width = 1;
 
 		tc = vc_translate(vc, &c, &rescan);
 		if (tc == -1)
@@ -2790,88 +2881,17 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 					&param) == NOTIFY_STOP)
 			continue;
 
-		if (!vc_is_control(vc, tc, c)) {
-			if (vc->vc_utf && !vc->vc_disp_ctrl) {
-				if (is_double_width(c))
-					width = 2;
-			}
-			/* Now try to find out how to display it */
-			tc = conv_uni_to_pc(vc, tc);
-			if (tc & ~charmask) {
-				if (tc == -1 || tc == -2) {
-				    continue; /* nothing to display */
-				}
-				/* Glyph not found */
-				if ((!(vc->vc_utf && !vc->vc_disp_ctrl) || c < 128) && !(c & ~charmask)) {
-				    /* In legacy mode use the glyph we get by a 1:1 mapping.
-				       This would make absolutely no sense with Unicode in mind,
-				       but do this for ASCII characters since a font may lack
-				       Unicode mapping info and we don't want to end up with
-				       having question marks only. */
-				    tc = c;
-				} else {
-				    /* Display U+FFFD. If it's not found, display an inverse question mark. */
-				    tc = conv_uni_to_pc(vc, 0xfffd);
-				    if (tc < 0) {
-					inverse = true;
-					tc = conv_uni_to_pc(vc, '?');
-					if (tc < 0) tc = '?';
-				    }
-				}
-			}
-
-			if (!inverse) {
-				vc_attr = vc->vc_attr;
-			} else {
-				vc_attr = vc_invert_attr(vc);
-				con_flush(vc, &draw);
-			}
-
-			next_c = c;
-			while (1) {
-				if (vc->vc_need_wrap || vc->vc_decim)
-					con_flush(vc, &draw);
-				if (vc->vc_need_wrap) {
-					cr(vc);
-					lf(vc);
-				}
-				if (vc->vc_decim)
-					insert_char(vc, 1);
-				vc_uniscr_putc(vc, next_c);
-				scr_writew(himask ?
-					     ((vc_attr << 8) & ~himask) + ((tc & 0x100) ? himask : 0) + (tc & 0xff) :
-					     (vc_attr << 8) + tc,
-					   (u16 *) vc->vc_pos);
-				if (con_should_update(vc) && draw.x < 0) {
-					draw.x = vc->state.x;
-					draw.from = vc->vc_pos;
-				}
-				if (vc->state.x == vc->vc_cols - 1) {
-					vc->vc_need_wrap = vc->vc_decawm;
-					draw.to = vc->vc_pos + 2;
-				} else {
-					vc->state.x++;
-					draw.to = (vc->vc_pos += 2);
-				}
-
-				if (!--width) break;
-
-				tc = conv_uni_to_pc(vc, ' '); /* A space is printed in the second column */
-				if (tc < 0) tc = ' ';
-				next_c = ' ';
-			}
-			notify_write(vc, c);
-
-			if (inverse)
-				con_flush(vc, &draw);
-
-			if (rescan)
-				goto rescan_last_byte;
-
+		if (vc_is_control(vc, tc, c)) {
+			con_flush(vc, &draw);
+			do_con_trol(tty, vc, orig);
 			continue;
 		}
-		con_flush(vc, &draw);
-		do_con_trol(tty, vc, orig);
+
+		if (vc_con_write_normal(vc, tc, c, &draw) < 0)
+			continue;
+
+		if (rescan)
+			goto rescan_last_byte;
 	}
 	con_flush(vc, &draw);
 	vc_uniscr_debug_check(vc);
-- 
2.27.0

