Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB917C34050
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A800E24656
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBSIuC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:50:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:49762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgBSIty (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6A924AD46;
        Wed, 19 Feb 2020 08:49:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/10] n_gsm: switch dead to bool
Date:   Wed, 19 Feb 2020 09:49:46 +0100
Message-Id: <20200219084949.28074-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Both gsm_dlci->dead and gsm_mux->dead are used as bools, so treat them
as such.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8afe635a04fd..24ce46e4fb45 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -140,7 +140,7 @@ struct gsm_dlci {
 	int prev_adaption;
 	u32 modem_rx;		/* Our incoming virtual modem lines */
 	u32 modem_tx;		/* Our outgoing modem lines */
-	int dead;		/* Refuse re-open */
+	bool dead;		/* Refuse re-open */
 	/* Flow control */
 	int throttled;		/* Private copy of throttle state */
 	int constipated;	/* Throttle status for outgoing */
@@ -232,7 +232,7 @@ struct gsm_mux {
 	unsigned int mru;
 	unsigned int mtu;
 	int initiator;			/* Did we initiate connection */
-	int dead;			/* Has the mux been shut down */
+	bool dead;			/* Has the mux been shut down */
 	struct gsm_dlci *dlci[NUM_DLCI];
 	int constipated;		/* Asked by remote to shut up */
 
@@ -1207,8 +1207,8 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		struct gsm_dlci *dlci = gsm->dlci[0];
 		/* Modem wishes to close down */
 		if (dlci) {
-			dlci->dead = 1;
-			gsm->dead = 1;
+			dlci->dead = true;
+			gsm->dead = true;
 			gsm_dlci_begin_close(dlci);
 		}
 		}
@@ -1434,7 +1434,7 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 		tty_port_tty_hangup(&dlci->port, false);
 		kfifo_reset(&dlci->fifo);
 	} else
-		dlci->gsm->dead = 1;
+		dlci->gsm->dead = true;
 	wake_up(&dlci->gsm->event);
 	/* A DLCI 0 close is a MUX termination so we need to kick that
 	   back to userspace somehow */
@@ -2081,7 +2081,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
 	struct gsm_dlci *dlci = gsm->dlci[0];
 	struct gsm_msg *txq, *ntxq;
 
-	gsm->dead = 1;
+	gsm->dead = true;
 
 	spin_lock(&gsm_mux_lock);
 	for (i = 0; i < MAX_MUX; i++) {
@@ -2098,7 +2098,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
 	del_timer_sync(&gsm->t2_timer);
 	/* Now we are sure T2 has stopped */
 	if (dlci)
-		dlci->dead = 1;
+		dlci->dead = true;
 
 	/* Free up any link layer users */
 	mutex_lock(&gsm->mutex);
@@ -2152,7 +2152,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	dlci = gsm_dlci_alloc(gsm, 0);
 	if (dlci == NULL)
 		return -ENOMEM;
-	gsm->dead = 0;		/* Tty opens are now permissible */
+	gsm->dead = false;		/* Tty opens are now permissible */
 	return 0;
 }
 
@@ -2236,7 +2236,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	gsm->encoding = 1;
 	gsm->mru = 64;	/* Default to encoding 1 so these should be 64 */
 	gsm->mtu = 64;
-	gsm->dead = 1;	/* Avoid early tty opens */
+	gsm->dead = true;	/* Avoid early tty opens */
 
 	return gsm;
 }
-- 
2.25.0

