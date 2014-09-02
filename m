From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 07/26] serial: mpc52xx: Use default serial core x_char handler
Date: Tue,  2 Sep 2014 17:39:16 -0400
Message-ID: <1409693975-1028-8-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

mpc52xx_uart_send_xchar() is _identical_ to the default serial core
x_char handling behavior in uart_send_xchar().

Remove mpc52xx_uart_send_xchar().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/mpc52xx_uart.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 97888f4..a5f4e36 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1087,22 +1087,6 @@ mpc52xx_uart_start_tx(struct uart_port *port)
 }
 
 static void
-mpc52xx_uart_send_xchar(struct uart_port *port, char ch)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&port->lock, flags);
-
-	port->x_char = ch;
-	if (ch) {
-		/* Make sure tx interrupts are on */
-		/* Truly necessary ??? They should be anyway */
-		psc_ops->start_tx(port);
-	}
-
-	spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static void
 mpc52xx_uart_stop_rx(struct uart_port *port)
 {
 	/* port->lock taken by caller */
@@ -1361,7 +1345,6 @@ static struct uart_ops mpc52xx_uart_ops = {
 	.get_mctrl	= mpc52xx_uart_get_mctrl,
 	.stop_tx	= mpc52xx_uart_stop_tx,
 	.start_tx	= mpc52xx_uart_start_tx,
-	.send_xchar	= mpc52xx_uart_send_xchar,
 	.stop_rx	= mpc52xx_uart_stop_rx,
 	.enable_ms	= mpc52xx_uart_enable_ms,
 	.break_ctl	= mpc52xx_uart_break_ctl,
-- 
2.1.0
