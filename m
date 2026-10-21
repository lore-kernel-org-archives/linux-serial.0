Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599160;
	b=SMZzcYbbH3h0b5opcCmkCICzZMZLw1vuXeXJEai2E3rjmvlhHYOjyTqohaiP5+8V13J9
	 HzjjUAzm/uzQ+xDpaapD3br89skrimyHKjX/2d1j554m0NISomTjlFFT4TuNejrJBcMJN
	 kb78bgKOW2OYDVHwjixTNFX8N3Urkbwv3Ihc2AzMT43uD+93oDSHHeBYWm3iyhU43K2Gw
	 b+Y9zcrs6To/EUW+H9y1wpxxc9TvjzjXk0eOxdyoS1hvNh6uEp/qhqCuF9bXIs3obzhWx
	 XCHOwUU3UdBeHvN1vrWkotuhdFU4Aa/HMrQuTh9ioThUGnNRdSkHz4gC2Z5FNa0Ba3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599160;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vf7ZK5u2reB6Du+GchqoDahqBht5sD1HLOrfvrlTUKY=;
	b=H68gkx/cH5bCNroTRCENHIdivuW0JR3ASilGLDpdIwhaxNQCwMHGLMBEwxV7vltn6kX5
	 hCZ9pdXZj1qUbWZUKhPXEKXFNFvriLE1jxvkNpTd8ZbgMv//vBYIt/WfHOmOGm+il7nv5
	 zsFlc6Z/j8/Q7+wPbw0SwIpg9IBpQhxPBN7U0RRdeBQZl7Nru9Y+tTrilHKkRNAP0Iy9Y
	 Ws7IoBR+NnhKxAYb+ZzMgOwZNJP24BUAm/SzBXfVdrCpG0LHDFIbcTye7pKud3Vm8TKpA
	 Xa9PZFZbkp2Z4toADWQKNNZWP/BOXMnDPga4aR1f8/+xo6rv6Q2zrJcPB3laRl4Wlvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnH0av5Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ACC60A6F7F;
	Wed, 21 Oct 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnH0av5Y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599159;
	b=1pTeWa1a3RLVUHQGdGyIbI/V0UICqVW2xu+M5TdbOuAWpNujPxf5KR3ttQXHf8TqMTqV
	 UYb65W9rfiAj2YbfEOOvahrOO0OusQAmyYvXm66UZkN2/lhVn75G/n2O3drQmIp+rAkkO
	 5BsHRFt6UWJ9buiZAS1pXIeliyyLAAIgcUlU27nlvvpLrl9cb+Zq7dRkmIRPgQO62vLeZ
	 QTa/LOPNBCZvLdf2qWFGIaDT3R80VrNThbwRXvGTegLIgNJ1B7p7Ev+vLAnEhvAsjvObs
	 PNjElTh1x4hYDigNr/exREJtdaT16j9rWWNtvj4BWr25rAlL8o0Chud8aYwZ6fA7MRA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599159;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vf7ZK5u2reB6Du+GchqoDahqBht5sD1HLOrfvrlTUKY=;
	b=YWCE2/skF/gufk2njo4Y9j7kmVADGcmJemqNcZNLeb9va0rEe+xK+i0wmZJHezsgB8PU
	 Qjehy+JqnjGn9c80CZzvG2o2s5oluPVja90QMm/RrNtRBvVXlv1aNcBAr+ARECUNe292h
	 YF9/KArV7JVc02WSCr5/OJ3okwSyNM+a/936WO2PK4mMabjzv8GdamRc+aQh9QN2uSZvk
	 gefJJUD0TZwvwhi0bZjaXolMgQPDgvDi9oBvrsBWdR7CJ/zeOVSwekvD55MqpcWFNANNS
	 +1WcaCQBM6q26nyscxjCscSXkDnJxoZZl7RgGRgC0KWRTXCzZ9QOw0GWCQqU9sWp6Eg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DD1A91F000C6;
	Wed, 21 Oct 2026 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599159;
	bh=vf7ZK5u2reB6Du+GchqoDahqBht5sD1HLOrfvrlTUKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YnH0av5YWgdoQDB1nrbyUOA2TTX9n9H5o8YiaHuseuqY7olCSlcYZXFK7QmJtInnd
	 KBbDceaObr8wHuM+1I7eMlKH0E4ZKo3dpdwFHA+U+5JrMp8we5+aJrF2POmHaFAMT/
	 4fDmXpRrBcQ612JVlzW9Jo3NPmsrZd6Kn4V6JbVncH9pj5in0x8p4cQlpj2LjEx3vT
	 xjuM53RUs6Pk6CFwhhz864l/PyNqQjhe+pif+Y+eoBmfbQkqiEzKy4TopKGiC6Or//
	 FSfLHWz3YwQtaTqndC9lENpPpFLWvVH15ZVtCdfzRZv9uY6suTTD219izo99ksfUM6
	 zNN9QmJKB2AnA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4A8DC433C1;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:06 +0800
Subject: [PATCH 09/27] gpio: rockchip: Add RK3572 GPIO support
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-add-board-ok3572-c-v1-9-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=7782;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=ybuMjroqWlGrhbZ7b+7+3KlQvwUxXnFSIMLjfQO0hew=;
 b=RqtBCE+OwGqzr9ILJLcWOVv41u5fPijhMaXsMt68lHeN6E3KIkhV5WLpGINhA51ZzleGRQUis
 c3ga1PlIquNDkoeUSPuKbs2jgMY8vIykxHmYjoi3qmQQiuIcfdpIuu0
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Support GPIO V2.7, four parent interrupts, and firmware-provided
interrupt-group masks. Keep all pins on the primary interrupt when group
queries are unavailable.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/gpio/gpio-rockchip.c        | 91 +++++++++++++++++++++++++++++++++----
 drivers/pinctrl/pinctrl-rockchip.h  |  8 +++-
 include/soc/rockchip/rockchip_sip.h |  5 ++
 3 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 77b239a9a601e..35894a68b5446 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -21,6 +22,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <soc/rockchip/rockchip_sip.h>
 
 #include "../pinctrl/core.h"
 #include "../pinctrl/pinctrl-rockchip.h"
@@ -35,6 +37,7 @@
 #define GPIO_TYPE_V2		(0x01000C2B)
 #define GPIO_TYPE_V2_1		(0x0101157C)
 #define GPIO_TYPE_V2_2		(0x010219C8)
+#define GPIO_TYPE_V2_7		(0x01074D2E)
 
 static const struct rockchip_gpio_regs gpio_regs_v1 = {
 	.port_dr = 0x00,
@@ -209,12 +212,27 @@ static int rockchip_gpio_set_debounce(struct gpio_chip *gc,
 	if (bank->gpio_type == GPIO_TYPE_V2 && !IS_ERR(bank->db_clk)) {
 		div_debounce_support = true;
 		freq = clk_get_rate(bank->db_clk);
-		max_debounce = (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
-		if (debounce > max_debounce)
-			return -EINVAL;
 
-		div = debounce * freq;
-		div_reg = DIV_ROUND_CLOSEST_ULL(div, 2 * USEC_PER_SEC) - 1;
+		if (of_device_is_compatible(bank->of_node, "rockchip,rk3572-gpio-bank")) {
+			if (!freq)
+				return -EINVAL;
+
+			div = (u64)(GENMASK(23, 0) + 1) * USEC_PER_SEC;
+			max_debounce = div_u64(div, 2 * freq);
+			if (debounce > max_debounce)
+				return -EINVAL;
+
+			div = (u64)debounce * freq * 2;
+			div_reg = DIV_ROUND_CLOSEST_ULL(div, USEC_PER_SEC);
+			div_reg = div_reg ? div_reg - 1 : 0;
+		} else {
+			max_debounce = (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
+			if (debounce > max_debounce)
+				return -EINVAL;
+
+			div = debounce * freq;
+			div_reg = DIV_ROUND_CLOSEST_ULL(div, 2 * USEC_PER_SEC) - 1;
+		}
 	} else {
 		div_debounce_support = false;
 	}
@@ -342,6 +360,12 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	pending = readl_relaxed(bank->reg_base + bank->gpio_regs->int_status);
+	for (unsigned int i = 0; i < bank->nr_irqs; i++) {
+		if (bank->irqs[i] == irq_desc_get_irq(desc)) {
+			pending &= bank->irq_masks[i];
+			break;
+		}
+	}
 	for_each_set_bit(irq, &pending, 32) {
 		dev_dbg(bank->dev, "handling irq %d\n", irq);
 
@@ -568,8 +592,9 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	rockchip_gpio_writel(bank, 0xffffffff, bank->gpio_regs->int_en);
 	gc->mask_cache = 0xffffffff;
 
-	irq_set_chained_handler_and_data(bank->irq,
-					 rockchip_irq_demux, bank);
+	for (unsigned int i = 0; i < bank->nr_irqs; i++)
+		irq_set_chained_handler_and_data(bank->irqs[i],
+						 rockchip_irq_demux, bank);
 
 	return 0;
 }
@@ -645,6 +670,36 @@ static void rockchip_clk_put(void *data)
 	clk_put(clk);
 }
 
+static int rockchip_gpio_read_irq_groups(struct rockchip_pin_bank *bank)
+{
+	struct arm_smccc_res res;
+	u32 assigned = 0;
+	int status;
+
+	for (unsigned int i = 1; i < bank->nr_irqs; i++) {
+		arm_smccc_smc(ROCKCHIP_SIP_GPIO_CONFIG, ROCKCHIP_SIP_GPIO_GET_GROUP,
+			      bank->bank_num, i, 0, 0, 0, 0, &res);
+		status = (int)res.a0;
+		if (i == 1 && (status == SMCCC_RET_NOT_SUPPORTED ||
+			       status == ROCKCHIP_SIP_RET_NOT_SUPPORTED)) {
+			/* Older firmware leaves all pins on the primary IRQ. */
+			dev_dbg(bank->dev, "GPIO group query unsupported: %d\n",
+				status);
+			break;
+		}
+		if (status)
+			return dev_err_probe(bank->dev, -EIO,
+					     "cannot read interrupt group %u: %d\n",
+					     i, status);
+		bank->irq_masks[i] = res.a1;
+		if (assigned & bank->irq_masks[i])
+			return -EINVAL;
+		assigned |= bank->irq_masks[i];
+	}
+	bank->irq_masks[0] = ~assigned;
+	return 0;
+}
+
 static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 {
 	struct platform_device *pdev = to_platform_device(bank->dev);
@@ -654,10 +709,23 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	if (IS_ERR(bank->reg_base))
 		return PTR_ERR(bank->reg_base);
 
-	ret = platform_get_irq(pdev, 0);
+	ret = platform_irq_count(pdev);
 	if (ret < 0)
 		return ret;
-	bank->irq = ret;
+	if (ret != (of_device_is_compatible(bank->of_node,
+					    "rockchip,rk3572-gpio-bank") ? 4 : 1))
+		return -EINVAL;
+	bank->nr_irqs = ret;
+	for (unsigned int i = 0; i < bank->nr_irqs; i++) {
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
+			return ret;
+		bank->irqs[i] = ret;
+	}
+
+	ret = rockchip_gpio_read_irq_groups(bank);
+	if (ret)
+		return ret;
 
 	bank->clk = devm_clk_get_enabled(bank->dev, NULL);
 	if (IS_ERR(bank->clk))
@@ -669,6 +737,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	case GPIO_TYPE_V2:
 	case GPIO_TYPE_V2_1:
 	case GPIO_TYPE_V2_2:
+	case GPIO_TYPE_V2_7:
 		bank->gpio_regs = &gpio_regs_v2;
 		bank->gpio_type = GPIO_TYPE_V2;
 		bank->db_clk = of_clk_get(bank->of_node, 1);
@@ -797,7 +866,8 @@ static void rockchip_gpio_remove(struct platform_device *pdev)
 {
 	struct rockchip_pin_bank *bank = platform_get_drvdata(pdev);
 
-	irq_set_chained_handler_and_data(bank->irq, NULL, NULL);
+	for (unsigned int i = 0; i < bank->nr_irqs; i++)
+		irq_set_chained_handler_and_data(bank->irqs[i], NULL, NULL);
 	if (bank->domain) {
 		irq_domain_remove_generic_chips(bank->domain);
 		irq_domain_remove(bank->domain);
@@ -807,6 +877,7 @@ static void rockchip_gpio_remove(struct platform_device *pdev)
 
 static const struct of_device_id rockchip_gpio_match[] = {
 	{ .compatible = "rockchip,gpio-bank", },
+	{ .compatible = "rockchip,rk3572-gpio-bank" },
 	{ .compatible = "rockchip,rk3188-gpio-bank0" },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 553197f6dc690..058b58dcde404 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -302,7 +302,9 @@ struct rockchip_drv {
  *	    bank has its own IOC block
  * @clk: clock of the gpio bank
  * @db_clk: clock of the gpio debounce
- * @irq: interrupt of the gpio bank
+ * @irqs: parent interrupts of the GPIO bank
+ * @irq_masks: pins assigned to each parent interrupt
+ * @nr_irqs: number of parent interrupts
  * @saved_masks: Saved content of GPIO_INTEN at suspend time.
  * @pin_base: first pin number
  * @nr_pins: number of pins in this bank
@@ -331,7 +333,9 @@ struct rockchip_pin_bank {
 	struct regmap			*regmap_ioc;
 	struct clk			*clk;
 	struct clk			*db_clk;
-	int				irq;
+	unsigned int			irqs[4];
+	u32				irq_masks[4];
+	unsigned int			nr_irqs;
 	u32				saved_masks;
 	u32				pin_base;
 	u8				nr_pins;
diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
index 501ad1fedb201..984272ede3baf 100644
--- a/include/soc/rockchip/rockchip_sip.h
+++ b/include/soc/rockchip/rockchip_sip.h
@@ -20,4 +20,9 @@
 #define ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM	0x07
 #define ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD	0x08
 
+#define ROCKCHIP_SIP_RET_NOT_SUPPORTED		-2
+
+#define ROCKCHIP_SIP_GPIO_CONFIG		0x8200002c
+#define ROCKCHIP_SIP_GPIO_GET_GROUP		0
+
 #endif

-- 
2.34.1


