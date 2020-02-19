Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B8C34050
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09F72465D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSItw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:49:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:49718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgBSItw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D40BBABE7;
        Wed, 19 Feb 2020 08:49:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/10] n_gsm: introduce enum gsm_dlci_state
Date:   Wed, 19 Feb 2020 09:49:41 +0100
Message-Id: <20200219084949.28074-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

gsm_dlci->state is clearly an enumeration. So introduce one and use it
-- compiler now checks if valid values are assigned to the field.

Note that a compiler warns about unhandled cases in switch. Add default
cases with a pr_debug (which is not printed by default).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 828c0c7babdd..1d0a140027ff 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -100,6 +100,13 @@ struct gsm_msg {
 	unsigned char buffer[];
 };
 
+enum gsm_dlci_state {
+	DLCI_CLOSED,
+	DLCI_OPENING,		/* Sending SABM not seen UA */
+	DLCI_OPEN,		/* SABM/UA complete */
+	DLCI_CLOSING,		/* Sending DISC not seen UA/DM */
+};
+
 /*
  *	Each active data link has a gsm_dlci structure associated which ties
  *	the link layer to an optional tty (if the tty side is open). To avoid
@@ -113,11 +120,7 @@ struct gsm_msg {
 struct gsm_dlci {
 	struct gsm_mux *gsm;
 	int addr;
-	int state;
-#define DLCI_CLOSED		0
-#define DLCI_OPENING		1	/* Sending SABM not seen UA */
-#define DLCI_OPEN		2	/* SABM/UA complete */
-#define DLCI_CLOSING		3	/* Sending DISC not seen UA/DM */
+	enum gsm_dlci_state state;
 	struct mutex mutex;
 
 	/* Link layer */
@@ -1495,6 +1498,9 @@ static void gsm_dlci_t1(struct timer_list *t)
 		} else
 			gsm_dlci_close(dlci);
 		break;
+	default:
+		pr_debug("%s: unhandled state: %d\n", __func__, dlci->state);
+		break;
 	}
 }
 
@@ -1808,6 +1814,10 @@ static void gsm_queue(struct gsm_mux *gsm)
 		case DLCI_OPENING:
 			gsm_dlci_open(dlci);
 			break;
+		default:
+			pr_debug("%s: unhandled state: %d\n", __func__,
+					dlci->state);
+			break;
 		}
 		break;
 	case DM:	/* DM can be valid unsolicited */
-- 
2.25.0

