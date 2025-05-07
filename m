Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B028BAA5;
	Wed,  7 May 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632973; cv=none; b=K0+butVhiuST8jALlhdN62vk56MOghNXgNUJqp1UNNc3OQXucs6Mh+L7hQUNjRA4Dw8+Jhq8OdCfnnWxCKqI6WkVdRKOA0aw9+DeXnYbNxrz1YmrXEdo7jQDMbOHWlkVgUlq0Bq+vuV+sfVTigRiqup5jkzr/8GxQyMGypwBrus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632973; c=relaxed/simple;
	bh=Tp8NdrkzlSlV2qbKcvvrIUR3zgxxR1AAJTORcyzUazM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=na9BHRce8cGCDDEfaPKDv46x3vEELXeMsPRhsbLuvD9ZfGzOCyKfogKSn8+QRbAt9tamPzLr77R7BMI2Hr0e1Q1mhnyxqEDNxMdVMDaU56wmlCOM7v/2IDCyhJLf0FtAVea+FpRXAanrMe/kfplV28Q9SpWRAp1wZbzPX79pvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJMFQ5xX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJMFQ5xX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0111C4CEE2;
	Wed,  7 May 2025 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746632972;
	bh=Tp8NdrkzlSlV2qbKcvvrIUR3zgxxR1AAJTORcyzUazM=;
	h=From:To:Cc:Subject:Date:From;
	b=iJMFQ5xXd5/NPJU1rTDYfFCPEXo9wEQPkrPTbD76lclEZlppbkn8LW+J2UZLwGtRB
	 HnRFjosuyiQoZH2YPjDxE/eazD5CMNqOyUc3aX/CNVggCIpWduzs6qcqGsFGqn6OQb
	 Rz7iwLo0rDqh5jW5FTWCtwmlIGrz0rThaYDr0IrpcQj7v58J8mBQB+r53XQiHn+vht
	 FZm6SNDwh/nSFAGFPUySzVTFPX2ZPb8M/1Z+nLfa+//QIkw0+c6KJDhi5SZ1Ey4o4p
	 jTd+aPeLd/M1Z/vy1SDvJVTgFzo5E3qYYlsh0JCCcv7UNG7/tQX9a8bCt8pXXXl0O6
	 9SkASNlXi02Bg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>
Cc: Thierry Reding <treding@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: serial: Convert socionext,milbeaut-usio-uart to DT schema
Date: Wed,  7 May 2025 10:49:22 -0500
Message-ID: <20250507154924.1602842-1-robh@kernel.org>
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

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Fix $id path
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
index 000000000000..34a997ca2e11
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/socionext,milbeaut-usio-uart.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/socionext,milbeaut-usio-uart.yaml#
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

