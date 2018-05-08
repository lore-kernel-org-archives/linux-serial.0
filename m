From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 7/8] arm64: tegra: Add nodes for tcu on Tegra194
Date: Tue, 8 May 2018 14:44:02 +0300
Message-ID: <20180508114403.14499-8-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: araza@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-serial@vger.kernel.org

Add nodes required for communication through the Tegra Combined UART.
This includes the AON HSP instance, addition of shared interrupts
for the TOP0 HSP instance, and finally the TCU node itself. Also
mark the HSP instances as compatible to tegra194-hsp, as the hardware
is not identical but is compatible to tegra186-hsp.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6d699815a84f..d7f780b06fe2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -217,10 +217,31 @@
 		};
 
 		hsp_top0: hsp@3c00000 {
-			compatible = "nvidia,tegra186-hsp";
+			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
 			reg = <0x03c00000 0xa0000>;
-			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "doorbell";
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "doorbell", "shared0", "shared1", "shared2",
+			                  "shared3", "shared4", "shared5", "shared6",
+			                  "shared7";
+			#mbox-cells = <2>;
+		};
+
+		hsp_aon: hsp@c150000 {
+			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
+			reg = <0x0c150000 0xa0000>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "shared0", "shared1", "shared2", "shared3";
 			#mbox-cells = <2>;
 		};
 
@@ -382,6 +403,13 @@
 		};
 	};
 
+	tcu: tcu {
+		compatible = "nvidia,tegra194-tcu";
+		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
+		         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
+		mbox-names = "rx", "tx";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.16.1
