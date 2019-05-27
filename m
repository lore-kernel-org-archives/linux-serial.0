From: Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH v11 6/6] arm64: dts: mt8183: add efuse and Mediatek Chip id node to read
Date: Mon, 27 May 2019 17:04:47 +0800
Message-ID: <1558947887-31084-7-git-send-email-erin.lo@mediatek.com>
References: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, erin.lo@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, Michael Mei <michael.mei@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Michael Mei <michael.mei@mediatek.com>

support for reading chip ID and efuse

Signed-off-by: Michael Mei <michael.mei@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
This patch is based on this patch:
https://patchwork.kernel.org/patch/10953029/
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 2e3063f..c2749c4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -156,6 +156,15 @@
 		compatible = "simple-bus";
 		ranges;
 
+		soc_data: soc_data@8000000 {
+			compatible = "mediatek,mt8183-efuse",
+				     "mediatek,efuse";
+			reg = <0 0x08000000 0 0x0010>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@c000000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <4>;
@@ -369,6 +378,12 @@
 			#clock-cells = <1>;
 		};
 
+		efuse: efuse@11f10000 {
+			compatible = "mediatek,mt8183-efuse",
+				     "mediatek,efuse";
+			reg = <0 0x11f10000 0 0x1000>;
+		};
+
 		mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
-- 
1.8.1.1.dirty
