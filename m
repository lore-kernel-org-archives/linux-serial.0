From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v2 05/10] ARM: Exynos: use four additional chipid bits to identify Exynos family
Date: Fri, 14 Jun 2013 19:32:47 +0530
Message-ID: <1371218572-8993-6-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
 <1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>
List-Id: linux-serial@vger.kernel.org

Use chipid[27:20] bits to identify the Exynos family while setting up
the serial port during the uncompression setup. This uses four additional
bits of chipid to identify the Exynos family since this is required for
identifying Exynos5420 SoC.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/include/mach/uncompress.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/uncompress.h b/arch/arm/mach-exynos/include/mach/uncompress.h
index 2979995..1937e0f 100644
--- a/arch/arm/mach-exynos/include/mach/uncompress.h
+++ b/arch/arm/mach-exynos/include/mach/uncompress.h
@@ -31,13 +31,12 @@ static void arch_detect_cpu(void)
 
 	/*
 	 * product_id is bits 31:12
-	 *    bits 23:20 describe the exynosX family
-	 *
+	 * bits 23:20 describe the exynosX family
+	 * bits 27:24 describe the exynosX family in exynos5420
 	 */
 	chip_id >>= 20;
-	chip_id &= 0xf;
 
-	if (chip_id == 0x5)
+	if ((chip_id & 0x0f) == 0x5 || (chip_id & 0xf0) == 0x50)
 		uart_base = (volatile u8 *)EXYNOS5_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
 	else
 		uart_base = (volatile u8 *)EXYNOS4_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
-- 
1.7.9.5
