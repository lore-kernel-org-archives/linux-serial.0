From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] serial/pcmcia: add ID for Advantech card
Date: Sat,  1 Aug 2009 15:28:35 +0200
Message-ID: <1249133315-21142-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33490 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZHAN2f (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Aug 2009 09:28:35 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org, KMoorman@transy.edu, Wolfram Sang <w.sang@pengutronix.de>, Greg KH <gregkh@suse.de>

Add ID as reported in:

http://lists.infradead.org/pipermail/linux-pcmcia/2009-May/006127.html

Reported-by: Kenneth Moorman <KMoorman@transy.edu>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Greg KH <gregkh@suse.de>
---

As this just adds an ID, it might be nice to have in 2.6.31 already. Greg, could
you pick it up perhaps? Otherwise I'll queue it up in my pcmcia-l2-branch which
Dominik hopefully pulls for 2.6.32.

 drivers/serial/serial_cs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 79c9c5f..6ecb51b 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -884,6 +884,7 @@ static struct pcmcia_device_id serial_ids[] = {
 	PCMCIA_DEVICE_CIS_MANF_CARD(0x0192, 0xa555, "SW_555_SER.cis"),  /* Sierra Aircard 555 CDMA 1xrtt Modem -- pre update */
 	PCMCIA_DEVICE_CIS_MANF_CARD(0x013f, 0xa555, "SW_555_SER.cis"),  /* Sierra Aircard 555 CDMA 1xrtt Modem -- post update */
 	PCMCIA_DEVICE_CIS_PROD_ID12("MultiTech", "PCMCIA 56K DataFax", 0x842047ee, 0xc2efcf03, "MT5634ZLX.cis"),
+	PCMCIA_DEVICE_CIS_PROD_ID12("ADVANTECH", "COMpad-32/85B-2", 0x96913a85, 0x27ab5437, "COMpad2.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID12("ADVANTECH", "COMpad-32/85B-4", 0x96913a85, 0xcec8f102, "COMpad4.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID123("ADVANTECH", "COMpad-32/85", "1.0", 0x96913a85, 0x8fbe92ae, 0x0877b627, "COMpad2.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID2("RS-COM 2P", 0xad20b156, "RS-COM-2P.cis"),
-- 
1.6.3.1

