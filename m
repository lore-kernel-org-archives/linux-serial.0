From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH/RFC 6/8] serial: pxa: Update DT binding documentation
Date: Wed, 12 Nov 2014 00:46:31 -0800
Message-ID: <1415781993-7755-7-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:56697 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbaKLIrP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 03:47:15 -0500
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

Add a couple of missing required properties; add the new optional
properties and an example.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/serial/mrvl-serial.txt     | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/mrvl-serial.txt b/Documentation/devicetree/bindings/serial/mrvl-serial.txt
index d744340..5bab455 100644
--- a/Documentation/devicetree/bindings/serial/mrvl-serial.txt
+++ b/Documentation/devicetree/bindings/serial/mrvl-serial.txt
@@ -1,4 +1,36 @@
 PXA UART controller
 
 Required properties:
-- compatible : should be "mrvl,mmp-uart" or "mrvl,pxa-uart".
+- compatible : should be "mrvl,mmp-uart", "mrvl,pxa-uart", or
+  "brcm,bcm7401-uart".
+- interrupts : a single interrupt specifier.
+- clocks : phandle to a clock; used to compute the baud divisor.
+
+Optional properties:
+- fifo-size : defaults to 64 bytes.
+- big-endian : always use BE register accesses.
+- native-endian : use BE register accesses if the kernel was built for BE,
+  otherwise use LE register accesses.
+
+Example:
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		uart_clk: uart_clk@0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	uart0: serial@10406900 {
+		compatible = "brcm,bcm7401-upg-uart";
+		reg = <0x10406900 0x20>;
+		native-endian;
+		fifo-size = <32>;
+		interrupt-parent = <&periph_intc>;
+		interrupts = <64>;
+		clocks = <&uart_clk>;
+	};
-- 
2.1.1

