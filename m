From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v8 2/4] ACPI: parse SPCR and enable matching console
Date: Fri, 20 May 2016 16:03:21 +0300
Message-ID: <1463749405-11640-3-git-send-email-aleksey.makarov@linaro.org>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

'ARM Server Base Boot Requiremets' [1] mentions SPCR (Serial Port
Console Redirection Table) [2] as a mandatory ACPI table that
specifies the configuration of serial console.

Defer initialization of DT earlycon until ACPI/DT decision is made.

Parse the ACPI SPCR table, setup earlycon if required,
enable specified console.

Thanks to Peter Hurley for explaining how this should work.

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/Kconfig          |   3 ++
 drivers/acpi/Makefile         |   1 +
 drivers/acpi/spcr.c           | 111 ++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/earlycon.c |  19 +++++++-
 include/linux/acpi.h          |   6 +++
 include/linux/serial_core.h   |   6 +++
 6 files changed, 144 insertions(+), 2 deletions(-)
 create mode 100644 drivers/acpi/spcr.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c204344..c8c02f1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -77,6 +77,9 @@ config ACPI_DEBUGGER_USER
 
 endif
 
+config ACPI_SPCR_TABLE
+	bool
+
 config ACPI_SLEEP
 	bool
 	depends on SUSPEND || HIBERNATION
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8b08e20..d0dc940 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
+obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 
 # processor has its own "processor." module_param namespace
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
new file mode 100644
index 0000000..f4cfc5c
--- /dev/null
+++ b/drivers/acpi/spcr.c
@@ -0,0 +1,111 @@
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
+#include <linux/serial_core.h>
+
+/**
+ * parse_spcr() - parse ACPI SPCR table and add preferred console
+ *
+ * @earlycon: set up earlycon for the console specified by the table
+ *
+ * For the architectures with support for ACPI, CONFIG_ACPI_SPCR_TABLE may be
+ * defined to parse ACPI SPCR table.  As a result of the parsing preferred
+ * console is registered and if @earlycon is true, earlycon is set up.
+ *
+ * When CONFIG_ACPI_SPCR_TABLE is defined, this function should be called
+ * from arch inintialization code as soon as the DT/ACPI decision is made.
+ *
+ */
+int __init parse_spcr(bool earlycon)
+{
+	static char opts[64];
+	struct acpi_table_spcr *table;
+	acpi_size table_size;
+	acpi_status status;
+	char *uart;
+	char *iotype;
+	int baud_rate;
+	int err;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	status = acpi_get_table_with_size(ACPI_SIG_SPCR, 0,
+					  (struct acpi_table_header **)&table,
+					  &table_size);
+
+	if (ACPI_FAILURE(status))
+		return -ENOENT;
+
+	if (table->header.revision < 2) {
+		err = -ENOENT;
+		pr_err("wrong table version\n");
+		goto done;
+	}
+
+	iotype = table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY ?
+			"mmio" : "io";
+
+	switch (table->interface_type) {
+	case ACPI_DBG2_ARM_SBSA_32BIT:
+		iotype = "mmio32";
+		/* fall through */
+	case ACPI_DBG2_ARM_PL011:
+	case ACPI_DBG2_ARM_SBSA_GENERIC:
+	case ACPI_DBG2_BCM2835:
+		uart = "pl011";
+		break;
+	case ACPI_DBG2_16550_COMPATIBLE:
+	case ACPI_DBG2_16550_SUBSET:
+		uart = "uart";
+		break;
+	default:
+		err = -ENOENT;
+		goto done;
+	}
+
+	switch (table->baud_rate) {
+	case 3:
+		baud_rate = 9600;
+		break;
+	case 4:
+		baud_rate = 19200;
+		break;
+	case 6:
+		baud_rate = 57600;
+		break;
+	case 7:
+		baud_rate = 115200;
+		break;
+	default:
+		err = -ENOENT;
+		goto done;
+	}
+
+	snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
+		 table->serial_port.address, baud_rate);
+
+	pr_info("console: %s", opts);
+
+	if (earlycon)
+		setup_earlycon(opts);
+
+	err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
+
+done:
+	early_acpi_os_unmap_memory((void __iomem *)table, table_size);
+	return err;
+}
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 7aae655..ea00b9f 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -21,6 +21,7 @@
 #include <linux/sizes.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/acpi.h>
 
 #ifdef CONFIG_FIX_EARLYCON_MEM
 #include <asm/fixmap.h>
@@ -199,6 +200,14 @@ int __init setup_earlycon(char *buf)
 	return -ENOENT;
 }
 
+/*
+ * When CONFIG_ACPI_SPCR_TABLE is defined, "earlycon" without parameters in
+ * command line does not start DT earlycon immediately, instead it defers
+ * starting it until DT/ACPI decision is made.  At that time if ACPI is enabled
+ * call parse_spcr(), else call early_init_dt_scan_chosen_stdout()
+ */
+bool earlycon_init_is_deferred __initdata;
+
 /* early_param wrapper for setup_earlycon() */
 static int __init param_setup_earlycon(char *buf)
 {
@@ -208,8 +217,14 @@ static int __init param_setup_earlycon(char *buf)
 	 * Just 'earlycon' is a valid param for devicetree earlycons;
 	 * don't generate a warning from parse_early_params() in that case
 	 */
-	if (!buf || !buf[0])
-		return early_init_dt_scan_chosen_stdout();
+	if (!buf || !buf[0]) {
+		if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE)) {
+			earlycon_init_is_deferred = true;
+			return 0;
+		} else {
+			return early_init_dt_scan_chosen_stdout();
+		}
+	}
 
 	err = setup_earlycon(buf);
 	if (err == -ENOENT || err == -EALREADY)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 288fac5..1de43be 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -997,4 +997,10 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 #define acpi_probe_device_table(t)	({ int __r = 0; __r;})
 #endif
 
+#ifdef CONFIG_ACPI_SPCR_TABLE
+int parse_spcr(bool earlycon);
+#else
+static inline int parse_spcr(bool earlycon) { return 0; }
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a3d7c0d..60b6143 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -366,6 +366,12 @@ extern int of_setup_earlycon(const struct earlycon_id *match,
 			     unsigned long node,
 			     const char *options);
 
+#ifdef CONFIG_SERIAL_EARLYCON
+extern bool earlycon_init_is_deferred __initdata;
+#else
+static const bool earlycon_init_is_deferred;
+#endif
+
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
 int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
-- 
2.8.2
