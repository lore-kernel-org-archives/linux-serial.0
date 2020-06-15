Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168EFC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B57206D7
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgFOHut (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:50:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbgFOHtS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3CAB4B02E;
        Mon, 15 Jun 2020 07:49:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/38] vc: introduce struct vc_draw_region
Date:   Mon, 15 Jun 2020 09:48:49 +0200
Message-Id: <20200615074910.19267-17-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For passing of draw area among functions. This makes next patches
simpler.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 0f61dc360067..0c663054ab79 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2549,15 +2549,20 @@ static int is_double_width(uint32_t ucs)
 			sizeof(struct interval), ucs_cmp) != NULL;
 }
 
-static void con_flush(struct vc_data *vc, unsigned long draw_from,
-		unsigned long draw_to, int *draw_x)
+struct vc_draw_region {
+	unsigned long from, to;
+	int x;
+};
+
+static void con_flush(struct vc_data *vc, struct vc_draw_region *draw)
 {
-	if (*draw_x < 0)
+	if (draw->x < 0)
 		return;
 
-	vc->vc_sw->con_putcs(vc, (u16 *)draw_from,
-			(u16 *)draw_to - (u16 *)draw_from, vc->state.y, *draw_x);
-	*draw_x = -1;
+	vc->vc_sw->con_putcs(vc, (u16 *)draw->from,
+			(u16 *)draw->to - (u16 *)draw->from, vc->state.y,
+			draw->x);
+	draw->x = -1;
 }
 
 static inline int vc_translate_ascii(const struct vc_data *vc, int c)
@@ -2689,9 +2694,11 @@ static inline unsigned char vc_invert_attr(const struct vc_data *vc)
 /* acquires console_lock */
 static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
-	int c, next_c, tc, ok, n = 0, draw_x = -1;
+	struct vc_draw_region draw = {
+		.x = -1,
+	};
+	int c, next_c, tc, ok, n = 0;
 	unsigned int currcons;
-	unsigned long draw_from = 0, draw_to = 0;
 	struct vc_data *vc;
 	unsigned char vc_attr;
 	struct vt_notifier_param param;
@@ -2798,14 +2805,13 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 				vc_attr = vc->vc_attr;
 			} else {
 				vc_attr = vc_invert_attr(vc);
-				con_flush(vc, draw_from, draw_to, &draw_x);
+				con_flush(vc, &draw);
 			}
 
 			next_c = c;
 			while (1) {
 				if (vc->vc_need_wrap || vc->vc_decim)
-					con_flush(vc, draw_from, draw_to,
-							&draw_x);
+					con_flush(vc, &draw);
 				if (vc->vc_need_wrap) {
 					cr(vc);
 					lf(vc);
@@ -2817,16 +2823,16 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 					     ((vc_attr << 8) & ~himask) + ((tc & 0x100) ? himask : 0) + (tc & 0xff) :
 					     (vc_attr << 8) + tc,
 					   (u16 *) vc->vc_pos);
-				if (con_should_update(vc) && draw_x < 0) {
-					draw_x = vc->state.x;
-					draw_from = vc->vc_pos;
+				if (con_should_update(vc) && draw.x < 0) {
+					draw.x = vc->state.x;
+					draw.from = vc->vc_pos;
 				}
 				if (vc->state.x == vc->vc_cols - 1) {
 					vc->vc_need_wrap = vc->vc_decawm;
-					draw_to = vc->vc_pos + 2;
+					draw.to = vc->vc_pos + 2;
 				} else {
 					vc->state.x++;
-					draw_to = (vc->vc_pos += 2);
+					draw.to = (vc->vc_pos += 2);
 				}
 
 				if (!--width) break;
@@ -2838,17 +2844,17 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 			notify_write(vc, c);
 
 			if (inverse)
-				con_flush(vc, draw_from, draw_to, &draw_x);
+				con_flush(vc, &draw);
 
 			if (rescan)
 				goto rescan_last_byte;
 
 			continue;
 		}
-		con_flush(vc, draw_from, draw_to, &draw_x);
+		con_flush(vc, &draw);
 		do_con_trol(tty, vc, orig);
 	}
-	con_flush(vc, draw_from, draw_to, &draw_x);
+	con_flush(vc, &draw);
 	vc_uniscr_debug_check(vc);
 	console_conditional_schedule();
 	notify_update(vc);
-- 
2.27.0

