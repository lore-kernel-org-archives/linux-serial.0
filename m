From: Thadeu Lima de Souza Cascardo <cascardo@cascardo.eti.br>
Subject: [PATCH] serial: core: remove silly test for uart_state
Date: Fri,  6 Jan 2017 00:45:10 -0200
Message-ID: <20170106024510.22369-1-cascardo@cascardo.eti.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Thadeu Lima de Souza Cascardo <cascardo@cascardo.eti.br>
List-Id: linux-serial@vger.kernel.org

The polling functions were checking for a NULL uart_state, which is
indexed from uart_driver->state. It should be always allocated and
non-NULL when the tty_driver is registered, and line should not be
larger than the tty_driver->num anyways.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@cascardo.eti.br>
---
 drivers/tty/serial/serial_core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9939c3d9912b..6f7247114ef8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2330,9 +2330,6 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 	int flow = 'n';
 	int ret = 0;
 
-	if (!state)
-		return -1;
-
 	tport = &state->port;
 	mutex_lock(&tport->mutex);
 
@@ -2367,12 +2364,10 @@ static int uart_poll_get_char(struct tty_driver *driver, int line)
 	struct uart_port *port;
 	int ret = -1;
 
-	if (state) {
-		port = uart_port_ref(state);
-		if (port) {
-			ret = port->ops->poll_get_char(port);
-			uart_port_deref(port);
-		}
+	port = uart_port_ref(state);
+	if (port) {
+		ret = port->ops->poll_get_char(port);
+		uart_port_deref(port);
 	}
 	return ret;
 }
@@ -2383,9 +2378,6 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
 	struct uart_state *state = drv->state + line;
 	struct uart_port *port;
 
-	if (!state)
-		return;
-
 	port = uart_port_ref(state);
 	if (!port)
 		return;
-- 
2.11.0
