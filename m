From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 14/45] drivers: tty: serial: vr41xx_siu: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:44 +0100
Message-ID: <1552602855-26086-15-git-send-email-info@metux.net>
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
 drivers/tty/serial/vr41xx_siu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 6d106e3..3f69603 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -617,12 +617,12 @@ static void siu_release_port(struct uart_port *port)
 	unsigned long size;
 
 	if (port->flags	& UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
 	size = siu_port_size(port);
-	release_mem_region(port->mapbase, size);
+	devm_release_mem_region(port->dev, port->mapbase, size);
 }
 
 static int siu_request_port(struct uart_port *port)
@@ -631,12 +631,15 @@ static int siu_request_port(struct uart_port *port)
 	struct resource *res;
 
 	size = siu_port_size(port);
-	res = request_mem_region(port->mapbase, size, siu_type_name(port));
+	res = devm_request_mem_region(port->dev,
+				      port->mapbase,
+				      size,
+				      siu_type_name(port));
 	if (res == NULL)
 		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
-		port->membase = ioremap(port->mapbase, size);
+		port->membase = devm_ioremap(port->dev, port->mapbase, size);
 		if (port->membase == NULL) {
 			release_resource(res);
 			return -ENOMEM;
-- 
1.9.1
