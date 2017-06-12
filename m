From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V3 3/7] tty: serial: lpuart: add little endian 32 bit register
 support
Date: Mon, 12 Jun 2017 23:37:24 +0800
Message-ID: <1497281848-12995-4-git-send-email-aisheng.dong@nxp.com>
References: <1497281848-12995-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497281848-12995-1-git-send-email-aisheng.dong@nxp.com>
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
Cc: nikita.yoush@cogentembedded.com, Dong Aisheng <aisheng.dong@nxp.com>, fugang.duan@nxp.com, dongas86@gmail.com, gregkh@linuxfoundation.org, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org, stefan@agner.ch, andy.shevchenko@gmail.com, Mingkai.Hu@nxp.com, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Use standard port->iotype to distinguish endian difference. Note as we
read/write register by checking iotype dynamically, we need to initialize
the iotype correctly for earlycon as well to avoid a break.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com> (supporter:TTY LAYER)
Cc: Stefan Agner <stefan@agner.ch>
Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

ChangeLog:
v2->v3:
 * Instead of using global var, use standard port->iotype to distinguish
   endian difference.
v1->v2:
 * No changes
---
 drivers/tty/serial/fsl_lpuart.c | 43 +++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ed9db2f..bbf47a0 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -280,15 +280,29 @@ MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
 /* Forward declare this for the dma callbacks*/
 static void lpuart_dma_tx_complete(void *arg);
 
-static inline u32 lpuart32_read(struct uart_port *port, u32 reg_off)
-{
-	return ioread32be(port->membase + reg_off);
+static inline u32 lpuart32_read(struct uart_port *port, u32 off)
+{
+	switch (port->iotype) {
+	case UPIO_MEM32:
+		return readl(port->membase + off);
+	case UPIO_MEM32BE:
+		return ioread32be(port->membase + off);
+	default:
+		return 0;
+	};
 }
 
 static inline void lpuart32_write(struct uart_port *port, u32 val,
-				  u32 reg_off)
+				  u32 off)
 {
-	iowrite32be(val, port->membase + reg_off);
+	switch (port->iotype) {
+	case UPIO_MEM32:
+		writel(val, port->membase + off);
+		break;
+	case UPIO_MEM32BE:
+		iowrite32be(val, port->membase + off);
+		break;
+	};
 }
 
 static void lpuart_stop_tx(struct uart_port *port)
@@ -602,7 +616,7 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	if (sport->port.x_char) {
-		if (sport->port.iotype & UPIO_MEM32BE)
+		if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
 			lpuart32_write(&sport->port, sport->port.x_char, UARTDATA);
 		else
 			writeb(sport->port.x_char, sport->port.membase + UARTDR);
@@ -610,14 +624,14 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 	}
 
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
-		if (sport->port.iotype & UPIO_MEM32BE)
+		if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
 			lpuart32_stop_tx(&sport->port);
 		else
 			lpuart_stop_tx(&sport->port);
 		goto out;
 	}
 
-	if (sport->port.iotype & UPIO_MEM32BE)
+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
 		lpuart32_transmit_buffer(sport);
 	else
 		lpuart_transmit_buffer(sport);
@@ -1890,12 +1904,12 @@ static int __init lpuart_console_setup(struct console *co, char *options)
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
-		if (sport->port.iotype & UPIO_MEM32BE)
+		if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
 			lpuart32_console_get_options(sport, &baud, &parity, &bits);
 		else
 			lpuart_console_get_options(sport, &baud, &parity, &bits);
 
-	if (sport->port.iotype & UPIO_MEM32BE)
+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
 		lpuart32_setup_watermark(sport);
 	else
 		lpuart_setup_watermark(sport);
@@ -1954,6 +1968,7 @@ static int __init lpuart32_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
+	device->port.iotype = UPIO_MEM32BE;
 	device->con->write = lpuart32_early_write;
 	return 0;
 }
@@ -2015,7 +2030,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	}
 	sport->port.irq = ret;
 	sport->port.iotype = sdata->iotype;
-	if (sport->port.iotype & UPIO_MEM32BE)
+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
 		sport->port.ops = &lpuart32_pops;
 	else
 		sport->port.ops = &lpuart_pops;
@@ -2042,7 +2057,7 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &sport->port);
 
-	if (sport->port.iotype & UPIO_MEM32BE)
+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE))
 		lpuart_reg.cons = LPUART32_CONSOLE;
 	else
 		lpuart_reg.cons = LPUART_CONSOLE;
@@ -2095,7 +2110,7 @@ static int lpuart_suspend(struct device *dev)
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	unsigned long temp;
 
-	if (sport->port.iotype & UPIO_MEM32BE) {
+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE)) {
 		/* disable Rx/Tx and interrupts */
 		temp = lpuart32_read(&sport->port, UARTCTRL);
 		temp &= ~(UARTCTRL_TE | UARTCTRL_TIE | UARTCTRL_TCIE);
@@ -2146,7 +2161,7 @@ static int lpuart_resume(struct device *dev)
 	if (sport->port.suspended && !sport->port.irq_wake)
 		clk_prepare_enable(sport->clk);
 
-	if (sport->port.iotype & UPIO_MEM32BE) {
+	if (sport->port.iotype & (UPIO_MEM32 | UPIO_MEM32BE)) {
 		lpuart32_setup_watermark(sport);
 		temp = lpuart32_read(&sport->port, UARTCTRL);
 		temp |= (UARTCTRL_RIE | UARTCTRL_TIE | UARTCTRL_RE |
-- 
2.7.4
