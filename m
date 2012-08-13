From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 8/8] n_gsm: memory leak in uplink error path
Date: Mon, 13 Aug 2012 13:45:30 +0100
Message-ID: <20120813124525.6125.10943.stgit@localhost.localdomain>
References: <20120813124254.6125.70371.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43392 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2HMM2L (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Aug 2012 08:28:11 -0400
In-Reply-To: <20120813124254.6125.70371.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Russ Gorby <russ.gorby@intel.com>

Uplink (TX) network data will go through gsm_dlci_data_output_framed
there is a bug where if memory allocation fails, the skb which
has already been pulled off the list will be lost.

In addition TX skbs were being processed in LIFO order

Fixed the memory leak, and changed to FIFO order processing

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Tested-by: Kappel, LaurentX <laurentx.kappel@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: Showjumping <stable@kernel.org>
---

 drivers/tty/n_gsm.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 17c9e94..793bc38 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -868,7 +868,7 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 
 	/* dlci->skb is locked by tx_lock */
 	if (dlci->skb == NULL) {
-		dlci->skb = skb_dequeue(&dlci->skb_list);
+		dlci->skb = skb_dequeue_tail(&dlci->skb_list);
 		if (dlci->skb == NULL)
 			return 0;
 		first = 1;
@@ -892,8 +892,11 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 
 	/* FIXME: need a timer or something to kick this so it can't
 	   get stuck with no work outstanding and no buffer free */
-	if (msg == NULL)
+	if (msg == NULL) {
+		skb_queue_tail(&dlci->skb_list, dlci->skb);
+		dlci->skb = NULL;
 		return -ENOMEM;
+	}
 	dp = msg->data;
 
 	if (dlci->adaption == 4) { /* Interruptible framed (Packetised Data) */

