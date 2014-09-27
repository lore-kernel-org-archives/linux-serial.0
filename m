From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 3/4] serial: mxs-auart: add interrupts for modem control lines
Date: Sat, 27 Sep 2014 11:46:36 +0200
Message-ID: <1411811197-12638-4-git-send-email-j.uzycki@elproma.com.pl>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:51227 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752614AbaI0JoT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Sep 2014 05:44:19 -0400
In-Reply-To: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

Handle CTS/DSR/RI/DCD GPIO interrupts in mxs-auart.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 176 ++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index fdfa8a9..ab127a2 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -42,7 +42,10 @@
 
 #include <asm/cacheflush.h>
 
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 #include "serial_mctrl_gpio.h"
 
 #define MXS_AUART_PORTS 5
@@ -146,6 +149,7 @@ struct mxs_auart_port {
 #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
 #define MXS_AUART_RTSCTS	4  /* bit 4 */
 	unsigned long flags;
+	unsigned int mctrl_prev;
 	enum mxs_auart_type devtype;
 
 	unsigned int irq;
@@ -163,6 +167,8 @@ struct mxs_auart_port {
 	void *rx_dma_buf;
 
 	struct mctrl_gpios	*gpios;
+	int			gpio_irq[UART_GPIO_MAX];
+	bool			ms_irq_enabled;
 };
 
 static struct platform_device_id mxs_auart_devtype[] = {
@@ -427,6 +433,29 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 	mctrl_gpio_set(s->gpios, mctrl);
 }
 
+#define MCTRL_ANY_DELTA        (TIOCM_RI | TIOCM_DSR | TIOCM_CD | TIOCM_CTS)
+static u32 mxs_auart_modem_status(struct mxs_auart_port *s, u32 mctrl)
+{
+	u32 mctrl_diff;
+
+	mctrl_diff = mctrl ^ s->mctrl_prev;
+	s->mctrl_prev = mctrl;
+	if (mctrl_diff & MCTRL_ANY_DELTA && s->ms_irq_enabled &&
+						s->port.state != NULL) {
+		if (mctrl_diff & TIOCM_RI)
+			s->port.icount.rng++;
+		if (mctrl_diff & TIOCM_DSR)
+			s->port.icount.dsr++;
+		if (mctrl_diff & TIOCM_CD)
+			uart_handle_dcd_change(&s->port, mctrl & TIOCM_CD);
+		if (mctrl_diff & TIOCM_CTS)
+			uart_handle_cts_change(&s->port, mctrl & TIOCM_CTS);
+
+		wake_up_interruptible(&s->port.state->port.delta_msr_wait);
+	}
+	return mctrl;
+}
+
 static u32 mxs_auart_get_mctrl(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
@@ -444,6 +473,64 @@ static u32 mxs_auart_get_mctrl(struct uart_port *u)
 	return mctrl_gpio_get(s->gpios, &mctrl);
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
+	/* TODO: enable AUART_INTR_CTSMIEN otherwise */
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
+	/* TODO: disable AUART_INTR_CTSMIEN otherwise */
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
@@ -692,6 +779,12 @@ static void mxs_auart_settermios(struct uart_port *u,
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
@@ -709,9 +802,20 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 		| AUART_INTR_CTSMIS),
 			s->port.membase + AUART_INTR_CLR);
 
+	/*
+	 * Dealing with GPIO interrupt
+	 */
+	if (irq == s->gpio_irq[UART_GPIO_CTS] ||
+	    irq == s->gpio_irq[UART_GPIO_DCD] ||
+	    irq == s->gpio_irq[UART_GPIO_DSR] ||
+	    irq == s->gpio_irq[UART_GPIO_RI])
+		mxs_auart_modem_status(s,
+				mctrl_gpio_get(s->gpios, &s->mctrl_prev));
+
 	if (istat & AUART_INTR_CTSMIS) {
 		if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
-						UART_GPIO_CTS)))
+							UART_GPIO_CTS))
+						&& s->ms_irq_enabled)
 			uart_handle_cts_change(&s->port,
 					stat & AUART_STAT_CTS);
 		writel(AUART_INTR_CTSMIS,
@@ -774,6 +878,10 @@ static int mxs_auart_startup(struct uart_port *u)
 	 */
 	writel(AUART_LINECTRL_FEN, u->membase + AUART_LINECTRL_SET);
 
+	/* get initial status of modem lines */
+	mctrl_gpio_get(s->gpios, &s->mctrl_prev);
+
+	s->ms_irq_enabled = false;
 	return 0;
 }
 
@@ -781,6 +889,8 @@ static void mxs_auart_shutdown(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
 
+	mxs_auart_disable_ms(u);
+
 	if (auart_dma_enabled(s))
 		mxs_auart_dma_exit(s);
 
@@ -837,6 +947,7 @@ static struct uart_ops mxs_auart_ops = {
 	.start_tx       = mxs_auart_start_tx,
 	.stop_tx	= mxs_auart_stop_tx,
 	.stop_rx	= mxs_auart_stop_rx,
+	.enable_ms      = mxs_auart_enable_ms,
 	.break_ctl      = mxs_auart_break_ctl,
 	.set_mctrl	= mxs_auart_set_mctrl,
 	.get_mctrl      = mxs_auart_get_mctrl,
@@ -1039,12 +1150,61 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 
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
@@ -1092,6 +1252,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.type = PORT_IMX;
 	s->port.dev = s->dev = &pdev->dev;
 
+	s->mctrl_prev = 0;
+
 	s->irq = platform_get_irq(pdev, 0);
 	s->port.irq = s->irq;
 	ret = request_irq(s->irq, mxs_auart_irq_handle, 0, dev_name(&pdev->dev), s);
@@ -1105,13 +1267,20 @@ static int mxs_auart_probe(struct platform_device *pdev)
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
@@ -1120,6 +1289,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	return 0;
 
+out_free_gpio_irq:
+	mxs_auart_free_gpio_irq(s);
 out_free_irq:
 	auart_port[pdev->id] = NULL;
 	free_irq(s->irq, s);
@@ -1139,6 +1310,7 @@ static int mxs_auart_remove(struct platform_device *pdev)
 
 	auart_port[pdev->id] = NULL;
 
+	mxs_auart_free_gpio_irq(s);
 	clk_put(s->clk);
 	free_irq(s->irq, s);
 	kfree(s);
-- 
1.7.11.3

