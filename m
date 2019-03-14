From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 23/45] drivers: tty: serial: amba-pl010: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:53 +0100
Message-ID: <1552602855-26086-24-git-send-email-info@metux.net>
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
 drivers/tty/serial/amba-pl010.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 109b8df..7abd1f8 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -503,7 +503,7 @@ static const char *pl010_type(struct uart_port *port)
  */
 static void pl010_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -511,7 +511,10 @@ static void pl010_release_port(struct uart_port *port)
  */
 static int pl010_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, UART_PORT_SIZE, "uart-pl010")
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       UART_PORT_SIZE,
+				       "uart-pl010")
 			!= NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1
