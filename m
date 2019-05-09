From: Lanqing Liu <liuhhome@gmail.com>
Subject: [PATCH] tty: serial_core: Fix the incorrect configuration of baud rate and data length at the console serial port resume
Date: Thu,  9 May 2019 13:42:39 +0800
Message-ID: <a8bd7d19de25b799098659334de7e19670a806fc.1557379676.git.liuhhome@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: baolin.wang@unisoc.com, baolin.wang@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: lanqing.liu@unisoc.com, liuhhome@gmail.com, robh@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, chunyan.zhang@unisoc.com, orson.zhai@unisoc.com, zhang.lyra@gmail.com
List-Id: linux-serial@vger.kernel.org

When userspace opens a serial port for console, uart_port_startup()
is called. This function assigns the uport->cons->cflag value to
TTY->termios.c_cflag, then it is cleared to 0. When the user space
closes this serial port, the TTY structure will be released, and at
this time uport->cons->cflag has also been cleared.

On the Spreadtrum platform, in some special scenarios, like charging mode,
userspace needs to close the console, which means the uport->cons->cflag
has also been cleared. But printing logs is still needed in the kernel. So
when system enters suspend and resume, the console needs to be configure
the baud rate and data length of the serial port according to its own cflag
when resuming the console port. At this time, the cflag is 0, which will
cause serial port to produce configuration errors that do not meet user
expectations.

To fix this, assigning the TTY->termios.c_cflag value to uport->cons->cflag
before the userspace closes this console serial port. It will ensure that
the correct cflag value can be gotten when the console serial port was
resumed.

Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
---
 drivers/tty/serial/serial_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 351843f..f233cf8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1539,6 +1539,7 @@ static void uart_set_termios(struct tty_struct *tty,
 static void uart_close(struct tty_struct *tty, struct file *filp)
 {
 	struct uart_state *state = tty->driver_data;
+	struct uart_port *uport;
 
 	if (!state) {
 		struct uart_driver *drv = tty->driver->driver_state;
@@ -1553,6 +1554,9 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	}
 
 	pr_debug("uart_close(%d) called\n", tty->index);
+	uport = uart_port_check(state);
+	if (uport && uart_console(uport))
+		uport->cons->cflag = tty->termios.c_cflag;
 
 	tty_port_close(tty->port, tty, filp);
 }
-- 
1.9.1
