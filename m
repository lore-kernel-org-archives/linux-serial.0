From: Evan Green <evgreen@chromium.org>
Subject: [PATCH] tty: serial: msm_geni_serial: Fix TX infinite loop
Date: Wed,  9 May 2018 13:44:29 -0700
Message-ID: <20180509204429.62778-1-evgreen@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Doug Anderson <dianders@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
List-Id: linux-serial@vger.kernel.org

The GENI serial driver handled transmit by leaving stuff in the
common circular buffer until it had completely caught up to the head,
then clearing it out all at once. This is a suboptimal way to do
transmit, as it leaves data in the circular buffer that could be
freed. Moreover, the logic implementing it is wrong, and it is easy to
get into a situation where the UART infinitely writes out the same buffer.

I could reproduce infinite serial output of the same buffer by running
dmesg, then hitting Ctrl-C. I believe what happened is xmit_size was
something large, marching towards a larger value. Then the generic OS
code flushed out the buffer and replaced it with two characters. Now the
xmit_size is a large value marching towards a small value, which it wasn't
expecting. The driver subtracts xmit_size (very large) from
uart_circ_chars_pending (2), underflows, and repeats ad nauseum. The
locking isn't wrong here, as the locks are held whenever the buffer is
manipulated, it's just that the driver wasn't expecting the buffer to be
flushed out from underneath it in between transmits.

This change reworks transmit to grab what it can from the circular buffer,
and then update ->tail, both fixing the underflow and freeing up space
for a smoother circular experience.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Note: This patch applies on top of Karthik's series of 8 fixup patches,
which seem basically ready to go, at:

https://www.spinics.net/lists/linux-arm-msm/msg36561.html

Karthik had some concerns here in that apparently he had done it the way it
was on purpose in order to avoid a watchdog timeout with very large kernel
logs. Doug's and my best interpretation of his explanation is that maybe the
UART is so fast, and the FIFO is potentially only 16 bytes wide, so by the
time the data has been loaded up into the FIFO and the interrupt handler
returns, the UART has finished and the interrupt fires again immediately.
His original solution works because the buffer fills up completely,
and handle_tx calls stop_tx and uart_write_wakeup, which usually happens to
take enough time to let the interrupting core schedule something.

The old way this driver was doing it, artificially letting the circular buffer
balloon up and eventually pop, still seems like the wrong approach to me.
Perhaps this means that DMA mode should be considered, or a threaded irq,
or at least a larger FIFO. Or perhaps smaller kernel logs.

 drivers/tty/serial/qcom_geni_serial.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9d773a991369..f296a62bd811 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -98,7 +98,6 @@ struct qcom_geni_serial_port {
 	enum geni_se_xfer_mode xfer_mode;
 	bool setup;
 	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
-	unsigned int xmit_size;
 	unsigned int baud;
 	unsigned int tx_bytes_pw;
 	unsigned int rx_bytes_pw;
@@ -462,7 +461,6 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 		writel_relaxed(0, uport->membase +
 				     SE_GENI_TX_WATERMARK_REG);
 	}
-	port->xmit_size = 0;
 	writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
 	/* Possible stop tx is called multiple times. */
@@ -592,16 +590,13 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport)
 	chunk = uart_circ_chars_pending(xmit);
 	status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
 	/* Both FIFO and framework buffer are drained */
-	if (chunk == port->xmit_size && !status) {
-		port->xmit_size = 0;
-		uart_circ_clear(xmit);
+	if (!chunk && !status) {
 		qcom_geni_serial_stop_tx(uport);
 		goto out_write_wakeup;
 	}
-	chunk -= port->xmit_size;
 
 	avail = (port->tx_fifo_depth - port->tx_wm) * port->tx_bytes_pw;
-	tail = (xmit->tail + port->xmit_size) & (UART_XMIT_SIZE - 1);
+	tail = xmit->tail;
 	chunk = min3((size_t)chunk, (size_t)(UART_XMIT_SIZE - tail), avail);
 	if (!chunk)
 		goto out_write_wakeup;
@@ -622,14 +617,16 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport)
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
 		i += tx_bytes;
-		tail = (tail + tx_bytes) & (UART_XMIT_SIZE - 1);
+		tail += tx_bytes;
 		uport->icount.tx += tx_bytes;
 		remaining -= tx_bytes;
 	}
+
+	xmit->tail = tail & (UART_XMIT_SIZE - 1);
 	qcom_geni_serial_poll_tx_done(uport);
-	port->xmit_size += chunk;
 out_write_wakeup:
-	uart_write_wakeup(uport);
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(uport);
 }
 
 static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
-- 
2.17.0.441.gb46fe60e1d-goog
