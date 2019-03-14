From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 29/45] drivers: tty: serial: serial_txx9: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:59 +0100
Message-ID: <1552602855-26086-30-git-send-email-info@metux.net>
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
 drivers/tty/serial/serial_txx9.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 1b4008d..aa01349 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -757,15 +757,22 @@ static int serial_txx9_request_resource(struct uart_txx9_port *up)
 		if (!up->port.mapbase)
 			break;
 
-		if (!request_mem_region(up->port.mapbase, size, "serial_txx9")) {
+		if (!devm_request_mem_region(up->port.dev,
+					     up->port.mapbase,
+					     size,
+					     "serial_txx9")) {
 			ret = -EBUSY;
 			break;
 		}
 
 		if (up->port.flags & UPF_IOREMAP) {
-			up->port.membase = ioremap(up->port.mapbase, size);
+			up->port.membase = devm_ioremap(up->port.dev,
+							up->port.mapbase,
+							size);
 			if (!up->port.membase) {
-				release_mem_region(up->port.mapbase, size);
+				devm_release_mem_region(up->port.dev,
+							up->port.mapbase,
+							size);
 				ret = -ENOMEM;
 			}
 		}
@@ -789,11 +796,11 @@ static void serial_txx9_release_resource(struct uart_txx9_port *up)
 			break;
 
 		if (up->port.flags & UPF_IOREMAP) {
-			iounmap(up->port.membase);
+			devm_iounmap(up->port.dev, up->port.membase);
 			up->port.membase = NULL;
 		}
 
-		release_mem_region(up->port.mapbase, size);
+		devm_release_mem_region(up->port.dev, up->port.mapbase, size);
 		break;
 
 	case UPIO_PORT:
-- 
1.9.1
