From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v8 3/4] ARM64: ACPI: enable ACPI_SPCR_TABLE
Date: Fri, 20 May 2016 16:03:22 +0300
Message-ID: <1463749405-11640-4-git-send-email-aleksey.makarov@linaro.org>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-serial@vger.kernel.org

SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64

Earlycon should be set up as early as possible.  ACPI boot tables are
mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() that
is called from setup_arch() and that's where we parse SPCR.
So it has to be opted-in per-arch.

When ACPI_SPCR_TABLE is defined initialization of DT earlycon is
deferred until the DT/ACPI decision is done.  Initialize DT earlycon
if ACPI is disabled.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/acpi.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d30abf..80c0816 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -4,6 +4,7 @@ config ARM64
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_PCI_HOST_GENERIC if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_SPCR_TABLE if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 3e4f1a4..252a6d9 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -24,6 +24,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/smp.h>
+#include <linux/serial_core.h>
 
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
@@ -206,7 +207,7 @@ void __init acpi_boot_table_init(void)
 	if (param_acpi_off ||
 	    (!param_acpi_on && !param_acpi_force &&
 	     of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
-		return;
+		goto done;
 
 	/*
 	 * ACPI is disabled at this point. Enable it in order to parse
@@ -226,6 +227,14 @@ void __init acpi_boot_table_init(void)
 		if (!param_acpi_force)
 			disable_acpi();
 	}
+
+done:
+	if (acpi_disabled) {
+		if (earlycon_init_is_deferred)
+			early_init_dt_scan_chosen_stdout();
+	} else {
+		parse_spcr(earlycon_init_is_deferred);
+	}
 }
 
 #ifdef CONFIG_ACPI_APEI
-- 
2.8.2
