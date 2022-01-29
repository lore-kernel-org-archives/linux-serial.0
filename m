Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92645C43217
	for <linux-serial@archiver.kernel.org>; Sat, 29 Jan 2022 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352838AbiA2Rxp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Jan 2022 12:53:45 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58800
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352845AbiA2Rxk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Jan 2022 12:53:40 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D5A6B3F1E9
        for <linux-serial@vger.kernel.org>; Sat, 29 Jan 2022 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478819;
        bh=ka9TiF8r6giyPD09NAPdLIG5k0S/14EE5/7Y9SeHZVU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Yxok1qKtfBtsFeQOhjBMwUGRBg7t5DpEfJjs9hYCTG1cFCp1GDoAFby8WlopSy3sO
         xxrEY3xwlBCy0hlZZNME2GahsI0V1xzUdwvyIiiR/jdVc5+kGYeefWJRsTtijjaBV0
         XXFT9XOWwvZWIpLAHfJ15NbA1u28bT5FRSgtw0crNlB4BRMONoUthEQnE/uxG7Ac/X
         yVp9DvnAiDDD6hlZJGUWE5EpIRr0uBA5WpaayOeWJV2nP5lO6kIsqDfl+z/eq3JcPr
         KLz1hsOY4udbZCyNXw1i76UNR5GlgmaPS1+48vqrailKA4cQRmuAFReIl+dFkEhUJK
         CCa8zP0/aNEgQ==
Received: by mail-ed1-f71.google.com with SMTP id o25-20020a056402039900b0040631c2a67dso4637223edv.19
        for <linux-serial@vger.kernel.org>; Sat, 29 Jan 2022 09:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ka9TiF8r6giyPD09NAPdLIG5k0S/14EE5/7Y9SeHZVU=;
        b=XSZFjnwruva1MWLN+mrO1V7roaLO1CAFX6nRc+iPAVILzxTkTnJv+kli6CG3/vDEbR
         qsoHsDPXR04ixd0yt/Uo9RKqZ/x3llR5OoqE+b6Qx4M4EBWEyh2bdZ7nEXYOvwoUgNkr
         Z78dmTyzZ4/1XlnBldIq+MGDM88Ro3CveY+YypAZMbauDpUrAegMEX12YkxGrYwdIg/H
         doVRrM7Z/JmafMev5bfJEuKXoNTS0AWNkFhN5fxpLO6Qs/zyZbaYkTzGnp/rtzNdkz5b
         2aNprFnN13dTrfQe5oNaU3Za4X6D4lv7ppRRWD8GQfCkaDI/aDay2pxkSIan/Ea3Xorc
         3Z1g==
X-Gm-Message-State: AOAM532P56iUpWR8jpuxNtZrI3ZTh/kFKorqqksALfweDWB4sSCTuBUi
        mpD5msLnDYVQmg4aXbqSrtrwpVMW1OfsYkCZNmO9+0Vk1Yto+6ffnNHqavuRuHjGy62yb4dVEO5
        37MHTBH2UYvOBJefjTn1ipSBWUDq/MNK7h/VbXE3K6A==
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr5133904ejc.328.1643478819452;
        Sat, 29 Jan 2022 09:53:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzk+zvupucdH70DRpGgSjDQ2oEuZcstxn3KX7+z5gkfdbUalg6yE54ueCT5xJD8Pb7M0KiKg==
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr5133887ejc.328.1643478819250;
        Sat, 29 Jan 2022 09:53:39 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s12sm11236266ejx.184.2022.01.29.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:53:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: mfd: samsung,exynos5433-lpass: Convert to dtschema
Date:   Sat, 29 Jan 2022 18:53:31 +0100
Message-Id: <20220129175332.298666-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the Exynos5433 LPASS bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/mfd/samsung,exynos5433-lpass.txt |  72 -----------
 .../mfd/samsung,exynos5433-lpass.yaml         | 119 ++++++++++++++++++
 2 files changed, 119 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml

diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
deleted file mode 100644
index 30ea27c3936d..000000000000
--- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-Samsung Exynos SoC Low Power Audio Subsystem (LPASS)
-
-Required properties:
-
- - compatible		: "samsung,exynos5433-lpass"
- - reg			: should contain the LPASS top SFR region location
-			  and size
- - clock-names		: should contain following required clocks: "sfr0_ctrl"
- - clocks		: should contain clock specifiers of all clocks, which
-			  input names have been specified in clock-names
-			  property, in same order.
- - #address-cells	: should be 1
- - #size-cells		: should be 1
- - ranges		: must be present
-
-Each IP block of the Low Power Audio Subsystem should be specified as
-an optional sub-node. For "samsung,exynos5433-lpass" compatible this includes:
-UART, SLIMBUS, PCM, I2S, DMAC, Timers 0...4, VIC, WDT 0...1 devices.
-
-Bindings of the sub-nodes are described in:
-  ../serial/samsung_uart.yaml
-  ../sound/samsung-i2s.txt
-  ../dma/arm-pl330.txt
-
-
-Example:
-
-audio-subsystem {
-	compatible = "samsung,exynos5433-lpass";
-	reg = <0x11400000 0x100>, <0x11500000 0x08>;
-	clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
-	clock-names = "sfr0_ctrl";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	adma: adma@11420000 {
-		compatible = "arm,pl330", "arm,primecell";
-		reg = <0x11420000 0x1000>;
-		interrupts = <0 73 0>;
-		clocks = <&cmu_aud CLK_ACLK_DMAC>;
-		clock-names = "apb_pclk";
-		#dma-cells = <1>;
-		#dma-channels = <8>;
-		#dma-requests = <32>;
-	};
-
-	i2s0: i2s0@11440000 {
-		compatible = "samsung,exynos7-i2s";
-		reg = <0x11440000 0x100>;
-		dmas = <&adma 0 &adma 2>;
-		dma-names = "tx", "rx";
-		interrupts = <0 70 0>;
-		clocks = <&cmu_aud CLK_PCLK_AUD_I2S>,
-			 <&cmu_aud CLK_SCLK_AUD_I2S>,
-			 <&cmu_aud CLK_SCLK_I2S_BCLK>;
-		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2s0_bus>;
-	};
-
-	serial_3: serial@11460000 {
-		compatible = "samsung,exynos5433-uart";
-		reg = <0x11460000 0x100>;
-		interrupts = <0 67 0>;
-		clocks = <&cmu_aud CLK_PCLK_AUD_UART>,
-			 <&cmu_aud CLK_SCLK_AUD_UART>;
-		clock-names = "uart", "clk_uart_baud0";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart_aud_bus>;
-	};
- };
diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
new file mode 100644
index 000000000000..96ef6113c8bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/samsung,exynos5433-lpass.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Low Power Audio Subsystem (LPASS)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    const: samsung,exynos5433-lpass
+
+  '#address-cells':
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: sfr0_ctrl
+
+  power-domains:
+    maxItems: 1
+
+  ranges: true
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^dma-controller@[0-9a-f]+$":
+    $ref: /schemas/dma/arm,pl330.yaml
+
+  "^i2s@[0-9a-f]+$":
+    $ref: /schemas/sound/samsung-i2s.yaml
+
+  "^serial@[0-9a-f]+$":
+    $ref: /schemas/serial/samsung_uart.yaml
+
+required:
+  - compatible
+  - '#address-cells'
+  - clocks
+  - clock-names
+  - ranges
+  - reg
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5433.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    audio-subsystem@11400000 {
+        compatible = "samsung,exynos5433-lpass";
+        reg = <0x11400000 0x100>, <0x11500000 0x08>;
+        clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
+        clock-names = "sfr0_ctrl";
+        power-domains = <&pd_aud>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        dma-controller@11420000 {
+            compatible = "arm,pl330", "arm,primecell";
+            reg = <0x11420000 0x1000>;
+            interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu_aud CLK_ACLK_DMAC>;
+            clock-names = "apb_pclk";
+            #dma-cells = <1>;
+            #dma-channels = <8>;
+            #dma-requests = <32>;
+            power-domains = <&pd_aud>;
+        };
+
+        i2s@11440000 {
+            compatible = "samsung,exynos7-i2s";
+            reg = <0x11440000 0x100>;
+            dmas = <&adma 0>, <&adma 2>;
+            dma-names = "tx", "rx";
+            interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&cmu_aud CLK_PCLK_AUD_I2S>,
+                     <&cmu_aud CLK_SCLK_AUD_I2S>,
+                     <&cmu_aud CLK_SCLK_I2S_BCLK>;
+            clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+            #clock-cells = <1>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&i2s0_bus>;
+            power-domains = <&pd_aud>;
+            #sound-dai-cells = <1>;
+            status = "disabled";
+        };
+
+        serial@11460000 {
+            compatible = "samsung,exynos5433-uart";
+            reg = <0x11460000 0x100>;
+            interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu_aud CLK_PCLK_AUD_UART>,
+                     <&cmu_aud CLK_SCLK_AUD_UART>;
+            clock-names = "uart", "clk_uart_baud0";
+            pinctrl-names = "default";
+            pinctrl-0 = <&uart_aud_bus>;
+            power-domains = <&pd_aud>;
+            status = "disabled";
+        };
+    };
-- 
2.32.0

