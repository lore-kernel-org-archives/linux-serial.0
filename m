From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 1/2] tty: rocket: Explicitly list supported PCI IDs
Date: Wed, 16 Jan 2013 20:28:39 -0800
Message-ID: <1ee681e19fb4ce83f2a133c35fe635ae@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [69.28.251.93] ([69.28.251.93]:50392 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758484Ab3AQE3n (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 23:29:43 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-serial@vger.kernel.org, dwmw2@infradead.org, ben@decadent.org.uk

Matching PCI_ANY_ID causes conflicts with RocketPort 2 adapters, which
are supported by a different driver.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/rocket.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)


V1->V2 changes:

 - Use standard PCI_DEVICE_ID_* constants in the ID table


diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 69c16fc..1d27003 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1756,8 +1756,29 @@ static void rp_flush_buffer(struct tty_struct *tty)
 
 #ifdef CONFIG_PCI
 
-static struct pci_device_id __used rocket_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_ANY_ID) },
+static DEFINE_PCI_DEVICE_TABLE(rocket_pci_ids) = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP4QUAD) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP8OCTA) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_URP8OCTA) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP8INTF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_URP8INTF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP8J) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP4J) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP8SNI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP16SNI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP16INTF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_URP16INTF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_CRP16INTF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP32INTF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_URP32INTF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RPP4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RPP8) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP2_232) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP2_422) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP6M) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_RP4M) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_UPCI_RM3_8PORT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_UPCI_RM3_4PORT) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, rocket_pci_ids);
@@ -1779,7 +1800,8 @@ static __init int register_PCI(int i, struct pci_dev *dev)
 	WordIO_t ConfigIO = 0;
 	ByteIO_t UPCIRingInd = 0;
 
-	if (!dev || pci_enable_device(dev))
+	if (!dev || !pci_match_id(rocket_pci_ids, dev) ||
+	    pci_enable_device(dev))
 		return 0;
 
 	rcktpt_io_addr[i] = pci_resource_start(dev, 0);
-- 
1.7.10.4

