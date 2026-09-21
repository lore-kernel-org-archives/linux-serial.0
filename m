Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F32368D40;
	Mon, 21 Sep 2026 04:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964613; cv=none; b=Xh+FYWfkcQjy0WKgNGvYVbdFpsJCt9q0nOfxpn1jIWzUxLNOrzzVHZzBnaZZblLwZb9SDTUmMdUw1FHW9SINYhxPXFe5NeTzhNEXYu6MOtZ+ByJ07DyrL8Aqp7YqBzLLRSryHULjDU28+uGUBW0OPFveDAwVZxM7yxJnn9X5d4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964613; c=relaxed/simple;
	bh=wZJacq8lp2xyUvHx/P8R2wnBwb1XTZEAMLxLNmfihS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3VjI25MiP7P+CbbdnRGI8lgAeCSl2d2i7HGkI3KP0rjGBWZRpB3P0WmQq8QImVssRpD9pJGZeQhzw+epb5eb3K9x3Sjne8BW9CcN0sb77fZitPxWOv7IYY+H0Wu7uo5vWqjPe8pomzb7fykAZ4y1il8+JP/wpLXM5ZAZecOpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyvixlXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyvixlXs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FD7DC4AF18;
	Mon, 21 Sep 2026 04:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789964613;
	bh=wZJacq8lp2xyUvHx/P8R2wnBwb1XTZEAMLxLNmfihS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jyvixlXsv42CK6y6Vs7GUIBsNb/Oj7ZNwIaHWyxhFoMPJ2N6nU3KnnI4L4dS16Gqb
	 1mRweQrpsGkQK9ghR/R785FFAhEFbbvj54oQj3Dqvp91VRZ0yyB4uZDqLJ2xW7eVN7
	 irtkN2Ra8ZALN17584kl+5RYf2HF7YuY+AwMSqDG7Uf8JuQSQghQL9BUZ7aUVZH7xw
	 22683jDVVnkbtYJYSULnM2Tzsd93KoTuL3ufJblpfyFWS30BE4YwVV0EiIQPguigdB
	 4vcJ3Fm6/xV5oMLCn26IQ47KEhj49CQTt/VjVac6PVK98Y0FY69MRud/t2czhhKWbj
	 +EWpCoFXOTLBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C32EC982F4;
	Mon, 21 Sep 2026 04:23:33 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 21 Sep 2026 12:23:31 +0800
Subject: [PATCH v8 12/18] gpio: pl061: use cleanup helpers for locks
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-cv75-v5-v8-12-282ff5d98dda@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789964608; l=3385;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=ii3oagWoRbkwRTyfP9uldtzy1qla8tAAWfRUevUse2E=;
 b=gdrZwOZPCUMN1JNeNnP15TEcY5an0TzacNkglL5E7oj8FKI1dtcC9UZp9WqFecEqc5CAm688Q
 Q0uaB6zaTorDlEmU0Vf6+S4N/q7rtnbd8JEtV0Zq+kzwyKvga4GNKl3
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Convert raw_spinlock critical sections to guard() from cleanup.h.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-pl061.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 2913daf46aff..c821a5117eed 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -10,6 +10,7 @@
  */
 #include <linux/amba/bus.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
@@ -103,11 +104,9 @@ static int pl061_get_direction(struct gpio_chip *gc, unsigned offset)
 static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	struct pl061 *pl061 = gpiochip_get_data(gc);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pl061->lock, flags);
+	guard(raw_spinlock_irqsave)(&pl061->lock);
 	regmap_update_bits(pl061->regmap, GPIODIR, BIT(offset), 0);
-	raw_spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
 }
@@ -116,10 +115,9 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
 		int value)
 {
 	struct pl061 *pl061 = gpiochip_get_data(gc);
-	unsigned long flags;
 	unsigned int mask = BIT(offset);
 
-	raw_spin_lock_irqsave(&pl061->lock, flags);
+	guard(raw_spinlock_irqsave)(&pl061->lock);
 	regmap_write(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
 		     !!value << offset);
 	regmap_update_bits(pl061->regmap, GPIODIR, mask, mask);
@@ -130,7 +128,6 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
 	 */
 	regmap_write(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
 		     !!value << offset);
-	raw_spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
 }
@@ -160,7 +157,6 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 	int offset = irqd_to_hwirq(d);
-	unsigned long flags;
 	unsigned int gpiois = 0, gpioibe = 0, gpioiev = 0;
 	unsigned int bit = BIT(offset);
 
@@ -176,7 +172,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	}
 
 
-	raw_spin_lock_irqsave(&pl061->lock, flags);
+	guard(raw_spinlock_irqsave)(&pl061->lock);
 
 	regmap_read(pl061->regmap, GPIOIEV, &gpioiev);
 	regmap_read(pl061->regmap, GPIOIS, &gpiois);
@@ -236,7 +232,6 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	regmap_write(pl061->regmap, GPIOIBE, gpioibe);
 	regmap_write(pl061->regmap, GPIOIEV, gpioiev);
 
-	raw_spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
 }
@@ -269,9 +264,8 @@ static void pl061_irq_mask(struct irq_data *d)
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 
-	raw_spin_lock(&pl061->lock);
+	guard(raw_spinlock)(&pl061->lock);
 	regmap_update_bits(pl061->regmap, GPIOIE, mask, 0);
-	raw_spin_unlock(&pl061->lock);
 
 	gpiochip_disable_irq(gc, d->hwirq);
 }
@@ -284,9 +278,8 @@ static void pl061_irq_unmask(struct irq_data *d)
 
 	gpiochip_enable_irq(gc, d->hwirq);
 
-	raw_spin_lock(&pl061->lock);
+	guard(raw_spinlock)(&pl061->lock);
 	regmap_update_bits(pl061->regmap, GPIOIE, mask, mask);
-	raw_spin_unlock(&pl061->lock);
 }
 
 /**

-- 
2.34.1


