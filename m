From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 26/75] Convert the oxsemi tornado special cases to use the
	quirk interface and not
Date: Fri, 02 Jan 2009 13:44:20 +0000
Message-ID: <20090102134418.13472.28961.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60341 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756187AbZABNoF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:44:05 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>

scribble on its own reference structures.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/8250_pci.c |   91 +++++++++++++++++++++++++--------------------
 1 files changed, 51 insertions(+), 40 deletions(-)


diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 5450a0e..057b532 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -737,6 +737,38 @@ static void __devexit pci_ite887x_exit(struct pci_dev *dev)
 	release_region(ioport, ITE_887x_IOSIZE);
 }
 
+/*
+ * Oxford Semiconductor Inc.
+ * Check that device is part of the Tornado range of devices, then determine
+ * the number of ports available on the device.
+ */
+static int pci_oxsemi_tornado_init(struct pci_dev *dev)
+{
+	u8 __iomem *p;
+	unsigned long deviceID;
+	unsigned int  number_uarts = 0;
+
+	/* OxSemi Tornado devices are all 0xCxxx */
+	if (dev->vendor == PCI_VENDOR_ID_OXSEMI &&
+	    (dev->device & 0xF000) != 0xC000)
+		return 0;
+
+	p = pci_iomap(dev, 0, 5);
+	if (p == NULL)
+		return -ENOMEM;
+
+	deviceID = ioread32(p);
+	/* Tornado device */
+	if (deviceID == 0x07000200) {
+		number_uarts = ioread8(p + 4);
+		printk(KERN_DEBUG
+			"%d ports detected on Oxford PCI Express device\n",
+								number_uarts);
+	}
+	pci_iounmap(dev, p);
+	return number_uarts;
+}
+
 static int
 pci_default_setup(struct serial_private *priv, struct pciserial_board *board,
 		  struct uart_port *port, int idx)
@@ -1018,6 +1050,25 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_default_setup,
 	},
 	/*
+	 * For Oxford Semiconductor and Mainpine
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_OXSEMI,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MAINPINE,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_default_setup,
+	},
+	/*
 	 * Default "match everything" terminator entry
 	 */
 	{
@@ -1854,39 +1905,6 @@ serial_pci_matches(struct pciserial_board *board,
 	    board->first_offset == guessed->first_offset;
 }
 
-/*
- * Oxford Semiconductor Inc.
- * Check that device is part of the Tornado range of devices, then determine
- * the number of ports available on the device.
- */
-static int pci_oxsemi_tornado_init(struct pci_dev *dev, struct pciserial_board *board)
-{
-	u8 __iomem *p;
-	unsigned long deviceID;
-	unsigned int  number_uarts;
-
-	/* OxSemi Tornado devices are all 0xCxxx */
-	if (dev->vendor == PCI_VENDOR_ID_OXSEMI &&
-	    (dev->device & 0xF000) != 0xC000)
-		return 0;
-
-	p = pci_iomap(dev, 0, 5);
-	if (p == NULL)
-		return -ENOMEM;
-
-	deviceID = ioread32(p);
-	/* Tornado device */
-	if (deviceID == 0x07000200) {
-		number_uarts = ioread8(p + 4);
-		board->num_ports = number_uarts;
-		printk(KERN_DEBUG
-			"%d ports detected on Oxford PCI Express device\n",
-								number_uarts);
-	}
-	pci_iounmap(dev, p);
-	return 0;
-}
-
 struct serial_private *
 pciserial_init_ports(struct pci_dev *dev, struct pciserial_board *board)
 {
@@ -1895,13 +1913,6 @@ pciserial_init_ports(struct pci_dev *dev, struct pciserial_board *board)
 	struct pci_serial_quirk *quirk;
 	int rc, nr_ports, i;
 
-	/*
-	 * Find number of ports on board
-	 */
-	if (dev->vendor == PCI_VENDOR_ID_OXSEMI ||
-	    dev->vendor == PCI_VENDOR_ID_MAINPINE)
-		pci_oxsemi_tornado_init(dev, board);
-
 	nr_ports = board->num_ports;
 
 	/*

