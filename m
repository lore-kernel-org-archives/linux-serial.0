From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5] earlycon: 8250: Fix command line regression
Date: Sun,  5 Apr 2015 10:52:12 -0400
Message-ID: <1428245532-1523-1-git-send-email-peter@hurleysoftware.com>
References: <1428167961-26841-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428167961-26841-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Yinghai Lu <yinghai@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Restore undocumented behavior of kernel command line parameters of
the forms:
    console=uart[8250],io|mmio|mmio32,<addr>[,options]
    console=uart[8250],<addr>[,options]
where 'options' have not been specified; in this case, the hardware
is assumed to be initialized.

Document the required behavior of the original implementation.

Fixes: c7cef0a84912cab3c9df8 ("console: Add extensible console matching")
Reported-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
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

 Documentation/kernel-parameters.txt  | 18 ++++++++++++---
 drivers/tty/serial/8250/8250_core.c  | 45 ++++++++++++++++++++++++++++--------
 drivers/tty/serial/8250/8250_early.c | 19 ---------------
 3 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index bfcb1a6..1facf0b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -713,10 +713,18 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 		uart[8250],io,<addr>[,options]
 		uart[8250],mmio,<addr>[,options]
+		uart[8250],mmio32,<addr>[,options]
+		uart[8250],0x<addr>[,options]
 			Start an early, polled-mode console on the 8250/16550
 			UART at the specified I/O port or MMIO address,
-			switching to the matching ttyS device later.  The
-			options are the same as for ttyS, above.
+			switching to the matching ttyS device later.
+			MMIO inter-register address stride is either 8-bit
+			(mmio) or 32-bit (mmio32).
+			If none of [io|mmio|mmio32], <addr> is assumed to be
+			equivalent to 'mmio'. 'options' are specified in the
+			same format described for ttyS above; if unspecified,
+			the h/w is not re-initialized.
+
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
 
@@ -944,11 +952,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		uart[8250],io,<addr>[,options]
 		uart[8250],mmio,<addr>[,options]
 		uart[8250],mmio32,<addr>[,options]
+		uart[8250],0x<addr>[,options]
 			Start an early, polled-mode console on the 8250/16550
 			UART at the specified I/O port or MMIO address.
 			MMIO inter-register address stride is either 8-bit
 			(mmio) or 32-bit (mmio32).
-			The options are the same as for ttyS, above.
+			If none of [io|mmio|mmio32], <addr> is assumed to be
+			equivalent to 'mmio'. 'options' are specified in the
+			same format described for "console=ttyS<n>"; if
+			unspecified, the h/w is not initialized.
 
 		pl011,<addr>
 			Start an early, polled-mode console on a pl011 serial
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e0fb5f0..f8c27de 100644
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
@@ -3423,15 +3437,17 @@ static int serial8250_console_setup(struct uart_8250_port *up, char *options)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
-	if (options)
+	if (options && (!probe || *options))
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
@@ -3455,13 +3471,18 @@ static int univ8250_console_setup(struct console *co, char *options)
  *	@options: ptr to option string from console command line
  *
  *	Only attempts to match console command lines of the form:
- *	    console=uart<>,io|mmio|mmio32,<addr>,<options>
- *	    console=uart<>,<addr>,options
+ *	    console=uart[8250],io|mmio|mmio32,<addr>[,<options>]
+ *	    console=uart[8250],0x<addr>[,<options>]
  *	This form is used to register an initial earlycon boot console and
  *	replace it with the serial8250_console at 8250 driver init.
  *
  *	Performs console setup for a match (as required by interface)
  *
+ *	** HACK ALERT **
+ *	If no <options> are specified, then assume the h/w is already setup.
+ *	This was the undocumented behavior of the original implementation so
+ *	it is cast in stone forever.
+ *
  *	Returns 0 if console matches; otherwise non-zero to use default matching
  */
 static int univ8250_console_match(struct console *co, char *name, int idx,
@@ -3475,6 +3496,9 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 	if (strncmp(name, match, 4) != 0)
 		return -ENODEV;
 
+	if (idx && idx != 8250)
+		return -ENODEV;
+
 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
 		return -ENODEV;
 
@@ -3491,7 +3515,8 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
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
