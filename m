From: Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH v11 3/4] dt-bindings: dma: uart: rename binding
Date: Thu, 7 Mar 2019 09:45:34 +0800
Message-ID: <1551923135-32479-4-git-send-email-long.cheng@mediatek.com>
References: <1551923135-32479-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551923135-32479-1-git-send-email-long.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhenbao Liu <zhenbao.liu@mediatek.com>, Long Cheng <long.cheng@mediatek.com>
List-Id: linux-serial@vger.kernel.org

The filename matches mtk-uart-apdma.c.
So using "mtk-uart-apdma.txt" should be better.
And add some property.

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org> 
---
 .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 ------------
 .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   55 ++++++++++++++++++++
 2 files changed, 55 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt

diff --git a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
deleted file mode 100644
index 3fe0961..0000000
--- a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-* Mediatek UART APDMA Controller
-
-Required properties:
-- compatible should contain:
-  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
-  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
-
-- reg: The base address of the APDMA register bank.
-
-- interrupts: A single interrupt specifier.
-
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: The APDMA clock for register accesses
-
-Examples:
-
-	apdma: dma-controller@11000380 {
-		compatible = "mediatek,mt2712-uart-dma";
-		reg = <0 0x11000380 0 0x400>;
-		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 65 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 66 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 69 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&pericfg CLK_PERI_AP_DMA>;
-		clock-names = "apdma";
-		#dma-cells = <1>;
-	};
-
diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
new file mode 100644
index 0000000..e0424b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
@@ -0,0 +1,55 @@
+* Mediatek UART APDMA Controller
+
+Required properties:
+- compatible should contain:
+  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
+  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
+
+- reg: The base address of the APDMA register bank.
+
+- interrupts: A single interrupt specifier.
+ One interrupt per dma-requests, or 8 if no dma-requests property is present
+
+- dma-requests: The number of DMA channels
+
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: The APDMA clock for register accesses
+
+- mediatek,dma-33bits: Present if the DMA requires support
+
+Examples:
+
+	apdma: dma-controller@11000400 {
+		compatible = "mediatek,mt2712-uart-dma";
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
+		mediatek,dma-33bits;
+		#dma-cells = <1>;
+	};
+
-- 
1.7.9.5
