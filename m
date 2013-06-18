From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v4 09/10] ARM: Exynos: add secondary CPU boot base location for Exynos5420
Date: Tue, 18 Jun 2013 11:59:21 +0530
Message-ID: <1371536962-13322-10-git-send-email-chander.kashyap@linaro.org>
References: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:62905 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab3FRGaR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Jun 2013 02:30:17 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3523194pbb.8
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2013 23:30:17 -0700 (PDT)
In-Reply-To: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>

The location at which the boot address is specified for secondary CPUs of
Exynos5420 is SYSRAM base + 4. Update the cpu_boot_reg function accordingly.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 85ea4ca..7b4c03e 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -50,6 +50,8 @@ static inline void __iomem *cpu_boot_reg(int cpu)
 	boot_reg = cpu_boot_reg_base();
 	if (soc_is_exynos4412())
 		boot_reg += 4*cpu;
+	else if (soc_is_exynos5420())
+		boot_reg += 4;
 	return boot_reg;
 }
 
-- 
1.7.9.5

