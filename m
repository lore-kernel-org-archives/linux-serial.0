From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v4 1/4] ACPI: parse SPCR and enable matching console
Date: Mon, 29 Feb 2016 15:02:29 +0300
Message-ID: <1456747355-15692-2-git-send-email-aleksey.makarov@linaro.org>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

'ARM Server Base Boot Requiremets' [1] mentions SPCR (Serial Port
Console Redirection Table) [2] as a mandatory ACPI table that
specifies the configuration of serial console.

Parse this table and check if any registered console match the
description.  If it does, enable that console.

Introduce a new function acpi_console_check().  At the uart port
registration, this function checks if the ACPI SPCR table specifies
its argument of type struct uart_port to be a console
and if so calls add_preferred_console().

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[2] http://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/Kconfig             |   3 +
 drivers/acpi/Makefile            |   1 +
 drivers/acpi/spcr.c              | 116 +++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c |  14 ++++-
 include/linux/acpi.h             |  10 ++++
 5 files changed, 142 insertions(+), 2 deletions(-)
 create mode 100644 drivers/acpi/spcr.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 65fb483..5611eb6 100644
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
index 7395928..f70ae14 100644
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
index 0000000..c460cb1
--- /dev/null
+++ b/drivers/acpi/spcr.c
@@ -0,0 +1,116 @@
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
+static char *options;
+static struct acpi_generic_address address;
+
+static int __init parse_spcr_init(void)
+{
+	struct acpi_table_spcr *table;
+	acpi_size table_size;
+	acpi_status status;
+	int err = 0;
+
+	status = acpi_get_table_with_size(ACPI_SIG_SPCR, 0,
+					  (struct acpi_table_header **)&table,
+					  &table_size);
+
+	if (ACPI_FAILURE(status)) {
+		pr_err("could not get the table\n");
+		return -ENOENT;
+	}
+
+	if (table->header.revision < 2) {
+		err = -EINVAL;
+		pr_err("wrong table version\n");
+		goto done;
+	}
+
+	switch (table->baud_rate) {
+	case 3:
+		options = "9600";
+		break;
+	case 4:
+		options = "19200";
+		break;
+	case 6:
+		options = "57600";
+		break;
+	case 7:
+		options = "115200";
+		break;
+	default:
+		options = "";
+		break;
+	}
+
+	address = table->serial_port;
+
+done:
+	early_acpi_os_unmap_memory((void __iomem *)table, table_size);
+	return err;
+}
+
+/*
+ * This function calls __init parse_spcr_init() so it needs __ref.
+ * It is referenced by the arch_inicall() macros so it will be called
+ * at initialization and the 'parsed' variable will be set.
+ * So it's safe to make it __ref.
+ */
+static int __ref parse_spcr(void)
+{
+	static bool parsed;
+	static int parse_error;
+
+	if (!parsed) {
+		parse_error = parse_spcr_init();
+		parsed = true;
+	}
+
+	return parse_error;
+}
+
+arch_initcall(parse_spcr);
+
+/**
+ * acpi_console_check - Check if uart matches the console specified by SPCR.
+ *
+ * @uport:	uart port to check
+ *
+ * This function checks if the ACPI SPCR table specifies @uport to be a console
+ * and if so calls add_preferred_console()
+ *
+ * Return: a non-error value if the console matches.
+ */
+bool acpi_console_check(struct uart_port *uport)
+{
+	if (acpi_disabled || console_set_on_cmdline || parse_spcr() < 0)
+		return false;
+
+	if ((address.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY &&
+	     address.address == (u64)uport->mapbase) ||
+	    (address.space_id == ACPI_ADR_SPACE_SYSTEM_IO &&
+	     address.address == (u64)uport->iobase)) {
+		pr_info("adding preferred console [%s%d]\n", uport->cons->name,
+			uport->line);
+		add_preferred_console(uport->cons->name, uport->line, options);
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a126a60..459ab54 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -34,6 +34,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/acpi.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -2654,8 +2655,17 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 		spin_lock_init(&uport->lock);
 		lockdep_set_class(&uport->lock, &port_lock_key);
 	}
-	if (uport->cons && uport->dev)
-		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
+
+	/*
+	 * Support both open FW and ACPI access to console definitions.
+	 * Both of_console_check() and acpi_console_check() will call
+	 * add_preferred_console() if a console definition is found.
+	 */
+	if (uport->cons && uport->dev) {
+		if (!acpi_console_check(uport))
+			of_console_check(uport->dev->of_node, uport->cons->name,
+					 uport->line);
+	}
 
 	uart_configure_port(drv, state, uport);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..ea0c297 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1004,4 +1004,14 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 #define acpi_probe_device_table(t)	({ int __r = 0; __r;})
 #endif
 
+struct uart_port;
+#ifdef CONFIG_ACPI_SPCR_TABLE
+bool acpi_console_check(struct uart_port *uport);
+#else
+static inline bool acpi_console_check(struct uart_port *uport)
+{
+	return FALSE;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.7.1

