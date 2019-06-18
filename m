From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 4/5] serial: stm32: add support of RX FIFO threshold
Date: Tue, 18 Jun 2019 12:02:25 +0200
Message-ID: <1560852146-3393-5-git-send-email-erwan.leray@st.com>
References: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>
List-Id: linux-serial@vger.kernel.org

Adds the support of RX FIFO threshold in order to improve the RX FIFO
management.
This is done by enabling fifo threshold interrupt, instead of relying
on rx empty/fifo not full irq. That basically generates one irq/char
currently. With this patch:
- RXCFG is set to half fifo size (e.g. 16/2 = 8 data for a 16 data depth
  FIFO)
- irq rate may be reduced by up to 1/RXCFG,  e.g. 1 over 8 with current
  RXCFG setting.
- Receiver timeout is used to gather chars when FIFO threshold isn't
  reached.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 397d86d..4083145 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -550,6 +550,9 @@ static void stm32_throttle(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 	stm32_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
+	if (stm32_port->cr3_irq)
+		stm32_clr_bits(port, ofs->cr3, stm32_port->cr3_irq);
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -562,6 +565,9 @@ static void stm32_unthrottle(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 	stm32_set_bits(port, ofs->cr1, stm32_port->cr1_irq);
+	if (stm32_port->cr3_irq)
+		stm32_set_bits(port, ofs->cr3, stm32_port->cr3_irq);
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -572,6 +578,9 @@ static void stm32_stop_rx(struct uart_port *port)
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	stm32_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
+	if (stm32_port->cr3_irq)
+		stm32_clr_bits(port, ofs->cr3, stm32_port->cr3_irq);
+
 }
 
 /* Handle breaks - ignored by us */
@@ -600,8 +609,9 @@ static int stm32_startup(struct uart_port *port)
 
 	if (stm32_port->fifoen) {
 		val = readl_relaxed(port->membase + ofs->cr3);
-		val &= ~USART_CR3_TXFTCFG_MASK;
+		val &= ~(USART_CR3_TXFTCFG_MASK | USART_CR3_RXFTCFG_MASK);
 		val |= USART_CR3_TXFTCFG_HALF << USART_CR3_TXFTCFG_SHIFT;
+		val |= USART_CR3_RXFTCFG_HALF << USART_CR3_RXFTCFG_SHIFT;
 		writel_relaxed(val, port->membase + ofs->cr3);
 	}
 
@@ -693,7 +703,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
 	cr3 = readl_relaxed(port->membase + ofs->cr3);
-	cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTCFG | USART_CR3_RXFTIE
+	cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTCFG_MASK | USART_CR3_RXFTIE
 		| USART_CR3_TXFTCFG_MASK;
 
 	if (cflag & CSTOPB)
@@ -733,8 +743,14 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 		stm32_port->cr1_irq = USART_CR1_RTOIE;
 		writel_relaxed(bits, port->membase + ofs->rtor);
 		cr2 |= USART_CR2_RTOEN;
+		/* Not using dma, enable fifo threshold irq */
+		if (!stm32_port->rx_ch)
+			stm32_port->cr3_irq =  USART_CR3_RXFTIE;
 	}
 
+	cr1 |= stm32_port->cr1_irq;
+	cr3 |= stm32_port->cr3_irq;
+
 	if (cflag & PARODD)
 		cr1 |= USART_CR1_PS;
 
@@ -976,6 +992,7 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 							"st,hw-flow-ctrl");
 	stm32_ports[id].port.line = id;
 	stm32_ports[id].cr1_irq = USART_CR1_RXNEIE;
+	stm32_ports[id].cr3_irq = 0;
 	stm32_ports[id].last_res = RX_BUF_L;
 	return &stm32_ports[id];
 }
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index a598446..a175c10 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -210,7 +210,8 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_CR3_WUFIE		BIT(22)		/* H7 */
 #define USART_CR3_TXFTIE	BIT(23)		/* H7 */
 #define USART_CR3_TCBGTIE	BIT(24)		/* H7 */
-#define USART_CR3_RXFTCFG	GENMASK(27, 25)	/* H7 */
+#define USART_CR3_RXFTCFG_MASK	GENMASK(27, 25)	/* H7 */
+#define USART_CR3_RXFTCFG_SHIFT	25		/* H7 */
 #define USART_CR3_RXFTIE	BIT(28)		/* H7 */
 #define USART_CR3_TXFTCFG_MASK	GENMASK(31, 29)	/* H7 */
 #define USART_CR3_TXFTCFG_SHIFT	29		/* H7 */
@@ -218,6 +219,9 @@ struct stm32_usart_info stm32h7_info = {
 /* TX FIFO threashold set to half of its depth */
 #define USART_CR3_TXFTCFG_HALF	0x2
 
+/* RX FIFO threashold set to half of its depth */
+#define USART_CR3_RXFTCFG_HALF	0x2
+
 /* USART_GTPR */
 #define USART_GTPR_PSC_MASK	GENMASK(7, 0)
 #define USART_GTPR_GT_MASK	GENMASK(15, 8)
@@ -263,6 +267,7 @@ struct stm32_port {
 	dma_addr_t tx_dma_buf;   /* dma tx buffer bus address */
 	unsigned char *tx_buf;   /* dma tx buffer cpu address */
 	u32 cr1_irq;		 /* USART_CR1_RXNEIE or RTOIE */
+	u32 cr3_irq;		 /* USART_CR3_RXFTIE */
 	int last_res;
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
-- 
1.9.1
