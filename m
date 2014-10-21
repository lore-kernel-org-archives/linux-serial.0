From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 05/10] Documentation: DT: Add entries for bcm63xx UART
Date: Tue, 21 Oct 2014 15:23:01 -0700
Message-ID: <1413930186-23168-6-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:59252 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933804AbaJUWXb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 18:23:31 -0400
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

This squashes a checkpatch warning on my new bcm3384 dts submission.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
new file mode 100644
index 0000000..5c52e5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
@@ -0,0 +1,30 @@
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
+Example:
+
+	uart0: serial@14e00520 {
+		compatible = "brcm,bcm6345-uart";
+		reg = <0x14e00520 0x18>;
+		interrupt-parent = <&periph_intc>;
+		interrupts = <2>;
+		clocks = <&periph_clk>;
+	};
+
+	clocks {
+		periph_clk: periph_clk@0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <54000000>;
+		};
+	};
-- 
2.1.1

