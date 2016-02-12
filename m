From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v2 8/9] serial: 8250: add acpi_match
Date: Fri, 12 Feb 2016 20:43:39 +0300
Message-ID: <1455299022-11641-9-git-send-email-aleksey.makarov@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Mark Salter <msalter@redhat.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

From: Mark Salter <msalter@redhat.com>

Add an implementation of acpi_match() to the 8250 driver.
It allows console to check if it matches the console specified by
ACPI SPCR table.

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/tty/serial/8250/8250_core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 7775221..059338a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -40,6 +40,7 @@
 #ifdef CONFIG_SPARC
 #include <linux/sunserialcore.h>
 #endif
+#include <linux/acpi.h>
 
 #include <asm/irq.h>
 
@@ -669,12 +670,34 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 	return -ENODEV;
 }
 
+static int __init univ8250_console_acpi_match(struct console *co,
+					      struct acpi_table_spcr *spcr)
+{
+	int index = co->index >= 0 ? co->index : 0;
+	struct uart_port *port = &serial8250_ports[index].port;
+
+	if (spcr->interface_type != ACPI_DBG2_16550_SUBSET &&
+	    spcr->interface_type != ACPI_DBG2_16550_COMPATIBLE)
+		return -ENODEV;
+
+	if (spcr->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY &&
+	    spcr->serial_port.address == (u64)port->mapbase)
+		return 0;
+
+	if (spcr->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_IO &&
+	    spcr->serial_port.address == (u64)port->iobase)
+		return 0;
+
+	return -ENODEV;
+}
+
 static struct console univ8250_console = {
 	.name		= "ttyS",
 	.write		= univ8250_console_write,
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
 	.match		= univ8250_console_match,
+	.acpi_match	= univ8250_console_acpi_match,
 	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
 	.index		= -1,
 	.data		= &serial8250_reg,
-- 
2.7.0
