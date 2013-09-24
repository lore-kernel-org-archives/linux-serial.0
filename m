From: takasi-y@ops.dti.ne.jp
Subject: [PATCH 4/6] ARM: shmobile: emev2: Define SMU clock DT bindings
Date: Tue, 24 Sep 2013 13:13:31 +0900
Message-ID: <20130924131331.0e9a5f830f531655b2ea0ebe@ops.dti.ne.jp>
References: <52410F86.4040301@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52410F86.4040301@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: SH-Linux <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>, Paul Mundt <lethal@linux-sh.org>, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Device tree clock binding document for EMMA Mobile EV2 SMU.
Following nodes are defined to describe clock tree.
- renesas,emev2-smu
- renesas,emev2-smu-clkdiv
- renesas,emev2-smu-gclk

These bindings are designed manually based on
 19UH0037EJ1000_SMU : System Management Unit User's Manual

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
---
 .../devicetree/bindings/clock/emev2-clock.txt      | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/emev2-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/emev2-clock.txt b/Documentation/devicetree/bindings/clock/emev2-clock.txt
new file mode 100644
index 0000000..f8649eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/emev2-clock.txt
@@ -0,0 +1,99 @@
+Device tree Clock bindings for Renesas EMMA Mobile EV2
+
+This binding uses the common clock binding.
+
+* SMU
+System Management Unit described in user's manual R19UH0037EJ1000_SMU.
+This is not a clock provider, but clocks under SMU depend on it.
+
+Required properties:
+- compatible: Should be "renesas,emev2-smu"
+- reg: Address and Size of SMU registers
+
+* SMU_CLKDIV
+Function block with an input mux and a divider, which corresponds to
+"Serial clock generator" in fig."Clock System Overview" of the manual,
+and "xxx frequency division setting register" (XXXCLKDIV) registers.
+This makes internal (neither input nor output) clock that is provided
+to input of xxxGCLK block.
+
+Required properties:
+- compatible: Should be "renesas,emev2-smu-clkdiv"
+- reg: Byte offset from SMU base and Bit position in the register
+- clocks: Parent clocks. Input clocks as described in clock-bindings.txt
+- #clock-cells: Should be <0>
+
+* SMU_GCLK
+Clock gating node shown as "Clock stop processing block" in the
+fig."Clock System Overview" of the manual.
+Registers are "xxx clock gate control register" (XXXGCLKCTRL).
+
+Required properties:
+- compatible: Should be "renesas,emev2-smu-gclk"
+- reg: Byte offset from SMU base and Bit position in the register
+- clocks: Input clock as described in clock-bindings.txt
+- #clock-cells: Should be <0>
+
+Example of provider:
+
+usia_u0_sclkdiv: usia_u0_sclkdiv {
+	compatible = "renesas,emev2-smu-clkdiv";
+	reg = <0x610 0>;
+	clocks = <&pll3_fo>, <&pll4_fo>, <&pll1_fo>, <&osc1_fo>;
+	#clock-cells = <0>;
+};
+
+usia_u0_sclk: usia_u0_sclk {
+	compatible = "renesas,emev2-smu-gclk";
+	reg = <0x4a0 1>;
+	clocks = <&usia_u0_sclkdiv>;
+	#clock-cells = <0>;
+};
+
+Example of consumer:
+
+uart@e1020000 {
+	compatible = "renesas,em-uart";
+	reg = <0xe1020000 0x38>;
+	interrupts = <0 8 0>;
+	clocks = <&usia_u0_sclk>;
+	clock-names = "sclk";
+};
+
+Example of clock-tree description:
+
+ This describes a clock path in the clock tree
+  c32ki -> pll3_fo -> usia_u0_sclkdiv -> usia_u0_sclk
+
+smu {
+	compatible = "renesas,emev2-smu";
+	reg = <0xe0110000 0x10000>;
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	c32ki: c32ki {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+	pll3_fo: pll3_fo {
+		compatible = "fixed-factor-clock";
+		clocks = <&c32ki>;
+		clock-div = <1>;
+		clock-mult = <7000>;
+		#clock-cells = <0>;
+	};
+	usia_u0_sclkdiv: usia_u0_sclkdiv {
+		compatible = "renesas,emev2-smu-clkdiv";
+		reg = <0x610 0>;
+		clocks = <&pll3_fo>;
+		#clock-cells = <0>;
+	};
+	usia_u0_sclk: usia_u0_sclk {
+		compatible = "renesas,emev2-smu-gclk";
+		reg = <0x4a0 1>;
+		clocks = <&usia_u0_sclkdiv>;
+		#clock-cells = <0>;
+	};
+};
+
-- 
1.8.1.5
