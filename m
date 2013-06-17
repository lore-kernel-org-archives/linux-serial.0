From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v3 02/10] ARM: dts: list the CPU nodes for Exynos5250
Date: Mon, 17 Jun 2013 16:30:27 +0530
Message-ID: <1371466836-4111-3-git-send-email-chander.kashyap@linaro.org>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>
List-Id: linux-serial@vger.kernel.org

Instead of having to specify the number for CPUs in Exynos5250 in platsmp.c
file, let the number of CPUs be determined by having this information listed
in Exynos5250 device tree file.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |   16 ++++++++++++++++
 arch/arm/mach-exynos/platsmp.c    |   10 +++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 2b59ea3..b4b808e 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -50,6 +50,22 @@
 		pinctrl3 = &pinctrl_3;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+		};
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+		};
+	};
+
 	pd_gsc: gsc-power-domain@0x10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 1a4e4e5..85ea4ca 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -180,10 +180,14 @@ static void __init exynos_smp_init_cpus(void)
 	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
 
-	if (soc_is_exynos5250())
-		ncores = 2;
-	else
+	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
 		ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+	else
+		/*
+		 * CPU Nodes are passed thru DT and set_cpu_possible
+		 * is set by "arm_dt_init_cpu_maps".
+		 */
+		return;
 
 	/* sanity check */
 	if (ncores > nr_cpu_ids) {
-- 
1.7.9.5
