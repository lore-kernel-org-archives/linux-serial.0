From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 15/23] tty: serial: fsl_lpuart: Introduce lpuart_stopped_or_empty()
Date: Wed, 31 Jul 2019 10:30:37 -0700
Message-ID: <20190731173045.11718-16-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The check for

    uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)

appears in multiple places in the driver. Move it into a helper
function.

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
 drivers/tty/serial/fsl_lpuart.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 58043e01a242..e59dd90fc34c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -452,6 +452,11 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 	dma_async_issue_pending(sport->dma_tx_chan);
 }
 
+static bool lpuart_stopped_or_empty(struct uart_port *port)
+{
+	return uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port);
+}
+
 static void lpuart_dma_tx_complete(void *arg)
 {
 	struct lpuart_port *sport = arg;
@@ -479,7 +484,7 @@ static void lpuart_dma_tx_complete(void *arg)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
+	if (!lpuart_stopped_or_empty(&sport->port))
 		lpuart_dma_tx(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -680,7 +685,7 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+	if (lpuart_stopped_or_empty(&sport->port)) {
 		lpuart_stop_tx(&sport->port);
 		return;
 	}
@@ -711,7 +716,7 @@ static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+	if (lpuart_stopped_or_empty(&sport->port)) {
 		lpuart32_stop_tx(&sport->port);
 		return;
 	}
@@ -739,14 +744,13 @@ static void lpuart_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned char temp;
 
 	temp = readb(port->membase + UARTCR2);
 	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
 
 	if (sport->lpuart_dma_tx_use) {
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(port))
+		if (!lpuart_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
 		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
@@ -757,11 +761,10 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long temp;
 
 	if (sport->lpuart_dma_tx_use) {
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(port))
+		if (!lpuart_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
 		temp = lpuart32_read(port, UARTCTRL);
-- 
2.21.0
