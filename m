From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 3/8] serial: core: Use tty->index for port # in debug messages
Date: Sun, 10 Jan 2016 20:23:57 -0800
Message-ID: <1452486242-7297-4-git-send-email-peter@hurleysoftware.com>
References: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The uart port may have already been removed by uart_remove_one_port();
use equivalent tty->index (which is always valid in these contexts)
instead.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6dfb583..f8c28a7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1381,8 +1381,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 	uport = state->uart_port;
 	port = &state->port;
-
-	pr_debug("uart_close(%d) called\n", uport ? uport->line : -1);
+	pr_debug("uart_close(%d) called\n", tty->index);
 
 	if (!port->count || tty_port_close_start(port, tty, filp) == 0)
 		return;
@@ -1500,7 +1499,7 @@ static void uart_hangup(struct tty_struct *tty)
 	struct tty_port *port = &state->port;
 	unsigned long flags;
 
-	pr_debug("uart_hangup(%d)\n", state->uart_port->line);
+	pr_debug("uart_hangup(%d)\n", tty->index);
 
 	mutex_lock(&port->mutex);
 	if (port->flags & ASYNC_NORMAL_ACTIVE) {
-- 
2.7.0
