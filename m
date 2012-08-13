From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 5/8] n_gsm: added interlocking for gsm_data_lock for certain
 code paths
Date: Mon, 13 Aug 2012 13:44:40 +0100
Message-ID: <20120813124433.6125.4800.stgit@localhost.localdomain>
References: <20120813124254.6125.70371.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43383 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2HMM1V (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Aug 2012 08:27:21 -0400
In-Reply-To: <20120813124254.6125.70371.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Russ Gorby <russ.gorby@intel.com>

There were some locking holes in the management of the MUX's
message queue for 2 code paths:
1) gsmld_write_wakeup
2) receipt of CMD_FCON flow-control message
In both cases gsm_data_kick is called w/o locking so it can collide
with other other instances of gsm_data_kick (pulling messages tx_tail)
or potentially other instances of __gsm_data_queu (adding messages to tx_head)

Changed to take the tx_lock in these 2 cases

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Tested-by: Yin, Fengwei <fengwei.yin@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: Riding School <stable@kernel.org>
---

 drivers/tty/n_gsm.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9854edf..51ba2f2 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1205,6 +1205,8 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 							u8 *data, int clen)
 {
 	u8 buf[1];
+	unsigned long flags;
+
 	switch (command) {
 	case CMD_CLD: {
 		struct gsm_dlci *dlci = gsm->dlci[0];
@@ -1225,7 +1227,9 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		gsm->constipated = 0;
 		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
 		/* Kick the link in case it is idling */
+		spin_lock_irqsave(&gsm->tx_lock, flags);
 		gsm_data_kick(gsm);
+		spin_unlock_irqrestore(&gsm->tx_lock, flags);
 		break;
 	case CMD_FCOFF:
 		/* Modem wants us to STFU */
@@ -2392,12 +2396,12 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
 
 	/* Queue poll */
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+	spin_lock_irqsave(&gsm->tx_lock, flags);
 	gsm_data_kick(gsm);
 	if (gsm->tx_bytes < TX_THRESH_LO) {
-		spin_lock_irqsave(&gsm->tx_lock, flags);
 		gsm_dlci_data_sweep(gsm);
-		spin_unlock_irqrestore(&gsm->tx_lock, flags);
 	}
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 }
 
 /**

