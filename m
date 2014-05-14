From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: imx: Disable new features of autobaud detection
Date: Wed, 14 May 2014 15:55:03 -0300
Message-ID: <1400093703-10128-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35757 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaENSzR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 May 2014 14:55:17 -0400
Received: by mail-yk0-f175.google.com with SMTP id 131so1944550ykp.34
        for <linux-serial@vger.kernel.org>; Wed, 14 May 2014 11:55:16 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com, shawn.guo@freescale.com, kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Bit 7 of UCR3 is described in the i.MX reference manuals (with the exception
of i.MX1) as follows:

ADNIMP: Autobaud Detection Not Improved-. Disables new features of
	autobaud detection (See Baud Rate Automatic Detection
	Protocol, for more details).

	0 Autobaud detection new features selected
	1 Keep old autobaud detection mechanism

The "new features" mechanism occasionally cause the receiver to get out of sync 
and continuously produce received characters of '\xff'.

In order to reproduce the problem:

$ stty -F /dev/ttymxc0 19200

- Change the terminal baudrate to 19200

- Type in the console and it should look good

- Change the terminal baudrate back to 115200

- Type 'b' in the console, then a stream of garbage characters is seen.

Also rename the bit definition as per the reference manual.

Tested on mx6q, mx6dl, mx6solo and mx53.

Based on a patch from Eric Nelson for U-boot.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3b6c1a2..392154d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -116,7 +116,7 @@
 #define UCR3_DSR	(1<<10) /* Data set ready */
 #define UCR3_DCD	(1<<9)	/* Data carrier detect */
 #define UCR3_RI		(1<<8)	/* Ring indicator */
-#define UCR3_TIMEOUTEN	(1<<7)	/* Timeout interrupt enable */
+#define UCR3_ADNIMP	(1<<7)	/* Autobaud Detection Not Improved */
 #define UCR3_RXDSEN	(1<<6)	/* Receive status interrupt enable */
 #define UCR3_AIRINTEN	(1<<5)	/* Async IR wake interrupt enable */
 #define UCR3_AWAKEN	(1<<4)	/* Async wake interrupt enable */
@@ -1174,7 +1174,7 @@ static int imx_startup(struct uart_port *port)
 
 	if (!is_imx1_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
-		temp |= IMX21_UCR3_RXDMUXSEL;
+		temp |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP;
 		writel(temp, sport->port.membase + UCR3);
 	}
 
-- 
1.8.3.2

