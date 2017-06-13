From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V4 1/7] tty: serial: lpuart: introduce lpuart_soc_data to represent SoC property
Date: Tue, 13 Jun 2017 10:55:48 +0800
Message-ID: <1497322554-24463-2-git-send-email-aisheng.dong@nxp.com>
References: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, stefan@agner.ch, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com, nikita.yoush@cogentembedded.com, andy.shevchenko@gmail.com, dongas86@gmail.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-serial@vger.kernel.org

This is used to dynamically check the SoC specific lpuart properies.
Currently only the iotype is added, it functions the same as before.
With this, new chips with different iotype will be more easily added.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Fugang Duan <fugang.duan@nxp.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * remove one duplicated blank line
v2->v3:
 * use standard iotype flags instead of private is_32 member
v1->v2:
 * make all soc_data const
---
 drivers/tty/serial/fsl_lpuart.c | 47 +++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 15df1ba7..c17a0ea 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -236,7 +236,6 @@ struct lpuart_port {
 	struct clk		*clk;
 	unsigned int		txfifo_size;
 	unsigned int		rxfifo_size;
-	bool			lpuart32;
 
 	bool			lpuart_dma_tx_use;
 	bool			lpuart_dma_rx_use;
@@ -258,13 +257,21 @@ struct lpuart_port {
 	wait_queue_head_t	dma_wait;
 };
 
+struct lpuart_soc_data {
+	char	iotype;
+};
+
+static const struct lpuart_soc_data vf_data = {
+	.iotype = UPIO_MEM,
+};
+
+static const struct lpuart_soc_data ls_data = {
+	.iotype = UPIO_MEM32BE,
+};
+
 static const struct of_device_id lpuart_dt_ids[] = {
-	{
-		.compatible = "fsl,vf610-lpuart",
-	},
-	{
-		.compatible = "fsl,ls1021a-lpuart",
-	},
+	{ .compatible = "fsl,vf610-lpuart",	.data = &vf_data, },
+	{ .compatible = "fsl,ls1021a-lpuart",	.data = &ls_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -593,7 +600,7 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	if (sport->port.x_char) {
-		if (sport->lpuart32)
+		if (sport->port.iotype & UPIO_MEM32BE)
 			lpuart32_write(sport->port.x_char, sport->port.membase + UARTDATA);
 		else
 			writeb(sport->port.x_char, sport->port.membase + UARTDR);
@@ -601,14 +608,14 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 	}
 
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
-		if (sport->lpuart32)
+		if (sport->port.iotype & UPIO_MEM32BE)
 			lpuart32_stop_tx(&sport->port);
 		else
 			lpuart_stop_tx(&sport->port);
 		goto out;
 	}
 
-	if (sport->lpuart32)
+	if (sport->port.iotype & UPIO_MEM32BE)
 		lpuart32_transmit_buffer(sport);
 	else
 		lpuart_transmit_buffer(sport);
@@ -1881,12 +1888,12 @@ static int __init lpuart_console_setup(struct console *co, char *options)
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
-		if (sport->lpuart32)
+		if (sport->port.iotype & UPIO_MEM32BE)
 			lpuart32_console_get_options(sport, &baud, &parity, &bits);
 		else
 			lpuart_console_get_options(sport, &baud, &parity, &bits);
 
-	if (sport->lpuart32)
+	if (sport->port.iotype & UPIO_MEM32BE)
 		lpuart32_setup_watermark(sport);
 	else
 		lpuart_setup_watermark(sport);
@@ -1971,6 +1978,9 @@ static struct uart_driver lpuart_reg = {
 
 static int lpuart_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id = of_match_device(lpuart_dt_ids,
+							   &pdev->dev);
+	const struct lpuart_soc_data *sdata = of_id->data;
 	struct device_node *np = pdev->dev.of_node;
 	struct lpuart_port *sport;
 	struct resource *res;
@@ -1988,8 +1998,6 @@ static int lpuart_probe(struct platform_device *pdev)
 		return ret;
 	}
 	sport->port.line = ret;
-	sport->lpuart32 = of_device_is_compatible(np, "fsl,ls1021a-lpuart");
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(sport->port.membase))
@@ -1998,15 +2006,14 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.mapbase = res->start;
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
-	sport->port.iotype = UPIO_MEM;
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot obtain irq\n");
 		return ret;
 	}
 	sport->port.irq = ret;
-
-	if (sport->lpuart32)
+	sport->port.iotype = sdata->iotype;
+	if (sport->port.iotype & UPIO_MEM32BE)
 		sport->port.ops = &lpuart32_pops;
 	else
 		sport->port.ops = &lpuart_pops;
@@ -2033,7 +2040,7 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &sport->port);
 
-	if (sport->lpuart32)
+	if (sport->port.iotype & UPIO_MEM32BE)
 		lpuart_reg.cons = LPUART32_CONSOLE;
 	else
 		lpuart_reg.cons = LPUART_CONSOLE;
@@ -2086,7 +2093,7 @@ static int lpuart_suspend(struct device *dev)
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	unsigned long temp;
 
-	if (sport->lpuart32) {
+	if (sport->port.iotype & UPIO_MEM32BE) {
 		/* disable Rx/Tx and interrupts */
 		temp = lpuart32_read(sport->port.membase + UARTCTRL);
 		temp &= ~(UARTCTRL_TE | UARTCTRL_TIE | UARTCTRL_TCIE);
@@ -2137,7 +2144,7 @@ static int lpuart_resume(struct device *dev)
 	if (sport->port.suspended && !sport->port.irq_wake)
 		clk_prepare_enable(sport->clk);
 
-	if (sport->lpuart32) {
+	if (sport->port.iotype & UPIO_MEM32BE) {
 		lpuart32_setup_watermark(sport);
 		temp = lpuart32_read(sport->port.membase + UARTCTRL);
 		temp |= (UARTCTRL_RIE | UARTCTRL_TIE | UARTCTRL_RE |
-- 
2.7.4
