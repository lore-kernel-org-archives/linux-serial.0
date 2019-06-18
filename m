From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 2/5] serial: stm32: update PIO transmission
Date: Tue, 18 Jun 2019 12:02:23 +0200
Message-ID: <1560852146-3393-3-git-send-email-erwan.leray@st.com>
References: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>
List-Id: linux-serial@vger.kernel.org

Improves PIO transmission:
- Replaces the FIFO filling per character by a filling per blocks of
  characters, which provides better performances
- Replaces the active waiting loop by TX empty interrupt dynamic handling.
  TXE interrupt is now enabled when data has to be sent (ie when
  uart_circ is not empty), and inhibited when there is no more data to
  send (ie when uart_circ is empty).

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e1cfb1e..8316e19 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -303,27 +303,26 @@ static void stm32_transmit_chars_pio(struct uart_port *port)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
-	unsigned int isr;
-	int ret;
 
 	if (stm32_port->tx_dma_busy) {
 		stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 		stm32_port->tx_dma_busy = false;
 	}
 
-	ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
-						isr,
-						(isr & USART_SR_TXE),
-						10, 100000);
-
-	if (ret)
-		dev_err(port->dev, "tx empty not set\n");
-
-	stm32_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
+	while (!uart_circ_empty(xmit)) {
+		/* Check that TDR is empty before filling FIFO */
+		if (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
+			break;
+		writel_relaxed(xmit->buf[xmit->tail], port->membase + ofs->tdr);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
 
-	writel_relaxed(xmit->buf[xmit->tail], port->membase + ofs->tdr);
-	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-	port->icount.tx++;
+	/* rely on TXE irq (mask or unmask) for sending remaining data */
+	if (uart_circ_empty(xmit))
+		stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
+	else
+		stm32_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
 }
 
 static void stm32_transmit_chars_dma(struct uart_port *port)
-- 
1.9.1
