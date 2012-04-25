From: Arnaud Patard <apatard@hupstream.com>
Subject: [patch 1/1] 8250_pci: fix pch uart matching
Date: Wed, 25 Apr 2012 12:17:24 +0200
Message-ID: <20120425101731.672615402@hupstream.com>
References: <20120425101723.820229746@hupstream.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:53201 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab2DZS4g (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2012 14:56:36 -0400
Content-Disposition: inline; filename=pch_uart.patch
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org

The rules used to make 8250_pci "ignore" the PCH uarts are lacking pci subids
entries, preventing it to match and thus is breaking serial port support for
theses systems.

This has been tested on a nanoETXexpress-TT, which has a specifici uart clock.
 
Tested-by: Erwan Velu <Erwan.Velu@zodiacaerospace.com>
[stable@: please apply to 3.0-stable, 3.2-stable and 3.3-stable]
Cc: stable@vger.kernel.org
Signed-off-by: Arnaud Patard <apatard@hupstream.com>
Index: arm-soc/drivers/tty/serial/8250/8250_pci.c
===================================================================
--- arm-soc.orig/drivers/tty/serial/8250/8250_pci.c	2012-04-19 20:40:44.336120603 +0200
+++ arm-soc/drivers/tty/serial/8250/8250_pci.c	2012-04-25 11:56:10.714697583 +0200
@@ -1609,54 +1609,72 @@ static struct pci_serial_quirk pci_seria
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8811,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8812,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8813,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8814,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x8027,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x8028,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x8029,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x800C,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x800D,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},


