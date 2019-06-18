From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 5/5] serial: stm32: add RX and TX FIFO flush
Date: Tue, 18 Jun 2019 12:02:26 +0200
Message-ID: <1560852146-3393-6-git-send-email-erwan.leray@st.com>
References: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>
List-Id: linux-serial@vger.kernel.org

Adds a flush of RX and TX FIFOs, and fixes some errors:
- adds RX FIFO flush in startup fonction
- removes the useless transmitter enabling in startup fonction
  (e.g. receiver only, see Documentation/serial/driver)
- configures FIFO threshold before enabling it, rather than after
- flushes both TX and RX in set_termios function

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4083145..21dc380 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -602,11 +602,11 @@ static int stm32_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	val = stm32_port->cr1_irq | USART_CR1_TE | USART_CR1_RE;
-	if (stm32_port->fifoen)
-		val |= USART_CR1_FIFOEN;
-	stm32_set_bits(port, ofs->cr1, val);
+	/* RX FIFO Flush */
+	if (ofs->rqr != UNDEF_REG)
+		stm32_set_bits(port, ofs->rqr, USART_RQR_RXFRQ);
 
+	/* Tx and RX FIFO configuration */
 	if (stm32_port->fifoen) {
 		val = readl_relaxed(port->membase + ofs->cr3);
 		val &= ~(USART_CR3_TXFTCFG_MASK | USART_CR3_RXFTCFG_MASK);
@@ -615,6 +615,12 @@ static int stm32_startup(struct uart_port *port)
 		writel_relaxed(val, port->membase + ofs->cr3);
 	}
 
+	/* RX FIFO enabling */
+	val = stm32_port->cr1_irq | USART_CR1_RE;
+	if (stm32_port->fifoen)
+		val |= USART_CR1_FIFOEN;
+	stm32_set_bits(port, ofs->cr1, val);
+
 	return 0;
 }
 
@@ -697,8 +703,12 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* Stop serial port and reset value */
 	writel_relaxed(0, port->membase + ofs->cr1);
 
-	cr1 = USART_CR1_TE | USART_CR1_RE;
+	/* flush RX & TX FIFO */
+	if (ofs->rqr != UNDEF_REG)
+		stm32_set_bits(port, ofs->rqr,
+			       USART_RQR_TXFRQ | USART_RQR_RXFRQ);
 
+	cr1 = USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
-- 
1.9.1
