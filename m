From: Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH v11 3/6] arm64: dts: mt8183: add pinctrl device node
Date: Mon, 27 May 2019 17:04:44 +0800
Message-ID: <1558947887-31084-4-git-send-email-erin.lo@mediatek.com>
References: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, erin.lo@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, Zhiyong Tao <zhiyong.tao@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Zhiyong Tao <zhiyong.tao@mediatek.com>

The commit adds pinctrl device node for mt8183

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5b34ec6..e74ea21 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include "mt8183-pinfunc.h"
 
 / {
 	compatible = "mediatek,mt8183";
@@ -204,6 +205,30 @@
 			#clock-cells = <1>;
 		};
 
+		pio: pinctrl@10005000 {
+			compatible = "mediatek,mt8183-pinctrl";
+			reg = <0 0x10005000 0 0x1000>,
+			      <0 0x11f20000 0 0x1000>,
+			      <0 0x11e80000 0 0x1000>,
+			      <0 0x11e70000 0 0x1000>,
+			      <0 0x11e90000 0 0x1000>,
+			      <0 0x11d30000 0 0x1000>,
+			      <0 0x11d20000 0 0x1000>,
+			      <0 0x11c50000 0 0x1000>,
+			      <0 0x11f30000 0 0x1000>,
+			      <0 0x1000b000 0 0x1000>;
+			reg-names = "iocfg0", "iocfg1", "iocfg2",
+				    "iocfg3", "iocfg4", "iocfg5",
+				    "iocfg6", "iocfg7", "iocfg8",
+				    "eint";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pio 0 0 192>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+		};
+
 		apmixedsys: syscon@1000c000 {
 			compatible = "mediatek,mt8183-apmixedsys", "syscon";
 			reg = <0 0x1000c000 0 0x1000>;
-- 
1.8.1.1.dirty
