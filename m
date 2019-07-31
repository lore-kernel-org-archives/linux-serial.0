From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 17/23] tty: serial: fsl_lpuart: Introduce lpuart_dma_shutdown()
Date: Wed, 31 Jul 2019 10:30:39 -0700
Message-ID: <20190731173045.11718-18-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Last steps of .shutdown() code are identical for lpuart and lpuart32
cases, so move it all into a standalone subroutine.

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
 drivers/tty/serial/fsl_lpuart.c | 42 ++++++++++++++-------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 2597a877d639..8cf10d12947f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1547,6 +1547,22 @@ static int lpuart32_startup(struct uart_port *port)
 	return 0;
 }
 
+static void lpuart_dma_shutdown(struct lpuart_port *sport)
+{
+	if (sport->lpuart_dma_rx_use) {
+		del_timer_sync(&sport->lpuart_timer);
+		lpuart_dma_rx_free(&sport->port);
+	}
+
+	if (sport->lpuart_dma_tx_use) {
+		if (wait_event_interruptible(sport->dma_wait,
+			!sport->dma_tx_in_progress) != false) {
+			sport->dma_tx_in_progress = false;
+			dmaengine_terminate_all(sport->dma_tx_chan);
+		}
+	}
+}
+
 static void lpuart_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1563,18 +1579,7 @@ static void lpuart_shutdown(struct uart_port *port)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (sport->lpuart_dma_rx_use) {
-		del_timer_sync(&sport->lpuart_timer);
-		lpuart_dma_rx_free(&sport->port);
-	}
-
-	if (sport->lpuart_dma_tx_use) {
-		if (wait_event_interruptible(sport->dma_wait,
-			!sport->dma_tx_in_progress) != false) {
-			sport->dma_tx_in_progress = false;
-			dmaengine_terminate_all(sport->dma_tx_chan);
-		}
-	}
+	lpuart_dma_shutdown(sport);
 }
 
 static void lpuart32_shutdown(struct uart_port *port)
@@ -1594,18 +1599,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (sport->lpuart_dma_rx_use) {
-		del_timer_sync(&sport->lpuart_timer);
-		lpuart_dma_rx_free(&sport->port);
-	}
-
-	if (sport->lpuart_dma_tx_use) {
-		if (wait_event_interruptible(sport->dma_wait,
-					     !sport->dma_tx_in_progress)) {
-			sport->dma_tx_in_progress = false;
-			dmaengine_terminate_all(sport->dma_tx_chan);
-		}
-	}
+	lpuart_dma_shutdown(sport);
 }
 
 static void
-- 
2.21.0
