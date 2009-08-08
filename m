From: Darius Augulis <augulis.darius@gmail.com>
Subject: [PATCH] 8250_pci: add support for MCS9865
Date: Sat, 08 Aug 2009 21:56:47 +0300
Message-ID: <20090808185647.2882.55946.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:60287 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbZHHTA7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Aug 2009 15:00:59 -0400
Received: by bwz19 with SMTP id 19so1972856bwz.37
        for <linux-serial@vger.kernel.org>; Sat, 08 Aug 2009 12:00:59 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: daugulis@linkodas.com

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---

 drivers/parport/parport_pc.c |    4 ++++
 drivers/serial/8250_pci.c    |   11 ++++++++++-
 include/linux/pci_ids.h      |    1 +
 3 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 2597145..2d83bb6 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2908,6 +2908,7 @@ enum parport_pc_pci_cards {
 	netmos_9805,
 	netmos_9815,
 	netmos_9901,
+	netmos_9865,
 	quatech_sppxp100,
 };
 
@@ -2989,6 +2990,7 @@ static struct parport_pc_pci {
 	/* netmos_9805 */               { 1, { { 0, -1 }, } },
 	/* netmos_9815 */               { 2, { { 0, -1 }, { 2, -1 }, } },
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
+	/* netmos_9865 */               { 1, { { 0, -1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 };
 
@@ -3092,6 +3094,8 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9815 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9901,
 	  0xA000, 0x2000, 0, 0, netmos_9901 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
+	  0xA000, 0x2000, 0, 0, netmos_9865 },
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index e7108e7..dc70e90 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -760,7 +760,8 @@ static int pci_netmos_init(struct pci_dev *dev)
 	/* subdevice 0x00PS means <P> parallel, <S> serial */
 	unsigned int num_serial = dev->subsystem_device & 0xf;
 
-	if (dev->device == PCI_DEVICE_ID_NETMOS_9901)
+	if ((dev->device == PCI_DEVICE_ID_NETMOS_9901) ||
+		(dev->device == PCI_DEVICE_ID_NETMOS_9865))
 		return 0;
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
 			dev->subsystem_device == 0x0299)
@@ -3565,6 +3566,14 @@ static struct pci_device_id serial_pci_tbl[] = {
 		0, 0, pbn_b0_1_115200 },
 
 	/*
+	 * Best Connectivity PCI Multi I/O cards
+	 */
+
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
+	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
 	 */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 73b46b6..75db1cd 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2645,6 +2645,7 @@
 #define PCI_DEVICE_ID_NETMOS_9835	0x9835
 #define PCI_DEVICE_ID_NETMOS_9845	0x9845
 #define PCI_DEVICE_ID_NETMOS_9855	0x9855
+#define PCI_DEVICE_ID_NETMOS_9865	0x9865
 #define PCI_DEVICE_ID_NETMOS_9901	0x9901
 
 #define PCI_VENDOR_ID_3COM_2		0xa727

