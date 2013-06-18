From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v4 03/10] ARM: Exynos: Add support for Exynos5420 SoC
Date: Tue, 18 Jun 2013 11:59:15 +0530
Message-ID: <1371536962-13322-4-git-send-email-chander.kashyap@linaro.org>
References: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>
List-Id: linux-serial@vger.kernel.org

Exynos5420 is new SoC in Samsung's Exynos5 SoC series. Add initial support
for this new SoC.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/Kconfig             |   10 ++++++++++
 arch/arm/mach-exynos/common.c            |    7 +++++++
 arch/arm/mach-exynos/mach-exynos5-dt.c   |    1 +
 arch/arm/plat-samsung/include/plat/cpu.h |    8 ++++++++
 4 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index ff18fc2..5ae41ec 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -71,6 +71,16 @@ config SOC_EXYNOS5250
 	help
 	  Enable EXYNOS5250 SoC support
 
+config SOC_EXYNOS5420
+	bool "SAMSUNG EXYNOS5420"
+	default y
+	depends on ARCH_EXYNOS5
+	select PM_GENERIC_DOMAINS if PM
+	select S5P_PM if PM
+	select S5P_SLEEP if PM
+	help
+	  Enable EXYNOS5420 SoC support
+
 config SOC_EXYNOS5440
 	bool "SAMSUNG EXYNOS5440"
 	default y
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index f1240f3..6f435da 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -65,6 +65,7 @@ static const char name_exynos4210[] = "EXYNOS4210";
 static const char name_exynos4212[] = "EXYNOS4212";
 static const char name_exynos4412[] = "EXYNOS4412";
 static const char name_exynos5250[] = "EXYNOS5250";
+static const char name_exynos5420[] = "EXYNOS5420";
 static const char name_exynos5440[] = "EXYNOS5440";
 
 static void exynos4_map_io(void);
@@ -104,6 +105,12 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= exynos_init,
 		.name		= name_exynos5250,
 	}, {
+		.idcode		= EXYNOS5420_SOC_ID,
+		.idmask		= EXYNOS5_SOC_MASK,
+		.map_io		= exynos5_map_io,
+		.init		= exynos_init,
+		.name		= name_exynos5420,
+	}, {
 		.idcode		= EXYNOS5440_SOC_ID,
 		.idmask		= EXYNOS5_SOC_MASK,
 		.map_io		= exynos5440_map_io,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 753b94f..050a5b1 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -57,6 +57,7 @@ static void __init exynos5_dt_machine_init(void)
 
 static char const *exynos5_dt_compat[] __initdata = {
 	"samsung,exynos5250",
+	"samsung,exynos5420",
 	"samsung,exynos5440",
 	NULL
 };
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 989fefe..4fb1f03 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -46,6 +46,7 @@ extern unsigned long samsung_cpu_id;
 #define EXYNOS4_CPU_MASK	0xFFFE0000
 
 #define EXYNOS5250_SOC_ID	0x43520000
+#define EXYNOS5420_SOC_ID	0xE5420000
 #define EXYNOS5440_SOC_ID	0xE5440000
 #define EXYNOS5_SOC_MASK	0xFFFFF000
 
@@ -67,6 +68,7 @@ IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
@@ -142,6 +144,12 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos5250()	0
 #endif
 
+#if defined(CONFIG_SOC_EXYNOS5420)
+# define soc_is_exynos5420()	is_samsung_exynos5420()
+#else
+# define soc_is_exynos5420()	0
+#endif
+
 #if defined(CONFIG_SOC_EXYNOS5440)
 # define soc_is_exynos5440()	is_samsung_exynos5440()
 #else
-- 
1.7.9.5
