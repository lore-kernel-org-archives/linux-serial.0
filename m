From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH RFC v2 10/11] tty: cadence: Document DT binding
Date: Fri,  7 Mar 2014 11:13:33 -0800
Message-ID: <1394219614-3197-11-git-send-email-soren.brinkmann@xilinx.com>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Add binding documentation for the Cadence UART.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
---
 .../devicetree/bindings/serial/cdns,uart.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
new file mode 100644
index 000000000000..a3eb154c32ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
@@ -0,0 +1,20 @@
+Binding for Cadence UART Controller
+
+Required properties:
+- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
+- reg: Should contain UART controller registers location and length.
+- interrupts: Should contain UART controller interrupts.
+- clocks: Must contain phandles to the UART clocks
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Tuple to identify input clocks, must contain "uart_clk" and "pclk"
+  See ../clocks/clock-bindings.txt for details.
+
+
+Example:
+	uart@e0000000 {
+		compatible = "cdns,uart-r1p8";
+		clocks = <&clkc 23>, <&clkc 40>;
+		clock-names = "uart_clk", "pclk";
+		reg = <0xE0000000 0x1000>;
+		interrupts = <0 27 4>;
+	};
-- 
1.9.0.1.g4196000
