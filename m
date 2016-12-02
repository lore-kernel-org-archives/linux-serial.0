From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] tty: serial: fsl_lpuart: fix del_timer_sync() vs timer routine deadlock
Date: Fri,  2 Dec 2016 13:28:10 +0300
Message-ID: <1480674490-24718-1-git-send-email-nikita.yoush@cogentembedded.com>
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
 drivers/tty/serial/fsl_lpuart.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a1c6519837a4..81100c40f33b 100644
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
+	if (sport->lpuart_dma_rx_use) {
+		del_timer_sync(&sport->lpuart_timer);
+		lpuart_dma_rx_free(&sport->port);
+	}
+
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	sport->port.read_status_mask = 0;
@@ -1456,17 +1468,8 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
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
+	if (sport->lpuart_dma_rx_use) {
+		if (!lpuart_start_rx_dma(sport)) {
 			sport->lpuart_dma_rx_use = true;
 			rx_dma_timer_init(sport);
 		} else {
-- 
2.1.4
