From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 1/2] serial: mxs-auart: use mctrl_gpio helpers for handling modem signals (v2.1)
Date: Mon, 15 Sep 2014 19:37:37 +0200
Message-ID: <1410802657-14084-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:64000 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752861AbaIORfG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Sep 2014 13:35:06 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

Dedicated CTS and RTS pins are unusable together with a lot of other
peripherals because they share the same line. Pinctrl is limited.

Moreover, the AUART controller doesn't handle DTR/DSR/DCD/RI signals,
so we have to control them via GPIO.

This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
signals.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 .../devicetree/bindings/serial/fsl-mxs-auart.txt   | 10 ++-
 drivers/tty/serial/Kconfig           |  1 +
 drivers/tty/serial/mxs-auart.c       | 79 +++++++++++++++++++++-
 3 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
index 59a40f1..7c408c8 100644
--- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
@@ -11,8 +11,13 @@ Required properties:
 - dma-names: "rx" for RX channel, "tx" for TX channel.
 
 Optional properties:
-- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines,
+- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines
+  for hardware flow control,
 	it also means you enable the DMA support for this UART.
+- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
+  line respectively. It will use specified PIO instead of the peripheral
+  function pin for the USART feature.
+  If unsure, don't specify this property.
 
 Example:
 auart0: serial@8006a000 {
@@ -21,6 +26,9 @@ auart0: serial@8006a000 {
 	interrupts = <112>;
 	dmas = <&dma_apbx 8>, <&dma_apbx 9>;
 	dma-names = "rx", "tx";
+	cts-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+	dsr-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	dcd-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 };
 
 Note: Each auart port should have an alias correctly numbered in "aliases"
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4fe8ca1..90e8516 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1357,6 +1357,7 @@ config SERIAL_MXS_AUART
 	depends on ARCH_MXS
 	tristate "MXS AUART support"
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
 	  This driver supports the MXS Application UART (AUART) port.
 
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 52d14e3..78cd7d1 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -38,6 +38,18 @@
 
 #include <asm/cacheflush.h>
 
+/* based on clps711x.c from linux-next:
+ *  serial: clps711x: Use mctrl_gpio helpers for handling modem signals
+ *  serial: clps711x: Fix COMPILE_TEST build for target without GPIOLIB support
+ * based on Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt from linux-next:
+ *  serial: clps711x: Use mctrl_gpio helpers for handling modem signals
+ * based on atmel_serial.c from linux-next:
+ *  tty/serial: at91: use mctrl_gpio helpers
+ *  TODO: tty/serial: at91: add interrupts for modem control lines
+ */
+#include <linux/err.h>
+#include "serial_mctrl_gpio.h"
+
 #define MXS_AUART_MAJOR 242
 #define MXS_AUART_PORTS 5
 #define MXS_AUART_FIFO_SIZE		16
@@ -156,6 +168,8 @@ struct mxs_auart_port {
 	struct scatterlist rx_sgl;
 	struct dma_chan	*rx_dma_chan;
 	void *rx_dma_buf;
+
+	struct mctrl_gpios	*gpios;
 };
 
 static struct platform_device_id mxs_auart_devtype[] = {
@@ -417,6 +431,34 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 
 	s->ctrl = mctrl;
 	writel(ctrl, u->membase + AUART_CTRL2);
+
+	mctrl_gpio_set(s->gpios, mctrl);
+}
+
+/* mxs_auart_modem_status() based on 8250.c,
+ * similar function could be as serial's helper... */
+#define MCTRL_ANY_DELTA        (TIOCM_RI | TIOCM_DSR | TIOCM_CD | TIOCM_CTS)
+static u32 mxs_auart_modem_status(struct mxs_auart_port *s, u32 mctrl)
+{
+	u32 mctrl_diff;
+
+	mctrl_diff = mctrl ^ s->ctrl;
+	s->ctrl = mctrl;
+	if (mctrl_diff & MCTRL_ANY_DELTA &&
+			/*interrupt_enabled &&*/
+			s->port.state != NULL) {
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
 }
 
 static u32 mxs_auart_get_mctrl(struct uart_port *u)
@@ -433,7 +475,9 @@ static u32 mxs_auart_get_mctrl(struct uart_port *u)
 	if (ctrl2 & AUART_CTRL2_RTS)
 		mctrl |= TIOCM_RTS;
 
-	return mctrl;
+	/* should mxs_auart_modem_status() be in interrupt only? */
+	return mxs_auart_modem_status(s,
+			mctrl_gpio_get(s->gpios, &mctrl));
 }
 
 static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s);
@@ -637,7 +681,12 @@ static void mxs_auart_settermios(struct uart_port *u,
 		ctrl |= AUART_LINECTRL_STP2;
 
 	/* figure out the hardware flow control settings */
-	if (cflag & CRTSCTS) {
+	/*FIXME: DMA for hardware flow control only? */
+	if (cflag & CRTSCTS &&
+			(IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
+					 UART_GPIO_RTS)) ||
+			 IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
+					 UART_GPIO_CTS)))) {
 		/*
 		 * The DMA has a bug(see errata:2836) in mx23.
 		 * So we can not implement the DMA for auart in mx23,
@@ -696,8 +745,14 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 		| AUART_INTR_CTSMIS),
 			s->port.membase + AUART_INTR_CLR);
 
+	mxs_auart_modem_status(s,
+			mctrl_gpio_get(s->gpios, &s->ctrl));
+
 	if (istat & AUART_INTR_CTSMIS) {
-		uart_handle_cts_change(&s->port, stat & AUART_STAT_CTS);
+		if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
+						UART_GPIO_CTS)))
+			uart_handle_cts_change(&s->port,
+					stat & AUART_STAT_CTS);
 		writel(AUART_INTR_CTSMIS,
 				s->port.membase + AUART_INTR_CLR);
 		istat &= ~AUART_INTR_CTSMIS;
@@ -758,6 +813,8 @@ static int mxs_auart_startup(struct uart_port *u)
 	 */
 	writel(AUART_LINECTRL_FEN, u->membase + AUART_LINECTRL_SET);
 
+	/* get initial status of modem lines */
+	mctrl_gpio_get(s->gpios, &s->ctrl);
 	return 0;
 }
 
@@ -1021,6 +1078,14 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	return 0;
 }
 
+static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
+{
+	s->gpios = mctrl_gpio_init(dev, 0);
+	if (IS_ERR_OR_NULL(s->gpios))
+		return -1;
+	return 0;
+}
+
 static int mxs_auart_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -1078,6 +1143,11 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, s);
 
+	ret = mxs_auart_init_gpios(s, &pdev->dev);
+	if (ret < 0)
+		dev_err(&pdev->dev, "%s",
+			"Failed to initialize GPIOs. The serial port may not work as expected");
+
 	auart_port[s->port.line] = s;
 
 	mxs_auart_reset(&s->port);
@@ -1094,6 +1164,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	return 0;
 
 out_free_irq:
+	mctrl_gpio_free(&pdev->dev, s->gpios);	/*useless?*/
 	auart_port[pdev->id] = NULL;
 	free_irq(s->irq, s);
 out_free_clk:
@@ -1112,6 +1183,8 @@ static int mxs_auart_remove(struct platform_device *pdev)
 
 	auart_port[pdev->id] = NULL;
 
+	mctrl_gpio_free(&pdev->dev, s->gpios);	/*useless?*/
+
 	clk_put(s->clk);
 	free_irq(s->irq, s);
 	kfree(s);
-- 
1.7.11.3


>From 6477f8f5a2ead95147e208bf8fc506d093c2d0d9 Mon Sep 17 00:00:00 2001
From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Date: Mon, 15 Sep 2014 19:28:01 +0200
Subject: [PATCH 2/2] serial: mxs-auart: add interrupts for modem control
 lines

Handle CTS/DSR/RI/DCD GPIO interrupts in mxs-auart.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 153 ++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 78cd7d1..091be08 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -45,9 +45,17 @@
  *  serial: clps711x: Use mctrl_gpio helpers for handling modem signals
  * based on atmel_serial.c from linux-next:
  *  tty/serial: at91: use mctrl_gpio helpers
- *  TODO: tty/serial: at91: add interrupts for modem control lines
+ *  tty/serial: at91: add interrupts for modem control lines
+ *  TODO: tty/serial: at91: BUG: disable interrupts when !UART_ENABLE_MS()
+ * based on arm-kernel:
+ *  [PATCH v6 0/3] tty/serial: Add helpers to use GPIOs to control modem lines and implement atmel_serial.c
+ * based on linux-arm-kernel:
+ *  TODO: tty: serial: omap: use mctrl_gpio helpers
  */
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 #include "serial_mctrl_gpio.h"
 
 #define MXS_AUART_MAJOR 242
@@ -170,6 +178,8 @@ struct mxs_auart_port {
 	void *rx_dma_buf;
 
 	struct mctrl_gpios	*gpios;
+	int			gpio_irq[UART_GPIO_MAX];
+	bool			ms_irq_enabled;
 };
 
 static struct platform_device_id mxs_auart_devtype[] = {
@@ -480,6 +490,64 @@ static u32 mxs_auart_get_mctrl(struct uart_port *u)
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
@@ -728,6 +796,12 @@ static void mxs_auart_settermios(struct uart_port *u,
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
@@ -745,8 +819,15 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
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
@@ -815,6 +896,8 @@ static int mxs_auart_startup(struct uart_port *u)
 
 	/* get initial status of modem lines */
 	mctrl_gpio_get(s->gpios, &s->ctrl);
+
+	s->ms_irq_enabled = false;
 	return 0;
 }
 
@@ -822,6 +905,8 @@ static void mxs_auart_shutdown(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
 
+	mxs_auart_disable_ms(u);
+
 	if (auart_dma_enabled(s))
 		mxs_auart_dma_exit(s);
 
@@ -878,6 +963,7 @@ static struct uart_ops mxs_auart_ops = {
 	.start_tx       = mxs_auart_start_tx,
 	.stop_tx	= mxs_auart_stop_tx,
 	.stop_rx	= mxs_auart_stop_rx,
+	.enable_ms      = mxs_auart_enable_ms,
 	.break_ctl      = mxs_auart_break_ctl,
 	.set_mctrl	= mxs_auart_set_mctrl,
 	.get_mctrl      = mxs_auart_get_mctrl,
@@ -1080,12 +1166,61 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 
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
+		err = request_irq(irq[i], mxs_auart_irq_handle, IRQ_TYPE_EDGE_BOTH,
+				dev_name(s->dev), s);
+		if (err)
+			dev_err(s->dev, "%s - Can't get %d irq\n",
+				__FUNCTION__, irq[i]);
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
@@ -1148,13 +1283,20 @@ static int mxs_auart_probe(struct platform_device *pdev)
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
@@ -1163,6 +1305,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	return 0;
 
+out_free_gpio_irq:
+	mxs_auart_free_gpio_irq(s);
 out_free_irq:
 	mctrl_gpio_free(&pdev->dev, s->gpios);	/*useless?*/
 	auart_port[pdev->id] = NULL;
@@ -1183,6 +1327,7 @@ static int mxs_auart_remove(struct platform_device *pdev)
 
 	auart_port[pdev->id] = NULL;
 
+	mxs_auart_free_gpio_irq(s);
 	mctrl_gpio_free(&pdev->dev, s->gpios);	/*useless?*/
 
 	clk_put(s->clk);
-- 
1.7.11.3

