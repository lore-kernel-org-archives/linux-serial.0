From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] tty/serial: atmel: RS485 half duplex w/DMA: enable RX after TX is done
Date: Tue,  6 Dec 2016 13:05:33 +0100
Message-ID: <20161206120533.14505-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Gil Weber <webergil@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When using RS485 in half duplex, RX should be enabled when TX is
finished, and stopped when TX starts.

Before commit 0058f0871efe7b01c6 ("tty/serial: atmel: fix RS485 half
duplex with DMA"), RX was not disabled in atmel_start_tx() if the DMA
was used. So, collisions could happened.

But disabling RX in atmel_start_tx() uncovered another bug:
RX was enabled again in the wrong place (in atmel_tx_dma) instead of
being enabled when TX is finished (in atmel_complete_tx_dma), so the
transmission simply stopped.

This bug was not triggered before commit 0058f0871efe7b01c6
("tty/serial: atmel: fix RS485 half duplex with DMA") because RX was
never disabled before.

Moving atmel_start_rx() in atmel_complete_tx_dma() corrects the problem.

Cc: stable@vger.kernel.org
Reported-by: Gil Weber <webergil@gmail.com>
Tested-by: Gil Weber <webergil@gmail.com>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 168b10cad47b..11c0117af80b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -798,6 +798,11 @@ static void atmel_complete_tx_dma(void *arg)
 	 */
 	if (!uart_circ_empty(xmit))
 		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
+	else if ((port->rs485.flags & SER_RS485_ENABLED) &&
+		 !(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
+		/* DMA done, stop TX, start RX for RS485 */
+		atmel_start_rx(port);
+	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -900,12 +905,6 @@ static void atmel_tx_dma(struct uart_port *port)
 		desc->callback = atmel_complete_tx_dma;
 		desc->callback_param = atmel_port;
 		atmel_port->cookie_tx = dmaengine_submit(desc);
-
-	} else {
-		if (port->rs485.flags & SER_RS485_ENABLED) {
-			/* DMA done, stop TX, start RX for RS485 */
-			atmel_start_rx(port);
-		}
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
