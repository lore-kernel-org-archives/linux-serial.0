Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D421930D;
	Tue,  6 May 2025 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568816; cv=none; b=k0oDipxbsZ2kGPKPz4pkTuhec8lFAc6VJ8Hn0FnaXxR0kgwutpxhzIMPxcl+ju50H1iJnQSeWIETsmmVGlcBGX8IYCZwCMdXmPxnMT3HifkNaVCw40bNi1tS+n7EDi7cWAbHFtBDH+UbMqcF0cl4QB4BswfsiXwYm/DhX1yWnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568816; c=relaxed/simple;
	bh=/+KalfFDzI80dknz8+VTKph/XzS0C0WyqI20V4kemKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSVblJYW2LZl1bJ5TXCVcqB5efk+CF3FduxQRqKhxuljg4zMADDXniGRKkhUpR2AEOWXtuLKIp6wodjLJnMMC3qVpxZFlUR+G9AEb9+dV6Fq8sQjwhzGbG9zOlTkNYoRe8Pi7lnzTopgDKWkcJ/0OWwI4EKRtYIQ4sRd9wjj5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPeFx3Jt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPeFx3Jt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC21C4CEE4;
	Tue,  6 May 2025 22:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568815;
	bh=/+KalfFDzI80dknz8+VTKph/XzS0C0WyqI20V4kemKk=;
	h=From:To:Cc:Subject:Date:From;
	b=IPeFx3JtbKD48/vdr6KT0DoGPaB5rRo8NmKdt/oNs0fq7qPCowf98T3IfGWWcZ2pq
	 Xo4sQ0pNkTafRBRslPstN/7rRpamTVyjBnvfJeeyeciDNXrnhf6SZJrD01MaZ9Kt5O
	 KXHMxh9dDcHJMrFQdvA4WxJQOXHGdTf1DVDoLREMhndI5XyJ4GkRj3QYVf385seiHn
	 EL8teOD+jLL6Y+N9tWPpxiIlKWjIAn7nl7ce1K3E4/bjGBYCM8ZH6PlaSCJwUyv7dP
	 W6UWn4BUefJ86BuaIfSws2UyCU49dGgeWsF7pIh3ihByFzxA60K6avpN7fsFvLwxau
	 a73SD/Tg8ghwg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Vladimir Murzin <vladimir.murzin@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: serial: Convert arm,mps2-uart to DT schema
Date: Tue,  6 May 2025 17:00:11 -0500
Message-ID: <20250506220012.2545470-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Arm MPS2 UART binding to DT schema. It is a straight-forward
conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/arm,mps2-uart.txt         | 19 --------
 .../bindings/serial/arm,mps2-uart.yaml        | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt b/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
deleted file mode 100644
index 128cc6aed001..000000000000
--- a/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-ARM MPS2 UART
-
-Required properties:
-- compatible	: Should be "arm,mps2-uart"
-- reg		: Address and length of the register set
-- interrupts	: Reference to the UART RX, TX and overrun interrupts
-
-Required clocking property:
-- clocks	  : The input clock of the UART
-
-
-Examples:
-
-uart0: serial@40004000 {
-	compatible = "arm,mps2-uart";
-	reg = <0x40004000 0x1000>;
-	interrupts = <0 1 12>;
-	clocks = <&sysclk>;
-};
diff --git a/Documentation/devicetree/bindings/serial/arm,mps2-uart.yaml b/Documentation/devicetree/bindings/serial/arm,mps2-uart.yaml
new file mode 100644
index 000000000000..4a8df078e6f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/arm,mps2-uart.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/arm,mps2-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm MPS2 UART
+
+maintainers:
+  - Vladimir Murzin <vladimir.murzin@arm.com>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: arm,mps2-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: RX interrupt
+      - description: TX interrupt
+      - description: Overrun interrupt
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
+    serial@40004000 {
+        compatible = "arm,mps2-uart";
+        reg = <0x40004000 0x1000>;
+        interrupts = <0>, <1>, <12>;
+        clocks = <&sysclk>;
+    };
-- 
2.47.2

