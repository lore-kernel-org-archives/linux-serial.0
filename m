From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 16/45] drivers: tty: serial: uartlite: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:46 +0100
Message-ID: <1552602855-26086-17-git-send-email-info@metux.net>
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
 drivers/tty/serial/uartlite.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index aa461b8..f068d00 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -342,8 +342,8 @@ static const char *ulite_type(struct uart_port *port)
 
 static void ulite_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, ULITE_REGION);
-	iounmap(port->membase);
+	devm_release_mem_region(port->dev, port->mapbase, ULITE_REGION);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 }
 
@@ -355,15 +355,20 @@ static int ulite_request_port(struct uart_port *port)
 	dev_dbg(port->dev, "ulite console: port=%p; port->mapbase=%llx\n",
 		 port, (unsigned long long) port->mapbase);
 
-	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     ULITE_REGION,
+				     "uartlite")) {
 		dev_err(port->dev, "Memory region busy\n");
 		return -EBUSY;
 	}
 
-	port->membase = ioremap(port->mapbase, ULITE_REGION);
+	port->membase = devm_ioremap(port->dev, port->mapbase, ULITE_REGION);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, ULITE_REGION);
+		devm_release_mem_region(port->dev,
+					port->mapbase,
+					ULITE_REGION);
 		return -EBUSY;
 	}
 
-- 
1.9.1
