From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4.9-stable] serial: pl011: add console matching function
Date: Mon,  4 Jun 2018 15:16:12 +0200
Message-ID: <20180604131612.14407-1-ard.biesheuvel@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: leif.lindholm@linaro.org, graeme.gregory@linaro.org, gregkh@linuxfoundation.org, linux@armlinux.org.uk, jslaby@suse.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
List-Id: linux-serial@vger.kernel.org

From: Aleksey Makarov <aleksey.makarov@linaro.org>

Commit 10879ae5f12e9cab3c4e8e9504c1aaa8a033bde7 upstream.

This patch adds function pl011_console_match() that implements
method match of struct console.  It allows to match consoles against
data specified in a string, for example taken from command line or
compiled by ACPI SPCR table handler.

This patch was merged to tty-next but then reverted because of
conflict with

commit 46e36683f433 ("serial: earlycon: Extend earlycon command line option to support 64-bit addresses")

Now it is fixed.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Tested-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Please consider for v4.9-stable. It is the missing puzzle piece for SPCR
support on arm64 ACPI systems, which got merged for v4.9 [0]. Now that more
systems are becoming available to people working in the kernel community, it
turns out that v4.9 distro installers (e.g., Debian Stretch) won't work
unless you pass a 'console=' parameter explicitly, which is annoying.
Given that it was clearly the intent to include this code at the time,
I hope it will be considered for backporting.

[0] To quote the tty maintainer:

      Also in here is the long-suffering ACPI SPCR patchset, which was
      passed around from maintainer to maintainer like a hot-potato. Seems I
      was the sucker^Wlucky one. All of those patches have been acked by the
      various subsystem maintainers as well.

 drivers/tty/serial/amba-pl011.c | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index b42d7f1c9089..6b1863293fe1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2320,12 +2320,67 @@ static int __init pl011_console_setup(struct console *co, char *options)
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
 
+/**
+ *	pl011_console_match - non-standard console matching
+ *	@co:	  registering console
+ *	@name:	  name from console command line
+ *	@idx:	  index from console command line
+ *	@options: ptr to option string from console command line
+ *
+ *	Only attempts to match console command lines of the form:
+ *	    console=pl011,mmio|mmio32,<addr>[,<options>]
+ *	    console=pl011,0x<addr>[,<options>]
+ *	This form is used to register an initial earlycon boot console and
+ *	replace it with the amba_console at pl011 driver init.
+ *
+ *	Performs console setup for a match (as required by interface)
+ *	If no <options> are specified, then assume the h/w is already setup.
+ *
+ *	Returns 0 if console matches; otherwise non-zero to use default matching
+ */
+static int __init pl011_console_match(struct console *co, char *name, int idx,
+				      char *options)
+{
+	unsigned char iotype;
+	resource_size_t addr;
+	int i;
+
+	if (strcmp(name, "pl011") != 0)
+		return -ENODEV;
+
+	if (uart_parse_earlycon(options, &iotype, &addr, &options))
+		return -ENODEV;
+
+	if (iotype != UPIO_MEM && iotype != UPIO_MEM32)
+		return -ENODEV;
+
+	/* try to match the port specified on the command line */
+	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
+		struct uart_port *port;
+
+		if (!amba_ports[i])
+			continue;
+
+		port = &amba_ports[i]->port;
+
+		if (port->mapbase != addr)
+			continue;
+
+		co->index = i;
+		port->cons = co;
+		return pl011_console_setup(co, options);
+	}
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
+	.match		= pl011_console_match,
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 	.data		= &amba_reg,
-- 
2.17.0
