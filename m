Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E23C433EF
	for <linux-serial@archiver.kernel.org>; Sun, 23 Jan 2022 04:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbiAWEVQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 22 Jan 2022 23:21:16 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44909 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbiAWEVQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 22 Jan 2022 23:21:16 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7FB79300002A0;
        Sun, 23 Jan 2022 05:21:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 70F262913AD; Sun, 23 Jan 2022 05:21:14 +0100 (CET)
Message-Id: <2d2acaf3a69e89b7bf687c912022b11fd29dfa1e.1642909284.git.lukas@wunner.de>
In-Reply-To: <85fa3323ba8c307943969b7343e23f34c3e652ba.1642909284.git.lukas@wunner.de>
References: <85fa3323ba8c307943969b7343e23f34c3e652ba.1642909284.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 23 Jan 2022 05:21:14 +0100
Subject: [PATCH 2/2] serial: core: Initialize rs485 RTS polarity already on
 probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Jochen Mades <jochen@mades.net>,
        "Su Bao Cheng" <baocheng.su@siemens.com>,
        "Su Bao Cheng" <baocheng_su@163.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RTS polarity of rs485-enabled ports is currently initialized on uart
open via:

tty_port_open()
  tty_port_block_til_ready()
    tty_port_raise_dtr_rts()  # if (C_BAUD(tty))
      uart_dtr_rts()
        uart_port_dtr_rts()

There's at least three problems here:

First, if no baud rate is set, RTS polarity is not initialized.
That's the right thing to do for rs232, but not for rs485, which
requires that RTS is deasserted unconditionally.

Second, if the DeviceTree property "linux,rs485-enabled-at-boot-time" is
present, RTS should be deasserted as early as possible, i.e. on probe.
Otherwise it may remain asserted until first open.

Third, even though RTS is deasserted on open and close, it may
subsequently be asserted by uart_throttle(), uart_unthrottle() or
uart_set_termios() because those functions aren't rs485-aware.
(Only uart_tiocmset() is.)

To address these issues, move RTS initialization from uart_port_dtr_rts()
to uart_configure_port().  Prevent subsequent modification of RTS
polarity by moving the existing rs485 check from uart_tiocmget() to
uart_update_mctrl().

That way, RTS is initialized on probe and then remains unmodified unless
the uart transmits data.  If rs485 is enabled at runtime (instead of at
boot) through a TIOCSRS485 ioctl(), RTS is initialized by the uart
driver's ->rs485_config() callback and then likewise remains unmodified.

The PL011 driver initializes RTS on uart open and prevents subsequent
modification in its ->set_mctrl() callback.  That code is obsoleted by
the present commit, so drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Su Bao Cheng <baocheng.su@siemens.com>
---
 drivers/tty/serial/amba-pl011.c  | 15 +-------------
 drivers/tty/serial/serial_core.c | 34 +++++++++++---------------------
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index f64c475a1379..ba053a68529f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1582,13 +1582,6 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int cr;
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
-			mctrl &= ~TIOCM_RTS;
-		else
-			mctrl |= TIOCM_RTS;
-	}
-
 	cr = pl011_read(uap, REG_CR);
 
 #define	TIOCMBIT(tiocmbit, uartbit)		\
@@ -1812,14 +1805,8 @@ static int pl011_startup(struct uart_port *port)
 	cr &= UART011_CR_RTS | UART011_CR_DTR;
 	cr |= UART01x_CR_UARTEN | UART011_CR_RXE;
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
-			cr &= ~UART011_CR_RTS;
-		else
-			cr |= UART011_CR_RTS;
-	} else {
+	if (!(port->rs485.flags & SER_RS485_ENABLED))
 		cr |= UART011_CR_TXE;
-	}
 
 	pl011_write(cr, uap, REG_CR);
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index dc40c4155356..0db90be4c3bc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -144,6 +144,11 @@ uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 	unsigned long flags;
 	unsigned int old;
 
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		set &= ~TIOCM_RTS;
+		clear &= ~TIOCM_RTS;
+	}
+
 	spin_lock_irqsave(&port->lock, flags);
 	old = port->mctrl;
 	port->mctrl = (old & ~clear) | set;
@@ -157,23 +162,10 @@ uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 
 static void uart_port_dtr_rts(struct uart_port *uport, int raise)
 {
-	int rs485_on = uport->rs485_config &&
-		(uport->rs485.flags & SER_RS485_ENABLED);
-	int RTS_after_send = !!(uport->rs485.flags & SER_RS485_RTS_AFTER_SEND);
-
-	if (raise) {
-		if (rs485_on && RTS_after_send) {
-			uart_set_mctrl(uport, TIOCM_DTR);
-			uart_clear_mctrl(uport, TIOCM_RTS);
-		} else {
-			uart_set_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
-		}
-	} else {
-		unsigned int clear = TIOCM_DTR;
-
-		clear |= (!rs485_on || RTS_after_send) ? TIOCM_RTS : 0;
-		uart_clear_mctrl(uport, clear);
-	}
+	if (raise)
+		uart_set_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
+	else
+		uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 }
 
 /*
@@ -1075,11 +1067,6 @@ uart_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
 		goto out;
 
 	if (!tty_io_error(tty)) {
-		if (uport->rs485.flags & SER_RS485_ENABLED) {
-			set &= ~TIOCM_RTS;
-			clear &= ~TIOCM_RTS;
-		}
-
 		uart_update_mctrl(uport, set, clear);
 		ret = 0;
 	}
@@ -2390,6 +2377,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 */
 		spin_lock_irqsave(&port->lock, flags);
 		port->mctrl &= TIOCM_DTR;
+		if (port->rs485.flags & SER_RS485_ENABLED &&
+		    !(port->rs485.flags & SER_RS485_RTS_AFTER_SEND))
+			port->mctrl |= TIOCM_RTS;
 		port->ops->set_mctrl(port, port->mctrl);
 		spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.34.1

