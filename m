From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v4 02/10] ARM: dts: list the CPU nodes for Exynos5250
Date: Tue, 18 Jun 2013 11:59:14 +0530
Message-ID: <1371536962-13322-3-git-send-email-chander.kashyap@linaro.org>
References: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:59347 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab3FRG3r (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Jun 2013 02:29:47 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so3620341pac.40
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2013 23:29:47 -0700 (PDT)
In-Reply-To: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>

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
index 63ca03d..1aeef98 100644
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

