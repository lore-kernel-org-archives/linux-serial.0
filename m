From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 02/24] tty: serial: fsl_lpuart: flush receive FIFO after overruns
Date: Mon, 29 Jul 2019 12:52:04 -0700
Message-ID: <20190729195226.8862-3-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Stefan Agner <stefan.agner@toradex.com>, Max Krummenacher <max.krummenacher@toradex.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

After overruns the FIFO pointers become misaligned. This
typically shows by characters still being stuck in the FIFO
despite the empty flag being asserted. After the first
assertion of the overrun flag the empty flag still seems to
indicate FIFO state correctly and all data can be read.
However, after another overrun assertion the FIFO seems to
be off by one such that the last received character is still
in the FIFO (despite the empty flag being asserted).

Flushing the receive FIFO reinitializes pointers. Hence it
is recommended to flush the FIFO after overruns, see also:
https://community.nxp.com/thread/321175

Hence, on assertion of the overrun flag read the remaining
data from the FIFO and flush buffers.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Acked-by: Max Krummenacher <max.krummenacher@toradex.com>
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
 drivers/tty/serial/fsl_lpuart.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 586b3513a6b0..edb1a9425fac 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -798,7 +798,7 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned int flg, ignored = 0;
+	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags;
 	unsigned char rx, sr;
@@ -825,7 +825,7 @@ static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 				sport->port.icount.frame++;
 
 			if (sr & UARTSR1_OR)
-				sport->port.icount.overrun++;
+				overrun++;
 
 			if (sr & sport->port.ignore_status_mask) {
 				if (++ignored > 100)
@@ -852,6 +852,17 @@ static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 	}
 
 out:
+	if (overrun) {
+		sport->port.icount.overrun += overrun;
+
+		/*
+		 * Overruns cause FIFO pointers to become missaligned.
+		 * Flushing the receive FIFO reinitializes the pointers.
+		 */
+		writeb(UARTCFIFO_RXFLUSH, sport->port.membase + UARTCFIFO);
+		writeb(UARTSFIFO_RXOF, sport->port.membase + UARTSFIFO);
+	}
+
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	tty_flip_buffer_push(port);
-- 
2.21.0
