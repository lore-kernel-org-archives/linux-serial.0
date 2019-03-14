From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 06/45] drivers: tty: serial: samsung: use devm_ioremap_resource()
Date: Thu, 14 Mar 2019 23:33:36 +0100
Message-ID: <1552602855-26086-7-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 83fd516..a49cf15 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1775,7 +1775,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	dbg("resource %pR)\n", res);
 
-	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
+	port->membase = devm_ioremap_resource(port->dev, res);
 	if (!port->membase) {
 		dev_err(port->dev, "failed to remap controller address\n");
 		return -EBUSY;
-- 
1.9.1
