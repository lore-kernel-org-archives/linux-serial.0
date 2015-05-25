From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH 1/1] serial: earlycon: Add support for big-endian MMIO accesses
Date: Mon, 25 May 2015 06:54:28 +0300
Message-ID: <1432526068-22820-1-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
Cc: vgupta@synopsys.com, giladb@ezchip.com, cmetcalf@ezchip.com, cernekee@gmail.com, robh@kernel.org, peter@hurleysoftware.com, gregkh@linuxfoundation.org, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

Support command line parameters of the form:
earlycon=<name>,io|mmio|mmio32|mmio32be,<addr>,<options>

This commit seem to be needed even after commit:
serial: 8250: Add support for big-endian MMIO accesses
c627f2ceb692e8a9358b64ac2d139314e7bb0d17

Signed-off-by: Noam Camus <noamc@ezchip.com>
---
 Documentation/kernel-parameters.txt |    9 +++++----
 drivers/tty/serial/earlycon.c       |    9 ++++++---
 drivers/tty/serial/serial_core.c    |    7 +++++--
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 61ab162..55bb093 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -959,14 +959,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		uart[8250],io,<addr>[,options]
 		uart[8250],mmio,<addr>[,options]
 		uart[8250],mmio32,<addr>[,options]
+		uart[8250],mmio32be,<addr>[,options]
 		uart[8250],0x<addr>[,options]
 			Start an early, polled-mode console on the 8250/16550
 			UART at the specified I/O port or MMIO address.
 			MMIO inter-register address stride is either 8-bit
-			(mmio) or 32-bit (mmio32).
-			If none of [io|mmio|mmio32], <addr> is assumed to be
-			equivalent to 'mmio'. 'options' are specified in the
-			same format described for "console=ttyS<n>"; if
+			(mmio) or 32-bit (mmio32 or mmio32be).
+			If none of [io|mmio|mmio32|mmio32be], <addr> is assumed
+			to be equivalent to 'mmio'. 'options' are specified
+			in the same format described for "console=ttyS<n>"; if
 			unspecified, the h/w is not initialized.
 
 		pl011,<addr>
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 5fdc9f3..a840732 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -72,6 +72,7 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 
 	switch (port->iotype) {
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 		port->regshift = 2;	/* fall-through */
 	case UPIO_MEM:
 		port->mapbase = addr;
@@ -90,9 +91,11 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 		strlcpy(device->options, options, length);
 	}
 
-	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
+	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32 ||
+	    port->iotype == UPIO_MEM32BE)
 		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
-			(port->iotype == UPIO_MEM32) ? "32" : "",
+			(port->iotype == UPIO_MEM) ? "" :
+			(port->iotype == UPIO_MEM32) ? "32" : "32be",
 			(unsigned long long)port->mapbase,
 			device->options);
 	else
@@ -133,7 +136,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
  *
  *	Registers the earlycon console matching the earlycon specified
  *	in the param string @buf. Acceptable param strings are of the form
- *	   <name>,io|mmio|mmio32,<addr>,<options>
+ *	   <name>,io|mmio|mmio32|mmio32be,<addr>,<options>
  *	   <name>,0x<addr>,<options>
  *	   <name>,<options>
  *	   <name>
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0b7bb12..1124090 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1816,8 +1816,8 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
  *	@options: ptr for <options> field; NULL if not present (out)
  *
  *	Decodes earlycon kernel command line parameters of the form
- *	   earlycon=<name>,io|mmio|mmio32,<addr>,<options>
- *	   console=<name>,io|mmio|mmio32,<addr>,<options>
+ *	   earlycon=<name>,io|mmio|mmio32|mmio32be,<addr>,<options>
+ *	   console=<name>,io|mmio|mmio32|mmio32be,<addr>,<options>
  *
  *	The optional form
  *	   earlycon=<name>,0x<addr>,<options>
@@ -1835,6 +1835,9 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
 	} else if (strncmp(p, "mmio32,", 7) == 0) {
 		*iotype = UPIO_MEM32;
 		p += 7;
+	} else if (strncmp(p, "mmio32be,", 9) == 0) {
+		*iotype = UPIO_MEM32BE;
+		p += 9;
 	} else if (strncmp(p, "io,", 3) == 0) {
 		*iotype = UPIO_PORT;
 		p += 3;
-- 
1.7.1

