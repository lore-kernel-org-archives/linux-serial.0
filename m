Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCC28C2BE;
	Wed,  7 May 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632961; cv=none; b=ZWYNJTzYzw9NScYKtwAoy2J54P3npd/x0TABMxOyqOBYAc/9hPBmqcBXOP37qoPXJrwSYmFBEs4jcNWxYq5VAn6t58cIKH5IHSLAVkla/gIQdja0vimtLL+UdVSRhQJA3S3oRDixe7ZP/+jaVhpR70v3o+xIdGRKEggvIZ8UTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632961; c=relaxed/simple;
	bh=Qz2S8MvbXorS/O9W3+q+a20k0SMmkwl6OV3DS1CxKVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/IbX3YNUO+ujBiBqsEyPcJYefKr2uLe1FAqp2ZcIYBNEyxXR3U9W7dU5NSRT3PTmiCO+aGnMxI8zx/UgHZs9h9sdgBF1x3r2na/JUk9NgyxizuPEWRC7W84LrKTmIfBOcTYYZZN10A0J4izGDEcOeEMPBA4qfcrBPmBp+s5yqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQOwPYQP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQOwPYQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F86C4CEE2;
	Wed,  7 May 2025 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746632960;
	bh=Qz2S8MvbXorS/O9W3+q+a20k0SMmkwl6OV3DS1CxKVA=;
	h=From:To:Cc:Subject:Date:From;
	b=tQOwPYQPWO8QO6iseBgX7DZEX9/efEiZcN9Badmeq7zIDV4oJiTMhlfRiNzAzvhN5
	 GjKBccWxwAkL01vzj0TbjpESdKKkgLkG3NW9nMHs6w2PPz1TRm7XKx3iujk3p6MbrX
	 5Y34I2CCmURnXjTtQy952lpMlAwzfx53Fk5zYyzI0y7GiNyU1GuW5gb4ZxXJs/C67Z
	 6xiBpx/VBoSBW+o81Fl3m9eVXKRmQM4X88CdrqgyP88HJ7/fNq6MajH7JqE9PCIk4M
	 1p7pZBMyjYNfgOmRjQKyj0Wqs3aw0p0yWAZXybMNeq1mdhkYEBu8tRAf60BF7ZMTwP
	 bLF2a4SgBLFnw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: Convert snps,arc-uart to DT schema
Date: Wed,  7 May 2025 10:49:08 -0500
Message-ID: <20250507154909.1602497-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Synopsys ARC UART binding to DT schema. Drop the "aliases"
portion which is not relevant to this schema.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Fix $id path
---
 .../devicetree/bindings/serial/arc-uart.txt   | 25 ---------
 .../bindings/serial/snps,arc-uart.yaml        | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/arc-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/snps,arc-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/arc-uart.txt b/Documentation/devicetree/bindings/serial/arc-uart.txt
deleted file mode 100644
index 256cc150ca7e..000000000000
--- a/Documentation/devicetree/bindings/serial/arc-uart.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Synopsys ARC UART : Non standard UART used in some of the ARC FPGA boards
-
-Required properties:
-- compatible		: "snps,arc-uart"
-- reg			: offset and length of the register set for the device.
-- interrupts		: device interrupt
-- clock-frequency	: the input clock frequency for the UART
-- current-speed		: baud rate for UART
-
-e.g.
-
-arcuart0: serial@c0fc1000 {
-	compatible = "snps,arc-uart";
-	reg = <0xc0fc1000 0x100>;
-	interrupts = <5>;
-	clock-frequency = <80000000>;
-	current-speed = <115200>;
-};
-
-Note: Each port should have an alias correctly numbered in "aliases" node.
-
-e.g.
-aliases {
-	serial0 = &arcuart0;
-};
diff --git a/Documentation/devicetree/bindings/serial/snps,arc-uart.yaml b/Documentation/devicetree/bindings/serial/snps,arc-uart.yaml
new file mode 100644
index 000000000000..dd3096fbfb6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/snps,arc-uart.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/snps,arc-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys ARC UART
+
+maintainers:
+  - Vineet Gupta <vgupta@kernel.org>
+
+description:
+  Synopsys ARC UART is a non-standard UART used in some of the ARC FPGA boards.
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: snps,arc-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    description: the input clock frequency for the UART
+
+  current-speed:
+    description: baud rate for UART
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-frequency
+  - current-speed
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@c0fc1000 {
+        compatible = "snps,arc-uart";
+        reg = <0xc0fc1000 0x100>;
+        interrupts = <5>;
+        clock-frequency = <80000000>;
+        current-speed = <115200>;
+    };
-- 
2.47.2

