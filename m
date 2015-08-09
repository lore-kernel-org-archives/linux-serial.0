From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 7/8] serial: imx: add runtime pm support
Date: Sun,  9 Aug 2015 11:19:08 -0700
Message-ID: <1439144349-10494-8-git-send-email-edubezval@gmail.com>
References: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Stevam <festevam@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
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

Cc: Fabio Stevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 209 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 163 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index def52e0..e30d8c0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -40,6 +40,8 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_wakeup.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/serial-imx.h>
@@ -220,6 +222,7 @@ struct imx_port {
 	unsigned int		saved_reg[8];
 	bool			context_saved;
 
+	struct device		*dev;
 	bool			is_suspending;
 };
 
@@ -370,6 +373,7 @@ static void imx_stop_tx(struct uart_port *port)
 	if (sport->dma_is_enabled && sport->dma_is_txing)
 		return;
 
+	pm_runtime_get_sync(sport->dev);
 	temp = readl(port->membase + UCR1);
 	writel(temp & ~UCR1_TXMPTYEN, port->membase + UCR1);
 
@@ -387,6 +391,8 @@ static void imx_stop_tx(struct uart_port *port)
 		temp &= ~UCR4_TCEN;
 		writel(temp, port->membase + UCR4);
 	}
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 /*
@@ -406,12 +412,15 @@ static void imx_stop_rx(struct uart_port *port)
 		}
 	}
 
+	pm_runtime_get_sync(sport->dev);
 	temp = readl(sport->port.membase + UCR2);
 	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
 
 	/* disable the `Receiver Ready Interrrupt` */
 	temp = readl(sport->port.membase + UCR1);
 	writel(temp & ~UCR1_RRDYEN, sport->port.membase + UCR1);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 /*
@@ -483,6 +492,7 @@ static void dma_tx_callback(void *data)
 	unsigned long flags;
 	unsigned long temp;
 
+	pm_runtime_get_sync(sport->dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
@@ -507,13 +517,17 @@ static void dma_tx_callback(void *data)
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
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 static void imx_dma_tx(struct imx_port *sport)
@@ -580,6 +594,7 @@ static void imx_start_tx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
+	pm_runtime_get_sync(sport->dev);
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		/* enable transmitter and shifter empty irq */
 		temp = readl(port->membase + UCR2);
@@ -607,14 +622,18 @@ static void imx_start_tx(struct uart_port *port)
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
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 static irqreturn_t imx_rtsint(int irq, void *dev_id)
@@ -623,6 +642,7 @@ static irqreturn_t imx_rtsint(int irq, void *dev_id)
 	unsigned int val;
 	unsigned long flags;
 
+	pm_runtime_get_sync(sport->dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	writel(USR1_RTSD, sport->port.membase + USR1);
@@ -631,6 +651,9 @@ static irqreturn_t imx_rtsint(int irq, void *dev_id)
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
+
 	return IRQ_HANDLED;
 }
 
@@ -639,9 +662,13 @@ static irqreturn_t imx_txint(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned long flags;
 
+	pm_runtime_get_sync(sport->dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 	imx_transmit_buffer(sport);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
+
 	return IRQ_HANDLED;
 }
 
@@ -652,6 +679,7 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags, temp;
 
+	pm_runtime_get_sync(sport->dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	while (readl(sport->port.membase + USR2) & USR2_RDR) {
@@ -711,6 +739,8 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 	tty_flip_buffer_push(port);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 	return IRQ_HANDLED;
 }
 
@@ -748,6 +778,7 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	unsigned int sts;
 	unsigned int sts2;
 
+	pm_runtime_get_sync(sport->dev);
 	sts = readl(sport->port.membase + USR1);
 	sts2 = readl(sport->port.membase + USR2);
 
@@ -775,6 +806,8 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 		sport->port.icount.overrun++;
 		writel(USR2_ORE, sport->port.membase + USR2);
 	}
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 
 	return IRQ_HANDLED;
 }
@@ -787,11 +820,14 @@ static unsigned int imx_tx_empty(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned int ret;
 
+	pm_runtime_get_sync(sport->dev);
 	ret = (readl(sport->port.membase + USR2) & USR2_TXDC) ?  TIOCSER_TEMT : 0;
 
 	/* If the TX DMA is working, return 0. */
 	if (sport->dma_is_enabled && sport->dma_is_txing)
 		ret = 0;
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 
 	return ret;
 }
@@ -804,6 +840,7 @@ static unsigned int imx_get_mctrl(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned int tmp = TIOCM_DSR | TIOCM_CAR;
 
+	pm_runtime_get_sync(sport->dev);
 	if (readl(sport->port.membase + USR1) & USR1_RTSS)
 		tmp |= TIOCM_CTS;
 
@@ -812,6 +849,8 @@ static unsigned int imx_get_mctrl(struct uart_port *port)
 
 	if (readl(sport->port.membase + uts_reg(sport)) & UTS_LOOP)
 		tmp |= TIOCM_LOOP;
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 
 	return tmp;
 }
@@ -821,6 +860,7 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
+	pm_runtime_get_sync(sport->dev);
 	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
 		temp = readl(sport->port.membase + UCR2);
 		temp &= ~(UCR2_CTS | UCR2_CTSC);
@@ -833,6 +873,8 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (mctrl & TIOCM_LOOP)
 		temp |= UTS_LOOP;
 	writel(temp, sport->port.membase + uts_reg(sport));
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 /*
@@ -843,6 +885,7 @@ static void imx_break_ctl(struct uart_port *port, int break_state)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags, temp;
 
+	pm_runtime_get_sync(sport->dev);
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	temp = readl(sport->port.membase + UCR1) & ~UCR1_SNDBRK;
@@ -853,6 +896,8 @@ static void imx_break_ctl(struct uart_port *port, int break_state)
 	writel(temp, sport->port.membase + UCR1);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 #define TXTL 2 /* reset default */
@@ -910,6 +955,7 @@ static void dma_rx_callback(void *data)
 	enum dma_status status;
 	unsigned int count;
 
+	pm_runtime_get_sync(sport->dev);
 	/* unmap it first */
 	dma_unmap_sg(sport->port.dev, sgl, 1, DMA_FROM_DEVICE);
 
@@ -946,6 +992,8 @@ static void dma_rx_callback(void *data)
 		 */
 		imx_rx_dma_done(sport);
 	}
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 static int start_rx_dma(struct imx_port *sport)
@@ -1101,18 +1149,10 @@ static void imx_disable_dma(struct imx_port *sport)
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
+	pm_runtime_get_sync(sport->dev);
 	imx_setup_ufcr(sport, 0);
 
 	/* disable the DREN bit (Data Ready interrupt enable) before
@@ -1169,6 +1209,8 @@ static int imx_startup(struct uart_port *port)
 	 */
 	imx_enable_ms(&sport->port);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 
 	return 0;
 }
@@ -1179,6 +1221,7 @@ static void imx_shutdown(struct uart_port *port)
 	unsigned long temp;
 	unsigned long flags;
 
+	pm_runtime_get_sync(sport->dev);
 	if (sport->dma_is_enabled) {
 		int ret;
 
@@ -1221,8 +1264,8 @@ static void imx_shutdown(struct uart_port *port)
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable_unprepare(sport->clk_per);
-	clk_disable_unprepare(sport->clk_ipg);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 static void imx_flush_buffer(struct uart_port *port)
@@ -1235,6 +1278,7 @@ static void imx_flush_buffer(struct uart_port *port)
 	if (!sport->dma_chan_tx)
 		return;
 
+	pm_runtime_get_sync(sport->dev);
 	sport->tx_bytes = 0;
 	dmaengine_terminate_all(sport->dma_chan_tx);
 	if (sport->dma_is_txing) {
@@ -1268,6 +1312,8 @@ static void imx_flush_buffer(struct uart_port *port)
 	writel(ubir, sport->port.membase + UBIR);
 	writel(ubmr, sport->port.membase + UBMR);
 	writel(uts, sport->port.membase + IMX21_UTS);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 static void
@@ -1282,6 +1328,7 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long num, denom;
 	uint64_t tdiv64;
 
+	pm_runtime_get_sync(sport->dev);
 	/*
 	 * We only support CS7 and CS8.
 	 */
@@ -1437,6 +1484,8 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (sport->dma_is_inited && !sport->dma_is_enabled)
 		imx_enable_dma(sport);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 static const char *imx_type(struct uart_port *port)
@@ -1494,13 +1543,7 @@ static int imx_poll_init(struct uart_port *port)
 	unsigned long temp;
 	int retval;
 
-	retval = clk_prepare_enable(sport->clk_ipg);
-	if (retval)
-		return retval;
-	retval = clk_prepare_enable(sport->clk_per);
-	if (retval)
-		clk_disable_unprepare(sport->clk_ipg);
-
+	pm_runtime_get_sync(sport->dev);
 	imx_setup_ufcr(sport, 0);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
@@ -1517,22 +1560,34 @@ static int imx_poll_init(struct uart_port *port)
 	writel(temp, sport->port.membase + UCR2);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 
 	return 0;
 }
 
 static int imx_poll_get_char(struct uart_port *port)
 {
-	if (!(readl_relaxed(port->membase + USR2) & USR2_RDR))
-		return NO_POLL_CHAR;
+	int ret;
+
+	pm_runtime_get_sync(sport->dev);
+	if (!(readl_relaxed(port->membase + USR2) & USR2_RDR)) {
+		ret = NO_POLL_CHAR;
+		goto mark_last;
+	}
 
-	return readl_relaxed(port->membase + URXD0) & URXD_RX_DATA;
+	ret = readl_relaxed(port->membase + URXD0) & URXD_RX_DATA;
+
+mark_last:
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 static void imx_poll_put_char(struct uart_port *port, unsigned char c)
 {
 	unsigned int status;
 
+	pm_runtime_get_sync(sport->dev);
 	/* drain */
 	do {
 		status = readl_relaxed(port->membase + USR1);
@@ -1545,6 +1600,8 @@ static void imx_poll_put_char(struct uart_port *port, unsigned char c)
 	do {
 		status = readl_relaxed(port->membase + USR2);
 	} while (~status & USR2_TXDC);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 #endif
 
@@ -1565,6 +1622,7 @@ static int imx_rs485_config(struct uart_port *port,
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		unsigned long temp;
 
+		pm_runtime_get_sync(sport->dev);
 		/* disable transmitter */
 		temp = readl(sport->port.membase + UCR2);
 		temp &= ~UCR2_CTSC;
@@ -1573,6 +1631,8 @@ static int imx_rs485_config(struct uart_port *port,
 		else
 			temp |= UCR2_CTS;
 		writel(temp, sport->port.membase + UCR2);
+		pm_runtime_mark_last_busy(sport->dev);
+		pm_runtime_put_autosuspend(sport->dev);
 	}
 
 	port->rs485 = *rs485conf;
@@ -1627,17 +1687,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
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
 
+	pm_runtime_get_sync(sport->dev);
 	if (sport->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
@@ -1673,8 +1724,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable_unprepare(sport->clk_ipg);
-	clk_disable_unprepare(sport->clk_per);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 }
 
 /*
@@ -1761,10 +1812,7 @@ imx_console_setup(struct console *co, char *options)
 	if (sport == NULL)
 		return -ENODEV;
 
-	/* For setting the registers, we only need to enable the ipg clock. */
-	retval = clk_prepare_enable(sport->clk_ipg);
-	if (retval)
-		goto error_console;
+	pm_runtime_get_sync(sport->dev);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -1775,9 +1823,8 @@ imx_console_setup(struct console *co, char *options)
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
-	clk_disable_unprepare(sport->clk_ipg);
-
-error_console:
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
 	return retval;
 }
 
@@ -1881,6 +1928,8 @@ static int serial_imx_suspend(struct device *dev)
 	serial_imx_enable_wakeup(sport, true);
 
 	uart_suspend_port(&imx_reg, &sport->port);
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
 
 	return 0;
 }
@@ -1889,6 +1938,8 @@ static int serial_imx_resume(struct device *dev)
 {
 	struct imx_port *sport = dev_get_drvdata(dev);
 
+	clk_prepare_enable(sport->clk_per);
+	clk_prepare_enable(sport->clk_ipg);
 	/* disable wakeup from i.MX UART */
 	serial_imx_enable_wakeup(sport, false);
 
@@ -2037,20 +2088,86 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	imx_ports[sport->port.line] = sport;
 
+	sport->dev = &pdev->dev;
 	platform_set_drvdata(pdev, sport);
 
-	return uart_add_one_port(&imx_reg, &sport->port);
+	device_init_wakeup(sport->dev, true);
+	pm_runtime_use_autosuspend(sport->dev);
+	pm_runtime_set_autosuspend_delay(sport->dev, 5000);
+
+	pm_runtime_irq_safe(sport->dev);
+	pm_runtime_enable(sport->dev);
+
+	clk_prepare(sport->clk_per);
+	clk_prepare(sport->clk_ipg);
+	pm_runtime_get_sync(sport->dev);
+	ret = uart_add_one_port(&imx_reg, &sport->port);
+	pm_runtime_mark_last_busy(sport->dev);
+	pm_runtime_put_autosuspend(sport->dev);
+
+	return ret;
 }
 
 static int serial_imx_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
+
+	pm_runtime_put_sync(sport->dev);
+	pm_runtime_disable(sport->dev);
+	clk_unprepare(sport->clk_per);
+	clk_unprepare(sport->clk_ipg);
+	ret = uart_remove_one_port(&imx_reg, &sport->port);
+	device_init_wakeup(&pdev->dev, false);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM
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
 
-	return uart_remove_one_port(&imx_reg, &sport->port);
+	clk_disable(sport->clk_per);
+	clk_disable(sport->clk_ipg);
+
+	return 0;
 }
 
+static int serial_imx_runtime_resume(struct device *dev)
+{
+	struct imx_port *sport = dev_get_drvdata(dev);
+
+	clk_enable(sport->clk_per);
+	clk_enable(sport->clk_ipg);
+	serial_imx_enable_wakeup(sport, false);
+
+	serial_imx_restore_context(sport);
+
+	return 0;
+}
+#endif
+
 static const struct dev_pm_ops serial_imx_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(serial_imx_suspend, serial_imx_resume)
+	SET_RUNTIME_PM_OPS(serial_imx_runtime_suspend,
+			   serial_imx_runtime_resume, NULL)
 	.prepare        = serial_imx_prepare,
 	.complete       = serial_imx_complete,
 };
-- 
2.5.0
