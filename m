From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH tty-next v2 4/4] Documentation: devicetree: add bindings documentation for bcm63xx-uart
Date: Thu, 20 Feb 2014 10:15:54 -0800
Message-ID: <1392920154-3642-5-git-send-email-f.fainelli@gmail.com>
References: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:20331 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719AbaBTSSI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Feb 2014 13:18:08 -0500
In-Reply-To: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, gregory.0xf0@gmail.com, Florian Fainelli <f.fainelli@gmail.com>

Add the Device Tree binding documentation for the non-standard BCM63xx
UART hardware block found in the BCM63xx DSL SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
- update the compatible property to be "brcm,bcm6345-uart" as suggested
- reword the clocks and clock-names properties based on feedback from Mark

 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
new file mode 100644
index 0000000..f288232
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
@@ -0,0 +1,27 @@
+Broadcom BCM63xx UART: Non standard UART used in the Broadcom BCM63xx DSL SoCs
+
+Required properties:
+- compatible: must be "brcm,bcm6345-uart"
+- reg: offset and length of the register set for the device
+- interrupts: device interrupt
+- clocks: a list of phandles and clock-specifiers, one for each entry
+  in clock-names
+- clock-names: should contain "periph" for the functional clock
+
+Example:
+
+serial0: uart@600 {
+	compatible = "brcm,bcm6345-uart";
+	reg = <0x600 0x1b>;
+	interrupts = <GIC_SPI 32 0>;
+	clocks = <&periph_clk>;
+	clock-names = "periph";
+};
+
+Note: each UART port must have an alias correctly numbered in the "aliases"
+node, e.g:
+
+aliases {
+	uart0 = &serial0;
+	uart1 = &serial1;
+};
-- 
1.8.3.2

