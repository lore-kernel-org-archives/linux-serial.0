Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4590497B96;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470941; cv=none; b=VzYVNEMf9KW899LlP6CsxqBW3EPoUEnV54z6sVr34oyxyTk44Ht0U7i8mGVGeYj0/PKcQ1KU3MCcmDr3Eg8z3SgZea2SnBxvTRgZ8ObDJ1igunaO2UTp+Le1zQj19Nso0MzrdfnWtcE4Tx6A+5vBiqv+OZifc7ScJhtc5ArlVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470941; c=relaxed/simple;
	bh=apLWzdvgb1s6ZZhPE9IW2ykFDz8tGxdLt1ms1gbZrRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSZ/J7OZIWApkbWZtCqplvlpi4OdvqlBGws2XFTeA7kJpd7NnAXlL0l1L8S9HeHb0IW7eazucLpPD+3mjzNRwrUKfgRZyBWs+36BREzctcYDx1/3gqDbi1OPInPlu4LXqStKVoVSgWBV+np2TbL2SMKXY4fxGFxQys8Ush09ZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9BO/s29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9BO/s29"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65688C2BCB9;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789470941;
	bh=apLWzdvgb1s6ZZhPE9IW2ykFDz8tGxdLt1ms1gbZrRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y9BO/s29j57o78qggRkGKful6hGXP2r6a2OTsdz/w/y9S8ebKCvw0F8c61dpp3OIV
	 zbxy+hRDzxQrxrUnfKki8IUzYeZC3ZJ9MAlEzqIJ6YmCaJSDjnx4Znr6BMQODaHMWb
	 uMiHlUIuWQAQ+p9myh4436uTs2ObGxevnlj5Edmwus73cH/SHn3PhKsUJ5Vjupw88C
	 ibET0FHNqg/oRjC3KwZDglZiT/180loBJ3oTlzJKqLm5LASWcxMZpMf2EnrgbubZWH
	 ziDPugAxDOvSGxqzfrc6TWqbvXZ8wEq4JdvDyD5XkuwKLKV8HDkI4mjmbnvo1KNG5U
	 vvetE8L+Kzr7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517CBC88E7B;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 15 Sep 2026 19:15:39 +0800
Subject: [PATCH v7 09/15] gpiolib: regmap: add gpio_regmap_get_chip()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-cv75-v5-v7-9-3297d3fbc9c0@ambarella.com>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
In-Reply-To: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789470938; l=2769;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=nq9zwoYxD+NQm8KCrReHWkDIjxPc8aBRQx3slgbQG5I=;
 b=UeddQ/k7Bfy8M1+7iO6pMfuGpWJDosaPnbR8AD5YXnJ+tU3kaZLmZlTKQJxKltmA4XbkZBtYx
 5KaLQ39XmhGAPEeZoRCm0OWLNLWcAdP+3CeBaRHKRGIQRJmtn+/dY9O
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Let drivers that implement a custom irqchip retrieve the gpio_chip
after registration. Attach a caller-provided irq_domain only when it
is present.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-regmap.c  | 20 +++++++++++++++-----
 include/linux/gpio/regmap.h |  1 +
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index dfcc1f1122ec..56c2c873cbfa 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -296,6 +296,12 @@ void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
 }
 EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
 
+struct gpio_chip *gpio_regmap_get_chip(struct gpio_regmap *gpio)
+{
+	return &gpio->gpio_chip;
+}
+EXPORT_SYMBOL_GPL(gpio_regmap_get_chip);
+
 /**
  * gpio_regmap_register() - Register a generic regmap GPIO controller
  * @config: configuration for gpio_regmap
@@ -304,7 +310,6 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
  */
 struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config)
 {
-	struct irq_domain *irq_domain;
 	struct gpio_regmap *gpio;
 	struct gpio_chip *chip;
 	int ret;
@@ -412,6 +417,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 #ifdef CONFIG_REGMAP_IRQ
 	if (config->regmap_irq_chip) {
+		struct irq_domain *irq_domain;
+
 		gpio->regmap_irq_line = config->regmap_irq_line;
 		ret = regmap_add_irq_chip_fwnode(dev_fwnode(config->parent), config->regmap,
 						 config->regmap_irq_line, config->regmap_irq_flags,
@@ -420,12 +427,15 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 			goto err_remove_gpiochip;
 
 		irq_domain = regmap_irq_get_domain(gpio->irq_chip_data);
+		if (irq_domain) {
+			ret = gpiochip_irqchip_add_domain(chip, irq_domain);
+			if (ret)
+				goto err_remove_gpiochip;
+		}
 	} else
 #endif
-	irq_domain = config->irq_domain;
-
-	if (irq_domain) {
-		ret = gpiochip_irqchip_add_domain(chip, irq_domain);
+	if (config->irq_domain) {
+		ret = gpiochip_irqchip_add_domain(chip, config->irq_domain);
 		if (ret)
 			goto err_remove_gpiochip;
 	}
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index d7ffc12b00a2..6bc00b9775a5 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -128,5 +128,6 @@ void gpio_regmap_unregister(struct gpio_regmap *gpio);
 struct gpio_regmap *devm_gpio_regmap_register(struct device *dev,
 					      const struct gpio_regmap_config *config);
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio);
+struct gpio_chip *gpio_regmap_get_chip(struct gpio_regmap *gpio);
 
 #endif /* _LINUX_GPIO_REGMAP_H */

-- 
2.34.1


