From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 01/47] serial: sh-sci: Don't enable/disable port from within break timer
Date: Fri,  6 Dec 2013 10:59:08 +0100
Message-ID: <1386323994-12850-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

The break timer accesses hardware registers and thus requires the port
to be enabled. It currently ensures this by enabling the port at the
beginning of the timer handler, and disabling it at the end. However,
the enable/disable operations call the runtime PM sync functions, which
are not allowed in atomic context. The current situation is thus broken.

This change relies on non-atomic code to enable/disable the port. The
break timer will only be started from the IRQ handler, which already
runs with the port enabled. We just need to ensure that the port won't
be disabled with the timer running, and that's easily done by just
cancelling the timer in the port disable function.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7d8103c..e3384a2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -431,6 +431,14 @@ static void sci_port_disable(struct sci_port *sci_port)
 	if (!sci_port->port.dev)
 		return;
 
+	/* Cancel the break timer to ensure that the timer handler will not try
+	 * to access the hardware with clocks and power disabled. Reset the
+	 * break flag to make the break debouncing state machine ready for the
+	 * next break.
+	 */
+	del_timer_sync(&sci_port->break_timer);
+	sci_port->break_flag = 0;
+
 	clk_disable(sci_port->fclk);
 	clk_disable(sci_port->iclk);
 
@@ -733,8 +741,6 @@ static void sci_break_timer(unsigned long data)
 {
 	struct sci_port *port = (struct sci_port *)data;
 
-	sci_port_enable(port);
-
 	if (sci_rxd_in(&port->port) == 0) {
 		port->break_flag = 1;
 		sci_schedule_break_timer(port);
@@ -744,8 +750,6 @@ static void sci_break_timer(unsigned long data)
 		sci_schedule_break_timer(port);
 	} else
 		port->break_flag = 0;
-
-	sci_port_disable(port);
 }
 
 static int sci_handle_errors(struct uart_port *port)
-- 
1.8.3.2

