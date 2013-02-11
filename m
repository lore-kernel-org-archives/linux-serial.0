From: claudio@evidence.eu.com
Subject: [PATCH 2/3] atmel_serial: use msleep for delays
Date: Mon, 11 Feb 2013 16:54:25 +0100
Message-ID: <1360598067-3577-3-git-send-email-claudio@evidence.eu.com>
References: <CAJa4H3fQ_khDVNcSu+39C+oZyc268YUgq9ahzt2ugk1_6eqYfw@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mr002msb.fastweb.it ([85.18.95.86]:50721 "EHLO
	mr002msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757538Ab3BKQBq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Feb 2013 11:01:46 -0500
In-Reply-To: <CAJa4H3fQ_khDVNcSu+39C+oZyc268YUgq9ahzt2ugk1_6eqYfw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: nicolas.ferre@atmel.com, clagix@gmail.com, Claudio Scordino <claudio@evidence.eu.com>

From: Claudio Scordino <claudio@evidence.eu.com>

The Transmitter TimeGuard Register (TTGR) should not be used for delays in
RS485 mode, because it is not a feature related only to RS485 (it should be
also available in RS232 mode) and bacause delays should be expressed in
milliseconds rrather than in bit times.

This patch sets RS485 delays using msleep (as in the cris driver) rather than
using TTGR.

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Guido Classen <clagix@gmail.com>
---
 drivers/tty/serial/atmel_serial.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 922e85a..52648ec 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -30,6 +30,7 @@
 #include <linux/serial.h>
 #include <linux/clk.h>
 #include <linux/console.h>
+#include <linux/delay.h>
 #include <linux/sysrq.h>
 #include <linux/tty_flip.h>
 #include <linux/platform_device.h>
@@ -228,8 +229,6 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-		if ((rs485conf->delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -304,9 +303,6 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		if ((atmel_port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port,
-					atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -549,7 +545,12 @@ static void atmel_tx_chars(struct uart_port *port)
 		return;
 
 	while (UART_GET_CSR(port) & atmel_port->tx_done_mask) {
+		if ((atmel_port->rs485.delay_rts_before_send) > 0)
+			msleep(atmel_port->rs485.delay_rts_before_send);
 		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
+		if ((atmel_port->rs485.delay_rts_after_send) > 0)
+			msleep(atmel_port->rs485.delay_rts_after_send);
+
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		if (uart_circ_empty(xmit))
@@ -1232,9 +1233,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		if ((atmel_port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port,
-					atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
-- 
1.7.9.5

