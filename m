From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH v2] serial: sh-sci: Update calculation of timeout for DMA
Date: Tue, 17 Mar 2015 01:19:54 +0900
Message-ID: <1426522794-25845-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

The current calculation method in the case of 9600bps, rounding error occurs
has become setting that occur timeout faster than the required time. When we
use 9600bps, 32byte buffer, 10 bit (CS8) and 100 HZ, it becomes 3 jiffies
(30msec). In fact it is necessary 33msec. This updates to the calculation
that are not actually less than the value set by the rounding error.
Also, this is nothing will be calculated value when there is no load. If there
are a lot of case load, overrun error will occur immediately.
This is by the buffer size to be calculated twice the DMA buffer, and add the
change of setting a sufficient time-out value.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

v2 [Yoshihiro Kaneko]
* fix indentation of a case statement.
* wrap a too long line in the block comment.

 drivers/tty/serial/sh-sci.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5b50c79..bc6daf8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1967,18 +1967,40 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	/*
-	 * Calculate delay for 1.5 DMA buffers: see
-	 * drivers/serial/serial_core.c::uart_update_timeout(). With 10 bits
-	 * (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above function
+	 * Calculate delay for 2 DMA buffers (4 FIFO).
+	 * See drivers/serial/serial_core.c::uart_update_timeout(). With 10
+	 * bits (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above function
 	 * calculates 1 jiffie for the data plus 5 jiffies for the "slop(e)."
-	 * Then below we calculate 3 jiffies (12ms) for 1.5 DMA buffers (3 FIFO
-	 * sizes), but it has been found out experimentally, that this is not
-	 * enough: the driver too often needlessly runs on a DMA timeout. 20ms
-	 * as a minimum seem to work perfectly.
+	 * Then below we calculate 5 jiffies (20ms) for 2 DMA buffers (4 FIFO
+	 * sizes), but when performing a faster transfer, value obtained by
+	 * this formula is may not enough. Therefore, if value is smaller than
+	 * 20msec, this sets 20msec as timeout of DMA.
 	 */
 	if (s->chan_rx) {
-		s->rx_timeout = (port->timeout - HZ / 50) * s->buf_len_rx * 3 /
-			port->fifosize / 2;
+		unsigned int bits;
+
+		/* byte size and parity */
+		switch (termios->c_cflag & CSIZE) {
+		case CS5:
+			bits = 7;
+			break;
+		case CS6:
+			bits = 8;
+			break;
+		case CS7:
+			bits = 9;
+			break;
+		default:
+			bits = 10;
+			break;
+		}
+
+		if (termios->c_cflag & CSTOPB)
+			bits++;
+		if (termios->c_cflag & PARENB)
+			bits++;
+		s->rx_timeout = DIV_ROUND_UP((s->buf_len_rx * 2 * bits * HZ) /
+					     (baud / 10), 10);
 		dev_dbg(port->dev, "DMA Rx t-out %ums, tty t-out %u jiffies\n",
 			s->rx_timeout * 1000 / HZ, port->timeout);
 		if (s->rx_timeout < msecs_to_jiffies(20))
-- 
1.9.1

