From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] tty/serial: atmel: fix RS485 half duplex with DMA
Date: Sat, 28 May 2016 00:54:08 +0200
Message-ID: <1464389648-4820-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

When using DMA, half duplex doesn't work properly because rx is not stopped
before starting tx. Ensure we call atmel_stop_rx() in the DMA case.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 954941dd8124..f9c798cba83f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -482,19 +482,21 @@ static void atmel_start_tx(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	if (atmel_use_pdc_tx(port)) {
-		if (atmel_uart_readl(port, ATMEL_PDC_PTSR) & ATMEL_PDC_TXTEN)
-			/* The transmitter is already running.  Yes, we
-			   really need this.*/
-			return;
+	if (atmel_use_pdc_tx(port) && (atmel_uart_readl(port, ATMEL_PDC_PTSR)
+				       & ATMEL_PDC_TXTEN))
+		/* The transmitter is already running.  Yes, we
+		   really need this.*/
+		return;
 
+	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
 		if ((port->rs485.flags & SER_RS485_ENABLED) &&
 		    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
 			atmel_stop_rx(port);
 
+	if (atmel_use_pdc_tx(port))
 		/* re-enable PDC transmit */
 		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTEN);
-	}
+
 	/* Enable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
 }
-- 
2.8.1
