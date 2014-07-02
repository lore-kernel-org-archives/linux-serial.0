From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] serial: fsl_lpuart: move DMA RX timeout calculation
Date: Wed,  2 Jul 2014 18:02:56 +0200
Message-ID: <54df28cb5dccf71b17523896da17ce2f155855fd.1404314964.git.stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@lists.infradead.org, stefan@agner.ch, yao.yuan@freescale.com, linux-serial@vger.kernel.org, jingchang.lu@freescale.com, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The DMA RX timeout calculation is done based on FIFO buffer size and
port timeout when setting up DMA. However, both variables are not
necessarily initialized at DMA initialization time, which can lead
to a division by zero.

Move the timeout calculation to set_termios where both variables
are initialized.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This happens only after eDMA is fixed. Hence if the eDMA patch makes
it into 3.16, it would be good to have this one in 3.16 too...

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/268199.html

 drivers/tty/serial/fsl_lpuart.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 49385c8..6b462a9 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -724,13 +724,6 @@ static int lpuart_dma_rx_request(struct uart_port *port)
 	sport->dma_rx_buf_bus = dma_bus;
 	sport->dma_rx_in_progress = 0;
 
-	sport->dma_rx_timeout = (sport->port.timeout - HZ / 50) *
-				FSL_UART_RX_DMA_BUFFER_SIZE * 3 /
-				sport->rxfifo_size / 2;
-
-	if (sport->dma_rx_timeout < msecs_to_jiffies(20))
-		sport->dma_rx_timeout = msecs_to_jiffies(20);
-
 	return 0;
 }
 
@@ -922,6 +915,17 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
+	if (sport->lpuart_dma_use) {
+		/* Calculate delay for 1.5 DMA buffers */
+		sport->dma_rx_timeout = (sport->port.timeout - HZ / 50) *
+					FSL_UART_RX_DMA_BUFFER_SIZE * 3 /
+					sport->rxfifo_size / 2;
+		dev_dbg(port->dev, "DMA Rx t-out %ums, tty t-out %u jiffies\n",
+			sport->dma_rx_timeout * 1000 / HZ, sport->port.timeout);
+		if (sport->dma_rx_timeout < msecs_to_jiffies(20))
+			sport->dma_rx_timeout = msecs_to_jiffies(20);
+	}
+
 	/* wait transmit engin complete */
 	while (!(readb(sport->port.membase + UARTSR1) & UARTSR1_TC))
 		barrier();
-- 
2.0.1
