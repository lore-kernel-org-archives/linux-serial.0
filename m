From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] tty: serial_core, remove state checks in uart_poll*
Date: Wed, 15 Mar 2017 12:00:23 +0100
Message-ID: <20170315110023.7806-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
List-Id: linux-serial@vger.kernel.org

Coverity complains about uart_state checks in polling functions. And it
is indeed correct. We do something like this:
	struct uart_state *state = drv->state + line;
	if (!state)
		return;

Adding 'line' to drv->state would move the potential NULL pointer to
something near NULL and the check is useless. Even if we checked pure
drv->state, nothing guarantees it is not freed and NULLed after the
check. So if the only user of this interface (kgdboc) needs to assure
something, this is neither the correct thing, nor place to do so.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net
---
 drivers/tty/serial/serial_core.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f93106e26dd1..aa31ee0fd324 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2323,9 +2323,6 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 	int flow = 'n';
 	int ret = 0;
 
-	if (!state)
-		return -1;
-
 	tport = &state->port;
 	mutex_lock(&tport->mutex);
 
@@ -2360,13 +2357,12 @@ static int uart_poll_get_char(struct tty_driver *driver, int line)
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
+
 	return ret;
 }
 
@@ -2376,9 +2372,6 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
 	struct uart_state *state = drv->state + line;
 	struct uart_port *port;
 
-	if (!state)
-		return;
-
 	port = uart_port_ref(state);
 	if (!port)
 		return;
-- 
2.12.0
