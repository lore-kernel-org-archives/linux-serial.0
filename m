From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Tue, 21 Jul 2015 13:34:52 -0700
Message-ID: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com, Jesper Nilsson <jesper.nilsson@axis.com>, Guenter Roeck <linux@roeck-us.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get function=
s")
makes the flags argument to devm_gpiod_get_optional mandatory but does =
not
update all users. This results in the following build error.

drivers/tty/serial/etraxfs-uart.c:933:16: error:
	too few arguments to function =E2=80=98devm_gpiod_get_optional=E2=80=99

=46ixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get functi=
ons")
Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/etraxfs-uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/etraxfs-uart.c b/drivers/tty/serial/etr=
axfs-uart.c
index a57301a6fe42..e35a19b214d5 100644
--- a/drivers/tty/serial/etraxfs-uart.c
+++ b/drivers/tty/serial/etraxfs-uart.c
@@ -930,10 +930,10 @@ static int etraxfs_uart_probe(struct platform_dev=
ice *pdev)
=20
 	up->irq =3D irq_of_parse_and_map(np, 0);
 	up->regi_ser =3D of_iomap(np, 0);
-	up->dtr_pin =3D devm_gpiod_get_optional(&pdev->dev, "dtr");
-	up->dsr_pin =3D devm_gpiod_get_optional(&pdev->dev, "dsr");
-	up->ri_pin =3D devm_gpiod_get_optional(&pdev->dev, "ri");
-	up->cd_pin =3D devm_gpiod_get_optional(&pdev->dev, "cd");
+	up->dtr_pin =3D devm_gpiod_get_optional(&pdev->dev, "dtr", GPIOD_ASIS=
);
+	up->dsr_pin =3D devm_gpiod_get_optional(&pdev->dev, "dsr", GPIOD_ASIS=
);
+	up->ri_pin =3D devm_gpiod_get_optional(&pdev->dev, "ri", GPIOD_ASIS);
+	up->cd_pin =3D devm_gpiod_get_optional(&pdev->dev, "cd", GPIOD_ASIS);
 	up->port.dev =3D &pdev->dev;
 	cris_serial_port_init(&up->port, dev_id);
=20
--=20
2.1.0
