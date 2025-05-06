Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A421A44D;
	Tue,  6 May 2025 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568824; cv=none; b=ZyF/HFkT+oS/FRxOew9nIh6SkWM4Pi6zENg391vjBdKbe30Srd/MwwOHKr/HnYxgHBXFmM5NcukA8LobHHKvMly0vfbJh5hHCZ2mD8Fs6JlTOwH1Wo5LckmdT4YDbw52PmbhIOqmr65y1ntTpdoN1M5pCx6IBEyvNCGiARUT4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568824; c=relaxed/simple;
	bh=q8TYgk9SPRa4xiti0wSSTzXmNd2FPif6jOlKvSPWt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujKMGsULsmHUEmFOPwmsjuF5DUKCmypqHTwt2AyiGNBptDLTRmNDXoTP1p+AcckoyzMGvsX26TSgXK7Sp5h+9Yc9uFaGYTAjGx8RrA1XwhB/R+1SEx8nGgIygQs009+mflN9P63t+LH8wnoM8u8ZqF599WFWJ9pqqTIDdOO9e1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0zYOxcm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0zYOxcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712D5C4CEE4;
	Tue,  6 May 2025 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568823;
	bh=q8TYgk9SPRa4xiti0wSSTzXmNd2FPif6jOlKvSPWt5U=;
	h=From:To:Cc:Subject:Date:From;
	b=b0zYOxcm0bxFTWVLyLQTqNzPlStmHRSUp9W/9Qig1cFHSgDgLxJPxoixeBe5O8M5A
	 ZE+Gm37+BnN0AhBmVx8cy4hVkMDq4ygarBA51+gd2hMv6Jlt4lu6Uc6/7eCYILZoOv
	 TMNxxWA+SJUXEZOiKWtC3sZ/Hl8MAOoHEqCOm3I87RqFAZZlt0NIKz/GKkuLX36A6N
	 su6YbiayxD77AOlpfQSYxuGmWqnRCBn+2Ig2J1Wte4rN1JklOAuo/uzf+1WN/xz3O0
	 Q/G3OCguNF3doX01kt+hFlvJAMy0THKZw8+kkl8dBsXpxoClTTD46J4jSDoUAqmxrz
	 DyH6dGDDX499Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert cirrus,ep7209-uart to DT schema
Date: Tue,  6 May 2025 17:00:19 -0500
Message-ID: <20250506220021.2545820-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Cirrus EP7209 UART binding to DT schema. There is no user of
"cirrus,ep7312-uart" other than the example, so drop it. Drop the
"aliases" node part as it is not relevant to the schema. The modem
control GPIOs are covered by the serial.yaml schema and don't have to be
listed in the schema.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/cirrus,clps711x-uart.txt  | 31 ----------
 .../bindings/serial/cirrus,ep7209-uart.yaml   | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/cirrus,ep7209-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
deleted file mode 100644
index 07013fa60a48..000000000000
--- a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* Cirrus Logic CLPS711X Universal Asynchronous Receiver/Transmitter (UART)
-
-Required properties:
-- compatible: Should be "cirrus,ep7209-uart".
-- reg: Address and length of the register set for the device.
-- interrupts: Should contain UART TX and RX interrupt.
-- clocks: Should contain UART core clock number.
-- syscon: Phandle to SYSCON node, which contain UART control bits.
-
-Optional properties:
-- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
-  line respectively.
-
-Note: Each UART port should have an alias correctly numbered
-in "aliases" node.
-
-Example:
-	aliases {
-		serial0 = &uart1;
-	};
-
-	uart1: uart@80000480 {
-		compatible = "cirrus,ep7312-uart","cirrus,ep7209-uart";
-		reg = <0x80000480 0x80>;
-		interrupts = <12 13>;
-		clocks = <&clks 11>;
-		syscon = <&syscon1>;
-		cts-gpios = <&sysgpio 0 GPIO_ACTIVE_LOW>;
-		dsr-gpios = <&sysgpio 1 GPIO_ACTIVE_LOW>;
-		dcd-gpios = <&sysgpio 2 GPIO_ACTIVE_LOW>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/cirrus,ep7209-uart.yaml b/Documentation/devicetree/bindings/serial/cirrus,ep7209-uart.yaml
new file mode 100644
index 000000000000..c9976e86872b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cirrus,ep7209-uart.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/cirrus,ep7209-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CLPS711X Universal Asynchronous Receiver/Transmitter (UART)
+
+maintainers:
+  - Alexander Shiyan <shc_work@mail.ru>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: cirrus,ep7209-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: UART TX interrupt
+      - description: UART RX interrupt
+
+  clocks:
+    maxItems: 1
+
+  syscon:
+    description: Phandle to SYSCON node, which contains UART control bits.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - syscon
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    serial@80000480 {
+        compatible = "cirrus,ep7209-uart";
+        reg = <0x80000480 0x80>;
+        interrupts = <12>, <13>;
+        clocks = <&clks 11>;
+        syscon = <&syscon1>;
+        cts-gpios = <&sysgpio 0 GPIO_ACTIVE_LOW>;
+        dsr-gpios = <&sysgpio 1 GPIO_ACTIVE_LOW>;
+        dcd-gpios = <&sysgpio 2 GPIO_ACTIVE_LOW>;
+    };
-- 
2.47.2

