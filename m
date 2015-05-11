From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] tty/serial: at91: RS485 mode: 0 is valid for delay_rts_after_send
Date: Mon, 11 May 2015 13:00:31 +0200
Message-ID: <1431342044-23343-1-git-send-email-nicolas.ferre@atmel.com>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA8D002E7C@edb1.wapice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EBD2DE4ADA47B94E831AED12A4B0CADA8D002E7C@edb1.wapice.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Sami.Pietikainen@wapice.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In RS485 mode, we may want to set the delay_rts_after_send value to 0.
In the datasheet, the 0 value is said to "disable" the Transmitter Time=
guard but
this is exactly the expected behavior if we want no delay...

Moreover, if the value was set to non-zero value by device-tree or earl=
ier
ioctl command, it was impossible to change it back to zero.

Reported-by: Sami Pietik=C3=A4inen <Sami.Pietikainen@wapice.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable@vger.kernel.org  # 3.2+
---
 drivers/tty/serial/atmel_serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atm=
el_serial.c
index 27dade29646b..5ca1dfb0561c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -315,8 +315,7 @@ static int atmel_config_rs485(struct uart_port *por=
t,
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		atmel_port->tx_done_mask =3D ATMEL_US_TXEMPTY;
-		if ((rs485conf->delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
+		UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
 		mode |=3D ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -354,8 +353,7 @@ static void atmel_set_mctrl(struct uart_port *port,=
 u_int mctrl)
=20
 	/* override mode to RS485 if needed, otherwise keep the current mode =
*/
 	if (port->rs485.flags & SER_RS485_ENABLED) {
-		if ((port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
+		UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
 		mode &=3D ~ATMEL_US_USMODE;
 		mode |=3D ATMEL_US_USMODE_RS485;
 	}
@@ -2061,8 +2059,7 @@ static void atmel_set_termios(struct uart_port *p=
ort, struct ktermios *termios,
=20
 	/* mode */
 	if (port->rs485.flags & SER_RS485_ENABLED) {
-		if ((port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
+		UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
 		mode |=3D ATMEL_US_USMODE_RS485;
 	} else if (termios->c_cflag & CRTSCTS) {
 		/* RS232 with hardware handshake (RTS/CTS) */
--=20
2.1.3
