Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E57C433E2
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CE8206D7
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgFOHtO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:39924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbgFOHtN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DD13BAFD4;
        Mon, 15 Jun 2020 07:49:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/38] vt: deduplicate setGx code
Date:   Mon, 15 Jun 2020 09:48:36 +0200
Message-Id: <20200615074910.19267-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The code for setting G0 and G1 is duplicated -- for each of them. Move
the code to a separate function (vc_setGx) and distinguish the two cases
by a parameter.

Change if-else-if to switch which allows for slightly better
optimization (decision tree).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 46 +++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 26cb1fc48b27..729c7c8c682b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2103,6 +2103,30 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	    csi_J(vc, 2);
 }
 
+static void vc_setGx(struct vc_data *vc, unsigned int which, int c)
+{
+	unsigned char *charset = which == 0 ? &vc->state.G0_charset :
+		&vc->state.G1_charset;
+
+	switch (c) {
+	case '0':
+		*charset = GRAF_MAP;
+		break;
+	case 'B':
+		*charset = LAT1_MAP;
+		break;
+	case 'U':
+		*charset = IBMPC_MAP;
+		break;
+	case 'K':
+		*charset = USER_MAP;
+		break;
+	}
+
+	if (vc->state.charset == which)
+		vc->vc_translate = set_translate(*charset, vc);
+}
+
 /* console_lock is held */
 static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 {
@@ -2485,29 +2509,11 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		}
 		return;
 	case ESsetG0:
-		if (c == '0')
-			vc->state.G0_charset = GRAF_MAP;
-		else if (c == 'B')
-			vc->state.G0_charset = LAT1_MAP;
-		else if (c == 'U')
-			vc->state.G0_charset = IBMPC_MAP;
-		else if (c == 'K')
-			vc->state.G0_charset = USER_MAP;
-		if (vc->state.charset == 0)
-			vc->vc_translate = set_translate(vc->state.G0_charset, vc);
+		vc_setGx(vc, 0, c);
 		vc->vc_state = ESnormal;
 		return;
 	case ESsetG1:
-		if (c == '0')
-			vc->state.G1_charset = GRAF_MAP;
-		else if (c == 'B')
-			vc->state.G1_charset = LAT1_MAP;
-		else if (c == 'U')
-			vc->state.G1_charset = IBMPC_MAP;
-		else if (c == 'K')
-			vc->state.G1_charset = USER_MAP;
-		if (vc->state.charset == 1)
-			vc->vc_translate = set_translate(vc->state.G1_charset, vc);
+		vc_setGx(vc, 1, c);
 		vc->vc_state = ESnormal;
 		return;
 	case ESosc:
-- 
2.27.0

