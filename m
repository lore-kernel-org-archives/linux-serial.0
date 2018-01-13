From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Subject: [PATCH v2 6/7] dt-bindings: serial: Add bindings for GENI based UART Controller
Date: Fri, 12 Jan 2018 18:05:46 -0700
Message-ID: <1515805547-22816-7-git-send-email-kramasub@codeaurora.org>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Add device tree binding support for GENI based UART Controller in the
QUP Wrapper.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
---
 .../devicetree/bindings/serial/qcom,geni-uart.txt  | 29 ++++++++++++++++++++++
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 13 ++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,geni-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt b/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
new file mode 100644
index 0000000..e7b9e24
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
@@ -0,0 +1,29 @@
+Qualcomm Technologies Inc. GENI Serial Engine based UART Controller
+
+The Generic Interface (GENI) Serial Engine based UART controller supports
+console use-cases and is supported only by GENI based Qualcomm Universal
+Peripheral (QUP) cores.
+
+Required properties:
+- compatible: should contain "qcom,geni-debug-uart".
+- reg: Should contain UART register location and length.
+- reg-names: Should contain "se-phys".
+- interrupts: Should contain UART core interrupts.
+- clock-names: Should contain "se-clk".
+- clocks: clocks needed for UART, includes the core clock.
+- pinctrl-names/pinctrl-0/1: The GPIOs assigned to this core. The names
+  Should be "active" and "sleep" for the pin confuguration when core is active
+  or when entering sleep state.
+
+Example:
+uart0: qcom,serial@a88000 {
+	compatible = "qcom,geni-debug-uart";
+	reg = <0xa88000 0x7000>;
+	reg-names = "se-phys";
+	interrupts = <0 355 0>;
+	clock-names = "se-clk";
+	clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&qup_1_uart_3_active>;
+	pinctrl-1 = <&qup_1_uart_3_sleep>;
+};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index 2ffbb3e..c307788 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -26,6 +26,7 @@ controller, spi controller, or some combination of aforementioned devices.
 
 See the following documentation for child node definitions:
 Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
+Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
 
 Example:
 	qup0: qcom,geniqup0@8c0000 {
@@ -50,4 +51,16 @@ Example:
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		uart0: qcom,serial@a88000 {
+			compatible = "qcom,geni-debug-uart";
+			reg = <0xa88000 0x7000>;
+			reg-names = "se-phys";
+			interrupts = <0 355 0>;
+			clock-names = "se-clk";
+			clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&qup_1_uart_3_active>;
+			pinctrl-1 = <&qup_1_uart_3_sleep>;
+		};
 	}
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

