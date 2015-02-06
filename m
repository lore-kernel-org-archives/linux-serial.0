From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH v3 2/4] serial: mxs-auart: Use helpers for gpio irqs
Date: Fri,  6 Feb 2015 17:55:33 +0100
Message-ID: <1423241735-30387-2-git-send-email-j.uzycki@elproma.com.pl>
References: <1423241735-30387-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1423241735-30387-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Cc: fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>
List-Id: linux-serial@vger.kernel.org

The patch updates mxs-auart driver to use new mctrl_gpio helpers for
gpio irqs. The code is much simpler now.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---

Changes since RFC v2:
 - fixed comments in *_ms functions to match the coding style
   (credits to Uwe Kleine-K=C3=B6nig)
 - rebased to next-20150204

---
 drivers/tty/serial/mxs-auart.c | 137 +++++----------------------------=
--------
 1 file changed, 17 insertions(+), 120 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-au=
art.c
index d1298b6..5a8cf2c 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -149,7 +149,6 @@ struct mxs_auart_port {
 #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
 #define MXS_AUART_RTSCTS	4  /* bit 4 */
 	unsigned long flags;
-	unsigned int mctrl_prev;
 	enum mxs_auart_type devtype;
=20
 	struct clk *clk;
@@ -165,7 +164,6 @@ struct mxs_auart_port {
 	void *rx_dma_buf;
=20
 	struct mctrl_gpios	*gpios;
-	int			gpio_irq[UART_GPIO_MAX];
 	bool			ms_irq_enabled;
 };
=20
@@ -431,29 +429,6 @@ static void mxs_auart_set_mctrl(struct uart_port *=
u, unsigned mctrl)
 	mctrl_gpio_set(s->gpios, mctrl);
 }
=20
-#define MCTRL_ANY_DELTA        (TIOCM_RI | TIOCM_DSR | TIOCM_CD | TIOC=
M_CTS)
-static u32 mxs_auart_modem_status(struct mxs_auart_port *s, u32 mctrl)
-{
-	u32 mctrl_diff;
-
-	mctrl_diff =3D mctrl ^ s->mctrl_prev;
-	s->mctrl_prev =3D mctrl;
-	if (mctrl_diff & MCTRL_ANY_DELTA && s->ms_irq_enabled &&
-						s->port.state !=3D NULL) {
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
 	struct mxs_auart_port *s =3D to_auart_port(u);
@@ -481,18 +456,11 @@ static void mxs_auart_enable_ms(struct uart_port =
*port)
=20
 	s->ms_irq_enabled =3D true;
=20
-	if (s->gpio_irq[UART_GPIO_CTS] >=3D 0)
-		enable_irq(s->gpio_irq[UART_GPIO_CTS]);
-	/* TODO: enable AUART_INTR_CTSMIEN otherwise */
-
-	if (s->gpio_irq[UART_GPIO_DSR] >=3D 0)
-		enable_irq(s->gpio_irq[UART_GPIO_DSR]);
-
-	if (s->gpio_irq[UART_GPIO_RI] >=3D 0)
-		enable_irq(s->gpio_irq[UART_GPIO_RI]);
-
-	if (s->gpio_irq[UART_GPIO_DCD] >=3D 0)
-		enable_irq(s->gpio_irq[UART_GPIO_DCD]);
+	mctrl_gpio_enable_ms(s->gpios);
+	/*
+	 * TODO: enable AUART_INTR_CTSMIEN if CTS isn't handled by
+	 * mctrl_gpio.
+	 */
 }
=20
 /*
@@ -510,18 +478,11 @@ static void mxs_auart_disable_ms(struct uart_port=
 *port)
=20
 	s->ms_irq_enabled =3D false;
=20
-	if (s->gpio_irq[UART_GPIO_CTS] >=3D 0)
-		disable_irq(s->gpio_irq[UART_GPIO_CTS]);
-	/* TODO: disable AUART_INTR_CTSMIEN otherwise */
-
-	if (s->gpio_irq[UART_GPIO_DSR] >=3D 0)
-		disable_irq(s->gpio_irq[UART_GPIO_DSR]);
-
-	if (s->gpio_irq[UART_GPIO_RI] >=3D 0)
-		disable_irq(s->gpio_irq[UART_GPIO_RI]);
-
-	if (s->gpio_irq[UART_GPIO_DCD] >=3D 0)
-		disable_irq(s->gpio_irq[UART_GPIO_DCD]);
+	mctrl_gpio_disable_ms(s->gpios);
+	/*
+	 * TODO: disable AUART_INTR_CTSMIEN if CTS isn't handled by
+	 * mctrl_gpio.
+	 */
 }
=20
 static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s);
@@ -797,7 +758,6 @@ static irqreturn_t mxs_auart_irq_handle(int irq, vo=
id *context)
 {
 	u32 istat;
 	struct mxs_auart_port *s =3D context;
-	u32 mctrl_temp =3D s->mctrl_prev;
 	u32 stat =3D readl(s->port.membase + AUART_STAT);
=20
 	istat =3D readl(s->port.membase + AUART_INTR);
@@ -809,16 +769,6 @@ static irqreturn_t mxs_auart_irq_handle(int irq, v=
oid *context)
 		| AUART_INTR_CTSMIS),
 			s->port.membase + AUART_INTR_CLR);
=20
-	/*
-	 * Dealing with GPIO interrupt
-	 */
-	if (irq =3D=3D s->gpio_irq[UART_GPIO_CTS] ||
-	    irq =3D=3D s->gpio_irq[UART_GPIO_DCD] ||
-	    irq =3D=3D s->gpio_irq[UART_GPIO_DSR] ||
-	    irq =3D=3D s->gpio_irq[UART_GPIO_RI])
-		mxs_auart_modem_status(s,
-				mctrl_gpio_get(s->gpios, &mctrl_temp));
-
 	if (istat & AUART_INTR_CTSMIS) {
 		if (CTS_AT_AUART() && s->ms_irq_enabled)
 			uart_handle_cts_change(&s->port,
@@ -883,9 +833,6 @@ static int mxs_auart_startup(struct uart_port *u)
 	 */
 	writel(AUART_LINECTRL_FEN, u->membase + AUART_LINECTRL_SET);
=20
-	/* get initial status of modem lines */
-	mctrl_gpio_get(s->gpios, &s->mctrl_prev);
-
 	s->ms_irq_enabled =3D false;
 	return 0;
 }
@@ -1155,71 +1102,23 @@ static int serial_mxs_probe_dt(struct mxs_auart=
_port *s,
 	return 0;
 }
=20
-static bool mxs_auart_init_gpios(struct mxs_auart_port *s, struct devi=
ce *dev)
+static bool mxs_auart_init_gpios(struct mxs_auart_port *s)
 {
-	enum mctrl_gpio_idx i;
-	struct gpio_desc *gpiod;
-
-	s->gpios =3D mctrl_gpio_init(dev, 0);
+	s->gpios =3D mctrl_gpio_init_dt(&s->port, 0);
 	if (IS_ERR_OR_NULL(s->gpios))
 		return false;
=20
 	/* Block (enabled before) DMA option if RTS or CTS is GPIO line */
 	if (!RTS_AT_AUART() || !CTS_AT_AUART()) {
 		if (test_bit(MXS_AUART_RTSCTS, &s->flags))
-			dev_warn(dev,
+			dev_warn(s->dev,
 				 "DMA and flow control via gpio may cause some problems. DMA disab=
led!\n");
 		clear_bit(MXS_AUART_RTSCTS, &s->flags);
 	}
=20
-	for (i =3D 0; i < UART_GPIO_MAX; i++) {
-		gpiod =3D mctrl_gpio_to_gpiod(s->gpios, i);
-		if (gpiod && (gpiod_get_direction(gpiod) =3D=3D GPIOF_DIR_IN))
-			s->gpio_irq[i] =3D gpiod_to_irq(gpiod);
-		else
-			s->gpio_irq[i] =3D -EINVAL;
-	}
-
 	return true;
 }
=20
-static void mxs_auart_free_gpio_irq(struct mxs_auart_port *s)
-{
-	enum mctrl_gpio_idx i;
-
-	for (i =3D 0; i < UART_GPIO_MAX; i++)
-		if (s->gpio_irq[i] >=3D 0)
-			free_irq(s->gpio_irq[i], s);
-}
-
-static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
-{
-	int *irq =3D s->gpio_irq;
-	enum mctrl_gpio_idx i;
-	int err =3D 0;
-
-	for (i =3D 0; (i < UART_GPIO_MAX) && !err; i++) {
-		if (irq[i] < 0)
-			continue;
-
-		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
-		err =3D request_irq(irq[i], mxs_auart_irq_handle,
-				IRQ_TYPE_EDGE_BOTH, dev_name(s->dev), s);
-		if (err)
-			dev_err(s->dev, "%s - Can't get %d irq\n",
-				__func__, irq[i]);
-	}
-
-	/*
-	 * If something went wrong, rollback.
-	 */
-	while (err && (--i >=3D 0))
-		if (irq[i] >=3D 0)
-			free_irq(irq[i], s);
-
-	return err;
-}
-
 static int mxs_auart_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =3D
@@ -1262,8 +1161,6 @@ static int mxs_auart_probe(struct platform_device=
 *pdev)
 	s->port.type =3D PORT_IMX;
 	s->port.dev =3D s->dev =3D &pdev->dev;
=20
-	s->mctrl_prev =3D 0;
-
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -1276,14 +1173,14 @@ static int mxs_auart_probe(struct platform_devi=
ce *pdev)
=20
 	platform_set_drvdata(pdev, s);
=20
-	if (!mxs_auart_init_gpios(s, &pdev->dev))
+	if (!mxs_auart_init_gpios(s))
 		dev_err(&pdev->dev,
 			"Failed to initialize GPIOs. The serial port may not work as expect=
ed\n");
=20
 	/*
 	 * Get the GPIO lines IRQ
 	 */
-	ret =3D mxs_auart_request_gpio_irq(s);
+	ret =3D mctrl_gpio_request_irqs(s->gpios);
 	if (ret)
 		return ret;
=20
@@ -1303,7 +1200,7 @@ static int mxs_auart_probe(struct platform_device=
 *pdev)
 	return 0;
=20
 out_free_gpio_irq:
-	mxs_auart_free_gpio_irq(s);
+	mctrl_gpio_free_irqs(s->gpios);
 	auart_port[pdev->id] =3D NULL;
 	return ret;
 }
@@ -1314,7 +1211,7 @@ static int mxs_auart_remove(struct platform_devic=
e *pdev)
=20
 	uart_remove_one_port(&auart_driver, &s->port);
 	auart_port[pdev->id] =3D NULL;
-	mxs_auart_free_gpio_irq(s);
+	mctrl_gpio_free_irqs(s->gpios);
=20
 	return 0;
 }
--=20
1.7.11.3

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
