From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 3/5] serial: stm32: add support of TX FIFO threshold
Date: Tue, 18 Jun 2019 12:02:24 +0200
Message-ID: <1560852146-3393-4-git-send-email-erwan.leray@st.com>
References: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@st.com>
Cc: linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, linux-serial@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Adds the support of TX FIFO threshold in order to improve the TX FIFO
management:
- TX FIFO threshold irq enabling (instead of relying on tx empty / fifo
  not full irq that generates one irq/char)
- TXCFG is set to half fifo size (e.g. 16/2 = 8 data for a 16 data depth
  FIFO)
- irq rate may be reduced by up to 1/TXCFG,  e.g. 1 over 8 with current
  TXCFG setting.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 8316e19..397d86d 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -298,6 +298,32 @@ static void stm32_tx_dma_complete(void *arg)
 	stm32_transmit_chars(port);
 }
 
+static void stm32_tx_interrupt_enable(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	/*
+	 * Enables TX FIFO threashold irq when FIFO is enabled,
+	 * or TX empty irq when FIFO is disabled
+	 */
+	if (stm32_port->fifoen)
+		stm32_set_bits(port, ofs->cr3, USART_CR3_TXFTIE);
+	else
+		stm32_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
+}
+
+static void stm32_tx_interrupt_disable(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	if (stm32_port->fifoen)
+		stm32_clr_bits(port, ofs->cr3, USART_CR3_TXFTIE);
+	else
+		stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
+}
+
 static void stm32_transmit_chars_pio(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -320,9 +346,9 @@ static void stm32_transmit_chars_pio(struct uart_port *port)
 
 	/* rely on TXE irq (mask or unmask) for sending remaining data */
 	if (uart_circ_empty(xmit))
-		stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
+		stm32_tx_interrupt_disable(port);
 	else
-		stm32_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
+		stm32_tx_interrupt_enable(port);
 }
 
 static void stm32_transmit_chars_dma(struct uart_port *port)
@@ -404,7 +430,7 @@ static void stm32_transmit_chars(struct uart_port *port)
 	}
 
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
+		stm32_tx_interrupt_disable(port);
 		return;
 	}
 
@@ -422,7 +448,7 @@ static void stm32_transmit_chars(struct uart_port *port)
 		uart_write_wakeup(port);
 
 	if (uart_circ_empty(xmit))
-		stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
+		stm32_tx_interrupt_disable(port);
 }
 
 static irqreturn_t stm32_interrupt(int irq, void *ptr)
@@ -501,10 +527,7 @@ static unsigned int stm32_get_mctrl(struct uart_port *port)
 /* Transmit stop */
 static void stm32_stop_tx(struct uart_port *port)
 {
-	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-
-	stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
+	stm32_tx_interrupt_disable(port);
 }
 
 /* There are probably characters waiting to be transmitted. */
@@ -575,6 +598,13 @@ static int stm32_startup(struct uart_port *port)
 		val |= USART_CR1_FIFOEN;
 	stm32_set_bits(port, ofs->cr1, val);
 
+	if (stm32_port->fifoen) {
+		val = readl_relaxed(port->membase + ofs->cr3);
+		val &= ~USART_CR3_TXFTCFG_MASK;
+		val |= USART_CR3_TXFTCFG_HALF << USART_CR3_TXFTCFG_SHIFT;
+		writel_relaxed(val, port->membase + ofs->cr3);
+	}
+
 	return 0;
 }
 
@@ -662,7 +692,9 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
-	cr3 = 0;
+	cr3 = readl_relaxed(port->membase + ofs->cr3);
+	cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTCFG | USART_CR3_RXFTIE
+		| USART_CR3_TXFTCFG_MASK;
 
 	if (cflag & CSTOPB)
 		cr2 |= USART_CR2_STOP_2B;
@@ -869,6 +901,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
+	port->fifosize	= stm32port->info->cfg.fifosize;
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index fcd01fe..a598446 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -27,6 +27,7 @@ struct stm32_usart_config {
 	bool has_7bits_data;
 	bool has_wakeup;
 	bool has_fifo;
+	int fifosize;
 };
 
 struct stm32_usart_info {
@@ -54,6 +55,7 @@ struct stm32_usart_info stm32f4_info = {
 	.cfg = {
 		.uart_enable_bit = 13,
 		.has_7bits_data = false,
+		.fifosize = 1,
 	}
 };
 
@@ -74,6 +76,7 @@ struct stm32_usart_info stm32f7_info = {
 	.cfg = {
 		.uart_enable_bit = 0,
 		.has_7bits_data = true,
+		.fifosize = 1,
 	}
 };
 
@@ -96,6 +99,7 @@ struct stm32_usart_info stm32h7_info = {
 		.has_7bits_data = true,
 		.has_wakeup = true,
 		.has_fifo = true,
+		.fifosize = 16,
 	}
 };
 
@@ -204,6 +208,15 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_CR3_WUS_MASK	GENMASK(21, 20)	/* H7 */
 #define USART_CR3_WUS_START_BIT	BIT(21)		/* H7 */
 #define USART_CR3_WUFIE		BIT(22)		/* H7 */
+#define USART_CR3_TXFTIE	BIT(23)		/* H7 */
+#define USART_CR3_TCBGTIE	BIT(24)		/* H7 */
+#define USART_CR3_RXFTCFG	GENMASK(27, 25)	/* H7 */
+#define USART_CR3_RXFTIE	BIT(28)		/* H7 */
+#define USART_CR3_TXFTCFG_MASK	GENMASK(31, 29)	/* H7 */
+#define USART_CR3_TXFTCFG_SHIFT	29		/* H7 */
+
+/* TX FIFO threashold set to half of its depth */
+#define USART_CR3_TXFTCFG_HALF	0x2
 
 /* USART_GTPR */
 #define USART_GTPR_PSC_MASK	GENMASK(7, 0)
-- 
1.9.1
