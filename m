From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH v2] tty: serial: fsl_lpuart: fix del_timer_sync() vs timer routine deadlock
Date: Sun,  4 Dec 2016 18:49:28 +0300
Message-ID: <1480866568-15725-1-git-send-email-nikita.yoush@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Stefan Agner <stefan@agner.ch>, Wei Yongjun <weiyongjun1@huawei.com>, Aaron Brice <aaron.brice@datasoft.com>, Nicolae Rosia <nicolae_rosia@mentor.com>, linux-serial@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org, Nikita Yushchenko <nikita.yoush@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

Problem found via lockdep:

- lpuart_set_termios() calls del_timer_sync(&sport->lpuart_timer) while
  holding sport->port.lock

- sport->lpuart_timer routine is lpuart_timer_func() that calls
  lpuart_copy_rx_to_tty() that acquires same lock.

To fix, move Rx DMA stopping out of lock, as it already is in other places
in the same file.

While at it, also make Rx DMA start/stop code to look the same is in
other places in the same file.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
Changes from v1:
- keep reallocation of Rx DMA buffer conditional on 'old'
- do not set sport->lpuart_dma_rx_use to true when it is already true

 drivers/tty/serial/fsl_lpuart.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a1c6519837a4..f02934ffb329 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1407,6 +1407,18 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* ask the core to calculate the divisor */
 	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
 
+	/*
+	 * Need to update the Ring buffer length according to the selected
+	 * baud rate and restart Rx DMA path.
+	 *
+	 * Since timer function acqures sport->port.lock, need to stop before
+	 * acquring same lock because otherwise del_timer_sync() can deadlock.
+	 */
+	if (old && sport->lpuart_dma_rx_use) {
+		del_timer_sync(&sport->lpuart_timer);
+		lpuart_dma_rx_free(&sport->port);
+	}
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	sport->port.read_status_mask = 0;
@@ -1456,22 +1468,11 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* restore control register */
 	writeb(old_cr2, sport->port.membase + UARTCR2);
 
-	/*
-	 * If new baud rate is set, we will also need to update the Ring buffer
-	 * length according to the selected baud rate and restart Rx DMA path.
-	 */
-	if (old) {
-		if (sport->lpuart_dma_rx_use) {
-			del_timer_sync(&sport->lpuart_timer);
-			lpuart_dma_rx_free(&sport->port);
-		}
-
-		if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
-			sport->lpuart_dma_rx_use = true;
+	if (old && sport->lpuart_dma_rx_use) {
+		if (!lpuart_start_rx_dma(sport))
 			rx_dma_timer_init(sport);
-		} else {
+		else
 			sport->lpuart_dma_rx_use = false;
-		}
 	}
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -2131,12 +2132,10 @@ static int lpuart_resume(struct device *dev)
 
 	if (sport->lpuart_dma_rx_use) {
 		if (sport->port.irq_wake) {
-			if (!lpuart_start_rx_dma(sport)) {
-				sport->lpuart_dma_rx_use = true;
+			if (!lpuart_start_rx_dma(sport))
 				rx_dma_timer_init(sport);
-			} else {
+			else
 				sport->lpuart_dma_rx_use = false;
-			}
 		}
 	}
 
-- 
2.1.4
