From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 04/24] tty: serial: fsl_lpuart: Simplify RX/TX IRQ handlers
Date: Mon, 29 Jul 2019 12:52:06 -0700
Message-ID: <20190729195226.8862-5-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

It appears that lpuart_rxint, lpuart_txint and lpuart32_rxint were
modelled after identical function found in UART driver for
i.MX. However, while said functions are used as individual IRQ
handlers in i.MX driver (in case of i.MX1), it is not the case for
LPUART. Given that, there's no need for us to restrict the prototype
of the handler to irqreturn_t foo(int, void *) and we can drop all of
uneened boilerplate code by changing it void foo(struct lpuart_port *).

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
 drivers/tty/serial/fsl_lpuart.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 56423ad02f0f..3e38970a444e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -770,9 +770,8 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 	return 0;
 }
 
-static irqreturn_t lpuart_txint(int irq, void *dev_id)
+static void lpuart_txint(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = dev_id;
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long flags;
 
@@ -803,12 +802,10 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 
 out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
-	return IRQ_HANDLED;
 }
 
-static irqreturn_t lpuart_rxint(int irq, void *dev_id)
+static void lpuart_rxint(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = dev_id;
 	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags;
@@ -877,12 +874,10 @@ static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	tty_flip_buffer_push(port);
-	return IRQ_HANDLED;
 }
 
-static irqreturn_t lpuart32_rxint(int irq, void *dev_id)
+static void lpuart32_rxint(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = dev_id;
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags;
@@ -941,7 +936,6 @@ static irqreturn_t lpuart32_rxint(int irq, void *dev_id)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	tty_flip_buffer_push(port);
-	return IRQ_HANDLED;
 }
 
 static irqreturn_t lpuart_int(int irq, void *dev_id)
@@ -952,10 +946,10 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 	sts = readb(sport->port.membase + UARTSR1);
 
 	if (sts & UARTSR1_RDRF)
-		lpuart_rxint(irq, dev_id);
+		lpuart_rxint(sport);
 
 	if (sts & UARTSR1_TDRE)
-		lpuart_txint(irq, dev_id);
+		lpuart_txint(sport);
 
 	return IRQ_HANDLED;
 }
@@ -970,10 +964,10 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
 	rxcount = rxcount >> UARTWATER_RXCNT_OFF;
 
 	if ((sts & UARTSTAT_RDRF || rxcount > 0) && !sport->lpuart_dma_rx_use)
-		lpuart32_rxint(irq, dev_id);
+		lpuart32_rxint(sport);
 
 	if ((sts & UARTSTAT_TDRE) && !sport->lpuart_dma_tx_use)
-		lpuart_txint(irq, dev_id);
+		lpuart_txint(sport);
 
 	lpuart32_write(&sport->port, sts, UARTSTAT);
 	return IRQ_HANDLED;
-- 
2.21.0
