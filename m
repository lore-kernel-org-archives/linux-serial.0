From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 8/8] arm64: tegra: Mark tcu as primary serial port on Tegra194 P2888
Date: Wed, 20 Jun 2018 15:20:42 +0300
Message-ID: <20180620122042.10950-9-mperttunen@nvidia.com>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620122042.10950-1-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-serial@vger.kernel.org

The Tegra Combined UART is the proper primary serial port on P2888,
so use it.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---

Notes:
    v2:
    - Added Jon's Acked-by.

 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 859ab5af17c1..95e2433984f7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -10,7 +10,7 @@
 	aliases {
 		sdhci0 = "/cbb/sdhci@3460000";
 		sdhci1 = "/cbb/sdhci@3400000";
-		serial0 = &uartb;
+		serial0 = &tcu;
 		i2c0 = "/bpmp/i2c";
 		i2c1 = "/cbb/i2c@3160000";
 		i2c2 = "/cbb/i2c@c240000";
-- 
2.16.1
