Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4274496D3F;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470941; cv=none; b=ChE68L+JXnJO/YgydU189sfVa/BcVdZVChM6vY61A6Mrh+uFNXgMVAxhzkwvAgdmNlvtbWU4UoKC7MrRWmGadsrMhi+n2A94gJWO8Dny4BQJiij0gRFf9UD3dHoqCwt7YqlvWXa28OmI+/Xig2P/q9WcWlOss3iWHrmX2llFC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470941; c=relaxed/simple;
	bh=VayeLJi6dF/5DfY+Xg7ilDAh5xT1Cx0pCzYaDRReLiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pMPhXIDQ/LRMzJ70OVpgjBeaIu0S3DJNkZvIX4j6CncZFY0kXNlX9XFrM8trEM4iVm6xvtayFUZKN21E0U6mDypaiCRZt3+g2mCxEEYZOf5wtmMf0RNJplQQfk6M4nRa4fjCIBTI/q7VvAglk9VTGV/fLY5+3Q7hlPr3DaZgQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOLJaYpd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOLJaYpd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 530F0C4AF65;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789470941;
	bh=VayeLJi6dF/5DfY+Xg7ilDAh5xT1Cx0pCzYaDRReLiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WOLJaYpdfs4XlGqHDPe6PaqUJv60fneV2vOF9lS5avSdaeDFyucf8iSg2DkArz2nm
	 1opbFJnZYV8yFtZiwOKCrjQQLoK3BUgUX6IX/XFqzJkQHeYRrjaOuW7FcL2fBV6nYA
	 m8+ZJWeyDaulFnuTAqcykeg8VKfzD4GlvNYQTry+2XWa73q/2AqJOD/rK1ag4o53Bf
	 HSC9irI1limkbn/fnLwtVzRlBo+gcH3pxjQzsoj9xMkHsPBB53FQlv8L76FAW7e3oW
	 kgztNwLKR1MCKUy3/gFJ2WWcEU8dWAcifGGd6mUP9tKddbZw7k7/vMZ1Fmc9K/Vvcj
	 EjsCy8uxcQirg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F686C88E7F;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 15 Sep 2026 19:15:38 +0800
Subject: [PATCH v7 08/15] gpiolib: regmap: add write_data_after_dir quirk
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-cv75-v5-v7-8-3297d3fbc9c0@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789470938; l=3083;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=G8eJneH1FEGvIrQmo2BCujbmuD8SZZsDUEFPHDAW3B8=;
 b=I0+BtY/IonIrgaL+mpBYWVB7SCJp5ipOngd4RH40wiQK4hLcT8kkwCrhV9Ovw0BQ6IEPAVEMN
 E6hTkDzmqnlAso1wmlTsMAiehCpESh997U4Ue2sXCIOaE/LCS6p5a8M
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Some controllers ignore data-register writes while a line is still an
input. Optionally write the output value again after switching the
direction, matching the existing PL061 behaviour.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-regmap.c  | 20 ++++++++++++++++++--
 include/linux/gpio/regmap.h |  8 ++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 51b4d69b8740..dfcc1f1122ec 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -31,6 +31,7 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	bool write_data_after_dir;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
 
@@ -271,9 +272,22 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 			return ret;
 	}
 
-	gpio_regmap_set(chip, offset, value);
+	ret = gpio_regmap_set(chip, offset, value);
+	if (ret)
+		return ret;
+
+	ret = gpio_regmap_set_direction(chip, offset, true);
+	if (ret)
+		return ret;
 
-	return gpio_regmap_set_direction(chip, offset, true);
+	/*
+	 * gpio value is set again, because pl061 doesn't allow to set value of
+	 * a gpio pin before configuring it in OUT mode.
+	 */
+	if (gpio->write_data_after_dir)
+		return gpio_regmap_set(chip, offset, value);
+
+	return 0;
 }
 
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
@@ -376,6 +390,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 			    config->fixed_direction_output, chip->ngpio);
 	}
 
+	gpio->write_data_after_dir = config->write_data_after_dir;
+
 	/* if not set, assume there is only one register */
 	gpio->ngpio_per_reg = config->ngpio_per_reg;
 	if (!gpio->ngpio_per_reg)
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 06255756710d..d7ffc12b00a2 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -48,6 +48,13 @@ struct regmap;
  *			(Optional) Bitmap representing the fixed direction of
  *			the GPIO lines. Useful when there are GPIO lines with a
  *			fixed direction mixed together in the same register.
+ * @write_data_after_dir:
+ *			(Optional) Write the output value again after
+ *			switching a line to output in ->direction_output().
+ *			Needed for hardware which ignores data register
+ *			writes while the line is configured as an input.
+ *			This is a legacy quirk (e.g. ARM PL061); new hardware
+ *			must not use it. Direction changes will glitch.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -94,6 +101,7 @@ struct gpio_regmap_config {
 	unsigned int reg_dir_out_base;
 	int reg_stride;
 	int ngpio_per_reg;
+	bool write_data_after_dir;
 	struct irq_domain *irq_domain;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;

-- 
2.34.1


