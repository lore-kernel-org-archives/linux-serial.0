From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 39/45] drivers: tty: serial: efm32-uart: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:09 +0100
Message-ID: <1552602855-26086-40-git-send-email-info@metux.net>
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
 drivers/tty/serial/efm32-uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index d6b5e54..a79cadc 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -437,7 +437,7 @@ static void efm32_uart_release_port(struct uart_port *port)
 
 	clk_unprepare(efm_port->clk);
 	clk_put(efm_port->clk);
-	iounmap(port->membase);
+	devm_iounmap(port->dev, port->membase);
 }
 
 static int efm32_uart_request_port(struct uart_port *port)
@@ -445,7 +445,7 @@ static int efm32_uart_request_port(struct uart_port *port)
 	struct efm32_uart_port *efm_port = to_efm_port(port);
 	int ret;
 
-	port->membase = ioremap(port->mapbase, 60);
+	port->membase = devm_ioremap(port->dev, port->mapbase, 60);
 	if (!efm_port->port.membase) {
 		ret = -ENOMEM;
 		efm_debug(efm_port, "failed to remap\n");
@@ -464,7 +464,7 @@ static int efm32_uart_request_port(struct uart_port *port)
 		clk_put(efm_port->clk);
 err_clk_get:
 
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 err_ioremap:
 		return ret;
 	}
-- 
1.9.1
