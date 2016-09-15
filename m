From: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 01/11] serial: stm32: adding support for stm32f7
Date: Thu, 15 Sep 2016 18:42:33 +0200
Message-ID: <1473957763-30629-2-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473957763-30629-1-git-send-email-alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gerald.baeza-qxv4g6HH51o@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Register offset management rework to support both
stm32f4 (default) and stm32f7. Driver rework to
ensure same functional level on both stm32f4 and
stm32f7: no new feature in this version yet.

Signed-off-by: Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index f89d1f7..e7ffd01 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) Maxime Coquelin 2015
- * Author:  Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ * Authors:  Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *	     Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>
  * License terms:  GNU General Public License (GPL), version 2
  *
  * Inspired by st-asc.c from STMicroelectronics (c)
@@ -29,16 +30,74 @@
 
 #define DRIVER_NAME "stm32-usart"
 
+struct stm32_usart_offsets {
+	u8 cr1;
+	u8 cr2;
+	u8 cr3;
+	u8 brr;
+	u8 gtpr;
+	u8 rtor;
+	u8 rqr;
+	u8 isr;
+	u8 icr;
+	u8 rdr;
+	u8 tdr;
+};
+
+struct stm32_usart_config {
+	u8 uart_enable_bit; /* USART_CR1_UE */
+	bool has_7bits_data;
+};
+
+struct stm32_usart_info {
+	struct stm32_usart_offsets ofs;
+	struct stm32_usart_config cfg;
+};
+
+#define UNDEF_REG ~0
+
 /* Register offsets */
-#define USART_SR		0x00
-#define USART_DR		0x04
-#define USART_BRR		0x08
-#define USART_CR1		0x0c
-#define USART_CR2		0x10
-#define USART_CR3		0x14
-#define USART_GTPR		0x18
-
-/* USART_SR */
+struct stm32_usart_info stm32f4_info = {
+	.ofs = {
+		.isr	= 0x00,
+		.rdr	= 0x04,
+		.tdr	= 0x04,
+		.brr	= 0x08,
+		.cr1	= 0x0c,
+		.cr2	= 0x10,
+		.cr3	= 0x14,
+		.gtpr	= 0x18,
+		.rtor	= UNDEF_REG,
+		.rqr	= UNDEF_REG,
+		.icr	= UNDEF_REG,
+	},
+	.cfg = {
+		.uart_enable_bit = 13,
+		.has_7bits_data = false,
+	}
+};
+
+struct stm32_usart_info stm32f7_info = {
+	.ofs = {
+		.cr1	= 0x00,
+		.cr2	= 0x04,
+		.cr3	= 0x08,
+		.brr	= 0x0c,
+		.gtpr	= 0x10,
+		.rtor	= 0x14,
+		.rqr	= 0x18,
+		.isr	= 0x1c,
+		.icr	= 0x20,
+		.rdr	= 0x24,
+		.tdr	= 0x28,
+	},
+	.cfg = {
+		.uart_enable_bit = 0,
+		.has_7bits_data = true,
+	}
+};
+
+/* USART_SR (F4) / USART_ISR (F7) */
 #define USART_SR_PE		BIT(0)
 #define USART_SR_FE		BIT(1)
 #define USART_SR_NF		BIT(2)
@@ -48,7 +107,16 @@
 #define USART_SR_TC		BIT(6)
 #define USART_SR_TXE		BIT(7)
 #define USART_SR_LBD		BIT(8)
-#define USART_SR_CTS		BIT(9)
+#define USART_SR_CTSIF		BIT(9)
+#define USART_SR_CTS		BIT(10)		/* F7 */
+#define USART_SR_RTOF		BIT(11)		/* F7 */
+#define USART_SR_EOBF		BIT(12)		/* F7 */
+#define USART_SR_ABRE		BIT(14)		/* F7 */
+#define USART_SR_ABRF		BIT(15)		/* F7 */
+#define USART_SR_BUSY		BIT(16)		/* F7 */
+#define USART_SR_CMF		BIT(17)		/* F7 */
+#define USART_SR_SBKF		BIT(18)		/* F7 */
+#define USART_SR_TEACK		BIT(21)		/* F7 */
 #define USART_SR_ERR_MASK	(USART_SR_LBD | USART_SR_ORE | \
 				 USART_SR_FE | USART_SR_PE)
 /* Dummy bits */
@@ -64,7 +132,7 @@
 
 /* USART_CR1 */
 #define USART_CR1_SBK		BIT(0)
-#define USART_CR1_RWU		BIT(1)
+#define USART_CR1_RWU		BIT(1)		/* F4 */
 #define USART_CR1_RE		BIT(2)
 #define USART_CR1_TE		BIT(3)
 #define USART_CR1_IDLEIE	BIT(4)
@@ -76,12 +144,20 @@
 #define USART_CR1_PCE		BIT(10)
 #define USART_CR1_WAKE		BIT(11)
 #define USART_CR1_M		BIT(12)
-#define USART_CR1_UE		BIT(13)
+#define USART_CR1_M0		BIT(12)		/* F7 */
+#define USART_CR1_MME		BIT(13)		/* F7 */
+#define USART_CR1_CMIE		BIT(14)		/* F7 */
 #define USART_CR1_OVER8		BIT(15)
-#define USART_CR1_IE_MASK	GENMASK(8, 4)
+#define USART_CR1_DEDT_MASK	GENMASK(20, 16)	/* F7 */
+#define USART_CR1_DEAT_MASK	GENMASK(25, 21)	/* F7 */
+#define USART_CR1_RTOIE		BIT(26)		/* F7 */
+#define USART_CR1_EOBIE		BIT(27)		/* F7 */
+#define USART_CR1_M1		BIT(28)		/* F7 */
+#define USART_CR1_IE_MASK	(GENMASK(8, 4) | BIT(14) | BIT(26) | BIT(27))
 
 /* USART_CR2 */
-#define USART_CR2_ADD_MASK	GENMASK(3, 0)
+#define USART_CR2_ADD_MASK	GENMASK(3, 0)	/* F4 */
+#define USART_CR2_ADDM7		BIT(4)		/* F7 */
 #define USART_CR2_LBDL		BIT(5)
 #define USART_CR2_LBDIE		BIT(6)
 #define USART_CR2_LBCL		BIT(8)
@@ -91,6 +167,15 @@
 #define USART_CR2_STOP_2B	BIT(13)
 #define USART_CR2_STOP_MASK	GENMASK(13, 12)
 #define USART_CR2_LINEN		BIT(14)
+#define USART_CR2_SWAP		BIT(15)		/* F7 */
+#define USART_CR2_RXINV		BIT(16)		/* F7 */
+#define USART_CR2_TXINV		BIT(17)		/* F7 */
+#define USART_CR2_DATAINV	BIT(18)		/* F7 */
+#define USART_CR2_MSBFIRST	BIT(19)		/* F7 */
+#define USART_CR2_ABREN		BIT(20)		/* F7 */
+#define USART_CR2_ABRMOD_MASK	GENMASK(22, 21)	/* F7 */
+#define USART_CR2_RTOEN		BIT(23)		/* F7 */
+#define USART_CR2_ADD_F7_MASK	GENMASK(31, 24)	/* F7 */
 
 /* USART_CR3 */
 #define USART_CR3_EIE		BIT(0)
@@ -105,18 +190,47 @@
 #define USART_CR3_CTSE		BIT(9)
 #define USART_CR3_CTSIE		BIT(10)
 #define USART_CR3_ONEBIT	BIT(11)
+#define USART_CR3_OVRDIS	BIT(12)		/* F7 */
+#define USART_CR3_DDRE		BIT(13)		/* F7 */
+#define USART_CR3_DEM		BIT(14)		/* F7 */
+#define USART_CR3_DEP		BIT(15)		/* F7 */
+#define USART_CR3_SCARCNT_MASK	GENMASK(19, 17)	/* F7 */
 
 /* USART_GTPR */
 #define USART_GTPR_PSC_MASK	GENMASK(7, 0)
 #define USART_GTPR_GT_MASK	GENMASK(15, 8)
 
-#define DRIVER_NAME "stm32-usart"
+/* USART_RTOR */
+#define USART_RTOR_RTO_MASK	GENMASK(23, 0)	/* F7 */
+#define USART_RTOR_BLEN_MASK	GENMASK(31, 24)	/* F7 */
+
+/* USART_RQR */
+#define USART_RQR_ABRRQ		BIT(0)		/* F7 */
+#define USART_RQR_SBKRQ		BIT(1)		/* F7 */
+#define USART_RQR_MMRQ		BIT(2)		/* F7 */
+#define USART_RQR_RXFRQ		BIT(3)		/* F7 */
+#define USART_RQR_TXFRQ		BIT(4)		/* F7 */
+
+/* USART_ICR */
+#define USART_ICR_PECF		BIT(0)		/* F7 */
+#define USART_ICR_FFECF		BIT(1)		/* F7 */
+#define USART_ICR_NCF		BIT(2)		/* F7 */
+#define USART_ICR_ORECF		BIT(3)		/* F7 */
+#define USART_ICR_IDLECF	BIT(4)		/* F7 */
+#define USART_ICR_TCCF		BIT(6)		/* F7 */
+#define USART_ICR_LBDCF		BIT(8)		/* F7 */
+#define USART_ICR_CTSCF		BIT(9)		/* F7 */
+#define USART_ICR_RTOCF		BIT(11)		/* F7 */
+#define USART_ICR_EOBCF		BIT(12)		/* F7 */
+#define USART_ICR_CMCF		BIT(17)		/* F7 */
+
 #define STM32_SERIAL_NAME "ttyS"
 #define STM32_MAX_PORTS 6
 
 struct stm32_port {
 	struct uart_port port;
 	struct clk *clk;
+	struct stm32_usart_info *info;
 	bool hw_flow_control;
 };
 
@@ -151,6 +265,8 @@ static void stm32_clr_bits(struct uart_port *port, u32 reg, u32 bits)
 static void stm32_receive_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long c;
 	u32 sr;
 	char flag;
@@ -158,9 +274,9 @@ static void stm32_receive_chars(struct uart_port *port)
 	if (port->irq_wake)
 		pm_wakeup_event(tport->tty->dev, 0);
 
-	while ((sr = readl_relaxed(port->membase + USART_SR)) & USART_SR_RXNE) {
+	while ((sr = readl_relaxed(port->membase + ofs->isr)) & USART_SR_RXNE) {
 		sr |= USART_SR_DUMMY_RX;
-		c = readl_relaxed(port->membase + USART_DR);
+		c = readl_relaxed(port->membase + ofs->rdr);
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
@@ -170,6 +286,10 @@ static void stm32_receive_chars(struct uart_port *port)
 				if (uart_handle_break(port))
 					continue;
 			} else if (sr & USART_SR_ORE) {
+				if (ofs->icr != UNDEF_REG)
+					writel_relaxed(USART_ICR_ORECF,
+						       port->membase +
+						       ofs->icr);
 				port->icount.overrun++;
 			} else if (sr & USART_SR_PE) {
 				port->icount.parity++;
@@ -199,10 +319,12 @@ static void stm32_receive_chars(struct uart_port *port)
 
 static void stm32_transmit_chars(struct uart_port *port)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (port->x_char) {
-		writel_relaxed(port->x_char, port->membase + USART_DR);
+		writel_relaxed(port->x_char, port->membase + ofs->tdr);
 		port->x_char = 0;
 		port->icount.tx++;
 		return;
@@ -218,7 +340,7 @@ static void stm32_transmit_chars(struct uart_port *port)
 		return;
 	}
 
-	writel_relaxed(xmit->buf[xmit->tail], port->membase + USART_DR);
+	writel_relaxed(xmit->buf[xmit->tail], port->membase + ofs->tdr);
 	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 	port->icount.tx++;
 
@@ -232,11 +354,13 @@ static void stm32_transmit_chars(struct uart_port *port)
 static irqreturn_t stm32_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 
 	spin_lock(&port->lock);
 
-	sr = readl_relaxed(port->membase + USART_SR);
+	sr = readl_relaxed(port->membase + ofs->isr);
 
 	if (sr & USART_SR_RXNE)
 		stm32_receive_chars(port);
@@ -251,15 +375,21 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 
 static unsigned int stm32_tx_empty(struct uart_port *port)
 {
-	return readl_relaxed(port->membase + USART_SR) & USART_SR_TXE;
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	return readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE;
 }
 
 static void stm32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
 	if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
-		stm32_set_bits(port, USART_CR3, USART_CR3_RTSE);
+		stm32_set_bits(port, ofs->cr3, USART_CR3_RTSE);
 	else
-		stm32_clr_bits(port, USART_CR3, USART_CR3_RTSE);
+		stm32_clr_bits(port, ofs->cr3, USART_CR3_RTSE);
 }
 
 static unsigned int stm32_get_mctrl(struct uart_port *port)
@@ -271,44 +401,56 @@ static unsigned int stm32_get_mctrl(struct uart_port *port)
 /* Transmit stop */
 static void stm32_stop_tx(struct uart_port *port)
 {
-	stm32_clr_bits(port, USART_CR1, USART_CR1_TXEIE);
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
 }
 
 /* There are probably characters waiting to be transmitted. */
 static void stm32_start_tx(struct uart_port *port)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (uart_circ_empty(xmit))
 		return;
 
-	stm32_set_bits(port, USART_CR1, USART_CR1_TXEIE | USART_CR1_TE);
+	stm32_set_bits(port, ofs->cr1, USART_CR1_TXEIE | USART_CR1_TE);
 }
 
 /* Throttle the remote when input buffer is about to overflow. */
 static void stm32_throttle(struct uart_port *port)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	stm32_clr_bits(port, USART_CR1, USART_CR1_RXNEIE);
+	stm32_clr_bits(port, ofs->cr1, USART_CR1_RXNEIE);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 /* Unthrottle the remote, the input buffer can now accept data. */
 static void stm32_unthrottle(struct uart_port *port)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	stm32_set_bits(port, USART_CR1, USART_CR1_RXNEIE);
+	stm32_set_bits(port, ofs->cr1, USART_CR1_RXNEIE);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 /* Receive stop */
 static void stm32_stop_rx(struct uart_port *port)
 {
-	stm32_clr_bits(port, USART_CR1, USART_CR1_RXNEIE);
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	stm32_clr_bits(port, ofs->cr1, USART_CR1_RXNEIE);
 }
 
 /* Handle breaks - ignored by us */
@@ -318,6 +460,8 @@ static void stm32_break_ctl(struct uart_port *port, int break_state)
 
 static int stm32_startup(struct uart_port *port)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	const char *name = to_platform_device(port->dev)->name;
 	u32 val;
 	int ret;
@@ -327,17 +471,19 @@ static int stm32_startup(struct uart_port *port)
 		return ret;
 
 	val = USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
-	stm32_set_bits(port, USART_CR1, val);
+	stm32_set_bits(port, ofs->cr1, val);
 
 	return 0;
 }
 
 static void stm32_shutdown(struct uart_port *port)
 {
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 val;
 
 	val = USART_CR1_TXEIE | USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
-	stm32_set_bits(port, USART_CR1, val);
+	stm32_set_bits(port, ofs->cr1, val);
 
 	free_irq(port->irq, port);
 }
@@ -346,6 +492,8 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	unsigned int baud;
 	u32 usartdiv, mantissa, fraction, oversampling;
 	tcflag_t cflag = termios->c_cflag;
@@ -360,9 +508,10 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Stop serial port and reset value */
-	writel_relaxed(0, port->membase + USART_CR1);
+	writel_relaxed(0, port->membase + ofs->cr1);
 
-	cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_UE | USART_CR1_RXNEIE;
+	cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_RXNEIE;
+	cr1 |= BIT(cfg->uart_enable_bit);
 	cr2 = 0;
 	cr3 = 0;
 
@@ -371,8 +520,12 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (cflag & PARENB) {
 		cr1 |= USART_CR1_PCE;
-		if ((cflag & CSIZE) == CS8)
-			cr1 |= USART_CR1_M;
+		if ((cflag & CSIZE) == CS8) {
+			if (cfg->has_7bits_data)
+				cr1 |= USART_CR1_M0;
+			else
+				cr1 |= USART_CR1_M;
+		}
 	}
 
 	if (cflag & PARODD)
@@ -394,15 +547,15 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	if (usartdiv < 16) {
 		oversampling = 8;
-		stm32_set_bits(port, USART_CR1, USART_CR1_OVER8);
+		stm32_set_bits(port, ofs->cr1, USART_CR1_OVER8);
 	} else {
 		oversampling = 16;
-		stm32_clr_bits(port, USART_CR1, USART_CR1_OVER8);
+		stm32_clr_bits(port, ofs->cr1, USART_CR1_OVER8);
 	}
 
 	mantissa = (usartdiv / oversampling) << USART_BRR_DIV_M_SHIFT;
 	fraction = usartdiv % oversampling;
-	writel_relaxed(mantissa | fraction, port->membase + USART_BRR);
+	writel_relaxed(mantissa | fraction, port->membase + ofs->brr);
 
 	uart_update_timeout(port, cflag, baud);
 
@@ -430,9 +583,9 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= USART_SR_DUMMY_RX;
 
-	writel_relaxed(cr3, port->membase + USART_CR3);
-	writel_relaxed(cr2, port->membase + USART_CR2);
-	writel_relaxed(cr1, port->membase + USART_CR1);
+	writel_relaxed(cr3, port->membase + ofs->cr3);
+	writel_relaxed(cr2, port->membase + ofs->cr2);
+	writel_relaxed(cr1, port->membase + ofs->cr1);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -469,6 +622,8 @@ static void stm32_pm(struct uart_port *port, unsigned int state,
 {
 	struct stm32_port *stm32port = container_of(port,
 			struct stm32_port, port);
+	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32port->info->cfg;
 	unsigned long flags = 0;
 
 	switch (state) {
@@ -477,7 +632,7 @@ static void stm32_pm(struct uart_port *port, unsigned int state,
 		break;
 	case UART_PM_STATE_OFF:
 		spin_lock_irqsave(&port->lock, flags);
-		stm32_clr_bits(port, USART_CR1, USART_CR1_UE);
+		stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 		spin_unlock_irqrestore(&port->lock, flags);
 		clk_disable_unprepare(stm32port->clk);
 		break;
@@ -567,8 +722,10 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id stm32_match[] = {
-	{ .compatible = "st,stm32-usart", },
-	{ .compatible = "st,stm32-uart", },
+	{ .compatible = "st,stm32-usart", .data = &stm32f4_info},
+	{ .compatible = "st,stm32-uart", .data = &stm32f4_info},
+	{ .compatible = "st,stm32f7-usart", .data = &stm32f7_info},
+	{ .compatible = "st,stm32f7-uart", .data = &stm32f7_info},
 	{},
 };
 
@@ -577,13 +734,20 @@ MODULE_DEVICE_TABLE(of, stm32_match);
 
 static int stm32_serial_probe(struct platform_device *pdev)
 {
-	int ret;
+	const struct of_device_id *match;
 	struct stm32_port *stm32port;
+	int ret;
 
 	stm32port = stm32_of_get_stm32_port(pdev);
 	if (!stm32port)
 		return -ENODEV;
 
+	match = of_match_device(stm32_match, &pdev->dev);
+	if (match && match->data)
+		stm32port->info = (struct stm32_usart_info *)match->data;
+	else
+		return -EINVAL;
+
 	ret = stm32_init_port(stm32port, pdev);
 	if (ret)
 		return ret;
@@ -608,15 +772,20 @@ static int stm32_serial_remove(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_STM32_CONSOLE
 static void stm32_console_putchar(struct uart_port *port, int ch)
 {
-	while (!(readl_relaxed(port->membase + USART_SR) & USART_SR_TXE))
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	while (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
 		cpu_relax();
 
-	writel_relaxed(ch, port->membase + USART_DR);
+	writel_relaxed(ch, port->membase + ofs->tdr);
 }
 
 static void stm32_console_write(struct console *co, const char *s, unsigned cnt)
 {
 	struct uart_port *port = &stm32_ports[co->index].port;
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 	u32 old_cr1, new_cr1;
 	int locked = 1;
@@ -630,14 +799,14 @@ static void stm32_console_write(struct console *co, const char *s, unsigned cnt)
 		spin_lock(&port->lock);
 
 	/* Save and disable interrupts */
-	old_cr1 = readl_relaxed(port->membase + USART_CR1);
+	old_cr1 = readl_relaxed(port->membase + ofs->cr1);
 	new_cr1 = old_cr1 & ~USART_CR1_IE_MASK;
-	writel_relaxed(new_cr1, port->membase + USART_CR1);
+	writel_relaxed(new_cr1, port->membase + ofs->cr1);
 
 	uart_console_write(port, s, cnt, stm32_console_putchar);
 
 	/* Restore interrupt state */
-	writel_relaxed(old_cr1, port->membase + USART_CR1);
+	writel_relaxed(old_cr1, port->membase + ofs->cr1);
 
 	if (locked)
 		spin_unlock(&port->lock);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
