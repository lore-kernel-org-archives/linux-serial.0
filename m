From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 10/14] SERIAL: MIPS: lantiq: implement OF support
Date: Fri,  4 May 2012 14:18:35 +0200
Message-ID: <1336133919-26525-10-git-send-email-blogic@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:50463 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757649Ab2EDMUS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 May 2012 08:20:18 -0400
In-Reply-To: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Add devicetree and handling for our new clkdev clocks. The patch is rather
straightforward. .of_match_table is set and the 3 irqs are now loaded from the
devicetree.

This series converts the lantiq target to clkdev amongst other things. The
driver needs to handle two clocks now. The fpi bus clock used to derive the
divider and the clock gate needed on some socs to make the secondary port work.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org
---
This patch is part of a series moving the mips/lantiq target to OF and clkdev
support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

 drivers/tty/serial/lantiq.c |   83 ++++++++++++++++++++++++++----------------
 1 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 96c1cac..b5044fa 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -31,16 +31,19 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
-#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 
 #include <lantiq_soc.h>
 
 #define PORT_LTQ_ASC		111
 #define MAXPORTS		2
 #define UART_DUMMY_UER_RX	1
-#define DRVNAME			"ltq_asc"
+#define DRVNAME			"lantiq,asc"
 #ifdef __BIG_ENDIAN
 #define LTQ_ASC_TBUF		(0x0020 + 3)
 #define LTQ_ASC_RBUF		(0x0024 + 3)
@@ -114,6 +117,9 @@ static DEFINE_SPINLOCK(ltq_asc_lock);
 
 struct ltq_uart_port {
 	struct uart_port	port;
+	/* clock used to derive divider */
+	struct clk		*fpiclk;
+	/* clock gating of the ASC core */
 	struct clk		*clk;
 	unsigned int		tx_irq;
 	unsigned int		rx_irq;
@@ -316,7 +322,9 @@ lqasc_startup(struct uart_port *port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 	int retval;
 
-	port->uartclk = clk_get_rate(ltq_port->clk);
+	if (ltq_port->clk)
+		clk_enable(ltq_port->clk);
+	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
 	ltq_w32_mask(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
@@ -382,6 +390,8 @@ lqasc_shutdown(struct uart_port *port)
 		port->membase + LTQ_ASC_RXFCON);
 	ltq_w32_mask(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
+	if (ltq_port->clk)
+		clk_disable(ltq_port->clk);
 }
 
 static void
@@ -630,7 +640,7 @@ lqasc_console_setup(struct console *co, char *options)
 
 	port = &ltq_port->port;
 
-	port->uartclk = clk_get_rate(ltq_port->clk);
+	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -668,37 +678,32 @@ static struct uart_driver lqasc_reg = {
 static int __init
 lqasc_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct ltq_uart_port *ltq_port;
 	struct uart_port *port;
-	struct resource *mmres, *irqres;
-	int tx_irq, rx_irq, err_irq;
-	struct clk *clk;
+	struct resource *mmres, irqres[3];
+	int line = 0;
 	int ret;
 
 	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irqres = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!mmres || !irqres)
+	ret = of_irq_to_resource_table(node, irqres, 3);
+	if (!mmres || (ret != 3)) {
+		dev_err(&pdev->dev,
+			"failed to get memory/irq for serial port\n");
 		return -ENODEV;
+	}
 
-	if (pdev->id >= MAXPORTS)
-		return -EBUSY;
+	/* check if this is the console port */
+	if (mmres->start != LTQ_ASC1_BASE_ADDR)
+		line = 1;
 
-	if (lqasc_port[pdev->id] != NULL)
+	if (lqasc_port[line]) {
+		dev_err(&pdev->dev, "port %d already allocated\n", line);
 		return -EBUSY;
-
-	clk = clk_get(&pdev->dev, "fpi");
-	if (IS_ERR(clk)) {
-		pr_err("failed to get fpi clk\n");
-		return -ENOENT;
 	}
 
-	tx_irq = platform_get_irq_byname(pdev, "tx");
-	rx_irq = platform_get_irq_byname(pdev, "rx");
-	err_irq = platform_get_irq_byname(pdev, "err");
-	if ((tx_irq < 0) | (rx_irq < 0) | (err_irq < 0))
-		return -ENODEV;
-
-	ltq_port = kzalloc(sizeof(struct ltq_uart_port), GFP_KERNEL);
+	ltq_port = devm_kzalloc(&pdev->dev, sizeof(struct ltq_uart_port),
+			GFP_KERNEL);
 	if (!ltq_port)
 		return -ENOMEM;
 
@@ -709,19 +714,26 @@ lqasc_probe(struct platform_device *pdev)
 	port->ops	= &lqasc_pops;
 	port->fifosize	= 16;
 	port->type	= PORT_LTQ_ASC,
-	port->line	= pdev->id;
+	port->line	= line;
 	port->dev	= &pdev->dev;
-
-	port->irq	= tx_irq; /* unused, just to be backward-compatibe */
+	/* unused, just to be backward-compatible */
+	port->irq	= irqres[0].start;
 	port->mapbase	= mmres->start;
 
-	ltq_port->clk	= clk;
+	ltq_port->fpiclk = clk_get_fpi();
+	if (IS_ERR(ltq_port->fpiclk)) {
+		pr_err("failed to get fpi clk\n");
+		return -ENOENT;
+	}
 
-	ltq_port->tx_irq = tx_irq;
-	ltq_port->rx_irq = rx_irq;
-	ltq_port->err_irq = err_irq;
+	/* not all asc ports have clock gates, lets ignore the return code */
+	ltq_port->clk = clk_get(&pdev->dev, NULL);
 
-	lqasc_port[pdev->id] = ltq_port;
+	ltq_port->tx_irq = irqres[0].start;
+	ltq_port->rx_irq = irqres[1].start;
+	ltq_port->err_irq = irqres[2].start;
+
+	lqasc_port[line] = ltq_port;
 	platform_set_drvdata(pdev, ltq_port);
 
 	ret = uart_add_one_port(&lqasc_reg, port);
@@ -729,10 +741,17 @@ lqasc_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id ltq_asc_match[] = {
+	{ .compatible = DRVNAME },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltq_asc_match);
+
 static struct platform_driver lqasc_driver = {
 	.driver		= {
 		.name	= DRVNAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = ltq_asc_match,
 	},
 };
 
-- 
1.7.9.1

