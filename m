From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: [PATCH] serial: imx: count tty buffer overruns
Date: Sat, 20 Jun 2015 19:25:35 +0200
Message-ID: <5585A20F.6040609@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
List-Id: linux-serial@vger.kernel.org

As can be seen in function uart_insert_char (serial_core) the element
buf_overrun of struct uart_icount is used to count overruns of
tty-buffer.
Added support for counting of overruns in imx driver analogue to
serial_core.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
---
 drivers/tty/serial/imx.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8825039..384cf1d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -700,7 +700,8 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
 			goto out;
 
-		tty_insert_flip_char(port, rx, flg);
+		if (tty_insert_flip_char(port, rx, flg) == 0)
+			sport->port.icount.buf_overrun++;
 	}
 
 out:
@@ -922,8 +923,13 @@ static void dma_rx_callback(void *data)
 	dev_dbg(sport->port.dev, "We get %d bytes.\n", count);
 
 	if (count) {
-		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ))
-			tty_insert_flip_string(port, sport->rx_buf, count);
+		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
+			int bytes = tty_insert_flip_string(port, sport->rx_buf,
+					count);
+
+			if (bytes != count)
+				sport->port.icount.buf_overrun++;
+		}
 		tty_flip_buffer_push(port);
 
 		start_rx_dma(sport);
-- 
1.7.10.4
