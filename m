From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 3/3] serial: pl011: add acpi_match for amba-pl011.c
Date: Mon, 25 Jan 2016 17:45:23 +0600
Message-ID: <1453722324-22407-4-git-send-email-aleksey.makarov@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Jiri Slaby <jslaby@suse.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, devel@acpica.org
List-Id: linux-serial@vger.kernel.org

Add an implementation of acpi_match() to the pl011 driver.
It allows to check if the console matches one specified with
ACPI SPCR table.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 14 ++++++++++++++
 include/acpi/actbl2.h           |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 899a771..3f4aa1b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2189,12 +2189,26 @@ static int __init pl011_console_setup(struct console *co, char *options)
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
 
+static int __init pl011_console_acpi_match(struct console *co,
+					   struct acpi_table_spcr *spcr)
+{
+	struct uart_amba_port *uap = amba_ports[co->index];
+
+	if (spcr->interface_type == ACPI_DBG2_ARM_PL011 &&
+	    spcr->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY &&
+	    spcr->serial_port.address == (u64)uap->port.mapbase)
+		return 0;
+
+	return -ENODEV;
+}
+
 static struct uart_driver amba_reg;
 static struct console amba_console = {
 	.name		= "ttyAMA",
 	.write		= pl011_console_write,
 	.device		= uart_console_device,
 	.setup		= pl011_console_setup,
+	.acpi_match	= pl011_console_acpi_match,
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 	.data		= &amba_reg,
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 6e28f54..ce4cb37 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -371,6 +371,10 @@ struct acpi_dbg2_device {
 
 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_ARM_PL011         0x0003
+#define ACPI_DBG2_ARM_SBSA_GENERIC  0x000e
+#define ACPI_DBG2_ARM_DCC           0x000f
+#define ACPI_DBG2_DCM2835           0x0010
 
 #define ACPI_DBG2_1394_STANDARD     0x0000
 
-- 
2.7.0

