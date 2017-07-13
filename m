From: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 9/9] serial: stm32: add fifo support
Date: Thu, 13 Jul 2017 15:08:30 +0000
Message-ID: <1499958494-19354-10-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>

This patch adds fifo mode support for rx and tx.

A fifo configuration is set in each port structure.
Add has_fifo flag to usart configuration to use fifo only when possible.

Signed-off-by: Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>
---
 drivers/tty/serial/stm32-usart.c | 7 +++++++
 drivers/tty/serial/stm32-usart.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 684cbe3..b16e7e7 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -468,6 +468,8 @@ static int stm32_startup(struct uart_port *port)
 	}
 
 	val = USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
+	if (stm32_port->fifoen)
+		val |= USART_CR1_FIFOEN;
 	stm32_set_bits(port, ofs->cr1, val);
 
 	return 0;
@@ -482,6 +484,8 @@ static void stm32_shutdown(struct uart_port *port)
 
 	val = USART_CR1_TXEIE | USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
 	val |= BIT(cfg->uart_enable_bit);
+	if (stm32_port->fifoen)
+		val |= USART_CR1_FIFOEN;
 	stm32_clr_bits(port, ofs->cr1, val);
 
 	dev_pm_clear_wake_irq(port->dev);
@@ -512,6 +516,8 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_RXNEIE;
 	cr1 |= BIT(cfg->uart_enable_bit);
+	if (stm32_port->fifoen)
+		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
 	cr3 = 0;
 
@@ -676,6 +682,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->dev	= &pdev->dev;
 	port->irq	= platform_get_irq(pdev, 0);
 	stm32port->wakeirq = platform_get_irq(pdev, 1);
+	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 5984a66..ffc0c52 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -26,6 +26,7 @@ struct stm32_usart_config {
 	u8 uart_enable_bit; /* USART_CR1_UE */
 	bool has_7bits_data;
 	bool has_wakeup;
+	bool has_fifo;
 };
 
 struct stm32_usart_info {
@@ -94,6 +95,7 @@ struct stm32_usart_info stm32h7_info = {
 		.uart_enable_bit = 0,
 		.has_7bits_data = true,
 		.has_wakeup = true,
+		.has_fifo = true,
 	}
 };
 
@@ -159,6 +161,7 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_CR1_EOBIE		BIT(27)		/* F7 */
 #define USART_CR1_M1		BIT(28)		/* F7 */
 #define USART_CR1_IE_MASK	(GENMASK(8, 4) | BIT(14) | BIT(26) | BIT(27))
+#define USART_CR1_FIFOEN	BIT(29)		/* H7 */
 
 /* USART_CR2 */
 #define USART_CR2_ADD_MASK	GENMASK(3, 0)	/* F4 */
@@ -253,6 +256,7 @@ struct stm32_port {
 	int last_res;
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
+	bool fifoen;
 	int wakeirq;
 };
 
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
