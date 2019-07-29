From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 21/24] tty: serial: fsl_lpuart: Introduce lpuart32_configure()
Date: Mon, 29 Jul 2019 12:52:23 -0700
Message-ID: <20190729195226.8862-22-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Code doing final steps of TX/RX configuration in lpuart32_startup()
and lpuart_resume() is identical, so move it into a standalone
subroutine.

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
 drivers/tty/serial/fsl_lpuart.c | 48 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bda01d23cea8..112fb1e19a1c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1502,6 +1502,24 @@ static int lpuart_startup(struct uart_port *port)
 	return 0;
 }
 
+static void lpuart32_configure(struct lpuart_port *sport)
+{
+	unsigned long temp;
+
+	if (sport->lpuart_dma_rx_use) {
+		/* RXWATER must be 0 */
+		temp = lpuart32_read(&sport->port, UARTWATER);
+		temp &= ~(UARTWATER_WATER_MASK << UARTWATER_RXWATER_OFF);
+		lpuart32_write(&sport->port, temp, UARTWATER);
+	}
+	temp = lpuart32_read(&sport->port, UARTCTRL);
+	if (!sport->lpuart_dma_rx_use)
+		temp |= UARTCTRL_RIE;
+	if (!sport->lpuart_dma_tx_use)
+		temp |= UARTCTRL_TIE;
+	lpuart32_write(&sport->port, temp, UARTCTRL);
+}
+
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1530,18 +1548,7 @@ static int lpuart32_startup(struct uart_port *port)
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(port);
 
-	if (sport->lpuart_dma_rx_use) {
-		/* RXWATER must be 0 */
-		temp = lpuart32_read(&sport->port, UARTWATER);
-		temp &= ~(UARTWATER_WATER_MASK << UARTWATER_RXWATER_OFF);
-		lpuart32_write(&sport->port, temp, UARTWATER);
-	}
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	if (!sport->lpuart_dma_rx_use)
-		temp |= UARTCTRL_RIE;
-	if (!sport->lpuart_dma_tx_use)
-		temp |= UARTCTRL_TIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_configure(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 	return 0;
@@ -2582,21 +2589,8 @@ static int lpuart_resume(struct device *dev)
 
 	lpuart_tx_dma_startup(sport);
 
-	if (lpuart_is_32(sport)) {
-		if (sport->lpuart_dma_rx_use) {
-			/* RXWATER must be 0 */
-			temp = lpuart32_read(&sport->port, UARTWATER);
-			temp &= ~(UARTWATER_WATER_MASK <<
-				  UARTWATER_RXWATER_OFF);
-			lpuart32_write(&sport->port, temp, UARTWATER);
-		}
-		temp = lpuart32_read(&sport->port, UARTCTRL);
-		if (!sport->lpuart_dma_rx_use)
-			temp |= UARTCTRL_RIE;
-		if (!sport->lpuart_dma_tx_use)
-			temp |= UARTCTRL_TIE;
-		lpuart32_write(&sport->port, temp, UARTCTRL);
-	}
+	if (lpuart_is_32(sport))
+		lpuart32_configure(sport);
 
 	uart_resume_port(&lpuart_reg, &sport->port);
 
-- 
2.21.0
