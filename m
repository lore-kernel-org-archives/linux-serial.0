Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EFFC34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DF92465D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgBSIuZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:50:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:49738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgBSItx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79CF1ACC6;
        Wed, 19 Feb 2020 08:49:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/10] n_gsm: introduce enum gsm_mux_state
Date:   Wed, 19 Feb 2020 09:49:43 +0100
Message-Id: <20200219084949.28074-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

gsm_mux->state is clearly an enumeration. So introduce one and use it
-- compiler now checks if valid values are assigned to the field.

Note that a compiler warns about unhandled cases in switch. Add default
cases with a pr_debug (which is not printed by default).

The values of the states are preserved thanks to the nature of enum.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 7fee5a580f21..82e3d88c1f3f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -173,6 +173,20 @@ struct gsm_control {
 	int error;	/* Error if any */
 };
 
+enum gsm_mux_state {
+	GSM_SEARCH,
+	GSM_START,
+	GSM_ADDRESS,
+	GSM_CONTROL,
+	GSM_LEN,
+	GSM_DATA,
+	GSM_FCS,
+	GSM_OVERRUN,
+	GSM_LEN0,
+	GSM_LEN1,
+	GSM_SSOF,
+};
+
 /*
  *	Each GSM mux we have is represented by this structure. If we are
  *	operating as an ldisc then we use this structure as our ldisc
@@ -197,18 +211,7 @@ struct gsm_mux {
 
 	/* Framing Layer */
 	unsigned char *buf;
-	int state;
-#define GSM_SEARCH		0
-#define GSM_START		1
-#define GSM_ADDRESS		2
-#define GSM_CONTROL		3
-#define GSM_LEN			4
-#define GSM_DATA		5
-#define GSM_FCS			6
-#define GSM_OVERRUN		7
-#define GSM_LEN0		8
-#define GSM_LEN1		9
-#define GSM_SSOF		10
+	enum gsm_mux_state state;
 	unsigned int len;
 	unsigned int address;
 	unsigned int count;
@@ -1934,6 +1937,9 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 			break;
 		}
 		break;
+	default:
+		pr_debug("%s: unhandled state: %d\n", __func__, gsm->state);
+		break;
 	}
 }
 
@@ -2008,6 +2014,9 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 		break;
 	case GSM_OVERRUN:	/* Over-long - eg a dropped SOF */
 		break;
+	default:
+		pr_debug("%s: unhandled state: %d\n", __func__, gsm->state);
+		break;
 	}
 }
 
-- 
2.25.0

