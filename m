From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/3] tty/n_gsm: fix bug in CRC calculation for gsm1 mode
Date: Fri, 22 Apr 2011 16:11:40 -0700
Message-ID: <1303513900-6169-3-git-send-email-gregkh@suse.de>
References: <20110422230713.GA5883@kroah.com>
 <1303513900-6169-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46568 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638Ab1DVXLo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Apr 2011 19:11:44 -0400
In-Reply-To: <1303513900-6169-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>, stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>

Problem description:
  gsm_queue() calculate a CRC for arrived frames. As a last step of
  CRC calculation it call

    gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->received_fcs);

  This work perfectly for the case of GSM0 mode as gsm->received_fcs
  contain the last piece of data required to generate final CRC.

  gsm->received_fcs is not used for GSM1 mode. Thus we put an
  additional byte to CRC calculation. As result we get a wrong CRC
  and reject incoming frame.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_gsm.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 47f8cdb..74273e6 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1658,8 +1658,12 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	if ((gsm->control & ~PF) == UI)
 		gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf, gsm->len);
-	/* generate final CRC with received FCS */
-	gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->received_fcs);
+	if (gsm->encoding == 0){
+		/* WARNING: gsm->received_fcs is used for gsm->encoding = 0 only.
+		            In this case it contain the last piece of data
+		            required to generate final CRC */
+		gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->received_fcs);
+	}
 	if (gsm->fcs != GOOD_FCS) {
 		gsm->bad_fcs++;
 		if (debug & 4)
-- 
1.7.4.2

