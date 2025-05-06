Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605D221ADCB;
	Tue,  6 May 2025 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568833; cv=none; b=badd3Z9k5AVZI4Fe0LoVp3r/7iqN7zXBSColEey8vENle0L2RadEvUofL64r0cxsgB6Mzl2PaDYS8GAQUfwBlepCbrcPxCAxvyhP55KdqW/fslBJ/ncRHHkgeePqo0yr7tXtFmUr5RQb/1tN6aIvHiBXMPW+9C1yE3T/t+xbgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568833; c=relaxed/simple;
	bh=P01iPKBxcC3Otadr9AfB+mFcfIaKMqAcqLS8zbFFI48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=br9o7YBkT8iw0Hve6CDL7nOy0clhs+kV9KHg9KYqqx3Urpl2V+g4XKE9pgLAwEr6WeWnTFI8axG20fPJVXiQO5KqimcU0mcHddgXE3yWMeyHBQJy3zCrJAD4HmLs/Vtb87wX0krkDA5RXaWBVpB7RbLKZGt052Ii+w9JvgU284o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttYuSqLa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttYuSqLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D994C4CEE4;
	Tue,  6 May 2025 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568832;
	bh=P01iPKBxcC3Otadr9AfB+mFcfIaKMqAcqLS8zbFFI48=;
	h=From:To:Cc:Subject:Date:From;
	b=ttYuSqLaaPN21I+V0ylPIwZj5dprp4MJx+6LqlvzHyzKatOTVEHKlxyNUCPt5a0l3
	 V9d9lsy6v3DoAM/PiiV8rKuFlHVzDqc2pNuMkkW/i/ck7nwJw7BjueTH8yYFFLqM2l
	 Rqr3IRkxhA9XCtQj+ybQJeytpphAPpDA/UYr/IYkXRIiVSWOThS2k+oe9+RBofI1/t
	 haC6/52Oas7fXGy8qN1dPingccMF8bgTephfM12wlEDw6J4Jnbf94OouXxkFeEoS5C
	 i8YGKhUSWb+pTLbV4xgzl+btDTnvodzSFNbZ1tdPXmhUCN7pCudm1qubDwEwB5jC+u
	 3Ue/YQls2eBeA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	John Crispin <john@phrozen.org>,
	Songjun Wu <songjun.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert lantiq,asc to DT schema
Date: Tue,  6 May 2025 17:00:28 -0500
Message-ID: <20250506220029.2546179-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Lantiq SoC ASC UART binding to DT schema. There are no such
clock identifier defines nor a user with clocks, so drop the example
with clocks.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/lantiq,asc.yaml           | 56 +++++++++++++++++++
 .../devicetree/bindings/serial/lantiq_asc.txt | 31 ----------
 2 files changed, 56 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/lantiq,asc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt

diff --git a/Documentation/devicetree/bindings/serial/lantiq,asc.yaml b/Documentation/devicetree/bindings/serial/lantiq,asc.yaml
new file mode 100644
index 000000000000..96e8c79cb047
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/lantiq,asc.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/lantiq,asc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq SoC ASC serial controller
+
+maintainers:
+  - John Crispin <john@phrozen.org>
+  - Songjun Wu <songjun.wu@linux.intel.com>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: lantiq,asc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: TX interrupt
+      - description: RX interrupt
+      - description: Error interrupt
+
+  clocks:
+    items:
+      - description: Frequency clock
+      - description: Gate clock
+
+  clock-names:
+    items:
+      - const: freq
+      - const: asc
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
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+
+    serial@16600000 {
+        compatible = "lantiq,asc";
+        reg = <0x16600000 0x100000>;
+        interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
deleted file mode 100644
index 40e81a5818f6..000000000000
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Lantiq SoC ASC serial controller
-
-Required properties:
-- compatible : Should be "lantiq,asc"
-- reg : Address and length of the register set for the device
-- interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
-  depends on the interrupt-parent interrupt controller.
-
-Optional properties:
-- clocks: Should contain frequency clock and gate clock
-- clock-names: Should be "freq" and "asc"
-
-Example:
-
-asc0: serial@16600000 {
-	compatible = "lantiq,asc";
-	reg = <0x16600000 0x100000>;
-	interrupt-parent = <&gic>;
-	interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
-		<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
-		<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
-	clock-names = "freq", "asc";
-};
-
-asc1: serial@e100c00 {
-	compatible = "lantiq,asc";
-	reg = <0xE100C00 0x400>;
-	interrupt-parent = <&icu0>;
-	interrupts = <112 113 114>;
-};
-- 
2.47.2

