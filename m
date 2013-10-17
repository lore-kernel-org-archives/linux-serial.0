From: Randy Witt <rewitt@declaratino.com>
Subject: [PATCH] serial_core: Don't re-initialize a previously initialized spinlock.
Date: Thu, 17 Oct 2013 16:56:47 -0400
Message-ID: <1382043407-2699-2-git-send-email-rewitt@declaratino.com>
References: <1382043407-2699-1-git-send-email-rewitt@declaratino.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from p3plsmtpa08-09.prod.phx3.secureserver.net ([173.201.193.110]:47613
	"EHLO p3plsmtpa08-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762555Ab3JQVDk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Oct 2013 17:03:40 -0400
In-Reply-To: <1382043407-2699-1-git-send-email-rewitt@declaratino.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: Randy Witt <rewitt@declaratino.com>

The uart_set_options() code unconditionally initalizes the spinlock
on the port. This can cause a deadlock in some situations.

One instance that exposed the problem, was when writing to
/sys/module/kgdboc/parameters/kgdboc to use ttyS0 when the console
is already running on ttyS0. If the spinlock is re-initialized
while the lock is held due to output to the console, there
is a deadlock.

Assume the spinlock is initialized if the port is a console.

Signed-off-by: Randy Witt <rewitt@declaratino.com>
---
 drivers/tty/serial/serial_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 28cdd28..0a2d277 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1830,9 +1830,13 @@ uart_set_options(struct uart_port *port, struct console *co,
 	/*
 	 * Ensure that the serial console lock is initialised
 	 * early.
+	 * If this port is a console, then the spinlock is already
+	 * initialised.
 	 */
-	spin_lock_init(&port->lock);
-	lockdep_set_class(&port->lock, &port_lock_key);
+	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED))) {
+		spin_lock_init(&port->lock);
+		lockdep_set_class(&port->lock, &port_lock_key);
+	}
 
 	memset(&termios, 0, sizeof(struct ktermios));
 
-- 
1.8.3.1

