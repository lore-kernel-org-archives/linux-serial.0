Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52ED35E1AC;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964612; cv=none; b=fxdQaAvsivKjnaZh6KN550FKfWpbA7itRnK6tLh1g2eUsOPZNPekhIDlCdMmpXoTeBMPPvr+1iBKaQcC2aA09OF6xuOyjk6tM4K43NpWDR64J/0MY96kTPDtzRBZZtuc+bf4GBJO5D1qIoaM/mqqqvEGGaXSEW+qSkQlj8V/7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964612; c=relaxed/simple;
	bh=jvbL/2RiMhg7JLG9DBXG5C6oQ3baY2PtbvCk8gshE7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdWKXZ8/XD9LciNSOCOBHh410NRQlVf55iNtdXw/FXhCPCAGOhRdN+F74Bs5HuTtq5L6AclnhbcnpQgu5eT1iebuh3WWlQ0cN52YBlCsVfVTDbazTbf6IFuRJe/beGVgNP+t9d6OcfjooslNbuOAd1+PwD05BokPvs1c7GUMEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phF9+0Q2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phF9+0Q2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F08AC2BCFD;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789964612;
	bh=jvbL/2RiMhg7JLG9DBXG5C6oQ3baY2PtbvCk8gshE7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=phF9+0Q2K4HXelrK4K49nidam5whFox+Kjs9MzfpeY95KmUrrLLBxaaMO9ZzIniUL
	 JcGJNuMA8EMYzu5MrMsCT0ofTWgv+VGl6rjgbQA0NE/Gvv7oyoadDjZI8jPuY1/JTK
	 Y2AnkBcRvzNMMy1ADCVjT6cq2E06bk5ennI/TBQU1TxFyqrJNWmKPhxoMTKR9YEe4M
	 CM7uv/yh51bqdJq7YGbKD4B8+qsEdC6dIbkIO4GIu3b/GuSLMgTe9fbwG5uiCkSByD
	 2eh6ChfJjprXR7Vs4WVbAgFgb4p85176q43ra0Rf3Mj3qYiTwwPF0KY2XoufJ9mgnt
	 Ty7lEyWa2NKTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68354C982F2;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 21 Sep 2026 12:23:27 +0800
Subject: [PATCH v8 08/18] gpiolib: regmap: add write_data_after_dir quirk
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-cv75-v5-v8-8-282ff5d98dda@ambarella.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789964608; l=3092;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=fpAj3vMXjZmURWyfts5CtyfyhTDoS5mn512oJA6h2aY=;
 b=e+MsuppDlgpjoNWogF4SShQN6eYtdesHSzDj+4r/pX+nVj5fmsfe+JIJpzHDyZ0LZ8NJ/XwPo
 I2z4VDEPGc2DvMHBbmioeZ8u/yVtTANgbGaSMPr/HFraoL+ryizimzx
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
 drivers/gpio/gpio-regmap.c  | 19 +++++++++++++++++--
 include/linux/gpio/regmap.h |  8 ++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 51b4d69b8740..fbd4c753525a 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -31,6 +31,7 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	bool write_data_after_dir;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
 
@@ -271,9 +272,21 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 			return ret;
 	}
 
-	gpio_regmap_set(chip, offset, value);
+	if (!gpio->write_data_after_dir)
+		gpio_regmap_set(chip, offset, value);
 
-	return gpio_regmap_set_direction(chip, offset, true);
+	ret = gpio_regmap_set_direction(chip, offset, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * Some controllers ignore data-register writes while the line is
+	 * still an input. Write the output value after switching direction.
+	 */
+	if (gpio->write_data_after_dir)
+		gpio_regmap_set(chip, offset, value);
+
+	return 0;
 }
 
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
@@ -376,6 +389,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
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


