From: "Christian P. Schmidt" <charlie@digadd.de>
Subject: [patch] Add blacklisting capability to serial_pci to avoid misdetection
 of serial ports
Date: Sun, 08 Jul 2007 12:38:17 +0300
Message-ID: <4690B089.2050908@digadd.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000302070009000305000000"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from echo.digadd.de ([195.47.195.234]:35556 "EHLO mx2.digadd.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755101AbXGHKDR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 8 Jul 2007 06:03:17 -0400
Received: from [192.168.255.30]
	by mx2.digadd.de with esmtp (Exim 4.67)
	(envelope-from <charlie@digadd.de>)
	id 1I7TAa-0001sZ-DA
	for linux-serial@vger.kernel.org; Sun, 08 Jul 2007 11:35:10 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------000302070009000305000000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

[Resend, originally sent to the lkml]

The serial_pci driver tries to guess serial ports on unknown devices
based on the PCI class (modem or serial). On certain softmodems (AC'97
modems) this can lead to the recognition of non-existing serial ports
like this:

0000:00:08.0: ttyS1 at I/O 0x8828 (irq = 3) is a 8250
0000:00:08.0: ttyS2 at I/O 0x8840 (irq = 3) is a 8250
0000:00:08.0: ttyS3 at I/O 0x8850 (irq = 3) is a 8250
0000:00:08.0: ttyS4 at I/O 0x8860 (irq = 3) is a 8250
0000:00:08.0: ttyS5 at I/O 0x8870 (irq = 3) is a 8250

This actually disables the use of the hsfmodem 3rd party driver if 8250
is compiled into the kernel e.g. to provide a boot-time serial console.

This patch adds a blacklist of PCI IDs that are to be ignored by the driver.

The patch applies against both 2.6.21.5 and 2.6.22-rc7.

Signed-off-by: Christian Schmidt <schmidt@digadd.de>



--------------000302070009000305000000
Content-Type: text/plain;
 name="8250_pci.blacklist.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250_pci.blacklist.patch"

--- linux-2.6.21.5.orig/drivers/serial/8250_pci.c	2007-04-26 06:08:32.000000000 +0300
+++ linux-2.6.21.5/drivers/serial/8250_pci.c	2007-07-05 17:26:32.000000000 +0300
@@ -1513,6 +1513,11 @@
 	},
 };
 
+static const struct pci_device_id softmodem_blacklist[] = {
+     { PCI_VDEVICE ( AL, 0x5457 ), }, /* ALi Corporation M5457 AC'97 Modem */
+     { }
+};
+
 /*
  * Given a complete unknown PCI device, try to use some heuristics to
  * guess what the configuration might be, based on the pitiful PCI
@@ -1521,6 +1526,7 @@
 static int __devinit
 serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 {
+        const struct pci_device_id * blacklist;
 	int num_iomem, num_port, first_port = -1, i;
 	
 	/*
@@ -1535,6 +1541,16 @@
 	    (dev->class & 0xff) > 6)
 		return -ENODEV;
 
+	/*
+	 * Do not access blacklisted devices that are known not to
+	 * feature serial ports.
+	 */
+	for (blacklist = softmodem_blacklist; blacklist->vendor; blacklist++) {
+	        if ((dev->vendor == blacklist->vendor) &&
+	            (dev->device == blacklist->device))
+		        return -ENODEV;
+	}
+	
 	num_iomem = num_port = 0;
 	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
 		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {


--------------000302070009000305000000--
