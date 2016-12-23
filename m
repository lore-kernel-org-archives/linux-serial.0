From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: 8250: use initializer instead of memset to clear
 local struct
Date: Fri, 23 Dec 2016 12:21:48 +0900
Message-ID: <1482463308-28968-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, Joachim Eastwood <manabian@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Leave the way of zero-out to the compiler's decision; the compiler
may know a more optimized way than calling memset().

It may end up with memset() for big structures like this after all,
but the code will be cleaner at least.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_acorn.c    |  3 +--
 drivers/tty/serial/8250/8250_core.c     |  4 +---
 drivers/tty/serial/8250/8250_em.c       |  3 +--
 drivers/tty/serial/8250/8250_gsc.c      |  3 +--
 drivers/tty/serial/8250/8250_hp300.c    | 11 +++--------
 drivers/tty/serial/8250/8250_lpc18xx.c  |  4 +---
 drivers/tty/serial/8250/8250_lpss.c     |  4 +---
 drivers/tty/serial/8250/8250_mid.c      |  4 +---
 drivers/tty/serial/8250/8250_moxa.c     |  4 +---
 drivers/tty/serial/8250/8250_of.c       |  4 ++--
 drivers/tty/serial/8250/8250_omap.c     |  3 +--
 drivers/tty/serial/8250/8250_pci.c      |  3 +--
 drivers/tty/serial/8250/8250_pnp.c      |  3 +--
 drivers/tty/serial/8250/8250_uniphier.c |  4 +---
 drivers/tty/serial/8250/serial_cs.c     |  3 +--
 15 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
index 402dfdd..f49acafc 100644
--- a/drivers/tty/serial/8250/8250_acorn.c
+++ b/drivers/tty/serial/8250/8250_acorn.c
@@ -43,7 +43,7 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
 {
 	struct serial_card_info *info;
 	struct serial_card_type *type = id->data;
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	unsigned long bus_addr;
 	unsigned int i;
 
@@ -62,7 +62,6 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
 
 	ecard_set_drvdata(ec, info);
 
-	memset(&uart, 0, sizeof(struct uart_8250_port));
 	uart.port.irq	= ec->irq;
 	uart.port.flags	= UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
 	uart.port.uartclk	= type->uartclk;
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 61569a7..27c18c9 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -804,11 +804,9 @@ EXPORT_SYMBOL(serial8250_resume_port);
 static int serial8250_probe(struct platform_device *dev)
 {
 	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	int ret, i, irqflag = 0;
 
-	memset(&uart, 0, sizeof(uart));
-
 	if (share_irqs)
 		irqflag = IRQF_SHARED;
 
diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 0b63812..5deabaf 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -92,7 +92,7 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct serial8250_em_priv *priv;
-	struct uart_8250_port up;
+	struct uart_8250_port up = {};
 	int ret;
 
 	if (!regs || !irq) {
@@ -110,7 +110,6 @@ static int serial8250_em_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->sclk);
 	}
 
-	memset(&up, 0, sizeof(up));
 	up.port.mapbase = regs->start;
 	up.port.irq = irq->start;
 	up.port.type = PORT_UNKNOWN;
diff --git a/drivers/tty/serial/8250/8250_gsc.c b/drivers/tty/serial/8250/8250_gsc.c
index b1e6ae9..5366e97 100644
--- a/drivers/tty/serial/8250/8250_gsc.c
+++ b/drivers/tty/serial/8250/8250_gsc.c
@@ -26,7 +26,7 @@
 
 static int __init serial_init_chip(struct parisc_device *dev)
 {
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	unsigned long address;
 	int err;
 
@@ -53,7 +53,6 @@ static int __init serial_init_chip(struct parisc_device *dev)
 	if (dev->id.sversion != 0x8d)
 		address += 0x800;
 
-	memset(&uart, 0, sizeof(uart));
 	uart.port.iotype	= UPIO_MEM;
 	/* 7.272727MHz on Lasi.  Assumed the same for Dino, Wax and Timi. */
 	uart.port.uartclk	= (dev->id.sversion != 0xad) ?
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index 38166db..6fd6414 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -90,9 +90,7 @@ extern int hp300_uart_scode;
 int __init hp300_setup_serial_console(void)
 {
 	int scode;
-	struct uart_port port;
-
-	memset(&port, 0, sizeof(port));
+	struct uart_port port = {};
 
 	if (hp300_uart_scode < 0 || hp300_uart_scode > DIO_SCMAX)
 		return 0;
@@ -156,7 +154,7 @@ int __init hp300_setup_serial_console(void)
 static int hpdca_init_one(struct dio_dev *d,
 				const struct dio_device_id *ent)
 {
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	int line;
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
@@ -165,7 +163,6 @@ static int hpdca_init_one(struct dio_dev *d,
 		return 0;
 	}
 #endif
-	memset(&uart, 0, sizeof(uart));
 
 	/* Memory mapped I/O */
 	uart.port.iotype = UPIO_MEM;
@@ -205,7 +202,7 @@ static int __init hp300_8250_init(void)
 #ifdef CONFIG_HPAPCI
 	int line;
 	unsigned long base;
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	struct hp300_port *port;
 	int i;
 #endif
@@ -243,8 +240,6 @@ static int __init hp300_8250_init(void)
 		if (!port)
 			return -ENOMEM;
 
-		memset(&uart, 0, sizeof(uart));
-
 		base = (FRODO_BASE + FRODO_APCI_OFFSET(i));
 
 		/* Memory mapped I/O */
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 99cd478..e00115b 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -105,7 +105,7 @@ static void lpc18xx_uart_serial_out(struct uart_port *p, int offset, int value)
 static int lpc18xx_serial_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_uart_data *data;
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	struct resource *res;
 	int irq, ret;
 
@@ -121,8 +121,6 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	memset(&uart, 0, sizeof(uart));
-
 	uart.port.membase = devm_ioremap(&pdev->dev, res->start,
 					 resource_size(res));
 	if (!uart.port.membase)
diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 58cbb30..cba46dd 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -275,7 +275,7 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
 
 static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	struct lpss8250 *lpss;
 	int ret;
 
@@ -289,8 +289,6 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	lpss->board = (struct lpss8250_board *)id->driver_data;
 
-	memset(&uart, 0, sizeof(struct uart_8250_port));
-
 	uart.port.dev = &pdev->dev;
 	uart.port.irq = pdev->irq;
 	uart.port.private_data = lpss;
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index ac013edf..8dd68c9 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -241,7 +241,7 @@ static int mid8250_dma_setup(struct mid8250 *mid, struct uart_8250_port *port)
 
 static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	struct mid8250 *mid;
 	unsigned int bar;
 	int ret;
@@ -259,8 +259,6 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mid->board = (struct mid8250_board *)id->driver_data;
 	bar = FL_GET_BASE(mid->board->flags);
 
-	memset(&uart, 0, sizeof(struct uart_8250_port));
-
 	uart.port.dev = &pdev->dev;
 	uart.port.irq = pdev->irq;
 	uart.port.private_data = mid;
diff --git a/drivers/tty/serial/8250/8250_moxa.c b/drivers/tty/serial/8250/8250_moxa.c
index 26eb539..fe5179b 100644
--- a/drivers/tty/serial/8250/8250_moxa.c
+++ b/drivers/tty/serial/8250/8250_moxa.c
@@ -49,7 +49,7 @@ static struct moxa8250_board moxa8250_boards[] = {
 
 static int moxa8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	struct moxa8250_board *brd;
 	void __iomem *ioaddr;
 	resource_size_t baseaddr;
@@ -69,8 +69,6 @@ static int moxa8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!brd)
 		return -ENOMEM;
 
-	memset(&uart, 0, sizeof(struct uart_8250_port));
-
 	uart.port.dev = &pdev->dev;
 	uart.port.irq = pdev->irq;
 	uart.port.uartclk = MOXA_BASE_BAUD * 16;
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index d25ab1c..1fae126 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -196,8 +196,8 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	case PORT_8250 ... PORT_MAX_8250:
 	{
 		u32 tx_threshold;
-		struct uart_8250_port port8250;
-		memset(&port8250, 0, sizeof(port8250));
+		struct uart_8250_port port8250 = {};
+
 		port8250.port = port;
 
 		if (port.fifosize)
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 61ad6c3..ac88bf9 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1093,7 +1093,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct omap8250_priv *priv;
-	struct uart_8250_port up;
+	struct uart_8250_port up = {};
 	int ret;
 	void __iomem *membase;
 
@@ -1111,7 +1111,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	if (!membase)
 		return -ENODEV;
 
-	memset(&up, 0, sizeof(up));
 	up.port.dev = &pdev->dev;
 	up.port.mapbase = regs->start;
 	up.port.membase = membase;
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index aa0166b..5e45704 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3834,7 +3834,7 @@ serial_pci_matches(const struct pciserial_board *board,
 struct serial_private *
 pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 {
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	struct serial_private *priv;
 	struct pci_serial_quirk *quirk;
 	int rc, nr_ports, i;
@@ -3874,7 +3874,6 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 	priv->dev = dev;
 	priv->quirk = quirk;
 
-	memset(&uart, 0, sizeof(uart));
 	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
 	uart.port.uartclk = board->base_baud * 16;
 	uart.port.irq = get_pci_irq(dev, board);
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 34f05ed..0891a6f 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -439,7 +439,7 @@ static int serial_pnp_guess_board(struct pnp_dev *dev)
 static int
 serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
-	struct uart_8250_port uart, *port;
+	struct uart_8250_port uart = {}, *port;
 	int ret, line, flags = dev_id->driver_data;
 
 	if (flags & UNKNOWN_DEV) {
@@ -448,7 +448,6 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 			return ret;
 	}
 
-	memset(&uart, 0, sizeof(uart));
 	if (pnp_irq_valid(dev, 0))
 		uart.port.irq = pnp_irq(dev, 0);
 	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 746680e..d7cfdfd 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -196,7 +196,7 @@ static int uniphier_of_serial_setup(struct device *dev, struct uart_port *port,
 static int uniphier_uart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port up;
+	struct uart_8250_port up = {};
 	struct uniphier8250_priv *priv;
 	struct resource *regs;
 	void __iomem *membase;
@@ -223,8 +223,6 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	memset(&up, 0, sizeof(up));
-
 	ret = uniphier_of_serial_setup(dev, &up.port, priv);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 933c268..348f897 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -342,10 +342,9 @@ static void serial_detach(struct pcmcia_device *link)
 static int setup_serial(struct pcmcia_device *handle, struct serial_info *info,
 			unsigned int iobase, int irq)
 {
-	struct uart_8250_port uart;
+	struct uart_8250_port uart = {};
 	int line;
 
-	memset(&uart, 0, sizeof(uart));
 	uart.port.iobase = iobase;
 	uart.port.irq = irq;
 	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
-- 
2.7.4
