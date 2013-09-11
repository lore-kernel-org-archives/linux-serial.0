From: =?UTF-8?q?Jos=C3=A9=20Miguel=20Gon=C3=A7alves?=
	<jose.goncalves@inov.pt>
Subject: [PATCH] serial: samsung: add support for manual RTS setting
Date: Wed, 11 Sep 2013 11:08:27 +0100
Message-ID: <1378894107-7904-1-git-send-email-jose.goncalves@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, =?UTF-8?q?Jos=C3=A9=20Miguel=20Gon=C3=A7alves?= <jose.goncalves@inov.pt>
List-Id: linux-serial@vger.kernel.org

The Samsung serial driver currently does not support setting the
RTS pin with an ioctl(TIOCMSET) call. This patch adds this support.

Signed-off-by: Jos=C3=A9 Miguel Gon=C3=A7alves <jose.goncalves@inov.pt>
---
 drivers/tty/serial/samsung.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.=
c
index f3dfa19..e5dd808 100644
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
@@ -792,6 +797,12 @@ static void s3c24xx_serial_set_termios(struct uart=
_port *port,
=20
 	wr_regl(port, S3C2410_ULCON, ulcon);
 	wr_regl(port, S3C2410_UBRDIV, quot);
+
+	if (termios->c_cflag & CRTSCTS)
+		umcon =3D S3C2410_UMCOM_AFC;
+	else
+		umcon =3D rd_regb(port, S3C2410_UMCON) & ~S3C2410_UMCOM_AFC;
+
 	wr_regl(port, S3C2410_UMCON, umcon);
=20
 	if (ourport->info->has_divslot)
--=20
1.7.10.4
