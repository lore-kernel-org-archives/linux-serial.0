From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/4] TTY: serial/m32r_sio, remove unused members
Date: Tue, 12 Jan 2016 10:59:09 +0100
Message-ID: <1452592749-25150-4-git-send-email-jslaby@suse.cz>
References: <1452592749-25150-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452592749-25150-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

struct uart_sio_port has a lots of unused members. Some of them are
set to some constant but never read. Remove all those.

This includes removal of uart_ops->pm handler as we never handle pm
(pm was never set).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/m32r_sio.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 6b1303505667..68765f7c2645 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -75,19 +75,7 @@ struct uart_sio_port {
 	struct uart_port	port;
 	struct timer_list	timer;		/* "no irq" timer */
 	struct list_head	list;		/* ports on this IRQ */
-	unsigned short		rev;
-	unsigned char		acr;
 	unsigned char		ier;
-	unsigned char		lcr;
-	unsigned char		mcr_mask;	/* mask of user bits */
-	unsigned char		mcr_force;	/* mask of forced bits */
-	unsigned char		lsr_break_flag;
-
-	/*
-	 * We provide a per-port pm hook.
-	 */
-	void			(*pm)(struct uart_port *port,
-				      unsigned int state, unsigned int old);
 };
 
 struct irq_info {
@@ -312,12 +300,6 @@ static void receive_chars(struct uart_sio_port *up, int *status)
 			 */
 			*status &= up->port.read_status_mask;
 
-			if (up->port.line == up->port.cons->index) {
-				/* Recover the break flag from console xmit */
-				*status |= up->lsr_break_flag;
-				up->lsr_break_flag = 0;
-			}
-
 			if (*status & UART_LSR_BI) {
 				pr_debug("handling break....\n");
 				flag = TTY_BREAK;
@@ -749,20 +731,9 @@ static void m32r_sio_set_termios(struct uart_port *port,
 
 	serial_out(up, UART_IER, up->ier);
 
-	up->lcr = cval;					/* Save LCR */
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-static void m32r_sio_pm(struct uart_port *port, unsigned int state,
-	unsigned int oldstate)
-{
-	struct uart_sio_port *up =
-		container_of(port, struct uart_sio_port, port);
-
-	if (up->pm)
-		up->pm(port, state, oldstate);
-}
-
 /*
  * Resource handling.  This is complicated by the fact that resources
  * depend on the port type.  Maybe we should be claiming the standard
@@ -899,7 +870,6 @@ static struct uart_ops m32r_sio_pops = {
 	.startup	= m32r_sio_startup,
 	.shutdown	= m32r_sio_shutdown,
 	.set_termios	= m32r_sio_set_termios,
-	.pm		= m32r_sio_pm,
 	.release_port	= m32r_sio_release_port,
 	.request_port	= m32r_sio_request_port,
 	.config_port	= m32r_sio_config_port,
@@ -944,9 +914,6 @@ static void __init m32r_sio_register_ports(struct uart_driver *drv)
 		init_timer(&up->timer);
 		up->timer.function = m32r_sio_timeout;
 
-		up->mcr_mask = ~0;
-		up->mcr_force = 0;
-
 		uart_add_one_port(drv, &up->port);
 	}
 }
-- 
2.7.0
