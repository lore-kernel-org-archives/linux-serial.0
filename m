From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 2/4] serial: mxs-auart: add interrupts for modem control lines
Date: Fri, 19 Sep 2014 20:08:54 +0200
Message-ID: <1411150136-30791-2-git-send-email-j.uzycki@elproma.com.pl>
References: <1411150136-30791-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:58752 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932117AbaISSGh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 14:06:37 -0400
In-Reply-To: <1411150136-30791-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

Handle CTS/DSR/RI/DCD GPIO interrupts in mxs-auart.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 146 ++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4690200..c2f24f8 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -38,7 +38,10 @@
 
 #include <asm/cacheflush.h>
 
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 #include "serial_mctrl_gpio.h"
 
 #define MXS_AUART_MAJOR 242
@@ -161,6 +164,8 @@ struct mxs_auart_port {
 	void *rx_dma_buf;
 
 	struct mctrl_gpios	*gpios;
+	int			gpio_irq[UART_GPIO_MAX];
+	bool			ms_irq_enabled;
 };
 
 static struct platform_device_id mxs_auart_devtype[] = {
@@ -478,6 +483,64 @@ static u32 mxs_auart_get_mctrl(struct uart_port *u)
 			mctrl_gpio_get(s->gpios, &mctrl));
 }
 
+/*
+ * Enable modem status interrupts
+ */
+static void mxs_auart_enable_ms(struct uart_port *port)
+{
+	struct mxs_auart_port *s = to_auart_port(port);
+
+	/*
+	 * Interrupt should not be enabled twice
+	 */
+	if (s->ms_irq_enabled)
+		return;
+
+	s->ms_irq_enabled = true;
+
+	if (s->gpio_irq[UART_GPIO_CTS] >= 0)
+		enable_irq(s->gpio_irq[UART_GPIO_CTS]);
+	/* otherwise: shouldn't be AUART_INTR_CTSMIEN enabled here? (FIXME) */
+
+	if (s->gpio_irq[UART_GPIO_DSR] >= 0)
+		enable_irq(s->gpio_irq[UART_GPIO_DSR]);
+
+	if (s->gpio_irq[UART_GPIO_RI] >= 0)
+		enable_irq(s->gpio_irq[UART_GPIO_RI]);
+
+	if (s->gpio_irq[UART_GPIO_DCD] >= 0)
+		enable_irq(s->gpio_irq[UART_GPIO_DCD]);
+}
+
+/*
+ * Disable modem status interrupts
+ */
+static void mxs_auart_disable_ms(struct uart_port *port)
+{
+	struct mxs_auart_port *s = to_auart_port(port);
+
+	/*
+	 * Interrupt should not be disabled twice
+	 */
+	if (!s->ms_irq_enabled)
+		return;
+
+	s->ms_irq_enabled = false;
+
+	if (s->gpio_irq[UART_GPIO_CTS] >= 0)
+		disable_irq(s->gpio_irq[UART_GPIO_CTS]);
+	/* otherwise: shouldn't be AUART_INTR_CTSMIEN disabled here? (FIXME) */
+
+	if (s->gpio_irq[UART_GPIO_DSR] >= 0)
+		disable_irq(s->gpio_irq[UART_GPIO_DSR]);
+
+	if (s->gpio_irq[UART_GPIO_RI] >= 0)
+		disable_irq(s->gpio_irq[UART_GPIO_RI]);
+
+	if (s->gpio_irq[UART_GPIO_DCD] >= 0)
+		disable_irq(s->gpio_irq[UART_GPIO_DCD]);
+}
+
 static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s);
 static void dma_rx_callback(void *arg)
 {
@@ -726,6 +789,12 @@ static void mxs_auart_settermios(struct uart_port *u,
 			dev_err(s->dev, "We can not start up the DMA.\n");
 		}
 	}
+
+	/* CTS flow-control and modem-status interrupts */
+	if (UART_ENABLE_MS(u, termios->c_cflag))
+		mxs_auart_enable_ms(u);
+	else
+		mxs_auart_disable_ms(u);
 }
 
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
@@ -743,8 +812,15 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 		| AUART_INTR_CTSMIS),
 			s->port.membase + AUART_INTR_CLR);
 
-	mxs_auart_modem_status(s,
-			mctrl_gpio_get(s->gpios, &s->ctrl));
+	/*
+	 * Dealing with GPIO interrupt
+	 */
+	if (irq == s->gpio_irq[UART_GPIO_CTS] ||
+	    irq == s->gpio_irq[UART_GPIO_DCD] ||
+	    irq == s->gpio_irq[UART_GPIO_DSR] ||
+	    irq == s->gpio_irq[UART_GPIO_RI])
+		mxs_auart_modem_status(s,
+				mctrl_gpio_get(s->gpios, &s->ctrl));
 
 	if (istat & AUART_INTR_CTSMIS) {
 		if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
@@ -813,6 +889,8 @@ static int mxs_auart_startup(struct uart_port *u)
 
 	/* get initial status of modem lines */
 	mctrl_gpio_get(s->gpios, &s->ctrl);
+
+	s->ms_irq_enabled = false;
 	return 0;
 }
 
@@ -820,6 +898,8 @@ static void mxs_auart_shutdown(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
 
+	mxs_auart_disable_ms(u);
+
 	if (auart_dma_enabled(s))
 		mxs_auart_dma_exit(s);
 
@@ -876,6 +956,7 @@ static struct uart_ops mxs_auart_ops = {
 	.start_tx       = mxs_auart_start_tx,
 	.stop_tx	= mxs_auart_stop_tx,
 	.stop_rx	= mxs_auart_stop_rx,
+	.enable_ms      = mxs_auart_enable_ms,
 	.break_ctl      = mxs_auart_break_ctl,
 	.set_mctrl	= mxs_auart_set_mctrl,
 	.get_mctrl      = mxs_auart_get_mctrl,
@@ -1078,12 +1159,61 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 
 static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
 {
+	enum mctrl_gpio_idx i;
+	struct gpio_desc *gpiod;
+
 	s->gpios = mctrl_gpio_init(dev, 0);
 	if (IS_ERR_OR_NULL(s->gpios))
 		return -1;
+
+	for (i = 0; i < UART_GPIO_MAX; i++) {
+		gpiod = mctrl_gpio_to_gpiod(s->gpios, i);
+		if (gpiod && (gpiod_get_direction(gpiod) == GPIOF_DIR_IN))
+			s->gpio_irq[i] = gpiod_to_irq(gpiod);
+		else
+			s->gpio_irq[i] = -EINVAL;
+	}
+
 	return 0;
 }
 
+static void mxs_auart_free_gpio_irq(struct mxs_auart_port *s)
+{
+	enum mctrl_gpio_idx i;
+
+	for (i = 0; i < UART_GPIO_MAX; i++)
+		if (s->gpio_irq[i] >= 0)
+			free_irq(s->gpio_irq[i], s);
+}
+
+static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
+{
+	int *irq = s->gpio_irq;
+	enum mctrl_gpio_idx i;
+	int err = 0;
+
+	for (i = 0; (i < UART_GPIO_MAX) && !err; i++) {
+		if (irq[i] < 0)
+			continue;
+
+		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
+		err = request_irq(irq[i], mxs_auart_irq_handle,
+				IRQ_TYPE_EDGE_BOTH, dev_name(s->dev), s);
+		if (err)
+			dev_err(s->dev, "%s - Can't get %d irq\n",
+				__func__, irq[i]);
+	}
+
+	/*
+	 * If something went wrong, rollback.
+	 */
+	while (err && (--i >= 0))
+		if (irq[i] >= 0)
+			free_irq(irq[i], s);
+
+	return err;
+}
+
 static int mxs_auart_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -1146,13 +1276,20 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s",
 			"Failed to initialize GPIOs. The serial port may not work as expected");
 
+	/*
+	 * Get the GPIO lines IRQ
+	 */
+	ret = mxs_auart_request_gpio_irq(s);
+	if (ret)
+		goto out_free_irq;
+
 	auart_port[s->port.line] = s;
 
 	mxs_auart_reset(&s->port);
 
 	ret = uart_add_one_port(&auart_driver, &s->port);
 	if (ret)
-		goto out_free_irq;
+		goto out_free_gpio_irq;
 
 	version = readl(s->port.membase + AUART_VERSION);
 	dev_info(&pdev->dev, "Found APPUART %d.%d.%d\n",
@@ -1161,6 +1298,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	return 0;
 
+out_free_gpio_irq:
+	mxs_auart_free_gpio_irq(s);
 out_free_irq:
 	mctrl_gpio_free(&pdev->dev, s->gpios);	/*useless?*/
 	auart_port[pdev->id] = NULL;
@@ -1181,6 +1320,7 @@ static int mxs_auart_remove(struct platform_device *pdev)
 
 	auart_port[pdev->id] = NULL;
 
+	mxs_auart_free_gpio_irq(s);
 	mctrl_gpio_free(&pdev->dev, s->gpios);	/*useless?*/
 
 	clk_put(s->clk);
-- 
1.7.11.3

