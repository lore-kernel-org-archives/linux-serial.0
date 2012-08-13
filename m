From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/8] n_gsm.c: Implement 3GPP27.010 DLC start-up procedure in
 MUX
Date: Mon, 13 Aug 2012 13:43:15 +0100
Message-ID: <20120813124254.6125.70371.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43370 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2HMMZ6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Aug 2012 08:25:58 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: xiaojin <jin.xiao@intel.com>

In 3GPP27.010 5.8.1, it defined:
The TE multiplexer initiates the establishment of the multiplexer control channel by sending a SABM frame on DLCI 0 using the procedures of clause 5.4.1.
Once the multiplexer channel is established other DLCs may be established using the procedures of clause 5.4.1.
This patch implement 5.8.1 in MUX level, it make sure DLC0 is the first channel to be setup.

[or for those not familiar with the specification: it was possible to try
 and open a data connection while the control channel was not yet fully
 open, which is a spec violation and confuses some modems]

Signed-off-by: xiaojin <jin.xiao@intel.com>
Tested-by: Yin, Fengwei <fengwei.yin@intel.com>
[tweaked the order we check things and error code]
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: The Horsebox <stable@kernel.org>
---

 drivers/tty/n_gsm.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 7a4bf30..5c6c2e2 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2889,6 +2889,10 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 	gsm = gsm_mux[mux];
 	if (gsm->dead)
 		return -EL2HLT;
+	/* If DLCI 0 is not yet fully open return an error. This is ok from a locking
+	   perspective as we don't have to worry about this if DLCI0 is lost */
+	if (gsm->dlci[0] && gsm->dlci[0]->state != DLCI_OPEN) 
+		return -EL2NSYNC;
 	dlci = gsm->dlci[line];
 	if (dlci == NULL)
 		dlci = gsm_dlci_alloc(gsm, line);

