From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v2 7/9] serial: pl011: add acpi_match
Date: Fri, 12 Feb 2016 20:43:38 +0300
Message-ID: <1455299022-11641-8-git-send-email-aleksey.makarov@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Add an implementation of acpi_match() to the pl011 driver.
It allows console to check if it matches the console specified by
ACPI SPCR table.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Tested-by: Christopher Covington <cov@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 500232a..f613bff 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2285,12 +2285,34 @@ static int __init pl011_console_setup(struct console *co, char *options)
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
 
+static int __init pl011_console_acpi_match(struct console *co,
+					   struct acpi_table_spcr *spcr)
+{
+	struct uart_amba_port *uap = amba_ports[co->index < 0 ? 0 : co->index];
+
+	if (uap->vendor->access_32b) {
+		if (spcr->interface_type != ACPI_DBG2_ARM_SBSA_32BIT)
+			return -ENODEV;
+	} else {
+		if (spcr->interface_type != ACPI_DBG2_ARM_PL011 &&
+		    spcr->interface_type != ACPI_DBG2_ARM_SBSA_GENERIC)
+			return -ENODEV;
+	}
+
+	if (spcr->serial_port.space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY ||
+	    spcr->serial_port.address != (u64)uap->port.mapbase)
+		return -ENODEV;
+
+	return 0;
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
-- 
2.7.0

