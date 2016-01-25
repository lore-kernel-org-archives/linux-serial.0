From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 2/3] ACPI: parse SPCR and enable matching console
Date: Mon, 25 Jan 2016 17:45:22 +0600
Message-ID: <1453722324-22407-3-git-send-email-aleksey.makarov@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

'ARM Server Base Boot Requiremets' [1] mention SPCR
(Serial Port Console Redirection Table) [2] as a mandatory ACPI table
that specifies the configuration of serial console.

Parse this table and check if any registered console match
the description.  If it does, enable that console.

To implement that, introduce a new member
int (*acpi_match)(struct console *, struct acpi_table_spcr *)
of struct console.  It allows drivers to check if they provide
a matching console device.

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[2] http://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/arm64/Kconfig      |  1 +
 drivers/acpi/Kconfig    |  3 ++
 drivers/acpi/Makefile   |  1 +
 drivers/acpi/spcr.c     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/console.h | 12 +++++++
 kernel/printk/printk.c  | 82 +++++++++++++++++++++++++++++++++++++----------
 6 files changed, 167 insertions(+), 17 deletions(-)
 create mode 100644 drivers/acpi/spcr.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 573bebc..bf31e3c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -4,6 +4,7 @@ config ARM64
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_PCI_HOST_GENERIC if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_SPCR_TABLE if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e315061..142a338 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -60,6 +60,9 @@ config ACPI_CCA_REQUIRED
 config IORT_TABLE
 	bool
 
+config ACPI_SPCR_TABLE
+	bool
+
 config ACPI_DEBUGGER
 	bool "AML debugger interface (EXPERIMENTAL)"
 	select ACPI_DEBUG
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 265eb90..8316859 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_IORT_TABLE) 	+= iort.o
+obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
new file mode 100644
index 0000000..ccb19a0
--- /dev/null
+++ b/drivers/acpi/spcr.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (c) 2012, Intel Corporation
+ * Copyright (c) 2015, Red Hat, Inc.
+ * Copyright (c) 2015, 2016 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#define pr_fmt(fmt) "ACPI: SPCR: " fmt
+
+#include <linux/acpi.h>
+#include <linux/console.h>
+#include <linux/kernel.h>
+
+static struct acpi_table_spcr *spcr_table;
+
+int console_acpi_match(struct console *c, char **options)
+{
+	int err;
+
+	if (!c->acpi_match)
+		return -ENODEV;
+
+	if (!spcr_table)
+		return -EAGAIN;
+
+	err = c->acpi_match(c, spcr_table);
+	if (err < 0)
+		return err;
+
+	if (options) {
+		switch (spcr_table->baud_rate) {
+		case 3:
+			*options = "9600";
+			break;
+		case 4:
+			*options = "19200";
+			break;
+		case 6:
+			*options = "57600";
+			break;
+		case 7:
+			*options = "115200";
+			break;
+		default:
+			*options = "";
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int __init spcr_table_detect(void)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	status = acpi_get_table(ACPI_SIG_SPCR, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		const char *msg = acpi_format_exception(status);
+
+		pr_err("Failed to get table, %s\n", msg);
+		return -EINVAL;
+	}
+
+	if (table->revision < 2)
+		return -EOPNOTSUPP;
+
+	spcr_table = (struct acpi_table_spcr *)table;
+
+	pr_info("Console at 0x%016llx\n", spcr_table->serial_port.address);
+
+	acpi_register_consoles_try_again();
+
+	return 0;
+}
+
+arch_initcall(spcr_table_detect);
diff --git a/include/linux/console.h b/include/linux/console.h
index bd19434..94d0bd8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -117,6 +117,7 @@ static inline int con_debug_leave(void)
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
 
+struct acpi_table_spcr;
 struct console {
 	char	name[16];
 	void	(*write)(struct console *, const char *, unsigned);
@@ -125,6 +126,7 @@ struct console {
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
 	int	(*match)(struct console *, char *name, int idx, char *options);
+	int	(*acpi_match)(struct console *, struct acpi_table_spcr *);
 	short	flags;
 	short	index;
 	int	cflag;
@@ -132,6 +134,16 @@ struct console {
 	struct	 console *next;
 };
 
+#ifdef CONFIG_ACPI
+int console_acpi_match(struct console *c, char **options);
+#else
+static inline int console_acpi_match(struct console *c, char **options)
+{
+	return -ENODEV;
+}
+#endif
+void acpi_register_consoles_try_again(void);
+
 /*
  * for_each_console() allows you to iterate on each console
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 37e531f..3cf8cba 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2430,6 +2430,25 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static DEFINE_MUTEX(acpi_consoles_delayed_mutex);
+static struct console *acpi_consoles_delayed;
+
+void acpi_register_consoles_try_again(void)
+{
+	mutex_lock(&acpi_consoles_delayed_mutex);
+	while (acpi_consoles_delayed) {
+
+		struct console *c = acpi_consoles_delayed;
+
+		acpi_consoles_delayed = acpi_consoles_delayed->next;
+
+		mutex_unlock(&acpi_consoles_delayed_mutex);
+		register_console(c);
+		mutex_lock(&acpi_consoles_delayed_mutex);
+	}
+	mutex_unlock(&acpi_consoles_delayed_mutex);
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2538,8 +2557,30 @@ void register_console(struct console *newcon)
 		break;
 	}
 
-	if (!(newcon->flags & CON_ENABLED))
-		return;
+	if (!(newcon->flags & CON_ENABLED)) {
+		char *opts;
+		int err;
+
+		if (newcon->index < 0)
+			newcon->index = 0;
+
+		err = console_acpi_match(newcon, &opts);
+
+		if (err == -EAGAIN) {
+			mutex_lock(&acpi_consoles_delayed_mutex);
+			newcon->next = acpi_consoles_delayed;
+			acpi_consoles_delayed = newcon;
+			mutex_unlock(&acpi_consoles_delayed_mutex);
+			return;
+		} else if (err < 0) {
+			return;
+		} else {
+			if (newcon->setup && newcon->setup(newcon, opts) != 0)
+				return;
+			newcon->flags |= CON_ENABLED | CON_CONSDEV;
+			preferred_console = true;
+		}
+	}
 
 	/*
 	 * If we have a bootconsole, and are switching to a real console,
@@ -2612,34 +2653,41 @@ void register_console(struct console *newcon)
 }
 EXPORT_SYMBOL(register_console);
 
+static int delete_from_console_list(struct console **list, struct console *c)
+{
+	while (*list) {
+		struct console *cur = *list;
+
+		if (cur == c) {
+			*list = cur->next;
+			return 0;
+		}
+		list = &cur->next;
+	}
+	return 1;
+}
+
 int unregister_console(struct console *console)
 {
-        struct console *a, *b;
 	int res;
 
 	pr_info("%sconsole [%s%d] disabled\n",
 		(console->flags & CON_BOOT) ? "boot" : "" ,
 		console->name, console->index);
 
+	mutex_lock(&acpi_consoles_delayed_mutex);
+	res = delete_from_console_list(&acpi_consoles_delayed, console);
+	mutex_unlock(&acpi_consoles_delayed_mutex);
+	if (res == 0)
+		return res;
+
 	res = _braille_unregister_console(console);
 	if (res)
 		return res;
 
-	res = 1;
 	console_lock();
-	if (console_drivers == console) {
-		console_drivers=console->next;
-		res = 0;
-	} else if (console_drivers) {
-		for (a=console_drivers->next, b=console_drivers ;
-		     a; b=a, a=b->next) {
-			if (a == console) {
-				b->next = a->next;
-				res = 0;
-				break;
-			}
-		}
-	}
+
+	res = delete_from_console_list(&console_drivers, console);
 
 	if (!res && (console->flags & CON_EXTENDED))
 		nr_ext_console_drivers--;
-- 
2.7.0
