From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/3] tty: rocket: Explicitly list supported PCI IDs
Date: Sat, 29 Dec 2012 23:23:23 -0800
Message-ID: <8e99cbf1f2bdfacaeaf0a5ac99d99309@localhost>
References: <bd10fdeead3e321db2bb291c0b722203@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [69.28.251.93] ([69.28.251.93]:50663 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751632Ab2L3HhE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 30 Dec 2012 02:37:04 -0500
In-Reply-To: <bd10fdeead3e321db2bb291c0b722203@localhost>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-serial@vger.kernel.org, dwmw2@infradead.org, ben@decadent.org.uk

Matching PCI_ANY_ID causes conflicts with RocketPort 2 adapters, which
are supported by a different driver.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/rocket.c |   31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index e42009a..c73ca4e 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1758,8 +1758,32 @@ static void rp_flush_buffer(struct tty_struct *tty)
 
 #ifdef CONFIG_PCI
 
-static struct pci_device_id __used rocket_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_ANY_ID) },
+#define RP_PCI_DEVICE(id) \
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_##id) }
+
+static DEFINE_PCI_DEVICE_TABLE(rocket_pci_ids) = {
+	RP_PCI_DEVICE(RP4QUAD),
+	RP_PCI_DEVICE(RP8OCTA),
+	RP_PCI_DEVICE(URP8OCTA),
+	RP_PCI_DEVICE(RP8INTF),
+	RP_PCI_DEVICE(URP8INTF),
+	RP_PCI_DEVICE(RP8J),
+	RP_PCI_DEVICE(RP4J),
+	RP_PCI_DEVICE(RP8SNI),
+	RP_PCI_DEVICE(RP16SNI),
+	RP_PCI_DEVICE(RP16INTF),
+	RP_PCI_DEVICE(URP16INTF),
+	RP_PCI_DEVICE(CRP16INTF),
+	RP_PCI_DEVICE(RP32INTF),
+	RP_PCI_DEVICE(URP32INTF),
+	RP_PCI_DEVICE(RPP4),
+	RP_PCI_DEVICE(RPP8),
+	RP_PCI_DEVICE(RP2_232),
+	RP_PCI_DEVICE(RP2_422),
+	RP_PCI_DEVICE(RP6M),
+	RP_PCI_DEVICE(RP4M),
+	RP_PCI_DEVICE(UPCI_RM3_8PORT),
+	RP_PCI_DEVICE(UPCI_RM3_4PORT),
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, rocket_pci_ids);
@@ -1781,7 +1805,8 @@ static __init int register_PCI(int i, struct pci_dev *dev)
 	WordIO_t ConfigIO = 0;
 	ByteIO_t UPCIRingInd = 0;
 
-	if (!dev || pci_enable_device(dev))
+	if (!dev || !pci_match_id(rocket_pci_ids, dev) ||
+	    pci_enable_device(dev))
 		return 0;
 
 	rcktpt_io_addr[i] = pci_resource_start(dev, 0);
-- 
1.7.10.4

