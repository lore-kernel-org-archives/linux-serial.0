From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v7 5/5] serial: pl011: add console matching function
Date: Thu, 31 Mar 2016 16:40:27 +0300
Message-ID: <1459431629-27934-6-git-send-email-aleksey.makarov@linaro.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

This patch adds function pl011_console_match() that implements
method match of struct console.  It allows to match consoles against
data specified in a string, for example taken from command line or
compiled by ACPI SPCR table handler.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7c198e0..4139b64 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2287,12 +2287,68 @@ static int __init pl011_console_setup(struct console *co, char *options)
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
+	char match[] = "pl011";	/* pl011-specific earlycon name */
+	unsigned char iotype;
+	unsigned long addr;
+	int i;
+
+	if (strncmp(name, match, 5) != 0)
+		return -ENODEV;
+
+	if (uart_parse_earlycon(options, &iotype, &addr, &options))
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
+		if (port->iotype != iotype)
+			continue;
+		if ((iotype == UPIO_MEM || iotype == UPIO_MEM32) &&
+		    (port->mapbase != addr))
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
2.7.4

