From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 01/13] serial: earlycon: Refactor parse_options into serial core
Date: Tue, 24 Feb 2015 11:36:58 -0500
Message-ID: <1424795830-31223-2-git-send-email-peter@hurleysoftware.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Prepare to support console-defined matching; refactor the command
line parameter string processing from parse_options() into a
new core function, uart_parse_earlycon(), which decodes command line
parameters of the form:
   earlycon=<name>,io|mmio|mmio32,<addr>,<options>
   console=<name>,io|mmio|mmio32,<addr>,<options>
   earlycon=<name>,0x<addr>,<options>
   console=<name>,0x<addr>,<options>

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/earlycon.c    | 39 ++++++++++++----------------------
 drivers/tty/serial/serial_core.c | 46 ++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h      |  2 ++
 3 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 64fe25a..58d6bcd 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -54,44 +54,31 @@ static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
 	return base;
 }
 
-static int __init parse_options(struct earlycon_device *device,
-				char *options)
+static int __init parse_options(struct earlycon_device *device, char *options)
 {
 	struct uart_port *port = &device->port;
-	int mmio, mmio32, length;
+	int length;
 	unsigned long addr;
 
-	if (!options)
-		return -ENODEV;
+	if (uart_parse_earlycon(options, &port->iotype, &addr, &options))
+		return -EINVAL;
 
-	mmio = !strncmp(options, "mmio,", 5);
-	mmio32 = !strncmp(options, "mmio32,", 7);
-	if (mmio || mmio32) {
-		port->iotype = (mmio ? UPIO_MEM : UPIO_MEM32);
-		options += mmio ? 5 : 7;
-		addr = simple_strtoul(options, NULL, 0);
+	switch (port->iotype) {
+	case UPIO_MEM32:
+		port->regshift = 2;	/* fall-through */
+	case UPIO_MEM:
 		port->mapbase = addr;
-		if (mmio32)
-			port->regshift = 2;
-	} else if (!strncmp(options, "io,", 3)) {
-		port->iotype = UPIO_PORT;
-		options += 3;
-		addr = simple_strtoul(options, NULL, 0);
+		break;
+	case UPIO_PORT:
 		port->iobase = addr;
-		mmio = 0;
-	} else if (!strncmp(options, "0x", 2)) {
-		port->iotype = UPIO_MEM;
-		addr = simple_strtoul(options, NULL, 0);
-		port->mapbase = addr;
-	} else {
+		break;
+	default:
 		return -EINVAL;
 	}
 
 	port->uartclk = BASE_BAUD * 16;
 
-	options = strchr(options, ',');
 	if (options) {
-		options++;
 		device->baud = simple_strtoul(options, NULL, 0);
 		length = min(strcspn(options, " ") + 1,
 			     (size_t)(sizeof(device->options)));
@@ -100,7 +87,7 @@ static int __init parse_options(struct earlycon_device *device,
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
 		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
-			mmio32 ? "32" : "",
+			(port->iotype == UPIO_MEM32) ? "32" : "",
 			(unsigned long long)port->mapbase,
 			device->options);
 	else
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6a1055a..3f823c26 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1810,6 +1810,52 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
 }
 
 /**
+ *	uart_parse_earlycon - Parse earlycon options
+ *	@p:	  ptr to 2nd field (ie., just beyond '<name>,')
+ *	@iotype:  ptr for decoded iotype (out)
+ *	@addr:    ptr for decoded mapbase/iobase (out)
+ *	@options: ptr for <options> field; NULL if not present (out)
+ *
+ *	Decodes earlycon kernel command line parameters of the form
+ *	   earlycon=<name>,io|mmio|mmio32,<addr>,<options>
+ *	   console=<name>,io|mmio|mmio32,<addr>,<options>
+ *
+ *	The optional form
+ *	   earlycon=<name>,0x<addr>,<options>
+ *	   console=<name>,0x<addr>,<options>
+ *	is also accepted; the returned @iotype will be UPIO_MEM.
+ *
+ *	Returns 0 on success or -EINVAL on failure
+ */
+int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
+			char **options)
+{
+	if (strncmp(p, "mmio,", 5) == 0) {
+		*iotype = UPIO_MEM;
+		p += 5;
+	} else if (strncmp(p, "mmio32,", 7) == 0) {
+		*iotype = UPIO_MEM32;
+		p += 7;
+	} else if (strncmp(p, "io,", 3) == 0) {
+		*iotype = UPIO_PORT;
+		p += 3;
+	} else if (strncmp(p, "0x", 2) == 0) {
+		*iotype = UPIO_MEM;
+	} else {
+		return -EINVAL;
+	}
+
+	*addr = simple_strtoul(p, NULL, 0);
+	p = strchr(p, ',');
+	if (p)
+		p++;
+
+	*options = p;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uart_parse_earlycon);
+
+/**
  *	uart_parse_options - Parse serial port baud/parity/bits/flow control.
  *	@options: pointer to option string
  *	@baud: pointer to an 'int' variable for the baud rate.
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index baf3e1d..cc5c506 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -354,6 +354,8 @@ early_param("earlycon", name ## _setup_earlycon);
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
+int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
+			char **options);
 void uart_parse_options(char *options, int *baud, int *parity, int *bits,
 			int *flow);
 int uart_set_options(struct uart_port *port, struct console *co, int baud,
-- 
2.3.0
