From: "sudheer.v" <open.sudheer@gmail.com>
Subject: [[PATCH] 1/9] DT-changes-for-DMA-UART-of-AST2500
Date: Wed, 17 Oct 2018 09:40:58 +0530
Message-ID: <1539749466-3912-2-git-send-email-open.sudheer@gmail.com>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Russell King <linux@armlinux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Moese <mmoese@suse.de>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.orglinux
Cc: "sudheer.v" <open.sudheer@gmail.com>, Sudheer V <sudheer.veliseti@aspeedtech.com>, ShivahShankar Shakarnarayan rao <shivahshankar.shankarnarayanrao@aspeedtech.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: sudheer.v <open.sudheer@gmail.com>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 20 ++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi         | 85 ++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 5dbb33c..f98d55b 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -64,6 +64,26 @@
 	status = "okay";
 };
 
+&ast_uart_sdma{
+	status = "okay";
+};
+
+&dma_uart0 {
+	status = "disabled";
+};
+
+&dma_uart1 {
+	status = "disabled";
+};
+
+&dma_uart2 {
+	status = "okay";
+};
+
+&dma_uart3 {
+	status = "okay";
+};
+
 &mac0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d92f047..ba8edd1 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -436,6 +436,91 @@
 				status = "disabled";
 			};
 
+			ast_uart_sdma: uart_sdma@1e79e000 {
+				compatible = "aspeed,ast-uart-sdma";
+				reg = <0x1e79e000 0x400>;
+				interrupts = <50>;
+				#dma-cells = <1>;
+				dma-channels = <8>;
+				status = "disabled";
+			};
+
+			dma_uart0: dma_uart0@1e783000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e783000 0x1000>;
+				interrupts = <9>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+				reg-shift = <2>;
+				dma-channel = <0>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd1_default
+				&pinctrl_rxd1_default &pinctrl_ncts1_default
+				&pinctrl_ndcd1_default &pinctrl_ndsr1_default
+				&pinctrl_ndtr1_default &pinctrl_nri1_default
+				&pinctrl_nrts1_default>;
+				dma-names = "rx", "tx";
+				dmas = <&ast_uart_sdma 1>, <&ast_uart_sdma 0>;
+				status = "disabled";
+			};
+
+			dma_uart1: dma_uart1@1e78d000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78d000 0x1000>;
+				interrupts = <32>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
+				reg-shift = <2>;
+				dma-channel = <1>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd2_default
+				&pinctrl_rxd2_default &pinctrl_ncts2_default
+				&pinctrl_ndcd2_default &pinctrl_ndsr2_default
+				&pinctrl_ndtr2_default &pinctrl_nri2_default
+				&pinctrl_nrts2_default>;
+				dma-names = "rx", "tx";
+				dmas = <&ast_uart_sdma 3>, <&ast_uart_sdma 2>;
+				status = "disabled";
+};
+
+			dma_uart2: dma_uart2@1e78e000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78e000 0x1000>;
+				interrupts = <33>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
+				reg-shift = <2>;
+				dma-channel = <2>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd3_default
+				&pinctrl_rxd3_default &pinctrl_ncts3_default
+				&pinctrl_ndcd3_default &pinctrl_ndsr3_default
+				&pinctrl_ndtr3_default &pinctrl_nri3_default
+				&pinctrl_nrts3_default>;
+				dma-names = "rx", "tx";
+				dmas = <&ast_uart_sdma 5>, <&ast_uart_sdma 4>;
+				status = "disabled";
+};
+
+			dma_uart3: dma_uart3@1e78f000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78f000 0x1000>;
+				interrupts = <34>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
+				reg-shift = <2>;
+				dma-channel = <3>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd4_default
+				&pinctrl_rxd4_default &pinctrl_ncts4_default
+				&pinctrl_ndcd4_default &pinctrl_ndsr4_default
+				&pinctrl_ndtr4_default &pinctrl_nri4_default
+				&pinctrl_nrts4_default>;
+				dma-names = "rx", "tx";
+				dmas = <&ast_uart_sdma 7>, <&ast_uart_sdma 6>;
+				status = "disabled";
+};
+
 			i2c: i2c@1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
-- 
1.9.1
