Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7952DC3F2DA
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 13:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5143C20717
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 13:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgCCNn6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:43:58 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:37118 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgCCNn5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 08:43:57 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id 9pjt2200y5USYZQ06pjtH1; Tue, 03 Mar 2020 14:43:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j97px-0001GU-Qp; Tue, 03 Mar 2020 14:43:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j97px-0005oA-Pp; Tue, 03 Mar 2020 14:43:53 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] dt-bindings: serial: Convert generic bindings to json-schema
Date:   Tue,  3 Mar 2020 14:43:50 +0100
Message-Id: <20200303134351.22270-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303134351.22270-1-geert+renesas@glider.be>
References: <20200303134351.22270-1-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the generic serial interface Device Tree binding documentation
to json-schema.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/serial/serial.txt     | 56 -----------
 .../devicetree/bindings/serial/serial.yaml    | 95 +++++++++++++++++++
 2 files changed, 95 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/serial.txt
 create mode 100644 Documentation/devicetree/bindings/serial/serial.yaml

diff --git a/Documentation/devicetree/bindings/serial/serial.txt b/Documentation/devicetree/bindings/serial/serial.txt
deleted file mode 100644
index 863c2893759e7151..0000000000000000
--- a/Documentation/devicetree/bindings/serial/serial.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Generic Serial DT Bindings
-
-This document lists a set of generic properties for describing UARTs in a
-device tree.  Whether these properties apply to a particular device depends on
-the DT bindings for the actual device.
-
-Optional properties:
-  - cts-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
-    used as the UART's CTS line.
-  - dcd-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
-    used as the UART's DCD line.
-  - dsr-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
-    used as the UART's DSR line.
-  - dtr-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
-    used as the UART's DTR line.
-  - rng-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
-    used as the UART's RNG line.
-  - rts-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
-    used as the UART's RTS line.
-
-  - uart-has-rtscts: The presence of this property indicates that the
-    UART has dedicated lines for RTS/CTS hardware flow control, and that
-    they are available for use (wired and enabled by pinmux configuration).
-    This depends on both the UART hardware and the board wiring.
-    Note that this property is mutually-exclusive with "cts-gpios" and
-    "rts-gpios" above, unless support is provided to switch between modes
-    dynamically.
-
-
-Examples:
-
-	uart1: serial@48022000 {
-		compatible = "ti,am3352-uart", "ti,omap3-uart";
-		ti,hwmods = "uart2";
-		clock-frequency = <48000000>;
-		reg = <0x48022000 0x2000>;
-		interrupts = <73>;
-		dmas = <&edma 28 0>, <&edma 29 0>;
-		dma-names = "tx", "rx";
-		dtr-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
-		dsr-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
-		dcd-gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
-		rng-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
-		cts-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
-		rts-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
-	};
-
-	scifa4: serial@e6c80000 {
-		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
-		reg = <0xe6c80000 0x100>;
-		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
-		clock-names = "fck";
-		power-domains = <&pd_a3sp>;
-		uart-has-rtscts;
-	};
diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
new file mode 100644
index 0000000000000000..d408335319f00215
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/serial.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Serial Interface Generic DT Bindings
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+description:
+  This document lists a set of generic properties for describing UARTs in a
+  device tree.  Whether these properties apply to a particular device depends
+  on the DT bindings for the actual device.
+
+properties:
+  $nodename:
+    pattern: "^serial@[0-9a-f]+$"
+
+  cts-gpios:
+    description:
+      Must contain a GPIO specifier, referring to the GPIO pin to be used as
+      the UART's CTS line.
+
+  dcd-gpios:
+    description:
+      Must contain a GPIO specifier, referring to the GPIO pin to be used as
+      the UART's DCD line.
+
+  dsr-gpios:
+    description:
+      Must contain a GPIO specifier, referring to the GPIO pin to be used as
+      the UART's DSR line.
+
+  dtr-gpios:
+    description:
+      Must contain a GPIO specifier, referring to the GPIO pin to be used as
+      the UART's DTR line.
+
+  rng-gpios:
+    description:
+      Must contain a GPIO specifier, referring to the GPIO pin to be used as
+      the UART's RNG line.
+
+  rts-gpios:
+    description:
+      Must contain a GPIO specifier, referring to the GPIO pin to be used as
+      the UART's RTS line.
+
+  uart-has-rtscts:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The presence of this property indicates that the UART has dedicated lines
+      for RTS/CTS hardware flow control, and that they are available for use
+      (wired and enabled by pinmux configuration).  This depends on both the
+      UART hardware and the board wiring.
+      Note that this property is mutually-exclusive with "cts-gpios" and
+      "rts-gpios" above, unless support is provided to switch between modes
+      dynamically.
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    serial@48022000 {
+            compatible = "ti,am3352-uart", "ti,omap3-uart";
+            ti,hwmods = "uart2";
+            clock-frequency = <48000000>;
+            reg = <0x48022000 0x2000>;
+            interrupts = <73>;
+            dmas = <&edma 28 0>, <&edma 29 0>;
+            dma-names = "tx", "rx";
+            dtr-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+            dsr-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+            dcd-gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
+            rng-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
+            cts-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+            rts-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+    };
+
+  - |
+    #include <dt-bindings/clock/sh73a0-clock.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@e6c80000 {
+            compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+            reg = <0xe6c80000 0x100>;
+            interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
+            clock-names = "fck";
+            power-domains = <&pd_a3sp>;
+            uart-has-rtscts;
+    };
-- 
2.17.1

