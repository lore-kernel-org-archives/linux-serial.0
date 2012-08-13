From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/8] n_gsm: uplink SKBs accumulate on list
Date: Mon, 13 Aug 2012 13:43:36 +0100
Message-ID: <20120813124326.6125.86930.stgit@localhost.localdomain>
References: <20120813124254.6125.70371.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43373 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2HMM0Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Aug 2012 08:26:16 -0400
In-Reply-To: <20120813124254.6125.70371.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Russ Gorby <russ.gorby@intel.com>

gsm_dlci_data_kick will not call any output function if tx_bytes > THRESH_LO
furthermore it will call the output function only once if tx_bytes == 0
If the size of the IP writes are on the order of THRESH_LO
we can get into a situation where skbs accumulate on the outbound list
being starved for events to call the output function.

gsm_dlci_data_kick now calls the sweep function when tx_bytes==0

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Tested-by: Kappel, LaurentX <laurentx.kappel@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: Hay and Water <stable@kernel.org>
---

 drivers/tty/n_gsm.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5c6c2e2..9b0a44d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -971,16 +971,19 @@ static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
 static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
 {
 	unsigned long flags;
+	int sweep;
 
 	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
 	/* If we have nothing running then we need to fire up */
+	sweep = (dlci->gsm->tx_bytes < TX_THRESH_LO);
 	if (dlci->gsm->tx_bytes == 0) {
 		if (dlci->net)
 			gsm_dlci_data_output_framed(dlci->gsm, dlci);
 		else
 			gsm_dlci_data_output(dlci->gsm, dlci);
-	} else if (dlci->gsm->tx_bytes < TX_THRESH_LO)
-		gsm_dlci_data_sweep(dlci->gsm);
+	}
+	if (sweep)
+ 		gsm_dlci_data_sweep(dlci->gsm);
 	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
 }
 

