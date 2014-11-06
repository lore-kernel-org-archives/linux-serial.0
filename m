From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 11/11] tty/serial_core: Introduce lock mechanism for RS485
Date: Thu,  6 Nov 2014 09:23:00 +0100
Message-ID: <1415262180-2694-12-git-send-email-ricardo.ribalda@gmail.com>
References: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:65363 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaKFIXU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 03:23:20 -0500
Received: by mail-la0-f43.google.com with SMTP id ge10so2161304lab.2
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2014 00:23:18 -0800 (PST)
In-Reply-To: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

Introduce an homogeneous lock system between setting and using the rs485
data of the uart_port.

This patch should not be split into multiple ones in order to avoid
leaving the tree in an unstable state.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reviewed-by: Alan Cox <alan@linux.intel.com>
Suggested-by: Alan Cox <alan@linux.intel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 10 ++++------
 drivers/tty/serial/mcf.c          |  5 +----
 drivers/tty/serial/omap-serial.c  |  3 ---
 drivers/tty/serial/serial_core.c  | 13 ++++++++++++-
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index ab33a53..e3b3c8f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -294,9 +294,6 @@ static int atmel_config_rs485(struct uart_port *port,
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned int mode;
-	unsigned long flags;
-
-	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable interrupts */
 	UART_PUT_IDR(port, atmel_port->tx_done_mask);
@@ -327,8 +324,6 @@ static int atmel_config_rs485(struct uart_port *port,
 	/* Enable interrupts */
 	UART_PUT_IER(port, atmel_port->tx_done_mask);
 
-	spin_unlock_irqrestore(&port->lock, flags);
-
 	return 0;
 }
 
@@ -2512,6 +2507,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 	void *data;
 	int ret = -ENODEV;
+	bool rs485_enabled;
 
 	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
 
@@ -2559,6 +2555,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
 		port->rx_ring.buf = data;
 	}
 
+	rs485_enabled = port->uart.rs485.flags & SER_RS485_ENABLED;
+
 	ret = uart_add_one_port(&atmel_uart, &port->uart);
 	if (ret)
 		goto err_add_port;
@@ -2577,7 +2575,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 	platform_set_drvdata(pdev, port);
 
-	if (port->uart.rs485.flags & SER_RS485_ENABLED) {
+	if (rs485_enabled) {
 		UART_PUT_MR(&port->uart, ATMEL_US_USMODE_NORMAL);
 		UART_PUT_CR(&port->uart, ATMEL_US_RTSEN);
 	}
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index d7be1f1..fdd5c7b 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -257,12 +257,12 @@ static void mcf_set_termios(struct uart_port *port, struct ktermios *termios,
 		mr2 |= MCFUART_MR2_TXCTS;
 	}
 
+	spin_lock_irqsave(&port->lock, flags);
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		mr2 |= MCFUART_MR2_TXRTS;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
 	uart_update_timeout(port, termios->c_cflag, baud);
 	writeb(MCFUART_UCR_CMDRESETRX, port->membase + MCFUART_UCR);
 	writeb(MCFUART_UCR_CMDRESETTX, port->membase + MCFUART_UCR);
@@ -442,10 +442,8 @@ static int mcf_verify_port(struct uart_port *port, struct serial_struct *ser)
 static int mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 {
 	struct mcf_uart *pp = container_of(port, struct mcf_uart, port);
-	unsigned long flags;
 	unsigned char mr1, mr2;
 
-	spin_lock_irqsave(&port->lock, flags);
 	/* Get mode registers */
 	mr1 = readb(port->membase + MCFUART_UMR);
 	mr2 = readb(port->membase + MCFUART_UMR);
@@ -460,7 +458,6 @@ static int mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 	writeb(mr1, port->membase + MCFUART_UMR);
 	writeb(mr2, port->membase + MCFUART_UMR);
 	port->rs485 = *rs485;
-	spin_unlock_irqrestore(&port->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ef58fd4..be84b10 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1360,12 +1360,10 @@ static int
 serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
-	unsigned long flags;
 	unsigned int mode;
 	int val;
 
 	pm_runtime_get_sync(up->dev);
-	spin_lock_irqsave(&up->port.lock, flags);
 
 	/* Disable interrupts from this port */
 	mode = up->ier;
@@ -1401,7 +1399,6 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 		serial_out(up, UART_OMAP_SCR, up->scr);
 	}
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 652cce7..2e45be9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1155,8 +1155,16 @@ static int uart_get_icount(struct tty_struct *tty,
 static int uart_get_rs485_config(struct uart_port *port,
 			 struct serial_rs485 __user *rs485)
 {
-	if (copy_to_user(rs485, &port->rs485, sizeof(port->rs485)))
+	unsigned long flags;
+	struct serial_rs485 aux;
+
+	spin_lock_irqsave(&port->lock, flags);
+	aux = port->rs485;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (copy_to_user(rs485, &aux, sizeof(aux)))
 		return -EFAULT;
+
 	return 0;
 }
 
@@ -1165,6 +1173,7 @@ static int uart_set_rs485_config(struct uart_port *port,
 {
 	struct serial_rs485 rs485;
 	int ret;
+	unsigned long flags;
 
 	if (!port->rs485_config)
 		return -ENOIOCTLCMD;
@@ -1172,7 +1181,9 @@ static int uart_set_rs485_config(struct uart_port *port,
 	if (copy_from_user(&rs485, rs485_user, sizeof(rs485_user)))
 		return -EFAULT;
 
+	spin_lock_irqsave(&port->lock, flags);
 	ret = port->rs485_config(port, &rs485);
+	spin_unlock_irqrestore(&port->lock, flags);
 	if (ret)
 		return ret;
 
-- 
2.1.1

