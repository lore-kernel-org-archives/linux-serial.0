From: Shawn Bohrer <shawn.bohrer@ni.com>
Subject: [PATCH 1/2] 8250_pci: add support for National Instruments 843x RS232 devices
Date: Tue, 17 Feb 2009 14:20:15 -0600
Message-ID: <1234902016-22219-1-git-send-email-shawn.bohrer@ni.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailserv59-us.natinst.com ([130.164.14.243]:1553 "EHLO
	mailserv59-us.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbZBQUjc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Feb 2009 15:39:32 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Shawn Bohrer <shawn.bohrer@ni.com>

This implements basic support for all 843x RS232 devices, but does not
add DMA support.  This means that sustained data transfers at high baud
rates may not be possible on multiple ports simultaneously.

Signed-off-by: Shawn Bohrer <shawn.bohrer@ni.com>
---
 drivers/serial/8250_pci.c |  193 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h   |   14 +++
 2 files changed, 207 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 536d8e5..3918263 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -306,6 +306,36 @@ static void __devexit pci_plx9050_exit(struct pci_dev *dev)
 	}
 }
 
+/* MITE registers */
+#define MITE_IOWBSR1	0xc4
+#define MITE_IOWCR1	0xf4
+#define MITE_LCIMR1	0x08
+#define MITE_LCIMR2	0x10
+
+#define MITE_LCIMR2_CLR_CPU_IE	(1 << 30)
+
+static void __devexit pci_ni8430_exit(struct pci_dev *dev)
+{
+	void __iomem *p;
+	unsigned long base, len;
+	unsigned int bar = 0;
+
+	if ((pci_resource_flags(dev, bar) & IORESOURCE_MEM) == 0) {
+		moan_device("no memory in bar", dev);
+		return;
+	}
+
+	base = pci_resource_start(dev, bar);
+	len =  pci_resource_len(dev, bar);
+	p = ioremap_nocache(base, len);
+	if (p == NULL)
+		return;
+
+	/* Disable the CPU Interrupt */
+	writel(MITE_LCIMR2_CLR_CPU_IE, p + MITE_LCIMR2);
+	iounmap(p);
+}
+
 /* SBS Technologies Inc. PMC-OCTPRO and P-OCTAL cards */
 static int
 sbs_setup(struct serial_private *priv, const struct pciserial_board *board,
@@ -597,6 +627,82 @@ static int pci_xircom_init(struct pci_dev *dev)
 	return 0;
 }
 
+#define MITE_IOWBSR1_WSIZE	0xa
+#define MITE_IOWBSR1_WIN_OFFSET	0x800
+#define MITE_IOWBSR1_WENAB	(1 << 7)
+#define MITE_LCIMR1_IO_IE_0	(1 << 24)
+#define MITE_LCIMR2_SET_CPU_IE	(1 << 31)
+#define MITE_IOWCR1_RAMSEL_MASK	0xfffffffe
+
+static int pci_ni8430_init(struct pci_dev *dev)
+{
+	void __iomem *p;
+	unsigned long base, len;
+	u32 device_window;
+	unsigned int bar = 0;
+
+	if ((pci_resource_flags(dev, bar) & IORESOURCE_MEM) == 0) {
+		moan_device("no memory in bar", dev);
+		return 0;
+	}
+
+	base = pci_resource_start(dev, bar);
+	len =  pci_resource_len(dev, bar);
+	p = ioremap_nocache(base, len);
+	if (p == NULL)
+		return -ENOMEM;
+
+	/* Set device window address and size in BAR0 */
+	device_window = ((base + MITE_IOWBSR1_WIN_OFFSET) & 0xffffff00)
+	                | MITE_IOWBSR1_WENAB | MITE_IOWBSR1_WSIZE;
+	writel(device_window, p + MITE_IOWBSR1);
+
+	/* Set window access to go to RAMSEL IO address space */
+	writel((readl(p + MITE_IOWCR1) & MITE_IOWCR1_RAMSEL_MASK),
+	       p + MITE_IOWCR1);
+
+	/* Enable IO Bus Interrupt 0 */
+	writel(MITE_LCIMR1_IO_IE_0, p + MITE_LCIMR1);
+
+	/* Enable CPU Interrupt */
+	writel(MITE_LCIMR2_SET_CPU_IE, p + MITE_LCIMR2);
+
+	iounmap(p);
+	return 0;
+}
+
+/* UART Port Control Register */
+#define NI8430_PORTCON	0x0f
+#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
+
+static int
+pci_ni8430_setup(struct serial_private *priv, struct pciserial_board *board,
+		 struct uart_port *port, int idx)
+{
+	void __iomem *p;
+	unsigned long base, len;
+	unsigned int bar, offset = board->first_offset;
+
+	if (idx >= board->num_ports)
+		return 1;
+
+	bar = FL_GET_BASE(board->flags);
+	offset += idx * board->uart_offset;
+
+	base = pci_resource_start(priv->dev, bar);
+	len =  pci_resource_len(priv->dev, bar);
+	p = ioremap_nocache(base, len);
+
+	/* enable the transciever */
+	writeb(readb(p + offset + NI8430_PORTCON) | NI8430_PORTCON_TXVR_ENABLE,
+	       p + offset + NI8430_PORTCON);
+
+	iounmap(p);
+
+	return setup_port(priv, port, bar, offset, board->reg_shift);
+}
+
+
 static int pci_netmos_init(struct pci_dev *dev)
 {
 	/* subdevice 0x00PS means <P> parallel, <S> serial */
@@ -877,6 +983,18 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.exit		= __devexit_p(pci_ite887x_exit),
 	},
 	/*
+	 * National Instruments
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8430_setup,
+		.exit		= __devexit_p(pci_ni8430_exit),
+	},
+	/*
 	 * Panacom
 	 */
 	{
@@ -1244,6 +1362,10 @@ enum pci_board_num_t {
 	pbn_exar_XR17C154,
 	pbn_exar_XR17C158,
 	pbn_pasemi_1682M,
+	pbn_ni8430_2,
+	pbn_ni8430_4,
+	pbn_ni8430_8,
+	pbn_ni8430_16,
 };
 
 /*
@@ -1814,6 +1936,37 @@ static struct pciserial_board pci_boards[] __devinitdata = {
 		.num_ports	= 1,
 		.base_baud	= 8333333,
 	},
+	/*
+	 * National Instruments 843x
+	 */
+	[pbn_ni8430_16] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 16,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8430_8] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8430_4] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8430_2] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
 };
 
 static const struct pci_device_id softmodem_blacklist[] = {
@@ -3016,6 +3169,46 @@ static struct pci_device_id serial_pci_tbl[] = {
 		pbn_pasemi_1682M },
 
 	/*
+	 * National Instruments
+	 */
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_2322,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_2 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_2322,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_2 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_2324,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_4 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_2324,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_4 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_2328,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_8 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_2328,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_8 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_23216,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_16 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_23216,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_16 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8432_2322,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_2 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8432_2322,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_2 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8432_2324,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_4 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8432_2324,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_4 },
+
+	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
 	*/
 	{	PCI_VENDOR_ID_ADDIDATA,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 52a9fe0..6d330bd 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -941,6 +941,20 @@
 #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
 #define PCI_DEVICE_ID_SUN_CASSINI	0xabba
 
+#define PCI_VENDOR_ID_NI		0x1093
+#define PCI_DEVICE_ID_NI_PXI8430_2322	0x7080
+#define PCI_DEVICE_ID_NI_PCI8430_2322	0x70db
+#define PCI_DEVICE_ID_NI_PXI8430_2324	0x70dd
+#define PCI_DEVICE_ID_NI_PCI8430_2324	0x70df
+#define PCI_DEVICE_ID_NI_PXI8430_2328	0x70e2
+#define PCI_DEVICE_ID_NI_PCI8430_2328	0x70e4
+#define PCI_DEVICE_ID_NI_PXI8430_23216	0x70e6
+#define PCI_DEVICE_ID_NI_PCI8430_23216	0x70e7
+#define PCI_DEVICE_ID_NI_PXI8432_2322	0x70e8
+#define PCI_DEVICE_ID_NI_PCI8432_2322	0x70ea
+#define PCI_DEVICE_ID_NI_PXI8432_2324	0x70ec
+#define PCI_DEVICE_ID_NI_PCI8432_2324	0x70ee
+
 #define PCI_VENDOR_ID_CMD		0x1095
 #define PCI_DEVICE_ID_CMD_643		0x0643
 #define PCI_DEVICE_ID_CMD_646		0x0646
-- 
1.5.6.6

