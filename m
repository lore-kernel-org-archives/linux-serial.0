From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v6] earlycon: 8250: Fix command line regression
Date: Mon,  6 Apr 2015 10:48:49 -0400
Message-ID: <1428331729-21679-1-git-send-email-peter@hurleysoftware.com>
References: <1428245532-1523-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428245532-1523-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Yinghai Lu <yinghai@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Restore undocumented behavior of kernel command line parameters of
the forms:
    console=uart[8250],io|mmio|mmio32,<addr>[,options]
    console=uart[8250],<addr>[,options]
where 'options' have not been specified; in this case, the hardware
is assumed to be initialized.

Fixes: c7cef0a84912cab3c9df8 ("console: Add extensible console matching")
Reported-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
v6: Removed documentation
  + removed unnecessary checks; this fix does not attempt to replicate
    the _exact_ original behavior, but only the reported breakage.

v5: Refactored serial8250_console_setup() & univ8250_console_setup()
    to eliminate open-coding; net +1 LOC (excludes documentation)

v4: Removed FIXME comment

v3: Fixed automatic console to port line settings initialization;
    open-coded serial8250_console_setup() so the baud can be probed;
    added sha reference in commit log

v2: Fixed regression which allowed "console=uart1337,..." to start a
    console (but not an earlycon)
  + fixed earlycon= documentation related required behavior fixed by
    this patch

 drivers/tty/serial/8250/8250_core.c  | 31 ++++++++++++++++++++++++-------
 drivers/tty/serial/8250/8250_early.c | 19 -------------------
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e0fb5f0..18142ee 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3412,9 +3412,23 @@ static void univ8250_console_write(struct console *co, const char *s,
 	serial8250_console_write(up, s, count);
 }
 
-static int serial8250_console_setup(struct uart_8250_port *up, char *options)
+static unsigned int probe_baud(struct uart_port *port)
+{
+	unsigned char lcr, dll, dlm;
+	unsigned int quot;
+
+	lcr = serial_port_in(port, UART_LCR);
+	serial_port_out(port, UART_LCR, lcr | UART_LCR_DLAB);
+	dll = serial_port_in(port, UART_DLL);
+	dlm = serial_port_in(port, UART_DLM);
+	serial_port_out(port, UART_LCR, lcr);
+
+	quot = (dlm << 8) | dll;
+	return (port->uartclk / 16) / quot;
+}
+
+static int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 {
-	struct uart_port *port = &up->port;
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
@@ -3425,13 +3439,15 @@ static int serial8250_console_setup(struct uart_8250_port *up, char *options)
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else if (probe)
+		baud = probe_baud(port);
 
 	return uart_set_options(port, port->cons, baud, parity, bits, flow);
 }
 
 static int univ8250_console_setup(struct console *co, char *options)
 {
-	struct uart_8250_port *up;
+	struct uart_port *port;
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
@@ -3440,11 +3456,11 @@ static int univ8250_console_setup(struct console *co, char *options)
 	 */
 	if (co->index >= nr_uarts)
 		co->index = 0;
-	up = &serial8250_ports[co->index];
+	port = &serial8250_ports[co->index].port;
 	/* link port to console */
-	up->port.cons = co;
+	port->cons = co;
 
-	return serial8250_console_setup(up, options);
+	return serial8250_console_setup(port, options, false);
 }
 
 /**
@@ -3491,7 +3507,8 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
-		return univ8250_console_setup(co, options);
+		port->cons = co;
+		return serial8250_console_setup(port, options, true);
 	}
 
 	return -ENODEV;
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index e95ebfe..8e11968 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -105,21 +105,6 @@ static void __init early_serial8250_write(struct console *console,
 		serial8250_early_out(port, UART_IER, ier);
 }
 
-static unsigned int __init probe_baud(struct uart_port *port)
-{
-	unsigned char lcr, dll, dlm;
-	unsigned int quot;
-
-	lcr = serial8250_early_in(port, UART_LCR);
-	serial8250_early_out(port, UART_LCR, lcr | UART_LCR_DLAB);
-	dll = serial8250_early_in(port, UART_DLL);
-	dlm = serial8250_early_in(port, UART_DLM);
-	serial8250_early_out(port, UART_LCR, lcr);
-
-	quot = (dlm << 8) | dll;
-	return (port->uartclk / 16) / quot;
-}
-
 static void __init init_port(struct earlycon_device *device)
 {
 	struct uart_port *port = &device->port;
@@ -151,10 +136,6 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
 		struct uart_port *port = &device->port;
 		unsigned int ier;
 
-		device->baud = probe_baud(&device->port);
-		snprintf(device->options, sizeof(device->options), "%u",
-			 device->baud);
-
 		/* assume the device was initialized, only mask interrupts */
 		ier = serial8250_early_in(port, UART_IER);
 		serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
-- 
2.3.5
