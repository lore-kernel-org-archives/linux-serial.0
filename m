Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09E21A43C;
	Tue,  6 May 2025 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568828; cv=none; b=pJiEPnzYvjRo3htvjMA29KcF2p7SJDzDU9w2Ep0VJkImNIqNErPenZuop4k1oNq9PNyhWCKPheVNt0iIfU+hZKvpyC36vK1WKJ6xZbdo4A9lX3etSwHfuC8wl74gmPnUNypWLJDAsnL9nMVFTW1AHn0OYrK1evhgOSPZOfSCrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568828; c=relaxed/simple;
	bh=Q7rma2RwRj36D72JBVslC3/pqB7P7ZnfkKx8oZ+43NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BH9g/wgBqU8Kn1SiTWMy8y8XldC5c4UjOCTPSMS4Lf1FkdEYbiMxIEI24bcYkC/PqyDoCf/T8QceoA9sPAJue9bo+g8Y1pL/ITLlAnAx6UuGsL//5OS+iGOB1jCekqvRuLoWPU1YkGSEA1ZVWychYtfZWyRR36B/YaMRyJgrNFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa7aXd5k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa7aXd5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5198AC4CEE4;
	Tue,  6 May 2025 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568828;
	bh=Q7rma2RwRj36D72JBVslC3/pqB7P7ZnfkKx8oZ+43NY=;
	h=From:To:Cc:Subject:Date:From;
	b=Fa7aXd5kLvyPLSMKt40QRRoZuYn77uA31RZqQwKdTC3lycJODdUqlmE8rehXx8pm3
	 nnKuLSBve3+JxcwtM4d3l2It5ed6UoLkR5P9z9dyaINoDwCHjWtz/qmunSMFweDfB8
	 k5+1Nm92BWKeH0yM8ImrRtnXJXlr3I9OfLDBuXryxqQFVadbrRfPpIphc7WoegBGzr
	 ACfDeZ4K0wFm8K3vN8Lnd/uupc7AL+Lcs6pmDgbntMHE5eDzE36Gp9Ekdre3XZB0wR
	 cI4V3+PCm8ZGzRCddNlMdlsD2/+hmGyogq/DteYBJngHovbew1Q9CJkMjVX+zpH8Y4
	 8wHYl9sheRSgw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: serial: Convert cnxt,cx92755-usart to DT schema
Date: Tue,  6 May 2025 17:00:24 -0500
Message-ID: <20250506220025.2545995-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Conexant Digicolor USART binding to DT schema. It is a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/cnxt,cx92755-usart.yaml   | 48 +++++++++++++++++++
 .../bindings/serial/digicolor-usart.txt       | 27 -----------
 2 files changed, 48 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/cnxt,cx92755-usart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/digicolor-usart.txt

diff --git a/Documentation/devicetree/bindings/serial/cnxt,cx92755-usart.yaml b/Documentation/devicetree/bindings/serial/cnxt,cx92755-usart.yaml
new file mode 100644
index 000000000000..720229455330
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cnxt,cx92755-usart.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/cnxt,cx92755-usart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Conexant Digicolor USART
+
+maintainers:
+  - Baruch Siach <baruch@tkos.co.il>
+
+description: >
+  Note: this binding is only applicable for using the USART peripheral as UART.
+  USART also support synchronous serial protocols like SPI and I2S.
+  Use the binding that matches the wiring of your system.
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: cnxt,cx92755-usart
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@f0000740 {
+        compatible = "cnxt,cx92755-usart";
+        reg = <0xf0000740 0x20>;
+        clocks = <&main_clk>;
+        interrupts = <44>;
+    };
diff --git a/Documentation/devicetree/bindings/serial/digicolor-usart.txt b/Documentation/devicetree/bindings/serial/digicolor-usart.txt
deleted file mode 100644
index 2d3ede66889d..000000000000
--- a/Documentation/devicetree/bindings/serial/digicolor-usart.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Binding for Conexant Digicolor USART
-
-Note: this binding is only applicable for using the USART peripheral as
-UART. USART also support synchronous serial protocols like SPI and I2S. Use
-the binding that matches the wiring of your system.
-
-Required properties:
-- compatible : should be "cnxt,cx92755-usart".
-- reg: Should contain USART controller registers location and length.
-- interrupts: Should contain a single USART controller interrupt.
-- clocks: Must contain phandles to the USART clock
-  See ../clocks/clock-bindings.txt for details.
-
-Note: Each UART port should have an alias correctly numbered
-in "aliases" node.
-
-Example:
-	aliases {
-		serial0 = &uart0;
-	};
-
-	uart0: uart@f0000740 {
-		compatible = "cnxt,cx92755-usart";
-		reg = <0xf0000740 0x20>;
-		clocks = <&main_clk>;
-		interrupts = <44>;
-	};
-- 
2.47.2

