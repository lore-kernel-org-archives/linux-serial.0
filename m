From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/10] TTY: serial, define uart_port_activate/shutdown
Date: Wed,  9 Nov 2011 21:33:50 +0100
Message-ID: <1320870831-23778-8-git-send-email-jslaby@suse.cz>
References: <1320870831-23778-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320870831-23778-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

This is a preparation for the next patches which will move the stuff
from uart_open and uart_close/hangup here. Then we will use
tty_port_* helpers.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/serial_core.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2ca4df4..d7e8a5e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1404,6 +1404,15 @@ static void uart_hangup(struct tty_struct *tty)
 	mutex_unlock(&port->mutex);
 }
 
+static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	return 0;
+}
+
+static void uart_port_shutdown(struct tty_port *port)
+{
+}
+
 static int uart_carrier_raised(struct tty_port *port)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
@@ -2162,6 +2171,8 @@ static const struct tty_operations uart_ops = {
 };
 
 static const struct tty_port_operations uart_port_ops = {
+	.activate	= uart_port_activate,
+	.shutdown	= uart_port_shutdown,
 	.carrier_raised = uart_carrier_raised,
 	.dtr_rts	= uart_dtr_rts,
 };
-- 
1.7.7
