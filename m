Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A960EB64DD
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jul 2023 15:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjGEPSK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jul 2023 11:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjGEPSJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jul 2023 11:18:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ECA170B;
        Wed,  5 Jul 2023 08:18:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so7571175f8f.0;
        Wed, 05 Jul 2023 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688570286; x=1691162286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rTM9zb9WY9Xvxel2SErjkaPh55ugzzbgIcOlX7MHw4=;
        b=mk5aUeNMCsmeJqqc1eyESY1lW11bAcprGyGXPdJ33glrCXnGnXxdzoySWpxUhodgQf
         7sA5wQPfmkta4s3zKgI+x9ku06bB9EivUCza+knU78/Up78E9pRezBrUs35kjucJhZOO
         AFCP6DY74N5crn4bCU9rUUmMNu/eAJ6RNqFXpy3RRxfUpsVPCXQ5ee01uG7/rnupPO5k
         sSt0E5uw59Pflsdlj+UPETEI9aqHthGRLqwZ7cY+EW62nD/HGrb24qNynBmVK0uGUipS
         MspkLc3Ozf2XfL6JdvuE+6nP9pRM4lt1A1b4czD6/UwEcOCo8c0FiXhJyaFPW0xs9rmV
         OPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688570286; x=1691162286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rTM9zb9WY9Xvxel2SErjkaPh55ugzzbgIcOlX7MHw4=;
        b=LEhQ+hkU61SRNv2ja21mMLnpXb0g9CZrLBeGtSqYQU9+CuTwzQiXdONuaIZNSZ4m5M
         Z2qYBzOWlAF042WUMNCDFVvzIkAofMIreexKeJOaI7yO1l16eOhw806FiSOKHMYHC/kZ
         vid6vwPWHJ6nYwq92ZQPJefmnnE4xvAi25it9v9ufI+ooPHq9liqXW6KMmKm6mNYNR8C
         Jc/TvPbaI1s1jOkBsbbKZoqXzhFVBbakTLmfvdwqzlZRmt37lZkBR4zjiXxZY4e6Bqk8
         l+15IANXUITreuC2jY92/gGCJ8vCcFLgk6lXSgd9oK5/19WjwFi7Jm/3iwReg2qPu45g
         jMVQ==
X-Gm-Message-State: ABy/qLaaTDUJ4sYnwN+kmZPTEEOfTlxPaOK5hPE2xQtL9teZpBmH9/f6
        1FJ1TyyFXoUazMnmB9TwcOQ=
X-Google-Smtp-Source: APBJJlEchMqCocnXvYS1zea7yJILbF0CxML3vQJxCuE0v67B8tiU5h9lvjNzB+voY7Zz9TrzqiSVTA==
X-Received: by 2002:adf:e604:0:b0:314:311d:1b9 with SMTP id p4-20020adfe604000000b00314311d01b9mr10159765wrm.47.1688570286000;
        Wed, 05 Jul 2023 08:18:06 -0700 (PDT)
Received: from localhost (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d58e3000000b00314329f7d8asm10030876wrd.29.2023.07.05.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:18:05 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: tegra-hsuart: Convert to json-schema
Date:   Wed,  5 Jul 2023 17:18:02 +0200
Message-ID: <20230705151802.2512186-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Tegra High-Speed UART bindings from the free-form text
format to json-schema.

While at it, also fix fix the example to reflect the correct compatible
string for Tegra30 chips.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add note about the corrected example to commit message
- collate all single entry compatibles into an enum

 .../bindings/serial/nvidia,tegra20-hsuart.txt |  73 ----------
 .../serial/nvidia,tegra20-hsuart.yaml         | 125 ++++++++++++++++++
 2 files changed, 125 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
deleted file mode 100644
index f709304036c2..000000000000
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver.
-
-Required properties:
-- compatible : should be,
-  "nvidia,tegra20-hsuart" for Tegra20,
-  "nvidia,tegra30-hsuart" for Tegra30,
-  "nvidia,tegra186-hsuart" for Tegra186,
-  "nvidia,tegra194-hsuart" for Tegra194.
-
-- reg: Should contain UART controller registers location and length.
-- interrupts: Should contain UART controller interrupts.
-- clocks: Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - serial
-- dmas : Must contain an entry for each entry in dma-names.
-  See ../dma/dma.txt for details.
-- dma-names : Must include the following entries:
-  - rx
-  - tx
-
-Optional properties:
-- nvidia,enable-modem-interrupt: Enable modem interrupts. Should be enable
-		only if all 8 lines of UART controller are pinmuxed.
-- nvidia,adjust-baud-rates: List of entries providing percentage of baud rate
-  adjustment within a range.
-  Each entry contains sets of 3 values. Range low/high and adjusted rate.
-  <range_low range_high adjusted_rate>
-  When baud rate set on controller falls within the range mentioned in this
-  field, baud rate will be adjusted by percentage mentioned here.
-  Ex: <9600 115200 200>
-  Increase baud rate by 2% when set baud rate falls within range 9600 to 115200
-
-Baud Rate tolerance:
-  Standard UART devices are expected to have tolerance for baud rate error by
-  -4 to +4 %. All Tegra devices till Tegra210 had this support. However,
-  Tegra186 chip has a known hardware issue. UART Rx baud rate tolerance level
-  is 0% to +4% in 1-stop config. Otherwise, the received data will have
-  corruption/invalid framing errors. Parker errata suggests adjusting baud
-  rate to be higher than the deviations observed in Tx.
-
-  Tx deviation of connected device can be captured over scope (or noted from
-  its spec) for valid range and Tegra baud rate has to be set above actual
-  Tx baud rate observed. To do this we use nvidia,adjust-baud-rates
-
-  As an example, consider there is deviation observed in Tx for baud rates as
-  listed below.
-  0 to 9600 has 1% deviation
-  9600 to 115200 2% deviation
-  This slight deviation is expcted and Tegra UART is expected to handle it. Due
-  to the issue stated above, baud rate on Tegra UART should be set equal to or
-  above deviation observed for avoiding frame errors.
-  Property should be set like this
-  nvidia,adjust-baud-rates = <0 9600 100>,
-  			     <9600 115200 200>;
-
-Example:
-
-serial@70006000 {
-	compatible = "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart";
-	reg = <0x70006000 0x40>;
-	reg-shift = <2>;
-	interrupts = <0 36 0x04>;
-	nvidia,enable-modem-interrupt;
-	clocks = <&tegra_car 6>;
-	resets = <&tegra_car 6>;
-	reset-names = "serial";
-	dmas = <&apbdma 8>, <&apbdma 8>;
-	dma-names = "rx", "tx";
-	nvidia,adjust-baud-rates = <1000000 4000000 136>; /* 1.36% shift */
-};
diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
new file mode 100644
index 000000000000..04d55fecf47c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/nvidia,tegra20-hsuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nvidia,tegra20-hsuart
+          - nvidia,tegra30-hsuart
+          - nvidia,tegra186-hsuart
+          - nvidia,tegra194-hsuart
+      - items:
+          - const: nvidia,tegra124-hsuart
+          - const: nvidia,tegra30-hsuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: module clock
+
+  resets:
+    items:
+      - description: module reset
+
+  reset-names:
+    items:
+      - const: serial
+
+  dmas:
+    items:
+      - description: DMA channel used for reception
+      - description: DMA channel used for transmission
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  nvidia,enable-modem-interrupt:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enable modem interrupts. Should be enable only if all 8 lines of UART controller
+      are pinmuxed.
+
+  nvidia,adjust-baud-rates:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      List of entries providing percentage of baud rate adjustment within a range. Each entry
+      contains a set of 3 values: range low/high and adjusted rate. When the baud rate set on the
+      controller falls within the range mentioned in this field, the baud rate will be adjusted by
+      percentage mentioned here.
+
+      Example: <9600 115200 200>
+
+      Increase baud rate by 2% when set baud rate falls within range 9600 to 115200.
+
+      Standard UART devices are expected to have tolerance for baud rate error by -4 to +4 %. All
+      Tegra devices till Tegra210 had this support. However, Tegra186 chip has a known hardware
+      issue. UART RX baud rate tolerance level is 0% to +4% in 1-stop config. Otherwise, the
+      received data will have corruption/invalid framing errors. Parker errata suggests adjusting
+      baud rate to be higher than the deviations observed in TX.
+
+      TX deviation of connected device can be captured over scope (or noted from its spec) for
+      valid range and Tegra baud rate has to be set above actual TX baud rate observed. To do this
+      we use nvidia,adjust-baud-rates.
+
+      As an example, consider there is deviation observed in TX for baud rates as listed below. 0
+      to 9600 has 1% deviation 9600 to 115200 2% deviation. This slight deviation is expcted and
+      Tegra UART is expected to handle it. Due to the issue stated above, baud rate on Tegra UART
+      should be set equal to or above deviation observed for avoiding frame errors. Property
+      should be set like this:
+
+        nvidia,adjust-baud-rates = <0 9600 100>,
+                                   <9600 115200 200>;
+    items:
+      items:
+        - description: range lower bound
+        - description: range upper bound
+        - description: adjustment (in permyriad, i.e. 0.01%)
+
+allOf:
+  - $ref: serial.yaml
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - reset-names
+  - dmas
+  - dma-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra30-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@70006000 {
+        compatible = "nvidia,tegra30-hsuart";
+        reg = <0x70006000 0x40>;
+        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+        nvidia,enable-modem-interrupt;
+        clocks = <&tegra_car TEGRA30_CLK_UARTA>;
+        resets = <&tegra_car 6>;
+        reset-names = "serial";
+        dmas = <&apbdma 8>, <&apbdma 8>;
+        dma-names = "rx", "tx";
+        nvidia,adjust-baud-rates = <1000000 4000000 136>; /* 1.36% shift */
+    };
-- 
2.41.0

