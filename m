From: yegorslists@googlemail.com
Subject: [PATCH] serial: add support for 200 v3 series Titan card
Date: Mon,  9 Dec 2013 12:11:15 +0100
Message-ID: <1386587475-32751-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:54500 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab3LILo5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Dec 2013 06:44:57 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/tty/serial/8250/8250_pci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4697a51..f87438b 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1744,6 +1744,7 @@ pci_wch_ch353_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_TITAN_800E	0xA014
 #define PCI_DEVICE_ID_TITAN_200EI	0xA016
 #define PCI_DEVICE_ID_TITAN_200EISI	0xA017
+#define PCI_DEVICE_ID_TITAN_200V3	0xA306
 #define PCI_DEVICE_ID_TITAN_400V3	0xA310
 #define PCI_DEVICE_ID_TITAN_410V3	0xA312
 #define PCI_DEVICE_ID_TITAN_800V3	0xA314
@@ -4427,6 +4428,9 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EISI,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_2_4000000 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200V3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400V3,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_4_921600 },
-- 
1.7.7

