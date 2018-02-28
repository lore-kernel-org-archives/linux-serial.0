From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 2/2] serial: stm32: add support for RS485 hardware control
 mode
Date: Wed, 28 Feb 2018 10:56:19 +0000
Message-ID: <1519815373-22940-3-git-send-email-bich.hemon@st.com>
References: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

Implement Driver Enable signal (DE) to activate the transmission mode
of the external transceiver.

Signed-off-by: Yves Coppeaux <yves.coppeaux@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 134 ++++++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h |   3 +
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 5c85cbc..6d34472 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -62,6 +62,113 @@ static void stm32_clr_bits(struct uart_port *port, u32 reg, u32 bits)
 	writel_relaxed(val, port->membase + reg);
 }
 
+static void stm32_config_reg_rs485(u32 *cr1, u32 *cr3, u32 delay_ADE,
+				   u32 delay_DDE, u32 baud)
+{
+	u32 rs485_deat_dedt;
+	u32 rs485_deat_dedt_max = (USART_CR1_DEAT_MASK >> USART_CR1_DEAT_SHIFT);
+	bool over8;
+
+	*cr3 |= USART_CR3_DEM;
+	over8 = *cr1 & USART_CR1_OVER8;
+
+	if (over8)
+		rs485_deat_dedt = delay_ADE * baud * 8;
+	else
+		rs485_deat_dedt = delay_ADE * baud * 16;
+
+	rs485_deat_dedt = DIV_ROUND_CLOSEST(rs485_deat_dedt, 1000);
+	rs485_deat_dedt = rs485_deat_dedt > rs485_deat_dedt_max ?
+			  rs485_deat_dedt_max : rs485_deat_dedt;
+	rs485_deat_dedt = (rs485_deat_dedt << USART_CR1_DEAT_SHIFT) &
+			   USART_CR1_DEAT_MASK;
+	*cr1 |= rs485_deat_dedt;
+
+	if (over8)
+		rs485_deat_dedt = delay_DDE * baud * 8;
+	else
+		rs485_deat_dedt = delay_DDE * baud * 16;
+
+	rs485_deat_dedt = DIV_ROUND_CLOSEST(rs485_deat_dedt, 1000);
+	rs485_deat_dedt = rs485_deat_dedt > rs485_deat_dedt_max ?
+			  rs485_deat_dedt_max : rs485_deat_dedt;
+	rs485_deat_dedt = (rs485_deat_dedt << USART_CR1_DEDT_SHIFT) &
+			   USART_CR1_DEDT_MASK;
+	*cr1 |= rs485_deat_dedt;
+}
+
+static int stm32_config_rs485(struct uart_port *port,
+			      struct serial_rs485 *rs485conf)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	u32 usartdiv, baud, cr1, cr3;
+	bool over8;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
+
+	port->rs485 = *rs485conf;
+
+	rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
+	if (rs485conf->flags & SER_RS485_ENABLED) {
+		cr1 = readl_relaxed(port->membase + ofs->cr1);
+		cr3 = readl_relaxed(port->membase + ofs->cr3);
+		usartdiv = readl_relaxed(port->membase + ofs->brr);
+		usartdiv = usartdiv & GENMASK(15, 0);
+		over8 = cr1 & USART_CR1_OVER8;
+
+		if (over8)
+			usartdiv = usartdiv | (usartdiv & GENMASK(4, 0))
+				   << USART_BRR_04_R_SHIFT;
+
+		baud = DIV_ROUND_CLOSEST(port->uartclk, usartdiv);
+		stm32_config_reg_rs485(&cr1, &cr3,
+				       rs485conf->delay_rts_before_send,
+				       rs485conf->delay_rts_after_send, baud);
+
+		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
+			cr3 &= ~USART_CR3_DEP;
+			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+		} else {
+			cr3 |= USART_CR3_DEP;
+			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+		}
+
+		writel_relaxed(cr3, port->membase + ofs->cr3);
+		writel_relaxed(cr1, port->membase + ofs->cr1);
+	} else {
+		stm32_clr_bits(port, ofs->cr3, USART_CR3_DEM | USART_CR3_DEP);
+		stm32_clr_bits(port, ofs->cr1,
+			       USART_CR1_DEDT_MASK | USART_CR1_DEAT_MASK);
+	}
+
+	stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return 0;
+}
+
+static int stm32_init_rs485(struct uart_port *port,
+			    struct platform_device *pdev)
+{
+	struct serial_rs485 *rs485conf = &port->rs485;
+
+	rs485conf->flags = 0;
+	rs485conf->delay_rts_before_send = 0;
+	rs485conf->delay_rts_after_send = 0;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	uart_get_rs485_mode(&pdev->dev, rs485conf);
+
+	return 0;
+}
+
 static int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
 			    bool threaded)
 {
@@ -498,6 +605,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
+	struct serial_rs485 *rs485conf = &port->rs485;
 	unsigned int baud;
 	u32 usartdiv, mantissa, fraction, oversampling;
 	tcflag_t cflag = termios->c_cflag;
@@ -515,7 +623,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	writel_relaxed(0, port->membase + ofs->cr1);
 
 	cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_RXNEIE;
-	cr1 |= BIT(cfg->uart_enable_bit);
+
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
@@ -553,9 +661,11 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	if (usartdiv < 16) {
 		oversampling = 8;
+		cr1 |= USART_CR1_OVER8;
 		stm32_set_bits(port, ofs->cr1, USART_CR1_OVER8);
 	} else {
 		oversampling = 16;
+		cr1 &= ~USART_CR1_OVER8;
 		stm32_clr_bits(port, ofs->cr1, USART_CR1_OVER8);
 	}
 
@@ -592,10 +702,28 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (stm32_port->rx_ch)
 		cr3 |= USART_CR3_DMAR;
 
+	if (rs485conf->flags & SER_RS485_ENABLED) {
+		stm32_config_reg_rs485(&cr1, &cr3,
+				       rs485conf->delay_rts_before_send,
+				       rs485conf->delay_rts_after_send, baud);
+		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
+			cr3 &= ~USART_CR3_DEP;
+			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+		} else {
+			cr3 |= USART_CR3_DEP;
+			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+		}
+
+	} else {
+		cr3 &= ~(USART_CR3_DEM | USART_CR3_DEP);
+		cr1 &= ~(USART_CR1_DEDT_MASK | USART_CR1_DEAT_MASK);
+	}
+
 	writel_relaxed(cr3, port->membase + ofs->cr3);
 	writel_relaxed(cr2, port->membase + ofs->cr2);
 	writel_relaxed(cr1, port->membase + ofs->cr1);
 
+	stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -681,6 +809,10 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
 	port->irq	= platform_get_irq_byname(pdev, "event");
+
+	port->rs485_config = stm32_config_rs485;
+	stm32_init_rs485(port, pdev);
+
 	stm32port->wakeirq = platform_get_irq_byname(pdev, "wakeup");
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 2294d0f..6f294e2 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -135,6 +135,7 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_BRR_DIV_F_MASK	GENMASK(3, 0)
 #define USART_BRR_DIV_M_MASK	GENMASK(15, 4)
 #define USART_BRR_DIV_M_SHIFT	4
+#define USART_BRR_04_R_SHIFT	1
 
 /* USART_CR1 */
 #define USART_CR1_SBK		BIT(0)
@@ -162,6 +163,8 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_CR1_M1		BIT(28)		/* F7 */
 #define USART_CR1_IE_MASK	(GENMASK(8, 4) | BIT(14) | BIT(26) | BIT(27))
 #define USART_CR1_FIFOEN	BIT(29)		/* H7 */
+#define USART_CR1_DEAT_SHIFT 21
+#define USART_CR1_DEDT_SHIFT 16
 
 /* USART_CR2 */
 #define USART_CR2_ADD_MASK	GENMASK(3, 0)	/* F4 */
-- 
1.9.1
