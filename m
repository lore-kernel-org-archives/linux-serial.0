From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/13] RS485: fix inconsistencies in the meaning of some variables
Date: Mon, 21 Nov 2011 17:11:39 -0800
Message-ID: <1321924303-26475-9-git-send-email-gregkh@suse.de>
References: <20111122005917.GD25420@kroah.com>
 <1321924303-26475-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42119 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757855Ab1KVBNV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 20:13:21 -0500
In-Reply-To: <1321924303-26475-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Claudio Scordino <claudio@evidence.eu.com>, Darron Black <darron@griffin.net>, Greg Kroah-Hartman <gregkh@suse.de>

From: Claudio Scordino <claudio@evidence.eu.com>

The crisv10.c and the atmel_serial.c serial drivers intepret the fields of the
serial_rs485 structure in a different way.

In particular, crisv10.c uses SER_RS485_RTS_AFTER_SEND and
SER_RS485_RTS_ON_SEND for the voltage of the RTS pin; atmel_serial.c,
instead, uses these values to know if a delay must be set before and
after sending.  This patch makes the usage of these variables consistent
across all drivers and fixes the Documentation as well.

>From now on, SER_RS485_RTS_AFTER_SEND and SER_RS485_RTS_ON_SEND will be
used to set the voltage of the RTS pin (as in the crisv10.c driver); the
delay will be understood by looking only at the value of
delay_rts_before_send and delay_rts_after_send.

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Darron Black <darron@griffin.net>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/serial/serial-rs485.txt |   14 +++++++++++---
 drivers/tty/serial/atmel_serial.c     |   16 +++-------------
 drivers/tty/serial/crisv10.c          |   10 ++--------
 include/linux/serial.h                |   14 ++++++++------
 4 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/Documentation/serial/serial-rs485.txt b/Documentation/serial/serial-rs485.txt
index 079cb3d..41c8378 100644
--- a/Documentation/serial/serial-rs485.txt
+++ b/Documentation/serial/serial-rs485.txt
@@ -97,15 +97,23 @@
 
 	struct serial_rs485 rs485conf;
 
-	/* Set RS485 mode: */
+	/* Enable RS485 mode: */
 	rs485conf.flags |= SER_RS485_ENABLED;
 
+	/* Set logical level for RTS pin equal to 1 when sending: */
+	rs485conf.flags |= SER_RS485_RTS_ON_SEND;
+	/* or, set logical level for RTS pin equal to 0 when sending: */
+	rs485conf.flags &= ~(SER_RS485_RTS_ON_SEND);
+
+	/* Set logical level for RTS pin equal to 1 after sending: */
+	rs485conf.flags |= SER_RS485_RTS_AFTER_SEND;
+	/* or, set logical level for RTS pin equal to 0 after sending: */
+	rs485conf.flags &= ~(SER_RS485_RTS_AFTER_SEND);
+
 	/* Set rts delay before send, if needed: */
-	rs485conf.flags |= SER_RS485_RTS_BEFORE_SEND;
 	rs485conf.delay_rts_before_send = ...;
 
 	/* Set rts delay after send, if needed: */
-	rs485conf.flags |= SER_RS485_RTS_AFTER_SEND;
 	rs485conf.delay_rts_after_send = ...;
 
 	/* Set this flag if you want to receive data even whilst sending data */
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4a0f86f..4c823f3 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -228,7 +228,7 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
+		if ((rs485conf->delay_rts_after_send) > 0)
 			UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
@@ -304,7 +304,7 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		if (atmel_port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		if ((atmel_port->rs485.delay_rts_after_send) > 0)
 			UART_PUT_TTGR(port,
 					atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
@@ -1228,7 +1228,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		if (atmel_port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		if ((atmel_port->rs485.delay_rts_after_send) > 0)
 			UART_PUT_TTGR(port,
 					atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
@@ -1447,16 +1447,6 @@ static void __devinit atmel_of_init_port(struct atmel_uart_port *atmel_port,
 		rs485conf->delay_rts_after_send = rs485_delay[1];
 		rs485conf->flags = 0;
 
-		if (rs485conf->delay_rts_before_send == 0 &&
-		    rs485conf->delay_rts_after_send == 0) {
-			rs485conf->flags |= SER_RS485_RTS_ON_SEND;
-		} else {
-			if (rs485conf->delay_rts_before_send)
-				rs485conf->flags |= SER_RS485_RTS_BEFORE_SEND;
-			if (rs485conf->delay_rts_after_send)
-				rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
-		}
-
 		if (of_get_property(np, "rs485-rx-during-tx", NULL))
 			rs485conf->flags |= SER_RS485_RX_DURING_TX;
 
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index b743504..1dfba7b 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3234,9 +3234,8 @@ rs_write(struct tty_struct *tty,
 		e100_disable_rx(info);
 		e100_enable_rx_irq(info);
 #endif
-		if ((info->rs485.flags & SER_RS485_RTS_BEFORE_SEND) &&
-			(info->rs485.delay_rts_before_send > 0))
-				msleep(info->rs485.delay_rts_before_send);
+		if (info->rs485.delay_rts_before_send > 0)
+			msleep(info->rs485.delay_rts_before_send);
 	}
 #endif /* CONFIG_ETRAX_RS485 */
 
@@ -3693,10 +3692,6 @@ rs_ioctl(struct tty_struct *tty,
 
 		rs485data.delay_rts_before_send = rs485ctrl.delay_rts_before_send;
 		rs485data.flags = 0;
-		if (rs485data.delay_rts_before_send != 0)
-			rs485data.flags |= SER_RS485_RTS_BEFORE_SEND;
-		else
-			rs485data.flags &= ~(SER_RS485_RTS_BEFORE_SEND);
 
 		if (rs485ctrl.enabled)
 			rs485data.flags |= SER_RS485_ENABLED;
@@ -4531,7 +4526,6 @@ static int __init rs_init(void)
 		/* Set sane defaults */
 		info->rs485.flags &= ~(SER_RS485_RTS_ON_SEND);
 		info->rs485.flags |= SER_RS485_RTS_AFTER_SEND;
-		info->rs485.flags &= ~(SER_RS485_RTS_BEFORE_SEND);
 		info->rs485.delay_rts_before_send = 0;
 		info->rs485.flags &= ~(SER_RS485_ENABLED);
 #endif
diff --git a/include/linux/serial.h b/include/linux/serial.h
index 97ff8e2..3d86517 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -207,13 +207,15 @@ struct serial_icounter_struct {
 
 struct serial_rs485 {
 	__u32	flags;			/* RS485 feature flags */
-#define SER_RS485_ENABLED		(1 << 0)
-#define SER_RS485_RTS_ON_SEND		(1 << 1)
-#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
-#define SER_RS485_RTS_BEFORE_SEND	(1 << 3)
+#define SER_RS485_ENABLED		(1 << 0)	/* If enabled */
+#define SER_RS485_RTS_ON_SEND		(1 << 1)	/* Logical level for
+							   RTS pin when
+							   sending */
+#define SER_RS485_RTS_AFTER_SEND	(1 << 2)	/* Logical level for
+							   RTS pin after sent*/
 #define SER_RS485_RX_DURING_TX		(1 << 4)
-	__u32	delay_rts_before_send;	/* Milliseconds */
-	__u32	delay_rts_after_send;	/* Milliseconds */
+	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
+	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
 	__u32	padding[5];		/* Memory is cheap, new structs
 					   are a royal PITA .. */
 };
-- 
1.7.7.3

