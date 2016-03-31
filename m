From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v7 4/5] ARM64: ACPI: enable ACPI_SPCR_TABLE
Date: Thu, 31 Mar 2016 16:40:26 +0300
Message-ID: <1459431629-27934-5-git-send-email-aleksey.makarov@linaro.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, linux-acpi@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
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
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/acpi.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07b6a16..c77b4b2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -3,6 +3,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_SPCR_TABLE if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index d1ce8e2..f331ebb 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -24,6 +24,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/smp.h>
+#include <linux/serial_core.h>
 
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
@@ -189,7 +190,7 @@ void __init acpi_boot_table_init(void)
 	 */
 	if (param_acpi_off ||
 	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
-		return;
+		goto done;
 
 	/*
 	 * ACPI is disabled at this point. Enable it in order to parse
@@ -209,6 +210,14 @@ void __init acpi_boot_table_init(void)
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
2.7.4
