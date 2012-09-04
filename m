From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] parport_serial: Add support for the WCH353 2S/1P multi-IO card
Date: Tue, 04 Sep 2012 15:44:24 +0100
Message-ID: <20120904144416.25377.7952.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43138 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188Ab2IDO0n (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Sep 2012 10:26:43 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com

From: Guainluca Anzolin <gianluca@sottospazio.it>

To allow parport_serial to handle the card the same PCI ids are blacklisted
in 8250_pci.c using the existing software blacklist mechanism.

The blacklist array is also renamed because it now covers this new use
case.

Since the two serial ports are auto-detected as XScale instead of 16550A
clones, we also add a quirk to 8250_pci.c to skip autodetection and set the
correct port type.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/parport/parport_serial.c   |   11 +++++++++-
 drivers/tty/serial/8250/8250_pci.c |   38 ++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index e9c3227..1631eea 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -62,6 +62,7 @@ enum parport_pc_pci_cards {
 	timedia_9079a,
 	timedia_9079b,
 	timedia_9079c,
+	wch_ch353_2s1p,
 };
 
 /* each element directly indexed from enum list, above */
@@ -145,6 +146,7 @@ static struct parport_pc_pci cards[] __devinitdata = {
 	/* timedia_9079a */             { 1, { { 2, 3 }, } },
 	/* timedia_9079b */             { 1, { { 2, 3 }, } },
 	/* timedia_9079c */             { 1, { { 2, 3 }, } },
+	/* wch_ch353_2s1p*/             { 1, { { 2, -1}, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -243,7 +245,8 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ 0x1409, 0x7168, 0x1409, 0xb079, 0, 0, timedia_9079a },
 	{ 0x1409, 0x7168, 0x1409, 0xc079, 0, 0, timedia_9079b },
 	{ 0x1409, 0x7168, 0x1409, 0xd079, 0, 0, timedia_9079c },
-
+	/* WCH CARDS */
+	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -460,6 +463,12 @@ static struct pciserial_board pci_parport_serial_boards[] __devinitdata = {
 		.base_baud	= 921600,
 		.uart_offset	= 8,
 	},
+	[wch_ch353_2s1p] = {
+		.flags          = FL_BASE0|FL_BASE_BARS,
+		.num_ports      = 2,
+		.base_baud      = 115200,
+		.uart_offset    = 8,
+	},
 };
 
 struct parport_serial_private {
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index ad4bb8d..2d69117 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1164,6 +1164,16 @@ pci_xr17c154_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
+static int
+pci_wch_ch353_setup(struct serial_private *priv,
+                    const struct pciserial_board *board,
+                    struct uart_port *port, int idx)
+{
+	port->flags |= UPF_FIXED_TYPE;
+	port->type = PORT_16550A;
+	return pci_default_setup(priv, board, port, idx);
+}
+
 #define PCI_VENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_DEVICE_ID_OCTPRO		0x0001
@@ -1737,6 +1747,14 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_omegapci_setup,
 	},
+	/* WCH CH353 2S1P card (16550 clone) */
+	{
+		.vendor         = 0x4348,
+		.device         = 0x7053,
+		.subvendor      = 0x4348,
+		.subdevice      = 0x3253,
+		.setup          = pci_wch_ch353_setup,
+	},
 	/*
 	 * ASIX devices with FIFO bug
 	 */
@@ -2636,10 +2654,14 @@ static struct pciserial_board pci_boards[] __devinitdata = {
 	},
 };
 
-static const struct pci_device_id softmodem_blacklist[] = {
+static const struct pci_device_id blacklist[] = {
+	/* softmodems */
 	{ PCI_VDEVICE(AL, 0x5457), }, /* ALi Corporation M5457 AC'97 Modem */
 	{ PCI_VDEVICE(MOTOROLA, 0x3052), }, /* Motorola Si3052-based modem */
 	{ PCI_DEVICE(0x1543, 0x3052), }, /* Si3052-based modem, default IDs */
+
+	/* multi-io cards handled by parport_serial */
+	{ PCI_DEVICE(0x4348, 0x7053), }, /* WCH CH353 2S1P */
 };
 
 /*
@@ -2650,7 +2672,7 @@ static const struct pci_device_id softmodem_blacklist[] = {
 static int __devinit
 serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 {
-	const struct pci_device_id *blacklist;
+	const struct pci_device_id *bldev;
 	int num_iomem, num_port, first_port = -1, i;
 
 	/*
@@ -2667,13 +2689,13 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 
 	/*
 	 * Do not access blacklisted devices that are known not to
-	 * feature serial ports.
+	 * feature serial ports or are handled by other modules.
 	 */
-	for (blacklist = softmodem_blacklist;
-	     blacklist < softmodem_blacklist + ARRAY_SIZE(softmodem_blacklist);
-	     blacklist++) {
-		if (dev->vendor == blacklist->vendor &&
-		    dev->device == blacklist->device)
+	for (bldev = blacklist;
+	     bldev < blacklist + ARRAY_SIZE(blacklist);
+	     bldev++) {
+		if (dev->vendor == bldev->vendor &&
+		    dev->device == bldev->device)
 			return -ENODEV;
 	}
 

