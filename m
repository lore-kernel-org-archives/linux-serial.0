From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 61/79] tty/n_gsm: avoid fifo overflow in gsm_dlci_data_output
Date: Wed, 26 Oct 2011 14:13:06 +0200
Message-ID: <1319631204-23262-61-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32839 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932942Ab1JZMN4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:56 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>

n_gsm use a simple approach: every writing to fifo correspond exactly one
reading from fifo. There are no problem in this approach until we read
less bytes then we write. As result fifo may owerflow. This leads to packet
loss and very slow responce.

For example, this happens with ping packets (about 96 byte each) and default
gsm->mtu = 64. As result we get 50 sec ping timeout and 20% packet loss.

Fix the problem by reading and sending all data from the fifo

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_gsm.c |   52 +++++++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 14c26cd..4cb0d0a 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -809,37 +809,41 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 {
 	struct gsm_msg *msg;
 	u8 *dp;
-	int len, size;
+	int len, total_size, size;
 	int h = dlci->adaption - 1;
 
-	len = kfifo_len(dlci->fifo);
-	if (len == 0)
-		return 0;
+	total_size = 0;
+	while(1) {
+		len = kfifo_len(dlci->fifo);
+		if (len == 0)
+			return total_size;
 
-	/* MTU/MRU count only the data bits */
-	if (len > gsm->mtu)
-		len = gsm->mtu;
+		/* MTU/MRU count only the data bits */
+		if (len > gsm->mtu)
+			len = gsm->mtu;
 
-	size = len + h;
+		size = len + h;
 
-	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
-	/* FIXME: need a timer or something to kick this so it can't
-	   get stuck with no work outstanding and no buffer free */
-	if (msg == NULL)
-		return -ENOMEM;
-	dp = msg->data;
-	switch (dlci->adaption) {
-	case 1:	/* Unstructured */
-		break;
-	case 2:	/* Unstructed with modem bits. Always one byte as we never
-		   send inline break data */
-		*dp++ = gsm_encode_modem(dlci);
-		break;
+		msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
+		/* FIXME: need a timer or something to kick this so it can't
+		   get stuck with no work outstanding and no buffer free */
+		if (msg == NULL)
+			return -ENOMEM;
+		dp = msg->data;
+		switch (dlci->adaption) {
+		case 1:	/* Unstructured */
+			break;
+		case 2:	/* Unstructed with modem bits. Always one byte as we never
+			   send inline break data */
+			*dp++ = gsm_encode_modem(dlci);
+			break;
+		}
+		WARN_ON(kfifo_out_locked(dlci->fifo, dp , len, &dlci->lock) != len);
+		__gsm_data_queue(dlci, msg);
+		total_size += size;
 	}
-	WARN_ON(kfifo_out_locked(dlci->fifo, dp , len, &dlci->lock) != len);
-	__gsm_data_queue(dlci, msg);
 	/* Bytes of data we used up */
-	return size;
+	return total_size;
 }
 
 /**
-- 
1.7.7

