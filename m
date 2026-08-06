Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082E3F4138;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008866; cv=none; b=DAlU/6qRzxjzL1KPnxg4U4m9MeRihrN+sj9bsHYYuqzClSo08KvJrGMyjEawt1bGG//mY7TNGxnflLnDZlssQD6WwqIdW6bCMO3lxlNoZXTGj1B7pBoQUScDUirlVSwdeCGbzd4eQ3ZnacUTQk/K45e97+ck0h0kTmHwIGWrRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008866; c=relaxed/simple;
	bh=Nlm5hTHmD3jVsjGjeCec+uJpTqsxuKfQw+NDZdxHGoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCbs2vGzxPP0SITsRaALashLhSRKqTOZW4mmC+AFa4QhELhHafh7J+UPbsN9B84gXazrxsPwRkC0KKLBIdNnEnQfwJcnMdX2x8alYIGyFLGGs+e91UrSQ1AjkYdN4roTkqMZZ0utcQ01/5KzZvRe1bUK4ooWZBlhU+BiZ5gtg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t95zQJej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t95zQJej"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 715A2C2BD04;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786008866;
	bh=Nlm5hTHmD3jVsjGjeCec+uJpTqsxuKfQw+NDZdxHGoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t95zQJejNNWaf44gVX1XbrLkTX/Js0YD3NmiU/Rapaf7/VvToPBUGKSuKv7qb/Djs
	 7in/ykeMEKANpMFTaCgKM+AOJ06E6z17w+r7pA1NyyyzmIIBvcMOpIZlxlTs0VwBUL
	 MxZzkooVYLRDQmMmz5ThAlrtDWMCU6BoJDv/Zy6ql+3tBGhlSyUPYXuRdwcjpbvyfC
	 AaBDuBNGDLvQOkbungQFw1XeKS3plf0G4gb3kNb3wH24NFi+rTbEct7VGGyoM8nteQ
	 VvuyP3k68lJw3EZLohiVrxv8ZiYxff2Qa1/svrUVbvNK/7N4ASk48JZmxxBskSAEnf
	 RcDqCDsTIVy8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE80C5AC6F;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 06 Aug 2026 17:34:12 +0800
Subject: [PATCH v2 04/10] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-longzhao-upstream-cv75-v2-v2-4-6b09707c5fe9@ambarella.com>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 soc@lists.linux.dev, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786008863; l=4816;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=9rdubmZ/+QRo7Rx2fG5nIwgQAldJunotrOeXcg9Kbfo=;
 b=F8tcpzImpasxLSOpFpa6um1OEviO7AaVDmtd8wslWwtethIiD275bee1POZMWiMBBcB9DdOFD
 FcfOCqbzGK7AV21UvOdQljOEMAhfsnfobtLOJK/JcoYagHZhqT/ROQs
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add the CV75 pin controller binding.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../bindings/pinctrl/ambarella,cv75-pinctrl.yaml   | 175 +++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
new file mode 100644
index 000000000000..3fa30b275e51
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
@@ -0,0 +1,175 @@
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
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^gpio@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      gpio-controller: true
+
+      "#gpio-cells":
+        const: 2
+
+      gpio-ranges:
+        maxItems: 1
+
+      interrupt-controller: true
+
+      "#interrupt-cells":
+        const: 2
+
+    required:
+      - reg
+      - interrupts
+      - gpio-controller
+      - "#gpio-cells"
+      - gpio-ranges
+      - interrupt-controller
+      - "#interrupt-cells"
+
+  "^[a-z0-9-]+-pins$":
+    type: object
+    allOf:
+      - $ref: pinmux-node.yaml#
+      - $ref: pincfg-node.yaml#
+    additionalProperties: false
+
+    properties:
+      function:
+        const: uart0
+
+      groups:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        items:
+          enum: [uart0tx, uart0rx]
+        minItems: 2
+        maxItems: 2
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
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rct: rct {
+    };
+
+    scratchpad: scratchpad {
+    };
+
+    pinctrl: pinctrl@e4010000 {
+        compatible = "ambarella,cv75-pinctrl";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0xe4010000 0x1000>;
+        ranges;
+        ambarella,drive-strength-syscon = <&rct>;
+        ambarella,pull-syscon = <&scratchpad>;
+
+        gpio0: gpio@e4013000 {
+            reg = <0xe4013000 0x1000>;
+            interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-ranges = <&pinctrl 0 0 32>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+
+        gpio1: gpio@e4014000 {
+            reg = <0xe4014000 0x1000>;
+            interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-ranges = <&pinctrl 0 32 32>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+
+        gpio2: gpio@e4015000 {
+            reg = <0xe4015000 0x1000>;
+            interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-ranges = <&pinctrl 0 64 32>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+
+        uart0-pins {
+            function = "uart0";
+            groups = "uart0tx", "uart0rx";
+            bias-disable;
+            drive-strength = <8>;
+        };
+    };

-- 
2.34.1


