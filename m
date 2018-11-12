From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 08/10] arm64: tegra: Add nodes for TCU on Tegra194
Date: Mon, 12 Nov 2018 16:18:51 +0100
Message-ID: <20181112151853.29289-9-thierry.reding@gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181112151853.29289-1-thierry.reding@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Mika Liljeberg <mliljeberg@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Add nodes required for communication through the Tegra Combined UART.
This includes the AON HSP instance, addition of shared interrupts
for the TOP0 HSP instance, and finally the TCU node itself. Also
mark the HSP instances as compatible to tegra194-hsp, as the hardware
is not identical but is compatible to tegra186-hsp.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- encode direction of mailboxes in device tree mailbox specifier

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 38 ++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c2091bb16546..4451532a2b4c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -340,10 +340,35 @@
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
+			/*
+			 * Shared interrupt 0 is routed only to AON/SPE, so
+			 * we only have 4 shared interrupts for the CCPLEX.
+			 */
+			interrupt-names = "shared1", "shared2", "shared3", "shared4";
 			#mbox-cells = <2>;
 		};
 
@@ -531,6 +556,13 @@
 		method = "smc";
 	};
 
+	tcu: tcu {
+		compatible = "nvidia,tegra194-tcu";
+		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM TEGRA_HSP_SM_RX(0)>,
+		         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM TEGRA_HSP_SM_TX(1)>;
+		mbox-names = "rx", "tx";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.19.1
