From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] serial_core: Unregister console in uart_remove_one_port()
Date: Fri, 28 Feb 2014 14:21:32 +0100
Message-ID: <1393593694-30262-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

If the serial port being removed is used as a console, it must also be
unregistered from the console subsystem using unregister_console().

uart_ops.release_port() will release resources (e.g. iounmap() the serial
port registers), causing a crash on subsequent kernel output if the console
is still registered.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/tty/serial/serial_core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ece2049bd270..8ece7f14d89d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2677,6 +2677,12 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 		tty_vhangup(port->tty);
 
 	/*
+	 * If the port is used as a console, unregister it
+	 */
+	if (uart_console(uport))
+		unregister_console(uport->cons);
+
+	/*
 	 * Free the port IO and memory resources, if any.
 	 */
 	if (uport->type != PORT_UNKNOWN)
-- 
1.7.9.5

