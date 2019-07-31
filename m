From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 19/23] tty: serial: fsl_lpuart: Introduce lpuart_rx_dma_startup()
Date: Wed, 31 Jul 2019 10:30:41 -0700
Message-ID: <20190731173045.11718-20-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Code doing initial DMA RX configuration in lpuart_startup() and
lpuart32_startup() is exactly the same, so move it into a standalone
subroutine.

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
 drivers/tty/serial/fsl_lpuart.c | 40 ++++++++++++++-------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5f2dc43676f7..7d67e9631623 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1455,6 +1455,21 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 	}
 }
 
+static void lpuart_rx_dma_startup(struct lpuart_port *sport)
+{
+	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
+		/* set Rx DMA timeout */
+		sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
+		if (!sport->dma_rx_timeout)
+			sport->dma_rx_timeout = 1;
+
+		sport->lpuart_dma_rx_use = true;
+		rx_dma_timer_init(sport);
+	} else {
+		sport->lpuart_dma_rx_use = false;
+	}
+}
+
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1479,18 +1494,7 @@ static int lpuart_startup(struct uart_port *port)
 	temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
 	writeb(temp, sport->port.membase + UARTCR2);
 
-	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
-		/* set Rx DMA timeout */
-		sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
-		if (!sport->dma_rx_timeout)
-		     sport->dma_rx_timeout = 1;
-
-		sport->lpuart_dma_rx_use = true;
-		rx_dma_timer_init(sport);
-	} else {
-		sport->lpuart_dma_rx_use = false;
-	}
-
+	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -1522,18 +1526,8 @@ static int lpuart32_startup(struct uart_port *port)
 	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
 	lpuart32_write(&sport->port, temp, UARTCTRL);
 
-	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
-		/* set Rx DMA timeout */
-		sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
-		if (!sport->dma_rx_timeout)
-			sport->dma_rx_timeout = 1;
-
-		sport->lpuart_dma_rx_use = true;
-		rx_dma_timer_init(sport);
-	} else {
-		sport->lpuart_dma_rx_use = false;
-	}
 
+	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(sport);
 
 	if (sport->lpuart_dma_rx_use) {
-- 
2.21.0
