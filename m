From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v4 4/4] serial: pl011: use ACPI SPCR to setup 32-bit access
Date: Mon, 29 Feb 2016 15:02:32 +0300
Message-ID: <1456747355-15692-5-git-send-email-aleksey.makarov@linaro.org>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Some implementations of ARM SBSA serial port hardware require that access
to the registers should be 32-bit.  Unfortunately, the only way for
the driver to tell if it's the case is to use the data from ACPI SPCR/DBG2
tables.  In this case the value of the 'Interface Type' field of the SPCR
table is ACPI_DBG2_ARM_SBSA_32BIT.

How this value is described in the DBG2 spec:
"(deprecated) ARM SBSA (2.x only) Generic UART supporting only
32-bit accesses"

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/spcr.c             | 22 ++++++++++++++++++++++
 drivers/tty/serial/amba-pl011.c |  2 ++
 include/linux/acpi.h            |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index c460cb1..f2e81af 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -18,6 +18,7 @@
 
 static char *options;
 static struct acpi_generic_address address;
+static bool sbsa_32_bit;
 
 static int __init parse_spcr_init(void)
 {
@@ -60,6 +61,7 @@ static int __init parse_spcr_init(void)
 	}
 
 	address = table->serial_port;
+	sbsa_32_bit = table->interface_type == ACPI_DBG2_ARM_SBSA_32BIT;
 
 done:
 	early_acpi_os_unmap_memory((void __iomem *)table, table_size);
@@ -114,3 +116,23 @@ bool acpi_console_check(struct uart_port *uport)
 
 	return false;
 }
+
+/**
+ * acpi_console_sbsa_32bit - Tell if SPCR specifies 32-bit SBSA.
+ *
+ * Some implementations of ARM SBSA serial port hardware require that access
+ * to the registers should be 32-bit.  Unfortunately, the only way for
+ * the driver to tell if it's the case is to use the data from ACPI SPCR/DBG2
+ * tables.  In this case the value of the 'Interface Type' field of the SPCR
+ * table is ACPI_DBG2_ARM_SBSA_32BIT.
+ *
+ * Return: true if access should be 32-bit wide.
+ */
+bool acpi_console_sbsa_32bit(void)
+{
+	if (acpi_disabled || parse_spcr() < 0)
+		return false;
+
+	return sbsa_32_bit;
+}
+EXPORT_SYMBOL(acpi_console_sbsa_32bit);
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 500232a..d9ca3a4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2541,6 +2541,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 		baudrate = 115200;
 	}
 
+	vendor_sbsa.access_32b = acpi_console_sbsa_32bit();
+
 	portnr = pl011_find_free_port();
 	if (portnr < 0)
 		return portnr;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ea0c297..da1eb23 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1007,11 +1007,16 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 struct uart_port;
 #ifdef CONFIG_ACPI_SPCR_TABLE
 bool acpi_console_check(struct uart_port *uport);
+bool acpi_console_sbsa_32bit(void);
 #else
 static inline bool acpi_console_check(struct uart_port *uport)
 {
 	return FALSE;
 }
+static inline bool acpi_console_sbsa_32bit(void)
+{
+	return false;
+}
 #endif
 
 #endif	/*_LINUX_ACPI_H*/
-- 
2.7.1
