From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 03/24] tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer
Date: Mon, 29 Jul 2019 12:52:05 -0700
Message-ID: <20190729195226.8862-4-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Fugang Duan <fugang.duan@nxp.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Switching baud rate might cause bogus data to appear in HW
FIFO. Add code to do a HW FIFO flush to .flush_buffer callback to
avoid that.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index edb1a9425fac..56423ad02f0f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -517,9 +517,16 @@ static int lpuart_dma_tx_request(struct uart_port *port)
 	return 0;
 }
 
+static bool lpuart_is_32(struct lpuart_port *sport)
+{
+	return sport->port.iotype == UPIO_MEM32 ||
+	       sport->port.iotype ==  UPIO_MEM32BE;
+}
+
 static void lpuart_flush_buffer(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
+	u32 val;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (sport->dma_tx_in_progress) {
@@ -529,6 +536,16 @@ static void lpuart_flush_buffer(struct uart_port *port)
 		}
 		dmaengine_terminate_all(sport->dma_tx_chan);
 	}
+
+	if (lpuart_is_32(sport)) {
+		val = lpuart32_read(&sport->port, UARTFIFO);
+		val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
+		lpuart32_write(&sport->port, val, UARTFIFO);
+	} else {
+		val = readb(sport->port.membase + UARTPFIFO);
+		val |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
+		writeb(val, sport->port.membase + UARTCFIFO);
+	}
 }
 
 #if defined(CONFIG_CONSOLE_POLL)
@@ -753,12 +770,6 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 	return 0;
 }
 
-static bool lpuart_is_32(struct lpuart_port *sport)
-{
-	return sport->port.iotype == UPIO_MEM32 ||
-	       sport->port.iotype ==  UPIO_MEM32BE;
-}
-
 static irqreturn_t lpuart_txint(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-- 
2.21.0
