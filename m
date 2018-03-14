From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 3/3] serial: core: Allow skipping old serial port initialization
Date: Tue, 13 Mar 2018 18:36:55 -0600
Message-ID: <20180314003655.12141-4-djkurtz@chromium.org>
References: <20180314003655.12141-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314003655.12141-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: adurbin@chromium.org, Daniel Kurtz <djkurtz@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matthias Brugger <mbrugger@suse.com>, Vignesh R <vigneshr@ti.com>, Kees Cook <keescook@chromium.org>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Matt Redfearn <matt.redfearn@mips.com>, Douglas Anderson <dianders@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

The old_serial_port global array in 8250_core is supposed to hold an entry
for each serial port on the system that cannot be discovered via a
standard enumeration mechanism (aka ACPI/PCI/DTS).  The array is populated
at compile-time from the value specified in the SERIAL_PORT_DFNS macro.
This macro is defined in arch/serial.h.

For x86, this macro is currently unconditionally initialized to supply
four ioport UARTs (0x3F8, 0x2F8, 0x3E8, 0x2E8).

However, not all x86 CPUs have these four ioport UARTs.  For example, the
UARTs on AMD Carrizo and later are separate memory mapped Designware IP
blocks.

Fairly early in boot the console_initcall univ8250_console_init iterates
over this array and installs these old UARTs into the global array
serial8250_ports.  Further, it attempts to register them for use as
the console.  In other words, if, for example, the kernel commandline has
console=ttyS0, the console will be switched over to one of these
non-existent UARTs.  Only later, when the real UART drivers are probed
and their devices are instantiated will the console switch back over to
the proper UART.

This is most noticeable when using earlycon, since part of the serial
console log will appear to disappear (when the bogus old takes over) and
then re-appear (when the real UART finally gets registered for the
console).

Create a global variable to allow skipping old serial port initialization
and wire it up to the special amdcz earlycon setup handler.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/tty/serial/8250/8250_core.c  | 6 ++++++
 drivers/tty/serial/8250/8250_early.c | 1 +
 include/linux/serial_8250.h          | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..91ee206096f1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -66,6 +66,9 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
 #define SERIAL_PORT_DFNS
 #endif
 
+bool skip_old_serial_ports;
+EXPORT_SYMBOL(skip_old_serial_ports);
+
 static const struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
@@ -537,6 +540,9 @@ static void __init serial8250_isa_init_ports(void)
 	if (share_irqs)
 		irqflag = IRQF_SHARED;
 
+	if (skip_old_serial_ports)
+		return;
+
 	for (i = 0, up = serial8250_ports;
 	     i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
 	     i++, up++) {
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index c6bf971a6038..8511b8e25b3f 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -202,6 +202,7 @@ static int __init early_amdcz_setup(struct earlycon_device *dev,
 {
 	struct uart_port *port = &dev->port;
 
+	skip_old_serial_ports = true;
 	port->uartclk = 48000000;
 
 	return early_serial8250_setup(dev, opt);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a27ef5f56431..cb6fd144529c 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -146,6 +146,8 @@ void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
 
+extern bool skip_old_serial_ports;
+
 extern int early_serial_setup(struct uart_port *port);
 
 extern int early_serial8250_setup(struct earlycon_device *device,
-- 
2.16.2.804.g6dcf76e118-goog
