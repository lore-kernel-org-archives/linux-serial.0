From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 39/48] 8250_pci: Add support for the Digi/IBM PCIe 2-port Adapter
Date: Mon, 23 May 2011 12:10:45 -0700
Message-ID: <1306177854-18172-39-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47358 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932294Ab1EWTMD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:12:03 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Scott Kilau <scottk@digi.com>, Michael Reed <mreed10@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Scott Kilau <scottk@digi.com>

Add support to the 8250 PCI serial driver for the Digi/IBM PCIe 2-port Async EIA-232 Adapter.

Oxford Semiconductor produces a 2/4/8 port UART (OXPCIe952/OXPCIe954/OXPCIe958) chip
called the Tornado, that can be used to create a very simple serial board product.
The kernel sources currently have just 2 vendors using this chip, which is Oxford and Mainpipe.
This new Digi/IBM serial product now uses it as well.

Rather than create a long running comment of vendors using the chip, the one changed comment
in the patch below now just lists "For Oxford Semiconductor Tornado based devices" to be a
more generic comment for all vendors that end up using the Oxford Tornado chip.

Cc: Michael Reed <mreed10@us.ibm.com>
Signed-off-by: Scott Kilau <scottk@digi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250_pci.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 98311ac..762db97 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -1010,6 +1010,7 @@ static int skip_tx_en_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_TITAN_200EI	0xA016
 #define PCI_DEVICE_ID_TITAN_200EISI	0xA017
 #define PCI_DEVICE_ID_OXSEMI_16PCI958	0x9538
+#define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -1410,7 +1411,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_default_setup,
 	},
 	/*
-	 * For Oxford Semiconductor and Mainpine
+	 * For Oxford Semiconductor Tornado based devices
 	 */
 	{
 		.vendor		= PCI_VENDOR_ID_OXSEMI,
@@ -1428,6 +1429,14 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.init		= pci_oxsemi_tornado_init,
 		.setup		= pci_default_setup,
 	},
+	{
+		.vendor		= PCI_VENDOR_ID_DIGI,
+		.device		= PCIE_DEVICE_ID_NEO_2_OX_IBM,
+		.subvendor		= PCI_SUBVENDOR_ID_IBM,
+		.subdevice		= PCI_ANY_ID,
+		.init			= pci_oxsemi_tornado_init,
+		.setup		= pci_default_setup,
+	},
 	/*
 	 * Default "match everything" terminator entry
 	 */
@@ -3073,6 +3082,14 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 8 Port V.34 Super-G3 Fax */
 		PCI_VENDOR_ID_MAINPINE, 0x4008, 0, 0,
 		pbn_oxsemi_8_4000000 },
+
+	/*
+	 * Digi/IBM PCIe 2-port Async EIA-232 Adapter utilizing OxSemi Tornado
+	 */
+	{	PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_2_OX_IBM,
+		PCI_SUBVENDOR_ID_IBM, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_4000000 },
+
 	/*
 	 * SBS Technologies, Inc. P-Octal and PMC-OCTPRO cards,
 	 * from skokodyn@yahoo.com
-- 
1.7.4.2

