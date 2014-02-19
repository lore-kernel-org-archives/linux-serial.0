From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4/4] Documentation: devicetree: add bindings documentation for bcm63xx-uart
Date: Wed, 19 Feb 2014 15:22:47 -0800
Message-ID: <1392852167-26243-5-git-send-email-f.fainelli@gmail.com>
References: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:65141 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaBSXXY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Feb 2014 18:23:24 -0500
In-Reply-To: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, gregkh@linuxfoundation.org, Florian Fainelli <f.fainelli@gmail.com>

Add the Device Tree binding documentation for the non-standard BCM63xx
UART hardware block found in the BCM63xx DSL SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
new file mode 100644
index 0000000..829441d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
@@ -0,0 +1,24 @@
+Broadcom BCM63xx UART: Non standard UART used in the Broadcom BCM63xx DSL SoCs
+
+Required properties:
+- compatible: must be "brcm,bcm63xx-uart"
+- reg: offset and length of the register set for the device
+- interrupts: device interrupt
+- clocks: a phandle to the functional clock node
+- clock-names: must be "periph"
+
+Note: each UART port must have an alias correctly numbered in the "aliases"
+node, e.g:
+
+serial0: uart@600 {
+	compatible = "brcm,bcm63xx-uart";
+	reg = <0x600 0x1b>;
+	interrupts = <GIC_SPI 32 0>;
+	clocks = <&periph_clk>;
+	clock-names = "periph";
+};
+
+aliases {
+	uart0 = &serial0;
+	uart1 = &serial1;
+};
-- 
1.8.3.2

