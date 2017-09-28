From: Vikas Manocha <vikas.manocha@st.com>
Subject: [PATCH 1/3] Arm: dts: stm32: remove extra compatible string for uart
Date: Thu, 28 Sep 2017 15:51:24 -0700
Message-ID: <1506639114-16913-2-git-send-email-vikas.manocha@st.com>
References: <1506639114-16913-1-git-send-email-vikas.manocha@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506639114-16913-1-git-send-email-vikas.manocha@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Vikas Manocha <vikas.manocha@st.com>, alexandre.torgue@st.com, patrice.chotard@st.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-serial@vger.kernel.org

This patch removes the extra compatibility string "st,stm32-usart" to
avoid confusion, save some time & space.

Signed-off-by: Vikas Manocha <vikas.manocha@st.com>
Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
---
 Documentation/devicetree/bindings/dma/stm32-dma.txt         |  2 +-
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
index 4408af6..6f44df9 100644
--- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
@@ -71,7 +71,7 @@ channel: a phandle to the DMA controller plus the following four integer cells:
 Example:
 
 	usart1: serial@40011000 {
-		compatible = "st,stm32-usart", "st,stm32-uart";
+		compatible = "st,stm32-uart";
 		reg = <0x40011000 0x400>;
 		interrupts = <37>;
 		clocks = <&clk_pclk2>;
diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 3657f9f..d150b04 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -2,14 +2,10 @@
 
 Required properties:
 - compatible: can be either:
-  - "st,stm32-usart",
   - "st,stm32-uart",
-  - "st,stm32f7-usart",
   - "st,stm32f7-uart",
-  - "st,stm32h7-usart"
   - "st,stm32h7-uart".
-  depending on whether the device supports synchronous mode
-  and is compatible with stm32(f4), stm32f7 or stm32h7.
+  depending is compatible with stm32(f4), stm32f7 or stm32h7.
 - reg: The address and length of the peripheral registers space
 - interrupts:
   - The interrupt line for the USART instance,
@@ -33,7 +29,7 @@ usart4: serial@40004c00 {
 };
 
 usart2: serial@40004400 {
-	compatible = "st,stm32-usart", "st,stm32-uart";
+	compatible = "st,stm32-uart";
 	reg = <0x40004400 0x400>;
 	interrupts = <38>;
 	clocks = <&clk_pclk1>;
@@ -43,7 +39,7 @@ usart2: serial@40004400 {
 };
 
 usart1: serial@40011000 {
-	compatible = "st,stm32-usart", "st,stm32-uart";
+	compatible = "st,stm32-uart";
 	reg = <0x40011000 0x400>;
 	interrupts = <37>;
 	clocks = <&rcc 0 164>;
-- 
1.9.1
