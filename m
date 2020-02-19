Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926BAC34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72548208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgBSHkC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:40:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:41582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgBSHj4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 02:39:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5CFABAEA8;
        Wed, 19 Feb 2020 07:39:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 9/9] vt: selection, indent switch-case properly
Date:   Wed, 19 Feb 2020 08:39:51 +0100
Message-Id: <20200219073951.16151-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219073951.16151-1-jslaby@suse.cz>
References: <20200219073951.16151-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Shift the cases one level left as this is how we are supposed to write
the switch-case code according to the CodingStyle.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/selection.c | 72 ++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index eaf11729ef9e..b9c517463efa 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -226,45 +226,43 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 	}
 	unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
 
-	switch (v->sel_mode)
-	{
-		case TIOCL_SELCHAR:	/* character-by-character selection */
+	switch (v->sel_mode) {
+	case TIOCL_SELCHAR:	/* character-by-character selection */
+		new_sel_start = ps;
+		new_sel_end = pe;
+		break;
+	case TIOCL_SELWORD:	/* word-by-word selection */
+		spc = isspace(sel_pos(ps, unicode));
+		for (new_sel_start = ps; ; ps -= 2) {
+			if ((spc && !isspace(sel_pos(ps, unicode))) ||
+			    (!spc && !inword(sel_pos(ps, unicode))))
+				break;
 			new_sel_start = ps;
+			if (!(ps % vc->vc_size_row))
+				break;
+		}
+
+		spc = isspace(sel_pos(pe, unicode));
+		for (new_sel_end = pe; ; pe += 2) {
+			if ((spc && !isspace(sel_pos(pe, unicode))) ||
+			    (!spc && !inword(sel_pos(pe, unicode))))
+				break;
 			new_sel_end = pe;
-			break;
-		case TIOCL_SELWORD:	/* word-by-word selection */
-			spc = isspace(sel_pos(ps, unicode));
-			for (new_sel_start = ps; ; ps -= 2)
-			{
-				if ((spc && !isspace(sel_pos(ps, unicode))) ||
-				    (!spc && !inword(sel_pos(ps, unicode))))
-					break;
-				new_sel_start = ps;
-				if (!(ps % vc->vc_size_row))
-					break;
-			}
-			spc = isspace(sel_pos(pe, unicode));
-			for (new_sel_end = pe; ; pe += 2)
-			{
-				if ((spc && !isspace(sel_pos(pe, unicode))) ||
-				    (!spc && !inword(sel_pos(pe, unicode))))
-					break;
-				new_sel_end = pe;
-				if (!((pe + 2) % vc->vc_size_row))
-					break;
-			}
-			break;
-		case TIOCL_SELLINE:	/* line-by-line selection */
-			new_sel_start = ps - ps % vc->vc_size_row;
-			new_sel_end = pe + vc->vc_size_row
-				    - pe % vc->vc_size_row - 2;
-			break;
-		case TIOCL_SELPOINTER:
-			highlight_pointer(pe);
-			goto unlock;
-		default:
-			ret = -EINVAL;
-			goto unlock;
+			if (!((pe + 2) % vc->vc_size_row))
+				break;
+		}
+		break;
+	case TIOCL_SELLINE:	/* line-by-line selection */
+		new_sel_start = ps - ps % vc->vc_size_row;
+		new_sel_end = pe + vc->vc_size_row
+			    - pe % vc->vc_size_row - 2;
+		break;
+	case TIOCL_SELPOINTER:
+		highlight_pointer(pe);
+		goto unlock;
+	default:
+		ret = -EINVAL;
+		goto unlock;
 	}
 
 	/* remove the pointer */
-- 
2.25.0

