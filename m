From: Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH 1/3] serial: mxs-auart: implement flush_buffer hook
Date: Fri, 29 Nov 2013 17:35:25 +0100
Message-ID: <1385742927-11358-2-git-send-email-hector.palacios@digi.com>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
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
Cc: fabio.estevam@freescale.com, marex@denx.de, gregkh@linuxfoundation.org, b32955@freescale.com, hector.palacios@digi.com, u.kleine-koenig@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Terminate any DMA transfer and verify the TX FIFO is empty.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/tty/serial/mxs-auart.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 9f0461778fc1..d9bf6e103f65 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -782,6 +782,28 @@ static unsigned int mxs_auart_tx_empty(struct uart_port *u)
 		return 0;
 }
 
+/*
+ * Flush the transmit buffer.
+ * Locking: called with port lock held and IRQs disabled.
+ */
+static void mxs_auart_flush_buffer(struct uart_port *u)
+{
+	struct mxs_auart_port *s = to_auart_port(u);
+	struct dma_chan *channel = s->tx_dma_chan;
+	unsigned int to;
+
+	if (auart_dma_enabled(s)) {
+		/* Avoid deadlock with the DMA engine callback */
+		spin_unlock(&s->port.lock);
+		dmaengine_terminate_all(channel);
+		spin_lock(&s->port.lock);
+	}
+	/* Wait for the FIFO to flush */
+	to = u->timeout;
+	while (!mxs_auart_tx_empty(u) && to--)
+		mdelay(1);
+}
+
 static void mxs_auart_start_tx(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
@@ -828,6 +850,7 @@ static struct uart_ops mxs_auart_ops = {
 	.get_mctrl      = mxs_auart_get_mctrl,
 	.startup	= mxs_auart_startup,
 	.shutdown       = mxs_auart_shutdown,
+	.flush_buffer	= mxs_auart_flush_buffer,
 	.set_termios    = mxs_auart_settermios,
 	.type	   	= mxs_auart_type,
 	.release_port   = mxs_auart_release_port,
