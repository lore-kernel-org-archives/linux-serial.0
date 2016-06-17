From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH] tty: serial: msm: Add runtime PM and system sleep support
Date: Fri, 17 Jun 2016 15:46:58 +0530
Message-ID: <1466158618-6702-1-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, andy.gross@linaro.org, david.brown@linaro.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-serial@vger.kernel.org

Add runtime pm and suspend/resume callback support to serial msm
driver so that clock resources are managed runtime to save power.

Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 183 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 168 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index b7d80bd..6b5776a 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -234,8 +235,12 @@ static void msm_stop_tx(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
 	msm_port->imr &= ~UART_IMR_TXLEV;
 	msm_write(port, msm_port->imr, UART_IMR);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 static void msm_start_tx(struct uart_port *port)
@@ -247,8 +252,12 @@ static void msm_start_tx(struct uart_port *port)
 	if (dma->count)
 		return;
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
 	msm_port->imr |= UART_IMR_TXLEV;
 	msm_write(port, msm_port->imr, UART_IMR);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 static void msm_reset_dm_count(struct uart_port *port, int count)
@@ -270,6 +279,8 @@ static void msm_complete_tx_dma(void *args)
 	unsigned int count;
 	u32 val;
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Already stopped */
@@ -306,6 +317,8 @@ static void msm_complete_tx_dma(void *args)
 	msm_handle_tx(port);
 done:
 	spin_unlock_irqrestore(&port->lock, flags);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
@@ -378,6 +391,8 @@ static void msm_complete_rx_dma(void *args)
 	unsigned long flags;
 	u32 val;
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Already stopped */
@@ -433,6 +448,8 @@ done:
 
 	if (count)
 		tty_flip_buffer_push(tport);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 static void msm_start_rx_dma(struct msm_port *msm_port)
@@ -507,19 +524,28 @@ static void msm_stop_rx(struct uart_port *port)
 	struct msm_port *msm_port = UART_TO_MSM(port);
 	struct msm_dma *dma = &msm_port->rx_dma;
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
 	msm_port->imr &= ~(UART_IMR_RXLEV | UART_IMR_RXSTALE);
 	msm_write(port, msm_port->imr, UART_IMR);
 
 	if (dma->chan)
 		msm_stop_dma(port, dma);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 static void msm_enable_ms(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
+
 	msm_port->imr |= UART_IMR_DELTA_CTS;
 	msm_write(port, msm_port->imr, UART_IMR);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
@@ -766,6 +792,8 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 	unsigned int misr;
 	u32 val;
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return IRQ_NONE;
 	spin_lock_irqsave(&port->lock, flags);
 	misr = msm_read(port, UART_MISR);
 	msm_write(port, 0, UART_IMR); /* disable interrupt */
@@ -799,13 +827,25 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 
 	msm_write(port, msm_port->imr, UART_IMR); /* restore interrupt */
 	spin_unlock_irqrestore(&port->lock, flags);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 
 	return IRQ_HANDLED;
 }
 
 static unsigned int msm_tx_empty(struct uart_port *port)
 {
-	return (msm_read(port, UART_SR) & UART_SR_TX_EMPTY) ? TIOCSER_TEMT : 0;
+	int ret;
+
+	ret = pm_runtime_get_sync(port->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = msm_read(port, UART_SR) & UART_SR_TX_EMPTY ? TIOCSER_TEMT : 0;
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+
+	return ret;
 }
 
 static unsigned int msm_get_mctrl(struct uart_port *port)
@@ -834,6 +874,8 @@ static void msm_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	unsigned int mr;
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
 	mr = msm_read(port, UART_MR1);
 
 	if (!(mctrl & TIOCM_RTS)) {
@@ -844,14 +886,20 @@ static void msm_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		mr |= UART_MR1_RX_RDY_CTL;
 		msm_write(port, mr, UART_MR1);
 	}
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 static void msm_break_ctl(struct uart_port *port, int break_ctl)
 {
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
 	if (break_ctl)
 		msm_write(port, UART_CR_CMD_START_BREAK, UART_CR);
 	else
 		msm_write(port, UART_CR_CMD_STOP_BREAK, UART_CR);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 struct msm_baud_map {
@@ -992,15 +1040,6 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 	return baud;
 }
 
-static void msm_init_clock(struct uart_port *port)
-{
-	struct msm_port *msm_port = UART_TO_MSM(port);
-
-	clk_prepare_enable(msm_port->clk);
-	clk_prepare_enable(msm_port->pclk);
-	msm_serial_set_mnd_regs(port);
-}
-
 static int msm_startup(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
@@ -1015,7 +1054,22 @@ static int msm_startup(struct uart_port *port)
 	if (unlikely(ret))
 		return ret;
 
-	msm_init_clock(port);
+	/*
+	 * UART clk must be kept enabled to
+	 * avoid losing received character
+	 */
+	ret = clk_prepare_enable(msm_port->clk);
+	if (ret)
+		return ret;
+	ret = clk_prepare(msm_port->pclk);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_get_sync(port->dev);
+	if (ret < 0)
+		goto err;
+
+	msm_serial_set_mnd_regs(port);
 
 	if (likely(port->fifosize > 12))
 		rfr_level = port->fifosize - 12;
@@ -1041,19 +1095,34 @@ static int msm_startup(struct uart_port *port)
 		msm_request_rx_dma(msm_port, msm_port->uart.mapbase);
 	}
 
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+
 	return 0;
+
+err:
+	clk_unprepare(msm_port->pclk);
+	clk_disable_unprepare(msm_port->clk);
+	free_irq(port->irq, port);
+	return ret;
 }
 
 static void msm_shutdown(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
+
 	msm_port->imr = 0;
 	msm_write(port, 0, UART_IMR); /* disable interrupts */
 
 	if (msm_port->is_uartdm)
 		msm_release_dma(msm_port);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 
+	clk_unprepare(msm_port->pclk);
 	clk_disable_unprepare(msm_port->clk);
 
 	free_irq(port->irq, port);
@@ -1067,6 +1136,8 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long flags;
 	unsigned int baud, mr;
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
 	spin_lock_irqsave(&port->lock, flags);
 
 	if (dma->chan) /* Terminate if any */
@@ -1140,6 +1211,8 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 	msm_start_rx_dma(msm_port);
 
 	spin_unlock_irqrestore(&port->lock, flags);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 static const char *msm_type(struct uart_port *port)
@@ -1220,12 +1293,26 @@ static void msm_power(struct uart_port *port, unsigned int state,
 
 	switch (state) {
 	case 0:
-		clk_prepare_enable(msm_port->clk);
-		clk_prepare_enable(msm_port->pclk);
+		/*
+		 * UART clk must be kept enabled to
+		 * avoid losing received character
+		 */
+		if (clk_prepare_enable(msm_port->clk))
+			return;
+		if (clk_prepare(msm_port->pclk)) {
+			clk_disable_unprepare(msm_port->clk);
+			return;
+		}
+		if (pm_runtime_get_sync(port->dev) < 0) {
+			clk_unprepare(msm_port->pclk);
+			clk_disable_unprepare(msm_port->clk);
+			return;
+		}
 		break;
 	case 3:
+		pm_runtime_put(port->dev);
+		clk_unprepare(msm_port->pclk);
 		clk_disable_unprepare(msm_port->clk);
-		clk_disable_unprepare(msm_port->pclk);
 		break;
 	default:
 		pr_err("msm_serial: Unknown PM state %d\n", state);
@@ -1465,7 +1552,11 @@ static void msm_console_write(struct console *co, const char *s,
 	port = msm_get_port_from_line(co->index);
 	msm_port = UART_TO_MSM(port);
 
+	if (pm_runtime_get_sync(port->dev) < 0)
+		return;
 	__msm_console_write(port, s, count, msm_port->is_uartdm);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
 
 static int __init msm_console_setup(struct console *co, char *options)
@@ -1484,7 +1575,7 @@ static int __init msm_console_setup(struct console *co, char *options)
 	if (unlikely(!port->membase))
 		return -ENXIO;
 
-	msm_init_clock(port);
+	msm_serial_set_mnd_regs(port);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -1627,6 +1718,12 @@ static int msm_serial_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, port);
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+	pm_runtime_irq_safe(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+
 	return uart_add_one_port(&msm_uart_driver, port);
 }
 
@@ -1635,6 +1732,7 @@ static int msm_serial_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&msm_uart_driver, port);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
@@ -1645,12 +1743,67 @@ static const struct of_device_id msm_match_table[] = {
 	{}
 };
 
+#ifdef CONFIG_PM
+static int msm_serial_runtime_suspend(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct msm_port *msm_port = UART_TO_MSM(port);
+
+	if (msm_port->is_uartdm)
+		clk_disable(msm_port->pclk);
+
+	return 0;
+}
+
+static int msm_serial_runtime_resume(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct msm_port *msm_port = UART_TO_MSM(port);
+	int ret;
+
+	if (msm_port->is_uartdm) {
+		ret = clk_enable(msm_port->pclk);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int msm_serial_suspend(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+
+	uart_suspend_port(&msm_uart_driver, port);
+
+	return 0;
+}
+
+static int msm_serial_resume(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+
+	uart_resume_port(&msm_uart_driver, port);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops msm_serial_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(msm_serial_suspend, msm_serial_resume)
+	SET_RUNTIME_PM_OPS(msm_serial_runtime_suspend,
+				msm_serial_runtime_resume, NULL)
+};
+
 static struct platform_driver msm_platform_driver = {
 	.remove = msm_serial_remove,
 	.probe = msm_serial_probe,
 	.driver = {
 		.name = "msm_serial",
 		.of_match_table = msm_match_table,
+		.pm = &msm_serial_pm_ops,
 	},
 };
 
-- 
1.8.2.1
