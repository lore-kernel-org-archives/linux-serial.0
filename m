From: Guenter Gebhardt <g.gebhardt@meilhaus.de>
Subject: [PATCH] Meilhaus Serial PCI Boards
Date: Mon, 12 Jul 2004 15:59:10 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200407121559.10900.g.gebhardt@meilhaus.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.meilhaus.com ([195.30.252.147]:52614 "EHLO
	mail.meilhaus.com") by vger.kernel.org with ESMTP id S266839AbUGLN7f
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Jul 2004 09:59:35 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk

Hello,

This patch adds support for the Meilhaus Serial PCI Boards ME-9000, ME9100, 
ME-9300 to the file 8250_pci.c. I tested this patch with kernel 2.6.7. All 
supported and available boards were tested at Meilhaus Electronic GmbH. 
Everything seems to be OK.

One additional Question arises when I worked on this patch:
Meilhaus has a further serial board ME-9200 with the NetMos Nm9835 chip which 
provides two serial ports and one parallel port.

I found out that support for this chip was added in the parport_serial.c code 
in the 2.4 kernels. Then it was removed with the hint that "Remove NetMos 
support, since it causes problems for some people", which People and why?

Then a patch was sent to the kernel mailing list for 2.5 Kernels 
(ftp://people.redhat.com/twaugh/patches/linux25/linux-netmos.patch) but never 
got applied.

Does someone know what's going on with this Chip?

Thanks in advance,

Gebhardt

>>>>> Patch for support of Meilhaus serial PCI boards
--- linux-2.6.7.orig/drivers/serial/8250_pci.c	2004-06-16 07:19:44.000000000 
+0200
+++ linux/drivers/serial/8250_pci.c	2004-07-09 16:49:22.000000000 +0200
@@ -133,6 +133,65 @@
 }
 
 /*
+ * Meilhaus Electronic GmbH.
+ * The ME9100 and ME9300 boards use the PLX PCI chip, which requires
+ * the interrupts to be enabled on the chip before we can use it.
+ * In addition the ME9100 boards with 8 ports use a mixture of
+ * PCI bar and register offsets.
+ */
+static int __devinit pci_me9x00_init(struct pci_dev *dev)
+{
+	u32 irq_config;
+	u32 plx_base = pci_resource_start(dev, 1);
+
+	if(!plx_base)
+		return -ENODEV;
+
+	if((dev->device == 0x9108) || (dev->device == 0x9158) || (dev->device == 
0x930B))
+		irq_config = 0x5B;
+	else if((dev->device == 0x9104) || (dev->device == 0x9154))
+		irq_config = 0x43;
+	else
+		return -ENODEV;
+
+	/*
+	 * Enable interrupts
+	 */
+	outl(irq_config, plx_base + 0x4C);
+	return 0;
+}
+
+static int
+pci_me9x00_setup(struct pci_dev *dev, struct pci_board *board,
+		  struct serial_struct *req, int idx)
+{
+	unsigned int bar, offset = board->first_offset;
+
+	bar = FL_GET_BASE(board->flags);
+	if(idx >= 4) {
+		bar++;
+		offset += (idx - 4) * board->uart_offset;
+	} else
+		offset += idx * board->uart_offset;
+
+	return setup_port(dev, req, bar, offset, board->reg_shift);
+}
+
+static void __devexit pci_me9x00_exit(struct pci_dev *dev)
+{
+	u32 plx_base = pci_resource_start(dev, 1);
+
+	if(!plx_base)
+		return;
+
+	/*
+	 * Disable interrupts
+	 */
+	outl(0x0, plx_base + 0x4C);
+	return;
+}
+
+/*
  * AFAVLAB uses a different mixture of BARs and offsets
  * Not that ugly ;) -- HW
  */
@@ -461,6 +520,81 @@
 EXPORT_SYMBOL(pci_siig20x_fn);
 
 /*
+ * Meilhaus Electronic GmbH.
+ * ME9000 series has an explosion of boards, and to avoid the PCI table from
+ * growing *huge*, we use this function to collapse the 88 entries
+ * in the PCI table into one, for sanity's and compactness's sake.
+ */
+static unsigned short me9000_one_port[] = {
+	0x9000, 0x9001,
+	0x9080, 0x9081, 0
+};
+
+static unsigned short me9000_two_port[] = {
+	0x9090, 0x9091, 0x9092,
+	0x9010, 0x9011, 0x9012, 0
+};
+
+static unsigned short me9000_three_port[] = {
+	0x9020, 0x9021, 0x9022, 0x9023,
+       	0x90A0, 0x90A1, 0x90A2, 0x90A3, 0
+};
+
+static unsigned short me9000_four_port[] = {
+	0x9030, 0x9031, 0x9032, 0x9033, 0x9034,
+	0x90B0, 0x90B1, 0x90B2, 0x90B3, 0x90B4, 0
+};
+
+static unsigned short me9000_five_port[] = {
+	0x9040, 0x9041, 0x9042, 0x9043, 0x9044, 0x9045,
+	0x90C0, 0x90C1, 0x90C2, 0x90C3, 0x90C4, 0x90C5, 0
+};
+
+static unsigned short me9000_six_port[] = {
+	0x9050, 0x9051, 0x9052, 0x9053, 0x9054, 0x9055, 0x9056,
+	0x90D0, 0x90D1, 0x90D2, 0x90D3, 0x90D4, 0x90D5, 0x90D6, 0
+};
+
+static unsigned short me9000_seven_port[] = {
+	0x9060, 0x9061, 0x9062, 0x9063, 0x9064, 0x9065, 0x9066, 0x9067,
+	0x90E0, 0x90E1, 0x90E2, 0x90E3, 0x90E4, 0x90E5, 0x90E6, 0x90E7, 0
+};
+
+static unsigned short me9000_eight_port[] = {
+	0x9070, 0x9071, 0x9072, 0x9073, 0x9074, 0x9075, 0x9076, 0x9077, 0x9078,
+	0x90F0, 0x90F1, 0x90F2, 0x90F3, 0x90F4, 0x90F5, 0x90F6, 0x90F7, 0x90F8, 0
+};
+
+static struct me9000_struct {
+	int num;
+	unsigned short *ids;
+} me9000_data[] = {
+	{ 1, me9000_one_port },
+	{ 2, me9000_two_port },
+	{ 3, me9000_three_port },
+	{ 4, me9000_four_port },
+	{ 5, me9000_five_port },
+	{ 6, me9000_six_port },
+	{ 7, me9000_seven_port },
+	{ 8, me9000_eight_port },
+	{ 0, 0 }
+};
+
+static int __devinit pci_me9000_init(struct pci_dev *dev)
+{
+	unsigned short *ids;
+	int i, j;
+
+	for (i = 0; me9000_data[i].num; i++) {
+		ids = me9000_data[i].ids;
+		for (j = 0; ids[j]; j++)
+			if (dev->device == ids[j])
+				return me9000_data[i].num;
+	}
+	return 0;
+}
+
+/*
  * Timedia has an explosion of boards, and to avoid the PCI table from
  * growing *huge*, we use this function to collapse some 70 entries
  * in the PCI table into one, for sanity's and compactness's sake.
@@ -601,6 +735,7 @@
 }
 
 /* This should be in linux/pci_ids.h */
+#define PCI_VENDOR_ID_MEILHAUS		0x1402
 #define PCI_VENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_DEVICE_ID_OCTPRO		0x0001
@@ -619,6 +754,71 @@
  */
 static struct pci_serial_quirk pci_serial_quirks[] = {
 	/*
+	 * Meilhaus Electronic GmbH ME9100 series boards
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x9108,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_me9x00_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x9104,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x9158,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_me9x00_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x9154,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	/*
+	 * Meilhaus Electronic GmbH ME9300 board
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x930B,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	/*
+	 * Meilhaus Electronic GmbH ME9000 series boards are
+	 * catched with this entry.
+	 * The init function detects the number of ports
+	 * available for the specific board.
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9000_init,
+		.setup		= pci_default_setup,
+	},
+	/*
 	 * AFAVLAB cards.
 	 *  It is not clear whether this applies to all products.
 	 */
@@ -1057,6 +1257,8 @@
 	/*
 	 * Board-specific versions.
 	 */
+	pbn_me9000,
+	pbn_me9300_16,
 	pbn_panacom,
 	pbn_panacom2,
 	pbn_panacom4,
@@ -1378,6 +1580,20 @@
 	 */
 
 	/*
+	 * Meilhaus Electronic GmbH
+	 */
+	[pbn_me9000] = {
+		.flags		= FL_BASE0,
+		.base_baud	= 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_me9300_16] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 16,
+		.base_baud	= 921600,
+		.uart_offset	= 0x8,
+	},
+	/*
 	 * Panacom - IOMEM
 	 */
 	[pbn_panacom] = {
@@ -1759,6 +1975,30 @@
 }
 
 static struct pci_device_id serial_pci_tbl[] = {
+	/* Meilhaus ME-9300 board */
+	{	PCI_VENDOR_ID_MEILHAUS, 0x930B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_me9300_16 },
+
+	/* Meilhaus ME-9100 boards */
+	{	PCI_VENDOR_ID_MEILHAUS, 0x9108,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	   	pbn_b2_8_921600 },
+	{	PCI_VENDOR_ID_MEILHAUS, 0x9104,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_4_921600 },
+	{	PCI_VENDOR_ID_MEILHAUS, 0x9158,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_8_921600 },
+	{	PCI_VENDOR_ID_MEILHAUS, 0x9154,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_4_921600 },
+
+	/* Meilhaus ME-9000 boards */
+	{	PCI_VENDOR_ID_MEILHAUS, PCI_ANY_ID,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_me9000 },
+
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
