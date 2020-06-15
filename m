Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08205C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D920C20738
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgFOHve (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:39988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbgFOHtQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 17993AFDC;
        Mon, 15 Jun 2020 07:49:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/38] vt: convert vc_tab_stop to bitmap
Date:   Mon, 15 Jun 2020 09:48:38 +0200
Message-Id: <20200615074910.19267-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

vc_tab_stop is used as a bitmap, but defined as an unsigned int array.
Switch it to bitmap and convert all users to the bitmap interface.

Note the difference in behavior! We no longer mask the top 24 bits away
from x, hence we do not wrap tabs at 256th column. Instead, we silently
drop attempts to set a tab behind 256 columns. And we will also seek by
'\t' to the rightmost column, when behind that boundary. I do not think
the original behavior was desired and that someone relies on that. If
this turns out to be the case, we can change the added 'if's back to
masks here and there instead...

(Or we can increase the limit as fb consoles now have 240 chars here.
And they could have more with higher than my resolution, of course.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c            | 44 ++++++++++++++--------------------
 include/linux/console_struct.h |  3 ++-
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4e79cda0c2be..3adb7f409524 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2052,6 +2052,8 @@ enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
 /* console_lock is held (except via vc_init()) */
 static void reset_terminal(struct vc_data *vc, int do_clear)
 {
+	unsigned int i;
+
 	vc->vc_top		= 0;
 	vc->vc_bottom		= vc->vc_rows;
 	vc->vc_state		= ESnormal;
@@ -2082,14 +2084,9 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	default_attr(vc);
 	update_attr(vc);
 
-	vc->vc_tab_stop[0]	=
-	vc->vc_tab_stop[1]	=
-	vc->vc_tab_stop[2]	=
-	vc->vc_tab_stop[3]	=
-	vc->vc_tab_stop[4]	=
-	vc->vc_tab_stop[5]	=
-	vc->vc_tab_stop[6]	=
-	vc->vc_tab_stop[7]	= 0x01010101;
+	bitmap_zero(vc->vc_tab_stop, VC_TABSTOPS_COUNT);
+	for (i = 0; i < VC_TABSTOPS_COUNT; i += 8)
+		set_bit(i, vc->vc_tab_stop);
 
 	vc->vc_bell_pitch = DEFAULT_BELL_PITCH;
 	vc->vc_bell_duration = DEFAULT_BELL_DURATION;
@@ -2147,11 +2144,13 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		return;
 	case 9:
 		vc->vc_pos -= (vc->state.x << 1);
-		while (vc->state.x < vc->vc_cols - 1) {
-			vc->state.x++;
-			if (vc->vc_tab_stop[7 & (vc->state.x >> 5)] & (1 << (vc->state.x & 31)))
-				break;
-		}
+
+		vc->state.x = find_next_bit(vc->vc_tab_stop,
+				min(vc->vc_cols - 1, VC_TABSTOPS_COUNT),
+				vc->state.x + 1);
+		if (vc->state.x >= VC_TABSTOPS_COUNT)
+			vc->state.x = vc->vc_cols - 1;
+
 		vc->vc_pos += (vc->state.x << 1);
 		notify_write(vc, '\t');
 		return;
@@ -2210,7 +2209,8 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			lf(vc);
 			return;
 		case 'H':
-			vc->vc_tab_stop[7 & (vc->state.x >> 5)] |= (1 << (vc->state.x & 31));
+			if (vc->state.x < VC_TABSTOPS_COUNT)
+				set_bit(vc->state.x, vc->vc_tab_stop);
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -2421,18 +2421,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 				respond_ID(tty);
 			return;
 		case 'g':
-			if (!vc->vc_par[0])
-				vc->vc_tab_stop[7 & (vc->state.x >> 5)] &= ~(1 << (vc->state.x & 31));
-			else if (vc->vc_par[0] == 3) {
-				vc->vc_tab_stop[0] =
-					vc->vc_tab_stop[1] =
-					vc->vc_tab_stop[2] =
-					vc->vc_tab_stop[3] =
-					vc->vc_tab_stop[4] =
-					vc->vc_tab_stop[5] =
-					vc->vc_tab_stop[6] =
-					vc->vc_tab_stop[7] = 0;
-			}
+			if (!vc->vc_par[0] && vc->state.x < VC_TABSTOPS_COUNT)
+				set_bit(vc->state.x, vc->vc_tab_stop);
+			else if (vc->vc_par[0] == 3)
+				bitmap_zero(vc->vc_tab_stop, VC_TABSTOPS_COUNT);
 			return;
 		case 'm':
 			csi_m(vc);
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 623e86689c3a..81f7afcd061a 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -21,6 +21,7 @@ struct uni_pagedir;
 struct uni_screen;
 
 #define NPAR 16
+#define VC_TABSTOPS_COUNT	256U
 
 enum vc_intensity {
 	VCI_HALF_BRIGHT,
@@ -147,7 +148,7 @@ struct vc_data {
 	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
 	unsigned char	vc_utf_count;
 		 int	vc_utf_char;
-	unsigned int	vc_tab_stop[8];		/* Tab stops. 256 columns. */
+	DECLARE_BITMAP(vc_tab_stop, VC_TABSTOPS_COUNT);	/* Tab stops. 256 columns. */
 	unsigned char   vc_palette[16*3];       /* Colour palette for VGA+ */
 	unsigned short * vc_translate;
 	unsigned int    vc_resize_user;         /* resize request from user */
-- 
2.27.0

