Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87125C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 30 Nov 2021 02:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhK3C0O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Nov 2021 21:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbhK3C0O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Nov 2021 21:26:14 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D54DC061746
        for <linux-serial@vger.kernel.org>; Mon, 29 Nov 2021 18:22:55 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b1so49560707lfs.13
        for <linux-serial@vger.kernel.org>; Mon, 29 Nov 2021 18:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYEHlzA1VrNpvRuMbbyAOHVDsMuIQ1cl/rzwkQW1XHM=;
        b=kWG6d/YEKVy0ZQFanmjZ84CzkosC743/dc3lqH+nDBsAB2hvwNMAl1KIVXsC2S9doX
         CMSpxUww9c3jEKe/+M89QZtMM3CpKCPh6FgGxxU/3vb/OwRkJGZW4D38SyWvE79oxshU
         9wx7ByZBeROaOJ40WikmiQAQMtfdxRHJWdkWdT4A/Hex847HpF4Uth3Elvg0kfmjQuWR
         ZpIm0D8QdmBUh5E3F6HeSkCKBtApx7+1sttdpDs9WdRNl0I4PUSQA8DicXvCusCH/ifn
         p0sRRziXWNwOD4UeuEvXI8/BWUbNClq8OTrDQY+4jsX6iTiphXyBgJYVBm/fKmdeHKdZ
         MLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYEHlzA1VrNpvRuMbbyAOHVDsMuIQ1cl/rzwkQW1XHM=;
        b=YmzqXMnxKrG+bgkFrWTIR/6UOn+x8d6+1i3Wp09q1eOrsavX5Tdor3cExKFtyRUivA
         naiw+vY3F3OFRhrrg5d8OwbZvYDsNN2yDsyobrWmggPciPOVYjvjtgiZMlLgrkmPXQX7
         Bt+V9403SEHZceNCEIKNCvVfvbM5Hepjw1PjE4ChBzcGHPANTECN4diRPm1X5ccv8K/w
         Y64qQ+XE96VNdeVtISRxNmUMxJUjj2sMT2xqRnHDY/4RMz8oVW6PEP8Rq1M5AjvJ7PLK
         qonnDDTUPULf3RoceEgXLiteU8Rvb/sCFrdhjrdlsHyUbXqpYio3QA52SGuB3dEq4cH5
         oQYQ==
X-Gm-Message-State: AOAM531XHPXfrdNr3tUuTRQCQK555BQy/FtjrJlr2A3tEjZd1mJMqiS6
        9trN23DNK2HIODl9IBruGiUH1A==
X-Google-Smtp-Source: ABdhPJxIG40IAHPH8i0k1Mo2rcIfRKc6SZHwzHioud3i38kW70c3c07LFHXozgPujcCFNYVtSsyubw==
X-Received: by 2002:ac2:43a6:: with SMTP id t6mr49677286lfl.95.1638238973710;
        Mon, 29 Nov 2021 18:22:53 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id l12sm1544858lfe.81.2021.11.29.18.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:22:53 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
Date:   Tue, 30 Nov 2021 04:22:46 +0200
Message-Id: <20211130022250.28519-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130022250.28519-1-semen.protsenko@linaro.org>
References: <20211130022250.28519-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add constants for choosing USIv2 configuration mode in device tree.
Those are further used in USI driver to figure out which value to write
into SW_CONF register. Also document USIv2 IP-core bindings.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Combined dt-bindings doc and dt-bindings header patches
  - Added i2c node to example in bindings doc
  - Added mentioning of shared internal circuits
  - Added USI_V2_NONE value to bindings header

 .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
 include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
 2 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
 create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
new file mode 100644
index 000000000000..a822bc62b3cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/samsung/exynos-usi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung's Exynos USI (Universal Serial Interface) binding
+
+maintainers:
+  - Sam Protsenko <semen.protsenko@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  USI IP-core provides selectable serial protocol (UART, SPI or High-Speed I2C).
+  USI shares almost all internal circuits within each protocol, so only one
+  protocol can be chosen at a time. USI is modeled as a node with zero or more
+  child nodes, each representing a serial sub-node device. The mode setting
+  selects which particular function will be used.
+
+  Refer to next bindings documentation for information on protocol subnodes that
+  can exist under USI node:
+
+  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
+  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
+  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
+
+properties:
+  $nodename:
+    pattern: "^usi@[0-9a-f]+$"
+
+  compatible:
+    const: samsung,exynos-usi-v2
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus (APB) clock
+      - description: Operating clock for UART/SPI/I2C protocol
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: ipclk
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  samsung,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should be phandle/offset pair. The phandle to System Register syscon node
+      (for the same domain where this USI controller resides) and the offset
+      of SW_CONF register for this USI controller.
+
+  samsung,mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Selects USI function (which serial protocol to use). Refer to
+      <include/dt-bindings/soc/samsung,exynos-usi.h> for valid USI mode values.
+
+  samsung,clkreq-on:
+    type: boolean
+    description:
+      Enable this property if underlying protocol requires the clock to be
+      continuously provided without automatic gating. As suggested by SoC
+      manual, it should be set in case of SPI/I2C slave, UART Rx and I2C
+      multi-master mode. Usually this property is needed if USI mode is set
+      to "UART".
+
+      This property is optional.
+
+patternProperties:
+  # All other properties should be child nodes
+  "^.*@[0-9a-f]+$":
+    type: object
+    description: Child node describing underlying USI serial protocol
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+  - samsung,sysreg
+  - samsung,mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/samsung,exynos-usi.h>
+
+    usi0: usi@138200c0 {
+        compatible = "samsung,exynos-usi-v2";
+        reg = <0x138200c0 0x20>;
+        samsung,sysreg = <&sysreg_peri 0x1010>;
+        samsung,mode = <USI_V2_UART>;
+        samsung,clkreq-on; /* needed for UART mode */
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+        clock-names = "pclk", "ipclk";
+        status = "disabled";
+
+        serial_0: serial@13820000 {
+            compatible = "samsung,exynos850-uart";
+            reg = <0x13820000 0xc0>;
+            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+            clock-names = "uart", "clk_uart_baud0";
+            status = "disabled";
+        };
+
+        hsi2c_0: i2c@13820000 {
+            compatible = "samsung,exynosautov9-hsi2c";
+            reg = <0x13820000 0xc0>;
+            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+            clock-names = "hsi2c_pclk", "hsi2c";
+            status = "disabled";
+        };
+    };
diff --git a/include/dt-bindings/soc/samsung,exynos-usi.h b/include/dt-bindings/soc/samsung,exynos-usi.h
new file mode 100644
index 000000000000..a01af169d249
--- /dev/null
+++ b/include/dt-bindings/soc/samsung,exynos-usi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Device Tree bindings for Samsung Exynos USI (Universal Serial Interface).
+ */
+
+#ifndef __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
+#define __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
+
+#define USI_V2_NONE		0
+#define USI_V2_UART		1
+#define USI_V2_SPI		2
+#define USI_V2_I2C		3
+
+#endif /* __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H */
-- 
2.30.2

