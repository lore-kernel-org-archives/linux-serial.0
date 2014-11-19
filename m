From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH v3] gpio: mxs: implement get_direction callback
Date: Wed, 19 Nov 2014 09:55:22 +0100
Message-ID: <1416387322-17320-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:61167 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750948AbaKSIxn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Nov 2014 03:53:43 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

gpiolib's gpiod_get_direction() function returns the EINVAL error
if .get_direction callback is not defined.
The patch implements the callback for mxs chip which is useful
for debugging.

Inspired by arch/arm/mach-at91/gpio.c

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---

Changes since v2:
- Remove obsolete paragraph concerning commit f9e42397d79b as
  .get_direction has nothing to do with mctrl_gpio
- Grammar fixes

Changes since v1:
- Fix the explanation why the patch is needed

Obsolete:
Two patches were missed during movements between our internal repos.
The 2/2 patch is required against commits:
  f9e42397d79b ("serial: mxs-auart: add interrupts for modem control lines")
  36a262782b04 ("serial: mxs-auart: enable PPS support")
I've done build-test for the next only before.
I should have done hardware test also for the next, sorry.
Now it is tested for the next on real hardware too.

Commit f9e42397d79b
("serial: mxs-auart: add interrupts for modem control lines")
as based on commit ab5e4e4108ca
("tty/serial: at91: add interrupts for modem control lines")
uses the gpiod_get_direction() function.

On the moment the patch is required to get the patch
"serial: mxs-auart: enable PPS support" working.
It is planned to introduce new mctrl_gpio helpers to avoid
gpiod_get_direction() function.

---
 drivers/gpio/gpio-mxs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 8ffdd7d..56052c2 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -227,6 +227,18 @@ static int mxs_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 	return irq_find_mapping(port->domain, offset);
 }
 
+static int mxs_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+	struct mxs_gpio_port *port =
+		container_of(bgc, struct mxs_gpio_port, bgc);
+	u32 mask = 1 << offset;
+	u32 dir;
+
+	dir = readl(port->base + PINCTRL_DOE(port));
+	return !(dir & mask);
+}
+
 static struct platform_device_id mxs_gpio_ids[] = {
 	{
 		.name = "imx23-gpio",
@@ -320,6 +332,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 		goto out_irqdesc_free;
 
 	port->bgc.gc.to_irq = mxs_gpio_to_irq;
+	port->bgc.gc.get_direction = mxs_gpio_get_direction;
 	port->bgc.gc.base = port->id * 32;
 
 	err = gpiochip_add(&port->bgc.gc);
-- 
1.7.11.3

