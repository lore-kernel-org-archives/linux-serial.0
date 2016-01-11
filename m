From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 6/8] serial: core: Remove cast from void ptr in uart_open()
Date: Sun, 10 Jan 2016 20:24:00 -0800
Message-ID: <1452486242-7297-7-git-send-email-peter@hurleysoftware.com>
References: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

void * promotes to any pointer type; remove type cast.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f77be14..530b892 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1580,7 +1580,7 @@ static void uart_dtr_rts(struct tty_port *port, int onoff)
  */
 static int uart_open(struct tty_struct *tty, struct file *filp)
 {
-	struct uart_driver *drv = (struct uart_driver *)tty->driver->driver_state;
+	struct uart_driver *drv = tty->driver->driver_state;
 	int retval, line = tty->index;
 	struct uart_state *state = drv->state + line;
 	struct tty_port *port = &state->port;
-- 
2.7.0
