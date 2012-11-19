From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: [PATCH] TTY: serial 8250: Support MCR CLK_SEL bit.
Date: Mon, 19 Nov 2012 09:54:21 +0100
Message-ID: <20121119085421.315.47347.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta1.parkeon.com ([91.121.43.66]:51266 "EHLO mta1.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088Ab2KSJPw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 04:15:52 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Some UARTs have an internal clock predivisor which can be /1 or /4.
The initial state is set by hardware at chip reset by an external CLK_SEL pin
but can be modified by software using the CLK_SEL bit in MCR.

Currently, on hardware where the CLK_SEL pin is set to /4, the baud rate used
by Linux is thus incorrect (4 times too slow).

Although it is possible to fix this just by changing the clock frequency passed
to the kernel this has two disadvantages:
    * The maximum attainable baud rate will be artificially low.
    * The DT or board file data no longer directly matches the schematic.

Hence this patch which:
    * Allows the CLK_SEL bit to be forced to /1, /4 or left as is.
    * Correctly calculates the effective uartclk according to this divisor

Tested using an Exar xr16c2850 UART.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 .../devicetree/bindings/tty/serial/of-serial.txt   |    2 +
 drivers/tty/serial/8250/8250.c                     |   60 ++++++++++++++++----
 drivers/tty/serial/8250/8250.h                     |    1 
 drivers/tty/serial/of_serial.c                     |    2 +
 include/linux/serial_8250.h                        |    2 +
 5 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
index ba385f2..b1c5f85 100644
--- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -27,6 +27,8 @@ Optional properties:
   RTAS and should not be registered.
 - no-loopback-test: set to indicate that the port does not implements loopback
   test mode
+ -clock-predivisor : predivisor for UARTs that support it (0,1 or 4)
+   0 => leave as determined by hardware pin.
 
 Example:
 
diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 3ba4234..caac065 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -216,7 +216,8 @@ static const struct serial8250_config uart_config[] = {
 		.fifo_size	= 128,
 		.tx_loadsz	= 128,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
-		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
+		.flags		= UART_CAP_FIFO | UART_CAP_EFR |
+				  UART_CAP_SLEEP | UART_CAP_CLKSEL,
 	},
 	[PORT_RSA] = {
 		.name		= "RSA",
@@ -572,21 +573,48 @@ EXPORT_SYMBOL_GPL(serial8250_clear_and_reinit_fifos);
  * capability" bit enabled.  Note that on XR16C850s, we need to
  * reset LCR to write to IER.
  */
+static void serial8250_enable_extended(struct uart_8250_port *p)
+{
+	if (p->capabilities & UART_CAP_EFR) {
+		serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(p, UART_EFR, UART_EFR_ECB);
+		serial_out(p, UART_LCR, 0);
+	}
+}
+
+static void serial8250_disable_extended(struct uart_8250_port *p)
+{
+	if (p->capabilities & UART_CAP_EFR) {
+		serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(p, UART_EFR, 0);
+		serial_out(p, UART_LCR, 0);
+	}
+}
+
 static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 {
 	if (p->capabilities & UART_CAP_SLEEP) {
-		if (p->capabilities & UART_CAP_EFR) {
-			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
-			serial_out(p, UART_EFR, UART_EFR_ECB);
-			serial_out(p, UART_LCR, 0);
-		}
+		serial8250_enable_extended(p);
 		serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
-		if (p->capabilities & UART_CAP_EFR) {
-			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
-			serial_out(p, UART_EFR, 0);
-			serial_out(p, UART_LCR, 0);
-		}
+		serial8250_disable_extended(p);
+	}
+}
+
+static int serial8250_configure_clock_predivisor(struct uart_8250_port *p)
+{
+	int value;
+
+	if (p->predivisor) { /* otherwise leave as set by hardware */
+		serial8250_enable_extended(p);
+		value = serial_in(p, UART_MCR);
+		value &= ~UART_MCR_CLKSEL;
+		if (p->predivisor > 1)
+			value |= UART_MCR_CLKSEL;
+		serial_out(p, UART_MCR, value);
+		serial8250_disable_extended(p);
 	}
+
+	return serial_in(p, UART_MCR) & UART_MCR_CLKSEL ? 4 : 1;
 }
 
 #ifdef CONFIG_SERIAL_8250_RSA
@@ -2617,6 +2645,15 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 		serial8250_release_rsa_resource(up);
 	if (port->type == PORT_UNKNOWN)
 		serial8250_release_std_resource(up);
+
+	if (up->capabilities & UART_CAP_CLKSEL) {
+		int div = serial8250_configure_clock_predivisor(up);
+
+		dev_info(port->dev, "Using /%d predivisor\n", div);
+		if (!up->hwclk)
+			up->hwclk = port->uartclk;
+		port->uartclk = up->hwclk / div;
+	}
 }
 
 static int
@@ -3173,6 +3210,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.iotype       = up->port.iotype;
 		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
 		uart->bugs		= up->bugs;
+		uart->predivisor	= up->predivisor;
 		uart->port.mapbase      = up->port.mapbase;
 		uart->port.private_data = up->port.private_data;
 		if (up->port.dev)
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 5a76f9c..01899db 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -40,6 +40,7 @@ struct serial8250_config {
 #define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
 #define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
 #define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
+#define UART_CAP_CLKSEL (1 << 14)	/* UART has clock select predivisor bit */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index df443b9..047f59c 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -154,6 +154,8 @@ static int __devinit of_platform_serial_probe(struct platform_device *ofdev)
 		struct uart_8250_port port8250;
 		memset(&port8250, 0, sizeof(port8250));
 		port8250.port = port;
+		of_property_read_u32(ofdev->dev.of_node,
+			"clock-predivisor", &port8250.predivisor);
 		ret = serial8250_register_8250_port(&port8250);
 		break;
 	}
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index c174c90..39bd8b9 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -73,6 +73,8 @@ struct uart_8250_port {
 	unsigned short		capabilities;	/* port capabilities */
 	unsigned short		bugs;		/* port bugs */
 	unsigned int		tx_loadsz;	/* transmit fifo load size */
+	unsigned int		predivisor;	/* 0=HW select */
+	unsigned long		hwclk;		/* Clock before predivisor */
 	unsigned char		acr;
 	unsigned char		ier;
 	unsigned char		lcr;

