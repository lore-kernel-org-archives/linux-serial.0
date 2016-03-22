From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v5 4/6] ACPI: enable ACPI_SPCR_TABLE on ARM64
Date: Tue, 22 Mar 2016 13:46:31 +0300
Message-ID: <1458643595-14719-5-git-send-email-aleksey.makarov@linaro.org>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-serial@vger.kernel.org

SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64

Earlycon should be set up as early as possible.  ACPI boot tables are
mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from
setup_arch() and that's where we parse SPCR.  So it has to be opted-in
per-arch.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/arm64/Kconfig       | 1 +
 arch/arm64/kernel/acpi.c | 2 ++
 2 files changed, 3 insertions(+)

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
index d1ce8e2..36d6f70 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -208,6 +208,8 @@ void __init acpi_boot_table_init(void)
 		pr_err("Failed to init ACPI tables\n");
 		if (!param_acpi_force)
 			disable_acpi();
+	} else {
+		parse_spcr();
 	}
 }
 
-- 
2.7.4

