From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 4/9] Documentation: DT: Add entries for bcm63xx UART
Date: Mon, 20 Oct 2014 13:54:03 -0700
Message-ID: <1413838448-29464-5-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47298 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbaJTUzB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Oct 2014 16:55:01 -0400
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

This squashes a checkpatch warning on my new bcm3384 dts submission.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
new file mode 100644
index 0000000..b01c76a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
@@ -0,0 +1,34 @@
+* BCM63xx UART
+
+Required properties:
+
+- compatible: "brcm,bcm6345-uart"
+
+- reg: The base address of the UART register bank.
+
+- interrupts: A single interrupt specifier.
+
+- clocks: Clock driving the hardware; used to figure out the baud rate
+  divisor.
+
+- clock-names: The appropriate output name in the referenced clock node.
+
+Example:
+
+	uart0: serial@14e00520 {
+		compatible = "brcm,bcm6345-uart";
+		reg = <0x14e00520 0x18>;
+		interrupt-parent = <&periph_intc>;
+		interrupts = <2>;
+		clocks = <&periph_clk>;
+		clock-names = "periph";
+	};
+
+	clocks {
+		periph_clk: periph_clk@0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <54000000>;
+			clock-output-names = "periph";
+		};
+	};
-- 
2.1.1

