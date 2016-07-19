From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH RESEND v2 1/8] tty: serial: fsl_lpuart: consider TX FIFO too
 in tx_empty
Date: Tue, 19 Jul 2016 13:13:03 +0530
Message-ID: <20160719074310.16872-2-bhuvanchandra.dv@toradex.com>
References: <20160719074310.16872-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160719074310.16872-1-bhuvanchandra.dv@toradex.com>
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
Cc: linux-serial@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, stefan@agner.ch, kernel@pengutronix.de, jslaby@suse.com, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

Currently the tx_empty callback only considers the Transmit Complete Flag (TC).
The reference manual is not quite clear if the TC flag covers the TX FIFO too.
Debug prints on real hardware have shown that from time to time the TC flag is
asserted (indicating Transmitter idle) while there are still data in the
TX FIFO. Hence, in this case the serial core will call the shutdown callback
even though there are data remaining in the TX FIFO buffers.

Avoid early shutdowns by considering the TX FIFO empty flag too. Also avoid
theoretical race conditions between DMA and the driver by checking whether the
TX DMA is in progress too.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3d79003..fabfa7e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -810,8 +810,18 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
 /* return TIOCSER_TEMT when transmitter is not busy */
 static unsigned int lpuart_tx_empty(struct uart_port *port)
 {
-	return (readb(port->membase + UARTSR1) & UARTSR1_TC) ?
-		TIOCSER_TEMT : 0;
+	struct lpuart_port *sport = container_of(port,
+			struct lpuart_port, port);
+	unsigned char sr1 = readb(port->membase + UARTSR1);
+	unsigned char sfifo = readb(port->membase + UARTSFIFO);
+
+	if (sport->dma_tx_in_progress)
+		return 0;
+
+	if (sr1 & UARTSR1_TC && sfifo & UARTSFIFO_TXEMPT)
+		return TIOCSER_TEMT;
+
+	return 0;
 }
 
 static unsigned int lpuart32_tx_empty(struct uart_port *port)
-- 
2.9.0
