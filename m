From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 40/45] drivers: tty: serial: mpc52xx_uart: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:10 +0100
Message-ID: <1552602855-26086-41-git-send-email-info@metux.net>
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
 drivers/tty/serial/mpc52xx_uart.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3a75ee0..3e74e44 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1276,11 +1276,13 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 
 	/* remapped by us ? */
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
+	devm_release_mem_region(port->dev,
+				port->mapbase,
+				sizeof(struct mpc52xx_psc));
 }
 
 static int
@@ -1289,13 +1291,14 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 	int err;
 
 	if (port->flags & UPF_IOREMAP) /* Need to remap ? */
-		port->membase = ioremap(port->mapbase,
+		port->membase = devm_ioremap(port->dev, port->mapbase,
 					sizeof(struct mpc52xx_psc));
 
 	if (!port->membase)
 		return -EINVAL;
 
-	err = request_mem_region(port->mapbase, sizeof(struct mpc52xx_psc),
+	err = devm_request_mem_region(port->mapbase,
+			sizeof(struct mpc52xx_psc),
 			"mpc52xx_psc_uart") != NULL ? 0 : -EBUSY;
 
 	if (err)
@@ -1310,10 +1313,12 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 	return 0;
 
 out_mapregion:
-	release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
+	devm_release_mem_region(port->dev,
+				port->mapbase,
+				sizeof(struct mpc52xx_psc));
 out_membase:
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 	return err;
@@ -1653,7 +1658,9 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 	port->uartclk = uartclk;
 	port->ops	= &mpc52xx_uart_ops;
 	port->mapbase = res.start;
-	port->membase = ioremap(res.start, sizeof(struct mpc52xx_psc));
+	port->membase = devm_ioremap(port->dev,
+				     res.start,
+				     sizeof(struct mpc52xx_psc));
 	port->irq = irq_of_parse_and_map(np, 0);
 
 	if (port->membase == NULL)
-- 
1.9.1
