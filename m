From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/8] n_gsm : Flow control handling in Mux driver
Date: Mon, 13 Aug 2012 13:43:58 +0100
Message-ID: <20120813124346.6125.32649.stgit@localhost.localdomain>
References: <20120813124254.6125.70371.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43377 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2HMM0m (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Aug 2012 08:26:42 -0400
In-Reply-To: <20120813124254.6125.70371.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Frederic Berat <fredericx.berat@intel.com>

- Correcting handling of FCon/FCoff in order to respect 27.010 spec
- Consider FCon/off will overide all dlci flow control except for
  dlci0 as we must be able to send control frames.
- Dlci constipated handling according to FC, RTC and RTR values.
- Modifying gsm_dlci_data_kick and gsm_dlci_data_sweep according
  to dlci constipated value

Signed-off-by: Frederic Berat <fredericx.berat@intel.com>
Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/n_gsm.c |   79 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9b0a44d..6651285 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -673,6 +673,8 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
  *
  *	The tty device has called us to indicate that room has appeared in
  *	the transmit queue. Ram more data into the pipe if we have any
+ *	If we have been flow-stopped by a CMD_FCOFF, then we can only
+ *	send messages on DLCI0 until CMD_FCON
  *
  *	FIXME: lock against link layer control transmissions
  */
@@ -680,15 +682,19 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 static void gsm_data_kick(struct gsm_mux *gsm)
 {
 	struct gsm_msg *msg = gsm->tx_head;
+	struct gsm_msg *free_msg;
 	int len;
 	int skip_sof = 0;
 
-	/* FIXME: We need to apply this solely to data messages */
-	if (gsm->constipated)
-		return;
-
-	while (gsm->tx_head != NULL) {
-		msg = gsm->tx_head;
+	while (msg) {
+		if (gsm->constipated && msg->addr) {
+			msg = msg->next;
+			continue;
+		}
+		if (gsm->dlci[msg->addr]->constipated) {
+			msg = msg->next;
+			continue;
+		}
 		if (gsm->encoding != 0) {
 			gsm->txframe[0] = GSM1_SOF;
 			len = gsm_stuff_frame(msg->data,
@@ -711,15 +717,19 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 						len - skip_sof) < 0)
 			break;
 		/* FIXME: Can eliminate one SOF in many more cases */
-		gsm->tx_head = msg->next;
-		if (gsm->tx_head == NULL)
-			gsm->tx_tail = NULL;
 		gsm->tx_bytes -= msg->len;
-		kfree(msg);
 		/* For a burst of frames skip the extra SOF within the
 		   burst */
 		skip_sof = 1;
+
+		if (gsm->tx_head == msg)
+			gsm->tx_head = msg->next;
+		free_msg = msg;
+		msg = msg->next;
+		kfree(free_msg);
 	}
+	if (!gsm->tx_head)
+		gsm->tx_tail = NULL;
 }
 
 /**
@@ -738,6 +748,8 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 	u8 *dp = msg->data;
 	u8 *fcs = dp + msg->len;
 
+	WARN_ONCE(dlci->constipated, "%s: queueing from a constipated DLCI",
+		__func__);
 	/* Fill in the header */
 	if (gsm->encoding == 0) {
 		if (msg->len < 128)
@@ -944,6 +956,9 @@ static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
 			break;
 		dlci = gsm->dlci[i];
 		if (dlci == NULL || dlci->constipated) {
+			if (dlci && (debug & 0x20))
+				pr_info("%s: DLCI %d is constipated",
+					__func__, i);
 			i++;
 			continue;
 		}
@@ -973,6 +988,13 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
 	unsigned long flags;
 	int sweep;
 
+	if (dlci->constipated) {
+		if (debug & 0x20)
+			pr_info("%s: DLCI %d is constipated",
+				__func__, dlci->addr);
+		return;
+	}
+
 	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
 	/* If we have nothing running then we need to fire up */
 	sweep = (dlci->gsm->tx_bytes < TX_THRESH_LO);
@@ -1030,6 +1052,7 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 {
 	int  mlines = 0;
 	u8 brk = 0;
+	int fc;
 
 	/* The modem status command can either contain one octet (v.24 signals)
 	   or two octets (v.24 signals + break signals). The length field will
@@ -1041,19 +1064,27 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 	else {
 		brk = modem & 0x7f;
 		modem = (modem >> 7) & 0x7f;
-	};
+	}
 
 	/* Flow control/ready to communicate */
-	if (modem & MDM_FC) {
+	fc = (modem & MDM_FC) || !(modem & MDM_RTR);
+	if (fc && !dlci->constipated) {
+		if (debug & 0x20)
+			pr_info("%s: DLCI %d START constipated (tx_bytes=%d)",
+				__func__, dlci->addr, dlci->gsm->tx_bytes);
 		/* Need to throttle our output on this device */
 		dlci->constipated = 1;
-	}
-	if (modem & MDM_RTC) {
-		mlines |= TIOCM_DSR | TIOCM_DTR;
+	} else if (!fc && dlci->constipated) {
+		if (debug & 0x20)
+			pr_info("%s: DLCI %d END constipated (tx_bytes=%d)",
+				__func__, dlci->addr, dlci->gsm->tx_bytes);
 		dlci->constipated = 0;
 		gsm_dlci_data_kick(dlci);
 	}
+
 	/* Map modem bits */
+	if (modem & MDM_RTC)
+		mlines |= TIOCM_DSR | TIOCM_DTR;
 	if (modem & MDM_RTR)
 		mlines |= TIOCM_RTS | TIOCM_CTS;
 	if (modem & MDM_IC)
@@ -1209,17 +1240,21 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		gsm_control_reply(gsm, CMD_TEST, data, clen);
 		break;
 	case CMD_FCON:
-		/* Modem wants us to STFU */
-		gsm->constipated = 1;
-		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
-		break;
-	case CMD_FCOFF:
 		/* Modem can accept data again */
+		if (debug & 0x20)
+			pr_info("%s: GSM END constipation", __func__);
 		gsm->constipated = 0;
-		gsm_control_reply(gsm, CMD_FCOFF, NULL, 0);
+		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
 		/* Kick the link in case it is idling */
 		gsm_data_kick(gsm);
 		break;
+	case CMD_FCOFF:
+		/* Modem wants us to STFU */
+		if (debug & 0x20)
+			pr_info("%s: GSM START constipation", __func__);
+		gsm->constipated = 1;
+		gsm_control_reply(gsm, CMD_FCOFF, NULL, 0);
+		break;
 	case CMD_MSC:
 		/* Out of band modem line change indicator for a DLCI */
 		gsm_control_modem(gsm, data, clen);
@@ -2276,7 +2311,7 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			gsm->error(gsm, *dp, flags);
 			break;
 		default:
-			WARN_ONCE("%s: unknown flag %d\n",
+			WARN_ONCE(1, "%s: unknown flag %d\n",
 			       tty_name(tty, buf), flags);
 			break;
 		}

