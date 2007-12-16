From: catab@embedromix.ro
Subject: [PATCH] Added support for a no-name 4 ports multiserial card
Date: Sun, 16 Dec 2007 23:12:49 +0200
Message-ID: <1197839569-7488-1-git-send-email-catab@embedromix.ro>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [86.125.123.202] ([86.125.123.202]:55243 "EHLO hc.rdsbv.ro"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759051AbXLPVcV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 16 Dec 2007 16:32:21 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: "Catalin(ux) M BOIE" <catab@embedromix.ro>

From: Catalin(ux) M BOIE <catab@embedromix.ro>

It is a no-name PCI card. I have found no reference to a producer so I
used the fake name "PDR".
Full lspci:
01:07.0 0780: 10b5:9050 (rev 01)
        Subsystem: 10b5:1584
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- \
		ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- \
		DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 1: I/O ports at ec00 [size=128]
        Region 2: I/O ports at e480 [size=32]
        Region 3: I/O ports at e400 [size=8]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA \
			PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] #06 [0080]
        Capabilities: [4c] Vital Product Data

After:
0000:01:07.0: ttyS4 at I/O 0xe480 (irq = 10) is a 16550A
0000:01:07.0: ttyS5 at I/O 0xe488 (irq = 10) is a 16550A
0000:01:07.0: ttyS6 at I/O 0xe490 (irq = 10) is a 16550A
0000:01:07.0: ttyS7 at I/O 0xe498 (irq = 10) is a 16550A

Signed-off-by: Catalin(ux) M BOIE <catab@embedromix.ro>

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 6d7d616..5f3f7a1 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -703,6 +703,15 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_PLX,
+		.device		= PCI_DEVICE_ID_PLX_9050,
+		.subvendor	= PCI_VENDOR_ID_PLX,
+		.subdevice	= PCI_SUBDEVICE_ID_PDR,
+		.init		= pci_plx9050_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_plx9050_exit),
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_PLX,
 		.device		= PCI_DEVICE_ID_PLX_ROMULUS,
 		.subvendor	= PCI_VENDOR_ID_PLX,
 		.subdevice	= PCI_DEVICE_ID_PLX_ROMULUS,
@@ -973,6 +982,7 @@ enum pci_board_num_t {
 	pbn_panacom4,
 	pbn_exsys_4055,
 	pbn_plx_romulus,
+	pbn_plx_pdr,
 	pbn_oxsemi,
 	pbn_intel_i960,
 	pbn_sgi_ioc3,
@@ -1003,6 +1013,13 @@ static struct pciserial_board pci_boards[] __devinitdata = {
 		.base_baud	= 115200,
 		.uart_offset	= 8,
 	},
+	/* PDR */
+	[pbn_plx_pdr] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
 	[pbn_b0_1_115200] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
@@ -1990,6 +2007,11 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_1077,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 		pbn_b2_4_921600 },
+	/* PDR */
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+		PCI_VENDOR_ID_PLX,
+		PCI_SUBDEVICE_ID_PDR, 0, 0,
+		pbn_plx_pdr },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_KEYSPAN,
 		PCI_SUBDEVICE_ID_KEYSPAN_SX2, 0, 0,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 600308f..ab8c17f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -965,6 +965,8 @@
 #define PCI_DEVICE_ID_PLX_9080		0x9080
 #define PCI_DEVICE_ID_PLX_GTEK_SERIAL2	0xa001
 
+#define PCI_SUBDEVICE_ID_PDR		0x1584
+
 #define PCI_VENDOR_ID_MADGE		0x10b6
 #define PCI_DEVICE_ID_MADGE_MK2		0x0002
 
-- 
1.5.3.6

