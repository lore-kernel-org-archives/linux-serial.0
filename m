From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 22/45] drivers: tty: serial: altera_uart: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:52 +0100
Message-ID: <1552602855-26086-23-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Use the safer devm versions of memory mapping functions.
The iounmap() call isn't necessary anymore, as devm will clean up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/altera_uart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 0e487ce..d4f7150 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -595,7 +595,9 @@ static int altera_uart_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	port->membase = ioremap(port->mapbase, ALTERA_UART_SIZE);
+	port->membase = devm_ioremap(port->dev,
+				     port->mapbase,
+				     ALTERA_UART_SIZE);
 	if (!port->membase)
 		return -ENOMEM;
 
@@ -625,7 +627,6 @@ static int altera_uart_remove(struct platform_device *pdev)
 	if (port) {
 		uart_remove_one_port(&altera_uart_driver, port);
 		port->mapbase = 0;
-		iounmap(port->membase);
 	}
 
 	return 0;
-- 
1.9.1
