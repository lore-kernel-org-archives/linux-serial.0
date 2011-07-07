From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] n_gsm: fix the wrong FCS handling
Date: Thu, 07 Jul 2011 15:16:48 +0100
Message-ID: <20110707141618.2695.14222.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:51829 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802Ab1GGPVM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Jul 2011 11:21:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, stable@kernel.org, linux-serial@vger.kernel.org

From: \"Du, Alek\" <alek.du@intel.com>

FCS could be GSM0_SOF, so will break state machine...

[This byte isn't quoted in any way so a SOF here doesn't imply an error
 occurred.]

Signed-off-by: Alek Du <alek.du@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>

[Trivial but best backported once its in 3.1rc I think]
---

 drivers/tty/n_gsm.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index ec37f57..8a50e4e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1885,10 +1885,6 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 		break;
 	case GSM_FCS:		/* FCS follows the packet */
 		gsm->received_fcs = c;
-		if (c == GSM0_SOF) {
-			gsm->state = GSM_SEARCH;
-			break;
-		}
 		gsm_queue(gsm);
 		gsm->state = GSM_SSOF;
 		break;

