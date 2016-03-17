From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 3/5] serial: sh-sci: Always set TIOCM_CTS in .get_mctrl() callback
Date: Thu, 17 Mar 2016 14:47:27 +0100
Message-ID: <1458222449-12324-4-git-send-email-geert+renesas@glider.be>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Documentation/serial/driver clearly states:

    If the port does not support CTS, DCD or DSR, the driver should
    indicate that the signal is permanently active.

Hence always set TIOCM_CTS, as we currently don't look at the CTS
hardware line state at all.

FWIW, this fixes the transmit path when hardware-assisted flow control
is enabled, and userspace enables CRTSCTS.
The receive path is still broken, as RTS is never asserted.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0130feb069aee02f..135f836642ab1c5a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1835,9 +1835,9 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
 {
 	/*
 	 * CTS/RTS is handled in hardware when supported, while nothing
-	 * else is wired up. Keep it simple and simply assert DSR/CAR.
+	 * else is wired up. Keep it simple and simply assert CTS/DSR/CAR.
 	 */
-	return TIOCM_DSR | TIOCM_CAR;
+	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
 }
 
 static void sci_break_ctl(struct uart_port *port, int break_state)
-- 
1.9.1
