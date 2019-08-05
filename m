From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v3 6/6] tty: serial: fsl_lpuart: Ignore TX/RX interrupts if DMA is enabled
Date: Mon,  5 Aug 2019 11:57:01 -0700
Message-ID: <20190805185701.22863-7-andrew.smirnov@gmail.com>
References: <20190805185701.22863-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805185701.22863-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In a mixed DMA/IRQ use-case (e.g.: DMA for TX, IRQ for RX), interrupt
handler might try to handle Rx/Tx condition it shouldn't. Change the
code to only handle TX/RX event if corresponding path isn't being
handled by DMA.

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
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5c3cc1051aa8..3e17bb8a0b16 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -967,10 +967,10 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 
 	sts = readb(sport->port.membase + UARTSR1);
 
-	if (sts & UARTSR1_RDRF)
+	if (sts & UARTSR1_RDRF && !sport->lpuart_dma_rx_use)
 		lpuart_rxint(sport);
 
-	if (sts & UARTSR1_TDRE)
+	if (sts & UARTSR1_TDRE && !sport->lpuart_dma_tx_use)
 		lpuart_txint(sport);
 
 	return IRQ_HANDLED;
-- 
2.21.0
