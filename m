From: Vikas Manocha <vikas.manocha@st.com>
Subject: [PATCH 2/3] Arm: dts: stm32: remove extra compatible string from DT & driver
Date: Thu, 28 Sep 2017 15:51:25 -0700
Message-ID: <1506639114-16913-3-git-send-email-vikas.manocha@st.com>
References: <1506639114-16913-1-git-send-email-vikas.manocha@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506639114-16913-1-git-send-email-vikas.manocha@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Vikas Manocha <vikas.manocha@st.com>, alexandre.torgue@st.com, patrice.chotard@st.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
List-Id: linux-serial@vger.kernel.org

This patch remove the extra compatibility string "st,stm32-usart" from
driver & device tree.

Signed-off-by: Vikas Manocha <vikas.manocha@st.com>
Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 12 ++++++------
 arch/arm/boot/dts/stm32f746.dtsi | 12 ++++++------
 arch/arm/boot/dts/stm32h743.dtsi |  4 ++--
 drivers/tty/serial/stm32-usart.c |  3 ---
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index dd7e99b..5d6bfdf 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -315,7 +315,7 @@
 		};
 
 		usart2: serial@40004400 {
-			compatible = "st,stm32-usart", "st,stm32-uart";
+			compatible = "st,stm32-uart";
 			reg = <0x40004400 0x400>;
 			interrupts = <38>;
 			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART2)>;
@@ -323,7 +323,7 @@
 		};
 
 		usart3: serial@40004800 {
-			compatible = "st,stm32-usart", "st,stm32-uart";
+			compatible = "st,stm32-uart";
 			reg = <0x40004800 0x400>;
 			interrupts = <39>;
 			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART3)>;
@@ -387,7 +387,7 @@
 		};
 
 		usart7: serial@40007800 {
-			compatible = "st,stm32-usart", "st,stm32-uart";
+			compatible = "st,stm32-uart";
 			reg = <0x40007800 0x400>;
 			interrupts = <82>;
 			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART7)>;
@@ -395,7 +395,7 @@
 		};
 
 		usart8: serial@40007c00 {
-			compatible = "st,stm32-usart", "st,stm32-uart";
+			compatible = "st,stm32-uart";
 			reg = <0x40007c00 0x400>;
 			interrupts = <83>;
 			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART8)>;
@@ -445,7 +445,7 @@
 		};
 
 		usart1: serial@40011000 {
-			compatible = "st,stm32-usart", "st,stm32-uart";
+			compatible = "st,stm32-uart";
 			reg = <0x40011000 0x400>;
 			interrupts = <37>;
 			clocks = <&rcc 0 STM32F4_APB2_CLOCK(USART1)>;
@@ -456,7 +456,7 @@
 		};
 
 		usart6: serial@40011400 {
-			compatible = "st,stm32-usart", "st,stm32-uart";
+			compatible = "st,stm32-uart";
 			reg = <0x40011400 0x400>;
 			interrupts = <71>;
 			clocks = <&rcc 0 STM32F4_APB2_CLOCK(USART6)>;
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 5633860..5f94178 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -136,7 +136,7 @@
 		};
 
 		usart2: serial@40004400 {
-			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			compatible = "st,stm32f7-uart";
 			reg = <0x40004400 0x400>;
 			interrupts = <38>;
 			clocks = <&rcc 1 CLK_USART2>;
@@ -144,7 +144,7 @@
 		};
 
 		usart3: serial@40004800 {
-			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			compatible = "st,stm32f7-uart";
 			reg = <0x40004800 0x400>;
 			interrupts = <39>;
 			clocks = <&rcc 1 CLK_USART3>;
@@ -177,7 +177,7 @@
 		};
 
 		usart7: serial@40007800 {
-			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			compatible = "st,stm32f7-uart";
 			reg = <0x40007800 0x400>;
 			interrupts = <82>;
 			clocks = <&rcc 1 CLK_UART7>;
@@ -185,7 +185,7 @@
 		};
 
 		usart8: serial@40007c00 {
-			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			compatible = "st,stm32f7-uart";
 			reg = <0x40007c00 0x400>;
 			interrupts = <83>;
 			clocks = <&rcc 1 CLK_UART8>;
@@ -193,7 +193,7 @@
 		};
 
 		usart1: serial@40011000 {
-			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			compatible = "st,stm32f7-uart";
 			reg = <0x40011000 0x400>;
 			interrupts = <37>;
 			clocks = <&rcc 1 CLK_USART1>;
@@ -201,7 +201,7 @@
 		};
 
 		usart6: serial@40011400 {
-			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			compatible = "st,stm32f7-uart";
 			reg = <0x40011400 0x400>;
 			interrupts = <71>;
 			clocks = <&rcc 1 CLK_USART6>;
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 58ec227..26de315 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -67,7 +67,7 @@
 		};
 
 		usart2: serial@40004400 {
-			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			compatible = "st,stm32f7-uart";
 			reg = <0x40004400 0x400>;
 			interrupts = <38>;
 			status = "disabled";
@@ -99,7 +99,7 @@
 		};
 
 		usart1: serial@40011000 {
-			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			compatible = "st,stm32f7-uart";
 			reg = <0x40011000 0x400>;
 			interrupts = <37>;
 			status = "disabled";
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 03a58326..46a1f86 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -736,11 +736,8 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id stm32_match[] = {
-	{ .compatible = "st,stm32-usart", .data = &stm32f4_info},
 	{ .compatible = "st,stm32-uart", .data = &stm32f4_info},
-	{ .compatible = "st,stm32f7-usart", .data = &stm32f7_info},
 	{ .compatible = "st,stm32f7-uart", .data = &stm32f7_info},
-	{ .compatible = "st,stm32h7-usart", .data = &stm32h7_info},
 	{ .compatible = "st,stm32h7-uart", .data = &stm32h7_info},
 	{},
 };
-- 
1.9.1
