From: Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH 1/4] dt-bindings: dma: uart: add uart dma bindings
Date: Thu, 20 Sep 2018 14:41:10 +0800
Message-ID: <1537425673-18807-2-git-send-email-long.cheng@mediatek.com>
References: <1537425673-18807-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537425673-18807-1-git-send-email-long.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ed Blake <ed.blake@sondrel.com>, Long Cheng <long.cheng@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

add uart dma bindings

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 .../devicetree/bindings/dma/8250_mtk_dma.txt       |   32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
new file mode 100644
index 0000000..b140cf4
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
@@ -0,0 +1,32 @@
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
+
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: The APDMA clock for register accesses
+
+Examples:
+
+	apdma: dma-controller@11000380 {
+		compatible = "mediatek,mt2712-uart-dma";
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
\ No newline at end of file
-- 
1.7.9.5
