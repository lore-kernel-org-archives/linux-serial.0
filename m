From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 04/20] serial: stm32: make fifoen as property for each port
Date: Mon, 26 Jun 2017 12:49:10 +0000
Message-ID: <1498481318-1894-5-git-send-email-bich.hemon@st.com>
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
 drivers/tty/serial/stm32-usart.c | 10 +++++++---
 drivers/tty/serial/stm32-usart.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index c6ae4fd..34e31d1 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -453,7 +453,8 @@ static int stm32_startup(struct uart_port *port)
 		return ret;
 
 	val = USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
-	val |= USART_CR1_FIFOEN;
+	if (stm32_port->fifoen)
+		val |= USART_CR1_FIFOEN;
 	stm32_set_bits(port, ofs->cr1, val);
 
 	return 0;
@@ -468,7 +469,8 @@ static void stm32_shutdown(struct uart_port *port)
 
 	val = USART_CR1_TXEIE | USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
 	val |= BIT(cfg->uart_enable_bit);
-	val |= USART_CR1_FIFOEN;
+	if (stm32_port->fifoen)
+		val |= USART_CR1_FIFOEN;
 	stm32_clr_bits(port, ofs->cr1, val);
 
 	free_irq(port->irq, port);
@@ -498,7 +500,8 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_RXNEIE;
 	cr1 |= BIT(cfg->uart_enable_bit);
-	cr1 |= USART_CR1_FIFOEN;
+	if (stm32_port->fifoen)
+		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
 	cr3 = 0;
 
@@ -707,6 +710,7 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 	stm32_ports[id].hw_flow_control = of_property_read_bool(np,
 							"st,hw-flow-ctrl");
 	stm32_ports[id].port.line = id;
+	stm32_ports[id].fifoen = true;
 	return &stm32_ports[id];
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 33f1320..9429baf 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -224,6 +224,7 @@ struct stm32_port {
 	unsigned char *tx_buf;   /* dma tx buffer cpu address */
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
+	bool fifoen;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
1.9.1
