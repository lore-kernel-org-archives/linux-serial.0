Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCFFEB64D7
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jun 2023 13:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjF3N6x (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jun 2023 09:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjF3N6w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jun 2023 09:58:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB792118;
        Fri, 30 Jun 2023 06:58:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so2280445f8f.2;
        Fri, 30 Jun 2023 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688133527; x=1690725527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5+VmZboCGtXD2h7I6RPQX0D+BsuFZkuK+SwH65LkZo=;
        b=SSjGPXScNJKwxC3/hOijYSRYNtfnn2Uf6P5ymjz41IWxhmk7v8Nx+x0XBUbbafnaYm
         8f9bBsVY6/JlwQooOx8a0WPXU8OWwDxN/cfMck3vWr+CstlH2swJHchbMC+m7hjyzk0j
         ff0BkN2VtwbPKOoI9NBK77oW+iePZ7sZut57D8jKfyzT2qKDf6WPwiCXi6wM4hWgtjoK
         yIq9DJH4QUJvnnoWl5S/lw82k+r7wIsTS3WZtuLjN1xlOsQp22qCqg6a6889b8wgnJwU
         03dorAlp5u1fBqKiUgceBmkf9IHCd7VjpjHfwq7bpNaGOs3GnlAYgZC+bpqBl0iZm9CC
         deYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688133527; x=1690725527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5+VmZboCGtXD2h7I6RPQX0D+BsuFZkuK+SwH65LkZo=;
        b=UTqkv7bYgDpMjjsJRQeMrjOMBe5wLpT6PhatpNuavZoJX6zHXJH8TfM50Ii1JSC4GT
         mAaOICLyCwpw3D7Ed2fISDVhgfzKkfz473e0VcbgzwsXU7C6cbw5u//sDi/8J/YSX1R2
         qUu5s6UQEg0xJalZhnG2XYzFZsTRvrMfIgtRr+fZUStXm583f+SbM8vdnNlYaKyOwpCf
         lPOor3SY6nRfdEagTd0PoAiC0ZPM732IE4DOqjEWVW5s8gIVUYIp+QRlpQwppFofgJH7
         9jWd9/7E7ZS50VJk9iVWnWvWGiSDiEu97uRd9jr/jBdh+75NJib8cNuE/PcFig943dP9
         UURw==
X-Gm-Message-State: ABy/qLZe7vTJaVYc250HnwwkVmfQ1P8Og1RCc9aO7bF/kSUt6zoSyjsf
        e36ZiD5SDIGasDTxzKnf4LtDLPEcEuI=
X-Google-Smtp-Source: APBJJlHOUc2EoCB2i+DAHpJZEzY9OnAN1I7UyH5LcaJCG/FCJAOfKlzA6hCLCkBo76RVCCemaDboZg==
X-Received: by 2002:a5d:58c3:0:b0:314:748:d59d with SMTP id o3-20020a5d58c3000000b003140748d59dmr2727282wrf.27.1688133527072;
        Fri, 30 Jun 2023 06:58:47 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q10-20020adfdfca000000b003141e629cb6sm2538560wrn.101.2023.06.30.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 06:58:46 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: tegra-hsuart: Convert to json-schema
Date:   Fri, 30 Jun 2023 15:58:43 +0200
Message-ID: <20230630135843.1092770-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Tegra High-Speed UART bindings from the free-form text
format to json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/serial/nvidia,tegra20-hsuart.txt |  73 -----------
 .../serial/nvidia,tegra20-hsuart.yaml         | 124 ++++++++++++++++++
 2 files changed, 124 insertions(+), 73 deletions(-)
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
index 000000000000..247ee33f8a01
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
@@ -0,0 +1,124 @@
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
+      - const: nvidia,tegra20-hsuart
+      - const: nvidia,tegra30-hsuart
+      - items:
+          - const: nvidia,tegra124-hsuart
+          - const: nvidia,tegra30-hsuart
+      - const: nvidia,tegra186-hsuart
+      - const: nvidia,tegra194-hsuart
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

