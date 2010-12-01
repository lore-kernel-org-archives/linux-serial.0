From: Matthias Reichl <hias@horus.com>
Subject: OXuPCI952 and baud_base questions
Date: Wed, 1 Dec 2010 17:46:34 +0100
Message-ID: <20101201164634.GA5773@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailbackup.inode.at ([213.229.60.24]:59775 "EHLO
	mailbackup.inode.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab0LAQrk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Dec 2010 11:47:40 -0500
Received: from [62.99.145.4] (port=37201 helo=mx.inode.at)
	by mailbackup.inode.at with esmtp (Exim 4.67)
	(envelope-from <hias@hias.horus.com>)
	id 1PNpqF-00018s-IN
	for linux-serial@vger.kernel.org; Wed, 01 Dec 2010 17:47:39 +0100
Received: from [85.127.54.55] (port=7438 helo=camel2.hias.horus.com)
	by smartmx-04.inode.at with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <hias@hias.horus.com>)
	id 1PNppF-0006ep-8z
	for linux-serial@vger.kernel.org; Wed, 01 Dec 2010 17:46:37 +0100
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Kernel <linux-serial@vger.kernel.org>

I've got a Lindy 51237 multi I/O card (2 16C950 URATs up to 921kbit
plus one parallel port) with a Oxford OXuPCI952 chip (PCI vendor
ID 0x1415, device ID 0x9505).

http://www.lindy-international.com/2-port-rs-232-serial-1-port-parallel-card-pci/51237.html
http://www.plxtech.com/products/uart/oxupci952

Kernel 2.6.36.1 doesn't contain any device-specific configuration,
the "guess code" detects both UARTs at BAR0 and BAR1,
but with the wrong baudrate (default of 115200 instead of
921600 needed for this card).

The card doesn't report any specific (sub-) vendor/device IDs but
the generic Oxford IDs. So adding an entry to the pci_device_id
table with a pbn_b0_bt_2_921600 config might break some prior
working setups (OXuPCI952 with baud_base=115200).

Do you have any policy how to cope with such situations?

so long,

Hias

lspic -vvvn output:

05:00.0 0700: 1415:9505 (rev 01) (prog-if 06 [16950])
	Subsystem: 1415:0000
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at d000 [size=8]
	Region 1: I/O ports at d100 [size=8]
	Region 2: I/O ports at d200 [size=8]
	Region 3: I/O ports at d300 [size=8]
	Region 4: I/O ports at d400 [size=32]
	Region 5: Memory at ea100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: serial

05:00.1 0701: 1415:9513 (rev 01) (prog-if 01 [BiDir])
	Subsystem: 1415:0000
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at d500 [size=8]
	Region 1: I/O ports at d600 [size=8]
	Region 2: I/O ports at d700 [size=32]
	Region 3: Memory at ea101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: parport_pc
	Kernel modules: parport_pc

possible patch against 2.6.36.1:

--- linux-2.6.36.1-orig/drivers/serial/8250_pci.c	2010-10-20 22:30:22.000000000 +0200
+++ linux-2.6.36.1/drivers/serial/8250_pci.c	2010-12-01 16:52:28.000000000 +0100
@@ -995,6 +995,7 @@
 #define PCI_DEVICE_ID_TITAN_200EI	0xA016
 #define PCI_DEVICE_ID_TITAN_200EISI	0xA017
 #define PCI_DEVICE_ID_OXSEMI_16PCI958	0x9538
+#define PCI_DEVICE_ID_OXSEMI_UPCI952	0x9505
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -3762,6 +3763,13 @@
 		0, 0, pbn_b0_bt_4_115200 },
 
 	/*
+	 * Lindy 51237 PCI Multi I/O card using OXuPCI952
+	 */
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_UPCI952,
+		PCI_ANY_ID , PCI_ANY_ID,
+		0, 0, pbn_b0_bt_2_921600 },
+
+	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
 	 */
