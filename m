From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/3] m32r_sio: remove dependency on struct serial_uart_config
Date: Mon, 20 Aug 2012 19:56:26 -0400
Message-ID: <1345506988-15390-2-git-send-email-paul.gortmaker@windriver.com>
References: <1345506988-15390-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:57563 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2HTX7y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 19:59:54 -0400
In-Reply-To: <1345506988-15390-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Hirokazu Takata <takata@linux-m32r.org>

The struct serial_uart_config is hardly used at all, and the
use case like this one are somewhat needless.  Remove the
trivial usage so that we can remove serial_uart_config.

Since the type field isn't really used at all, we also delete
the initialization and references of it here as well.

Cc: Hirokazu Takata <takata@linux-m32r.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/m32r_sio.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index a070362..b13949a 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -44,8 +44,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#define PORT_M32R_BASE	PORT_M32R_SIO
-#define PORT_INDEX(x)	(x - PORT_M32R_BASE + 1)
 #define BAUD_RATE	115200
 
 #include <linux/serial_core.h>
@@ -132,22 +130,6 @@ struct irq_info {
 
 static struct irq_info irq_lists[NR_IRQS];
 
-/*
- * Here we define the default xmit fifo size used for each type of UART.
- */
-static const struct serial_uart_config uart_config[] = {
-	[PORT_UNKNOWN] = {
-		.name			= "unknown",
-		.dfl_xmit_fifo_size	= 1,
-		.flags			= 0,
-	},
-	[PORT_INDEX(PORT_M32R_SIO)] = {
-		.name			= "M32RSIO",
-		.dfl_xmit_fifo_size	= 1,
-		.flags			= 0,
-	},
-};
-
 #ifdef CONFIG_SERIAL_M32R_PLDSIO
 
 #define __sio_in(x) inw((unsigned long)(x))
@@ -907,8 +889,7 @@ static void m32r_sio_config_port(struct uart_port *port, int unused)
 
 	spin_lock_irqsave(&up->port.lock, flags);
 
-	up->port.type = (PORT_M32R_SIO - PORT_M32R_BASE + 1);
-	up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
+	up->port.fifosize = 1;
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
@@ -916,23 +897,11 @@ static void m32r_sio_config_port(struct uart_port *port, int unused)
 static int
 m32r_sio_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	if (ser->irq >= nr_irqs || ser->irq < 0 ||
-	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
-	    ser->type >= ARRAY_SIZE(uart_config))
+	if (ser->irq >= nr_irqs || ser->irq < 0 || ser->baud_base < 9600)
 		return -EINVAL;
 	return 0;
 }
 
-static const char *
-m32r_sio_type(struct uart_port *port)
-{
-	int type = port->type;
-
-	if (type >= ARRAY_SIZE(uart_config))
-		type = 0;
-	return uart_config[type].name;
-}
-
 static struct uart_ops m32r_sio_pops = {
 	.tx_empty	= m32r_sio_tx_empty,
 	.set_mctrl	= m32r_sio_set_mctrl,
@@ -946,7 +915,6 @@ static struct uart_ops m32r_sio_pops = {
 	.shutdown	= m32r_sio_shutdown,
 	.set_termios	= m32r_sio_set_termios,
 	.pm		= m32r_sio_pm,
-	.type		= m32r_sio_type,
 	.release_port	= m32r_sio_release_port,
 	.request_port	= m32r_sio_request_port,
 	.config_port	= m32r_sio_config_port,
-- 
1.7.11.1

