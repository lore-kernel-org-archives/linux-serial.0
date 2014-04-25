From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 2/5] ARM: at91: gpio: implement get_direction
Date: Fri, 25 Apr 2014 16:52:38 +0200
Message-ID: <1398437561-4289-3-git-send-email-richard.genoud@gmail.com>
References: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:63028 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaDYOxV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 10:53:21 -0400
Received: by mail-we0-f171.google.com with SMTP id t61so3749026wes.30
        for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2014 07:53:20 -0700 (PDT)
In-Reply-To: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

This is needed for gpiod_get_direction().
Otherwise, it returns -EINVAL.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-at91/gpio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index a5afcf76550e..afbe34027e62 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -49,6 +49,7 @@ static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset);
 static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip);
 static void at91_gpiolib_set(struct gpio_chip *chip, unsigned offset, int val);
 static int at91_gpiolib_get(struct gpio_chip *chip, unsigned offset);
+static int at91_gpiolib_get_direction(struct gpio_chip *chip, unsigned offset);
 static int at91_gpiolib_direction_output(struct gpio_chip *chip,
 					 unsigned offset, int val);
 static int at91_gpiolib_direction_input(struct gpio_chip *chip,
@@ -60,6 +61,7 @@ static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 		.chip = {						\
 			.label		  = name,			\
 			.request	  = at91_gpiolib_request,	\
+			.get_direction    = at91_gpiolib_get_direction, \
 			.direction_input  = at91_gpiolib_direction_input, \
 			.direction_output = at91_gpiolib_direction_output, \
 			.get		  = at91_gpiolib_get,		\
@@ -799,6 +801,17 @@ static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
+static int at91_gpiolib_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
+	void __iomem *pio = at91_gpio->regbase;
+	unsigned mask = 1 << offset;
+	u32 osr;
+
+	osr = __raw_readl(pio + PIO_OSR);
+	return !(osr & mask);
+}
+
 static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 					unsigned offset)
 {
-- 
1.8.5.5

