From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 2/4] serial: imx: add runtime pm support
Date: Fri, 14 Aug 2015 21:37:46 -0700
Message-ID: <1439613468-22366-3-git-send-email-edubezval@gmail.com>
References: <1439613468-22366-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439613468-22366-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

This change introduces the runtime pm support on imx serial
driver. The objective is to be able to idle the uart
port whenever it is not in use while still being able
to wake it up when needed. The key changes in this patch are:
1. Move the clock handling to runtime pm. Both, ipg and per,
are now handled in the suspend and resume callbacks. Only
enabling and disabling the clocks are handled in runtime
suspend and resume, so we are able to use runtime pm
in IRQ context.
2. Clocks are prepared in probe and unprepared in remove,
so we do not need to prepare (may sleep) in runtime pm.
3. We mark the device activity based on uart and console
callbacks. Whenever the device is needed and we want to
access registers, we runtime_pm_get and then mark its
last usage when we are done. This is done also across
IRQs and DMA callbacks.
4. We reuse the infrastructure in place for suspend and
resume, so we do not need to redo wakeup configuration,
or context save and restore.

After this change, the clocks are still sane, in the sense
of having balanced clock prepare and enable.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 239 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 191 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 50abb60..d9ccf6b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -39,6 +39,9 @@
 #include <linux/of_device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_wakeup.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/serial-imx.h>
@@ -369,6 +372,7 @@ static void imx_stop_tx(struct uart_port *port)
 	if (sport->dma_is_enabled && sport->dma_is_txing)
 		return;
 
+	pm_runtime_get_sync(sport->port.dev);
 	temp = readl(port->membase + UCR1);
 	writel(temp & ~UCR1_TXMPTYEN, port->membase + UCR1);
 
@@ -386,6 +390,8 @@ static void imx_stop_tx(struct uart_port *port)
 		temp &= ~UCR4_TCEN;
 		writel(temp, port->membase + UCR4);
 	}
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 /*
@@ -405,12 +411,15 @@ static void imx_stop_rx(struct uart_port *port)
 		}
 	}
 
+	pm_runtime_get_sync(sport->port.dev);
 	temp = readl(sport->port.membase + UCR2);
 	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
 
 	/* disable the `Receiver Ready Interrrupt` */
 	temp = readl(sport->port.membase + UCR1);
 	writel(temp & ~UCR1_RRDYEN, sport->port.membase + UCR1);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 /*
@@ -482,6 +491,7 @@ static void dma_tx_callback(void *data)
 	unsigned long flags;
 	unsigned long temp;
 
+	pm_runtime_get_sync(sport->port.dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
@@ -506,13 +516,17 @@ static void dma_tx_callback(void *data)
 	if (waitqueue_active(&sport->dma_wait)) {
 		wake_up(&sport->dma_wait);
 		dev_dbg(sport->port.dev, "exit in %s.\n", __func__);
-		return;
+		goto mark_last;
 	}
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
 		imx_dma_tx(sport);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+
+mark_last:
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 static void imx_dma_tx(struct imx_port *sport)
@@ -579,6 +593,7 @@ static void imx_start_tx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
+	pm_runtime_get_sync(sport->port.dev);
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		/* enable transmitter and shifter empty irq */
 		temp = readl(port->membase + UCR2);
@@ -606,14 +621,18 @@ static void imx_start_tx(struct uart_port *port)
 			temp &= ~UCR1_TDMAEN;
 			temp |= UCR1_TXMPTYEN;
 			writel(temp, sport->port.membase + UCR1);
-			return;
+			goto mark_last;
 		}
 
 		if (!uart_circ_empty(&port->state->xmit) &&
 		    !uart_tx_stopped(port))
 			imx_dma_tx(sport);
-		return;
+		goto mark_last;
 	}
+
+mark_last:
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 static irqreturn_t imx_rtsint(int irq, void *dev_id)
@@ -622,6 +641,7 @@ static irqreturn_t imx_rtsint(int irq, void *dev_id)
 	unsigned int val;
 	unsigned long flags;
 
+	pm_runtime_get_sync(sport->port.dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	writel(USR1_RTSD, sport->port.membase + USR1);
@@ -630,6 +650,9 @@ static irqreturn_t imx_rtsint(int irq, void *dev_id)
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
+
 	return IRQ_HANDLED;
 }
 
@@ -638,9 +661,13 @@ static irqreturn_t imx_txint(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned long flags;
 
+	pm_runtime_get_sync(sport->port.dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 	imx_transmit_buffer(sport);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
+
 	return IRQ_HANDLED;
 }
 
@@ -651,6 +678,7 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags, temp;
 
+	pm_runtime_get_sync(sport->port.dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	while (readl(sport->port.membase + USR2) & USR2_RDR) {
@@ -711,6 +739,8 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 	tty_flip_buffer_push(port);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 	return IRQ_HANDLED;
 }
 
@@ -748,6 +778,7 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	unsigned int sts;
 	unsigned int sts2;
 
+	pm_runtime_get_sync(sport->port.dev);
 	sts = readl(sport->port.membase + USR1);
 	sts2 = readl(sport->port.membase + USR2);
 
@@ -774,6 +805,8 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 		sport->port.icount.overrun++;
 		writel(USR2_ORE, sport->port.membase + USR2);
 	}
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 
 	return IRQ_HANDLED;
 }
@@ -786,11 +819,14 @@ static unsigned int imx_tx_empty(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned int ret;
 
+	pm_runtime_get_sync(sport->port.dev);
 	ret = (readl(sport->port.membase + USR2) & USR2_TXDC) ?  TIOCSER_TEMT : 0;
 
 	/* If the TX DMA is working, return 0. */
 	if (sport->dma_is_enabled && sport->dma_is_txing)
 		ret = 0;
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 
 	return ret;
 }
@@ -803,6 +839,7 @@ static unsigned int imx_get_mctrl(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned int tmp = TIOCM_DSR | TIOCM_CAR;
 
+	pm_runtime_get_sync(sport->port.dev);
 	if (readl(sport->port.membase + USR1) & USR1_RTSS)
 		tmp |= TIOCM_CTS;
 
@@ -811,6 +848,8 @@ static unsigned int imx_get_mctrl(struct uart_port *port)
 
 	if (readl(sport->port.membase + uts_reg(sport)) & UTS_LOOP)
 		tmp |= TIOCM_LOOP;
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 
 	return tmp;
 }
@@ -820,6 +859,7 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
+	pm_runtime_get_sync(sport->port.dev);
 	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
 		temp = readl(sport->port.membase + UCR2);
 		temp &= ~(UCR2_CTS | UCR2_CTSC);
@@ -832,6 +872,8 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (mctrl & TIOCM_LOOP)
 		temp |= UTS_LOOP;
 	writel(temp, sport->port.membase + uts_reg(sport));
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 /*
@@ -842,6 +884,7 @@ static void imx_break_ctl(struct uart_port *port, int break_state)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags, temp;
 
+	pm_runtime_get_sync(sport->port.dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	temp = readl(sport->port.membase + UCR1) & ~UCR1_SNDBRK;
@@ -852,6 +895,8 @@ static void imx_break_ctl(struct uart_port *port, int break_state)
 	writel(temp, sport->port.membase + UCR1);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 #define TXTL 2 /* reset default */
@@ -909,6 +954,7 @@ static void dma_rx_callback(void *data)
 	enum dma_status status;
 	unsigned int count;
 
+	pm_runtime_get_sync(sport->port.dev);
 	/* unmap it first */
 	dma_unmap_sg(sport->port.dev, sgl, 1, DMA_FROM_DEVICE);
 
@@ -950,6 +996,8 @@ static void dma_rx_callback(void *data)
 		 */
 		imx_rx_dma_done(sport);
 	}
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 static int start_rx_dma(struct imx_port *sport)
@@ -1105,18 +1153,10 @@ static void imx_disable_dma(struct imx_port *sport)
 static int imx_startup(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	int retval, i;
+	int i;
 	unsigned long flags, temp;
 
-	retval = clk_prepare_enable(sport->clk_per);
-	if (retval)
-		return retval;
-	retval = clk_prepare_enable(sport->clk_ipg);
-	if (retval) {
-		clk_disable_unprepare(sport->clk_per);
-		return retval;
-	}
-
+	pm_runtime_get_sync(sport->port.dev);
 	imx_setup_ufcr(sport, 0);
 
 	/* disable the DREN bit (Data Ready interrupt enable) before
@@ -1173,6 +1213,8 @@ static int imx_startup(struct uart_port *port)
 	 */
 	imx_enable_ms(&sport->port);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 
 	return 0;
 }
@@ -1183,6 +1225,7 @@ static void imx_shutdown(struct uart_port *port)
 	unsigned long temp;
 	unsigned long flags;
 
+	pm_runtime_get_sync(sport->port.dev);
 	if (sport->dma_is_enabled) {
 		int ret;
 
@@ -1225,8 +1268,8 @@ static void imx_shutdown(struct uart_port *port)
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable_unprepare(sport->clk_per);
-	clk_disable_unprepare(sport->clk_ipg);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 static void imx_flush_buffer(struct uart_port *port)
@@ -1239,6 +1282,7 @@ static void imx_flush_buffer(struct uart_port *port)
 	if (!sport->dma_chan_tx)
 		return;
 
+	pm_runtime_get_sync(sport->port.dev);
 	sport->tx_bytes = 0;
 	dmaengine_terminate_all(sport->dma_chan_tx);
 	if (sport->dma_is_txing) {
@@ -1272,6 +1316,8 @@ static void imx_flush_buffer(struct uart_port *port)
 	writel(ubir, sport->port.membase + UBIR);
 	writel(ubmr, sport->port.membase + UBMR);
 	writel(uts, sport->port.membase + IMX21_UTS);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 static void
@@ -1286,6 +1332,7 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long num, denom;
 	uint64_t tdiv64;
 
+	pm_runtime_get_sync(sport->port.dev);
 	/*
 	 * We only support CS7 and CS8.
 	 */
@@ -1441,6 +1488,8 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (sport->dma_is_inited && !sport->dma_is_enabled)
 		imx_enable_dma(sport);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 static const char *imx_type(struct uart_port *port)
@@ -1498,13 +1547,7 @@ static int imx_poll_init(struct uart_port *port)
 	unsigned long temp;
 	int retval;
 
-	retval = clk_prepare_enable(sport->clk_ipg);
-	if (retval)
-		return retval;
-	retval = clk_prepare_enable(sport->clk_per);
-	if (retval)
-		clk_disable_unprepare(sport->clk_ipg);
-
+	pm_runtime_get_sync(sport->port.dev);
 	imx_setup_ufcr(sport, 0);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
@@ -1521,22 +1564,36 @@ static int imx_poll_init(struct uart_port *port)
 	writel(temp, sport->port.membase + UCR2);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 
 	return 0;
 }
 
 static int imx_poll_get_char(struct uart_port *port)
 {
-	if (!(readl_relaxed(port->membase + USR2) & USR2_RDR))
-		return NO_POLL_CHAR;
+	int ret;
+
+	pm_runtime_get_sync(sport->port.dev);
+	if (!(readl_relaxed(port->membase + USR2) & USR2_RDR)) {
+		ret = NO_POLL_CHAR;
+		goto mark_last;
+	}
+
+	ret = readl_relaxed(port->membase + URXD0) & URXD_RX_DATA;
+
+mark_last:
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 
-	return readl_relaxed(port->membase + URXD0) & URXD_RX_DATA;
+	return ret;
 }
 
 static void imx_poll_put_char(struct uart_port *port, unsigned char c)
 {
 	unsigned int status;
 
+	pm_runtime_get_sync(sport->port.dev);
 	/* drain */
 	do {
 		status = readl_relaxed(port->membase + USR1);
@@ -1549,6 +1606,8 @@ static void imx_poll_put_char(struct uart_port *port, unsigned char c)
 	do {
 		status = readl_relaxed(port->membase + USR2);
 	} while (~status & USR2_TXDC);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 #endif
 
@@ -1569,6 +1628,7 @@ static int imx_rs485_config(struct uart_port *port,
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		unsigned long temp;
 
+		pm_runtime_get_sync(sport->port.dev);
 		/* disable transmitter */
 		temp = readl(sport->port.membase + UCR2);
 		temp &= ~UCR2_CTSC;
@@ -1577,6 +1637,8 @@ static int imx_rs485_config(struct uart_port *port,
 		else
 			temp |= UCR2_CTS;
 		writel(temp, sport->port.membase + UCR2);
+		pm_runtime_mark_last_busy(sport->port.dev);
+		pm_runtime_put_autosuspend(sport->port.dev);
 	}
 
 	port->rs485 = *rs485conf;
@@ -1631,17 +1693,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned int ucr1;
 	unsigned long flags = 0;
 	int locked = 1;
-	int retval;
-
-	retval = clk_prepare_enable(sport->clk_per);
-	if (retval)
-		return;
-	retval = clk_prepare_enable(sport->clk_ipg);
-	if (retval) {
-		clk_disable_unprepare(sport->clk_per);
-		return;
-	}
 
+	pm_runtime_get_sync(sport->port.dev);
 	if (sport->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
@@ -1677,8 +1730,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable_unprepare(sport->clk_ipg);
-	clk_disable_unprepare(sport->clk_per);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 }
 
 /*
@@ -1765,10 +1818,7 @@ imx_console_setup(struct console *co, char *options)
 	if (sport == NULL)
 		return -ENODEV;
 
-	/* For setting the registers, we only need to enable the ipg clock. */
-	retval = clk_prepare_enable(sport->clk_ipg);
-	if (retval)
-		goto error_console;
+	pm_runtime_get_sync(sport->port.dev);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -1779,9 +1829,8 @@ imx_console_setup(struct console *co, char *options)
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
-	clk_disable_unprepare(sport->clk_ipg);
-
-error_console:
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
 	return retval;
 }
 
@@ -1965,14 +2014,36 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sport);
 
-	return uart_add_one_port(&imx_reg, &sport->port);
+	device_init_wakeup(sport->port.dev, true);
+	pm_runtime_use_autosuspend(sport->port.dev);
+	pm_runtime_set_autosuspend_delay(sport->port.dev, 5000);
+
+	pm_runtime_irq_safe(sport->port.dev);
+	pm_runtime_enable(sport->port.dev);
+
+	clk_prepare(sport->clk_per);
+	clk_prepare(sport->clk_ipg);
+	pm_runtime_get_sync(sport->port.dev);
+	ret = uart_add_one_port(&imx_reg, &sport->port);
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
+
+	return ret;
 }
 
 static int serial_imx_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
+
+	pm_runtime_put_sync(sport->port.dev);
+	pm_runtime_disable(sport->port.dev);
+	clk_unprepare(sport->clk_per);
+	clk_unprepare(sport->clk_ipg);
+	ret = uart_remove_one_port(&imx_reg, &sport->port);
+	device_init_wakeup(&pdev->dev, false);
 
-	return uart_remove_one_port(&imx_reg, &sport->port);
+	return ret;
 }
 
 static void serial_imx_restore_context(struct imx_port *sport)
@@ -2028,6 +2099,52 @@ static void serial_imx_enable_wakeup(struct imx_port *sport, bool on)
 	writel(val, sport->port.membase + UCR1);
 }
 
+static int serial_imx_runtime_suspend(struct device *dev)
+{
+	struct imx_port *sport = dev_get_drvdata(dev);
+
+	if (!sport)
+		return -EINVAL;
+
+	/*
+	* When using 'no_console_suspend', the console UART must not be
+	* suspended. Since driver suspend is managed by runtime suspend,
+	* preventing runtime suspend (by returning error) will keep device
+	* active during suspend.
+	*/
+	if (sport->is_suspending && !console_suspend_enabled &&
+	    uart_console(&sport->port))
+		return -EBUSY;
+
+	serial_imx_save_context(sport);
+	serial_imx_enable_wakeup(sport, true);
+
+	clk_disable(sport->clk_per);
+	clk_disable(sport->clk_ipg);
+
+	return 0;
+}
+
+static int serial_imx_runtime_resume(struct device *dev)
+{
+	struct imx_port *sport = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_enable(sport->clk_per);
+	if (ret)
+		return ret;
+	ret = clk_enable(sport->clk_ipg);
+	if (ret) {
+		clk_disable(sport->clk_per);
+		return ret;
+	}
+	serial_imx_enable_wakeup(sport, false);
+
+	serial_imx_restore_context(sport);
+
+	return 0;
+}
+
 static int serial_imx_prepare(struct device *dev)
 {
 	struct imx_port *sport = dev_get_drvdata(dev);
@@ -2082,12 +2199,24 @@ static int imx_serial_port_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_prepare_enable(sport->clk_per);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(sport->clk_ipg);
+	if (ret) {
+		clk_disable_unprepare(sport->clk_per);
+		return ret;
+	}
 
 	/* enable wakeup from i.MX UART */
 	serial_imx_enable_wakeup(sport, true);
-
 	uart_suspend_port(&imx_reg, &sport->port);
 
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
+
 	return 0;
 }
 
@@ -2095,16 +2224,30 @@ static int imx_serial_port_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_prepare_enable(sport->clk_per);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(sport->clk_ipg);
+	if (ret) {
+		clk_disable_unprepare(sport->clk_per);
+		return ret;
+	}
 
 	/* disable wakeup from i.MX UART */
 	serial_imx_enable_wakeup(sport, false);
-
 	uart_resume_port(&imx_reg, &sport->port);
 
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
+
 	return 0;
 }
 
 static const struct dev_pm_ops imx_serial_port_pm_ops = {
+	SET_RUNTIME_PM_OPS(serial_imx_runtime_suspend,
+			   serial_imx_runtime_resume, NULL)
 	.suspend_noirq = imx_serial_port_suspend_noirq,
 	.resume_noirq = imx_serial_port_resume_noirq,
 	.suspend = imx_serial_port_suspend,
-- 
2.5.0
