From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 19/45] drivers: tty: serial: sh-sci: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:49 +0100
Message-ID: <1552602855-26086-20-git-send-email-info@metux.net>
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
 drivers/tty/serial/sh-sci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 060fcd4..e40b0d0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2667,7 +2667,9 @@ static int sci_remap_port(struct uart_port *port)
 		return 0;
 
 	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
-		port->membase = ioremap_nocache(port->mapbase, sport->reg_size);
+		port->membase = devm_ioremap_nocache(port->dev,
+						     port->mapbase,
+						     sport->reg_size);
 		if (unlikely(!port->membase)) {
 			dev_err(port->dev, "can't remap port#%d\n", port->line);
 			return -ENXIO;
@@ -2689,11 +2691,11 @@ static void sci_release_port(struct uart_port *port)
 	struct sci_port *sport = to_sci_port(port);
 
 	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, sport->reg_size);
+	devm_release_mem_region(port->dev, port->mapbase, sport->reg_size);
 }
 
 static int sci_request_port(struct uart_port *port)
@@ -2702,8 +2704,10 @@ static int sci_request_port(struct uart_port *port)
 	struct sci_port *sport = to_sci_port(port);
 	int ret;
 
-	res = request_mem_region(port->mapbase, sport->reg_size,
-				 dev_name(port->dev));
+	res = devm_request_mem_region(port->dev,
+				      port->mapbase,
+				      sport->reg_size,
+				      dev_name(port->dev));
 	if (unlikely(res == NULL)) {
 		dev_err(port->dev, "request_mem_region failed.");
 		return -EBUSY;
-- 
1.9.1
