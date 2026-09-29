Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7641D4F4;
	Tue, 29 Sep 2026 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663775; cv=none; b=IKRpRKCnqrfb2Ls9LXh9Ydwel3Y8v9SfKcVchvD0l4xCTYhsiYsBYIPEGyo2D2L39hbmtNCMu0jBuMFyYtoLzF5N2xD8WAXTJ03UeW0oP1f2rySSYH313Xu0lWtT25Z3igoiiULjmdacS4drrTARev+5wYopUTU9cSz5Q1OSYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663775; c=relaxed/simple;
	bh=5NoCBVFlAxYBfKmdQdRKug1rV9iAfFD7VdfT2zuV4CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrvbYA34nEuZWokvzQQ+1VAb3mNapCK0ZLf031iuB+ZjSAsZlUhtAATUSxMlf8WvEYJkkeRnnVe5TisDEPHSKW2khCDnr5zXZm/Fo3Lafud7iwiUGXdTdlXT702Ab7mYp3uZ+3TKmqMCINwZ6WwmPoDDoav4jLmC3Z56LZodKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs1APU3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs1APU3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCD41F0089A;
	Tue, 29 Sep 2026 06:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663773;
	bh=e0VGD3X/peauhNb/icV3qvhJKQ5zgJQNYDC9a4QoeC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bs1APU3NscaEec/mANEaayJt9GkGjMdfrdY4NxI7xRCp5WHO7c6pr2zPQCj2LudvV
	 Zta283jpfO/hZY9skQmm9I8nf5f1IXgzm84GdKSYjrxV+ahXqSHvuBkH/7zhjXfPZ1
	 G51Ty//cxojqV+BSaQtJR49mL8Qd9fpt9ll5rZqSoJ/oLRmhYCrm379p0KEUbjB1Z/
	 FsN11tTXJTepR0A333KtbK/DqflQuyQbvJ5nvnAejKdd4SB8qlnIUxxBT6gmhk/7FQ
	 J0C238fPG+l5mwM58iK0CdInfftCvTZlSobilennqjgJLW2vgQCu8VNsZR5gwAnFEM
	 d7bhWTtDBWxjA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 17/20] dt-bindings: mfd: Add Synaptics SL261x global block binding
Date: Tue, 29 Sep 2026 14:14:14 +0800
Message-ID: <20260929061417.20733-18-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929061417.20733-1-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the AVIO global, CPU wrapper, chip control, and MCU global
register blocks on SL261x SoCs. Each block exposes its clock and, where
applicable, pinctrl and reset functions through child nodes.

Document the chip control syscon phandle used by the CPU clock
controller.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/mfd/syna,sl261x-gbl.yaml         | 208 ++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml

diff --git a/Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml b/Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml
new file mode 100644
index 000000000000..3e5842169c4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/syna,sl261x-gbl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics SL261x global and control register blocks
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+description: |
+  The SL261x global and control register blocks contain clock, reset, and
+  pin control registers. Each functional child uses its parent's register
+  range. The CPU clock controller also refers to the chip control syscon.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: syna,sl261x-avio-gbl
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - const: syna,sl261x-cpu-wrp
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - const: syna,sl261x-chip-control
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - const: syna,sl261x-mcu-gbl
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  clock:
+    type: object
+    additionalProperties: true
+
+  pin-controller:
+    type: object
+    additionalProperties: true
+
+  reset:
+    type: object
+    additionalProperties: true
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: syna,sl261x-avio-gbl
+    then:
+      required:
+        - clock
+      properties:
+        clock:
+          properties:
+            compatible:
+              const: syna,sl261x-aio-clk
+        pin-controller: false
+        reset: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: syna,sl261x-cpu-wrp
+    then:
+      required:
+        - clock
+      properties:
+        clock:
+          properties:
+            compatible:
+              const: syna,sl261x-cpu-clk
+        pin-controller: false
+        reset: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: syna,sl261x-chip-control
+    then:
+      required:
+        - clock
+        - pin-controller
+        - reset
+      properties:
+        clock:
+          properties:
+            compatible:
+              const: syna,sl261x-soc-clk
+        pin-controller:
+          properties:
+            compatible:
+              const: syna,sl261x-soc-pinctrl
+        reset:
+          properties:
+            compatible:
+              const: syna,sl261x-soc-reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: syna,sl261x-mcu-gbl
+    then:
+      required:
+        - clock
+        - pin-controller
+        - reset
+      properties:
+        clock:
+          properties:
+            compatible:
+              const: syna,sl261x-system-clk
+        pin-controller:
+          properties:
+            compatible:
+              const: syna,sl261x-system-pinctrl
+        reset:
+          properties:
+            compatible:
+              const: syna,sl261x-system-reset
+
+additionalProperties: false
+
+examples:
+  - |
+    osc: clock-osc {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <25000000>;
+    };
+
+    avio_gbl: avio-gbl@f7490000 {
+        compatible = "syna,sl261x-avio-gbl", "syscon", "simple-mfd";
+        reg = <0xf7490000 0x4000>;
+
+        aioclk: clock {
+            compatible = "syna,sl261x-aio-clk";
+            #clock-cells = <1>;
+            clocks = <&osc>;
+        };
+    };
+
+    chip: chip-control@f7e10000 {
+        compatible = "syna,sl261x-chip-control", "syscon", "simple-mfd";
+        reg = <0xf7e10000 0x10000>;
+
+        clk: clock {
+            compatible = "syna,sl261x-soc-clk";
+            #clock-cells = <1>;
+            clocks = <&osc>;
+        };
+
+        pinctrl: pin-controller {
+            compatible = "syna,sl261x-soc-pinctrl";
+        };
+
+        rst: reset {
+            compatible = "syna,sl261x-soc-reset";
+            #reset-cells = <1>;
+        };
+    };
+
+    cpu_wrp: cpu-wrp@f7e30000 {
+        compatible = "syna,sl261x-cpu-wrp", "syscon", "simple-mfd";
+        reg = <0xf7e30000 0x4000>;
+
+        cpuclk: clock {
+            compatible = "syna,sl261x-cpu-clk";
+            #clock-cells = <1>;
+            clocks = <&osc>;
+            syna,gbl-syscon = <&chip>;
+        };
+    };
+
+    mcu_gbl: mcu-gbl@e5025000 {
+        compatible = "syna,sl261x-mcu-gbl", "syscon", "simple-mfd";
+        reg = <0xe5025000 0x1000>;
+
+        sm_clk: clock {
+            compatible = "syna,sl261x-system-clk";
+            #clock-cells = <1>;
+        };
+
+        sm_pinctrl: pin-controller {
+            compatible = "syna,sl261x-system-pinctrl";
+        };
+
+        sm_rst: reset {
+            compatible = "syna,sl261x-system-reset";
+            #reset-cells = <1>;
+        };
+    };
+...
-- 
2.53.0

