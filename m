From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v3 10/10] ARM: Exynos: extend soft-reset support for Exynos5420
Date: Mon, 17 Jun 2013 16:30:35 +0530
Message-ID: <1371466836-4111-11-git-send-email-chander.kashyap@linaro.org>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:45573 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669Ab3FQLBg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jun 2013 07:01:36 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so2723697pab.22
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2013 04:01:36 -0700 (PDT)
In-Reply-To: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>

Extend the soft reset support for Exynos5420 SoC.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/mach-exynos/common.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 6f435da..4e6c227 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -330,10 +330,10 @@ void exynos5_restart(char mode, const char *cmd)
 	u32 val;
 	void __iomem *addr;
 
-	if (of_machine_is_compatible("samsung,exynos5250")) {
-		val = 0x1;
-		addr = EXYNOS_SWRESET;
-	} else if (of_machine_is_compatible("samsung,exynos5440")) {
+	val = 0x1;
+	addr = EXYNOS_SWRESET;
+
+	if (of_machine_is_compatible("samsung,exynos5440")) {
 		u32 status;
 		np = of_find_compatible_node(NULL, NULL, "samsung,exynos5440-clock");
 
@@ -344,9 +344,6 @@ void exynos5_restart(char mode, const char *cmd)
 		val = __raw_readl(addr);
 
 		val = (val & 0xffff0000) | (status & 0xffff);
-	} else {
-		pr_err("%s: cannot support non-DT\n", __func__);
-		return;
 	}
 
 	__raw_writel(val, addr);
-- 
1.7.9.5

