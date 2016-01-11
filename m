From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 2/8] serial: core: Fold do_uart_get_info() into caller
Date: Sun, 10 Jan 2016 20:23:56 -0800
Message-ID: <1452486242-7297-3-git-send-email-peter@hurleysoftware.com>
References: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

do_uart_get_info() has a single caller: uart_get_info().
Manually inline do_uart_get_info().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 048b175..6dfb583 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -671,14 +671,18 @@ static void uart_unthrottle(struct tty_struct *tty)
 		uart_set_mctrl(port, TIOCM_RTS);
 }
 
-static void do_uart_get_info(struct tty_port *port,
-			struct serial_struct *retinfo)
+static void uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = state->uart_port;
 
 	memset(retinfo, 0, sizeof(*retinfo));
 
+	/*
+	 * Ensure the state we copy is consistent and no hardware changes
+	 * occur as we go
+	 */
+	mutex_lock(&port->mutex);
 	retinfo->type	    = uport->type;
 	retinfo->line	    = uport->line;
 	retinfo->port	    = uport->iobase;
@@ -697,15 +701,6 @@ static void do_uart_get_info(struct tty_port *port,
 	retinfo->io_type         = uport->iotype;
 	retinfo->iomem_reg_shift = uport->regshift;
 	retinfo->iomem_base      = (void *)(unsigned long)uport->mapbase;
-}
-
-static void uart_get_info(struct tty_port *port,
-			struct serial_struct *retinfo)
-{
-	/* Ensure the state we copy is consistent and no hardware changes
-	   occur as we go */
-	mutex_lock(&port->mutex);
-	do_uart_get_info(port, retinfo);
 	mutex_unlock(&port->mutex);
 }
 
@@ -713,6 +708,7 @@ static int uart_get_info_user(struct tty_port *port,
 			 struct serial_struct __user *retinfo)
 {
 	struct serial_struct tmp;
+
 	uart_get_info(port, &tmp);
 
 	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-- 
2.7.0
