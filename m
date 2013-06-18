From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v4 05/10] ARM: Exynos: use four additional chipid bits to identify Exynos family
Date: Tue, 18 Jun 2013 11:59:17 +0530
Message-ID: <1371536962-13322-6-git-send-email-chander.kashyap@linaro.org>
References: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:45704 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab3FRGaA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Jun 2013 02:30:00 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so3650728pab.34
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2013 23:30:00 -0700 (PDT)
In-Reply-To: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>

Use chipid[27:20] bits to identify the Exynos family while setting up
the serial port during the uncompression setup. This uses four additional
bits of chipid to identify the Exynos family since this is required for
identifying Exynos5420 SoC.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
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

