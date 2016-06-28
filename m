From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v2 1/9] tty: serial: fsl_lpuart: consider TX FIFO too in tx_empty
Date: Tue, 28 Jun 2016 11:02:27 +0530
Message-ID: <20160628053235.5114-2-bhuvanchandra.dv@toradex.com>
References: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
Sender: linux-clk-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: stefan@agner.ch, shawnguo@kernel.org, kernel@pengutronix.de, mturquette@baylibre.com, sboyd@codeaurora.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
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

