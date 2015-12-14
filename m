From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 16/27] serial: sh-sci: Take into account sampling rate for max baud rate
Date: Mon, 14 Dec 2015 19:57:25 +0100
Message-ID: <1450119456-964-17-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The maximum baud rate depends on the sampling rate.
HSCIF has a variable sampling rate and sets s->sampling_rate to zero,
hence use the minimum sampling rate of 8.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Reviewed-by, Acked-by.
---
 drivers/tty/serial/sh-sci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d89d4b7576cf3a15..5b120757c02a555a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1975,7 +1975,10 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * that the previous boot loader has enabled required clocks and
 	 * setup the baud rate generator hardware for us already.
 	 */
-	max_baud = port->uartclk ? port->uartclk / 16 : 115200;
+	if (port->uartclk)
+		max_baud = port->uartclk / max(s->sampling_rate, 8U);
+	else
+		max_baud = 115200;
 
 	baud = uart_get_baud_rate(port, termios, old, 0, max_baud);
 	if (likely(baud && port->uartclk))
-- 
1.9.1

