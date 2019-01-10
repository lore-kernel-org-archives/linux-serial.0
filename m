From: Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: serial: Convert arm,pl011 to json-schema
Date: Thu, 10 Jan 2019 16:19:42 -0600
Message-ID: <20190110221942.5374-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Convert the arm,pl011 binding to DT schema using json-schema.

The zte,zx296702-uart binding appears to be broken as the dts files are
missing 'arm,primecell'. That's included in the schema here to throw a
warning.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/serial/pl011.txt      |  51 -------
 .../devicetree/bindings/serial/pl011.yaml     | 126 ++++++++++++++++++
 2 files changed, 126 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/pl011.txt
 create mode 100644 Documentation/devicetree/bindings/serial/pl011.yaml

diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
deleted file mode 100644
index 77863aefe9ef..000000000000
--- a/Documentation/devicetree/bindings/serial/pl011.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-* ARM AMBA Primecell PL011 serial UART
-
-Required properties:
-- compatible: must be "arm,primecell", "arm,pl011", "zte,zx296702-uart"
-- reg: exactly one register range with length 0x1000
-- interrupts: exactly one interrupt specifier
-
-Optional properties:
-- pinctrl:
-	   When present, must have one state named "default",
-	   and may contain a second name named "sleep". The former
-	   state sets up pins for ordinary operation whereas
-	   the latter state will put the associated pins to sleep
-	   when the UART is unused
-- clocks:
-	   When present, the first clock listed must correspond to
-	   the clock named UARTCLK on the IP block, i.e. the clock
-	   to the external serial line, whereas the second clock
-	   must correspond to the PCLK clocking the internal logic
-	   of the block. Just listing one clock (the first one) is
-	   deprecated.
-- clock-names:
-	   When present, the first clock listed must be named
-	   "uartclk" and the second clock listed must be named
-	   "apb_pclk"
-- dmas:	
-	   When present, may have one or two dma channels.
-	   The first one must be named "rx", the second one
-	   must be named "tx".
-- auto-poll:
-	   Enables polling when using RX DMA.
-- poll-rate-ms:
-	   Rate at which poll occurs when auto-poll is set,
-	   default 100ms.
-- poll-timeout-ms:
-	   Poll timeout when auto-poll is set, default
-	   3000ms.
-
-See also bindings/arm/primecell.txt
-
-Example:
-
-uart@80120000 {
-	compatible = "arm,pl011", "arm,primecell";
-	reg = <0x80120000 0x1000>;
-	interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
-	dmas = <&dma 13 0 0x2>, <&dma 13 0 0x0>;
-	dma-names = "rx", "tx";
-	clocks = <&foo_clk>, <&bar_clk>;
-	clock-names = "uartclk", "apb_pclk";
-};
diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
new file mode 100644
index 000000000000..1a64d59152aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/pl011.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM AMBA Primecell PL011 serial UART
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - arm,pl011
+          - zte,zx296702-uart
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: arm,pl011
+          - const: arm,primecell
+      - items:
+          - const: zte,zx296702-uart
+          - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    description:
+      When present, must have one state named "default",
+      and may contain a second name named "sleep". The former
+      state sets up pins for ordinary operation whereas
+      the latter state will put the associated pins to sleep
+      when the UART is unused
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+
+  clocks:
+    description:
+      When present, the first clock listed must correspond to
+      the clock named UARTCLK on the IP block, i.e. the clock
+      to the external serial line, whereas the second clock
+      must correspond to the PCLK clocking the internal logic
+      of the block. Just listing one clock (the first one) is
+      deprecated.
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: uartclk
+      - const: apb_pclk
+
+  dmas:
+    minItems: 1
+    maxItems: 2
+
+  dma-names:
+    minItems: 1
+    items:
+      - const: rx
+      - const: tx
+
+  auto-poll:
+    description:
+      Enables polling when using RX DMA.
+    type: boolean
+
+  poll-rate-ms:
+    description:
+      Rate at which poll occurs when auto-poll is set.
+      default 100ms.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 100
+
+  poll-timeout-ms:
+    description:
+      Poll timeout when auto-poll is set, default
+      3000ms.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 3000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+dependencies:
+  poll-rate-ms: [ auto-poll ]
+  poll-timeout-ms: [ auto-poll ]
+
+additionalProperties: false
+
+examples:
+  - |
+    serial@80120000 {
+      compatible = "arm,pl011", "arm,primecell";
+      reg = <0x80120000 0x1000>;
+      interrupts = <0 11 4>;
+      dmas = <&dma 13 0 0x2>, <&dma 13 0 0x0>;
+      dma-names = "rx", "tx";
+      clocks = <&foo_clk>, <&bar_clk>;
+      clock-names = "uartclk", "apb_pclk";
+    };
+
+...
-- 
2.19.1
