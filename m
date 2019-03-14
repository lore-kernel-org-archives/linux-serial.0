From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 37/45] drivers: tty: serial: apbuart: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:07 +0100
Message-ID: <1552602855-26086-38-git-send-email-info@metux.net>
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
 drivers/tty/serial/apbuart.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 60cd133..5eaaee9 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -293,12 +293,15 @@ static const char *apbuart_type(struct uart_port *port)
 
 static void apbuart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, 0x100);
+	devm_release_mem_region(port->dev, port->mapbase, 0x100);
 }
 
 static int apbuart_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, 0x100, "grlib-apbuart")
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       0x100,
+				       "grlib-apbuart")
 	    != NULL ? 0 : -EBUSY;
 	return 0;
 }
@@ -622,7 +625,9 @@ static int __init grlib_apbuart_configure(void)
 		port = &grlib_apbuart_ports[line];
 
 		port->mapbase = addr;
-		port->membase = ioremap(addr, sizeof(struct grlib_apbuart_regs_map));
+		port->membase = devm_ioremap(port->dev,
+					     addr,
+					     sizeof(struct grlib_apbuart_regs_map));
 		port->irq = 0;
 		port->iotype = UPIO_MEM;
 		port->ops = &grlib_apbuart_ops;
-- 
1.9.1
