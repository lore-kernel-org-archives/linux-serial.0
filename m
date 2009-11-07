From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH] serial: add support for the Lava Quattro PCI quad-port 16550A card
Date: Sat, 7 Nov 2009 14:52:14 +0100
Message-ID: <20091107135214.GD18639@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fw.wantstofly.org ([80.101.37.227]:38474 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZKGOND (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 7 Nov 2009 09:13:03 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

This seems to be a different model (with a different PCI ID) than
the "Quatro" card that is also in the list.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 34b0b2b..e04b88a 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -3093,6 +3093,12 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_115200 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATTRO_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_115200 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATTRO_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_115200 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_4_460800 },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index da1fda8..7344e17 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1954,6 +1954,8 @@
 #define PCI_DEVICE_ID_LAVA_DSERIAL	0x0100 /* 2x 16550 */
 #define PCI_DEVICE_ID_LAVA_QUATRO_A	0x0101 /* 2x 16550, half of 4 port */
 #define PCI_DEVICE_ID_LAVA_QUATRO_B	0x0102 /* 2x 16550, half of 4 port */
+#define PCI_DEVICE_ID_LAVA_QUATTRO_A	0x0120 /* 2x 16550A, half of 4 port */
+#define PCI_DEVICE_ID_LAVA_QUATTRO_B	0x0121 /* 2x 16550A, half of 4 port */
 #define PCI_DEVICE_ID_LAVA_OCTO_A	0x0180 /* 4x 16550A, half of 8 port */
 #define PCI_DEVICE_ID_LAVA_OCTO_B	0x0181 /* 4x 16550A, half of 8 port */
 #define PCI_DEVICE_ID_LAVA_PORT_PLUS	0x0200 /* 2x 16650 */

--
