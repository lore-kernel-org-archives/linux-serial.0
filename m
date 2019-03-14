From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 44/45] drivers: tty: serial: pnx8xxx_uart: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:14 +0100
Message-ID: <1552602855-26086-45-git-send-email-info@metux.net>
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
 drivers/tty/serial/pnx8xxx_uart.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 223a949..3951226 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -568,10 +568,7 @@ static const char *pnx8xxx_type(struct uart_port *port)
  */
 static void pnx8xxx_release_port(struct uart_port *port)
 {
-	struct pnx8xxx_port *sport =
-		container_of(port, struct pnx8xxx_port, port);
-
-	release_mem_region(sport->port.mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -579,9 +576,7 @@ static void pnx8xxx_release_port(struct uart_port *port)
  */
 static int pnx8xxx_request_port(struct uart_port *port)
 {
-	struct pnx8xxx_port *sport =
-		container_of(port, struct pnx8xxx_port, port);
-	return request_mem_region(sport->port.mapbase, UART_PORT_SIZE,
+	return devm_request_mem_region(port->dev, port->mapbase, UART_PORT_SIZE,
 			"pnx8xxx-uart") != NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1
