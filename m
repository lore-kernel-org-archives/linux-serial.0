From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 18/45] drivers: tty: serial: sirfsoc_uart: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:48 +0100
Message-ID: <1552602855-26086-19-git-send-email-info@metux.net>
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
 drivers/tty/serial/sirfsoc_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index db2e08d..64ea1e7 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1042,14 +1042,14 @@ static int sirfsoc_uart_request_port(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_uart_param *uart_param = &sirfport->uart_reg->uart_param;
 	void *ret;
-	ret = request_mem_region(port->mapbase,
+	ret = devm_request_mem_region(port->dev, port->mapbase,
 		SIRFUART_MAP_SIZE, uart_param->port_name);
 	return ret ? 0 : -EBUSY;
 }
 
 static void sirfsoc_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, SIRFUART_MAP_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, SIRFUART_MAP_SIZE);
 }
 
 static void sirfsoc_uart_config_port(struct uart_port *port, int flags)
-- 
1.9.1
