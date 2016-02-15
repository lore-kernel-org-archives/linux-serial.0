From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v3 2/5] ACPI: parse SPCR and enable matching console
Date: Mon, 15 Feb 2016 21:05:26 +0300
Message-ID: <1455559532-8305-3-git-send-email-aleksey.makarov@linaro.org>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>, Jiri Slaby <jslaby@suse.com>
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
 drivers/acpi/Kconfig             |  3 ++
 drivers/acpi/Makefile            |  1 +
 drivers/acpi/spcr.c              | 97 ++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c | 14 +++++-
 include/linux/acpi.h             | 10 +++++
 5 files changed, 123 insertions(+), 2 deletions(-)
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
index 346101c..708b143 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
+obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 
 # processor has its own "processor." module_param namespace
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
new file mode 100644
index 0000000..a1eca91
--- /dev/null
+++ b/drivers/acpi/spcr.c
@@ -0,0 +1,97 @@
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
+static int acpi_table_parse_spcr(int (*handler)(struct acpi_table_spcr *table,
+						void *data), void *data)
+{
+	struct acpi_table_spcr *table = NULL;
+	acpi_size table_size;
+	acpi_status status;
+	int err;
+
+	status = acpi_get_table_with_size(ACPI_SIG_SPCR, 0,
+					  (struct acpi_table_header **)&table,
+					  &table_size);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	err = handler(table, data);
+
+	early_acpi_os_unmap_memory(table, table_size);
+
+	return err;
+}
+
+static int spcr_table_handler_check(struct acpi_table_spcr *table, void *data)
+{
+	struct uart_port *uport = data;
+	char *options;
+
+	if (table->header.revision < 2)
+		return -EOPNOTSUPP;
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
+	if ((table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY &&
+	     table->serial_port.address == (u64)uport->mapbase) ||
+	    (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_IO &&
+	     table->serial_port.address == (u64)uport->iobase)) {
+		pr_info("adding preferred console [%s%d]\n", uport->cons->name,
+			uport->line);
+		add_preferred_console(uport->cons->name, uport->line, options);
+		return 1;
+
+	}
+
+	return 0;
+}
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
+	if (acpi_disabled || console_set_on_cmdline)
+		return false;
+
+	return acpi_table_parse_spcr(spcr_table_handler_check, uport) > 0;
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
