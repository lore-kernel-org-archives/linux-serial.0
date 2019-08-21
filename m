From: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 1/2] dt-bindings: serial: lantiq: Convert to YAML schema
Date: Wed, 21 Aug 2019 15:06:51 +0800
Message-ID: <b8e0fa2981176dba29cd8e29f14532501cf962b4.1566370151.git.rahul.tanwar@linux.intel.com>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Convert the existing DT binding document for Lantiq SoC ASC serial controller
from txt format to YAML format.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/serial/lantiq,asc.yaml     | 55 ++++++++++++++++++++++
 .../devicetree/bindings/serial/lantiq_asc.txt      | 31 ------------
 2 files changed, 55 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/lantiq,asc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt

diff --git a/Documentation/devicetree/bindings/serial/lantiq,asc.yaml b/Documentation/devicetree/bindings/serial/lantiq,asc.yaml
new file mode 100644
index 000000000000..72ea2a3d75c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/lantiq,asc.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/lantiq,asc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq SoC ASC serial controller
+
+maintainers:
+  - Rahul Tanwar <rahul.tanwar@intel.com>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+properties:
+  compatible:
+    enum:
+      - lantiq,asc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 3
+
+  clocks:
+    items:
+      - description: phandle to the frequency clock
+      - description: phandle to the gate clock
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
+
+examples:
+  - |
+    asc0: serial@16600000 {
+            compatible = "lantiq,asc";
+            reg = <0x16600000 0x100000>;
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
+            clock-names = "freq", "asc";
+    };
+
+...
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
2.11.0
