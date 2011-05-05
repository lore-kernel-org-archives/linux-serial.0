From: Nicos Gollan <gtdev@spearhead.de>
Subject: [PATCH] Basic support for Moschip 9900 family I/O chips
Date: Thu,  5 May 2011 21:00:37 +0200
Message-ID: <1304622037-5317-1-git-send-email-gtdev@spearhead.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from svc.spearhead.de ([85.214.96.164]:38095 "EHLO mx.spearhead.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044Ab1EETHZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 May 2011 15:07:25 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Nicos Gollan <gtdev@spearhead.de>

Add I/O based support for serial and parallel ports of the following
chips:

Vendor: Moschip (0x9710)

Parts (device IDs)
* 9900 (0x9900)
* 9904 (0x9904
* 9901 (0x9912, also sold as 9912)
* 9922 (0x9922)

On all chips but the 9900, a single port is provided per PCI subdevice
(subvendor-ID 0xA000, subdevice-IDs 0x1000 for serial, 0x2000 for
parallel with proper class codes). In cascading configurations, the
9900 provides two devices per subdevice, with subvendor-ID 0xA000 and
subdevice-IDs 0x30ps where p is the number of parallel ports and s the
number of serial ports.

Basic testing was only done on the serial part of a 9912 to the point
where it can be used for a serial kernel console, and advanced features
are completely untested. It is possible to reduce functionality of the
chips by adding a configuration EEPROM, and the datasheet [1] is
inconsistent w.r.t subdevices in the 4s+2s1p and 2s1p+4s
configurations. The subdevice-ID 0x3012 should likely read 0x3011 with
a serial port in function 3, which would be consistent with the BAR
layouts. For now, the drivers ignore subdevices with ID 0x1000 and no
class code.

The parallel ports are integrated in parport_serial even for purely
parallel parts to reduce the footprint of the patch.

[1] http://www.moschip.com/data/products/MCS9900/MCS9900_Datasheet.pdf

Signed-off-by: Nicos Gollan <gtdev@spearhead.de>
---
 drivers/parport/parport_serial.c |   66 ++++++++++++++++++------
 drivers/tty/serial/8250_pci.c    |  104 +++++++++++++++++++++++++++++++++++++-
 include/linux/pci_ids.h          |    4 ++
 3 files changed, 157 insertions(+), 17 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index f01e264..342a3de 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -33,6 +33,9 @@ enum parport_pc_pci_cards {
 	netmos_9xx5_combo,
 	netmos_9855,
 	netmos_9855_2p,
+	netmos_9900,
+	netmos_9900_2p,
+	netmos_99xx_1p,
 	avlab_1s1p,
 	avlab_1s2p,
 	avlab_2s1p,
@@ -72,22 +75,20 @@ static int __devinit netmos_parallel_init(struct pci_dev *dev, struct parport_pc
 			dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
 			dev->subsystem_device == 0x0299)
 		return -ENODEV;
-	/*
-	 * Netmos uses the subdevice ID to indicate the number of parallel
-	 * and serial ports.  The form is 0x00PS, where <P> is the number of
-	 * parallel ports and <S> is the number of serial ports.
-	 */
-	par->numports = (dev->subsystem_device & 0xf0) >> 4;
-	if (par->numports > ARRAY_SIZE(par->addr))
-		par->numports = ARRAY_SIZE(par->addr);
-	/*
-	 * This function is currently only called for cards with up to
-	 * one parallel port.
-	 * Parallel port BAR is either before or after serial ports BARS;
-	 * hence, lo should be either 0 or equal to the number of serial ports.
-	 */
-	if (par->addr[0].lo != 0)
-		par->addr[0].lo = dev->subsystem_device & 0xf;
+
+	if (dev->device == PCI_DEVICE_ID_NETMOS_9912) {
+		par->numports = 1;
+	} else {
+		/*
+		 * Netmos uses the subdevice ID to indicate the number of parallel
+		 * and serial ports.  The form is 0x00PS, where <P> is the number of
+		 * parallel ports and <S> is the number of serial ports.
+		 */
+		par->numports = (dev->subsystem_device & 0xf0) >> 4;
+		if (par->numports > ARRAY_SIZE(par->addr))
+			par->numports = ARRAY_SIZE(par->addr);
+	}
+
 	return 0;
 }
 
@@ -97,6 +98,9 @@ static struct parport_pc_pci cards[] __devinitdata = {
 	/* netmos_9xx5_combo */		{ 1, { { 2, -1 }, }, netmos_parallel_init },
 	/* netmos_9855 */		{ 1, { { 0, -1 }, }, netmos_parallel_init },
 	/* netmos_9855_2p */		{ 2, { { 0, -1 }, { 2, -1 }, } },
+	/* netmos_9900 */		{1, { { 3, 4 }, }, netmos_parallel_init },
+	/* netmos_9900_2p */		{2, { { 0, 1 }, { 3, 4 }, } },
+	/* netmos_99xx_1p */		{1, { { 0, 1 }, } },
 	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
 	/* avlab_1s2p     */		{ 2, { { 1, 2}, { 3, 4 },} },
 	/* avlab_2s1p     */		{ 1, { { 2, 3}, } },
@@ -127,6 +131,14 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	  0x1000, 0x0022, 0, 0, netmos_9855_2p },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9855 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+	  0xA000, 0x3011, 0, 0, netmos_9900 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+	  0xA000, 0x3012, 0, 0, netmos_9900 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+	  0xA000, 0x3020, 0, 0, netmos_9900_2p },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
+	  0xA000, 0x2000, 0, 0, netmos_99xx_1p },
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ PCI_VENDOR_ID_AFAVLAB, 0x2110,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p },
@@ -219,6 +231,24 @@ static struct pciserial_board pci_parport_serial_boards[] __devinitdata = {
 		.base_baud	= 115200,
 		.uart_offset	= 8,
 	},
+	[netmos_9900] = { /* n/t */
+		.flags		= FL_BASE0 | FL_BASE_BARS,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[netmos_9900_2p] = { /* parallel only */ /* n/t */
+		.flags		= FL_BASE0,
+		.num_ports	= 0,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[netmos_99xx_1p] = { /* parallel only */ /* n/t */
+		.flags		= FL_BASE0,
+		.num_ports	= 0,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
 	[avlab_1s1p] = { /* n/t */
 		.flags		= FL_BASE0 | FL_BASE_BARS,
 		.num_ports	= 1,
@@ -285,6 +315,10 @@ static int __devinit serial_register (struct pci_dev *dev,
 	struct serial_private *serial;
 
 	board = &pci_parport_serial_boards[id->driver_data];
+
+	if (board->num_ports == 0)
+		return 0;
+
 	serial = pciserial_init_ports(dev, board);
 
 	if (IS_ERR(serial))
diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 738cec9..fddae92 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -58,6 +58,9 @@ struct serial_private {
 	int			line[0];
 };
 
+static int pci_default_setup(struct serial_private*,
+	  const struct pciserial_board*, struct uart_port*, int);
+
 static void moan_device(const char *str, struct pci_dev *dev)
 {
 	printk(KERN_WARNING
@@ -754,6 +757,62 @@ pci_ni8430_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
+static int pci_netmos_9900_setup(struct serial_private *priv,
+				const struct pciserial_board *board,
+				struct uart_port *port, int idx)
+{
+	unsigned int bar;
+
+	if ((priv->dev->subsystem_device & 0xff00) == 0x3000) {
+		/* netmos apparently orders BARs by datasheet layout, so serial
+		 * ports get BARs 0 and 3 (or 1 and 4 for memmapped)
+		 */
+		bar = 3 * idx;
+
+		return setup_port(priv, port, bar, 0, board->reg_shift);
+	} else {
+		return pci_default_setup(priv, board, port, idx);
+	}
+}
+
+/* the 99xx series comes with a range of device IDs and a variety
+ * of capabilities:
+ *
+ * 9900 has varying capabilities and can cascade to sub-controllers
+ *   (cascading should be purely internal)
+ * 9904 is hardwired with 4 serial ports
+ * 9912 and 9922 are hardwired with 2 serial ports
+ */
+static int pci_netmos_9900_numports(struct pci_dev *dev)
+{
+	unsigned int c = dev->class;
+	unsigned int pi;
+	unsigned short sub_serports;
+
+	pi = (c & 0xff);
+
+	if (pi == 2) {
+		return 1;
+	} else if ((pi == 0) &&
+			   (dev->device == PCI_DEVICE_ID_NETMOS_9900)) {
+		/* two possibilities: 0x30ps encodes number of parallel and
+		 * serial ports, or 0x1000 indicates *something*. This is not
+		 * immediately obvious, since the 2s1p+4s configuration seems
+		 * to offer all functionality on functions 0..2, while still
+		 * advertising the same function 3 as the 4s+2s1p config.
+		 */
+		sub_serports = dev->subsystem_device & 0xf;
+		if (sub_serports > 0) {
+			return sub_serports;
+		} else {
+			printk(KERN_NOTICE "NetMos/Mostech serial driver ignoring port on ambiguous config.\n");
+			return 0;
+		}
+	}
+
+	moan_device("unknown NetMos/Mostech program interface", dev);
+	return 0;
+}
 
 static int pci_netmos_init(struct pci_dev *dev)
 {
@@ -763,12 +822,28 @@ static int pci_netmos_init(struct pci_dev *dev)
 	if ((dev->device == PCI_DEVICE_ID_NETMOS_9901) ||
 		(dev->device == PCI_DEVICE_ID_NETMOS_9865))
 		return 0;
+
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
 			dev->subsystem_device == 0x0299)
 		return 0;
 
+	switch (dev->device) { /* FALLTHROUGH on all */
+		case PCI_DEVICE_ID_NETMOS_9904:
+		case PCI_DEVICE_ID_NETMOS_9912:
+		case PCI_DEVICE_ID_NETMOS_9922:
+		case PCI_DEVICE_ID_NETMOS_9900:
+			num_serial = pci_netmos_9900_numports(dev);
+			break;
+
+		default:
+			if (num_serial == 0 ) {
+				moan_device("unknown NetMos/Mostech device", dev);
+			}
+	}
+
 	if (num_serial == 0)
 		return -ENODEV;
+
 	return num_serial;
 }
 
@@ -1409,7 +1484,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_netmos_init,
-		.setup		= pci_default_setup,
+		.setup		= pci_netmos_9900_setup,
 	},
 	/*
 	 * For Oxford Semiconductor and Mainpine
@@ -1617,6 +1692,7 @@ enum pci_board_num_t {
 	pbn_ADDIDATA_PCIe_4_3906250,
 	pbn_ADDIDATA_PCIe_8_3906250,
 	pbn_ce4100_1_115200,
+	pbn_NETMOS9900_2s_115200,
 };
 
 /*
@@ -2312,6 +2388,11 @@ static struct pciserial_board pci_boards[] __devinitdata = {
 		.base_baud	= 921600,
 		.reg_shift      = 2,
 	},
+	[pbn_NETMOS9900_2s_115200] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+	},
 };
 
 static const struct pci_device_id softmodem_blacklist[] = {
@@ -3785,6 +3866,27 @@ static struct pci_device_id serial_pci_tbl[] = {
 		0xA000, 0x1000,
 		0, 0, pbn_b0_1_115200 },
 
+	/* the 9901 is a rebranded 9912 */
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9904,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+		0xA000, 0x3002,
+		0, 0, pbn_NETMOS9900_2s_115200 },
+
 	/*
 	 * Best Connectivity PCI Multi I/O cards
 	 */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 8abe8d7..41eed9a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2816,7 +2816,11 @@
 #define PCI_DEVICE_ID_NETMOS_9845	0x9845
 #define PCI_DEVICE_ID_NETMOS_9855	0x9855
 #define PCI_DEVICE_ID_NETMOS_9865	0x9865
+#define PCI_DEVICE_ID_NETMOS_9900	0x9900
 #define PCI_DEVICE_ID_NETMOS_9901	0x9901
+#define PCI_DEVICE_ID_NETMOS_9904	0x9904
+#define PCI_DEVICE_ID_NETMOS_9912	0x9912
+#define PCI_DEVICE_ID_NETMOS_9922	0x9922
 
 #define PCI_VENDOR_ID_3COM_2		0xa727
 
-- 
1.7.4.4

