Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B8493D2B;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470941; cv=none; b=gwlGaDkd66M1SkbKbxQltWZmAaNZYXk0DIY3kNgIudq8iiOZxYebzmQw8N7ZUL64EDRoxeOE/lqmqA/03EuXeJCHtzKuGBx2Fqfz6kdX+HPO+hkz9Q3Ei4qslzfTuiCw4QcdKP0KDZ4n4ojIHjuGSoCqbrbIt9jxOoZXvUuc5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470941; c=relaxed/simple;
	bh=tvheqHsmI7hix28b7pr10B/Z5B5TUMz+iHESIt74yC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hY9sZBODyqz3HbzA7PHHJqOIi26tD43KblbeQxYl+pJcAXkixVQ7zc0FTh6hS6otn1yFG66VFRNyO5Xd+9px+3njUc4xP3RIZv+uQKcqBwZZrBafQ7FBt75j325ilSlU3fPBf73BFkDhSrkhrNxhUHoKx7LEDjpeMZlmCaog+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3c+g94X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3c+g94X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 133D3C2BD01;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789470941;
	bh=tvheqHsmI7hix28b7pr10B/Z5B5TUMz+iHESIt74yC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H3c+g94XiiVNtus0seIIE8ncWHU/pM6q0h3tIXhTRNDGWe1VxWhXvKTdyQDBskxxA
	 vgyRdyPi/I0qT+MVxG9LzvrZbOULF6K5KGyncO2eQmih3GbW9RWJECcfZsf6u4KJOa
	 iNzEbFjUNFj/w+E+UVci6jRmfbVjOoh7hzXQaiLNfK+kVwvyL2O7ONjR1BnFQLuEeu
	 ablJk+4tc6a+OIxMqAJ28wptyJEhDtsFiE59O1D0M6pbRuk6eKlDc6BjJPLBvKVSOe
	 85AlXK3OJXI84afmfPWCshKJAaFOlI6E9+9EmZrP02HdMfCuO//ZAjYHmyMmLI6bTP
	 EQaKYtOYUaVhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C87C982C3;
	Tue, 15 Sep 2026 11:15:40 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 15 Sep 2026 19:15:34 +0800
Subject: [PATCH v7 04/15] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-cv75-v5-v7-4-3297d3fbc9c0@ambarella.com>
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
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789470938; l=6407;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=dt26uw9gyEL6VIYot6EABDm601cc1K43aUBkL9kWh+Y=;
 b=i9FBFOZ1WLi4Rq6q8sTwQtrG7vlh21JxFXMtrQX2HKilUO953+33lzYf5m20WLcoElWHoZLfO
 6EJvUisKQWsBCtH5Uwl1C4/wyXPryrYlMFj1ArqqrKOpizASONhYtrx
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Document the CV75 pin controller binding using generic function and
groups properties for pinmux configuration.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../bindings/pinctrl/ambarella,cv75-pinctrl.yaml   | 237 +++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
new file mode 100644
index 000000000000..ee464a0f80d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
@@ -0,0 +1,237 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/ambarella,cv75-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella CV75 Pin Controller
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+description:
+  The Ambarella CV75 pin controller configures pin multiplexing, bias and
+  drive strength for the main GPIO banks. Pin groups and their mux settings
+  are defined by the pin controller driver and selected by function and group
+  names.
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    const: ambarella,cv75-pinctrl
+
+  reg:
+    maxItems: 1
+    description: IOMUX registers
+
+  ambarella,drive-strength-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: RCT syscon containing the drive-strength registers.
+
+  ambarella,pull-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Secure scratchpad syscon containing the pull registers.
+
+patternProperties:
+  "^[a-z0-9-]+-pins$":
+    type: object
+    allOf:
+      - $ref: pinmux-node.yaml#
+      - $ref: pincfg-node.yaml#
+    additionalProperties: false
+
+    properties:
+      function:
+        enum:
+          - can0
+          - can1
+          - dmic0
+          - enet0
+          - hsync0
+          - hsync1
+          - i2c0
+          - i2c1
+          - i2c2
+          - i2c3
+          - i2cs
+          - i2s0
+          - i2s1
+          - ir
+          - pwm0
+          - pwm1
+          - pwm2
+          - pwm3
+          - pwm4
+          - pwm5
+          - pwm6
+          - pwm7
+          - pwm8
+          - pwm9
+          - pwm10
+          - pwm11
+          - sdmmc0
+          - sdmmc1
+          - snand
+          - spi0
+          - spi1
+          - spi2
+          - spi3
+          - spi_slave
+          - spinor
+          - uart0
+          - uart1
+          - uart2
+          - uart3
+          - uart4
+          - vin_master_sync
+          - vsync0
+          - vsync1
+          - vsync2
+          - vsync3
+          - wdt
+
+      groups:
+        items:
+          enum:
+            - can0
+            - can1
+            - dmic0
+            - enet_2nd_ref_clk_a
+            - enet_2nd_ref_clk_b
+            - enet_ext_osc_clk
+            - enet0_ptp_pps_o
+            - hsync0
+            - hsync1
+            - i2c0_a
+            - i2c0_b
+            - i2c1_a
+            - i2c1_b
+            - i2c2
+            - i2c3_a
+            - i2c3_b
+            - i2c3_c
+            - i2cs_a
+            - i2cs_b
+            - i2cs_c
+            - i2cs_d
+            - i2s0
+            - i2s1
+            - ir
+            - pwm0
+            - pwm1
+            - pwm2
+            - pwm3
+            - pwm4_a
+            - pwm4_b
+            - pwm5_a
+            - pwm5_b
+            - pwm6_a
+            - pwm6_b
+            - pwm7_a
+            - pwm7_b
+            - pwm8_a
+            - pwm8_b
+            - pwm9_a
+            - pwm9_b
+            - pwm10_a
+            - pwm10_b
+            - pwm11_a
+            - pwm11_b
+            - rgmii0
+            - rmii0
+            - sdmmc0_1bit
+            - sdmmc0_4bit
+            - sdmmc0_cd
+            - sdmmc0_hs_sel
+            - sdmmc0_reset
+            - sdmmc0_wp
+            - sdmmc1_1bit
+            - sdmmc1_4bit
+            - sdmmc1_cd
+            - sdmmc1_hs_sel
+            - sdmmc1_reset
+            - sdmmc1_wp
+            - snand
+            - spi0
+            - spi1
+            - spi2
+            - spi3_a
+            - spi3_b
+            - spi3_c
+            - spi_slave_a
+            - spi_slave_b
+            - spi_slave_c
+            - spi_slave_d
+            - spi_slave_e
+            - spinor
+            - uart0
+            - uart1
+            - uart1_flow
+            - uart2_a
+            - uart2_b
+            - uart2_c
+            - uart2_flow_a
+            - uart2_flow_b
+            - uart3_a
+            - uart3_b
+            - uart3_flow_a
+            - uart3_flow_b
+            - uart4_a
+            - uart4_b
+            - uart4_flow_a
+            - uart4_flow_b
+            - vin_master_sync_a
+            - vin_master_sync_b
+            - vin_master_sync_c
+            - vin_master_sync_d
+            - vin_master_sync_e
+            - vsync0
+            - vsync1
+            - vsync2
+            - vsync3
+            - wdt_a
+            - wdt_b
+            - wdt_c
+            - wdt_d
+            - wdt_e
+            - wdt_f
+        minItems: 1
+        maxItems: 6
+        uniqueItems: true
+
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+
+      drive-strength:
+        enum: [3, 4, 5, 6, 7, 8, 9, 12]
+
+    required:
+      - function
+      - groups
+
+required:
+  - compatible
+  - reg
+  - ambarella,drive-strength-syscon
+  - ambarella,pull-syscon
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pinctrl: pinctrl@e4010000 {
+        compatible = "ambarella,cv75-pinctrl";
+        reg = <0xe4010000 0x1000>;
+        ambarella,drive-strength-syscon = <&rct>;
+        ambarella,pull-syscon = <&scratchpad>;
+
+        uart0-pins {
+            function = "uart0";
+            groups = "uart0";
+            bias-disable;
+            drive-strength = <8>;
+        };
+    };

-- 
2.34.1


