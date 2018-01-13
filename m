From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Subject: [PATCH v2 4/7] dt-bindings: i2c: Add device tree bindings for GENI I2C Controller
Date: Fri, 12 Jan 2018 18:05:44 -0700
Message-ID: <1515805547-22816-5-git-send-email-kramasub@codeaurora.org>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
To: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Sagar Dharia <sdharia@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Add device tree binding support for I2C Controller in GENI based
QUP Wrapper.

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
---
 .../devicetree/bindings/i2c/i2c-qcom-geni.txt      | 35 ++++++++++++++++++++++
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 19 ++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt b/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
new file mode 100644
index 0000000..ea84be7
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
@@ -0,0 +1,35 @@
+Qualcomm Technologies Inc. GENI Serial Engine based I2C Controller
+
+Required properties:
+ - compatible: Should be:
+   * "qcom,i2c-geni.
+ - reg: Should contain QUP register address and length.
+ - interrupts: Should contain I2C interrupt.
+ - clock-names: Should contain "se-clk".
+ - clocks: Serial engine core clock needed by the device.
+ - pinctrl-names/pinctrl-0/1: The GPIOs assigned to this core. The names
+   should be "active" and "sleep" for the pin confuguration when core is active
+   or when entering sleep state.
+ - #address-cells: Should be <1> Address cells for i2c device address
+ - #size-cells: Should be <0> as i2c addresses have no size component
+
+Optional property:
+ - clock-frequency : Desired I2C bus clock frequency in Hz.
+   When missing default to 400000Hz.
+
+Child nodes should conform to i2c bus binding.
+
+Example:
+
+i2c0: i2c@a94000 {
+	compatible = "qcom,i2c-geni";
+	reg = <0xa94000 0x4000>;
+	interrupts = <GIC_SPI 358 0>;
+	clock-names = "se-clk";
+	clocks = <&clock_gcc GCC_QUPV3_WRAP0_S5_CLK>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&qup_1_i2c_5_active>;
+	pinctrl-1 = <&qup_1_i2c_5_sleep>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index 66f8a16..2ffbb3e 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -24,6 +24,9 @@ A GENI based QUP wrapper controller node can contain 0 or more child nodes
 representing serial devices.  These serial devices can be a QCOM UART, I2C
 controller, spi controller, or some combination of aforementioned devices.
 
+See the following documentation for child node definitions:
+Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
+
 Example:
 	qup0: qcom,geniqup0@8c0000 {
 		compatible = "qcom,geni-se-qup";
@@ -31,4 +34,20 @@ Example:
 		clock-names = "m-ahb", "s-ahb";
 		clocks = <&clock_gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
 			<&clock_gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		i2c0: i2c@a94000 {
+			compatible = "qcom,i2c-geni";
+			reg = <0xa94000 0x4000>;
+			interrupts = <GIC_SPI 358 0>;
+			clock-names = "se-clk";
+			clocks = <&clock_gcc GCC_QUPV3_WRAP0_S5_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&qup_1_i2c_5_active>;
+			pinctrl-1 = <&qup_1_i2c_5_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	}
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
