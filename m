Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D028B3FB;
	Wed,  7 May 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632655; cv=none; b=sYOG9BdAzyiwZje73YoRS8zsZM8B43T5AJsdWkaK+Triud0QLkgVSGnUX69b1f6VPl5IXzsiFWaYkGxpCZEwCxYSZUlUj/bboW+YusN6Xcrpvzq337jfS5uO6OX9RZEEXQdWcVZkkyYb8qWvCQeauRkkqdmIxyHxm448V5tSIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632655; c=relaxed/simple;
	bh=9DwO+tMCHVnRer2N2lnbbKSzIKIMSeGptXpWGmXWqLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NYKEyA01f2NUPfWW9bsoKw2QfIiS5dkl6IlznFDsclaHectwf2892oP5/kNUU10J4xL3rflTbtNNpOfZRBk+2dmG/HQen+JqVkOwhI39PWHJxt5Cn7FqQS21MFneK/9LemWVgAiMTH87X0plxtwVpeXQvke4O10tNgBdvy5vync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbSCCxNO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbSCCxNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE115C4CEE9;
	Wed,  7 May 2025 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746632655;
	bh=9DwO+tMCHVnRer2N2lnbbKSzIKIMSeGptXpWGmXWqLI=;
	h=From:To:Cc:Subject:Date:From;
	b=AbSCCxNO8CNVYOzDUipZoJUA7G9IStnYJU16V2/WnYLNWQRTFxYwb8WwMI4wAUxBh
	 qUidnIcAnN3kl6Vr7dcbBeBK26VpviAuUSg/iGCWkF0NF0d8A76dQkBaLe1MhHz8IJ
	 bBeMQZFx+zi9fnFM7ipIn1oc1YI7LUiVkqEi3h1io22ZjMVmynoHAmMiR7+lVK81Jy
	 W1sB6k+5nfS2B1JKBRB/CvPWSG0EHqgRuWDS7Q9Z2XjpbHH10W5Vbex5b+Va4kvBYC
	 ljaUU3QOj1/n4AzjMUZKHcktUi8GKr4r+QzJGFTnAZ2Hg35yBUM2i18RKJbFcgPiha
	 s6WvXUISfX9Xw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3] dt-bindings: serial: Convert marvell,armada-3700-uart to DT schema
Date: Wed,  7 May 2025 10:44:02 -0500
Message-ID: <20250507154408.1595932-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Marvell Armada-3700 UART binding to DT schema. It is a
straight-forward conversion.

Drop the long deprecated single interrupt support.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - Fix serial.yaml path

v2:
 - Drop deprecated part of interrupt description
 - fix subject
---
 .../serial/marvell,armada-3700-uart.yaml      | 102 ++++++++++++++++++
 .../devicetree/bindings/serial/mvebu-uart.txt |  56 ----------
 MAINTAINERS                                   |   2 +-
 3 files changed, 103 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/mvebu-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml b/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
new file mode 100644
index 000000000000..6c7fa3d19369
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/marvell,armada-3700-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada-3700 UART
+
+maintainers:
+  - Pali Rohár <pali@kernel.org>
+
+description:
+  Marvell UART is a non standard UART used in some of Marvell EBU SoCs (e.g.
+  Armada-3700).
+
+properties:
+  compatible:
+    enum:
+      - marvell,armada-3700-uart
+      - marvell,armada-3700-uart-ext
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      UART reference clock used to derive the baud rate. If absent, only fixed
+      baud rate from the bootloader is supported.
+
+  interrupts:
+    minItems: 2
+    items:
+      - description: UART sum interrupt
+      - description: UART TX interrupt
+      - description: UART RX interrupt
+
+  interrupt-names:
+    minItems: 2
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+  - if:
+      properties:
+        compatible:
+          const: marvell,armada-3700-uart-ext
+    then:
+      properties:
+        interrupts:
+          maxItems: 2
+
+        interrupt-names:
+          items:
+            - const: uart-tx
+            - const: uart-rx
+    else:
+      properties:
+        interrupts:
+          minItems: 3
+
+        interrupt-names:
+          items:
+            - const: uart-sum
+            - const: uart-tx
+            - const: uart-rx
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@12000 {
+        compatible = "marvell,armada-3700-uart";
+        reg = <0x12000 0x18>;
+        clocks = <&uartclk 0>;
+        interrupts =
+            <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+            <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+            <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uart-sum", "uart-tx", "uart-rx";
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@12200 {
+        compatible = "marvell,armada-3700-uart-ext";
+        reg = <0x12200 0x30>;
+        clocks = <&uartclk 1>;
+        interrupts =
+            <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
+            <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "uart-tx", "uart-rx";
+    };
diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
deleted file mode 100644
index a062bbca532c..000000000000
--- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* Marvell UART : Non standard UART used in some of Marvell EBU SoCs
-                 e.g., Armada-3700.
-
-Required properties:
-- compatible:
-    - "marvell,armada-3700-uart" for the standard variant of the UART
-      (32 bytes FIFO, no DMA, level interrupts, 8-bit access to the
-      FIFO), called also UART1.
-    - "marvell,armada-3700-uart-ext" for the extended variant of the
-      UART (128 bytes FIFO, DMA, front interrupts, 8-bit or 32-bit
-      accesses to the FIFO), called also UART2.
-- reg: offset and length of the register set for the device.
-- clocks: UART reference clock used to derive the baudrate. If no clock
-      is provided (possible only with the "marvell,armada-3700-uart"
-      compatible string for backward compatibility), it will only work
-      if the baudrate was initialized by the bootloader and no baudrate
-      change will then be possible. When provided it should be UART1-clk
-      for standard variant of UART and UART2-clk for extended variant
-      of UART. TBG clock (with UART TBG divisors d1=d2=1) or xtal clock
-      should not be used and are supported only for backward compatibility.
-- interrupts:
-    - Must contain three elements for the standard variant of the IP
-      (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",
-      respectively the UART sum interrupt, the UART TX interrupt and
-      UART RX interrupt. A corresponding interrupt-names property must
-      be defined.
-    - Must contain two elements for the extended variant of the IP
-      (marvell,armada-3700-uart-ext): "uart-tx" and "uart-rx",
-      respectively the UART TX interrupt and the UART RX interrupt. A
-      corresponding interrupt-names property must be defined.
-    - For backward compatibility reasons, a single element interrupts
-      property is also supported for the standard variant of the IP,
-      containing only the UART sum interrupt. This form is deprecated
-      and should no longer be used.
-
-Example:
-	uart0: serial@12000 {
-		compatible = "marvell,armada-3700-uart";
-		reg = <0x12000 0x18>;
-		clocks = <&uartclk 0>;
-		interrupts =
-		<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-		<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-		<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "uart-sum", "uart-tx", "uart-rx";
-	};
-
-	uart1: serial@12200 {
-		compatible = "marvell,armada-3700-uart-ext";
-		reg = <0x12200 0x30>;
-		clocks = <&uartclk 1>;
-		interrupts =
-		<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
-		<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "uart-tx", "uart-rx";
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..8b1306c14380 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14254,7 +14254,7 @@ MARVELL ARMADA 3700 SERIAL DRIVER
 M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
-F:	Documentation/devicetree/bindings/serial/mvebu-uart.txt
+F:	Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
 F:	drivers/tty/serial/mvebu-uart.c
 
 MARVELL ARMADA DRM SUPPORT
-- 
2.47.2

