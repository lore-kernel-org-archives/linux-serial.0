From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/3] serial: imx: Use dev_name() for request_irq() to distinguish UARTs
Date: Sat, 22 Feb 2014 16:01:34 +0400
Message-ID: <1393070495-11220-2-git-send-email-shc_work@mail.ru>
References: <1393070495-11220-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp40.i.mail.ru ([94.100.177.100]:49729 "EHLO smtp40.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbaBVMBs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 22 Feb 2014 07:01:48 -0500
In-Reply-To: <1393070495-11220-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d185972..37c3939 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1116,25 +1116,25 @@ static int imx_startup(struct uart_port *port)
 	 */
 	if (sport->txirq > 0) {
 		retval = request_irq(sport->rxirq, imx_rxint, 0,
-				DRIVER_NAME, sport);
+				     dev_name(port->dev), sport);
 		if (retval)
 			goto error_out1;
 
 		retval = request_irq(sport->txirq, imx_txint, 0,
-				DRIVER_NAME, sport);
+				     dev_name(port->dev), sport);
 		if (retval)
 			goto error_out2;
 
 		/* do not use RTS IRQ on IrDA */
 		if (!USE_IRDA(sport)) {
 			retval = request_irq(sport->rtsirq, imx_rtsint, 0,
-					DRIVER_NAME, sport);
+					     dev_name(port->dev), sport);
 			if (retval)
 				goto error_out3;
 		}
 	} else {
 		retval = request_irq(sport->port.irq, imx_int, 0,
-				DRIVER_NAME, sport);
+				     dev_name(port->dev), sport);
 		if (retval) {
 			free_irq(sport->port.irq, sport);
 			goto error_out1;
-- 
1.8.3.2

