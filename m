From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v11 4/4] serial: pl011: add console matching function
Date: Tue, 27 Sep 2016 23:54:15 +0300
Message-ID: <20160927205418.31529-4-aleksey.makarov@linaro.org>
References: <20160927151953.GB4371@kroah.com>
 <20160927205418.31529-1-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160927205418.31529-1-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

This patch adds function pl011_console_match() that implements
method match of struct console.  It allows to match consoles against
data specified in a string, for example taken from command line or
compiled by ACPI SPCR table handler.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Tested-by: Christopher Covington <cov@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8a9e213..2f9af8a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2288,12 +2288,67 @@ static int __init pl011_console_setup(struct console *co, char *options)
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
+	unsigned long addr;
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
2.10.0

