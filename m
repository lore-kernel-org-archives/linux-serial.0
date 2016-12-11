From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] tty: serial: lantiq: implement earlycon support
Date: Sun, 11 Dec 2016 21:42:23 +0100
Message-ID: <20161211204223.7906-1-martin.blumenstingl@googlemail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, corbet@lwn.net, jslaby@suse.com
Cc: linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, john@phrozen.org, hauke@hauke-m.de, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-serial@vger.kernel.org

This allows enabling earlycon for devices with a Lantiq serial console
by splitting lqasc_serial_port_write() from lqasc_console_write() and
re-using the new function for earlycon's write callback.

The kernel-parameter name matches the driver name ("lantiq"), similar
to how other drivers implement this.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/kernel-parameters.txt |  6 ++++++
 drivers/tty/serial/Kconfig          |  1 +
 drivers/tty/serial/lantiq.c         | 38 ++++++++++++++++++++++++++++++-------
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 37babf9..72fd841 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1156,6 +1156,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			serial port must already be setup and configured.
 			Options are not yet supported.
 
+		lantiq,<addr>
+			Start an early, polled-mode console on a lantiq serial
+			(lqasc) port at the specified address. The serial port
+			must already be setup and configured. Options are not
+			yet supported.
+
 		lpuart,<addr>
 		lpuart32,<addr>
 			Use early console provided by Freescale LP UART driver
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 25c1d7b..13e280d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1148,6 +1148,7 @@ config SERIAL_LANTIQ
 	depends on LANTIQ
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  Support for console and UART on Lantiq SoCs.
 
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index b88832e..7c9a3f2 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -590,13 +590,20 @@ lqasc_console_putchar(struct uart_port *port, int ch)
 	ltq_w8(ch, port->membase + LTQ_ASC_TBUF);
 }
 
+static void lqasc_serial_port_write(struct uart_port *port, const char *s,
+				    u_int count)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ltq_asc_lock, flags);
+	uart_console_write(port, s, count, lqasc_console_putchar);
+	spin_unlock_irqrestore(&ltq_asc_lock, flags);
+}
 
 static void
 lqasc_console_write(struct console *co, const char *s, u_int count)
 {
 	struct ltq_uart_port *ltq_port;
-	struct uart_port *port;
-	unsigned long flags;
 
 	if (co->index >= MAXPORTS)
 		return;
@@ -605,11 +612,7 @@ lqasc_console_write(struct console *co, const char *s, u_int count)
 	if (!ltq_port)
 		return;
 
-	port = &ltq_port->port;
-
-	spin_lock_irqsave(&ltq_asc_lock, flags);
-	uart_console_write(port, s, count, lqasc_console_putchar);
-	spin_unlock_irqrestore(&ltq_asc_lock, flags);
+	lqasc_serial_port_write(&ltq_port->port, s, count);
 }
 
 static int __init
@@ -659,6 +662,27 @@ lqasc_console_init(void)
 }
 console_initcall(lqasc_console_init);
 
+static void lqasc_serial_early_console_write(struct console *co,
+					     const char *s,
+					     u_int count)
+{
+	struct earlycon_device *dev = co->data;
+
+	lqasc_serial_port_write(&dev->port, s, count);
+}
+
+static int __init
+lqasc_serial_early_console_setup(struct earlycon_device *device,
+				 const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = lqasc_serial_early_console_write;
+	return 0;
+}
+OF_EARLYCON_DECLARE(lantiq, DRVNAME, lqasc_serial_early_console_setup);
+
 static struct uart_driver lqasc_reg = {
 	.owner =	THIS_MODULE,
 	.driver_name =	DRVNAME,
-- 
2.10.2

