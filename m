From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] serial: support the Exsys EX-4055 4S four-port card
Date: Mon, 24 Oct 2005 10:58:31 -0600
Message-ID: <200510241058.31419.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:36569 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751161AbVJXQ6l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Oct 2005 12:58:41 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+serial@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, Wolfgang Denk <wd@denx.de>

Tested by Wolfgang Denk with this device:

    00:0f.0 Network controller: PLX Technology, Inc. PCI <-> IOBus Bridge (rev 01)
        Subsystem: Exsys EX-4055 4S(16C550) RS-232
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 80100000 (32-bit, non-prefetchable) [size=128]
        Region 1: I/O ports at 7080 [size=128]
        Region 2: I/O ports at 7400 [size=32]

    00:0f.0 Class 0280: 10b5:9050 (rev 01)
        Subsystem: d84d:4055

Results with this patch:

    Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
    ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
    PCI: Found IRQ 10 for device 0000:00:0f.0
    ttyS4 at I/O 0x7400 (irq = 10) is a 16550A
    ttyS5 at I/O 0x7408 (irq = 10) is a 16550A
    ttyS6 at I/O 0x7410 (irq = 10) is a 16550A
    ttyS7 at I/O 0x7418 (irq = 10) is a 16550A

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: denk/drivers/serial/8250_pci.c
===================================================================
--- denk.orig/drivers/serial/8250_pci.c	2005-10-24 10:21:43.000000000 -0600
+++ denk/drivers/serial/8250_pci.c	2005-10-24 10:21:44.000000000 -0600
@@ -226,8 +226,10 @@
 	}
 
 	irq_config = 0x41;
-	if (dev->vendor == PCI_VENDOR_ID_PANACOM)
+	if (dev->vendor == PCI_VENDOR_ID_PANACOM ||
+	    dev->subsystem_vendor == PCI_SUBVENDOR_ID_EXSYS) {
 		irq_config = 0x43;
+	}
 	if ((dev->vendor == PCI_VENDOR_ID_PLX) &&
 	    (dev->device == PCI_DEVICE_ID_PLX_ROMULUS)) {
 		/*
@@ -664,6 +666,15 @@
 	{
 		.vendor		= PCI_VENDOR_ID_PLX,
 		.device		= PCI_DEVICE_ID_PLX_9050,
+		.subvendor	= PCI_SUBVENDOR_ID_EXSYS,
+		.subdevice	= PCI_SUBDEVICE_ID_EXSYS_4055,
+		.init		= pci_plx9050_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_plx9050_exit),
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_PLX,
+		.device		= PCI_DEVICE_ID_PLX_9050,
 		.subvendor	= PCI_SUBVENDOR_ID_KEYSPAN,
 		.subdevice	= PCI_SUBDEVICE_ID_KEYSPAN_SX2,
 		.init		= pci_plx9050_init,
@@ -927,6 +938,7 @@
 	pbn_panacom,
 	pbn_panacom2,
 	pbn_panacom4,
+	pbn_exsys_4055,
 	pbn_plx_romulus,
 	pbn_oxsemi,
 	pbn_intel_i960,
@@ -1292,6 +1304,13 @@
 		.reg_shift	= 7,
 	},
 
+	[pbn_exsys_4055] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+
 	/* I think this entry is broken - the first_offset looks wrong --rmk */
 	[pbn_plx_romulus] = {
 		.flags		= FL_BASE2,
@@ -1853,6 +1872,10 @@
 		PCI_SUBVENDOR_ID_CHASE_PCIRAS,
 		PCI_SUBDEVICE_ID_CHASE_PCIRAS8, 0, 0, 
 		pbn_b2_8_460800 },
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+		PCI_SUBVENDOR_ID_EXSYS,
+		PCI_SUBDEVICE_ID_EXSYS_4055, 0, 0,
+		pbn_exsys_4055 },
 	/*
 	 * Megawolf Romulus PCI Serial Card, from Mike Hudson
 	 * (Exoray@isys.ca)
Index: denk/include/linux/pci_ids.h
===================================================================
--- denk.orig/include/linux/pci_ids.h	2005-10-24 10:21:43.000000000 -0600
+++ denk/include/linux/pci_ids.h	2005-10-24 10:21:44.000000000 -0600
@@ -2696,6 +2696,7 @@
 
 #define PCI_SUBVENDOR_ID_EXSYS		0xd84d
 #define PCI_SUBDEVICE_ID_EXSYS_4014	0x4014
+#define PCI_SUBDEVICE_ID_EXSYS_4055	0x4055
 
 #define PCI_VENDOR_ID_TIGERJET		0xe159
 #define PCI_DEVICE_ID_TIGERJET_300	0x0001
