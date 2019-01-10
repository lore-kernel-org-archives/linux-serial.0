From: Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: serial: Convert snps,dw-apb-uart to json-schema
Date: Thu, 10 Jan 2019 16:20:16 -0600
Message-ID: <20190110222017.6390-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Convert the snps,dw-apb-uart binding to DT schema using json-schema.

The Rockchip and Broadcom compatible strings were not documented,
so add them here.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/serial/snps-dw-apb-uart.txt      |  76 ----------
 .../bindings/serial/snps-dw-apb-uart.yaml     | 140 ++++++++++++++++++
 2 files changed, 140 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
deleted file mode 100644
index 12bbe9f22560..000000000000
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
+++ /dev/null
@@ -1,76 +0,0 @@
-* Synopsys DesignWare ABP UART
-
-Required properties:
-- compatible : "snps,dw-apb-uart"
-- reg : offset and length of the register set for the device.
-- interrupts : should contain uart interrupt.
-
-Clock handling:
-The clock rate of the input clock needs to be supplied by one of
-- clock-frequency : the input clock frequency for the UART.
-- clocks : phandle to the input clock
-
-The supplying peripheral clock can also be handled, needing a second property
-- clock-names: tuple listing input clock names.
-	Required elements: "baudclk", "apb_pclk"
-
-Optional properties:
-- snps,uart-16550-compatible : reflects the value of UART_16550_COMPATIBLE
-  configuration parameter. Define this if your UART does not implement the busy
-  functionality.
-- resets : phandle to the parent reset controller.
-- reg-shift : quantity to shift the register offsets by.  If this property is
-  not present then the register offsets are not shifted.
-- reg-io-width : the size (in bytes) of the IO accesses that should be
-  performed on the device.  If this property is not present then single byte
-  accesses are used.
-- dcd-override : Override the DCD modem status signal. This signal will always
-  be reported as active instead of being obtained from the modem status
-  register. Define this if your serial port does not use this pin.
-- dsr-override : Override the DTS modem status signal. This signal will always
-  be reported as active instead of being obtained from the modem status
-  register. Define this if your serial port does not use this pin.
-- cts-override : Override the CTS modem status signal. This signal will always
-  be reported as active instead of being obtained from the modem status
-  register. Define this if your serial port does not use this pin.
-- ri-override : Override the RI modem status signal. This signal will always be
-  reported as inactive instead of being obtained from the modem status register.
-  Define this if your serial port does not use this pin.
-
-Example:
-
-	uart@80230000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x80230000 0x100>;
-		clock-frequency = <3686400>;
-		interrupts = <10>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		dcd-override;
-		dsr-override;
-		cts-override;
-		ri-override;
-	};
-
-Example with one clock:
-
-	uart@80230000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x80230000 0x100>;
-		clocks = <&baudclk>;
-		interrupts = <10>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-	};
-
-Example with two clocks:
-
-	uart@80230000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x80230000 0x100>;
-		clocks = <&baudclk>, <&apb_pclk>;
-		clock-names = "baudclk", "apb_pclk";
-		interrupts = <10>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
new file mode 100644
index 000000000000..b42002542690
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/snps-dw-apb-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare ABP UART
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a06g032-uart
+              - renesas,r9a06g033-uart
+          - const: renesas,rzn1-uart
+      - items:
+          - enum:
+              - rockchip,px30-uart
+              - rockchip,rk3036-uart
+              - rockchip,rk3066-uart
+              - rockchip,rk3188-uart
+              - rockchip,rk3288-uart
+              - rockchip,rk3328-uart
+              - rockchip,rk3368-uart
+              - rockchip,rk3399-uart
+              - rockchip,rv1108-uart
+          - const: snps,dw-apb-uart
+      - items:
+          - enum:
+              - brcm,bcm11351-dw-apb-uart
+              - brcm,bcm21664-dw-apb-uart
+          - const: snps,dw-apb-uart
+      - const: snps,dw-apb-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency: true
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: baudclk
+      - const: apb_pclk
+
+  snps,uart-16550-compatible:
+    description: reflects the value of UART_16550_COMPATIBLE configuration
+      parameter. Define this if your UART does not implement the busy functionality.
+    type: boolean
+
+  resets:
+    maxItems: 1
+
+  reg-shift: true
+
+  reg-io-width: true
+
+  dcd-override:
+    description: Override the DCD modem status signal. This signal will
+      always be reported as active instead of being obtained from the modem
+      status register. Define this if your serial port does not use this
+      pin.
+    type: boolean
+
+  dsr-override:
+    description: Override the DTS modem status signal. This signal will
+      always be reported as active instead of being obtained from the modem
+      status register. Define this if your serial port does not use this
+      pin.
+    type: boolean
+
+  cts-override:
+    description: Override the CTS modem status signal. This signal will
+      always be reported as active instead of being obtained from the modem
+      status register. Define this if your serial port does not use this
+      pin.
+    type: boolean
+
+  ri-override:
+    description: Override the RI modem status signal. This signal will always
+      be reported as inactive instead of being obtained from the modem status
+      register. Define this if your serial port does not use this pin.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    serial@80230000 {
+      compatible = "snps,dw-apb-uart";
+      reg = <0x80230000 0x100>;
+      clock-frequency = <3686400>;
+      interrupts = <10>;
+      reg-shift = <2>;
+      reg-io-width = <4>;
+      dcd-override;
+      dsr-override;
+      cts-override;
+      ri-override;
+    };
+
+  - |
+    // Example with one clock:
+    serial@80230000 {
+      compatible = "snps,dw-apb-uart";
+      reg = <0x80230000 0x100>;
+      clocks = <&baudclk>;
+      interrupts = <10>;
+      reg-shift = <2>;
+      reg-io-width = <4>;
+    };
+
+  - |
+    // Example with two clocks:
+    serial@80230000 {
+      compatible = "snps,dw-apb-uart";
+      reg = <0x80230000 0x100>;
+      clocks = <&baudclk>, <&apb_pclk>;
+      clock-names = "baudclk", "apb_pclk";
+      interrupts = <10>;
+      reg-shift = <2>;
+      reg-io-width = <4>;
+    };
+...
-- 
2.19.1
