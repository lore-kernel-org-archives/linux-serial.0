From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH v3 10/10] ARM: dts: stm32: add wakeup capability on each
 usart/uart on stm32mp157c
Date: Thu, 13 Jun 2019 15:50:00 +0200
Message-ID: <1560433800-12255-11-git-send-email-erwan.leray@st.com>
References: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@st.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, linux-serial@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

- Mark all usart/uart devices as wakeup source.
- Identify all dedicated interrupts with a specific interrupt name (either
 "event" or "wakeup").
- add interrupts-extended wakeup interrupt

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 2afeee6..de5b1bf 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -395,32 +395,44 @@
 		usart2: serial@4000e000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000e000 0x400>;
-			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 27 1>;
 			clocks = <&rcc USART2_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
 		usart3: serial@4000f000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000f000 0x400>;
-			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 28 1>;
 			clocks = <&rcc USART3_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
 		uart4: serial@40010000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40010000 0x400>;
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 30 1>;
 			clocks = <&rcc UART4_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
 		uart5: serial@40011000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40011000 0x400>;
-			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 31 1>;
 			clocks = <&rcc UART5_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -512,16 +524,22 @@
 		uart7: serial@40018000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40018000 0x400>;
-			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 32 1>;
 			clocks = <&rcc UART7_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
 		uart8: serial@40019000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40019000 0x400>;
-			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 33 1>;
 			clocks = <&rcc UART8_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -588,8 +606,11 @@
 		usart6: serial@44003000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x44003000 0x400>;
-			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 29 1>;
 			clocks = <&rcc USART6_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -1201,8 +1222,11 @@
 		usart1: serial@5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 26 1>;
 			clocks = <&rcc USART1_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
-- 
1.9.1
