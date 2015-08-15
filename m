From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCHv3] serial: don't register CIR serial ports
Date: Sat, 15 Aug 2015 19:25:35 +0200
Message-ID: <55CF760F.50303@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

CIR type serial ports aren't real serial ports.

This is just a way to prevent legacy 8250 serial
driver from probing and eventually binding some
resources.

Since in current state such ports aren't providing
any real functionality and it is not possible
to change their type via setserial/ioctl(TIOCSSERIAL)
(due to UPF_FIXED_PORT flag set on them)
it is simpler and cleaner to not register them at all
with serial core.

Print a short message in this case so it is known
to user what has happened.

This way checks for PORT_8250_CIR in serial port
callbacks can be removed too, since they won't
ever be called.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
This replaces "serial: don't announce CIR serial ports"
submission.

Changes from v1: print message using dev_info().

Changes from v2: added specific code in
serial8250_register_ports() regarding not adding
PORT_8250_CIR-type ports, updated to changes in
tty-testing branch.

 drivers/tty/serial/8250/8250_core.c | 26 ++++++++++++++++++++------
 drivers/tty/serial/8250/8250_port.c | 14 +-------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index cfbb9d7..2308ff8 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -569,6 +569,9 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		if (up->port.type == PORT_8250_CIR)
+			continue;
+
 		if (up->port.dev)
 			continue;
 
@@ -1027,13 +1030,24 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (up->dl_write)
 			uart->dl_write = up->dl_write;
 
-		if (serial8250_isa_config != NULL)
-			serial8250_isa_config(0, &uart->port,
-					&uart->capabilities);
+		if (uart->port.type != PORT_8250_CIR) {
+			if (serial8250_isa_config != NULL)
+				serial8250_isa_config(0, &uart->port,
+						&uart->capabilities);
+
+			ret = uart_add_one_port(&serial8250_reg,
+						&uart->port);
+			if (ret == 0)
+				ret = uart->port.line;
+		} else {
+			dev_info(uart->port.dev,
+				"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
+				uart->port.iobase,
+				(unsigned long long)uart->port.mapbase,
+				uart->port.irq);
 
-		ret = uart_add_one_port(&serial8250_reg, &uart->port);
-		if (ret == 0)
-			ret = uart->port.line;
+			ret = 0;
+		}
 	}
 	mutex_unlock(&serial_mutex);
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 54e6c8d..138a36f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1799,9 +1799,6 @@ int serial8250_do_startup(struct uart_port *port)
 	unsigned char lsr, iir;
 	int retval;
 
-	if (port->type == PORT_8250_CIR)
-		return -ENODEV;
-
 	if (!port->fifosize)
 		port->fifosize = uart_config[port->type].fifo_size;
 	if (!up->tx_loadsz)
@@ -2505,14 +2502,8 @@ static void serial8250_release_port(struct uart_port *port)
 static int serial8250_request_port(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	int ret;
-
-	if (port->type == PORT_8250_CIR)
-		return -ENODEV;
 
-	ret = serial8250_request_std_resource(up);
-
-	return ret;
+	return serial8250_request_std_resource(up);
 }
 
 static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
@@ -2660,9 +2651,6 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	int ret;
 
-	if (port->type == PORT_8250_CIR)
-		return;
-
 	/*
 	 * Find the region that we can probe for.  This in turn
 	 * tells us whether we can probe for the type of port.
