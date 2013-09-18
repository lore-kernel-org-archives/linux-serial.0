From: =?UTF-8?q?Jos=C3=A9=20Miguel=20Gon=C3=A7alves?=
	<jose.goncalves@inov.pt>
Subject: [PATCH v2] serial: samsung: add support for manual RTS setting
Date: Wed, 18 Sep 2013 16:52:49 +0100
Message-ID: <1379519569-7266-1-git-send-email-jose.goncalves@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:55755 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612Ab3IRPxx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Sep 2013 11:53:53 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: t.figa@samsung.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, heiko@sntech.de, s.nawrocki@samsung.com, =?UTF-8?q?Jos=C3=A9=20Miguel=20Gon=C3=A7alves?= <jose.goncalves@inov.pt>

The Samsung serial driver currently does not support setting the
RTS pin with an ioctl(TIOCMSET) call. This patch adds this support.

Changes in v2:
 - Preserve the RTS pin's manual setting  in set_termios() also when
   enabling CRTSCTS.

Signed-off-by: Jos=C3=A9 Miguel Gon=C3=A7alves <jose.goncalves@inov.pt>
---
 drivers/tty/serial/samsung.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.=
c
index f3dfa19..401ef4f 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -407,7 +407,14 @@ static unsigned int s3c24xx_serial_get_mctrl(struc=
t uart_port *port)
=20
 static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned =
int mctrl)
 {
-	/* todo - possibly remove AFC and do manual CTS */
+	unsigned int umcon =3D rd_regl(port, S3C2410_UMCON);
+
+	if (mctrl & TIOCM_RTS)
+		umcon |=3D S3C2410_UMCOM_RTS_LOW;
+	else
+		umcon &=3D ~S3C2410_UMCOM_RTS_LOW;
+
+	wr_regl(port, S3C2410_UMCON, umcon);
 }
=20
 static void s3c24xx_serial_break_ctl(struct uart_port *port, int break=
_state)
@@ -774,8 +781,6 @@ static void s3c24xx_serial_set_termios(struct uart_=
port *port,
 	if (termios->c_cflag & CSTOPB)
 		ulcon |=3D S3C2410_LCON_STOPB;
=20
-	umcon =3D (termios->c_cflag & CRTSCTS) ? S3C2410_UMCOM_AFC : 0;
-
 	if (termios->c_cflag & PARENB) {
 		if (termios->c_cflag & PARODD)
 			ulcon |=3D S3C2410_LCON_PODD;
@@ -792,6 +797,15 @@ static void s3c24xx_serial_set_termios(struct uart=
_port *port,
=20
 	wr_regl(port, S3C2410_ULCON, ulcon);
 	wr_regl(port, S3C2410_UBRDIV, quot);
+
+	umcon =3D rd_regl(port, S3C2410_UMCON);
+	if (termios->c_cflag & CRTSCTS) {
+		umcon |=3D S3C2410_UMCOM_AFC;
+		/* Disable RTS when RX FIFO contains 63 bytes */
+		umcon &=3D ~S3C2412_UMCON_AFC_8;
+	} else {
+		umcon &=3D ~S3C2410_UMCOM_AFC;
+	}
 	wr_regl(port, S3C2410_UMCON, umcon);
=20
 	if (ourport->info->has_divslot)
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
