From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 7/8] n_gsm: replace kfree_skb w/ appropriate dev_* versions
Date: Mon, 13 Aug 2012 13:45:15 +0100
Message-ID: <20120813124509.6125.23690.stgit@localhost.localdomain>
References: <20120813124254.6125.70371.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43389 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2HMM1z (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Aug 2012 08:27:55 -0400
In-Reply-To: <20120813124254.6125.70371.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Russ Gorby <russ.gorby@intel.com>

Drivers are supposed to use the dev_* versions of the kfree_skb
interfaces. In a couple of cases we were called with IRQs
disabled as well which kfree_skb() does not expect.

Replaced kfree_skb calls w/ dev_kfree_skb and dev_kfree_skb_any

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Tested-by: Yin, Fengwei <fengwei.yin@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: Grooming <stable@kernel.org>
---

 drivers/tty/n_gsm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e2bdb8b..17c9e94 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -879,7 +879,7 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 	if (len > gsm->mtu) {
 		if (dlci->adaption == 3) {
 			/* Over long frame, bin it */
-			kfree_skb(dlci->skb);
+			dev_kfree_skb_any(dlci->skb);
 			dlci->skb = NULL;
 			return 0;
 		}
@@ -905,7 +905,7 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 	skb_pull(dlci->skb, len);
 	__gsm_data_queue(dlci, msg);
 	if (last) {
-		kfree_skb(dlci->skb);
+		dev_kfree_skb_any(dlci->skb);
 		dlci->skb = NULL;
 	}
 	return size;
@@ -1674,7 +1674,7 @@ static void gsm_dlci_free(struct kref *ref)
 	dlci->gsm->dlci[dlci->addr] = NULL;
 	kfifo_free(dlci->fifo);
 	while ((dlci->skb = skb_dequeue(&dlci->skb_list)))
-		kfree_skb(dlci->skb);
+		dev_kfree_skb(dlci->skb);
 	kfree(dlci);
 }
 
@@ -2013,7 +2013,7 @@ void gsm_cleanup_mux(struct gsm_mux *gsm)
 {
 	int i;
 	struct gsm_dlci *dlci = gsm->dlci[0];
-	struct gsm_msg *txq, *utxq;
+	struct gsm_msg *txq, *ntxq;
 	struct gsm_control *gc;
 
 	gsm->dead = 1;

