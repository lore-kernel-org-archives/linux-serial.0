Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65B1E522;
	Wed,  7 May 2025 02:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583410; cv=none; b=huTnkSQTsZ/mbgR653WYyOdv7aY/+igun010jdA7QSM30ul+pMjftNvT08cZ+uJ/RcbtV4tedeiNttaJr87psupUNYVN6EJhBllBhesaozc2D18YzGXFjDTS5ybLwNk144fp6hUyfn/1xC4Ot6NggYfTguHZBn0nQEor8cb01sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583410; c=relaxed/simple;
	bh=iWUfpozT6gTBIvpNZECYHH6SUFyXp8R9OvUIR/bNZhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fMchEdasfCq+qIZ/6IGKG/GSpJeDTOz70jB21xYwfl+D6Rkgu0qjVjpmjBkLSWAAxXeAnGq7yy0fZVr4q4YB7UOuKjIHojkWBRdN83C/OlifZaxplQK9sAkJdIbjXKgSIz2iSoVzGDuDRuTqT7VjFEYcYpvHLfTxe/0XigMVFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovQpq0FE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovQpq0FE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A74FC4CEE4;
	Wed,  7 May 2025 02:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746583410;
	bh=iWUfpozT6gTBIvpNZECYHH6SUFyXp8R9OvUIR/bNZhk=;
	h=From:To:Cc:Subject:Date:From;
	b=ovQpq0FEtMuXJMnvGfqL61jPvx8tnPczAGSBVc+o7C+Qaj7SB8N+WYioA7dyMNua+
	 qQfbeEZ21H7thdDb4lfVHiHS1GfAgeFohlcvATfY0EV9P8NSUkxdXqwmaEx9gxVIOF
	 qd6UWxxAflTpB6Xafah9OZ2gRwbxMt6hwHVjnVYxN+n/sENP7kVOuypqjmEWs16xEl
	 Hk1ILyPXF66eN3/s7UpW2Bld6EbEuyM+j5/nw7D3KlOd6oG6NZHTLxREY4keMqqflI
	 ahXjYhBM3p0wQ/KncDOTjKqZJczMdxjixC4mk+cB2dXYAdWAkyRKH1oMMc9vm9ljsm
	 ZBGj5R3XgSspA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: Convert marvell,armada-3700-uart to DT schema
Date: Tue,  6 May 2025 21:03:21 -0500
Message-ID: <20250507020325.3407521-1-robh@kernel.org>
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
index 000000000000..231e1e9d1d72
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
+  - $ref: /schemas/serial.yaml#
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

