From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: clear receive flag on FIFO flush
Date: Fri, 13 Mar 2015 14:51:51 +0100
Message-ID: <1426254711-618-2-git-send-email-stefan@agner.ch>
References: <1426254711-618-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426254711-618-1-git-send-email-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, jingchang.lu@freescale.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stefan@agner.ch
List-Id: linux-serial@vger.kernel.org

When the receiver was enabled during startup, a character could
have been in the FIFO when the UART get initially used. The
driver configures the (receive) watermark level, and flushes the
FIFO. However, the receive flag (RDRF) could still be set at that
stage (as mentioned in the register description of UARTx_RWFIFO).
This leads to an interrupt which won't be handled properly in
interrupt mode: The receive interrupt function lpuart_rxint checks
the FIFO count, which is 0 at that point (due to the flush
during initialization). The problem does not manifest when using
DMA to receive characters.

Fix this situation by explicitly read the status register, which
leads to clearing of the RDRF flag. Due to the flush just after
the status flag read, a explicit data read is not to required.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/fsl_lpuart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 7ec9110..3ad1458 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -921,6 +921,9 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	writeb(val | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
 			sport->port.membase + UARTPFIFO);
 
+	/* explicitly clear RDRF */
+	readb(sport->port.membase + UARTSR1);
+
 	/* flush Tx and Rx FIFO */
 	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
 			sport->port.membase + UARTCFIFO);
-- 
2.3.1
