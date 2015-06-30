From: Paul Osmialowski <pawelo@king.net.pl>
Subject: [PATCH v2 8/9] arm: twr-k70f120m: extend Freescale lpuart driver with ability to support Kinetis SoC
Date: Tue, 30 Jun 2015 14:27:29 +0200
Message-ID: <1435667250-28299-9-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Paul Bolle <pebolle@tiscali.nl>, Thomas Gleixner <tglx@linutronix.de>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Paul Osmialowski <pawelo@king.net.pl>, Anson Huang <b20788@freescale.com>, Frank Li <Frank.Li@freescale.com>, Jingchang Lu <jingchang.lu@freescale.com>, Rob Herring <r.herring@freescale.com>, Yuri Tikhonov <yur@emcraft.com>, Sergei Poselenov <sposelenov@emcraft.com>, Alexander Potashev <aspotashev@emcraft.com>
List-Id: linux-serial@vger.kernel.org

This adds Kinetis SoC UART support to Freescale lpuart driver.

Apart from some small changes (e.g. phony handler for error interrupt),
somewhat bigger change was required by rx DMA operation model: for Kinetis
the transfer residue should be consumed when handling interrupt caused by
IDLE state. As a reference I used DMA related code from pre-OF UART driver
published on Emcraft git repo:

https://github.com/EmcraftSystems/linux-emcraft.git

9dc9c6dd13fa3058c776ac71a5a9f71ec89712d3
 RT76540. serial: kinetis_uart: Support receiving from UART using DMA

by Alexander Potashev <aspotashev@emcraft.com>

Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
---
 .../devicetree/bindings/serial/fsl-lpuart.txt      |  6 +-
 drivers/tty/serial/fsl_lpuart.c                    | 90 ++++++++++++++++++----
 2 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index c95005e..9a8d672 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -6,6 +6,8 @@ Required properties:
     on Vybrid vf610 SoC with 8-bit register organization
   - "fsl,ls1021a-lpuart" for lpuart compatible with the one integrated
     on LS1021A SoC with 32-bit big-endian register organization
+  - "fsl,kinetis-lpuart" for lpuart compatible with the one integrated
+    on Kinetis SoC with 8-bit register organization
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
 - clocks : phandle + clock specifier pairs, one for each entry in clock-names
@@ -15,7 +17,9 @@ Optional properties:
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
 
-Note: Optional properties for DMA support. Write them both or both not.
+Note: Optional properties for DMA support.
+        For Kinetis SoC, write "rx" only.
+        For others, write them both or both not.
 
 Example:
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 08ce76f..acf4094 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -236,6 +236,8 @@ struct lpuart_port {
 	unsigned int		txfifo_size;
 	unsigned int		rxfifo_size;
 	bool			lpuart32;
+	bool			kinetis;
+	int			kinetis_err_irq;
 
 	bool			lpuart_dma_tx_use;
 	bool			lpuart_dma_rx_use;
@@ -264,6 +266,9 @@ static const struct of_device_id lpuart_dt_ids[] = {
 	{
 		.compatible = "fsl,ls1021a-lpuart",
 	},
+	{
+		.compatible = "fsl,kinetis-lpuart",
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -350,7 +355,9 @@ static void lpuart_pio_tx(struct lpuart_port *sport)
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	while (!uart_circ_empty(xmit) &&
-		readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size) {
+	    (sport->kinetis ?
+	      (readb(sport->port.membase + UARTSR1) & UARTSR1_TDRE) :
+	      (readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size))) {
 		writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		sport->port.icount.tx++;
@@ -471,7 +478,10 @@ static void lpuart_dma_rx_complete(void *arg)
 	unsigned long flags;
 
 	async_tx_ack(sport->dma_rx_desc);
-	mod_timer(&sport->lpuart_timer, jiffies + sport->dma_rx_timeout);
+	if (!(sport->kinetis)) {
+		mod_timer(&sport->lpuart_timer,
+				jiffies + sport->dma_rx_timeout);
+	}
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
@@ -483,16 +493,14 @@ static void lpuart_dma_rx_complete(void *arg)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
-static void lpuart_timer_func(unsigned long data)
+static inline void lpuart_dma_rx_extract_residue(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = (struct lpuart_port *)data;
 	struct tty_port *port = &sport->port.state->port;
 	struct dma_tx_state state;
 	unsigned long flags;
 	unsigned char temp;
 	int count;
 
-	del_timer(&sport->lpuart_timer);
 	dmaengine_pause(sport->dma_rx_chan);
 	dmaengine_tx_status(sport->dma_rx_chan, sport->dma_rx_cookie, &state);
 	dmaengine_terminate_all(sport->dma_rx_chan);
@@ -510,6 +518,14 @@ static void lpuart_timer_func(unsigned long data)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
+static void lpuart_timer_func(unsigned long data)
+{
+	struct lpuart_port *sport = (struct lpuart_port *)data;
+
+	del_timer(&sport->lpuart_timer);
+	lpuart_dma_rx_extract_residue(sport);
+}
+
 static inline void lpuart_prepare_rx(struct lpuart_port *sport)
 {
 	unsigned long flags;
@@ -517,8 +533,10 @@ static inline void lpuart_prepare_rx(struct lpuart_port *sport)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
-	add_timer(&sport->lpuart_timer);
+	if (!(sport->kinetis)) {
+		sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
+		add_timer(&sport->lpuart_timer);
+	}
 
 	lpuart_dma_rx(sport);
 	temp = readb(sport->port.membase + UARTCR5);
@@ -532,7 +550,9 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 	struct circ_buf *xmit = &sport->port.state->xmit;
 
 	while (!uart_circ_empty(xmit) &&
-		(readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size)) {
+	    (sport->kinetis ?
+	      (readb(sport->port.membase + UARTSR1) & UARTSR1_TDRE) :
+	      (readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size))) {
 		writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		sport->port.icount.tx++;
@@ -766,13 +786,20 @@ out:
 static irqreturn_t lpuart_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned char sts, crdma;
+	unsigned char sts, crdma, tmp;
 
 	sts = readb(sport->port.membase + UARTSR1);
 	crdma = readb(sport->port.membase + UARTCR5);
 
-	if (sts & UARTSR1_RDRF && !(crdma & UARTCR5_RDMAS)) {
-		if (sport->lpuart_dma_rx_use)
+	if (sport->kinetis && sport->lpuart_dma_rx_use) {
+		if (sts & UARTSR1_IDLE) {
+			/* Clear S[IDLE] flag by reading from UARTx_D */
+			tmp = readb(sport->port.membase + UARTDR);
+			lpuart_dma_rx_extract_residue(sport);
+			lpuart_prepare_rx(sport);
+		}
+	} else if (sts & UARTSR1_RDRF && !(crdma & UARTCR5_RDMAS)) {
+		if ((!(sport->kinetis)) && (sport->lpuart_dma_rx_use))
 			lpuart_prepare_rx(sport);
 		else
 			lpuart_rxint(irq, dev_id);
@@ -807,6 +834,11 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t lpuart_errint(int irq, void *data)
+{
+	return IRQ_HANDLED;
+}
+
 /* return TIOCSER_TEMT when transmitter is not busy */
 static unsigned int lpuart_tx_empty(struct uart_port *port)
 {
@@ -1086,8 +1118,11 @@ static int lpuart_startup(struct uart_port *port)
 
 	if (sport->dma_rx_chan && !lpuart_dma_rx_request(port)) {
 		sport->lpuart_dma_rx_use = true;
-		setup_timer(&sport->lpuart_timer, lpuart_timer_func,
-			    (unsigned long)sport);
+		if (sport->kinetis)
+			lpuart_prepare_rx(sport);
+		else
+			setup_timer(&sport->lpuart_timer, lpuart_timer_func,
+					(unsigned long)sport);
 	} else
 		sport->lpuart_dma_rx_use = false;
 
@@ -1105,12 +1140,23 @@ static int lpuart_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
+	if (sport->kinetis) {
+		ret = devm_request_irq(port->dev, sport->kinetis_err_irq,
+					lpuart_errint, 0, DRIVER_NAME, sport);
+		if (ret) {
+			devm_free_irq(port->dev, port->irq, sport);
+			return ret;
+		}
+	}
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	lpuart_setup_watermark(sport);
 
 	temp = readb(sport->port.membase + UARTCR2);
 	temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
+	if (sport->kinetis && sport->lpuart_dma_rx_use)
+		temp |= UARTCR2_ILIE;
 	writeb(temp, sport->port.membase + UARTCR2);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -1169,6 +1215,9 @@ static void lpuart_shutdown(struct uart_port *port)
 
 	devm_free_irq(port->dev, port->irq, sport);
 
+	if (sport->kinetis)
+		devm_free_irq(port->dev, sport->kinetis_err_irq, sport);
+
 	if (sport->lpuart_dma_rx_use) {
 		lpuart_dma_rx_free(&sport->port);
 		del_timer_sync(&sport->lpuart_timer);
@@ -1781,6 +1830,8 @@ static int lpuart_probe(struct platform_device *pdev)
 	}
 	sport->port.line = ret;
 	sport->lpuart32 = of_device_is_compatible(np, "fsl,ls1021a-lpuart");
+	sport->kinetis = of_device_is_compatible(np, "fsl,kinetis-lpuart");
+	spin_lock_init(&(sport->port.lock));
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
@@ -1788,10 +1839,19 @@ static int lpuart_probe(struct platform_device *pdev)
 		return PTR_ERR(sport->port.membase);
 
 	sport->port.mapbase = res->start;
+	sport->port.mapsize = resource_size(res);
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->port.iotype = UPIO_MEM;
-	sport->port.irq = platform_get_irq(pdev, 0);
+
+	if (sport->kinetis) {
+		sport->port.irq = platform_get_irq_byname(pdev, "uart-stat");
+		sport->kinetis_err_irq =
+				platform_get_irq_byname(pdev, "uart-err");
+	} else {
+		sport->port.irq = platform_get_irq(pdev, 0);
+	}
+
 	if (sport->lpuart32)
 		sport->port.ops = &lpuart32_pops;
 	else
@@ -1829,7 +1889,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	}
 
 	sport->dma_tx_chan = dma_request_slave_channel(sport->port.dev, "tx");
-	if (!sport->dma_tx_chan)
+	if ((!sport->dma_tx_chan) && (!sport->kinetis))
 		dev_info(sport->port.dev, "DMA tx channel request failed, "
 				"operating without tx DMA\n");
 
-- 
2.3.6

