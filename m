From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH RESEND] tty: serial: 8250_mtk: Fix quot calculation
Date: Fri, 31 Oct 2014 17:36:35 +0100
Message-ID: <1414773395-9916-1-git-send-email-matthias.brugger@bq.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:42972 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbaJaQg6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 31 Oct 2014 12:36:58 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, jslaby@suse.cz, alan@linux.intel.com, matthias.bgg@gmail.com, heiko@sntech.de, yingjoe.chen@gmail.com, ibanezchen@gmail.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The calculation of value quot for highspeed register set to three
was wrong. This patch fixes the calculation so that the serial port
for baudrates bigger then 576000 baud is working correctly.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 8f37d57..de7aae5 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -81,7 +81,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		/* Set to highest baudrate supported */
 		if (baud >= 1152000)
 			baud = 921600;
-		quot = DIV_ROUND_CLOSEST(port->uartclk, 256 * baud);
+		quot = (port->uartclk / (256 * baud)) + 1;
 	}
 
 	/*
-- 
1.9.1

