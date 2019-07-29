From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 01/24] tty: serial: fsl_lpuart: fix framing error handling when using DMA
Date: Mon, 29 Jul 2019 12:52:03 -0700
Message-ID: <20190729195226.8862-2-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Stefan Agner <stefan.agner@toradex.com>, Max Krummenacher <max.krummenacher@toradex.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

When using DMA framing error get cleared properly. However, due
to the additional read from the data register, an underflow in
the receive FIFO buffer occurs (the FIFO pointer gets out of
sync).

Clear the FIFO in case an underflow has occurred. Also disable the
receiver during this operation and when reading the data register to
minimize potential interference.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Acked-by: Max Krummenacher <max.krummenacher@toradex.com>
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
 drivers/tty/serial/fsl_lpuart.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 92dad2b4ec36..586b3513a6b0 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -982,6 +982,13 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 		unsigned char sr = readb(sport->port.membase + UARTSR1);
 
 		if (sr & (UARTSR1_PE | UARTSR1_FE)) {
+			unsigned char cr2;
+
+			/* Disable receiver during this operation... */
+			cr2 = readb(sport->port.membase + UARTCR2);
+			cr2 &= ~UARTCR2_RE;
+			writeb(cr2, sport->port.membase + UARTCR2);
+
 			/* Read DR to clear the error flags */
 			readb(sport->port.membase + UARTDR);
 
@@ -989,6 +996,25 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 				sport->port.icount.parity++;
 			else if (sr & UARTSR1_FE)
 				sport->port.icount.frame++;
+			/*
+			 * At this point parity/framing error is
+			 * cleared However, since the DMA already read
+			 * the data register and we had to read it
+			 * again after reading the status register to
+			 * properly clear the flags, the FIFO actually
+			 * underflowed... This requires a clearing of
+			 * the FIFO...
+			 */
+			if (readb(sport->port.membase + UARTSFIFO) &
+			    UARTSFIFO_RXUF) {
+				writeb(UARTSFIFO_RXUF,
+				       sport->port.membase + UARTSFIFO);
+				writeb(UARTCFIFO_RXFLUSH,
+				       sport->port.membase + UARTCFIFO);
+			}
+
+			cr2 |= UARTCR2_RE;
+			writeb(cr2, sport->port.membase + UARTCR2);
 		}
 	}
 
-- 
2.21.0
