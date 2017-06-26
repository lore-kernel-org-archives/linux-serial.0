From: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 15/20] serial: stm32: Add wakeup mechanism
Date: Mon, 26 Jun 2017 12:49:15 +0000
Message-ID: <1498481318-1894-16-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>

Add support for wake-up from low power modes. This extends stm32f7.
Introduce new compatible for stm32h7 to manage wake-up capability.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
---
 drivers/tty/serial/stm32-usart.c | 90 +++++++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h | 29 +++++++++++++
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index a62fc95..05d89b0 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -25,6 +25,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/spinlock.h>
@@ -374,6 +375,10 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 		writel_relaxed(USART_ICR_RTOCF,
 			       port->membase + ofs->icr);
 
+	if ((sr & USART_SR_WUF) && (ofs->icr != UNDEF_REG))
+		writel_relaxed(USART_ICR_WUCF,
+			       port->membase + ofs->icr);
+
 	if ((sr & USART_SR_RXNE) && !(stm32_port->rx_ch))
 		stm32_receive_chars(port, false);
 
@@ -526,6 +531,7 @@ static int stm32_startup(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	const char *name = to_platform_device(port->dev)->name;
 	u32 val;
 	int ret;
@@ -536,6 +542,15 @@ static int stm32_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
+	if (cfg->has_wakeup && stm32_port->wakeirq >= 0) {
+		ret = dev_pm_set_dedicated_wake_irq(port->dev,
+						    stm32_port->wakeirq);
+		if (ret) {
+			free_irq(port->irq, port);
+			return ret;
+		}
+	}
+
 	val = stm32_port->rx_irq | USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
 		val |= USART_CR1_FIFOEN;
@@ -558,6 +573,7 @@ static void stm32_shutdown(struct uart_port *port)
 		val |= USART_CR1_FIFOEN;
 	stm32_clr_bits(port, ofs->cr1, val);
 
+	dev_pm_clear_wake_irq(port->dev);
 	free_irq(port->irq, port);
 }
 
@@ -758,6 +774,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
 	port->irq	= platform_get_irq(pdev, 0);
+	stm32port->wakeirq = platform_get_irq(pdev, 1);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
@@ -819,6 +836,8 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 	{ .compatible = "st,stm32-uart", .data = &stm32f4_info},
 	{ .compatible = "st,stm32f7-usart", .data = &stm32f7_info},
 	{ .compatible = "st,stm32f7-uart", .data = &stm32f7_info},
+	{ .compatible = "st,stm32h7-usart", .data = &stm32h7_info},
+	{ .compatible = "st,stm32h7-uart", .data = &stm32h7_info},
 	{},
 };
 
@@ -964,9 +983,15 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0) {
+		ret = device_init_wakeup(&pdev->dev, true);
+		if (ret)
+			goto err_uninit;
+	}
+
 	ret = uart_add_one_port(&stm32_usart_driver, &stm32port->port);
 	if (ret)
-		goto err_uninit;
+		goto err_nowup;
 
 	ret = stm32_of_dma_rx_probe(stm32port, pdev);
 	if (ret)
@@ -980,6 +1005,10 @@ static int stm32_serial_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_nowup:
+	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0)
+		device_init_wakeup(&pdev->dev, false);
+
 err_uninit:
 	clk_disable_unprepare(stm32port->clk);
 
@@ -991,6 +1020,7 @@ static int stm32_serial_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 
 	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
@@ -1016,6 +1046,9 @@ static int stm32_serial_remove(struct platform_device *pdev)
 				  TX_BUF_L, stm32_port->tx_buf,
 				  stm32_port->tx_dma_buf);
 
+	if (cfg->has_wakeup && stm32_port->wakeirq >= 0)
+		device_init_wakeup(&pdev->dev, false);
+
 	clk_disable_unprepare(stm32_port->clk);
 
 	stm32_serial_debugfs_rm(stm32_port);
@@ -1123,11 +1156,66 @@ static int stm32_console_setup(struct console *co, char *options)
 	.cons		= STM32_SERIAL_CONSOLE,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static void stm32_serial_enable_wakeup(struct uart_port *port, bool enable)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	u32 val;
+
+	if (!cfg->has_wakeup || stm32_port->wakeirq < 0)
+		return;
+
+	if (enable) {
+		stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
+		stm32_set_bits(port, ofs->cr1, USART_CR1_UESM);
+		val = readl_relaxed(port->membase + ofs->cr3);
+		val &= ~USART_CR3_WUS_MASK;
+		/* Enable Wake up interrupt from low power on start bit */
+		val |= USART_CR3_WUS_START_BIT | USART_CR3_WUFIE;
+		writel_relaxed(val, port->membase + ofs->cr3);
+		stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
+	} else {
+		stm32_clr_bits(port, ofs->cr1, USART_CR1_UESM);
+	}
+}
+
+static int stm32_serial_suspend(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+
+	uart_suspend_port(&stm32_usart_driver, port);
+
+	if (device_may_wakeup(dev))
+		stm32_serial_enable_wakeup(port, true);
+	else
+		stm32_serial_enable_wakeup(port, false);
+
+	return 0;
+}
+
+static int stm32_serial_resume(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		stm32_serial_enable_wakeup(port, false);
+
+	return uart_resume_port(&stm32_usart_driver, port);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_serial_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_serial_suspend, stm32_serial_resume)
+};
+
 static struct platform_driver stm32_serial_driver = {
 	.probe		= stm32_serial_probe,
 	.remove		= stm32_serial_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
+		.pm	= &stm32_serial_pm_ops,
 		.of_match_table = of_match_ptr(stm32_match),
 	},
 };
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 056a837..98dbf38 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -24,6 +24,7 @@ struct stm32_usart_offsets {
 struct stm32_usart_config {
 	u8 uart_enable_bit; /* USART_CR1_UE */
 	bool has_7bits_data;
+	bool has_wakeup;
 };
 
 struct stm32_usart_info {
@@ -74,6 +75,27 @@ struct stm32_usart_info stm32f7_info = {
 	}
 };
 
+struct stm32_usart_info stm32h7_info = {
+	.ofs = {
+		.cr1	= 0x00,
+		.cr2	= 0x04,
+		.cr3	= 0x08,
+		.brr	= 0x0c,
+		.gtpr	= 0x10,
+		.rtor	= 0x14,
+		.rqr	= 0x18,
+		.isr	= 0x1c,
+		.icr	= 0x20,
+		.rdr	= 0x24,
+		.tdr	= 0x28,
+	},
+	.cfg = {
+		.uart_enable_bit = 0,
+		.has_7bits_data = true,
+		.has_wakeup = true,
+	}
+};
+
 /* USART_SR (F4) / USART_ISR (F7) */
 #define USART_SR_PE		BIT(0)
 #define USART_SR_FE		BIT(1)
@@ -93,6 +115,7 @@ struct stm32_usart_info stm32f7_info = {
 #define USART_SR_BUSY		BIT(16)		/* F7 */
 #define USART_SR_CMF		BIT(17)		/* F7 */
 #define USART_SR_SBKF		BIT(18)		/* F7 */
+#define USART_SR_WUF		BIT(20)		/* H7 */
 #define USART_SR_TEACK		BIT(21)		/* F7 */
 #define USART_SR_ERR_MASK	(USART_SR_LBD | USART_SR_ORE | \
 				 USART_SR_FE | USART_SR_PE)
@@ -113,6 +136,7 @@ struct stm32_usart_info stm32f7_info = {
 /* USART_CR1 */
 #define USART_CR1_SBK		BIT(0)
 #define USART_CR1_RWU		BIT(1)		/* F4 */
+#define USART_CR1_UESM		BIT(1)		/* H7 */
 #define USART_CR1_RE		BIT(2)
 #define USART_CR1_TE		BIT(3)
 #define USART_CR1_IDLEIE	BIT(4)
@@ -176,6 +200,9 @@ struct stm32_usart_info stm32f7_info = {
 #define USART_CR3_DEM		BIT(14)		/* F7 */
 #define USART_CR3_DEP		BIT(15)		/* F7 */
 #define USART_CR3_SCARCNT_MASK	GENMASK(19, 17)	/* F7 */
+#define USART_CR3_WUS_MASK	GENMASK(21, 20)	/* H7 */
+#define USART_CR3_WUS_START_BIT	BIT(21)		/* H7 */
+#define USART_CR3_WUFIE		BIT(22)		/* H7 */
 
 /* USART_GTPR */
 #define USART_GTPR_PSC_MASK	GENMASK(7, 0)
@@ -204,6 +231,7 @@ struct stm32_usart_info stm32f7_info = {
 #define USART_ICR_RTOCF		BIT(11)		/* F7 */
 #define USART_ICR_EOBCF		BIT(12)		/* F7 */
 #define USART_ICR_CMCF		BIT(17)		/* F7 */
+#define USART_ICR_WUCF		BIT(20)		/* H7 */
 
 #define STM32_SERIAL_NAME "ttyS"
 #define STM32_MAX_PORTS 8
@@ -230,6 +258,7 @@ struct stm32_port {
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
 	bool fifoen;
+	int wakeirq;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
