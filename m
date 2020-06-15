Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD3AC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C212206D7
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgFOHv4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgFOHtO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E778DAFD7;
        Mon, 15 Jun 2020 07:49:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/38] vt: switch G0/1_charset to an array
Date:   Mon, 15 Jun 2020 09:48:37 +0200
Message-Id: <20200615074910.19267-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Declare Gx_charset[2] instead of G0_charset and G1_charset. It makes
the code simpler (without ternary operators).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c            | 19 ++++++++-----------
 include/linux/console_struct.h |  6 ++----
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 729c7c8c682b..4e79cda0c2be 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1743,9 +1743,7 @@ static void csi_m(struct vc_data *vc)
 			  * Select primary font, don't display control chars if
 			  * defined, don't set bit 8 on output.
 			  */
-			vc->vc_translate = set_translate(vc->state.charset == 0
-					? vc->state.G0_charset
-					: vc->state.G1_charset, vc);
+			vc->vc_translate = set_translate(vc->state.Gx_charset[vc->state.charset], vc);
 			vc->vc_disp_ctrl = 0;
 			vc->vc_toggle_meta = 0;
 			break;
@@ -2041,8 +2039,8 @@ static void restore_cur(struct vc_data *vc)
 	memcpy(&vc->state, &vc->saved_state, sizeof(vc->state));
 
 	gotoxy(vc, vc->state.x, vc->state.y);
-	vc->vc_translate = set_translate(vc->state.charset ? vc->state.G1_charset :
-			vc->state.G0_charset, vc);
+	vc->vc_translate = set_translate(vc->state.Gx_charset[vc->state.charset],
+			vc);
 	update_attr(vc);
 	vc->vc_need_wrap = 0;
 }
@@ -2059,8 +2057,8 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	vc->vc_state		= ESnormal;
 	vc->vc_priv		= EPecma;
 	vc->vc_translate	= set_translate(LAT1_MAP, vc);
-	vc->state.G0_charset	= LAT1_MAP;
-	vc->state.G1_charset	= GRAF_MAP;
+	vc->state.Gx_charset[0]	= LAT1_MAP;
+	vc->state.Gx_charset[1]	= GRAF_MAP;
 	vc->state.charset	= 0;
 	vc->vc_need_wrap	= 0;
 	vc->vc_report_mouse	= 0;
@@ -2105,8 +2103,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 
 static void vc_setGx(struct vc_data *vc, unsigned int which, int c)
 {
-	unsigned char *charset = which == 0 ? &vc->state.G0_charset :
-		&vc->state.G1_charset;
+	unsigned char *charset = &vc->state.Gx_charset[which];
 
 	switch (c) {
 	case '0':
@@ -2168,12 +2165,12 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		return;
 	case 14:
 		vc->state.charset = 1;
-		vc->vc_translate = set_translate(vc->state.G1_charset, vc);
+		vc->vc_translate = set_translate(vc->state.Gx_charset[1], vc);
 		vc->vc_disp_ctrl = 1;
 		return;
 	case 15:
 		vc->state.charset = 0;
-		vc->vc_translate = set_translate(vc->state.G0_charset, vc);
+		vc->vc_translate = set_translate(vc->state.Gx_charset[0], vc);
 		vc->vc_disp_ctrl = 0;
 		return;
 	case 24: case 26:
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fa1abffe64be..623e86689c3a 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -34,8 +34,7 @@ enum vc_intensity {
  * @x: cursor's x-position
  * @y: cursor's y-position
  * @color: foreground & background colors
- * @G0_charset: what's G0 slot set to (like GRAF_MAP, LAT1_MAP)
- * @G1_charset: what's G1 slot set to (like GRAF_MAP, LAT1_MAP)
+ * @Gx_charset: what's G0/G1 slot set to (like GRAF_MAP, LAT1_MAP)
  * @charset: what character set to use (0=G0 or 1=G1)
  * @intensity: see enum vc_intensity for values
  * @reverse: reversed foreground/background colors
@@ -48,8 +47,7 @@ struct vc_state {
 
 	unsigned char	color;
 
-	unsigned char	G0_charset;
-	unsigned char	G1_charset;
+	unsigned char	Gx_charset[2];
 	unsigned int	charset		: 1;
 
 	/* attribute flags */
-- 
2.27.0

