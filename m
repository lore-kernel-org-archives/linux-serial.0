From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Date: Tue,  9 Feb 2016 07:08:59 -0800
Message-ID: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Baruch Siach <baruch@tkos.co.il>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-serial@vger.kernel.org

IS_ERR_VALUE() assumes that its parameter is an unsigned long.
It can not be used to check if an unsigned int reflects an error.
Doing so can result in the following build warning.

drivers/tty/serial/digicolor-usart.c: In function =E2=80=98digicolor_ua=
rt_probe=E2=80=99:
include/linux/err.h:21:38: warning:
	comparison is always false due to limited range of data type
drivers/tty/serial/digicolor-usart.c:485:6: note:
	in expansion of macro =E2=80=98IS_ERR_VALUE=E2=80=99

If that warning is seen, an error return from platform_get_irq() is mis=
sed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/digicolor-usart.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/=
digicolor-usart.c
index a80cdad114f3..02ad6953b167 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -453,7 +453,7 @@ static struct uart_driver digicolor_uart =3D {
 static int digicolor_uart_probe(struct platform_device *pdev)
 {
 	struct device_node *np =3D pdev->dev.of_node;
-	int ret, index;
+	int irq, ret, index;
 	struct digicolor_port *dp;
 	struct resource *res;
 	struct clk *uart_clk;
@@ -481,9 +481,10 @@ static int digicolor_uart_probe(struct platform_de=
vice *pdev)
 	if (IS_ERR(dp->port.membase))
 		return PTR_ERR(dp->port.membase);
=20
-	dp->port.irq =3D platform_get_irq(pdev, 0);
-	if (IS_ERR_VALUE(dp->port.irq))
-		return dp->port.irq;
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	dp->port.irq =3D irq;
=20
 	dp->port.iotype =3D UPIO_MEM;
 	dp->port.uartclk =3D clk_get_rate(uart_clk);
--=20
2.5.0
