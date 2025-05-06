Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB621930D;
	Tue,  6 May 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568812; cv=none; b=C722RqBPAsr2Cgki6VttgDiib/UImvcq8CZcw0kSPfUzmcPdOgnyOXWdOLtu3vepLouW4JQr9eUM/rKSaXK1K1xrlBEWAMfm7YecQIEELRKmg+y68dYPEiAhQAhDat1QSaJFoMhZ5LHNOUAap2eTAFBDs87ep2HAuCd5G2mSGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568812; c=relaxed/simple;
	bh=Mxh5XqieR954Z1YyfC7edpX6k51hFSaD+meiY3HG0oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfjUbv2xD3e4HEu8enjCTmoS35sq3krl3WnDnNMBZWQaHGhJ3SAMYLMd/jL5wZ8u2sSd8dYN0NxiMyjQiMqKryGLT4629N10lSUEEXJDmWvOdWsBbb8jY1KnrVepMmhX4sXDJ5bNgGa9YODG3tn63aEeGmt9eKicnlo7Ydhygtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNKW3qzS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNKW3qzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B706C4CEE4;
	Tue,  6 May 2025 22:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568811;
	bh=Mxh5XqieR954Z1YyfC7edpX6k51hFSaD+meiY3HG0oY=;
	h=From:To:Cc:Subject:Date:From;
	b=kNKW3qzSyAe/ADwSc8ibxJLYmiu6CrXW2ZmHFDdM9U9QDgHrdGfHp/xTG18lEg1Zw
	 PaWkm+wxy38hb0vevL4oPPqJYiHYK8/P7ifpdRtpLddGnWqft1A+HGxjBYP/iB41WS
	 2YDLRnEte9rLnznrDsAjvcH56/3E5Z1gtOTG2/mUV7EzwFkyWZcrCmA7xPHqNqb5/3
	 AdAQt8/0qgKm1PFTFKAmU2ehtORQz9yQr9ogQAewzGGbcID7iLn1Bt7lwJaiy2bIlL
	 W4QfYMeIgv1WwGTNn9xTdKKOLwBodYoIN6WL9uOSmumfwLwmEU9gGsgM+oZaLGMVEN
	 0WONgC+jJqb0A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert snps,arc-uart to DT schema
Date: Tue,  6 May 2025 17:00:07 -0500
Message-ID: <20250506220008.2545296-1-robh@kernel.org>
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

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
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
index 000000000000..b5d7eec60018
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/snps,arc-uart.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/snps,arc-uart.yaml#
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

