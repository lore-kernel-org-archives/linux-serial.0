From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v3 6/7] ACPI: enable ACPI_DBG2_TABLE on ARM64
Date: Mon, 29 Feb 2016 15:42:03 +0300
Message-ID: <1456749726-30261-7-git-send-email-aleksey.makarov@linaro.org>
References: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Matthias Brugger <mbrugger@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-serial@vger.kernel.org

SBBR mentions DBG2 as a mandatory ACPI table.
So enable it for ARM64

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/arm64/Kconfig       | 1 +
 arch/arm64/kernel/acpi.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9dc5209..0b614d4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -3,6 +3,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_DBG2_TABLE if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index d1ce8e2..3370046 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -208,6 +208,8 @@ void __init acpi_boot_table_init(void)
 		pr_err("Failed to init ACPI tables\n");
 		if (!param_acpi_force)
 			disable_acpi();
+	} else {
+		acpi_probe_device_table(dbg2);
 	}
 }
 
-- 
2.7.1

