Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66321ADCB;
	Tue,  6 May 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568837; cv=none; b=Y4erj+zhwZ6mjXuDjZDLUpmoYJ9HY8MWRhkRYgTXHDAi4AtYHT+ZvBvinupIQ4mNKnslnzx32Exask5WKXZY1b3TbwFRIBv7yrVJ/wLLygnecqvSE0HDgy08iDhMNMP/2ED15seNMrRuGIOssL8VhlF254sjsy0F1Kl1LawtBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568837; c=relaxed/simple;
	bh=h+whgQfUqdWH8Q07OSCUd2LeCaWYZ0wVNxpoIuJs6jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrm6WNG3WVVDbDIZadfunX6HWEj/MYULlcF6Igdyr8w13pVa8Fen35T6yxx0O7blR6Caw9inf9bKyTBWk5ZAFcFb3rWByeTaAJsnWjOzX5ub92jWdByTwNVMMLAuTz/eXy2qIIWN7JIoo+Bl7xmp20Plp1XQ2WvmRu/+ERrng0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQm4nZ8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQm4nZ8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C7FC4CEE4;
	Tue,  6 May 2025 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568836;
	bh=h+whgQfUqdWH8Q07OSCUd2LeCaWYZ0wVNxpoIuJs6jk=;
	h=From:To:Cc:Subject:Date:From;
	b=KQm4nZ8TJEGqdfxbdHA0ha/YpX5SfHETI5Q/1VSe/IUtUbbbn3YHH4WNp2+rL6swN
	 eMmEO/DCUVolAw6/y1E0FYSQVKhybr8gGDiAuYSX+Dx+JMkMCM8NnGSq8Bo6s9FLZN
	 GV7Uqnc8af1nZ2LR1WNEeBQxq+jTOD6iDpu0ZT8EUfknzKL4Kvisn24tOoQugKPHid
	 FY/LJTmm6nzl6J5TG+Ka1NPPo8aSSwz1t3Dq3SWBdNUSAUvhaHg3+sWlwzIeDbwtcL
	 Mq0+v1Xmejlo72Xro4ahkcU15taSMh63Al4EV6qRjVa/GCOQOWUeGmlIOOu1iSV8c1
	 5pqpLW3OZl/MA==
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
Subject: [PATCH] dt-bindings: serial: Convert microchip,pic32mzda-uart to DT schema
Date: Tue,  6 May 2025 17:00:33 -0500
Message-ID: <20250506220034.2546370-1-robh@kernel.org>
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
index 000000000000..44b2d5a289f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/microchip,pic32mzda-uart.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/microchip,pic32mzda-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIC32 UART
+
+maintainers:
+  - Andrei Pistirica <andrei.pistirica@microchip.com>
+  - Purna Chandra Mandal <purna.mandal@microchip.com>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
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

