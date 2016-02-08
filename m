From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH] tty: serial: meson: Add support for XTAL clock input
Date: Mon,  8 Feb 2016 13:49:42 +0100
Message-ID: <1454935783-17027-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-meson@googlegroups.com
Cc: Carlo Caione <carlo@caione.org>, linux-arm-kernel@lists.infradead.org, Matthias Brugger <mbrugger@suse.com>, Nicolas Saenz <nicolassaenzj@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

=46ix the baudrate calculation for 24 MHz XTAL clock found on gxbb plat=
forms.

Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 Forward-ported from vendor kernel. On top of my meson earlycon patch.
=20
 drivers/tty/serial/meson_uart.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson=
_uart.c
index 9efcfa2de31e..4415631bab17 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -78,6 +78,7 @@
 /* AML_UART_REG5 bits */
 #define AML_UART_BAUD_MASK		0x7fffff
 #define AML_UART_BAUD_USE		BIT(23)
+#define AML_UART_BAUD_XTAL		BIT(24)
=20
 #define AML_UART_PORT_NUM		6
 #define AML_UART_DEV_NAME		"ttyAML"
@@ -299,7 +300,12 @@ static void meson_uart_change_speed(struct uart_po=
rt *port, unsigned long baud)
=20
 	val =3D readl(port->membase + AML_UART_REG5);
 	val &=3D ~AML_UART_BAUD_MASK;
-	val =3D ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
+	if (port->uartclk =3D=3D 24000000) {
+		val =3D ((port->uartclk / 3) / baud) - 1;
+		val |=3D AML_UART_BAUD_XTAL;
+	} else {
+		val =3D ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
+	}
 	val |=3D AML_UART_BAUD_USE;
 	writel(val, port->membase + AML_UART_REG5);
 }
--=20
2.6.2
