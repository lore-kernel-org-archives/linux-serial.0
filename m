From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [2.6 patch] drivers/serial/8250_pci.c: don't probe non-serial softmodems
Date: Wed, 20 Apr 2005 02:56:08 +0300
Message-ID: <20050419235608.GB8276@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sa10.bezeqint.net ([192.115.104.24]:10930 "EHLO
	sa10.bezeqint.net") by vger.kernel.org with ESMTP id S261202AbVDSXhh
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Apr 2005 19:37:37 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org
Cc: linux-serial@vger.kernel.org


Hello Russel,

Some soft modem pci devices (known list in the patch) claim to have 
'communication' class, and as result they are grabbed by serial driver.
Actually those devices are useless for serial drivers (it is not "real"
modem and doesn't have serial interface), but this prevents probing from
soft modem drivers (there are few in ALSA).

The patch below makes it possible to define ids of such known non-serial
devices and don't probe it by 8250_pci driver.

Thanks,
Sasha.


Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

diff -wru linux-2.6.12-rc1_orig/drivers/serial/8250_pci.c linux-2.6.12-rc1/drivers/serial/8250_pci.c
--- linux-2.6.12-rc1_orig/drivers/serial/8250_pci.c	2005-03-28 17:26:38.000000000 +0200
+++ linux-2.6.12-rc1/drivers/serial/8250_pci.c	2005-04-12 18:07:27.000000000 +0300
@@ -1605,6 +1605,22 @@
 }
 
 /*
+ * pci devices with appropriate class declared, but known as
+ * non modems or serial
+ */
+static struct pci_device_id __devinitdata non_serial_pci_tbl[] = {
+	{	0x163c, 0x3052,   /* smartlink softmodem */
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{	0x134d, 0x2189,   /* HSP1688 softmodem */
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{	PCI_VENDOR_ID_AL, 0x5457,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{	PCI_VENDOR_ID_AL, 0x5459,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, }
+};
+
+/*
  * Probe one serial board.  Unfortunately, there is no rhyme nor reason
  * to the arrangement of serial ports on a PCI card.
  */
@@ -1616,6 +1632,9 @@
 	struct pci_serial_quirk *quirk;
 	int rc, nr_ports, i;
 
+	if (pci_match_device(non_serial_pci_tbl, dev))
+		return -ENODEV;
+
 	if (ent->driver_data >= ARRAY_SIZE(pci_boards)) {
 		printk(KERN_ERR "pci_init_one: invalid driver_data: %ld\n",
 			ent->driver_data);
