From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] serial: sh-sci: Do not start transfers from sci_startup()
Date: Thu, 26 May 2016 20:18:35 +0200
Message-ID: <1464286718-10745-2-git-send-email-geert+renesas@glider.be>
References: <1464286718-10745-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1464286718-10745-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

FIFO reset is done in sci_reset(), called from sci_set_termios(), while
sci_start_tx() and sci_start_rx() are called before, from sci_startup().
However, starting transfers before the UART's FIFOs have been reset may
cause reading of stale data.

Remove the calls to sci_start_tx() and sci_start_rx() from sci_startup()
to fix this.

Transfers are still started when needed:
  - sci_start_rx() is called from sci_set_termios() after FIFO reset, if
    the CREAD flag is set,
  - sci_start_tx() is called from uart_change_speed() immediately
    thereafter, if transmission is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0130feb069aee02f..d6ba90c572f7475c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1873,7 +1873,6 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 static int sci_startup(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
-	unsigned long flags;
 	int ret;
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
@@ -1884,11 +1883,6 @@ static int sci_startup(struct uart_port *port)
 
 	sci_request_dma(port);
 
-	spin_lock_irqsave(&port->lock, flags);
-	sci_start_tx(port);
-	sci_start_rx(port);
-	spin_unlock_irqrestore(&port->lock, flags);
-
 	return 0;
 }
 
-- 
1.9.1
