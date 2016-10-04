From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: [PATCH 1/2] tty: serial: fsl_lpuart: add polled console functions
Date: Tue,  4 Oct 2016 15:46:16 +0300
Message-ID: <1475585177-28777-2-git-send-email-nicolae.rosia.oss@gmail.com>
References: <1475585177-28777-1-git-send-email-nicolae.rosia.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1475585177-28777-1-git-send-email-nicolae.rosia.oss@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Agner <stefan@agner.ch>, Stefan Golinschi <stefan.golinschi@gmail.com>, Jiri Slaby <jslaby@suse.com>, Nicolae Rosia <nicolae_rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Nicolae Rosia <nicolae_rosia@mentor.com>

This adds polling functions as used by kgdb.

Signed-off-by: Nicolae Rosia <nicolae_rosia@mentor.com>
Signed-off-by: Stefan Golinschi <stefan.golinschi@gmail.com>
---
 drivers/tty/serial/fsl_lpuart.c | 66 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index de9d510..49d7526 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -431,6 +431,67 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	}
 }
 
+#if defined(CONFIG_CONSOLE_POLL)
+
+static int lpuart_poll_init(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port,
+					struct lpuart_port, port);
+	unsigned long flags;
+	unsigned char temp;
+
+	sport->port.fifosize = 0;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+	/* Disable Rx & Tx */
+	writeb(0, sport->port.membase + UARTCR2);
+
+	temp = readb(sport->port.membase + UARTPFIFO);
+	/* Enable Rx and Tx FIFO */
+	writeb(temp | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
+			sport->port.membase + UARTPFIFO);
+
+	/* flush Tx and Rx FIFO */
+	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
+			sport->port.membase + UARTCFIFO);
+
+	/* explicitly clear RDRF */
+	if (readb(sport->port.membase + UARTSR1) & UARTSR1_RDRF) {
+		readb(sport->port.membase + UARTDR);
+		writeb(UARTSFIFO_RXUF, sport->port.membase + UARTSFIFO);
+	}
+
+	writeb(0, sport->port.membase + UARTTWFIFO);
+	writeb(1, sport->port.membase + UARTRWFIFO);
+
+	/* Enable Rx and Tx */
+	writeb(UARTCR2_RE | UARTCR2_TE, sport->port.membase + UARTCR2);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	return 0;
+}
+
+static void lpuart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned int status;
+
+	/* drain */
+	while (!(readb(port->membase + UARTSR1) & UARTSR1_TDRE))
+		barrier();
+
+	writeb(c, port->membase + UARTDR);
+}
+
+static int lpuart_poll_get_char(struct uart_port *port)
+{
+	if (!(readb(port->membase + UARTSR1) & UARTSR1_RDRF))
+		return NO_POLL_CHAR;
+
+	return readb(port->membase + UARTDR);
+}
+
+#endif
+
 static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
@@ -1596,6 +1657,11 @@ static const struct uart_ops lpuart_pops = {
 	.config_port	= lpuart_config_port,
 	.verify_port	= lpuart_verify_port,
 	.flush_buffer	= lpuart_flush_buffer,
+#if defined(CONFIG_CONSOLE_POLL)
+	.poll_init	= lpuart_poll_init,
+	.poll_get_char	= lpuart_poll_get_char,
+	.poll_put_char	= lpuart_poll_put_char,
+#endif
 };
 
 static const struct uart_ops lpuart32_pops = {
-- 
2.5.5
