From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: [PATCH] serial: imx: Avoid probe failure in case of missing gpiolib
Date: Thu, 1 Aug 2019 08:18:05 +0000
Message-ID: <20190801081524.22577-1-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: Schrempf Frieder <frieder.schrempf@kontron.de>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() will return
-ENOSYS and cause the probing of the imx UART to fail. As the
GPIOs are optional, we should continue probing in this case.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/tty/serial/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 10db3e54ac9e..51714498dacf 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2237,7 +2237,9 @@ static int imx_uart_probe(struct platform_device *pdev)
 	timer_setup(&sport->timer, imx_uart_timeout, 0);
 
 	sport->gpios = mctrl_gpio_init(&sport->port, 0);
-	if (IS_ERR(sport->gpios))
+	if (PTR_ERR(sport->gpios) == -ENOSYS)
+		sport->gpios = NULL;
+	else if (IS_ERR(sport->gpios))
 		return PTR_ERR(sport->gpios);
 
 	sport->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-- 
2.17.1
