From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v2 02/10] ARM: dts: list the CPU nodes for Exynos5250
Date: Fri, 14 Jun 2013 19:32:44 +0530
Message-ID: <1371218572-8993-3-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
 <1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34639 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab3FNOD0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 10:03:26 -0400
Received: by mail-pd0-f170.google.com with SMTP id x11so605672pdj.29
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2013 07:03:26 -0700 (PDT)
In-Reply-To: <1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
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

