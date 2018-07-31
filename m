From: Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH v4 08/10] arm64: dts: mt8183: Add clock controller device nodes
Date: Tue, 31 Jul 2018 13:38:05 +0800
Message-ID: <1533015487-60189-9-git-send-email-erin.lo@mediatek.com>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, erin.lo@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

Add clock controller nodes for MT8183, include topckgen, infracfg,
apmixedsys and subsystem.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 92 ++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 1553265..6b87a24 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -5,6 +5,7 @@
  *	   Erin Lo <erin.lo@mediatek.com>
  */
 
+#include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -112,6 +113,13 @@
 		method          = "smc";
 	};
 
+	clk26m: oscillator@0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
@@ -143,4 +151,88 @@
 		interrupt-parent = <&gic>;
 		reg = <0 0x0c530a80 0 0x50>;
 	};
+
+	topckgen: syscon@10000000 {
+		compatible = "mediatek,mt8183-topckgen", "syscon";
+		reg = <0 0x10000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	infracfg: syscon@10001000 {
+		compatible = "mediatek,mt8183-infracfg", "syscon";
+		reg = <0 0x10001000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	apmixedsys: syscon@1000c000 {
+		compatible = "mediatek,mt8183-apmixedsys", "syscon";
+		reg = <0 0x1000c000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	audiosys: syscon@11220000 {
+		compatible = "mediatek,mt8183-audiosys", "syscon";
+		reg = <0 0x11220000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	mfgcfg: syscon@13000000 {
+		compatible = "mediatek,mt8183-mfgcfg", "syscon";
+		reg = <0 0x13000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	mmsys: syscon@14000000 {
+		compatible = "mediatek,mt8183-mmsys", "syscon";
+		reg = <0 0x14000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	imgsys: syscon@15020000 {
+		compatible = "mediatek,mt8183-imgsys", "syscon";
+		reg = <0 0x15020000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	vdecsys: syscon@16000000 {
+		compatible = "mediatek,mt8183-vdecsys", "syscon";
+		reg = <0 0x16000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	vencsys: syscon@17000000 {
+		compatible = "mediatek,mt8183-vencsys", "syscon";
+		reg = <0 0x17000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_conn: syscon@19000000 {
+		compatible = "mediatek,mt8183-ipu_conn", "syscon";
+		reg = <0 0x19000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_adl: syscon@19010000 {
+		compatible = "mediatek,mt8183-ipu_adl", "syscon";
+		reg = <0 0x19010000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_core0: syscon@19180000 {
+		compatible = "mediatek,mt8183-ipu_core0", "syscon";
+		reg = <0 0x19180000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_core1: syscon@19280000 {
+		compatible = "mediatek,mt8183-ipu_core1", "syscon";
+		reg = <0 0x19280000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	camsys: syscon@1a000000 {
+		compatible = "mediatek,mt8183-camsys", "syscon";
+		reg = <0 0x1a000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
 };
-- 
1.9.1
