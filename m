From: Rob Herring <robh@kernel.org>
Subject: [PATCH 5/9] tty: serial_core: use tty_port_tty_wakeup instead of tty_wakeup
Date: Fri,  9 Sep 2016 17:37:06 -0500
Message-ID: <20160909223711.26238-6-robh@kernel.org>
References: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In preparation to use a tty_port without a tty, call the tty_port helper
tty_port_tty_wakeup instead of tty_wakeup directly.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 70aea76dbfb7..d48ea0a98e92 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -111,7 +111,7 @@ void uart_write_wakeup(struct uart_port *port)
 	 * closed.  No cookie for you.
 	 */
 	BUG_ON(!state);
-	tty_wakeup(state->port.tty);
+	tty_port_tty_wakeup(&state->port);
 }
 
 static void uart_stop(struct tty_struct *tty)
@@ -631,7 +631,7 @@ static void uart_flush_buffer(struct tty_struct *tty)
 	if (port->ops->flush_buffer)
 		port->ops->flush_buffer(port);
 	uart_port_unlock(port, flags);
-	tty_wakeup(tty);
+	tty_port_tty_wakeup(&state->port);
 }
 
 /*
-- 
2.9.3
