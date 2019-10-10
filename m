From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH v6 2/5] arm64: Introduce config for S32
Date: Thu, 10 Oct 2019 19:52:25 +0300
Message-ID: <1570726348-6420-3-git-send-email-stefan-gabriel.mirea@nxp.com>
References: <1570726348-6420-1-git-send-email-stefan-gabriel.mirea@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570726348-6420-1-git-send-email-stefan-gabriel.mirea@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com
Cc: jslaby@suse.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
List-Id: linux-serial@vger.kernel.org

From: Mihaela Martinas <Mihaela.Martinas@freescale.com>

Add configuration option for the NXP S32 platform family in
Kconfig.platforms. For starters, the only SoC supported will be Treerunner
(S32V234), with a single execution target: the S32V234-EVB (rev 29288)
board.

Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 16d761475a86..17f1c34ec750 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -212,6 +212,11 @@ config ARCH_ROCKCHIP
 	  This enables support for the ARMv8 based Rockchip chipsets,
 	  like the RK3368.
 
+config ARCH_S32
+	bool "NXP S32 SoC Family"
+	help
+	  This enables support for the NXP S32 family of processors.
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
-- 
2.22.0
