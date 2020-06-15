Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D609C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8232C2067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgFOHvK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgFOHtR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B21FB031;
        Mon, 15 Jun 2020 07:49:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 18/38] vc: extract detecting control characters from do_con_write
Date:   Mon, 15 Jun 2020 09:48:50 +0200
Message-Id: <20200615074910.19267-18-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move the control characters detection to a separate function dubbed
vc_is_control. It makes the 14 subexpressions a "bit" more readable. And
also simplifies next patches.

It moves also CTRL_ACTION and CTRL_ALWAYS to this new function, as they
are used exclusively here. While at it, these are converted to static
const variables.

And we use "& BIT()" instead of ">>" and "& 1".

Checked using symbolic execution (klee), that the old and new
behaviors are the same.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 71 ++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 0c663054ab79..45d32844e61b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -127,14 +127,6 @@ struct con_driver {
 static struct con_driver registered_con_driver[MAX_NR_CON_DRIVER];
 const struct consw *conswitchp;
 
-/* A bitmap for codes <32. A bit of 1 indicates that the code
- * corresponding to that bit number invokes some special action
- * (such as cursor movement) and should not be displayed as a
- * glyph unless the disp_ctrl mode is explicitly enabled.
- */
-#define CTRL_ACTION 0x0d00ff81
-#define CTRL_ALWAYS 0x0800f501	/* Cannot be overridden by disp_ctrl */
-
 /*
  * Here is the default bell parameters: 750HZ, 1/8th of a second
  */
@@ -2691,13 +2683,56 @@ static inline unsigned char vc_invert_attr(const struct vc_data *vc)
 		((vc->vc_attr & 0x07) << 4);
 }
 
+static bool vc_is_control(struct vc_data *vc, int tc, int c)
+{
+	/*
+	 * A bitmap for codes <32. A bit of 1 indicates that the code
+	 * corresponding to that bit number invokes some special action (such
+	 * as cursor movement) and should not be displayed as a glyph unless
+	 * the disp_ctrl mode is explicitly enabled.
+	 */
+	static const u32 CTRL_ACTION = 0x0d00ff81;
+	/* Cannot be overridden by disp_ctrl */
+	static const u32 CTRL_ALWAYS = 0x0800f501;
+
+	if (vc->vc_state != ESnormal)
+		return true;
+
+	if (!tc)
+		return true;
+
+	/*
+	 * If the original code was a control character we only allow a glyph
+	 * to be displayed if the code is not normally used (such as for cursor
+	 * movement) or if the disp_ctrl mode has been explicitly enabled.
+	 * Certain characters (as given by the CTRL_ALWAYS bitmap) are always
+	 * displayed as control characters, as the console would be pretty
+	 * useless without them; to display an arbitrary font position use the
+	 * direct-to-font zone in UTF-8 mode.
+	 */
+	if (c < 32) {
+		if (vc->vc_disp_ctrl)
+			return CTRL_ALWAYS & BIT(c);
+		else
+			return vc->vc_utf || (CTRL_ACTION & BIT(c));
+	}
+
+	if (c == 127 && !vc->vc_disp_ctrl)
+		return true;
+
+	if (c == 128 + 27)
+		return true;
+
+	return false;
+}
+
 /* acquires console_lock */
 static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
 	struct vc_draw_region draw = {
 		.x = -1,
 	};
-	int c, next_c, tc, ok, n = 0;
+	int c, next_c, tc, n = 0;
 	unsigned int currcons;
 	struct vc_data *vc;
 	unsigned char vc_attr;
@@ -2755,23 +2790,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 					&param) == NOTIFY_STOP)
 			continue;
 
-                /* If the original code was a control character we
-                 * only allow a glyph to be displayed if the code is
-                 * not normally used (such as for cursor movement) or
-                 * if the disp_ctrl mode has been explicitly enabled.
-                 * Certain characters (as given by the CTRL_ALWAYS
-                 * bitmap) are always displayed as control characters,
-                 * as the console would be pretty useless without
-                 * them; to display an arbitrary font position use the
-                 * direct-to-font zone in UTF-8 mode.
-                 */
-                ok = tc && (c >= 32 ||
-			    !(vc->vc_disp_ctrl ? (CTRL_ALWAYS >> c) & 1 :
-				  vc->vc_utf || ((CTRL_ACTION >> c) & 1)))
-			&& (c != 127 || vc->vc_disp_ctrl)
-			&& (c != 128+27);
-
-		if (vc->vc_state == ESnormal && ok) {
+		if (!vc_is_control(vc, tc, c)) {
 			if (vc->vc_utf && !vc->vc_disp_ctrl) {
 				if (is_double_width(c))
 					width = 2;
-- 
2.27.0

