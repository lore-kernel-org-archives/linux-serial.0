From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2] earlycon: 8250: Fix command line regression
Date: Fri,  3 Apr 2015 20:04:35 -0400
Message-ID: <1428105875-4038-1-git-send-email-peter@hurleysoftware.com>
References: <1428102229-26103-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428102229-26103-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>, Yinghai Lu <yinghai@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Restore undocumented behavior of kernel command line parameters of
the forms:
    console=uart[8250],io|mmio|mmio32,<addr>[,options]
    console=uart[8250],<addr>[,options]
where 'options' have not been specified; in this case, the hardware
is assumed to be initialized.

Document the required behavior of the original implementation.

Reported-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---

v2: Fixed regression which allowed "console=uart1337,..." to start a
    console (but not an earlycon)
  + fixed earlycon= documentation related required behavior fixed by
    this patch

 Documentation/kernel-parameters.txt  | 18 +++++++++++++++---
 drivers/tty/serial/8250/8250_core.c  | 20 ++++++++++++++++++--
 drivers/tty/serial/8250/8250_early.c | 19 -------------------
 3 files changed, 33 insertions(+), 24 deletions(-)

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
index e0fb5f0..bda2a57 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3455,13 +3455,18 @@ static int univ8250_console_setup(struct console *co, char *options)
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
@@ -3475,6 +3480,9 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 	if (strncmp(name, match, 4) != 0)
 		return -ENODEV;
 
+	if (idx && idx != 8250)
+		return -ENODEV;
+
 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
 		return -ENODEV;
 
@@ -3491,6 +3499,14 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
+
+		/* if no line settings, then assume h/w was setup */
+		if (!options) {
+			/* link port to console */
+			port->cons = co;
+			return 0;
+		}
+
 		return univ8250_console_setup(co, options);
 	}
 
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
