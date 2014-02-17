From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v3 6/7] pinctrl: at91: implement get_direction
Date: Mon, 17 Feb 2014 17:57:26 +0100
Message-ID: <1392656247-3351-7-git-send-email-richard.genoud@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:53291 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbaBQQ6L (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Feb 2014 11:58:11 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn9so2623745wib.6
        for <linux-serial@vger.kernel.org>; Mon, 17 Feb 2014 08:58:10 -0800 (PST)
In-Reply-To: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

This is needed for gpiod_get_direction().
Otherwise, it returns -EINVAL.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/pinctrl/pinctrl-at91.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index d990e33d8aa7..9bd18fdc604a 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1137,6 +1137,17 @@ static void at91_gpio_free(struct gpio_chip *chip, unsigned offset)
 	pinctrl_free_gpio(gpio);
 }
 
+static int at91_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
+	void __iomem *pio = at91_gpio->regbase;
+	unsigned mask = 1 << offset;
+	u32 osr;
+
+	osr = readl_relaxed(pio + PIO_OSR);
+	return !(osr & mask);
+}
+
 static int at91_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
@@ -1543,6 +1554,7 @@ static int at91_gpio_of_irq_setup(struct device_node *node,
 static struct gpio_chip at91_gpio_template = {
 	.request		= at91_gpio_request,
 	.free			= at91_gpio_free,
+	.get_direction		= at91_gpio_get_direction,
 	.direction_input	= at91_gpio_direction_input,
 	.get			= at91_gpio_get,
 	.direction_output	= at91_gpio_direction_output,
-- 
1.8.5

