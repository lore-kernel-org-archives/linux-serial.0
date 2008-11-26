From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/5] Serial: Allow port type to be specified when calling serial8250_register_port.
Date: Tue, 25 Nov 2008 16:18:37 -0800
Message-ID: <1227658719-18297-3-git-send-email-ddaney@caviumnetworks.com>
References: <492C94FC.9070906@caviumnetworks.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:20491 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYKZATX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2008 19:19:23 -0500
In-Reply-To: <492C94FC.9070906@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk
Cc: linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>

Add flag value UPF_FIXED_TYPE which specifies that the UART type is
known and should not be probed.  For this case the UARTs properties
are just copied out of the uart_config entry.

This allows us to keep SOC specific 8250 probe code out of 8250.c.  In
this case we know the serial hardware will not be changing as it is on
the same silicon as the CPU, and we can specify it with certainty in
the board/cpu setup code.

The alternative is to load up 8250.c with a bunch of OCTEON specific
special cases in the probing code.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/serial/8250.c        |    9 +++++++++
 drivers/serial/serial_core.c |    7 +++++--
 include/linux/serial_8250.h  |    1 +
 include/linux/serial_core.h  |    2 ++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 849af9d..3ae4974 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2903,6 +2903,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.mapbase		= p->mapbase;
 		port.hub6		= p->hub6;
 		port.private_data	= p->private_data;
+		port.type		= p->type;
 		port.serial_in		= p->serial_in;
 		port.serial_out		= p->serial_out;
 		port.dev		= &dev->dev;
@@ -3058,6 +3059,14 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.private_data = port->private_data;
 		if (port->dev)
 			uart->port.dev = port->dev;
+
+		if (port->flags & UPF_FIXED_TYPE) {
+			uart->port.type = port->type;
+			uart->port.fifosize = uart_config[port->type].fifo_size;
+			uart->capabilities = uart_config[port->type].flags;
+			uart->tx_loadsz = uart_config[port->type].tx_loadsz;
+		}
+
 		set_io_from_upio(&uart->port);
 		/* Possibly override default I/O functions.  */
 		if (port->serial_in)
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 874786a..7fef45e 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2198,11 +2198,14 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 	 * Now do the auto configuration stuff.  Note that config_port
 	 * is expected to claim the resources and map the port for us.
 	 */
-	flags = UART_CONFIG_TYPE;
+	flags = 0;
 	if (port->flags & UPF_AUTO_IRQ)
 		flags |= UART_CONFIG_IRQ;
 	if (port->flags & UPF_BOOT_AUTOCONF) {
-		port->type = PORT_UNKNOWN;
+		if (!(port->flags & UPF_FIXED_TYPE)) {
+			port->type = PORT_UNKNOWN;
+			flags |= UART_CONFIG_TYPE;
+		}
 		port->ops->config_port(port, flags);
 	}
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 77d83d9..d4d2a78 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -28,6 +28,7 @@ struct plat_serial8250_port {
 	unsigned char	iotype;		/* UPIO_* */
 	unsigned char	hub6;
 	upf_t		flags;		/* UPF_* flags */
+	unsigned int	type;		/* If UPF_FIXED_TYPE */
 	unsigned int	(*serial_in)(struct uart_port *, int);
 	void		(*serial_out)(struct uart_port *, int, int);
 };
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2d22c67..b9e7756 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -293,6 +293,8 @@ struct uart_port {
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
+/* The exact UART type is known and should not be probed.  */
+#define UPF_FIXED_TYPE		((__force upf_t) (1 << 27))
 #define UPF_BOOT_AUTOCONF	((__force upf_t) (1 << 28))
 #define UPF_FIXED_PORT		((__force upf_t) (1 << 29))
 #define UPF_DEAD		((__force upf_t) (1 << 30))
-- 
1.5.6.5

