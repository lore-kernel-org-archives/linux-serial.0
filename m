From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 2/2] acpi, x86: Use SPCR table for earlycon on x86
Date: Thu,  7 Dec 2017 12:29:12 -0500
Message-ID: <20171207172912.17868-3-prarit@redhat.com>
References: <20171207172912.17868-1-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20171207172912.17868-1-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-serial@vger.kernel.org

The ACPI SPCR code has been used to define an earlycon console for arm64
and can be used for x86.

Modify the ACPI SPCR parsing code to account for console behaviour
differences between arm64 and x86.  Initialize the SPCR code from
x86 ACPI initialization code.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/acpi.c                        | 2 +-
 arch/x86/kernel/acpi/boot.c                     | 3 +++
 drivers/acpi/Kconfig                            | 2 +-
 drivers/acpi/spcr.c                             | 5 +++--
 include/linux/acpi.h                            | 7 +++++--
 6 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0d173289c67e..c7cc890a0e81 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -918,6 +918,9 @@
 			stdout-path property in device tree's chosen node,
 			or determined by the ACPI SPCR table.
 
+			[X86] When used with no options the early console is
+			determined by the ACPI SPCR table.
+
 		cdns,<addr>[,options]
 			Start an early, polled-mode console on a Cadence
 			(xuartps) serial port at the specified address. Only
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index ef74e1f3e468..9d7842022d47 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -355,7 +355,7 @@ void __init acpi_boot_table_init(void)
 			early_init_dt_scan_chosen_stdout();
 	} else {
 		/* Always enable the ACPI SPCR console */
-		acpi_parse_spcr(console_acpi_spcr_enable);
+		acpi_parse_spcr(console_acpi_spcr_enable, true);
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 	}
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index f4c463df8b08..4527ecbab4cb 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1626,6 +1626,9 @@ int __init acpi_boot_init(void)
 	if (!acpi_noirq)
 		x86_init.pci.init = pci_acpi_init;
 
+	/* Do not enable ACPI SPCR console by default */
+	acpi_parse_spcr(console_acpi_spcr_enable, console_acpi_spcr_enable);
+
 	return 0;
 }
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ae25159dd976..6bcddd149ca7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -562,7 +562,7 @@ config TPS68470_PMIC_OPREGION
 
 config ACPI_SPCR_TABLE
 	bool "ACPI Serial Port Console Redirection Support"
-	default y if ARM64
+	default y if (X86 || ARM64)
 	help
 	  Enable support for Serial Port Console Redirection (SPCR) Table.
 	  This table provides information about the configuration of the
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index d8ad8fa67582..23abb1c207a0 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -40,7 +40,7 @@ bool console_acpi_spcr_enable __initdata;
  * from arch initialization code as soon as the DT/ACPI decision is made.
  *
  */
-int __init acpi_parse_spcr(bool earlycon)
+int __init acpi_parse_spcr(bool earlycon, bool enable_console)
 {
 	static char opts[ACPI_SPCR_OPTS_SIZE];
 	static char uart[ACPI_SPCR_BUF_SIZE];
@@ -113,7 +113,8 @@ int __init acpi_parse_spcr(bool earlycon)
 	if (earlycon)
 		setup_earlycon(opts);
 
-	err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
+	if (enable_console)
+		err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
 done:
 	acpi_put_table((struct acpi_table_header *)table);
 	return err;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 818c1053cc6f..252d692f017f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1248,10 +1248,13 @@ extern bool console_acpi_spcr_enable __initdata;
 extern int acpi_arch_setup_console(struct acpi_table_spcr *table,
 				   char *opts, char *uart, char *iotype,
 				   int baud_rate, bool earlycon);
-int acpi_parse_spcr(bool earlycon);
+int acpi_parse_spcr(bool earlycon, bool enable_console);
 #else
 static const bool console_acpi_spcr_enable;
-static inline int acpi_parse_spcr(bool earlycon) { return 0; }
+static inline int acpi_parse_spcr(bool earlycon, bool enable_console)
+{
+	return 0;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_ACPI_GENERIC_GSI)
-- 
2.15.0.rc0.39.g2f0e14e64
