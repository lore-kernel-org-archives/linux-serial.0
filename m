From: Long Cheng <long.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 4/4] arm: dts: mt2701: add uart APDMA to device tree
Date: Thu, 16 Feb 2017 19:07:31 +0800
Message-ID: <1487243251-964-5-git-send-email-long.cheng@mediatek.com>
References: <1487243251-964-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1487243251-964-1-git-send-email-long.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Long Cheng <long.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

1. add uart APDMA controller device node
2. add uart 0/1/2/3 DMA function
3. uart0 is console, So disable DMA
4. enable uart2 port to test DMA function.

Signed-off-by: Long Cheng <long.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 arch/arm/boot/dts/mt2701-evb.dts |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi    |   29 +++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index 082ca88..2f92bf9 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -24,6 +24,28 @@
 	};
 };
 
+&pio {
+	uart2_default_cfg: uart2default {
+		pins_cmd_dat {
+			pinmux = <MT2701_PIN_14_URXD2__FUNC_URXD2>,
+				 <MT2701_PIN_15_UTXD2__FUNC_UTXD2>,
+				 <MT2701_PIN_242_URTS2__FUNC_URTS2>,
+				 <MT2701_PIN_243_UCTS2__FUNC_UCTS2>;
+			bias-pull-up;
+		};
+	};
+};
+
 &uart0 {
+	dmas = "";
+	dma-names = "";
+
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_default_cfg>;
+
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 7eab6f4..62b3ec9 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -175,6 +175,23 @@
 		      <0 0x10216000 0 0x2000>;
 	};
 
+	apdma: dma-controller@11000380 {
+		compatible = "mediatek,mt2701-uart-dma",
+			     "mediatek,mt6577-uart-dma";
+		reg = <0 0x11000380 0 0x400>;
+		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 65 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 66 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 69 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "apdma";
+		#dma-cells = <1>;
+	};
+
 	uart0: serial@11002000 {
 		compatible = "mediatek,mt2701-uart",
 			     "mediatek,mt6577-uart";
@@ -182,6 +199,9 @@
 		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 0
+			&apdma 1>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -192,6 +212,9 @@
 		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&pericfg CLK_PERI_UART1_SEL>, <&pericfg CLK_PERI_UART1>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 2
+			&apdma 3>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -202,6 +225,9 @@
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&pericfg CLK_PERI_UART2_SEL>, <&pericfg CLK_PERI_UART2>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 4
+			&apdma 5>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -212,6 +238,9 @@
 		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&pericfg CLK_PERI_UART3_SEL>, <&pericfg CLK_PERI_UART3>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 6
+			&apdma 7>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 };
-- 
1.7.9.5
