From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 35/45] drivers: tty: serial: lpc32xx_hs: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:05 +0100
Message-ID: <1552602855-26086-36-git-send-email-info@metux.net>
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
 drivers/tty/serial/lpc32xx_hs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index f4e27d0..0bb86d7 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -575,11 +575,11 @@ static void serial_lpc32xx_release_port(struct uart_port *port)
 {
 	if ((port->iotype == UPIO_MEM32) && (port->mapbase)) {
 		if (port->flags & UPF_IOREMAP) {
-			iounmap(port->membase);
+			devm_iounmap(port->dev, port->membase);
 			port->membase = NULL;
 		}
 
-		release_mem_region(port->mapbase, SZ_4K);
+		devm_release_mem_region(port->dev, port->mapbase, SZ_4K);
 	}
 }
 
@@ -590,12 +590,19 @@ static int serial_lpc32xx_request_port(struct uart_port *port)
 	if ((port->iotype == UPIO_MEM32) && (port->mapbase)) {
 		ret = 0;
 
-		if (!request_mem_region(port->mapbase, SZ_4K, MODNAME))
+		if (!devm_request_mem_region(port->dev,
+					     port->mapbase,
+					     SZ_4K,
+					     MODNAME))
 			ret = -EBUSY;
 		else if (port->flags & UPF_IOREMAP) {
-			port->membase = ioremap(port->mapbase, SZ_4K);
+			port->membase = devm_ioremap(port->dev,
+						     port->mapbase,
+						     SZ_4K);
 			if (!port->membase) {
-				release_mem_region(port->mapbase, SZ_4K);
+				devm_release_mem_region(port->dev,
+							port->mapbase,
+							SZ_4K);
 				ret = -ENOMEM;
 			}
 		}
-- 
1.9.1
