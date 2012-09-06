From: Sean Young <sean@mess.org>
Subject: [PATCH 2/2] 8250: blacklist IR ports
Date: Thu,  6 Sep 2012 23:20:32 +0100
Message-ID: <a9565dd624c186917c71a4e431e6bcab712dbf08.1346969721.git.sean@mess.org>
References: <cover.1346969721.git.sean@mess.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pequod.mess.org ([93.97.41.153]:43601 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab2IFWUe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 18:20:34 -0400
In-Reply-To: <cover.1346969721.git.sean@mess.org>
In-Reply-To: <cover.1346969721.git.sean@mess.org>
References: <cover.1346969721.git.sean@mess.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>, Mauro Carvalho Chehab <mchehab@redhat.com>

These ports should not be probed, but we need to keep track of them so we
can prevent the legacy (non-PNP) probe of serial ports from touching them
too.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/tty/serial/8250/8250.c     | 16 ++++++++++++++--
 drivers/tty/serial/8250/8250_pnp.c | 23 ++++++++++++++++++-----
 include/linux/serial_core.h        |  3 ++-
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index bc25874..ea9166b 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -290,6 +290,9 @@ static const struct serial8250_config uart_config[] = {
 				  UART_FCR_R_TRIG_00 | UART_FCR_T_TRIG_00,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_IR] = {
+		.name		= "IR port"
+	}
 };
 
 /* Uart divisor latch read */
@@ -1897,6 +1900,9 @@ static int serial8250_startup(struct uart_port *port)
 	unsigned char lsr, iir;
 	int retval;
 
+	if (port->type == PORT_IR)
+		return -ENODEV;
+
 	port->fifosize = uart_config[up->port.type].fifo_size;
 	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
 	up->capabilities = uart_config[up->port.type].flags;
@@ -2554,7 +2560,10 @@ static int serial8250_request_port(struct uart_port *port)
 {
 	struct uart_8250_port *up =
 		container_of(port, struct uart_8250_port, port);
-	int ret = 0;
+	int ret;
+
+	if (port->type == PORT_IR)
+		return -ENODEV;
 
 	ret = serial8250_request_std_resource(up);
 	if (ret == 0 && port->type == PORT_RSA) {
@@ -2573,6 +2582,9 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 	int probeflags = PROBE_ANY;
 	int ret;
 
+	if (port->type == PORT_IR)
+		return;
+
 	/*
 	 * Find the region that we can probe for.  This in turn
 	 * tells us whether we can probe for the type of port.
@@ -3144,7 +3156,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 	mutex_lock(&serial_mutex);
 
 	uart = serial8250_find_match_or_unused(&up->port);
-	if (uart) {
+	if (uart && uart->port.type != PORT_IR) {
 		if (uart->port.dev)
 			uart_remove_one_port(&serial8250_reg, &uart->port);
 
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 28bf830..6ab2ce1 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -25,7 +25,7 @@
 #include "8250.h"
 
 #define UNKNOWN_DEV 0x3000
-
+#define IR_PORT	0x0800
 
 static const struct pnp_device_id pnp_dev_table[] = {
 	/* Archtek America Corp. */
@@ -362,6 +362,12 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	{	"PNPCXXX",		UNKNOWN_DEV	},
 	/* More unknown PnP modems */
 	{	"PNPDXXX",		UNKNOWN_DEV	},
+	/* IR ports -- should not be probed. We should keep track of them
+	   to prevent the legacy serial driver from probing */
+	{	"WEC1022",		IR_PORT	},
+	{	"NSC6001",		IR_PORT },
+	{	"HWPC224",		IR_PORT },
+	{	"IBM0071",		IR_PORT },
 	{	"",			0	}
 };
 
@@ -409,7 +415,7 @@ static int __devinit check_resources(struct pnp_dev *dev)
  * PnP modems, alternatively we must hardcode all modems in pnp_devices[]
  * table.
  */
-static int __devinit serial_pnp_guess_board(struct pnp_dev *dev, int *flags)
+static int __devinit serial_pnp_guess_board(struct pnp_dev *dev)
 {
 	if (!(check_name(pnp_dev_name(dev)) ||
 		(dev->card && check_name(dev->card->name))))
@@ -428,7 +434,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	int ret, line, flags = dev_id->driver_data;
 
 	if (flags & UNKNOWN_DEV) {
-		ret = serial_pnp_guess_board(dev, &flags);
+		ret = serial_pnp_guess_board(dev);
 		if (ret < 0)
 			return ret;
 	}
@@ -436,7 +442,10 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	memset(&uart, 0, sizeof(uart));
 	if (pnp_irq_valid(dev, 0))
 		uart.port.irq = pnp_irq(dev, 0);
-	if (pnp_port_valid(dev, 0)) {
+	if ((flags & IR_PORT) && pnp_port_valid(dev, 2)) {
+		uart.port.iobase = pnp_port_start(dev, 2);
+		uart.port.iotype = UPIO_PORT;
+	} else if (pnp_port_valid(dev, 0)) {
 		uart.port.iobase = pnp_port_start(dev, 0);
 		uart.port.iotype = UPIO_PORT;
 	} else if (pnp_mem_valid(dev, 0)) {
@@ -451,6 +460,10 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 		"Setup PNP port: port %x, mem 0x%lx, irq %d, type %d\n",
 		       uart.port.iobase, uart.port.mapbase, uart.port.irq, uart.port.iotype);
 #endif
+	if (flags & IR_PORT) {
+		uart.port.flags |= UPF_FIXED_PORT | UPF_FIXED_TYPE;
+		uart.port.type = PORT_IR;
+	}
 
 	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
@@ -459,7 +472,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	uart.port.dev = &dev->dev;
 
 	line = serial8250_register_8250_port(&uart);
-	if (line < 0)
+	if (line < 0 || (flags & IR_PORT))
 		return -ENODEV;
 
 	pnp_set_drvdata(dev, (void *)((long)line + 1));
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 7cf0b68..c7e9edf 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -48,7 +48,8 @@
 #define PORT_TEGRA	20	/* NVIDIA Tegra internal UART */
 #define PORT_XR17D15X	21	/* Exar XR17D15x UART */
 #define PORT_LPC3220	22	/* NXP LPC32xx SoC "Standard" UART */
-#define PORT_MAX_8250	22	/* max port ID */
+#define PORT_IR		23	/* infrared port, has its own driver */
+#define PORT_MAX_8250	23	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
-- 
1.7.11.4

