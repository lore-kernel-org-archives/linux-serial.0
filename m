Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C021A427;
	Tue,  6 May 2025 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568841; cv=none; b=luAO2QpMrFVsK8JpwEFwwMnoWnlRmtQC6RCe+BOSgonz6bpVq+9MR+pp9bvA+B6SKRgDos25RISqpwMtHcGn2SNrohOyIrqptaplwBSmUWkNCOp6Aky/gcjPSuDrP0jGmQyJXDm2zQUvwVmKRoxw7bY0JVaTCiuC14XrYrDUQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568841; c=relaxed/simple;
	bh=gcf1J8rzv6+webHzaN9XOJsTcMRO4EZlNlQ175HgN+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hll036Bh4ezvvfu8+xhNUQN+nr+FMfZui0s1wha97BUtBvn9GybcqX/nFFW2pTWuxxy1BRqFTQJNxos46f4C2VT8DcuAq++i5uqWtauXACk6lvU9/LLXvSdvvg7aBPeTH1mIbwQiQxNkbakSf5mJGnrXnsB3eyOU8cszc0PCf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ8FMTv/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ8FMTv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E79C4CEEF;
	Tue,  6 May 2025 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568840;
	bh=gcf1J8rzv6+webHzaN9XOJsTcMRO4EZlNlQ175HgN+M=;
	h=From:To:Cc:Subject:Date:From;
	b=BZ8FMTv/l5xpG+wtcWuecDth82Inh+KHHULm9TcSs/ZEwCCZe8K+hc3vH+ADoCKf8
	 crfFpa/lDAoR2puOmhR5q5n3pwm/pDc0qqjSZQ6tfsq5BzkA49Ws18VWai6K8bMf25
	 0LtTq9jnHpAJci7v3G0qPphGGRKoV8GeTwvZoqRCmYgt36f2R1TZe2oK3d3+KzByqQ
	 2y/n/4FW0yvqjmSnpAeAMZ4IAQXsQCQoBrzQg6Q3fkG/9W1/KgrZuXuUaDPzYg0FLN
	 sdaZh6IDj2Nskd1E1V0H8eKn87wVQ31/SbYVdEMckwLWKTEWYl+ZMFRjThxFZphCbB
	 PsJBc9D2VI0tQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: serial: Convert socionext,milbeaut-usio-uart to DT schema
Date: Tue,  6 May 2025 17:00:37 -0500
Message-ID: <20250506220038.2546557-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Socionext Milbeaut UART binding to DT schema. It is a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/milbeaut-uart.txt         | 21 -------
 .../serial/socionext,milbeaut-usio-uart.yaml  | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/socionext,milbeaut-usio-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
deleted file mode 100644
index 3d2fb1a7ba94..000000000000
--- a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Socionext Milbeaut UART controller
-
-Required properties:
-- compatible: should be "socionext,milbeaut-usio-uart".
-- reg: offset and length of the register set for the device.
-- interrupts: two interrupts specifier.
-- interrupt-names: should be "rx", "tx".
-- clocks: phandle to the input clock.
-
-Optional properties:
-- auto-flow-control: flow control enable.
-
-Example:
-	usio1: usio_uart@1e700010 {
-		compatible = "socionext,milbeaut-usio-uart";
-		reg = <0x1e700010 0x10>;
-		interrupts = <0 141 0x4>, <0 149 0x4>;
-		interrupt-names = "rx", "tx";
-		clocks = <&clk 2>;
-		auto-flow-control;
-	};
diff --git a/Documentation/devicetree/bindings/serial/socionext,milbeaut-usio-uart.yaml b/Documentation/devicetree/bindings/serial/socionext,milbeaut-usio-uart.yaml
new file mode 100644
index 000000000000..37db6459b67a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/socionext,milbeaut-usio-uart.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/socionext,milbeaut-usio-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext Milbeaut UART controller
+
+maintainers:
+  - Sugaya Taichi <sugaya.taichi@socionext.com>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: socionext,milbeaut-usio-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: RX interrupt specifier
+      - description: TX interrupt specifier
+
+  interrupt-names:
+    items:
+      - const: rx
+      - const: tx
+
+  clocks:
+    maxItems: 1
+
+  auto-flow-control:
+    description: Enable automatic flow control.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@1e700010 {
+        compatible = "socionext,milbeaut-usio-uart";
+        reg = <0x1e700010 0x10>;
+        interrupts = <0 141 0x4>, <0 149 0x4>;
+        interrupt-names = "rx", "tx";
+        clocks = <&clk 2>;
+        auto-flow-control;
+    };
-- 
2.47.2

