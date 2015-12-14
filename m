From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 09/27] serial: sh-sci: Don't overwrite clock selection in serial_console_write()
Date: Mon, 14 Dec 2015 19:57:18 +0100
Message-ID: <1450119456-964-10-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Blindly writing the default configuration value into the SCSCR register
may change the clock selection bits, breaking the serial console if the
current driver settings differ from the default settings.

Keep the current clock selection bits to prevent this from happening
on e.g. r8a7791/koelsch when support for the BRG will be added.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Reviewed-by, Acked-by.
---
 drivers/tty/serial/sh-sci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 05ac15336e4f918d..136ad2f633413cbc 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2420,7 +2420,7 @@ static void serial_console_write(struct console *co, const char *s,
 {
 	struct sci_port *sci_port = &sci_ports[co->index];
 	struct uart_port *port = &sci_port->port;
-	unsigned short bits, ctrl;
+	unsigned short bits, ctrl, ctrl_temp;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2432,9 +2432,11 @@ static void serial_console_write(struct console *co, const char *s,
 	else
 		spin_lock(&port->lock);
 
-	/* first save the SCSCR then disable the interrupts */
+	/* first save SCSCR then disable interrupts, keep clock source */
 	ctrl = serial_port_in(port, SCSCR);
-	serial_port_out(port, SCSCR, sci_port->cfg->scscr);
+	ctrl_temp = (sci_port->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0)) |
+		    (ctrl & (SCSCR_CKE1 | SCSCR_CKE0));
+	serial_port_out(port, SCSCR, ctrl_temp);
 
 	uart_console_write(port, s, count, serial_console_putchar);
 
-- 
1.9.1

