From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 8/9] serial: stm32: add wakeup mechanism
Date: Thu, 13 Jul 2017 15:08:30 +0000
Message-ID: <1499958494-19354-9-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Add support for wake-up from low power modes. This extends stm32f7.
Introduce new compatible for stm32h7 to manage wake-up capability.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 90 +++++++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h | 29 +++++++++++++
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 413ff49..684cbe3 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -26,6 +26,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/spinlock.h>
@@ -326,6 +327,10 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
+	if ((sr & USART_SR_WUF) && (ofs->icr != UNDEF_REG))
+		writel_relaxed(USART_ICR_WUCF,
+			       port->membase + ofs->icr);
+
 	if ((sr & USART_SR_RXNE) && !(stm32_port->rx_ch))
 		stm32_receive_chars(port, false);
 
@@ -442,6 +447,7 @@ static int stm32_startup(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	const char *name = to_platform_device(port->dev)->name;
 	u32 val;
 	int ret;
@@ -452,6 +458,15 @@ static int stm32_startup(struct uart_port *port)
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
 	val = USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
 	stm32_set_bits(port, ofs->cr1, val);
 
@@ -469,6 +484,7 @@ static void stm32_shutdown(struct uart_port *port)
 	val |= BIT(cfg->uart_enable_bit);
 	stm32_clr_bits(port, ofs->cr1, val);
 
+	dev_pm_clear_wake_irq(port->dev);
 	free_irq(port->irq, port);
 }
 
@@ -659,6 +675,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
 	port->irq	= platform_get_irq(pdev, 0);
+	stm32port->wakeirq = platform_get_irq(pdev, 1);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
@@ -716,6 +733,8 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 	{ .compatible = "st,stm32-uart", .data = &stm32f4_info},
 	{ .compatible = "st,stm32f7-usart", .data = &stm32f7_info},
 	{ .compatible = "st,stm32f7-uart", .data = &stm32f7_info},
+	{ .compatible = "st,stm32h7-usart", .data = &stm32h7_info},
+	{ .compatible = "st,stm32h7-uart", .data = &stm32h7_info},
 	{},
 };
 
@@ -865,9 +884,15 @@ static int stm32_serial_probe(struct platform_device *pdev)
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
@@ -881,6 +906,10 @@ static int stm32_serial_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_nowup:
+	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0)
+		device_init_wakeup(&pdev->dev, false);
+
 err_uninit:
 	clk_disable_unprepare(stm32port->clk);
 
@@ -892,6 +921,7 @@ static int stm32_serial_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 
 	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
@@ -913,6 +943,9 @@ static int stm32_serial_remove(struct platform_device *pdev)
 				  TX_BUF_L, stm32_port->tx_buf,
 				  stm32_port->tx_dma_buf);
 
+	if (cfg->has_wakeup && stm32_port->wakeirq >= 0)
+		device_init_wakeup(&pdev->dev, false);
+
 	clk_disable_unprepare(stm32_port->clk);
 
 	return uart_remove_one_port(&stm32_usart_driver, port);
@@ -1018,11 +1051,66 @@ static int stm32_console_setup(struct console *co, char *options)
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
index 6092789..5984a66 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -25,6 +25,7 @@ struct stm32_usart_offsets {
 struct stm32_usart_config {
 	u8 uart_enable_bit; /* USART_CR1_UE */
 	bool has_7bits_data;
+	bool has_wakeup;
 };
 
 struct stm32_usart_info {
@@ -75,6 +76,27 @@ struct stm32_usart_info stm32f7_info = {
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
@@ -94,6 +116,7 @@ struct stm32_usart_info stm32f7_info = {
 #define USART_SR_BUSY		BIT(16)		/* F7 */
 #define USART_SR_CMF		BIT(17)		/* F7 */
 #define USART_SR_SBKF		BIT(18)		/* F7 */
+#define USART_SR_WUF		BIT(20)		/* H7 */
 #define USART_SR_TEACK		BIT(21)		/* F7 */
 #define USART_SR_ERR_MASK	(USART_SR_LBD | USART_SR_ORE | \
 				 USART_SR_FE | USART_SR_PE)
@@ -114,6 +137,7 @@ struct stm32_usart_info stm32f7_info = {
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
@@ -225,6 +253,7 @@ struct stm32_port {
 	int last_res;
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
+	int wakeirq;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
1.9.1
