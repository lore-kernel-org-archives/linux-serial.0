From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [RFT] Netmos parallel/serial/combo support
Date: Wed, 09 Mar 2005 14:09:54 -0700
Message-ID: <1110402594.28105.29.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from atlrel7.hp.com ([156.153.255.213]:39586 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261552AbVCIVKk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Mar 2005 16:10:40 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-parport@lists.infradead.org, linux-serial@vger.kernel.org
Cc: darryl@netbauds.net, rjshaw@netspace.net.au, reinelt@eunet.at, rmk+serial@arm.linux.org.uk, dh@winterwolf.co.uk, wd@denx.de, giraffe@danubian.hu

Linux support for Netmos parallel, serial, and combo (parallel/serial)
cards is currently a bit of a mess.

These devices include the following (see http://moschip.com for
more information):

    9705 Parallel Port
    9715 Dual Parallel Port
    9735 Multi-I/O Controller (2 serial and optional parallel)
    9745 Multi-I/O Controller (2 serial and optional parallel)
    9755 Parallel Port and ISA Bridge
    9805 Parallel Port
    9815 Dual Parallel Port
    9835 Multi-I/O Controller (2 serial and optional parallel)
    9845 Multi-I/O Controller (4 serial and optional parallel)
    9855 Multi-I/O Controller (4 serial and optional parallel)

Some of the combo cards (9735, 9835, and 9855) are currently claimed by
parport_pc, which makes the serial ports useless.

The combo devices seem to always have a PCI class code of
PCI_CLASS_COMMUNICATION_SERIAL, even when the optional parallel port is
present.  This causes them to be claimed by 8250_pci.c, which makes the
parallel port useless.

I propose that:

    1) Parallel-only devices be claimed by parport_pc.  This
       includes 9705, 9715, 9755, 9805, and 9815.

    2) Serial-only devices be claimed by 8250_pci.  This includes
       the variants of 9735, 9745, 9835, 9845, and 9855 that don't
       have the optional parallel port.

    3) Combo devices be claimed by parport_serial.  This includes
       9735, 9745, 9835, 9845, and 9855 devices that have the optional
       parallel port.

The following patch should accomplish this, but I have no hardware to
actually test it.  If you do have a Netmos card, please test this patch
and let me know how it works.  

You should set both CONFIG_PARPORT_SERIAL=y and CONFIG_SERIAL_8250=y.
I'm interested in a complete dmesg log and the output of "lspci -vvnx".
  
The patch is against current Linus BK, but applies to 2.6.11 with some
offsets and one reject.  These are harmless and you can ignore the reject
(it's in pci.ids, which isn't used).

===== drivers/parport/parport_pc.c 1.69 vs edited =====
--- 1.69/drivers/parport/parport_pc.c	2005-02-26 06:06:23 -07:00
+++ edited/drivers/parport/parport_pc.c	2005-03-09 13:00:58 -07:00
@@ -2889,20 +2889,14 @@
 	/* NetMos communication controllers */
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9705,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9705 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9715,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9715 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9755,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9755 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9805,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9805 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9815,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9815 },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9855 },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9735,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9755,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9755 },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9715,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9715 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);
===== drivers/parport/parport_serial.c 1.12 vs edited =====
--- 1.12/drivers/parport/parport_serial.c	2004-06-24 02:55:57 -06:00
+++ edited/drivers/parport/parport_serial.c	2005-03-09 13:00:59 -07:00
@@ -33,8 +33,11 @@
 enum parport_pc_pci_cards {
 	titan_110l = 0,
 	titan_210l,
-	netmos_9735,
-	netmos_9835,
+	netmos_9735_1p2s,
+	netmos_9745_1p2s,
+	netmos_9835_1p2s,
+	netmos_9845_1p4s,
+	netmos_9855_1p4s,
 	avlab_1s1p,
 	avlab_1s1p_650,
 	avlab_1s1p_850,
@@ -73,8 +76,11 @@
 } cards[] __devinitdata = {
 	/* titan_110l */		{ 1, { { 3, -1 }, } },
 	/* titan_210l */		{ 1, { { 3, -1 }, } },
-	/* netmos_9735 (not tested) */	{ 1, { { 2, -1 }, } },
-	/* netmos_9835 */		{ 1, { { 2, -1 }, } },
+	/* netmos_9735_1p2s */		{ 1, { { 2, -1 }, } },
+	/* netmos_9745_1p2s */		{ 1, { { 2, -1 }, } },
+	/* netmos_9835_1p2s */		{ 1, { { 2, -1 }, } },
+	/* netmos_9845_1p4s */		{ 1, { { 4, -1 }, } },
+	/* netmos_9855_1p4s */		{ 1, { { 4, -1 }, } },
 	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_650 */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_850 */		{ 1, { { 1, 2}, } },
@@ -98,9 +104,15 @@
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9735,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
+	  PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9735_1P2S, 0, 0, netmos_9735_1p2s },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9745,
+	  PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9745_1P2S, 0, 0, netmos_9745_1p2s },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
+	  PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9835_1P2S, 0, 0, netmos_9835_1p2s },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9845,
+	  PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9845_1P4S, 0, 0, netmos_9845_1p4s },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
+	  PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9855_1P4S, 0, 0, netmos_9855_1p4s },
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
 	{ 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
@@ -180,8 +192,11 @@
 
 /* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
 /* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
-/* netmos_9735 (n/t)*/	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
-/* netmos_9835 */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* netmos_9735_1p2s */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* netmos_9745_1p2s */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* netmos_9835_1p2s */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* netmos_9845_1p4s */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 115200 },
+/* netmos_9855_1p4s */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 115200 },
 /* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
===== drivers/pci/pci.ids 1.73 vs edited =====
--- 1.73/drivers/pci/pci.ids	2005-02-16 20:05:44 -07:00
+++ edited/drivers/pci/pci.ids	2005-03-09 13:28:43 -07:00
@@ -9567,16 +9567,28 @@
 	6565  6565
 9710  NetMos Technology
 	7780  USB IRDA-port
-	9815  PCI 9815 Multi-I/O Controller
+	9705  PCI 9705 Parallel Port
+	9715  PCI 9715 Dual Parallel Port
+	9735  PCI 9735 Multi-I/O Controller
+		1000 0002  0P2S (2 serial)
+		1000 0012  1P2S (1 parallel + 2 serial)
+	9745  PCI 9745 Multi-I/O Controller
+		1000 0002  0P2S (2 serial)
+		1000 0012  1P2S (1 parallel + 2 serial)
+	9755  PCI 9755 Parallel Port and ISA Bridge
+	9805  PCI 9805 Parallel Port
+	9815  PCI 9815 Dual Parallel Port
 		1000 0020  2P0S (2 port parallel adaptor)
 	9835  PCI 9835 Multi-I/O Controller
-		1000 0002  2S (16C550 UART)
+		1000 0002  0P2S (16C550 UART)
 		1000 0012  1P2S
 	9845  PCI 9845 Multi-I/O Controller
 		1000 0004  0P4S (4 port 16550A serial card)
-		1000 0006  0P6S (6 port 16550a serial card)
+		1000 0006  0P6S (6 port 16550A serial card)
+		1000 0014  1P4S (4 port 16550A serial card + parallel)
 	9855  PCI 9855 Multi-I/O Controller
-		1000 0014  1P4S
+		1000 0004  0P4S (4 serial)
+		1000 0014  1P4S (1 parallel + 4 serial)
 9902  Stargen Inc.
 	0001  SG2010 PCI over Starfabric Bridge
 	0002  SG2010 PCI to Starfabric Gateway
===== drivers/pci/quirks.c 1.71 vs edited =====
--- 1.71/drivers/pci/quirks.c	2005-02-14 12:10:24 -07:00
+++ edited/drivers/pci/quirks.c	2005-03-09 13:00:59 -07:00
@@ -1254,6 +1254,35 @@
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch );
 
+static void __devinit quirk_netmos(struct pci_dev *dev)
+{
+	/*
+	 * These Netmos parts are multiport serial devices with optional
+	 * parallel ports.  Even when parallel ports are present, they
+	 * are identified as class SERIAL, which means the serial driver
+	 * will claim them.  To prevent this, mark them as class OTHER.
+	 * These combo devices should be claimed by parport_serial.
+	 *
+	 * The subdevice ID is of the form 0x00PS, where <P> is the number
+	 * of parallel ports and <S> is the number of serial ports.
+	 */
+	switch (dev->device) {
+	case PCI_DEVICE_ID_NETMOS_9735:
+	case PCI_DEVICE_ID_NETMOS_9745:
+	case PCI_DEVICE_ID_NETMOS_9835:
+	case PCI_DEVICE_ID_NETMOS_9845:
+	case PCI_DEVICE_ID_NETMOS_9855:
+		if ((dev->class >> 8) == PCI_CLASS_COMMUNICATION_SERIAL &&
+		    dev->subsystem_device & 0xf0) {
+			printk(KERN_INFO "PCI: Netmos %04x with parallel at %s, use parport_serial\n",
+				dev->device, pci_name(dev));
+			dev->class = (PCI_CLASS_COMMUNICATION_OTHER << 8) |
+			    (dev->class & 0xff);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETMOS, PCI_ANY_ID, quirk_netmos);
+
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {
 	while (f < end) {
===== drivers/serial/8250_pci.c 1.51 vs edited =====
--- 1.51/drivers/serial/8250_pci.c	2005-03-08 15:08:47 -07:00
+++ edited/drivers/serial/8250_pci.c	2005-03-09 13:28:08 -07:00
@@ -2222,6 +2222,27 @@
 		0, pbn_exar_XR17C158 },
 
 	/*
+	 * Netmos Dual/Quad UARTs (Wolfgang Denk <wd@denx.de>).
+	 * These could be matched by default entries, but they
+	 * have extra BARs that we shouldn't poke at.
+	 */
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9735,
+		PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9735_0P2S, 0, 0,
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9745,
+		PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9745_0P2S, 0, 0,
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+		PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9835_0P2S, 0, 0,
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9845,
+		PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9845_0P4S, 0, 0,
+		pbn_b0_4_115200 },
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
+		PCI_ANY_ID, PCI_SUBDEVICE_ID_NETMOS_9855_0P4S, 0, 0,
+		pbn_b0_4_115200 },
+
+	/*
 	 * Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke)
 	 */
 	{	PCI_VENDOR_ID_TOPIC, PCI_DEVICE_ID_TOPIC_TP560,
===== include/linux/pci_ids.h 1.201 vs edited =====
--- 1.201/include/linux/pci_ids.h	2005-03-08 17:26:50 -07:00
+++ edited/include/linux/pci_ids.h	2005-03-09 13:29:03 -07:00
@@ -2436,13 +2436,25 @@
 
 #define PCI_VENDOR_ID_NETMOS		0x9710
 #define PCI_DEVICE_ID_NETMOS_9705	0x9705
+#define PCI_DEVICE_ID_NETMOS_9715	0x9715
 #define PCI_DEVICE_ID_NETMOS_9735	0x9735
+#define PCI_SUBDEVICE_ID_NETMOS_9735_0P2S	0x0002 /* 0 parallel 2 serial */
+#define PCI_SUBDEVICE_ID_NETMOS_9735_1P2S	0x0012 /* 1 parallel 2 serial */
+#define PCI_DEVICE_ID_NETMOS_9745	0x9745
+#define PCI_SUBDEVICE_ID_NETMOS_9745_0P2S	0x0002 /* 0 parallel 2 serial */
+#define PCI_SUBDEVICE_ID_NETMOS_9745_1P2S	0x0012 /* 1 parallel 2 serial */
+#define PCI_DEVICE_ID_NETMOS_9755	0x9755
 #define PCI_DEVICE_ID_NETMOS_9805	0x9805
 #define PCI_DEVICE_ID_NETMOS_9815	0x9815
 #define PCI_DEVICE_ID_NETMOS_9835	0x9835
+#define PCI_SUBDEVICE_ID_NETMOS_9835_0P2S	0x0002 /* 0 parallel 2 serial */
+#define PCI_SUBDEVICE_ID_NETMOS_9835_1P2S	0x0012 /* 1 parallel 2 serial */
+#define PCI_DEVICE_ID_NETMOS_9845	0x9845
+#define PCI_SUBDEVICE_ID_NETMOS_9845_0P4S	0x0004 /* 0 parallel 4 serial */
+#define PCI_SUBDEVICE_ID_NETMOS_9845_1P4S	0x0014 /* 1 parallel 4 serial */
 #define PCI_DEVICE_ID_NETMOS_9855	0x9855
-#define PCI_DEVICE_ID_NETMOS_9755	0x9755
-#define PCI_DEVICE_ID_NETMOS_9715	0x9715
+#define PCI_SUBDEVICE_ID_NETMOS_9855_0P4S	0x0004 /* 0 parallel 4 serial */
+#define PCI_SUBDEVICE_ID_NETMOS_9855_1P4S	0x0014 /* 1 parallel 4 serial */
 
 #define PCI_SUBVENDOR_ID_EXSYS		0xd84d
 #define PCI_SUBDEVICE_ID_EXSYS_4014	0x4014



