Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E74519BA;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049134; cv=none; b=ruDvei69uLnC5lgrYtgyrWHgGwxvQJ8x3gPkLcQLK+EA2hcLe+7dEPSGSYRG5Ilpw+CYQthkqNkKUgG6TyFvCk9ypxgqR3C29/8Mr+K4vXF5kDh8kTOHkSKQIZusu1Rw9ei4eKcRYd7hDGHYaFclqev6LDp/llOx+eHsG8d0mQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049134; c=relaxed/simple;
	bh=hp7bqmHn9P6jHYwnNUYIruS99llCyau/ChCTrkE9I+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBZsW6leWIYAZjV9dR7nyfu8l/YvYzX9xN4oU8P9Fj9pbUM6vDcWzR1yKTkMktVylrwN5GabAfe4SO64HvZ1Q2oc7fi/GjDFTiV0mjhjDn7fSftldgQeHNE42mEjYGHNhhTaLRBClX/kYz72AfsbgXxEyHAHOIBWTTcMdfEgsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayZJa1sV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayZJa1sV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B49FCC2BCFD;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787049133;
	bh=hp7bqmHn9P6jHYwnNUYIruS99llCyau/ChCTrkE9I+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ayZJa1sVH7++0TDFW9aoodDYU6rdAbzkf4zDqLPqxB14Gvf+E1hkBbZCwXlQxA0g8
	 d/cqkhqkrCg7idKhrZ8T+E7ClPgbT/DnydVFo6152Vl4nrM+vxj6lwuLBr4QhwNBL0
	 RZ4jeV+HJkn0ylpRBCDb6B9hxiD/6pd89uxL+w+P6r2rbtStD7p3nmzFeSWWcGDArr
	 Gg63P3aoexDRuItczcnDFBs/H0A90vps2MQrFP7kZYHu3iQ5S+2daURmFaBjNsgqa/
	 cbyjWHxMiF16l+a+riRZAEn4frC/1BNCpO7faceOuEZ3mXQsr+vDpzkuzZG0eW22sW
	 OydMv0infh7Rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D225C5DF81;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 18 Aug 2026 18:31:18 +0800
Subject: [PATCH v5 04/12] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-cv75-v5-v5-4-7bbb12f0360f@ambarella.com>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
In-Reply-To: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>, 
 Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 Long Zhao <zl020895@163.com>, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787049131; l=6330;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=XEvKncSGovDF7OgNkB6DKQG+ZkDy9YW2XQhMlWM+4n0=;
 b=h0FnNS20H56ST+R+dRfD5UAzzGYH0JEd8Or/5lM0Na4qx2C7nEvIIvStg13h1naJHobLAF/AF
 uZh/eJHD9QZBVWpx9A5orZvK3lxDnL1ANHOdlepSP7cT+s9rcZpktTG
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Document the CV75 pin controller binding using generic function and
groups properties for pinmux configuration.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../bindings/pinctrl/ambarella,cv75-pinctrl.yaml   | 239 +++++++++++++++++++++
 1 file changed, 239 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
new file mode 100644
index 000000000000..34054bc56c3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
@@ -0,0 +1,239 @@
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
+          - clk_au
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
+            - clk_au
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


