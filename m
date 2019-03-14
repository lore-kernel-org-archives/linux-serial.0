From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 21/45] drivers: tty: serial: altera_jtaguart: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:51 +0100
Message-ID: <1552602855-26086-22-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/altera_jtaguart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index c90e503..13cab5d 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -448,7 +448,9 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
-	port->membase = ioremap(port->mapbase, ALTERA_JTAGUART_SIZE);
+	port->membase = devm_ioremap(port->dev,
+				     port->mapbase,
+				     ALTERA_JTAGUART_SIZE);
 	if (!port->membase)
 		return -ENOMEM;
 
@@ -474,7 +476,7 @@ static int altera_jtaguart_remove(struct platform_device *pdev)
 
 	port = &altera_jtaguart_ports[i].port;
 	uart_remove_one_port(&altera_jtaguart_driver, port);
-	iounmap(port->membase);
+	devm_iounmap(port->dev, port->membase);
 
 	return 0;
 }
-- 
1.9.1
