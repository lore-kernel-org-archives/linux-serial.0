From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 1/3] Documentation: devicetree: Update samsung UART bindings
Date: Thu, 26 Jun 2014 13:24:33 +0200
Message-ID: <1403781875-5425-2-git-send-email-t.figa@samsung.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Drake <drake@endlessm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-serial@vger.kernel.org

The primary purpose of this patch is to add information about (now
required) aliases of UART ports. However the documentation currently is
heavily outdated and so this patch also takes care of this.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 .../devicetree/bindings/serial/samsung_uart.txt    | 52 +++++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.txt b/Documentation/devicetree/bindings/serial/samsung_uart.txt
index 2c8a17c..85e8ee2 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.txt
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.txt
@@ -1,14 +1,54 @@
 * Samsung's UART Controller
 
-The Samsung's UART controller is used for interfacing SoC with serial communicaion
-devices.
+The Samsung's UART controller is used for interfacing SoC with serial
+communicaion devices.
 
 Required properties:
-- compatible: should be
-  - "samsung,exynos4210-uart", for UART's compatible with Exynos4210 uart ports.
+- compatible: should be one of following:
+  - "samsung,exynos4210-uart" -  Exynos4210 SoC,
+  - "samsung,s3c2410-uart" - compatible with ports present on S3C2410 SoC,
+  - "samsung,s3c2412-uart" - compatible with ports present on S3C2412 SoC,
+  - "samsung,s3c2440-uart" - compatible with ports present on S3C2440 SoC,
+  - "samsung,s3c6400-uart" - compatible with ports present on S3C6400 SoC,
+  - "samsung,s5pv210-uart" - compatible with ports present on S5PV210 SoC.
 
 - reg: base physical address of the controller and length of memory mapped
   region.
 
-- interrupts: interrupt number to the cpu. The interrupt specifier format depends
-  on the interrupt controller parent.
+- interrupts: a single interrupt signal to SoC interrupt controller,
+  according to interrupt bindings documentation [1].
+
+- clock-names: input names of clocks used by the controller:
+  - "uart" - controller bus clock,
+  - "clk_uart_baudN" - Nth baud base clock input (N = 0, 1, ...),
+    according to SoC User's Manual (only N = 0 is allowedfor SoCs without
+    internal baud clock mux).
+- clocks: phandles and specifiers for all clocks specified in "clock-names"
+  property, in the same order, according to clock bindings documentation [2].
+
+[1] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Note: Each Samsung UART should have an alias correctly numbered in the
+"aliases" node, according to serialN format, where N is the port number
+(non-negative decimal integer) as specified by User's Manual of respective
+SoC.
+
+Example:
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+Example:
+	uart1: serial@7f005400 {
+		compatible = "samsung,s3c6400-uart";
+		reg = <0x7f005400 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <6>;
+		clock-names = "uart", "clk_uart_baud2",
+				"clk_uart_baud3";
+		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
+				<&clocks SCLK_UART>;
+	};
-- 
1.9.3
