From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 37/79] n_gsm: Send CLD command on exit
Date: Wed, 26 Oct 2011 14:12:42 +0200
Message-ID: <1319631204-23262-37-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32770 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932899Ab1JZMNo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:44 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Alan Cox <alan@linux.intel.com>

A DISC on DLCI 0 should close down the mux but Michael Lauer reports this
is not the case for some modems. Send a CLD as well.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Tested-by: Michael Lauer
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_gsm.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index ed42908..8d7766b 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2003,6 +2003,7 @@ void gsm_cleanup_mux(struct gsm_mux *gsm)
 	int i;
 	struct gsm_dlci *dlci = gsm->dlci[0];
 	struct gsm_msg *txq;
+	struct gsm_control *gc;
 
 	gsm->dead = 1;
 
@@ -2016,6 +2017,13 @@ void gsm_cleanup_mux(struct gsm_mux *gsm)
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
-- 
1.7.7

