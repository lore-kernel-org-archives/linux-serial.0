From: George Spelvin <linux@horizon.com>
Subject: [PATCH v2 6/9] pps: Additional cleanups in uart_handle_dcd_change
Date: Sun, 10 Feb 2013 04:44:30 -0500
Message-ID: <a2516ce36544efd71cffb109effc6ce0e4c0c1d2.1360677367.git.linux@horizon.com>
References: <cover.1360677367.git.linux@horizon.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1360677367.git.linux@horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, giometti@linux.it, linux@horizon.com
List-Id: linux-serial@vger.kernel.org

An extension of the previous commit, there is no semantic change
here, just fewer lines of source code.

Signed-off-by: George Spelvin <linux@horizon.com>
---
 drivers/tty/serial/serial_core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 23fc494..b3a204b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2715,15 +2715,15 @@ EXPORT_SYMBOL(uart_match_port);
  */
 void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 {
-	struct uart_state *state = uport->state;
-	struct tty_port *port = &state->port;
-	struct tty_ldisc *ld = NULL;
+	struct tty_port *port = &uport->state->port;
 	struct tty_struct *tty = port->tty;
+	struct tty_ldisc *ld = tty ? tty_ldisc_ref(tty) : NULL;
 
-	if (tty)
-	        ld = tty_ldisc_ref(tty);
-	if (ld && ld->ops->dcd_change)
-		ld->ops->dcd_change(tty, status);
+	if (ld) {
+		if (ld->ops->dcd_change)
+			ld->ops->dcd_change(tty, status);
+		tty_ldisc_deref(ld);
+	}
 
 	uport->icount.dcd++;
 #ifdef CONFIG_HARD_PPS
@@ -2737,9 +2737,6 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 		else if (tty)
 			tty_hangup(tty);
 	}
-
-	if (ld)
-		tty_ldisc_deref(ld);
 }
 EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
 
-- 
1.8.1.3
