From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 19/20] serial: stm32: add dma rx callback
Date: Mon, 26 Jun 2017 12:49:17 +0000
Message-ID: <1498481318-1894-20-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon@st.com>

Initial usart driver behavior consists in looking for
chars received in dma rx buffer as soon as it gets the
interrupt telling that we received some data (RXNE or
RTO).

When stm32 dma is used combined with mdma, meaning that
the third dmamux property in the device tree is 0x1,
the received data are accumulated until the rx dma
transfer period (RX_BUF_L) is reached.

In that case, the usard driver will always get a maximum
residue for the rx dma transfer and its callback will
be called after each period completion to tell that
it can get a complete buffer: this is the purpose of
this patch.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.c | 39 +++++++++++++++++++++++++++++++++------
 drivers/tty/serial/stm32-usart.h |  7 +++++++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index d241056..06a92c8 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -124,14 +124,18 @@ static int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
 	*sr = readl_relaxed(port->membase + ofs->isr);
 
 	if (threaded && stm32_port->rx_ch) {
+		if (stm32_port->rx_dma_cb == CALLBACK_CALLED)
+			return 1;
 		status = dmaengine_tx_status(stm32_port->rx_ch,
 					     stm32_port->rx_ch->cookie,
 					     &state);
 		if ((status == DMA_IN_PROGRESS) &&
-		    (*last_res != state.residue))
+		    (*last_res != state.residue)) {
+			stm32_port->rx_dma_cb = CALLBACK_IGNORED;
 			return 1;
-		else
+		} else {
 			return 0;
+		}
 	} else if (*sr & USART_SR_RXNE) {
 		return 1;
 	}
@@ -147,8 +151,11 @@ static int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
 
 	if (stm32_port->rx_ch) {
 		c = stm32_port->rx_buf[RX_BUF_L - (*last_res)--];
-		if ((*last_res) == 0)
+		if ((*last_res) == 0) {
 			*last_res = RX_BUF_L;
+			if (stm32_port->rx_dma_cb == CALLBACK_CALLED)
+				stm32_port->rx_dma_cb = CALLBACK_NOT_CALLED;
+		}
 		return c;
 	} else {
 		return readl_relaxed(port->membase + ofs->rdr);
@@ -238,6 +245,27 @@ static void stm32_tx_dma_complete(void *arg)
 	stm32_transmit_chars(port);
 }
 
+static void stm32_rx_dma_complete(void *arg)
+{
+	struct uart_port *port = arg;
+	struct stm32_port *stm32port = to_stm32_port(port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/*
+	 * If the dma controller is sending the data on
+	 * the fly then we have CALLBACK_IGNORED
+	 */
+
+	if (stm32port->rx_dma_cb == CALLBACK_NOT_CALLED) {
+		stm32port->rx_dma_cb = CALLBACK_CALLED;
+		stm32_receive_chars(port, true);
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static void stm32_transmit_chars_pio(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -897,9 +925,8 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 		goto config_err;
 	}
 
-	/* No callback as dma buffer is drained on usart interrupt */
-	desc->callback = NULL;
-	desc->callback_param = NULL;
+	desc->callback = stm32_rx_dma_complete;
+	desc->callback_param = port;
 
 	/* Push current DMA transaction in the pending queue */
 	cookie = dmaengine_submit(desc);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 5137e68..f8cad09 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -242,6 +242,12 @@ struct stm32_usart_info stm32h7_info = {
 #define RX_BUF_P RX_BUF_L	 /* dma rx buffer period     */
 #define TX_BUF_L RX_BUF_L	 /* dma tx buffer length     */
 
+enum dma_cb {
+	CALLBACK_NOT_CALLED,
+	CALLBACK_CALLED,
+	CALLBACK_IGNORED,
+};
+
 struct stm32_port {
 	struct uart_port port;
 	struct clk *clk;
@@ -257,6 +263,7 @@ struct stm32_port {
 	unsigned char *tx_buf;   /* dma tx buffer cpu address */
 	u32 rx_irq;		 /* USART_CR1_RXNEIE or RTOIE */
 	int last_res;
+	enum dma_cb rx_dma_cb;	 /* dma rx callback status    */
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
 	bool fifoen;
-- 
1.9.1
