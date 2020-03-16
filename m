Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7629C0044D
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 06:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B7D20679
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 06:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgCPG7R (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:59:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:34820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgCPG7P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 02:59:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5A6A9AF37;
        Mon, 16 Mar 2020 06:59:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/3] vt: indent switch-case in setterm_command properly
Date:   Mon, 16 Mar 2020 07:59:11 +0100
Message-Id: <20200316065911.11024-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316065911.11024-1-jslaby@suse.cz>
References: <20200316065911.11024-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Shift cases one level left. This makes the code more readable and some
lines need not wrap anymore.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 120 ++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 61 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e0d2cb93f6cf..71378baf92d8 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1902,67 +1902,65 @@ static void set_mode(struct vc_data *vc, int on_off)
 /* console_lock is held */
 static void setterm_command(struct vc_data *vc)
 {
-	switch(vc->vc_par[0]) {
-		case 1:	/* set color for underline mode */
-			if (vc->vc_can_do_color &&
-					vc->vc_par[1] < 16) {
-				vc->vc_ulcolor = color_table[vc->vc_par[1]];
-				if (vc->vc_underline)
-					update_attr(vc);
-			}
-			break;
-		case 2:	/* set color for half intensity mode */
-			if (vc->vc_can_do_color &&
-					vc->vc_par[1] < 16) {
-				vc->vc_halfcolor = color_table[vc->vc_par[1]];
-				if (vc->vc_intensity == 0)
-					update_attr(vc);
-			}
-			break;
-		case 8:	/* store colors as defaults */
-			vc->vc_def_color = vc->vc_attr;
-			if (vc->vc_hi_font_mask == 0x100)
-				vc->vc_def_color >>= 1;
-			default_attr(vc);
-			update_attr(vc);
-			break;
-		case 9:	/* set blanking interval */
-			blankinterval = min(vc->vc_par[1], 60U) * 60;
-			poke_blanked_console();
-			break;
-		case 10: /* set bell frequency in Hz */
-			if (vc->vc_npar >= 1)
-				vc->vc_bell_pitch = vc->vc_par[1];
-			else
-				vc->vc_bell_pitch = DEFAULT_BELL_PITCH;
-			break;
-		case 11: /* set bell duration in msec */
-			if (vc->vc_npar >= 1)
-				vc->vc_bell_duration = (vc->vc_par[1] < 2000) ?
-					msecs_to_jiffies(vc->vc_par[1]) : 0;
-			else
-				vc->vc_bell_duration = DEFAULT_BELL_DURATION;
-			break;
-		case 12: /* bring specified console to the front */
-			if (vc->vc_par[1] >= 1 && vc_cons_allocated(vc->vc_par[1] - 1))
-				set_console(vc->vc_par[1] - 1);
-			break;
-		case 13: /* unblank the screen */
-			poke_blanked_console();
-			break;
-		case 14: /* set vesa powerdown interval */
-			vesa_off_interval = min(vc->vc_par[1], 60U) * 60 * HZ;
-			break;
-		case 15: /* activate the previous console */
-			set_console(last_console);
-			break;
-		case 16: /* set cursor blink duration in msec */
-			if (vc->vc_npar >= 1 && vc->vc_par[1] >= 50 &&
-					vc->vc_par[1] <= USHRT_MAX)
-				vc->vc_cur_blink_ms = vc->vc_par[1];
-			else
-				vc->vc_cur_blink_ms = DEFAULT_CURSOR_BLINK_MS;
-			break;
+	switch (vc->vc_par[0]) {
+	case 1:	/* set color for underline mode */
+		if (vc->vc_can_do_color && vc->vc_par[1] < 16) {
+			vc->vc_ulcolor = color_table[vc->vc_par[1]];
+			if (vc->vc_underline)
+				update_attr(vc);
+		}
+		break;
+	case 2:	/* set color for half intensity mode */
+		if (vc->vc_can_do_color && vc->vc_par[1] < 16) {
+			vc->vc_halfcolor = color_table[vc->vc_par[1]];
+			if (vc->vc_intensity == 0)
+				update_attr(vc);
+		}
+		break;
+	case 8:	/* store colors as defaults */
+		vc->vc_def_color = vc->vc_attr;
+		if (vc->vc_hi_font_mask == 0x100)
+			vc->vc_def_color >>= 1;
+		default_attr(vc);
+		update_attr(vc);
+		break;
+	case 9:	/* set blanking interval */
+		blankinterval = min(vc->vc_par[1], 60U) * 60;
+		poke_blanked_console();
+		break;
+	case 10: /* set bell frequency in Hz */
+		if (vc->vc_npar >= 1)
+			vc->vc_bell_pitch = vc->vc_par[1];
+		else
+			vc->vc_bell_pitch = DEFAULT_BELL_PITCH;
+		break;
+	case 11: /* set bell duration in msec */
+		if (vc->vc_npar >= 1)
+			vc->vc_bell_duration = (vc->vc_par[1] < 2000) ?
+				msecs_to_jiffies(vc->vc_par[1]) : 0;
+		else
+			vc->vc_bell_duration = DEFAULT_BELL_DURATION;
+		break;
+	case 12: /* bring specified console to the front */
+		if (vc->vc_par[1] >= 1 && vc_cons_allocated(vc->vc_par[1] - 1))
+			set_console(vc->vc_par[1] - 1);
+		break;
+	case 13: /* unblank the screen */
+		poke_blanked_console();
+		break;
+	case 14: /* set vesa powerdown interval */
+		vesa_off_interval = min(vc->vc_par[1], 60U) * 60 * HZ;
+		break;
+	case 15: /* activate the previous console */
+		set_console(last_console);
+		break;
+	case 16: /* set cursor blink duration in msec */
+		if (vc->vc_npar >= 1 && vc->vc_par[1] >= 50 &&
+				vc->vc_par[1] <= USHRT_MAX)
+			vc->vc_cur_blink_ms = vc->vc_par[1];
+		else
+			vc->vc_cur_blink_ms = DEFAULT_CURSOR_BLINK_MS;
+		break;
 	}
 }
 
-- 
2.25.1

