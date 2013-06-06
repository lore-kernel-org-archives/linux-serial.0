From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH 02/13] ARM: Exynos: fix secondary cpu power control register address calculation
Date: Thu,  6 Jun 2013 16:31:16 +0530
Message-ID: <1370516488-25860-2-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>
List-Id: linux-serial@vger.kernel.org

The CPU power control register address calculation for secondary CPUs is
generalized by calculating the register address using secondary cpu
logical number.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    6 ++++++
 arch/arm/mach-exynos/platsmp.c               |   10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index 3f30aa1..b77f72c 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -125,11 +125,17 @@
 #define S5P_GPS_ALIVE_LOWPWR			S5P_PMUREG(0x13A0)
 
 #define S5P_ARM_CORE0_CONFIGURATION		S5P_PMUREG(0x2000)
+#define S5P_ARM_CORE0_STATUS			S5P_PMUREG(0x2004)
 #define S5P_ARM_CORE0_OPTION			S5P_PMUREG(0x2008)
 #define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
 #define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
 #define S5P_ARM_CORE1_OPTION			S5P_PMUREG(0x2088)
 
+#define S5P_ARM_CORE_CONFIGURATION(_nr)		\
+			(S5P_ARM_CORE0_CONFIGURATION + (_nr) * 0x80)
+#define S5P_ARM_CORE_STATUS(_nr)			\
+			(S5P_ARM_CORE0_STATUS + (_nr) * 0x80)
+
 #define S5P_ARM_COMMON_OPTION			S5P_PMUREG(0x2408)
 #define S5P_TOP_PWR_OPTION			S5P_PMUREG(0x2C48)
 #define S5P_CAM_OPTION				S5P_PMUREG(0x3C08)
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index d9c6d0a..1a4e4e5 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -109,14 +109,14 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
 	 */
 	write_pen_release(phys_cpu);
 
-	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
+	if (!(__raw_readl(S5P_ARM_CORE_STATUS(cpu)) & S5P_CORE_LOCAL_PWR_EN)) {
 		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-			     S5P_ARM_CORE1_CONFIGURATION);
+			     S5P_ARM_CORE_CONFIGURATION(cpu));
 
 		timeout = 10;
 
-		/* wait max 10 ms until cpu1 is on */
-		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
+		/* wait max 10 ms until secondary cpu is on */
+		while ((__raw_readl(S5P_ARM_CORE_STATUS(cpu))
 			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
 			if (timeout-- == 0)
 				break;
@@ -125,7 +125,7 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
 		}
 
 		if (timeout == 0) {
-			printk(KERN_ERR "cpu1 power enable failed");
+			pr_err("secondary cpu power enable failed\n");
 			spin_unlock(&boot_lock);
 			return -ETIMEDOUT;
 		}
-- 
1.7.9.5
