From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH 01/13] ARM: Exynos: initialize l2x0 cache controller only for cortex-a9 based SoCs
Date: Thu,  6 Jun 2013 16:31:15 +0530
Message-ID: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:43811 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab3FFLCe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jun 2013 07:02:34 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so3123483pbc.1
        for <linux-serial@vger.kernel.org>; Thu, 06 Jun 2013 04:02:34 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>

Only cortex-a9 based Exynos SoCs have l2x0 cache controller. Hence instead of
checking for every SoC with soc_is_xxx, just check for cpu part number and
initialize the cache controller for cortex-a9 based SoCs.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/mach-exynos/common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 8ce2db4..bad000e 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -35,6 +35,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 #include <asm/cacheflush.h>
+#include <asm/cputype.h>
 
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
@@ -520,7 +521,7 @@ static int __init exynos4_l2x0_cache_init(void)
 {
 	int ret;
 
-	if (soc_is_exynos5250() || soc_is_exynos5440())
+	if (read_cpuid_part_number() != ARM_CPU_PART_CORTEX_A9)
 		return 0;
 
 	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
-- 
1.7.9.5

