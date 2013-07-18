From: Hubert Feurstein <h.feurstein@gmail.com>
Subject: [PATCH] serial/imx: fix custom-baudrate handling
Date: Thu, 18 Jul 2013 18:52:49 +0200
Message-ID: <1374166369-20342-1-git-send-email-h.feurstein@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:57864 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab3GRQxC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Jul 2013 12:53:02 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Hubert Feurstein <h.feurstein@gmail.com>

It was not possible to set custom-baudrates like 62500.

Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
---
 drivers/tty/serial/imx.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 415cec6..a6671ed 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1020,6 +1020,11 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 		 */
 		div = 1;
 	} else {
+		/* custom-baudrate handling */
+		div = sport->port.uartclk / (baud * 16);
+		if (baud == 38400 && quot != div)
+			baud = sport->port.uartclk / (quot * 16);
+
 		div = sport->port.uartclk / (baud * 16);
 		if (div > 7)
 			div = 7;
-- 
1.7.9.5

