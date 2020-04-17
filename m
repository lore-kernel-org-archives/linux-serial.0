Return-Path: <SRS0=oPkf=6B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942FAC352BE
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 11:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBCF208E4
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 11:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgDQLAD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:00:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729512AbgDQLAC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Apr 2020 07:00:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76B60ACD0;
        Fri, 17 Apr 2020 11:00:00 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/2] tty: rocket, remove unneeded variable
Date:   Fri, 17 Apr 2020 12:59:58 +0200
Message-Id: <20200417105959.15201-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

num_chan in register_PCI is used only as an alias for ports_per_aiop. So
drop num_chan and use ports_per_aiop directly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/rocket.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index fbaa4ec85560..077ef849f8cb 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1882,7 +1882,7 @@ static int sPCIInitController(CONTROLLER_T * CtlP, int CtlNum,
  */
 static __init int register_PCI(int i, struct pci_dev *dev)
 {
-	int num_aiops, aiop, max_num_aiops, num_chan, chan;
+	int num_aiops, aiop, max_num_aiops, chan;
 	unsigned int aiopio[MAX_AIOPS_PER_BOARD];
 	CONTROLLER_t *ctlp;
 
@@ -2154,8 +2154,7 @@ static __init int register_PCI(int i, struct pci_dev *dev)
 	/*  Reset the AIOPIC, init the serial ports */
 	for (aiop = 0; aiop < num_aiops; aiop++) {
 		sResetAiopByNum(ctlp, aiop);
-		num_chan = ports_per_aiop;
-		for (chan = 0; chan < num_chan; chan++)
+		for (chan = 0; chan < ports_per_aiop; chan++)
 			init_r_port(i, aiop, chan, dev);
 	}
 
@@ -2163,11 +2162,10 @@ static __init int register_PCI(int i, struct pci_dev *dev)
 	if ((rcktpt_type[i] == ROCKET_TYPE_MODEM) ||
 	    (rcktpt_type[i] == ROCKET_TYPE_MODEMII) ||
 	    (rcktpt_type[i] == ROCKET_TYPE_MODEMIII)) {
-		num_chan = ports_per_aiop;
-		for (chan = 0; chan < num_chan; chan++)
+		for (chan = 0; chan < ports_per_aiop; chan++)
 			sPCIModemReset(ctlp, chan, 1);
 		msleep(500);
-		for (chan = 0; chan < num_chan; chan++)
+		for (chan = 0; chan < ports_per_aiop; chan++)
 			sPCIModemReset(ctlp, chan, 0);
 		msleep(500);
 		rmSpeakerReset(ctlp, rocketModel[i].model);
-- 
2.26.1

