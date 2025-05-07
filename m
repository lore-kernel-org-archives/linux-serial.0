Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673928B7F0;
	Wed,  7 May 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633052; cv=none; b=ESCMQd3UcvGO+utrMe4pjZ+5LluRZCxDaIMCtddoU2qRdF2xnbF1cGTlY2BsXkK+DRFZoCsdifBBQ/mm/nRkNPRywaoafb4wyADcsKbwCnFKY54h5B1CVl5FRU9QrcedZQ5v7vxIUsKqQxAyqrKX93+/9sSK1UxPjwEnaeVHH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633052; c=relaxed/simple;
	bh=nh6KOMxUfRoy7f+PjpQTE4JRl+EPsicm9X6duZF491I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EilXRa1tnP9/at2ldynk7pLv0yvA0iE757hN4qMUbBQGpV4pAXWiSY15ac+3RkuS6ZN+kkqoEY0zk30HHDazAGF5FyQnc22blKhgYTdFZ3HHkaiHBe9DL9nf5hQfqlA7AoMPof+xPvke60xGNqkzzX3XzVZckUOEOC9yRYxLiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW+uo/Ox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW+uo/Ox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0A5C4CEE2;
	Wed,  7 May 2025 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746633052;
	bh=nh6KOMxUfRoy7f+PjpQTE4JRl+EPsicm9X6duZF491I=;
	h=From:To:Cc:Subject:Date:From;
	b=CW+uo/OxVQTEueo9gBcedjcgO7XUxXklg/+LfrGUDAex4QD/TH+geo1EvQKu4SDAo
	 Xp7fQH6aLMnIShwS/NQO9sXohKx2JUs8Eb7s8F28NcKe2YMcF8kswTX+V7DLGQfJZv
	 Wubs9lfph7mzjCXq/J8jMbBcDVf6RpBBVr8PGa4Ra0B2UrmxrqjcPV2y+9TkpHR+mp
	 lo9T60VH9+Wsyp9Wg3GarOhApJe2t4vk57UVxLch1n/aSgoaHGhy3e8DWVIPGMqU7G
	 kkAQ7Z0KfziJ0F8QNoY94iw1Ao7syF0CINVT3+2OW/Anz+BIuG1BNgge/GtADTDgIF
	 9lNycqQIdVp/A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrei Pistirica <andrei.pistirica@microchip.com>,
	Chandra Mandal <purna.mandal@microchip.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: Convert microchip,pic32mzda-uart to DT schema
Date: Wed,  7 May 2025 10:49:36 -0500
Message-ID: <20250507154937.1603190-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Microchip PIC32 UART binding to DT schema. The binding was
unclear there are 3 interrupts. The functions were determined from the
driver. The 'cts-gpios' property is covered by serial.yaml schema.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Fix $id path and serial.yaml path
---
 .../bindings/serial/microchip,pic32-uart.txt  | 29 ----------
 .../serial/microchip,pic32mzda-uart.yaml      | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32mzda-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt b/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
deleted file mode 100644
index c8dd440e9747..000000000000
--- a/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Microchip Universal Asynchronous Receiver Transmitter (UART)
-
-Required properties:
-- compatible: Should be "microchip,pic32mzda-uart"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt
-- clocks: Phandle to the clock.
-          See: Documentation/devicetree/bindings/clock/clock-bindings.txt
-- pinctrl-names: A pinctrl state names "default" must be defined.
-- pinctrl-0: Phandle referencing pin configuration of the UART peripheral.
-             See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
-Optional properties:
-- cts-gpios: CTS pin for UART
-
-Example:
-	uart1: serial@1f822000 {
-		compatible = "microchip,pic32mzda-uart";
-		reg = <0x1f822000 0x50>;
-		interrupts = <112 IRQ_TYPE_LEVEL_HIGH>,
-			<113 IRQ_TYPE_LEVEL_HIGH>,
-			<114 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&rootclk PB2CLK>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_uart1
-				&pinctrl_uart1_cts
-				&pinctrl_uart1_rts>;
-		cts-gpios = <&gpio1 15 0>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/microchip,pic32mzda-uart.yaml b/Documentation/devicetree/bindings/serial/microchip,pic32mzda-uart.yaml
new file mode 100644
index 000000000000..b176fd5b580e
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/microchip,pic32mzda-uart.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/microchip,pic32mzda-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIC32 UART
+
+maintainers:
+  - Andrei Pistirica <andrei.pistirica@microchip.com>
+  - Purna Chandra Mandal <purna.mandal@microchip.com>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: microchip,pic32mzda-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Fault
+      - description: RX
+      - description: TX
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/microchip,pic32-clock.h>
+
+    serial@1f822000 {
+        compatible = "microchip,pic32mzda-uart";
+        reg = <0x1f822000 0x50>;
+        interrupts = <112 IRQ_TYPE_LEVEL_HIGH>,
+                    <113 IRQ_TYPE_LEVEL_HIGH>,
+                    <114 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&rootclk PB2CLK>;
+        cts-gpios = <&gpio1 15 0>;
+    };
-- 
2.47.2

