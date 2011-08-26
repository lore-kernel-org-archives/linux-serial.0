From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/2] n_gsm: Send CLD command on exit
Date: Fri, 26 Aug 2011 11:28:11 +0100
Message-ID: <20110826102746.17092.95409.stgit@localhost.localdomain>
References: <20110826102731.17092.52217.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60893 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1HZLVA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 07:21:00 -0400
In-Reply-To: <20110826102731.17092.52217.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

A DISC on DLCI 0 should close down the mux but Michael Lauer reports this
is not the case for some modems. Send a CLD as well.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Tested-by: Michael Lauer
---

 drivers/tty/n_gsm.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8f03ea7..b90638c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2005,6 +2005,7 @@ void gsm_cleanup_mux(struct gsm_mux *gsm)
 	int i;
 	struct gsm_dlci *dlci = gsm->dlci[0];
 	struct gsm_msg *txq;
+	struct gsm_control *gc;
 
 	gsm->dead = 1;
 
@@ -2018,6 +2019,13 @@ void gsm_cleanup_mux(struct gsm_mux *gsm)
 	spin_unlock(&gsm_mux_lock);
 	WARN_ON(i == MAX_MUX);
 
+	/* In theory disconnecting DLCI 0 is sufficient but for some
+	   modems this is apparently not the case. */
+	if (dlci) {
+		gc = gsm_control_send(gsm, CMD_CLD, NULL, 0);
+		if (gc)
+			gsm_control_wait(gsm, gc);
+	}
 	del_timer_sync(&gsm->t2_timer);
 	/* Now we are sure T2 has stopped */
 	if (dlci) {

