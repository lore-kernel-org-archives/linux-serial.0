Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEBC4332F
	for <linux-serial@archiver.kernel.org>; Tue,  5 Apr 2022 06:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiDEGiX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Apr 2022 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiDEGhY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Apr 2022 02:37:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA3319001
        for <linux-serial@vger.kernel.org>; Mon,  4 Apr 2022 23:35:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k23so21092888ejd.3
        for <linux-serial@vger.kernel.org>; Mon, 04 Apr 2022 23:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aRapulVleACHaRVpaRemPKR+at6Oa4NBeEZ+s+WImo=;
        b=sxY1JQ+pX73S1Bwlv3xrdFu/cmB3MqveCA78+V9LgccrAJi76NfLA7HVbtygTtSE1Z
         Wz2z7Sn85AiCsElpF3qtwk8+6v5/SdT4IMyxNerOcYeaSQYV2EZzHDZOH/ZVGCn5sq4e
         hoJilmgzv+kNBIfcBVwh0KpoN2L/2CREp53CUJZzucYnJv1DpviSZvXY5GBqywgGC0gS
         THKDxRkHnIuPr+j6afCkQ6vXuidor91dtksLB5AjbDmIbVu20Af3nFZqPpA33zwnOX4F
         b071/mGLhSMtiG46sSXLExekcHx/9f+1C7M9ZZgbCi2XR5mg1fFeYN3lzZKxkrSWEGey
         rxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aRapulVleACHaRVpaRemPKR+at6Oa4NBeEZ+s+WImo=;
        b=q838cKME9kzv88Wf0oo/HsUowx31HbLJso/jo78z1w457jQMHRgKBxLcVIYpZzA+OP
         u0cyi4IUXVJle970pBm8isQGdIZHeQvD0ZHCQRHWArD6ELBKc9NRDHGOxsnPjOwcuoax
         Kf4gERHeKrnwXFWg2ckN4VIIOyZ4RE8/Gt7+SnKRBb5V3tbzrLT6e584UlxcTvdtRpuB
         qBCxBldvZHtfmvuw5LC22GYaIKheO3jr7UjjzwSLGF7M18RZuF8WAH2Dg3yoamqxYYAD
         DKchi5nggxR1flQDJEoZ5BI2EKonh0wEiSJrVqioglUI89m+u4VqRfoklw6CUxCQ5cwA
         Rwtg==
X-Gm-Message-State: AOAM531IuDKeJhkpHWaeiD+EU1iagWiJcePXNTyuZTZNuYvLsh64xLAV
        E7eb6D1XNuTt1C0ymlceDIlQBg==
X-Google-Smtp-Source: ABdhPJwjK52iLr3z/j3CSrDW9cArzWMU7Uadld+yfwG2I1BCADlrbG+s4oWwtM/f3FsI0tyMDLEQ2Q==
X-Received: by 2002:a17:907:7f04:b0:6e1:39b8:d1a5 with SMTP id qf4-20020a1709077f0400b006e139b8d1a5mr2012819ejc.83.1649140516637;
        Mon, 04 Apr 2022 23:35:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bs7-20020a056402304700b004197e5d2350sm6086543edb.54.2022.04.04.23.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:35:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 7/9] dt-bindings: serial: qcom,msm-uartdm: convert to dtschema
Date:   Tue,  5 Apr 2022 08:34:49 +0200
Message-Id: <20220405063451.12011-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
References: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the Qualcomm MSM Serial UARTDM bindings to DT Schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/serial/qcom,msm-uartdm.txt       |  81 -------------
 .../bindings/serial/qcom,msm-uartdm.yaml      | 112 ++++++++++++++++++
 2 files changed, 112 insertions(+), 81 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml

diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
deleted file mode 100644
index 9d098cf73b53..000000000000
--- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-* MSM Serial UARTDM
-
-The MSM serial UARTDM hardware is designed for high-speed use cases where the
-transmit and/or receive channels can be offloaded to a dma-engine. From a
-software perspective it's mostly compatible with the MSM serial UART except
-that it supports reading and writing multiple characters at a time.
-
-Required properties:
-- compatible: Should contain at least "qcom,msm-uartdm".
-              A more specific property should be specified as follows depending
-	      on the version:
-		"qcom,msm-uartdm-v1.1"
-		"qcom,msm-uartdm-v1.2"
-		"qcom,msm-uartdm-v1.3"
-		"qcom,msm-uartdm-v1.4"
-- reg: Should contain UART register locations and lengths. The first
-       register shall specify the main control registers. An optional second
-       register location shall specify the GSBI control region.
-       "qcom,msm-uartdm-v1.3" is the only compatible value that might
-       need the GSBI control region.
-- interrupts: Should contain UART interrupt.
-- clocks: Should contain the core clock and the AHB clock.
-- clock-names: Should be "core" for the core clock and "iface" for the
-	       AHB clock.
-
-Optional properties:
-- dmas: Should contain dma specifiers for transmit and receive channels
-- dma-names: Should contain "tx" for transmit and "rx" for receive channels
-- qcom,tx-crci: Identificator <u32> for Client Rate Control Interface to be
-           used with TX DMA channel. Required when using DMA for transmission
-           with UARTDM v1.3 and below.
-- qcom,rx-crci: Identificator <u32> for Client Rate Control Interface to be
-           used with RX DMA channel. Required when using DMA for reception
-           with UARTDM v1.3 and below.
-
-Note: Aliases may be defined to ensure the correct ordering of the UARTs.
-The alias serialN will result in the UART being assigned port N.  If any
-serialN alias exists, then an alias must exist for each enabled UART.  The
-serialN aliases should be in a .dts file instead of in a .dtsi file.
-
-Examples:
-
-- A uartdm v1.4 device with dma capabilities.
-
-	serial@f991e000 {
-		compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-		reg = <0xf991e000 0x1000>;
-		interrupts = <0 108 0x0>;
-		clocks = <&blsp1_uart2_apps_cxc>, <&blsp1_ahb_cxc>;
-		clock-names = "core", "iface";
-		dmas = <&dma0 0>, <&dma0 1>;
-		dma-names = "tx", "rx";
-	};
-
-- A uartdm v1.3 device without dma capabilities and part of a GSBI complex.
-
-	serial@19c40000 {
-		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
-		reg = <0x19c40000 0x1000>,
-		<0x19c00000 0x1000>;
-		interrupts = <0 195 0x0>;
-		clocks = <&gsbi5_uart_cxc>, <&gsbi5_ahb_cxc>;
-		clock-names = "core", "iface";
-	};
-
-- serialN alias.
-
-	aliases {
-		serial0 = &uarta;
-		serial1 = &uartc;
-		serial2 = &uartb;
-	};
-
-	uarta: serial@12490000 {
-	};
-
-	uartb: serial@16340000 {
-	};
-
-	uartc: serial@1a240000 {
-	};
diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
new file mode 100644
index 000000000000..484b9a51f6a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/qcom,msm-uartdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM Serial UARTDM
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description: |
+  The MSM serial UARTDM hardware is designed for high-speed use cases where the
+  transmit and/or receive channels can be offloaded to a dma-engine. From a
+  software perspective it's mostly compatible with the MSM serial UART except
+  that it supports reading and writing multiple characters at a time.
+
+  Note:: Aliases may be defined to ensure the correct ordering of the UARTs.
+  The alias serialN will result in the UART being assigned port N.  If any
+  serialN alias exists, then an alias must exist for each enabled UART.  The
+  serialN aliases should be in a .dts file instead of in a .dtsi file.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,msm-uartdm-v1.1
+          - qcom,msm-uartdm-v1.2
+          - qcom,msm-uartdm-v1.3
+          - qcom,msm-uartdm-v1.4
+      - const: qcom,msm-uartdm
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: iface
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interrupts:
+    maxItems: 1
+
+  qcom,rx-crci:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Identificator for Client Rate Control Interface to be used with RX DMA
+      channel. Required when using DMA for reception with UARTDM v1.3 and
+      below.
+
+  qcom,tx-crci:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Identificator for Client Rate Control Interface to be used with TX DMA
+      channel. Required when using DMA for transmission with UARTDM v1.3 and
+      below.
+
+  reg:
+    minItems: 1
+    items:
+      - description: Main control registers
+      - description: An optional second register location shall specify the GSBI control region.
+
+required:
+  - compatible
+  - clock-names
+  - clocks
+  - interrupts
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,msm-uartdm-v1.3
+    then:
+      properties:
+        reg:
+          minItems: 2
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@f991e000 {
+        compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+        reg = <0xf991e000 0x1000>;
+        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&blsp1_uart2_apps_cxc>, <&blsp1_ahb_cxc>;
+        clock-names = "core", "iface";
+        dmas = <&dma0 0>, <&dma0 1>;
+        dma-names = "tx", "rx";
+    };
-- 
2.32.0

