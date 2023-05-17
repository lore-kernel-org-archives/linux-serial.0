Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3605C77B7A
	for <linux-serial@archiver.kernel.org>; Wed, 17 May 2023 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjEQP7B (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 May 2023 11:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjEQP6y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 May 2023 11:58:54 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B59728A
        for <linux-serial@vger.kernel.org>; Wed, 17 May 2023 08:58:33 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023051715583118a1465d4bce0a9f52
        for <linux-serial@vger.kernel.org>;
        Wed, 17 May 2023 17:58:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Sa2/lDymF7guLu5/iTBwB/pVI82RAGaOTwCGzH2ZfJs=;
 b=GGbH5S9CVsn0iyn2AM467c9w4vL3Ia8lP4NQfMoFErGuzQ9vWcRrvigDC/YCnFkNy0ovoD
 6NLoU6f4pviCO6yg2TCfBg2K0TCGQb1bv+UwaHmGcReOhouc2p3s/Vf94URSYEU8vbJajS+U
 IXTkWiALiGAJtR4DlF9uPIYctR8wg=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        felix-haase@siemens.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v5 08/10] tty: n_gsm: add DLCI specific rx/tx statistics
Date:   Wed, 17 May 2023 17:57:02 +0200
Message-Id: <20230517155704.5701-8-daniel.starke@siemens.com>
In-Reply-To: <20230517155704.5701-1-daniel.starke@siemens.com>
References: <20230517155704.5701-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Add counters for the number of data bytes received/transmitted per DLCI in
for preparation for an upcoming patch which will expose these values to the
user.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

v4 -> v5:
Added blank line before comment of new tx/rx fields in struct gsm_dlci as
suggested in the review.
The remarked upcoming patch which exposes these flags is now included in
patch 9/10. This has been done as recommended in the review.

Please note that I cannot response to emails until August 7th. Felix Haase
will take over from our side for questions regarding this patch series or
the n_gsm.

Link: https://lore.kernel.org/all/DB9PR10MB5881A7A09725EAF8FDB5F35BE0789@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 62bff4474b57..511f22489754 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -186,6 +186,10 @@ struct gsm_dlci {
 	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	struct net_device *net; /* network interface, if created */
+
+	/* Statistics (not currently exposed) */
+	u64 tx;			/* Data bytes sent on this DLCI */
+	u64 rx;			/* Data bytes received on this DLCI */
 };
 
 /*
@@ -1216,6 +1220,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 	tty_port_tty_wakeup(&dlci->port);
 
 	__gsm_data_queue(dlci, msg);
+	dlci->tx += len;
 	/* Bytes of data we used up */
 	return size;
 }
@@ -1283,6 +1288,7 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 	memcpy(dp, dlci->skb->data, len);
 	skb_pull(dlci->skb, len);
 	__gsm_data_queue(dlci, msg);
+	dlci->tx += len;
 	if (last) {
 		dev_kfree_skb_any(dlci->skb);
 		dlci->skb = NULL;
@@ -1461,6 +1467,7 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
 	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
 
 	return 0;
 }
@@ -1488,6 +1495,7 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
 	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
 }
 
 /**
@@ -1852,10 +1860,13 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 						const u8 *data, int clen)
 {
 	u8 buf[1];
+	struct gsm_dlci *dlci = gsm->dlci[0];
+
+	if (dlci)
+		dlci->rx += clen;
 
 	switch (command) {
 	case CMD_CLD: {
-		struct gsm_dlci *dlci = gsm->dlci[0];
 		/* Modem wishes to close down */
 		if (dlci) {
 			dlci->dead = true;
@@ -1934,6 +1945,8 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 
 	ctrl = gsm->pending_cmd;
 	dlci = gsm->dlci[0];
+	if (dlci)
+		dlci->rx += clen;
 	command |= 1;
 	/* Does the reply match our command */
 	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
@@ -2298,6 +2311,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 			need_pn = true;
 	}
 
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_WAITING_CONFIG:
@@ -2330,6 +2346,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
  */
 static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
 {
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_WAITING_CONFIG:
@@ -2349,6 +2368,9 @@ static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
  */
 static void gsm_dlci_set_wait_config(struct gsm_dlci *dlci)
 {
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_CLOSING:
@@ -2425,6 +2447,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 		fallthrough;
 	case 1:		/* Line state will go via DLCI 0 controls only */
 	default:
+		dlci->rx += clen;
 		tty_insert_flip_string(port, data, clen);
 		tty_flip_buffer_push(port);
 	}
@@ -2785,6 +2808,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 			gsm->open_error++;
 			return;
 		}
+		dlci->rx += gsm->len;
 		if (dlci->dead)
 			gsm_response(gsm, address, DM|PF);
 		else {
-- 
2.34.1

