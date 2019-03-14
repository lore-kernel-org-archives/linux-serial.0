From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 41/45] drivers: tty: serial: timuart: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:11 +0100
Message-ID: <1552602855-26086-42-git-send-email-info@metux.net>
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
 drivers/tty/serial/men_z135_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index ef89534..349f70e 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -732,7 +732,7 @@ static void men_z135_release_port(struct uart_port *port)
 {
 	struct men_z135_port *uart = to_men_z135(port);
 
-	iounmap(port->membase);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 
 	mcb_release_mem(uart->mem);
@@ -751,7 +751,7 @@ static int men_z135_request_port(struct uart_port *port)
 	port->mapbase = mem->start;
 	uart->mem = mem;
 
-	port->membase = ioremap(mem->start, resource_size(mem));
+	port->membase = devm_ioremap_resource(port->dev, mem);
 	if (port->membase == NULL) {
 		mcb_release_mem(mem);
 		return -ENOMEM;
-- 
1.9.1
