From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] serial: sh-sci: Fix issue of frequent rx_full interrupt
Date: Mon, 15 Jun 2015 02:26:26 +0900
Message-ID: <1434302786-31162-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

When the receive FIFO is not read in PIO transfer, rx_full interrupt
occurs frequently. This patch avoids it by discarding the receive FIFO.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

 drivers/tty/serial/sh-sci.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b74a644..4ec3c32 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -121,6 +121,8 @@ struct sci_port {
 #endif
 
 	struct notifier_block		freq_transition;
+
+	u64				rxfull_time;
 };
 
 /* Function prototypes */
@@ -690,12 +692,26 @@ static void sci_receive_chars(struct uart_port *port)
 		return;
 
 	while (1) {
+		int rxfill = sci_rxfill(port);
+		u64 now = get_jiffies_64();
 		/* Don't copy more bytes than there is room for in the buffer */
-		count = tty_buffer_request_room(tport, sci_rxfill(port));
+		count = tty_buffer_request_room(tport, rxfill);
 
 		/* If for any reason we can't copy more data, we're done! */
-		if (count == 0)
+		if (count == 0) {
+			int n;
+			/* discarded bytes in RX-FIFO */
+			for (n = 0; n < rxfill; n++)
+				serial_port_in(port, SCxRDR);
+			if (rxfill > 0 &&
+			    time_after64(now, sci_port->rxfull_time + (5*HZ))) {
+				sci_port->rxfull_time = now;
+				dev_warn(port->dev,
+					 "RX-FIFO isn't read, so %d bytes is discarded.\n",
+					 rxfill);
+			}
 			break;
+		}
 
 		if (port->type == PORT_SCI) {
 			char c = serial_port_in(port, SCxRDR);
@@ -2342,6 +2358,8 @@ static int sci_init_single(struct platform_device *dev,
 		dev_dbg(port->dev, "DMA tx %d, rx %d\n",
 			p->dma_slave_tx, p->dma_slave_rx);
 
+	sci_port->rxfull_time = get_jiffies_64();
+
 	return 0;
 }
 
-- 
1.9.1

