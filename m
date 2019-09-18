From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] serial: bcm2835: Use devm_platform_ioremap_resource() in
 bcm2835aux_serial_probe()
Date: Wed, 18 Sep 2019 22:12:40 +0200
Message-ID: <fcb34c72-89c7-9993-fc0a-ba3a61708bec@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Martin Sperl <kernel@martin.sperl.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, Stephen Boyd <swboyd@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 22:00:14 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/tty/serial/8250/8250_bcm2835aux.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/seria=
l/8250/8250_bcm2835aux.c
index 8ce700c1a7fc..e2c9d19fc8e9 100644
=2D-- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -25,7 +25,6 @@ struct bcm2835aux_data {
 static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
 	struct bcm2835aux_data *data;
-	struct resource *res;
 	int ret;

 	/* allocate the custom structure */
@@ -61,12 +60,7 @@ static int bcm2835aux_serial_probe(struct platform_devi=
ce *pdev)
 	data->uart.port.irq =3D ret;

 	/* map the main registers */
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "memory resource not found");
-		return -EINVAL;
-	}
-	data->uart.port.membase =3D devm_ioremap_resource(&pdev->dev, res);
+	data->uart.port.membase =3D devm_platform_ioremap_resource(pdev, 0);
 	ret =3D PTR_ERR_OR_ZERO(data->uart.port.membase);
 	if (ret)
 		return ret;
=2D-
2.23.0
