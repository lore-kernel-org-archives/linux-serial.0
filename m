From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] serial_core: Get a reference for port->tty in uart_remove_one_port()
Date: Mon, 17 Mar 2014 14:10:58 +0100
Message-ID: <1395061859-15295-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Suggested-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/tty/serial/serial_core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8ee90f731f31..21084f0b8ea4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2647,6 +2647,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
 	struct uart_state *state = drv->state + uport->line;
 	struct tty_port *port = &state->port;
+	struct tty_struct *tty;
 	int ret = 0;
 
 	BUG_ON(in_interrupt());
@@ -2675,8 +2676,11 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 */
 	tty_unregister_device(drv->tty_driver, uport->line);
 
-	if (port->tty)
+	tty = tty_port_tty_get(port);
+	if (tty) {
 		tty_vhangup(port->tty);
+		tty_kref_put(tty);
+	}
 
 	/*
 	 * If the port is used as a console, unregister it, and power it down
-- 
1.7.9.5
