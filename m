From: kpark3469@gmail.com
Subject: [PATCH] tty: serial_core: recover uport->cons->cflag on uart_close
Date: Sun, 16 Jun 2019 18:57:14 +0400
Message-ID: <1560697034-4807-1-git-send-email-kpark3469@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, keun-o.park@darkmatter.ae
List-Id: linux-serial@vger.kernel.org

From: Sahara <keun-o.park@darkmatter.ae>

Since uart_close was converted to use tty_port_close, uart_shutdown
also moved to uart_tty_port_shutdown, which means it does not backup
tty's termios to uart_port.console.cflag when console is closed and
uart_console is true.
By losing this value, serial console was not set correctly especially
after suspend/resume when there is no consumer of console device.
This problem resets console driver's configuration to an unwanted value
and may give a performance regression in the system eventually.
This patch fixes the bug introduced from v4.9 kernel.

Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Reported-by: Jouni Linnamaa <Jouni.Linnamaa@darkmatter.ae>
Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
---
 drivers/tty/serial/serial_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 83f4dd0bfd74..a52afceb2f4e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1533,6 +1533,7 @@ static void uart_set_termios(struct tty_struct *tty,
 static void uart_close(struct tty_struct *tty, struct file *filp)
 {
 	struct uart_state *state = tty->driver_data;
+	struct uart_port *uport = uart_port_check(state);
 
 	if (!state) {
 		struct uart_driver *drv = tty->driver->driver_state;
@@ -1548,6 +1549,8 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 	pr_debug("uart_close(%d) called\n", tty->index);
 
+	if (uport && uart_console(uport))
+		uport->cons->cflag = tty->termios.c_cflag;
 	tty_port_close(tty->port, tty, filp);
 }
 
-- 
2.17.1
