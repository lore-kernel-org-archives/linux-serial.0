Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0ED49D5A6;
	Thu,  1 Oct 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858461; cv=none; b=A+Dk7ZWTMLLv11TmsMeU5gOsZ0I8DdOoUVDKakccYMnb3khbPlNzM1T9G9UXRysruzsx6zZISE7AJ+0tZt4CBBaU950yGgWf0Ke7cPI1mq7g0A933gDOR/QFfuF16lMBG9bQm497rUPkN9Ci5NB7aO5ryBmL6ibnjMYRFawlVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858461; c=relaxed/simple;
	bh=fGVHCZe9DlwBH9noY2QTBptVI7Ljju4biYMRrsgyXHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t+FkR3xDi8dZCrKPNSRClbnsKm/OnmCJ1Hln9cZjma7Zr7P2dvjSgX6hD9YWxR1fCiImOooXjIKXkIizyPlvCvACv5yczG0RLT2oMlUc3cyPWSVUXXHwtrghyTXFnr8RehzrJJ4DYS8HAmDDIJI09Xqhid9B1coI1YxIkByDDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo90uNYX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo90uNYX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCD02C4DDF6;
	Thu,  1 Oct 2026 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790858460;
	bh=fGVHCZe9DlwBH9noY2QTBptVI7Ljju4biYMRrsgyXHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Uo90uNYXs8jm6uHyxxyO+mZI5ulHRvk1JK5wBxCIDtmlCMP3u1xuWlGJXLUztIE21
	 BddR4DyCrdlLBv9mntyEclgRux0qpb2gU4l9WDvYKHRVmuFHjZN+v2hJAjL0tpCgOx
	 kPOydl+2SP83zsQOn6/01TSqF7niEQ9lZdseKs/m5Vq7vk4X4YEEbT1JHQ7virHAG+
	 1zf4dx7r4RnKWMM3b3Qc8KQiZ7s2CTcMhHW8g0ojsTgHuiYxKPUgyVKECRXb2nsss7
	 rLjR14r2p6PrNWFHFszkl8o12YpdnJf8KbSG16880d8OfEmlrFV3KZ3Q+gU3Qcs+1N
	 leMueH/+k0Fsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62BBCA5FCB;
	Thu,  1 Oct 2026 12:41:00 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 01 Oct 2026 20:40:56 +0800
Subject: [PATCH v9 07/15] gpiolib: regmap: add
 GPIO_REGMAP_QUIRK_SET_AFTER_DIR
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-cv75-v5-v9-7-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
In-Reply-To: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790858457; l=3373;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=IBa8epd2/4YpoCQ3nIa3WOdoI+AIcLQgC3bWWH4FGyQ=;
 b=PZWnOerKLdbdqt73Nvu/XDtzQRIy2lsM4PdHcH8CH5y17x+sAN9UWgrUMW9kuwNW4ypkuU9KS
 BEbgND5KgcxA55t3qvSMiTmFLGcNrwKlfOKDK0dmsavbSpK2QeFgd1b
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Some controllers ignore output writes while a line is still an input.
Add a behaviour flag so the output value is written after the direction
change. This is a legacy quirk. New hardware must not use it.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-regmap.c  | 15 +++++++++++++--
 include/linux/gpio/regmap.h | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 51b4d69b8740..728bf3d90c48 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -31,6 +31,7 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	unsigned long quirks;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
 
@@ -271,9 +272,17 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 			return ret;
 	}
 
-	gpio_regmap_set(chip, offset, value);
+	if (!(gpio->quirks & GPIO_REGMAP_QUIRK_SET_AFTER_DIR))
+		gpio_regmap_set(chip, offset, value);
 
-	return gpio_regmap_set_direction(chip, offset, true);
+	ret = gpio_regmap_set_direction(chip, offset, true);
+	if (ret)
+		return ret;
+
+	if (gpio->quirks & GPIO_REGMAP_QUIRK_SET_AFTER_DIR)
+		gpio_regmap_set(chip, offset, value);
+
+	return 0;
 }
 
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
@@ -376,6 +385,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 			    config->fixed_direction_output, chip->ngpio);
 	}
 
+	gpio->quirks = config->quirks;
+
 	/* if not set, assume there is only one register */
 	gpio->ngpio_per_reg = config->ngpio_per_reg;
 	if (!gpio->ngpio_per_reg)
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 06255756710d..e5a343512efb 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_GPIO_REGMAP_H
 #define _LINUX_GPIO_REGMAP_H
 
+#include <linux/bits.h>
+
 struct device;
 struct fwnode_handle;
 struct gpio_regmap;
@@ -13,6 +15,14 @@ struct regmap;
 #define GPIO_REGMAP_ADDR_ZERO ((unsigned int)(-1))
 #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
 
+/*
+ * Write the output value after the line is switched to output.
+ * Needed when hardware ignores output writes while the line is an input.
+ * This is a legacy quirk; new hardware must not use it. Direction changes
+ * will glitch.
+ */
+#define GPIO_REGMAP_QUIRK_SET_AFTER_DIR BIT(0)
+
 /**
  * struct gpio_regmap_config - Description of a generic regmap gpio_chip.
  * @parent:		The parent device
@@ -24,6 +34,7 @@ struct regmap;
  *			If not given, the name of the device is used.
  * @ngpio:		(Optional) Number of GPIOs
  * @names:		(Optional) Array of names for gpios
+ * @quirks:		(Optional) Behaviour flags, OR of GPIO_REGMAP_QUIRK_*.
  * @reg_dat_base:	(Optional) (in) register base address
  * @reg_set_base:	(Optional) set register base address
  * @reg_clr_base:	(Optional) clear register base address
@@ -87,6 +98,9 @@ struct gpio_regmap_config {
 	int ngpio;
 	const char *const *names;
 
+	/* Regmap GPIO behaviour flags */
+	unsigned long quirks;
+
 	unsigned int reg_dat_base;
 	unsigned int reg_set_base;
 	unsigned int reg_clr_base;

-- 
2.34.1


