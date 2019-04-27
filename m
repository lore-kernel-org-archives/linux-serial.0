From: Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH 2/4] arm: dts: mt2712: add uart APDMA to device tree
Date: Sat, 27 Apr 2019 11:36:31 +0800
Message-ID: <1556336193-15198-3-git-send-email-long.cheng@mediatek.com>
References: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Zhenbao Liu <zhenbao.liu@mediatek.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org, YT Shen <yt.shen@mediatek.com>, Long Cheng <long.cheng@mediatek.com>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, dmaengine@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

1. add uart APDMA controller device node
2. add uart 0/1/2/3/4/5 DMA function

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   51 +++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 976d92a..f1e419e 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -300,6 +300,9 @@
 		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 10
+			&apdma 11>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -369,6 +372,39 @@
 			 (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	apdma: dma-controller@11000400 {
+		compatible = "mediatek,mt2712-uart-dma",
+			     "mediatek,mt6577-uart-dma";
+		reg = <0 0x11000400 0 0x80>,
+		      <0 0x11000480 0 0x80>,
+		      <0 0x11000500 0 0x80>,
+		      <0 0x11000580 0 0x80>,
+		      <0 0x11000600 0 0x80>,
+		      <0 0x11000680 0 0x80>,
+		      <0 0x11000700 0 0x80>,
+		      <0 0x11000780 0 0x80>,
+		      <0 0x11000800 0 0x80>,
+		      <0 0x11000880 0 0x80>,
+		      <0 0x11000900 0 0x80>,
+		      <0 0x11000980 0 0x80>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
+		dma-requests = <12>;
+		clocks = <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "apdma";
+		#dma-cells = <1>;
+	};
+
 	auxadc: adc@11001000 {
 		compatible = "mediatek,mt2712-auxadc";
 		reg = <0 0x11001000 0 0x1000>;
@@ -385,6 +421,9 @@
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 0
+			&apdma 1>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -395,6 +434,9 @@
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 2
+			&apdma 3>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -405,6 +447,9 @@
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 4
+			&apdma 5>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -415,6 +460,9 @@
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 6
+			&apdma 7>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -629,6 +677,9 @@
 		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 8
+			&apdma 9>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.7.9.5
