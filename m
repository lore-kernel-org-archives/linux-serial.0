From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 08/20] serial: stm32: timeout interrupt using with dma
Date: Mon, 26 Jun 2017 12:49:12 +0000
Message-ID: <1498481318-1894-9-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon@st.com>

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.c | 25 +++++++++++++++++++------
 drivers/tty/serial/stm32-usart.h |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index dcc6d1e..ed2025b 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -371,6 +371,10 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
+	if ((sr & USART_SR_RTOF) && (ofs->icr != UNDEF_REG))
+		writel_relaxed(USART_ICR_RTOCF,
+			       port->membase + ofs->icr);
+
 	if ((sr & USART_SR_RXNE) && !(stm32_port->rx_ch))
 		stm32_receive_chars(port, false);
 
@@ -453,7 +457,7 @@ static void stm32_throttle(struct uart_port *port)
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	stm32_clr_bits(port, ofs->cr1, USART_CR1_RXNEIE);
+	stm32_clr_bits(port, ofs->cr1, stm32_port->rx_irq);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -465,7 +469,7 @@ static void stm32_unthrottle(struct uart_port *port)
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	stm32_set_bits(port, ofs->cr1, USART_CR1_RXNEIE);
+	stm32_set_bits(port, ofs->cr1, stm32_port->rx_irq);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -475,7 +479,7 @@ static void stm32_stop_rx(struct uart_port *port)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
-	stm32_clr_bits(port, ofs->cr1, USART_CR1_RXNEIE);
+	stm32_clr_bits(port, ofs->cr1, stm32_port->rx_irq);
 }
 
 /* Handle breaks - ignored by us */
@@ -497,7 +501,7 @@ static int stm32_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	val = USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
+	val = stm32_port->rx_irq | USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
 		val |= USART_CR1_FIFOEN;
 	stm32_set_bits(port, ofs->cr1, val);
@@ -512,7 +516,8 @@ static void stm32_shutdown(struct uart_port *port)
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 val;
 
-	val = USART_CR1_TXEIE | USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
+	val = USART_CR1_TXEIE | USART_CR1_TE;
+	val |= stm32_port->rx_irq | USART_CR1_RE;
 	val |= BIT(cfg->uart_enable_bit);
 	if (stm32_port->fifoen)
 		val |= USART_CR1_FIFOEN;
@@ -543,7 +548,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* Stop serial port and reset value */
 	writel_relaxed(0, port->membase + ofs->cr1);
 
-	cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_RXNEIE;
+	cr1 = USART_CR1_TE | USART_CR1_RE;
 	cr1 |= BIT(cfg->uart_enable_bit);
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
@@ -553,6 +558,13 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (cflag & CSTOPB)
 		cr2 |= USART_CR2_STOP_2B;
 
+	if ((ofs->rtor != UNDEF_REG) && (stm32_port->rx_ch)) {
+		stm32_port->rx_irq = USART_CR1_RTOIE;
+		writel_relaxed(baud, port->membase + ofs->rtor);
+		cr2 |= USART_CR2_RTOEN;
+	}
+	cr1 |= stm32_port->rx_irq;
+
 	if (cflag & PARENB) {
 		cr1 |= USART_CR1_PCE;
 		if ((cflag & CSIZE) == CS8) {
@@ -758,6 +770,7 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 							"st,hw-flow-ctrl");
 	stm32_ports[id].port.line = id;
 	stm32_ports[id].fifoen = true;
+	stm32_ports[id].rx_irq = USART_CR1_RXNEIE;
 	return &stm32_ports[id];
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index a8999a1..f9fe15b 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -225,6 +225,7 @@ struct stm32_port {
 	struct dma_chan *tx_ch;  /* dma tx channel            */
 	dma_addr_t tx_dma_buf;   /* dma tx buffer bus address */
 	unsigned char *tx_buf;   /* dma tx buffer cpu address */
+	u32 rx_irq;		 /* USART_CR1_RXNEIE or RTOIE */
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
 	bool fifoen;
-- 
1.9.1
