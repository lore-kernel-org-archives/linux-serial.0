From: Emil Goode <emilgoode@gmail.com>
Subject: [PATCH 1/2] tty: serial: Check return code of gpiochip_remove
Date: Sat, 18 Aug 2012 18:12:48 +0200
Message-ID: <1345306369-10407-1-git-send-email-emilgoode@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55057 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751817Ab2HRQJO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Aug 2012 12:09:14 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>

The gpiochip_remove function may fail to remove a gpio_chip
if any GPIOs are still requested. This patch informs the caller
of such a senario.

Sparse is warning because the function prototype has a
__must_check annotation.

Sparse warning:
drivers/tty/serial/max310x.c:1223:18: warning:
	ignoring return value of =E2=80=98gpiochip_remove=E2=80=99,
	declared with attribute warn_unused_result
	[-Wunused-result]

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 drivers/tty/serial/max310x.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.=
c
index 534e448..06ff5ad 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1207,6 +1207,7 @@ static int __devexit max310x_remove(struct spi_de=
vice *spi)
 {
 	struct device *dev =3D &spi->dev;
 	struct max310x_port *s =3D dev_get_drvdata(dev);
+	int ret =3D 0;
=20
 	dev_dbg(dev, "Removing port\n");
=20
@@ -1219,8 +1220,11 @@ static int __devexit max310x_remove(struct spi_d=
evice *spi)
 	uart_unregister_driver(&s->uart);
=20
 #ifdef CONFIG_GPIOLIB
-	if (s->pdata->gpio_base)
-		gpiochip_remove(&s->gpio);
+	if (s->pdata->gpio_base) {
+		ret =3D gpiochip_remove(&s->gpio);
+		if (ret)
+			dev_err(dev, "Failed to remove gpio chip: %d\n", ret);
+	}
 #endif
=20
 	dev_set_drvdata(dev, NULL);
@@ -1232,7 +1236,7 @@ static int __devexit max310x_remove(struct spi_de=
vice *spi)
=20
 	devm_kfree(dev, s);
=20
-	return 0;
+	return ret;
 }
=20
 static const struct spi_device_id max310x_id_table[] =3D {
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
