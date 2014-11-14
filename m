From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH] gpio: mxs: implement get_direction callback
Date: Fri, 14 Nov 2014 23:27:06 +0100
Message-ID: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:59001 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422727AbaKNWYw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2014 17:24:52 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com, linux-gpio@vger.kernel.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

Function gpiod_get_direction() of gpiolib calls get_direction()
callback. If chip doesn't implement it EINVAL error is returned.
The function doesn't use for returned value shadowed FLAG_IS_OUT
bit of gpio_desc.flags field so the callback is required.
The patch implements the missing callback.

Inspired from arch/arm/mach-at91/gpio.c
Required to get the patch "serial: mxs-auart: enable PPS support" working.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---

Two patches were missed during movements between our internal repos.
The 2/2 patch is required against commits:
  f9e42397d79b ("serial: mxs-auart: add interrupts for modem control lines")
  36a262782b04 ("serial: mxs-auart: enable PPS support")
I've done build-test for the next only before.
I should have done hardware test also for the next, sorry.
Now it is tested for the next on real hardware too.

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

