From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/79] TTY: serial, remove tasklet for tty_wakeup
Date: Wed, 26 Oct 2011 14:12:10 +0200
Message-ID: <1319631204-23262-5-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60923 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932819Ab1JZMN3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:29 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

tty_wakeup can be called from any context. So there is no need to have
an extra tasklet for calling that. Hence save some space and remove
the tasklet completely.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |   20 +-------------------
 include/linux/serial_core.h      |    1 -
 2 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2cbf1bd..4786232 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -72,7 +72,7 @@ void uart_write_wakeup(struct uart_port *port)
 	 * closed.  No cookie for you.
 	 */
 	BUG_ON(!state);
-	tasklet_schedule(&state->tlet);
+	tty_wakeup(state->port.tty);
 }
 
 static void uart_stop(struct tty_struct *tty)
@@ -107,12 +107,6 @@ static void uart_start(struct tty_struct *tty)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static void uart_tasklet_action(unsigned long data)
-{
-	struct uart_state *state = (struct uart_state *)data;
-	tty_wakeup(state->port.tty);
-}
-
 static inline void
 uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 {
@@ -250,11 +244,6 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	}
 
 	/*
-	 * kill off our tasklet
-	 */
-	tasklet_kill(&state->tlet);
-
-	/*
 	 * Free the transmit buffer page.
 	 */
 	if (state->xmit.buf) {
@@ -2277,8 +2266,6 @@ int uart_register_driver(struct uart_driver *drv)
 		port->ops = &uart_port_ops;
 		port->close_delay     = 500;	/* .5 seconds */
 		port->closing_wait    = 30000;	/* 30 seconds */
-		tasklet_init(&state->tlet, uart_tasklet_action,
-			     (unsigned long)state);
 	}
 
 	retval = tty_register_driver(normal);
@@ -2439,11 +2426,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 */
 	uport->type = PORT_UNKNOWN;
 
-	/*
-	 * Kill the tasklet, and free resources.
-	 */
-	tasklet_kill(&state->tlet);
-
 	state->uart_port = NULL;
 	mutex_unlock(&port_mutex);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a5c3114..76e1103 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -384,7 +384,6 @@ struct uart_state {
 	int			pm_state;
 	struct circ_buf		xmit;
 
-	struct tasklet_struct	tlet;
 	struct uart_port	*uart_port;
 };
 
-- 
1.7.7

