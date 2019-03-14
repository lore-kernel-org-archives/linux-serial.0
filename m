From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 17/45] drivers: tty: serial: timuart: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:47 +0100
Message-ID: <1552602855-26086-18-git-send-email-info@metux.net>
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
 drivers/tty/serial/timbuart.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 19d38b5..292354b 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -319,11 +319,11 @@ static void timbuart_release_port(struct uart_port *port)
 		resource_size(platform_get_resource(pdev, IORESOURCE_MEM, 0));
 
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, size);
+	devm_release_mem_region(port->dev, port->mapbase, size);
 }
 
 static int timbuart_request_port(struct uart_port *port)
@@ -332,13 +332,18 @@ static int timbuart_request_port(struct uart_port *port)
 	int size =
 		resource_size(platform_get_resource(pdev, IORESOURCE_MEM, 0));
 
-	if (!request_mem_region(port->mapbase, size, "timb-uart"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     size,
+				     "timb-uart"))
 		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
 		port->membase = ioremap(port->mapbase, size);
 		if (port->membase == NULL) {
-			release_mem_region(port->mapbase, size);
+			devm-release_mem_region(port->dev,
+						port->mapbase,
+						size);
 			return -ENOMEM;
 		}
 	}
-- 
1.9.1
