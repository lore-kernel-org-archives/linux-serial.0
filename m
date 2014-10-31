From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 1/2] serial: 8250_pci: Handle devices mapped above 4 GiB
Date: Thu, 30 Oct 2014 19:49:45 -0500 (CDT)
Message-ID: <1427602154.136535.1414716585730.JavaMail.zimbra@xes-inc.com>
References: <742976830.136534.1414716563422.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:58230 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161571AbaJaBuv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Oct 2014 21:50:51 -0400
In-Reply-To: <742976830.136534.1414716563422.JavaMail.zimbra@xes-inc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Several init/setup functions passed the PCI BAR resource start address
to ioremap_nocache() via an unsigned long. This caused address truncation
for a 32-bit device mapped above 4 GiB (i.e. the CPU interacts with the
device via a translated address), which resulted in a kernel panic.

This patch replaces all of the instances of intermediate variable use
with pci_ioremap_bar() to ensure the full resource_size_t start address
is used and that ioremap_nocache() is still called.

The kernel panic (Exar XR17V358 PCIe device on a Freescale P2020 SBC):

Machine check in kernel mode.
Caused by (from MCSR=10008): Bus - Read Data Bus Error
Oops: Machine check, sig: 7 [#1]
SMP NR_CPUS=2 X-ES P2020
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.14.15-xes_r2-00002-g560e401 #978
task: bf850000 ti: bffee000 task.ti: bf84c000
NIP: 80318e10 LR: 80319ecc CTR: 80318dfc
REGS: bffeff10 TRAP: 0204   Not tainted  (3.14.15-xes_r2-00002-g560e401)
MSR: 00021000 <CE,ME>  CR: 20adbe42  XER: 00000000
DEAR: c1058001 ESR: 00000000
GPR00: 00000000 bf84db30 bf850000 80cb4af8 00000001 00000000 80000007 80000000
GPR08: bf837c9c c1058001 00000001 00000000 80000007 00000000 80002a10 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 80cb0000 80c72dc4
GPR24: 80cb4900 fffffffe 00029000 00000001 bf8c11e8 ffffffea 80c72ce4 80cb4af8
NIP [80318e10] mem_serial_in+0x14/0x28
LR [80319ecc] serial8250_config_port+0x160/0xe38
Call Trace:
[bf84db30] [80319d94] serial8250_config_port+0x28/0xe38 (unreliable)
[bf84db60] [80315e3c] uart_add_one_port+0x148/0x3a4
[bf84dbf0] [8031bf40] serial8250_register_8250_port+0x2dc/0x3c8
[bf84dc20] [8032111c] pciserial_init_ports+0xd4/0x1c0
[bf84dd50] [803212f8] pciserial_init_one+0xf0/0x224
[bf84dd90] [802d8ff4] local_pci_probe+0x34/0x8c
[bf84dda0] [802d92c8] pci_device_probe+0x84/0xa0
[bf84ddc0] [80329ee0] driver_probe_device+0xac/0x26c
[bf84dde0] [8032a15c] __driver_attach+0xbc/0xc0
[bf84de00] [80328388] bus_for_each_dev+0x90/0xcc
[bf84de30] [80329cd0] driver_attach+0x24/0x34
[bf84de40] [80328e28] bus_add_driver+0x104/0x1fc
[bf84de60] [8032a8c8] driver_register+0x70/0x138
[bf84de70] [802d93c0] __pci_register_driver+0x48/0x58
[bf84de80] [8077e0e4] serial_pci_driver_init+0x24/0x34
[bf84de90] [80002228] do_one_initcall+0x34/0x1b0
[bf84df00] [80764294] kernel_init_freeable+0x138/0x1e8
[bf84df30] [80002a24] kernel_init+0x14/0x108
[bf84df40] [8000ef94] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
800800c4 7d290214 39290001 7c0004ac 7ca049ae 7c0004ac 4e800020 88030035
81230008 7c840030 7d292214 7c0004ac <88690000> 0c030000 4c00012c 5463063e
---[ end trace e3c16443b5d573c6 ]---

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/tty/serial/8250/8250_pci.c | 47 ++++++++++++++------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index beb9d71..2e8d8a4 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -79,29 +79,24 @@ setup_port(struct serial_private *priv, struct uart_8250_port *port,
 	   int bar, int offset, int regshift)
 {
 	struct pci_dev *dev = priv->dev;
-	unsigned long base, len;
 
 	if (bar >= PCI_NUM_BAR_RESOURCES)
 		return -EINVAL;
 
-	base = pci_resource_start(dev, bar);
-
 	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
-		len =  pci_resource_len(dev, bar);
-
 		if (!priv->remapped_bar[bar])
-			priv->remapped_bar[bar] = ioremap_nocache(base, len);
+			priv->remapped_bar[bar] = pci_ioremap_bar(dev, bar);
 		if (!priv->remapped_bar[bar])
 			return -ENOMEM;
 
 		port->port.iotype = UPIO_MEM;
 		port->port.iobase = 0;
-		port->port.mapbase = base + offset;
+		port->port.mapbase = pci_resource_start(dev, bar) + offset;
 		port->port.membase = priv->remapped_bar[bar] + offset;
 		port->port.regshift = regshift;
 	} else {
 		port->port.iotype = UPIO_PORT;
-		port->port.iobase = base + offset;
+		port->port.iobase = pci_resource_start(dev, bar) + offset;
 		port->port.mapbase = 0;
 		port->port.membase = NULL;
 		port->port.regshift = 0;
@@ -317,7 +312,6 @@ static void pci_plx9050_exit(struct pci_dev *dev)
 static void pci_ni8420_exit(struct pci_dev *dev)
 {
 	void __iomem *p;
-	unsigned long base, len;
 	unsigned int bar = 0;
 
 	if ((pci_resource_flags(dev, bar) & IORESOURCE_MEM) == 0) {
@@ -325,9 +319,7 @@ static void pci_ni8420_exit(struct pci_dev *dev)
 		return;
 	}
 
-	base = pci_resource_start(dev, bar);
-	len =  pci_resource_len(dev, bar);
-	p = ioremap_nocache(base, len);
+	p = pci_ioremap_bar(dev, bar);
 	if (p == NULL)
 		return;
 
@@ -349,7 +341,6 @@ static void pci_ni8420_exit(struct pci_dev *dev)
 static void pci_ni8430_exit(struct pci_dev *dev)
 {
 	void __iomem *p;
-	unsigned long base, len;
 	unsigned int bar = 0;
 
 	if ((pci_resource_flags(dev, bar) & IORESOURCE_MEM) == 0) {
@@ -357,9 +348,7 @@ static void pci_ni8430_exit(struct pci_dev *dev)
 		return;
 	}
 
-	base = pci_resource_start(dev, bar);
-	len =  pci_resource_len(dev, bar);
-	p = ioremap_nocache(base, len);
+	p = pci_ioremap_bar(dev, bar);
 	if (p == NULL)
 		return;
 
@@ -682,7 +671,6 @@ static int pci_xircom_init(struct pci_dev *dev)
 static int pci_ni8420_init(struct pci_dev *dev)
 {
 	void __iomem *p;
-	unsigned long base, len;
 	unsigned int bar = 0;
 
 	if ((pci_resource_flags(dev, bar) & IORESOURCE_MEM) == 0) {
@@ -690,9 +678,7 @@ static int pci_ni8420_init(struct pci_dev *dev)
 		return 0;
 	}
 
-	base = pci_resource_start(dev, bar);
-	len =  pci_resource_len(dev, bar);
-	p = ioremap_nocache(base, len);
+	p = pci_ioremap_bar(dev, bar);
 	if (p == NULL)
 		return -ENOMEM;
 
@@ -714,7 +700,7 @@ static int pci_ni8420_init(struct pci_dev *dev)
 static int pci_ni8430_init(struct pci_dev *dev)
 {
 	void __iomem *p;
-	unsigned long base, len;
+	struct pci_bus_region region;
 	u32 device_window;
 	unsigned int bar = 0;
 
@@ -723,14 +709,17 @@ static int pci_ni8430_init(struct pci_dev *dev)
 		return 0;
 	}
 
-	base = pci_resource_start(dev, bar);
-	len =  pci_resource_len(dev, bar);
-	p = ioremap_nocache(base, len);
+	p = pci_ioremap_bar(dev, bar);
 	if (p == NULL)
 		return -ENOMEM;
 
-	/* Set device window address and size in BAR0 */
-	device_window = ((base + MITE_IOWBSR1_WIN_OFFSET) & 0xffffff00)
+	/*
+	 * Set device window address and size in BAR0, while acknowledging that
+	 * the resource structure may contain a translated address that differs
+	 * from the address the device responds to.
+	 */
+	pcibios_resource_to_bus(dev->bus, &region, &dev->resource[bar]);
+	device_window = ((region.start + MITE_IOWBSR1_WIN_OFFSET) & 0xffffff00)
 	                | MITE_IOWBSR1_WENAB | MITE_IOWBSR1_WSIZE;
 	writel(device_window, p + MITE_IOWBSR1);
 
@@ -757,8 +746,8 @@ pci_ni8430_setup(struct serial_private *priv,
 		 const struct pciserial_board *board,
 		 struct uart_8250_port *port, int idx)
 {
+	struct pci_dev *dev = priv->dev;
 	void __iomem *p;
-	unsigned long base, len;
 	unsigned int bar, offset = board->first_offset;
 
 	if (idx >= board->num_ports)
@@ -767,9 +756,7 @@ pci_ni8430_setup(struct serial_private *priv,
 	bar = FL_GET_BASE(board->flags);
 	offset += idx * board->uart_offset;
 
-	base = pci_resource_start(priv->dev, bar);
-	len =  pci_resource_len(priv->dev, bar);
-	p = ioremap_nocache(base, len);
+	p = pci_ioremap_bar(dev, bar);
 
 	/* enable the transceiver */
 	writeb(readb(p + offset + NI8430_PORTCON) | NI8430_PORTCON_TXVR_ENABLE,
-- 
1.9.1
