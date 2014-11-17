From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [RFC PATCH 2/2] serial: mxs-auart: use helpers for gpio irqs
Date: Mon, 17 Nov 2014 22:39:27 +0100
Message-ID: <1416260367-31589-2-git-send-email-j.uzycki@elproma.com.pl>
References: <1416260367-31589-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:56258 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751982AbaKQVhd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2014 16:37:33 -0500
In-Reply-To: <1416260367-31589-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Cc: fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

The patch updates mx-auart driver to use new mctrl_gpio helpers for
gpio irqs. The code is much simpler now.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 133 +++------------------------
 1 file changed, 13 insertions(+), 120 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 518eac6..aeeb4aa 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -150,7 +150,6 @@ struct mxs_auart_port {
 #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
 #define MXS_AUART_RTSCTS	4  /* bit 4 */
 	unsigned long flags;
-	unsigned int mctrl_prev;
 	enum mxs_auart_type devtype;
 
 	unsigned int irq;
@@ -168,7 +167,6 @@ struct mxs_auart_port {
 	void *rx_dma_buf;
 
 	struct mctrl_gpios	*gpios;
-	int			gpio_irq[UART_GPIO_MAX];
 	bool			ms_irq_enabled;
 };
 
@@ -434,29 +432,6 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 	mctrl_gpio_set(s->gpios, mctrl);
 }
 
-#define MCTRL_ANY_DELTA        (TIOCM_RI | TIOCM_DSR | TIOCM_CD | TIOCM_CTS)
-static u32 mxs_auart_modem_status(struct mxs_auart_port *s, u32 mctrl)
-{
-	u32 mctrl_diff;
-
-	mctrl_diff = mctrl ^ s->mctrl_prev;
-	s->mctrl_prev = mctrl;
-	if (mctrl_diff & MCTRL_ANY_DELTA && s->ms_irq_enabled &&
-						s->port.state != NULL) {
-		if (mctrl_diff & TIOCM_RI)
-			s->port.icount.rng++;
-		if (mctrl_diff & TIOCM_DSR)
-			s->port.icount.dsr++;
-		if (mctrl_diff & TIOCM_CD)
-			uart_handle_dcd_change(&s->port, mctrl & TIOCM_CD);
-		if (mctrl_diff & TIOCM_CTS)
-			uart_handle_cts_change(&s->port, mctrl & TIOCM_CTS);
-
-		wake_up_interruptible(&s->port.state->port.delta_msr_wait);
-	}
-	return mctrl;
-}
-
 static u32 mxs_auart_get_mctrl(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
@@ -484,18 +459,9 @@ static void mxs_auart_enable_ms(struct uart_port *port)
 
 	s->ms_irq_enabled = true;
 
-	if (s->gpio_irq[UART_GPIO_CTS] >= 0)
-		enable_irq(s->gpio_irq[UART_GPIO_CTS]);
-	/* TODO: enable AUART_INTR_CTSMIEN otherwise */
-
-	if (s->gpio_irq[UART_GPIO_DSR] >= 0)
-		enable_irq(s->gpio_irq[UART_GPIO_DSR]);
-
-	if (s->gpio_irq[UART_GPIO_RI] >= 0)
-		enable_irq(s->gpio_irq[UART_GPIO_RI]);
-
-	if (s->gpio_irq[UART_GPIO_DCD] >= 0)
-		enable_irq(s->gpio_irq[UART_GPIO_DCD]);
+	mctrl_gpio_enable_ms(s->gpios);
+	/* TODO: enable AUART_INTR_CTSMIEN
+	 * if s->gpios->irq[UART_GPIO_CTS] == 0 */
 }
 
 /*
@@ -513,18 +479,9 @@ static void mxs_auart_disable_ms(struct uart_port *port)
 
 	s->ms_irq_enabled = false;
 
-	if (s->gpio_irq[UART_GPIO_CTS] >= 0)
-		disable_irq(s->gpio_irq[UART_GPIO_CTS]);
-	/* TODO: disable AUART_INTR_CTSMIEN otherwise */
-
-	if (s->gpio_irq[UART_GPIO_DSR] >= 0)
-		disable_irq(s->gpio_irq[UART_GPIO_DSR]);
-
-	if (s->gpio_irq[UART_GPIO_RI] >= 0)
-		disable_irq(s->gpio_irq[UART_GPIO_RI]);
-
-	if (s->gpio_irq[UART_GPIO_DCD] >= 0)
-		disable_irq(s->gpio_irq[UART_GPIO_DCD]);
+	mctrl_gpio_disable_ms(s->gpios);
+	/* TODO: disable AUART_INTR_CTSMIEN
+	 * if s->gpios->irq[UART_GPIO_CTS] == 0 */
 }
 
 static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s);
@@ -799,7 +756,6 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
 	u32 istat;
 	struct mxs_auart_port *s = context;
-	u32 mctrl_temp = s->mctrl_prev;
 	u32 stat = readl(s->port.membase + AUART_STAT);
 
 	istat = readl(s->port.membase + AUART_INTR);
@@ -811,16 +767,6 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 		| AUART_INTR_CTSMIS),
 			s->port.membase + AUART_INTR_CLR);
 
-	/*
-	 * Dealing with GPIO interrupt
-	 */
-	if (irq == s->gpio_irq[UART_GPIO_CTS] ||
-	    irq == s->gpio_irq[UART_GPIO_DCD] ||
-	    irq == s->gpio_irq[UART_GPIO_DSR] ||
-	    irq == s->gpio_irq[UART_GPIO_RI])
-		mxs_auart_modem_status(s,
-				mctrl_gpio_get(s->gpios, &mctrl_temp));
-
 	if (istat & AUART_INTR_CTSMIS) {
 		if (CTS_AT_AUART() && s->ms_irq_enabled)
 			uart_handle_cts_change(&s->port,
@@ -885,9 +831,6 @@ static int mxs_auart_startup(struct uart_port *u)
 	 */
 	writel(AUART_LINECTRL_FEN, u->membase + AUART_LINECTRL_SET);
 
-	/* get initial status of modem lines */
-	mctrl_gpio_get(s->gpios, &s->mctrl_prev);
-
 	s->ms_irq_enabled = false;
 	return 0;
 }
@@ -1156,71 +1099,23 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	return 0;
 }
 
-static bool mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
+static bool mxs_auart_init_gpios(struct mxs_auart_port *s)
 {
-	enum mctrl_gpio_idx i;
-	struct gpio_desc *gpiod;
-
-	s->gpios = mctrl_gpio_init(dev, 0);
+	s->gpios = mctrl_gpio_init_dt(&s->port, 0);
 	if (IS_ERR_OR_NULL(s->gpios))
 		return false;
 
 	/* Block (enabled before) DMA option if RTS or CTS is GPIO line */
 	if (!RTS_AT_AUART() || !CTS_AT_AUART()) {
 		if (test_bit(MXS_AUART_RTSCTS, &s->flags))
-			dev_warn(dev,
+			dev_warn(s->dev,
 				 "DMA and flow control via gpio may cause some problems. DMA disabled!\n");
 		clear_bit(MXS_AUART_RTSCTS, &s->flags);
 	}
 
-	for (i = 0; i < UART_GPIO_MAX; i++) {
-		gpiod = mctrl_gpio_to_gpiod(s->gpios, i);
-		if (gpiod && (gpiod_get_direction(gpiod) == GPIOF_DIR_IN))
-			s->gpio_irq[i] = gpiod_to_irq(gpiod);
-		else
-			s->gpio_irq[i] = -EINVAL;
-	}
-
 	return true;
 }
 
-static void mxs_auart_free_gpio_irq(struct mxs_auart_port *s)
-{
-	enum mctrl_gpio_idx i;
-
-	for (i = 0; i < UART_GPIO_MAX; i++)
-		if (s->gpio_irq[i] >= 0)
-			free_irq(s->gpio_irq[i], s);
-}
-
-static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
-{
-	int *irq = s->gpio_irq;
-	enum mctrl_gpio_idx i;
-	int err = 0;
-
-	for (i = 0; (i < UART_GPIO_MAX) && !err; i++) {
-		if (irq[i] < 0)
-			continue;
-
-		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
-		err = request_irq(irq[i], mxs_auart_irq_handle,
-				IRQ_TYPE_EDGE_BOTH, dev_name(s->dev), s);
-		if (err)
-			dev_err(s->dev, "%s - Can't get %d irq\n",
-				__func__, irq[i]);
-	}
-
-	/*
-	 * If something went wrong, rollback.
-	 */
-	while (err && (--i >= 0))
-		if (irq[i] >= 0)
-			free_irq(irq[i], s);
-
-	return err;
-}
-
 static int mxs_auart_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -1268,8 +1163,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.type = PORT_IMX;
 	s->port.dev = s->dev = &pdev->dev;
 
-	s->mctrl_prev = 0;
-
 	s->irq = platform_get_irq(pdev, 0);
 	s->port.irq = s->irq;
 	ret = request_irq(s->irq, mxs_auart_irq_handle, 0, dev_name(&pdev->dev), s);
@@ -1278,14 +1171,14 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, s);
 
-	if (!mxs_auart_init_gpios(s, &pdev->dev))
+	if (!mxs_auart_init_gpios(s))
 		dev_err(&pdev->dev,
 			"Failed to initialize GPIOs. The serial port may not work as expected\n");
 
 	/*
 	 * Get the GPIO lines IRQ
 	 */
-	ret = mxs_auart_request_gpio_irq(s);
+	ret = mctrl_gpio_request_irqs(s->gpios);
 	if (ret)
 		goto out_free_irq;
 
@@ -1305,7 +1198,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	return 0;
 
 out_free_gpio_irq:
-	mxs_auart_free_gpio_irq(s);
+	mctrl_gpio_free_irqs(s->gpios);
 out_free_irq:
 	auart_port[pdev->id] = NULL;
 	free_irq(s->irq, s);
@@ -1325,7 +1218,7 @@ static int mxs_auart_remove(struct platform_device *pdev)
 
 	auart_port[pdev->id] = NULL;
 
-	mxs_auart_free_gpio_irq(s);
+	mctrl_gpio_free_irqs(s->gpios);
 	clk_put(s->clk);
 	free_irq(s->irq, s);
 	kfree(s);
-- 
1.7.11.3

