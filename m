From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 01/45] drivers: tty: serial: 8250_bcm2835aux: use devm_platform_ioremap_resource()
Date: Thu, 14 Mar 2019 23:33:31 +0100
Message-ID: <1552602855-26086-2-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

For the common platform_get_resource()+devm_platform_ioremap() combination,
there is a helper, so use it and make the code a bit more compact.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index bd53661..0738d14 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -25,7 +25,6 @@ struct bcm2835aux_data {
 static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
 	struct bcm2835aux_data *data;
-	struct resource *res;
 	int ret;
 
 	/* allocate the custom structure */
@@ -63,15 +62,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	data->uart.port.irq = ret;
 
 	/* map the main registers */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "memory resource not found");
-		return -EINVAL;
-	}
-	data->uart.port.membase = devm_ioremap_resource(&pdev->dev, res);
+	data->uart.port.membase = devm_platform_ioremap_resource(pdev, 0);
 	ret = PTR_ERR_OR_ZERO(data->uart.port.membase);
-	if (ret)
+	if (ret) {
+		dev_err(&pdev->dev, "could not map memory resource");
 		return ret;
+	}
 
 	/* Check for a fixed line number */
 	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-- 
1.9.1
