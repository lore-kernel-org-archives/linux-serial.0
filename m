From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 09/20] serial: stm32: fix end of transfer
Date: Mon, 26 Jun 2017 12:49:12 +0000
Message-ID: <1498481318-1894-10-git-send-email-bich.hemon@st.com>
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

tx_empty: poll TC (PIO mode) or DMAT (DMA mode) bit.
flush_buffer: terminate on going DMA tx transfer.
remove: terminate DMA rx and tx transfers.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ed2025b..266dc4f 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -408,8 +408,14 @@ static unsigned int stm32_tx_empty(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	int ret;
+
+	if (!stm32_port->tx_ch)
+		ret = readl_relaxed(port->membase + ofs->isr) & USART_SR_TC;
+	else
+		ret = readl_relaxed(port->membase + ofs->cr3) & USART_CR3_DMAT;
 
-	return readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE;
+	return ret;
 }
 
 static void stm32_set_mctrl(struct uart_port *port, unsigned int mctrl)
@@ -449,6 +455,26 @@ static void stm32_start_tx(struct uart_port *port)
 	stm32_transmit_chars(port);
 }
 
+/* Flush the transmit buffer. */
+static void stm32_flush_buffer(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	if (stm32_port->tx_ch) {
+		spin_lock(&port->lock);
+		dmaengine_terminate_all(stm32_port->tx_ch);
+		spin_unlock(&port->lock);
+		if (ofs->icr == UNDEF_REG)
+			stm32_clr_bits(port, ofs->isr, USART_SR_TC);
+		else
+			stm32_set_bits(port, ofs->icr, USART_CR_TC);
+
+		stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
+		stm32_port->tx_dma_busy = false;
+	}
+}
+
 /* Throttle the remote when input buffer is about to overflow. */
 static void stm32_throttle(struct uart_port *port)
 {
@@ -701,6 +727,7 @@ static void stm32_pm(struct uart_port *port, unsigned int state,
 	.break_ctl	= stm32_break_ctl,
 	.startup	= stm32_startup,
 	.shutdown	= stm32_shutdown,
+	.flush_buffer	= stm32_flush_buffer,
 	.set_termios	= stm32_set_termios,
 	.pm		= stm32_pm,
 	.type		= stm32_type,
@@ -950,8 +977,10 @@ static int stm32_serial_remove(struct platform_device *pdev)
 
 	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
-	if (stm32_port->rx_ch)
+	if (stm32_port->rx_ch) {
+		dmaengine_terminate_all(stm32_port->rx_ch);
 		dma_release_channel(stm32_port->rx_ch);
+	}
 
 	if (stm32_port->rx_dma_buf)
 		dma_free_coherent(&pdev->dev,
@@ -960,8 +989,10 @@ static int stm32_serial_remove(struct platform_device *pdev)
 
 	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 
-	if (stm32_port->tx_ch)
+	if (stm32_port->tx_ch) {
+		dmaengine_terminate_all(stm32_port->tx_ch);
 		dma_release_channel(stm32_port->tx_ch);
+	}
 
 	if (stm32_port->tx_dma_buf)
 		dma_free_coherent(&pdev->dev,
-- 
1.9.1
