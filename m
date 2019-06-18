From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 1/5] serial: stm32: add support of timeout interrupt for RX
Date: Tue, 18 Jun 2019 12:02:22 +0200
Message-ID: <1560852146-3393-2-git-send-email-erwan.leray@st.com>
References: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>
List-Id: linux-serial@vger.kernel.org

Add support of RX timeout interrupts to limit the number of interrupts.
RX timeout is a number of bits (baud clock cycles) without
transmission seen in the receiver. One character  is used as an arbitrary
RX timeout value.
If parity is enabled, the number of bits has to include parity bit.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 9c2b04e..e1cfb1e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -437,6 +437,10 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
+	if ((sr & USART_SR_RTOF) && ofs->icr != UNDEF_REG)
+		writel_relaxed(USART_ICR_RTOCF,
+			       port->membase + ofs->icr);
+
 	if ((sr & USART_SR_WUF) && (ofs->icr != UNDEF_REG))
 		writel_relaxed(USART_ICR_WUCF,
 			       port->membase + ofs->icr);
@@ -523,7 +527,7 @@ static void stm32_throttle(struct uart_port *port)
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	stm32_clr_bits(port, ofs->cr1, USART_CR1_RXNEIE);
+	stm32_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -535,7 +539,7 @@ static void stm32_unthrottle(struct uart_port *port)
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	stm32_set_bits(port, ofs->cr1, USART_CR1_RXNEIE);
+	stm32_set_bits(port, ofs->cr1, stm32_port->cr1_irq);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -545,7 +549,7 @@ static void stm32_stop_rx(struct uart_port *port)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
-	stm32_clr_bits(port, ofs->cr1, USART_CR1_RXNEIE);
+	stm32_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
 }
 
 /* Handle breaks - ignored by us */
@@ -567,7 +571,7 @@ static int stm32_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	val = USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
+	val = stm32_port->cr1_irq | USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
 		val |= USART_CR1_FIFOEN;
 	stm32_set_bits(port, ofs->cr1, val);
@@ -583,7 +587,8 @@ static void stm32_shutdown(struct uart_port *port)
 	u32 val, isr;
 	int ret;
 
-	val = USART_CR1_TXEIE | USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
+	val = USART_CR1_TXEIE | USART_CR1_TE;
+	val |= stm32_port->cr1_irq | USART_CR1_RE;
 	val |= BIT(cfg->uart_enable_bit);
 	if (stm32_port->fifoen)
 		val |= USART_CR1_FIFOEN;
@@ -653,7 +658,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* Stop serial port and reset value */
 	writel_relaxed(0, port->membase + ofs->cr1);
 
-	cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_RXNEIE;
+	cr1 = USART_CR1_TE | USART_CR1_RE;
 
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
@@ -686,6 +691,19 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 		dev_dbg(port->dev, "Unsupported data bits config: %u bits\n"
 			, bits);
 
+	if (ofs->rtor != UNDEF_REG && (stm32_port->rx_ch ||
+				       stm32_port->fifoen)) {
+		if (cflag & CSTOPB)
+			bits = bits + 3; /* 1 start bit + 2 stop bits */
+		else
+			bits = bits + 2; /* 1 start bit + 1 stop bit */
+
+		/* RX timeout irq to occur after last stop bit + bits */
+		stm32_port->cr1_irq = USART_CR1_RTOIE;
+		writel_relaxed(bits, port->membase + ofs->rtor);
+		cr2 |= USART_CR2_RTOEN;
+	}
+
 	if (cflag & PARODD)
 		cr1 |= USART_CR1_PS;
 
@@ -925,6 +943,7 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 	stm32_ports[id].hw_flow_control = of_property_read_bool(np,
 							"st,hw-flow-ctrl");
 	stm32_ports[id].port.line = id;
+	stm32_ports[id].cr1_irq = USART_CR1_RXNEIE;
 	stm32_ports[id].last_res = RX_BUF_L;
 	return &stm32_ports[id];
 }
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 30d2433..fcd01fe 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -249,6 +249,7 @@ struct stm32_port {
 	struct dma_chan *tx_ch;  /* dma tx channel            */
 	dma_addr_t tx_dma_buf;   /* dma tx buffer bus address */
 	unsigned char *tx_buf;   /* dma tx buffer cpu address */
+	u32 cr1_irq;		 /* USART_CR1_RXNEIE or RTOIE */
 	int last_res;
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
-- 
1.9.1
