Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B9C34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2388D222D9
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSIuL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:50:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgBSIty (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 105CCABE7;
        Wed, 19 Feb 2020 08:49:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/10] n_gsm: switch constipated to bool
Date:   Wed, 19 Feb 2020 09:49:48 +0100
Message-Id: <20200219084949.28074-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Both gsm_dlci->constipated and gsm_mux->constipated are used as bools,
so treat them as such.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 6bd51d309c32..e0283bb24bb5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -143,7 +143,7 @@ struct gsm_dlci {
 	bool dead;		/* Refuse re-open */
 	/* Flow control */
 	bool throttled;		/* Private copy of throttle state */
-	int constipated;	/* Throttle status for outgoing */
+	bool constipated;	/* Throttle status for outgoing */
 	/* Packetised I/O */
 	struct sk_buff *skb;	/* Frame being sent */
 	struct sk_buff_head skb_list;	/* Queued frames */
@@ -234,7 +234,7 @@ struct gsm_mux {
 	int initiator;			/* Did we initiate connection */
 	bool dead;			/* Has the mux been shut down */
 	struct gsm_dlci *dlci[NUM_DLCI];
-	int constipated;		/* Asked by remote to shut up */
+	bool constipated;		/* Asked by remote to shut up */
 
 	spinlock_t tx_lock;
 	unsigned int tx_bytes;		/* TX data outstanding */
@@ -1042,9 +1042,9 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 	fc = (modem & MDM_FC) || !(modem & MDM_RTR);
 	if (fc && !dlci->constipated) {
 		/* Need to throttle our output on this device */
-		dlci->constipated = 1;
+		dlci->constipated = true;
 	} else if (!fc && dlci->constipated) {
-		dlci->constipated = 0;
+		dlci->constipated = false;
 		gsm_dlci_data_kick(dlci);
 	}
 
@@ -1219,7 +1219,7 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		break;
 	case CMD_FCON:
 		/* Modem can accept data again */
-		gsm->constipated = 0;
+		gsm->constipated = false;
 		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
 		/* Kick the link in case it is idling */
 		spin_lock_irqsave(&gsm->tx_lock, flags);
@@ -1228,7 +1228,7 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		break;
 	case CMD_FCOFF:
 		/* Modem wants us to STFU */
-		gsm->constipated = 1;
+		gsm->constipated = true;
 		gsm_control_reply(gsm, CMD_FCOFF, NULL, 0);
 		break;
 	case CMD_MSC:
-- 
2.25.0

