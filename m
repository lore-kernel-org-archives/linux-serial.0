From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v3 1/6] tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
Date: Mon,  5 Aug 2019 11:56:56 -0700
Message-ID: <20190805185701.22863-2-andrew.smirnov@gmail.com>
References: <20190805185701.22863-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805185701.22863-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Code configure DMA TX path in lpuart_startup(), lpuart32_startup() and
lpuart_resume() is doing exactly the same thing, so move it into a
standalone subroutine.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 53 ++++++++++++++-------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 0e09e6dc5ccb..9da4529ee223 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1435,6 +1435,26 @@ static void rx_dma_timer_init(struct lpuart_port *sport)
 	add_timer(&sport->lpuart_timer);
 }
 
+static void lpuart_tx_dma_startup(struct lpuart_port *sport)
+{
+	u32 uartbaud;
+
+	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
+		init_waitqueue_head(&sport->dma_wait);
+		sport->lpuart_dma_tx_use = true;
+		if (lpuart_is_32(sport)) {
+			uartbaud = lpuart32_read(&sport->port, UARTBAUD);
+			lpuart32_write(&sport->port,
+				       uartbaud | UARTBAUD_TDMAE, UARTBAUD);
+		} else {
+			writeb(readb(sport->port.membase + UARTCR5) |
+				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
+		}
+	} else {
+		sport->lpuart_dma_tx_use = false;
+	}
+}
+
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1471,14 +1491,7 @@ static int lpuart_startup(struct uart_port *port)
 		sport->lpuart_dma_rx_use = false;
 	}
 
-	if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
-		init_waitqueue_head(&sport->dma_wait);
-		sport->lpuart_dma_tx_use = true;
-		temp = readb(port->membase + UARTCR5);
-		writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
-	} else {
-		sport->lpuart_dma_tx_use = false;
-	}
+	lpuart_tx_dma_startup(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
@@ -1521,14 +1534,7 @@ static int lpuart32_startup(struct uart_port *port)
 		sport->lpuart_dma_rx_use = false;
 	}
 
-	if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
-		init_waitqueue_head(&sport->dma_wait);
-		sport->lpuart_dma_tx_use = true;
-		temp = lpuart32_read(&sport->port, UARTBAUD);
-		lpuart32_write(&sport->port, temp | UARTBAUD_TDMAE, UARTBAUD);
-	} else {
-		sport->lpuart_dma_tx_use = false;
-	}
+	lpuart_tx_dma_startup(sport);
 
 	if (sport->lpuart_dma_rx_use) {
 		/* RXWATER must be 0 */
@@ -2577,20 +2583,7 @@ static int lpuart_resume(struct device *dev)
 		}
 	}
 
-	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
-		init_waitqueue_head(&sport->dma_wait);
-		sport->lpuart_dma_tx_use = true;
-		if (lpuart_is_32(sport)) {
-			temp = lpuart32_read(&sport->port, UARTBAUD);
-			lpuart32_write(&sport->port,
-				       temp | UARTBAUD_TDMAE, UARTBAUD);
-		} else {
-			writeb(readb(sport->port.membase + UARTCR5) |
-				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
-		}
-	} else {
-		sport->lpuart_dma_tx_use = false;
-	}
+	lpuart_tx_dma_startup(sport);
 
 	if (lpuart_is_32(sport)) {
 		if (sport->lpuart_dma_rx_use) {
-- 
2.21.0
