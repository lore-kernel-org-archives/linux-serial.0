From: gianluca <gianluca@sottospazio.it>
Subject: [PATCH] Add PCI IDs and quirks for WCH CH353 2S1P card
Date: Wed, 29 Aug 2012 20:24:29 +0200
Message-ID: <20120829182429.GA15239@server>
References: <20120828122458.GB1258@server>
 <20120828135529.6a826b19@pyramind.ukuu.org.uk>
 <20120828135720.GA2803@server>
 <20120829142815.231d5fdf@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:37069 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab2H2SYj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Aug 2012 14:24:39 -0400
Content-Disposition: inline
In-Reply-To: <20120829142815.231d5fdf@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add new PCI ids for WCH CH353 2Serial 1Parallel Multi-IO PCI Card to
parport_serial.c.

To allow parport_serial to handle the card the same PCI ids are blacklisted
in 8250_pci.c using the existing softmodem blacklist mechanism.

The blacklist array is also renamed because it now covers this new use case.

Since the two serial ports are autodetected as XScale instead of 16550A clones,
add also a quirk to 8250_pci.c to skip autodetection and set the correct port
type.

The patch is against linux v3.5.3 but applies cleanly also to latest git head.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wch.patch"

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
index 28e7c7c..226b4db 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1157,6 +1157,16 @@ pci_xr17c154_setup(struct serial_private *priv,
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
@@ -1727,6 +1737,14 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
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
 	 * Default "match everything" terminator entry
 	 */
@@ -2624,10 +2642,14 @@ static struct pciserial_board pci_boards[] __devinitdata = {
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
@@ -2638,7 +2660,7 @@ static const struct pci_device_id softmodem_blacklist[] = {
 static int __devinit
 serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 {
-	const struct pci_device_id *blacklist;
+	const struct pci_device_id *bldev;
 	int num_iomem, num_port, first_port = -1, i;
 
 	/*
@@ -2655,13 +2677,13 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 
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
 

--bp/iNruPH9dso1Pn--
