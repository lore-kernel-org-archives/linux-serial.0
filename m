From: Colin King <colin.king@canonical.com>
Subject: [PATCH] serial: core: remove redundant assignment to port
Date: Wed,  1 Nov 2017 10:49:23 +0000
Message-ID: <20171101104923.18439-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The final assignment to port is never read, hence it is redundant
and can be removed. Also move the declaration of port to a more
local scope.  Cleans up clang warning:

drivers/tty/serial/serial_core.c:1498:2: warning: Value stored
to 'port' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/serial_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f4e6c8662987..cdac01fe11ca 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1482,10 +1482,10 @@ static void uart_set_termios(struct tty_struct *tty,
 static void uart_close(struct tty_struct *tty, struct file *filp)
 {
 	struct uart_state *state = tty->driver_data;
-	struct tty_port *port;
 
 	if (!state) {
 		struct uart_driver *drv = tty->driver->driver_state;
+		struct tty_port *port;
 
 		state = drv->state + tty->index;
 		port = &state->port;
@@ -1495,7 +1495,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 		return;
 	}
 
-	port = &state->port;
 	pr_debug("uart_close(%d) called\n", tty->index);
 
 	tty_port_close(tty->port, tty, filp);
-- 
2.14.1
