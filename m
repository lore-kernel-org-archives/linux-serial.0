From: Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH v7 3/6] dt-bindings: pinctrl: mt8183: add binding document
Date: Fri, 15 Feb 2019 14:02:35 +0800
Message-ID: <1550210558-30516-4-git-send-email-erin.lo@mediatek.com>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, erin.lo@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Zhiyong Tao <zhiyong.tao@mediatek.com>

The commit adds mt8183 compatible node in binding document.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
new file mode 100644
index 0000000..364e673
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
@@ -0,0 +1,115 @@
+* Mediatek MT8183 Pin Controller
+
+The Mediatek's Pin controller is used to control SoC pins.
+
+Required properties:
+- compatible: value should be one of the following.
+	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
+  binding is used, the amount of cells must be specified as 2. See the below
+  mentioned gpio binding representation for description of particular cells.
+- gpio-ranges : gpio valid number range.
+- reg: physicall address base for gpio base registers. There are nine
+  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
+  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
+  0x11F30000.
+
+	Eg: <&pio 6 0>
+	<[phandle of the gpio controller node]
+	[line number within the gpio controller]
+	[flags]>
+
+	Values for gpio specifier:
+	- Line number: is a value between 0 to 202.
+	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
+            Only the following flags are supported:
+            0 - GPIO_ACTIVE_HIGH
+            1 - GPIO_ACTIVE_LOW
+
+Optional properties:
+- reg-names: gpio base register names. There are nine gpio base register
+  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
+  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
+- interrupt-controller: Marks the device node as an interrupt controller
+- #interrupt-cells: Should be two.
+- interrupts : The interrupt outputs from the controller.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices.
+
+Subnode format
+A pinctrl node should contain at least one subnodes representing the
+pinctrl groups available on the machine. Each subnode will list the
+pins it needs, and how they should be configured, with regard to muxer
+configuration, pullups, drive strength, input enable/disable and input schmitt.
+
+    node {
+	pinmux = <PIN_NUMBER_PINMUX>;
+	GENERIC_PINCONFIG;
+    };
+
+Required properties:
+- pinmux: integer array, represents gpio pin number and mux setting.
+    Supported pin number and mux varies for different SoCs, and are defined
+    as macros in boot/dts/<soc>-pinfunc.h directly.
+
+Optional properties:
+- GENERIC_PINCONFIG: is the generic pinconfig options to use, bias-disable,
+    bias-pull-down, bias-pull-up, input-enable, input-disable, output-low, output-high,
+    input-schmitt-enable, input-schmitt-disable and drive-strength are valid.
+
+    Some special pins have extra pull up strength, there are R0 and R1 pull-up
+    resistors available, but for user, it's only need to set R1R0 as 00, 01, 10 or 11.
+    So when config mediatek,pull-up-adv or mediatek,pull-down-adv,
+    it support arguments for those special pins.
+
+    When config drive-strength, it can support some arguments, such as
+    MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h.
+
+Examples:
+
+#include "mt8183-pinfunc.h"
+
+...
+{
+	pio: pinctrl@10005000 {
+		compatible = "mediatek,mt8183-pinctrl";
+		reg = <0 0x10005000 0 0x1000>,
+		      <0 0x11F20000 0 0x1000>,
+		      <0 0x11E80000 0 0x1000>,
+		      <0 0x11E70000 0 0x1000>,
+		      <0 0x11E90000 0 0x1000>,
+		      <0 0x11D30000 0 0x1000>,
+		      <0 0x11D20000 0 0x1000>,
+		      <0 0x11C50000 0 0x1000>,
+		      <0 0x11F30000 0 0x1000>;
+		reg-names = "iocfg0", "iocfg1", "iocfg2",
+			    "iocfg3", "iocfg4", "iocfg5",
+			    "iocfg6", "iocfg7", "iocfg8";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pio 0 0 192>;
+		interrupt-controller;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <2>;
+
+		i2c0_pins_a: i2c0 {
+			pins1 {
+				pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
+					 <PINMUX_GPIO49__FUNC_SDA5>;
+				mediatek,pull-up-adv = <11>;
+			};
+		};
+
+		i2c1_pins_a: i2c1 {
+			pins {
+				pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
+					 <PINMUX_GPIO51__FUNC_SDA3>;
+				mediatek,pull-down-adv = <10>;
+			};
+		};
+		...
+	};
+};
-- 
1.9.1
