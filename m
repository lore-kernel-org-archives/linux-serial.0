From: Alan Cox <alan@linux.intel.com>
Subject: [RFC PATCH 3/3] serial: switch to the new RS485 helpers
Date: Tue, 12 Aug 2014 16:02:47 +0100
Message-ID: <20140812150150.13378.93278.stgit@acox1-desk.ger.corp.intel.com>
References: <20140812150104.13378.24152.stgit@acox1-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29249 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbaHLPDZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Aug 2014 11:03:25 -0400
In-Reply-To: <20140812150104.13378.24152.stgit@acox1-desk.ger.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

From: Alan <gnomes@lxorguk.ukuu.org.uk>

Example switch for evaluation (untested)
---
 drivers/tty/serial/atmel_serial.c |   32 +++---------------------------
 drivers/tty/serial/mcf.c          |   28 +++-----------------------
 drivers/tty/serial/omap-serial.c  |   31 ++---------------------------
 drivers/tty/serial/sc16is7xx.c    |   40 +++++++------------------------------
 4 files changed, 16 insertions(+), 115 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 7b63677..d441fad 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2059,8 +2059,10 @@ static int atmel_request_port(struct uart_port *port)
  */
 static void atmel_config_port(struct uart_port *port, int flags)
 {
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	if (flags & UART_CONFIG_TYPE) {
 		port->type = PORT_ATMEL;
+		port->rs485 = &atmel_port->rs485;
 		atmel_request_port(port);
 	}
 }
@@ -2106,34 +2108,6 @@ static void atmel_poll_put_char(struct uart_port *port, unsigned char ch)
 }
 #endif
 
-static int
-atmel_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
-{
-	struct serial_rs485 rs485conf;
-
-	switch (cmd) {
-	case TIOCSRS485:
-		if (copy_from_user(&rs485conf, (struct serial_rs485 *) arg,
-					sizeof(rs485conf)))
-			return -EFAULT;
-
-		atmel_config_rs485(port, &rs485conf);
-		break;
-
-	case TIOCGRS485:
-		if (copy_to_user((struct serial_rs485 *) arg,
-					&(to_atmel_uart_port(port)->rs485),
-					sizeof(rs485conf)))
-			return -EFAULT;
-		break;
-
-	default:
-		return -ENOIOCTLCMD;
-	}
-	return 0;
-}
-
-
 
 static struct uart_ops atmel_pops = {
 	.tx_empty	= atmel_tx_empty,
@@ -2155,7 +2129,7 @@ static struct uart_ops atmel_pops = {
 	.config_port	= atmel_config_port,
 	.verify_port	= atmel_verify_port,
 	.pm		= atmel_serial_pm,
-	.ioctl		= atmel_ioctl,
+	.set_rs485	= atmel_config_rs485,
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_get_char	= atmel_poll_get_char,
 	.poll_put_char	= atmel_poll_put_char,
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index bc896dc..4260381 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -395,8 +395,10 @@ static irqreturn_t mcf_interrupt(int irq, void *data)
 
 static void mcf_config_port(struct uart_port *port, int flags)
 {
+	struct mcf_uart *pp = container_of(port, struct mcf_uart, port);
 	port->type = PORT_MCF;
 	port->fifosize = MCFUART_TXFIFOSIZE;
+	port->rs485 = &pp->rs485;
 
 	/* Clear mask, so no surprise interrupts. */
 	writeb(0, port->membase + MCFUART_UIMR);
@@ -464,30 +466,6 @@ static void mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static int mcf_ioctl(struct uart_port *port, unsigned int cmd,
-		unsigned long arg)
-{
-	switch (cmd) {
-	case TIOCSRS485: {
-		struct serial_rs485 rs485;
-		if (copy_from_user(&rs485, (struct serial_rs485 *)arg,
-				sizeof(struct serial_rs485)))
-			return -EFAULT;
-		mcf_config_rs485(port, &rs485);
-		break;
-	}
-	case TIOCGRS485: {
-		struct mcf_uart *pp = container_of(port, struct mcf_uart, port);
-		if (copy_to_user((struct serial_rs485 *)arg, &pp->rs485,
-				sizeof(struct serial_rs485)))
-			return -EFAULT;
-		break;
-	}
-	default:
-		return -ENOIOCTLCMD;
-	}
-	return 0;
-}
 
 /****************************************************************************/
 
@@ -510,7 +488,7 @@ static const struct uart_ops mcf_uart_ops = {
 	.release_port	= mcf_release_port,
 	.config_port	= mcf_config_port,
 	.verify_port	= mcf_verify_port,
-	.ioctl		= mcf_ioctl,
+	.set_rs485	= mcf_config_rs485
 };
 
 static struct mcf_uart mcf_ports[4];
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d017cec..43aa91d 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1143,6 +1143,7 @@ static void serial_omap_config_port(struct uart_port *port, int flags)
 							up->port.line);
 	up->port.type = PORT_OMAP;
 	up->port.flags |= UPF_SOFT_FLOW | UPF_HARD_FLOW;
+	up->port.rs485 = &up->rs485;
 }
 
 static int
@@ -1391,34 +1392,6 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	pm_runtime_put_autosuspend(up->dev);
 }
 
-static int
-serial_omap_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
-{
-	struct serial_rs485 rs485conf;
-
-	switch (cmd) {
-	case TIOCSRS485:
-		if (copy_from_user(&rs485conf, (void __user *) arg,
-					sizeof(rs485conf)))
-			return -EFAULT;
-
-		serial_omap_config_rs485(port, &rs485conf);
-		break;
-
-	case TIOCGRS485:
-		if (copy_to_user((void __user *) arg,
-					&(to_uart_omap_port(port)->rs485),
-					sizeof(rs485conf)))
-			return -EFAULT;
-		break;
-
-	default:
-		return -ENOIOCTLCMD;
-	}
-	return 0;
-}
-
-
 static struct uart_ops serial_omap_pops = {
 	.tx_empty	= serial_omap_tx_empty,
 	.set_mctrl	= serial_omap_set_mctrl,
@@ -1439,7 +1412,7 @@ static struct uart_ops serial_omap_pops = {
 	.request_port	= serial_omap_request_port,
 	.config_port	= serial_omap_config_port,
 	.verify_port	= serial_omap_verify_port,
-	.ioctl		= serial_omap_ioctl,
+	.set_rs485	= serial_omap_config_rs485,
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_put_char  = serial_omap_poll_put_char,
 	.poll_get_char  = serial_omap_poll_get_char,
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3284c31..bc136aa 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -830,10 +830,10 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	uart_update_timeout(port, termios->c_cflag, baud);
 }
 
-#if defined(TIOCSRS485) && defined(TIOCGRS485)
-static void sc16is7xx_config_rs485(struct uart_port *port,
+static int sc16is7xx_config_rs485(struct uart_port *port,
 				   struct serial_rs485 *rs485)
 {
+	/* FIXME: really we should not copy the unimplemented bits here */
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
 	one->rs485 = *rs485;
@@ -847,34 +847,7 @@ static void sc16is7xx_config_rs485(struct uart_port *port,
 				      SC16IS7XX_EFCR_AUTO_RS485_BIT,
 				      0);
 	}
-}
-#endif
-
-static int sc16is7xx_ioctl(struct uart_port *port, unsigned int cmd,
-			   unsigned long arg)
-{
-#if defined(TIOCSRS485) && defined(TIOCGRS485)
-	struct serial_rs485 rs485;
-
-	switch (cmd) {
-	case TIOCSRS485:
-		if (copy_from_user(&rs485, (void __user *)arg, sizeof(rs485)))
-			return -EFAULT;
-
-		sc16is7xx_config_rs485(port, &rs485);
-		return 0;
-	case TIOCGRS485:
-		if (copy_to_user((void __user *)arg,
-				 &(to_sc16is7xx_one(port, port)->rs485),
-				 sizeof(rs485)))
-			return -EFAULT;
-		return 0;
-	default:
-		break;
-	}
-#endif
-
-	return -ENOIOCTLCMD;
+	return 0;
 }
 
 static int sc16is7xx_startup(struct uart_port *port)
@@ -958,8 +931,11 @@ static int sc16is7xx_request_port(struct uart_port *port)
 
 static void sc16is7xx_config_port(struct uart_port *port, int flags)
 {
-	if (flags & UART_CONFIG_TYPE)
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	if (flags & UART_CONFIG_TYPE) {
 		port->type = PORT_SC16IS7XX;
+		port->rs485 = &one->rs485;
+        }
 }
 
 static int sc16is7xx_verify_port(struct uart_port *port,
@@ -1000,7 +976,7 @@ static const struct uart_ops sc16is7xx_ops = {
 	.release_port	= sc16is7xx_null_void,
 	.config_port	= sc16is7xx_config_port,
 	.verify_port	= sc16is7xx_verify_port,
-	.ioctl		= sc16is7xx_ioctl,
+	.set_rs485	= sc16is7xx_config_rs485,
 	.pm		= sc16is7xx_pm,
 };
 

