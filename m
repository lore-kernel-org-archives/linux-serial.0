From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 12/45] drivers: tty: serial: xilinx_uartps: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:42 +0100
Message-ID: <1552602855-26086-13-git-send-email-info@metux.net>
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
 drivers/tty/serial/xilinx_uartps.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 74089f5..6684ed7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -953,15 +953,21 @@ static int cdns_uart_verify_port(struct uart_port *port,
  */
 static int cdns_uart_request_port(struct uart_port *port)
 {
-	if (!request_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE,
-					 CDNS_UART_NAME)) {
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     CDNS_UART_REGISTER_SPACE,
+				     CDNS_UART_NAME)) {
 		return -ENOMEM;
 	}
 
-	port->membase = ioremap(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	port->membase = devm_ioremap(port->dev,
+				     port->mapbase,
+				     CDNS_UART_REGISTER_SPACE);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+		devm_release_mem_region(port->dev,
+					port->mapbase,
+					CDNS_UART_REGISTER_SPACE);
 		return -ENOMEM;
 	}
 	return 0;
@@ -976,8 +982,10 @@ static int cdns_uart_request_port(struct uart_port *port)
  */
 static void cdns_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
-	iounmap(port->membase);
+	devm_release_mem_region(port->dev,
+				port->mapbase,
+				CDNS_UART_REGISTER_SPACE);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 }
 
-- 
1.9.1
