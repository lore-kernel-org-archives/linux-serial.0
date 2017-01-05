From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH] serial/8250: remove comment about schedule_timeout
Date: Thu,  5 Jan 2017 13:48:40 -0200
Message-ID: <20170105154840.24795-1-cascardo@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

Ted T'so has added the function size_fifo in 1999 for the 2.3 series
[1], a long time ago.

During the 2.5 cycle, Russell King has restructured the serial drivers
and, in that process, has suggested using schedule_timeout instead of
mdelay in size_fifo. [2]

It was only at 2.6.7 that Greg Kroah-Hartman added the msleep function
to the core kernel, as people were starting to duplicate it. [3]

However, as size_fifo is called under a spinlock from the autoconfig
function, we might not use msleep here, so removing that comment is the
appropriate thing to do.

[1] http://lkml.iu.edu/hypermail/linux/kernel/9908.3/1229.html
[2] https://git.kernel.org/cgit/linux/kernel/git/tglx/history.git/commit/?id=33c0d1b0c3ebb61243d9b19ce70d9063acff2aac
[3] https://git.kernel.org/cgit/linux/kernel/git/tglx/history.git/commit/?id=8365c315507fe10925bb3281d74444fe02935b25

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Theodore Ts'o <tytso@mit.edu>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1731b98d2471..645daf551fdf 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -796,7 +796,7 @@ static int size_fifo(struct uart_8250_port *up)
 	serial_out(up, UART_LCR, 0x03);
 	for (count = 0; count < 256; count++)
 		serial_out(up, UART_TX, count);
-	mdelay(20);/* FIXME - schedule_timeout */
+	mdelay(20);
 	for (count = 0; (serial_in(up, UART_LSR) & UART_LSR_DR) &&
 	     (count < 256); count++)
 		serial_in(up, UART_RX);
-- 
2.11.0
