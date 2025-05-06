Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41921CA02;
	Tue,  6 May 2025 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568851; cv=none; b=tWUJ+6YBIUG46gNXY376fOR0Cd1MF6eBEGzob+WU+LoZwwegpXUjjUvfbe7XHbJ/EUUD7285tRnRfqOyL9FBFIXhWaI03pyVQIIa46pvTQKRDAs6czBcGczYVxyfqPkTe4kJi+1i6tqXP+jWeSoMQ/rED6NmjAr3bqMexMrbLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568851; c=relaxed/simple;
	bh=eM85/T2zv3JvHnzRMBYb0t05nCijCfpQv0/4QmBfOpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQ+S1fEfCgSFU1NktKg/CgeotyVFYOQZgsO2KzxwhHtnz6ohOBPRxzBi2ZVGBkzHhnqhYWVyAAI6y+2NP/VT0XRFHhtHWseUWWwkXJRBttcHpFlpgabsZUJ5holSKEv/ALkDbzq6s+OUSaMIAE/GeHGrzyhRqRUeAX6uecdYErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H86Y0XIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H86Y0XIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3C5C4CEE4;
	Tue,  6 May 2025 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568851;
	bh=eM85/T2zv3JvHnzRMBYb0t05nCijCfpQv0/4QmBfOpU=;
	h=From:To:Cc:Subject:Date:From;
	b=H86Y0XIFCJqx57Bxaf6FZO4W92RJ0izJRVnhHyT5uvDBvdSLEDr+nfd35Kyf93bjo
	 rjuPsBvItXlxr7yc5mseXmLONJMxDkGAIQGdVI4J8q7JVmaZXmoX5P89zkode8sLdh
	 UMADIAARzm3tECBIGV4AhBmC/IBQBKQXJHNtte67QQ6mjOinWzE1ohPp7BUNZjqC8k
	 q//wvYcdk6i5Sa2aYSoJBd2aje+8GSu8PR0fDDNKEzJGlTslv1GasDV9Ob1jI3ga/G
	 QZT2FKQLgB3YkKORFvalxSc1tk5HAOB0ajroDeFAzNdjgsp0HbS9msc/d41KTbPF8P
	 g5zdyKYGGeEwA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: serial: Convert nxp,lpc3220-hsuart to DT schema
Date: Tue,  6 May 2025 17:00:47 -0500
Message-ID: <20250506220048.2546915-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the NXP LPC3220 HS UART binding to DT schema. It is a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/nxp,lpc3220-hsuart.yaml   | 39 +++++++++++++++++++
 .../bindings/serial/nxp-lpc32xx-hsuart.txt    | 14 -------
 2 files changed, 39 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc3220-hsuart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/nxp-lpc32xx-hsuart.txt

diff --git a/Documentation/devicetree/bindings/serial/nxp,lpc3220-hsuart.yaml b/Documentation/devicetree/bindings/serial/nxp,lpc3220-hsuart.yaml
new file mode 100644
index 000000000000..ffa2ea59f256
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nxp,lpc3220-hsuart.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/nxp,lpc3220-hsuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32xx SoC High Speed UART
+
+maintainers:
+  - Vladimir Zapolskiy <vz@mleia.com>
+  - Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: nxp,lpc3220-hsuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@40014000 {
+        compatible = "nxp,lpc3220-hsuart";
+        reg = <0x40014000 0x1000>;
+        interrupts = <26 0>;
+    };
diff --git a/Documentation/devicetree/bindings/serial/nxp-lpc32xx-hsuart.txt b/Documentation/devicetree/bindings/serial/nxp-lpc32xx-hsuart.txt
deleted file mode 100644
index 0d439dfc1aa5..000000000000
--- a/Documentation/devicetree/bindings/serial/nxp-lpc32xx-hsuart.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* NXP LPC32xx SoC High Speed UART
-
-Required properties:
-- compatible: Should be "nxp,lpc3220-hsuart"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt
-
-Example:
-
-	uart1: serial@40014000 {
-		compatible = "nxp,lpc3220-hsuart";
-		reg = <0x40014000 0x1000>;
-		interrupts = <26 0>;
-	};
-- 
2.47.2

