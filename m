From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 2/2] acpi, x86: Use SPCR table for earlycon on x86
Date: Mon, 11 Dec 2017 10:50:59 -0500
Message-ID: <20171211155059.17062-3-prarit@redhat.com>
References: <20171211155059.17062-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171211155059.17062-1-prarit@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, linux-serial@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Timur Tabi <timur@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The ACPI SPCR code has been used to define an earlycon console for ARM64
and can be used for x86.

Modify the ACPI SPCR parsing code to account for console behaviour
differences between ARM64 and x86.  Initialize the SPCR code from
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
Cc: Timur Tabi <timur@codeaurora.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/acpi.c                        | 2 +-
 arch/x86/kernel/acpi/boot.c                     | 4 ++++
 drivers/acpi/Kconfig                            | 2 +-
 drivers/acpi/spcr.c                             | 7 +++++--
 include/linux/acpi.h                            | 7 +++++--
 6 files changed, 19 insertions(+), 6 deletions(-)

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
index b3e33bbdf3b7..aaee4864b63e 100644
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
index f4c463df8b08..f01a03643cff 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -36,6 +36,7 @@
 #include <linux/ioport.h>
 #include <linux/pci.h>
 #include <linux/efi-bgrt.h>
+#include <linux/serial_core.h>
 
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
@@ -1626,6 +1627,9 @@ int __init acpi_boot_init(void)
 	if (!acpi_noirq)
 		x86_init.pci.init = pci_acpi_init;
 
+	/* Do not enable ACPI SPCR console by default */
+	acpi_parse_spcr(console_acpi_spcr_enable, console_acpi_spcr_enable);
+
 	return 0;
 }
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 9ae98eeada76..2d4e841e0682 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -80,7 +80,7 @@ endif
 
 config ACPI_SPCR_TABLE
 	bool "ACPI Serial Port Console Redirection Support"
-	default y if ARM64
+	default y if (X86 || ARM64)
 	help
 	  Enable support for Serial Port Console Redirection (SPCR) Table.
 	  This table provides information about the configuration of the
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index f4bb8110e404..c9469b488527 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -39,7 +39,7 @@ bool console_acpi_spcr_enable __initdata;
  * from arch initialization code as soon as the DT/ACPI decision is made.
  *
  */
-int __init acpi_parse_spcr(bool earlycon)
+int __init acpi_parse_spcr(bool earlycon, bool enable_console)
 {
 	static char opts[ACPI_SPCR_OPTS_SIZE];
 	static char uart[ACPI_SPCR_BUF_SIZE];
@@ -112,7 +112,10 @@ int __init acpi_parse_spcr(bool earlycon)
 	if (earlycon)
 		setup_earlycon(opts);
 
-	err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
+	if (enable_console)
+		err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
+	else
+		err = 0;
 done:
 	acpi_put_table((struct acpi_table_header *)table);
 	return err;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 875d7327d91c..4c2d449bab9b 100644
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
