From: George Spelvin <linux@horizon.com>
Subject: [PATCH 2/7] pps: Additional cleanups in uart_handle_dcd_change
Date: Fri, 8 Feb 2013 01:06:58 -0500
Message-ID: <9a1c4acfce3411d23b7d839986bc228ab43daf41.1360307140.git.linux@horizon.com>
References: <cover.1360307140.git.linux@horizon.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:36258 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1946089Ab3BHJQg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Feb 2013 04:16:36 -0500
In-Reply-To: <cover.1360307140.git.linux@horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, giometti@linux.it

An extension of the previous commit, there is no semantic change
here, just 5 fewer lines of source code.

Signed-off-by: George Spelvin <linux@horizon.com>
---
 drivers/tty/serial/serial_core.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8b6bff5..b3a204b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2715,16 +2715,14 @@ EXPORT_SYMBOL(uart_match_port);
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
-	if (ld && ld->ops->dcd_change) {
-		pps_get_ts(&ts);
-		ld->ops->dcd_change(tty, status);
+	if (ld) {
+		if (ld->ops->dcd_change)
+			ld->ops->dcd_change(tty, status);
+		tty_ldisc_deref(ld);
 	}
 
 	uport->icount.dcd++;
@@ -2739,9 +2737,6 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 		else if (tty)
 			tty_hangup(tty);
 	}
-
-	if (ld)
-		tty_ldisc_deref(ld);
 }
 EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
 
-- 
1.8.1.2

