Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AF41DE15;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503954; cv=none; b=esHAGyFTLQsSXUpGD9G13P9LGNQUxGQK6+HoCtGkaHARXjg5ip+jXjTndN74RsrFSbNN+6kCRhD+s1jOYHDtpjPO9ukhd3z0r7KxcbPCbrTYxz9BF6EMHa7XlHVOjLbSr2FxnDJuX+YD8LmqLE90TAqww8s/8wS1yfOtL+rvHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503954; c=relaxed/simple;
	bh=fTYrlYc/jDOyyW1JHqcXVgR7s43Ok1EE/6NxZ45lwiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bYJ/UyAQVDTE9b8bq4lwAOf8kaF9pL4K+ZTkUV6+wFbAg/+MRa4AjCyMHGR/vj0/0UlQ/U3yXAgce4tXzA+Q1RjsJ4jM4QM9QummsOMhmanvnIYtnUXZ+gJXeLVhcpmngv3uxNHilG99eITLb1NKmxaYhrPV5XsfDGOJIjzTW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duUIYKs6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duUIYKs6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48586C2BD04;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788503954;
	bh=fTYrlYc/jDOyyW1JHqcXVgR7s43Ok1EE/6NxZ45lwiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=duUIYKs6eNciXHDXf3PrPNgOzFM9CWwZAHcSMGmIJflXJ5SDdwfBi5RF8E+fZBnao
	 x6z+vZjO9GIUj4G1OiAXkHqeVC0uX8rOApEpVkqnqsh6wgVxACRcpXb7XSvs1yOYsV
	 fS97DuXLuG6AeVJgfkNKtWiuFTquLDPiPkuHvnPQF7jOZAWLNlY2DvFXSrtWrA/Fu2
	 T2qlwk/pVbO5ZEaNWf9MjcB8WR5An2vw0S2zA5l0kH93NjYmk9/Ja8JT7qNukyLaMH
	 CagptAK4RqDhkn2nvJIqcVezzdkAIuTro0zZwLjh3vu0+oeqwAn7ZqfgY7i8naE3Hf
	 vXzQZAvDY+r/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E05C79F85;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Fri, 04 Sep 2026 14:38:15 +0800
Subject: [PATCH v6 08/13] gpio: regmap: support write_data_after_dir and
 girq
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-cv75-v5-v6-8-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
In-Reply-To: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788503951; l=4540;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=KycT9tCUaJK+3T2peLT5loHlf/DpTwIq3Pwde6A3W6c=;
 b=Yb23nkmcQvpXY7/MoTocT7QJWIK3F4m2m54gDR1qN0PDiBGMbkb4FJ/91BRR5mrthdQi1qzVs
 qx5/ITDsDUhCeZu4N+N6Qx+4OV8CtPULThI0gb+Vf3gmmR6jYjN3Izw
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add an optional write-after-direction-output quirk for controllers
that ignore data-register writes while a line is still configured as
input, and allow drivers to pass an existing gpio_irq_chip through
gpio_regmap_register() so IRQ setup can stay with the caller.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-regmap.c  | 24 +++++++++++++++++++++++-
 include/linux/gpio/regmap.h | 13 +++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 51b4d69b8740..b4b492a1765c 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -33,6 +33,7 @@ struct gpio_regmap {
 	unsigned int reg_dir_out_base;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
+	bool write_data_after_dir;
 
 #ifdef CONFIG_REGMAP_IRQ
 	int regmap_irq_line;
@@ -273,7 +274,15 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 
 	gpio_regmap_set(chip, offset, value);
 
-	return gpio_regmap_set_direction(chip, offset, true);
+	ret = gpio_regmap_set_direction(chip, offset, true);
+	if (ret)
+		return ret;
+
+	/* Some controllers ignore data writes while the line is still an input. */
+	if (gpio->write_data_after_dir)
+		gpio_regmap_set(chip, offset, value);
+
+	return 0;
 }
 
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
@@ -311,6 +320,14 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (config->reg_dir_out_base && config->reg_dir_in_base)
 		return ERR_PTR(-EINVAL);
 
+	if (config->girq && config->irq_domain)
+		return ERR_PTR(-EINVAL);
+
+#ifdef CONFIG_REGMAP_IRQ
+	if (config->girq && config->regmap_irq_chip)
+		return ERR_PTR(-EINVAL);
+#endif
+
 	gpio = kzalloc_obj(*gpio);
 	if (!gpio)
 		return ERR_PTR(-ENOMEM);
@@ -376,6 +393,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 			    config->fixed_direction_output, chip->ngpio);
 	}
 
+	gpio->write_data_after_dir = config->write_data_after_dir;
+
 	/* if not set, assume there is only one register */
 	gpio->ngpio_per_reg = config->ngpio_per_reg;
 	if (!gpio->ngpio_per_reg)
@@ -390,6 +409,9 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (!gpio->reg_mask_xlate)
 		gpio->reg_mask_xlate = gpio_regmap_simple_xlate;
 
+	if (config->girq)
+		chip->irq = *config->girq;
+
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
 		goto err_free_bitmap_output;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 06255756710d..f94dd95d330f 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -7,6 +7,7 @@ struct device;
 struct fwnode_handle;
 struct gpio_regmap;
 struct gpio_chip;
+struct gpio_irq_chip;
 struct irq_domain;
 struct regmap;
 
@@ -34,6 +35,11 @@ struct regmap;
  * @ngpio_per_reg:	(Optional) Number of GPIOs per register
  * @irq_domain:		(Optional) IRQ domain if the controller is
  *			interrupt-capable
+ * @girq:		(Optional) Interrupt chip settings for the gpio_chip,
+ *			prepared by the driver as for a direct gpiochip
+ *			registration. The gpio_chip will then create and
+ *			manage its own IRQ domain. Mutually exclusive with
+ *			@irq_domain and @regmap_irq_chip.
  * @reg_mask_xlate:     (Optional) Translates base address and GPIO
  *			offset to a register/bitmask pair. If not
  *			given the default gpio_regmap_simple_xlate()
@@ -48,6 +54,11 @@ struct regmap;
  *			(Optional) Bitmap representing the fixed direction of
  *			the GPIO lines. Useful when there are GPIO lines with a
  *			fixed direction mixed together in the same register.
+ * @write_data_after_dir:
+ *			(Optional) Write the output value again after
+ *			switching a line to output in ->direction_output().
+ *			Needed for hardware which ignores data register
+ *			writes while the line is configured as an input.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -95,8 +106,10 @@ struct gpio_regmap_config {
 	int reg_stride;
 	int ngpio_per_reg;
 	struct irq_domain *irq_domain;
+	const struct gpio_irq_chip *girq;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
+	bool write_data_after_dir;
 
 #ifdef CONFIG_REGMAP_IRQ
 	struct regmap_irq_chip *regmap_irq_chip;

-- 
2.34.1


