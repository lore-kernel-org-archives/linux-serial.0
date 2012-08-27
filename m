From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] tty: serial: mpc5xxx: add support for mark/space parity
Date: Mon, 27 Aug 2012 16:03:14 +0200
Message-ID: <1346076194-1830-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55166 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab2H0ODW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Aug 2012 10:03:22 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>, Anatolij Gustschin <agust@denx.de>, Greg KH <gregkh@linuxfoundation.org>

Tested on a custom MPC5200B-board using some fancy industrial protocol.
Verified that MPC512x has identical bits, so should work there as well.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Greg KH <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/mpc52xx_uart.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index bedac0d..f19d04e 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -775,11 +775,15 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	}
 
 	if (new->c_cflag & PARENB) {
+		if (new->c_cflag & CMSPAR)
+			mr1 |= MPC52xx_PSC_MODE_PARFORCE;
+
+		/* With CMSPAR, PARODD also means high parity (same as termios) */
 		mr1 |= (new->c_cflag & PARODD) ?
 			MPC52xx_PSC_MODE_PARODD : MPC52xx_PSC_MODE_PAREVEN;
-	} else
+	} else {
 		mr1 |= MPC52xx_PSC_MODE_PARNONE;
-
+	}
 
 	mr2 = 0;
 
-- 
1.7.10.4

