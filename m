From: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 08/11] serial: stm32: adding dma support
Date: Thu, 15 Sep 2016 18:42:40 +0200
Message-ID: <1473957763-30629-9-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473957763-30629-1-git-send-email-alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gerald.baeza-qxv4g6HH51o@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This patch adds dma mode support for rx and tx
with pio mode as fallback in case of dma error.

Signed-off-by: Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 520e7de..24c4d82 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -11,26 +11,31 @@
 #define SUPPORT_SYSRQ
 #endif
 
-#include <linux/module.h>
-#include <linux/serial.h>
+#include <linux/clk.h>
 #include <linux/console.h>
-#include <linux/sysrq.h>
-#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/dma-direction.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/delay.h>
-#include <linux/spinlock.h>
-#include <linux/pm_runtime.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/serial_core.h>
-#include <linux/clk.h>
+#include <linux/serial.h>
+#include <linux/spinlock.h>
+#include <linux/sysrq.h>
+#include <linux/tty_flip.h>
+#include <linux/tty.h>
 
 #include "stm32-usart.h"
 
 static void stm32_stop_tx(struct uart_port *port);
+static void stm32_transmit_chars(struct uart_port *port);
 
 static inline struct stm32_port *to_stm32_port(struct uart_port *port)
 {
@@ -55,7 +60,48 @@ static void stm32_clr_bits(struct uart_port *port, u32 reg, u32 bits)
 	writel_relaxed(val, port->membase + reg);
 }
 
-static void stm32_receive_chars(struct uart_port *port)
+int stm32_pending_rx(struct uart_port *port, u32 *sr, int *last_res,
+		     bool threaded)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	enum dma_status status;
+	struct dma_tx_state state;
+
+	*sr = readl_relaxed(port->membase + ofs->isr);
+
+	if (threaded && stm32_port->rx_ch) {
+		status = dmaengine_tx_status(stm32_port->rx_ch,
+					     stm32_port->rx_ch->cookie,
+					     &state);
+		if ((status == DMA_IN_PROGRESS) &&
+		    (*last_res != state.residue))
+			return 1;
+		else
+			return 0;
+	} else if (*sr & USART_SR_RXNE) {
+		return 1;
+	}
+	return 0;
+}
+
+unsigned long stm32_get_char(struct uart_port *port, u32 *sr, int *last_res)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	unsigned long c;
+
+	if (stm32_port->rx_ch) {
+		c = stm32_port->rx_buf[RX_BUF_L - (*last_res)--];
+		if ((*last_res) == 0)
+			*last_res = RX_BUF_L;
+		return c;
+	} else {
+		return readl_relaxed(port->membase + ofs->rdr);
+	}
+}
+
+static void stm32_receive_chars(struct uart_port *port, bool threaded)
 {
 	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -63,13 +109,14 @@ static void stm32_receive_chars(struct uart_port *port)
 	unsigned long c;
 	u32 sr;
 	char flag;
+	static int last_res = RX_BUF_L;
 
 	if (port->irq_wake)
 		pm_wakeup_event(tport->tty->dev, 0);
 
-	while ((sr = readl_relaxed(port->membase + ofs->isr)) & USART_SR_RXNE) {
+	while (stm32_pending_rx(port, &sr, &last_res, threaded)) {
 		sr |= USART_SR_DUMMY_RX;
-		c = readl_relaxed(port->membase + ofs->rdr);
+		c = stm32_get_char(port, &sr, &last_res);
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
@@ -110,6 +157,124 @@ static void stm32_receive_chars(struct uart_port *port)
 	spin_lock(&port->lock);
 }
 
+static void stm32_tx_dma_complete(void *arg)
+{
+	struct uart_port *port = arg;
+	struct stm32_port *stm32port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	unsigned int isr;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
+						isr,
+						(isr & USART_SR_TC),
+						10, 100000);
+
+	if (ret)
+		dev_err(port->dev, "terminal count not set\n");
+
+	if (ofs->icr == UNDEF_REG)
+		stm32_clr_bits(port, ofs->isr, USART_SR_TC);
+	else
+		stm32_set_bits(port, ofs->icr, USART_CR_TC);
+
+	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
+	stm32port->tx_dma_busy = false;
+
+	/* Let's see if we have pending data to send */
+	stm32_transmit_chars(port);
+}
+
+static void stm32_transmit_chars_pio(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned int isr;
+	int ret;
+
+	if (stm32_port->tx_dma_busy) {
+		stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
+		stm32_port->tx_dma_busy = false;
+	}
+
+	ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
+						isr,
+						(isr & USART_SR_TXE),
+						10, 100);
+
+	if (ret)
+		dev_err(port->dev, "tx empty not set\n");
+
+	stm32_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
+
+	writel_relaxed(xmit->buf[xmit->tail], port->membase + ofs->tdr);
+	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+	port->icount.tx++;
+}
+
+static void stm32_transmit_chars_dma(struct uart_port *port)
+{
+	struct stm32_port *stm32port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	struct circ_buf *xmit = &port->state->xmit;
+	struct dma_async_tx_descriptor *desc = NULL;
+	dma_cookie_t cookie;
+	unsigned int count, i;
+
+	if (stm32port->tx_dma_busy)
+		return;
+
+	stm32port->tx_dma_busy = true;
+
+	count = uart_circ_chars_pending(xmit);
+
+	if (count > TX_BUF_L)
+		count = TX_BUF_L;
+
+	if (xmit->tail < xmit->head) {
+		memcpy(&stm32port->tx_buf[0], &xmit->buf[xmit->tail], count);
+	} else {
+		size_t one = UART_XMIT_SIZE - xmit->tail;
+		size_t two;
+
+		if (one > count)
+			one = count;
+		two = count - one;
+
+		memcpy(&stm32port->tx_buf[0], &xmit->buf[xmit->tail], one);
+		if (two)
+			memcpy(&stm32port->tx_buf[one], &xmit->buf[0], two);
+	}
+
+	desc = dmaengine_prep_slave_single(stm32port->tx_ch,
+					   stm32port->tx_dma_buf,
+					   count,
+					   DMA_MEM_TO_DEV,
+					   DMA_PREP_INTERRUPT);
+
+	if (!desc) {
+		for (i = count; i > 0; i--)
+			stm32_transmit_chars_pio(port);
+		return;
+	}
+
+	desc->callback = stm32_tx_dma_complete;
+	desc->callback_param = port;
+
+	/* Push current DMA TX transaction in the pending queue */
+	cookie = dmaengine_submit(desc);
+
+	/* Issue pending DMA TX requests */
+	dma_async_issue_pending(stm32port->tx_ch);
+
+	stm32_clr_bits(port, ofs->isr, USART_SR_TC);
+	stm32_set_bits(port, ofs->cr3, USART_CR3_DMAT);
+
+	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
+	port->icount.tx += count;
+}
+
 static void stm32_transmit_chars(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -117,9 +282,13 @@ static void stm32_transmit_chars(struct uart_port *port)
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (port->x_char) {
+		if (stm32_port->tx_dma_busy)
+			stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 		writel_relaxed(port->x_char, port->membase + ofs->tdr);
 		port->x_char = 0;
 		port->icount.tx++;
+		if (stm32_port->tx_dma_busy)
+			stm32_set_bits(port, ofs->cr3, USART_CR3_DMAT);
 		return;
 	}
 
@@ -133,9 +302,10 @@ static void stm32_transmit_chars(struct uart_port *port)
 		return;
 	}
 
-	writel_relaxed(xmit->buf[xmit->tail], port->membase + ofs->tdr);
-	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-	port->icount.tx++;
+	if (stm32_port->tx_ch)
+		stm32_transmit_chars_dma(port);
+	else
+		stm32_transmit_chars_pio(port);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
@@ -151,16 +321,30 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 
-	spin_lock(&port->lock);
-
 	sr = readl_relaxed(port->membase + ofs->isr);
 
-	if (sr & USART_SR_RXNE)
-		stm32_receive_chars(port);
+	if ((sr & USART_SR_RXNE) && !(stm32_port->rx_ch))
+		stm32_receive_chars(port, false);
 
-	if (sr & USART_SR_TXE)
+	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch))
 		stm32_transmit_chars(port);
 
+	if (stm32_port->rx_ch)
+		return IRQ_WAKE_THREAD;
+	else
+		return IRQ_HANDLED;
+}
+
+static irqreturn_t stm32_threaded_interrupt(int irq, void *ptr)
+{
+	struct uart_port *port = ptr;
+	struct stm32_port *stm32_port = to_stm32_port(port);
+
+	spin_lock(&port->lock);
+
+	if (stm32_port->rx_ch)
+		stm32_receive_chars(port, true);
+
 	spin_unlock(&port->lock);
 
 	return IRQ_HANDLED;
@@ -203,14 +387,12 @@ static void stm32_stop_tx(struct uart_port *port)
 /* There are probably characters waiting to be transmitted. */
 static void stm32_start_tx(struct uart_port *port)
 {
-	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (uart_circ_empty(xmit))
 		return;
 
-	stm32_set_bits(port, ofs->cr1, USART_CR1_TXEIE | USART_CR1_TE);
+	stm32_transmit_chars(port);
 }
 
 /* Throttle the remote when input buffer is about to overflow. */
@@ -259,7 +441,9 @@ static int stm32_startup(struct uart_port *port)
 	u32 val;
 	int ret;
 
-	ret = request_irq(port->irq, stm32_interrupt, 0, name, port);
+	ret = request_threaded_irq(port->irq, stm32_interrupt,
+				   stm32_threaded_interrupt,
+				   IRQF_NO_SUSPEND, name, port);
 	if (ret)
 		return ret;
 
@@ -376,6 +560,9 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= USART_SR_DUMMY_RX;
 
+	if (stm32_port->rx_ch)
+		cr3 |= USART_CR3_DMAR;
+
 	writel_relaxed(cr3, port->membase + ofs->cr3);
 	writel_relaxed(cr2, port->membase + ofs->cr2);
 	writel_relaxed(cr1, port->membase + ofs->cr1);
@@ -523,6 +710,129 @@ static const struct of_device_id stm32_match[] = {
 MODULE_DEVICE_TABLE(of, stm32_match);
 #endif
 
+static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
+				 struct platform_device *pdev)
+{
+	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	struct uart_port *port = &stm32port->port;
+	struct device *dev = &pdev->dev;
+	struct dma_slave_config config;
+	struct dma_async_tx_descriptor *desc = NULL;
+	dma_cookie_t cookie;
+	int ret;
+
+	/* Request DMA RX channel */
+	stm32port->rx_ch = dma_request_slave_channel(dev, "rx");
+	if (!stm32port->rx_ch) {
+		dev_info(dev, "rx dma alloc failed\n");
+		return -ENODEV;
+	}
+	stm32port->rx_buf = dma_alloc_coherent(&pdev->dev, RX_BUF_L,
+						 &stm32port->rx_dma_buf,
+						 GFP_KERNEL);
+	if (!stm32port->rx_buf) {
+		ret = -ENOMEM;
+		goto alloc_err;
+	}
+
+	/* Configure DMA channel */
+	memset(&config, 0, sizeof(config));
+	config.src_addr = (dma_addr_t)port->membase + ofs->rdr;
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
+	ret = dmaengine_slave_config(stm32port->rx_ch, &config);
+	if (ret < 0) {
+		dev_err(dev, "rx dma channel config failed\n");
+		ret = -ENODEV;
+		goto config_err;
+	}
+
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(stm32port->rx_ch,
+					 stm32port->rx_dma_buf,
+					 RX_BUF_L, RX_BUF_P, DMA_DEV_TO_MEM,
+					 DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dev, "rx dma prep cyclic failed\n");
+		ret = -ENODEV;
+		goto config_err;
+	}
+
+	/* No callback as dma buffer is drained on usart interrupt */
+	desc->callback = NULL;
+	desc->callback_param = NULL;
+
+	/* Push current DMA transaction in the pending queue */
+	cookie = dmaengine_submit(desc);
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(stm32port->rx_ch);
+
+	return 0;
+
+config_err:
+	dma_free_coherent(&pdev->dev,
+			  RX_BUF_L, stm32port->rx_buf,
+			  stm32port->rx_dma_buf);
+
+alloc_err:
+	dma_release_channel(stm32port->rx_ch);
+	stm32port->rx_ch = NULL;
+
+	return ret;
+}
+
+static int stm32_of_dma_tx_probe(struct stm32_port *stm32port,
+				 struct platform_device *pdev)
+{
+	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	struct uart_port *port = &stm32port->port;
+	struct device *dev = &pdev->dev;
+	struct dma_slave_config config;
+	int ret;
+
+	stm32port->tx_dma_busy = false;
+
+	/* Request DMA TX channel */
+	stm32port->tx_ch = dma_request_slave_channel(dev, "tx");
+	if (!stm32port->tx_ch) {
+		dev_info(dev, "tx dma alloc failed\n");
+		return -ENODEV;
+	}
+	stm32port->tx_buf = dma_alloc_coherent(&pdev->dev, TX_BUF_L,
+						 &stm32port->tx_dma_buf,
+						 GFP_KERNEL);
+	if (!stm32port->tx_buf) {
+		ret = -ENOMEM;
+		goto alloc_err;
+	}
+
+	/* Configure DMA channel */
+	memset(&config, 0, sizeof(config));
+	config.dst_addr = (dma_addr_t)port->membase + ofs->tdr;
+	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
+	ret = dmaengine_slave_config(stm32port->tx_ch, &config);
+	if (ret < 0) {
+		dev_err(dev, "tx dma channel config failed\n");
+		ret = -ENODEV;
+		goto config_err;
+	}
+
+	return 0;
+
+config_err:
+	dma_free_coherent(&pdev->dev,
+			  TX_BUF_L, stm32port->tx_buf,
+			  stm32port->tx_dma_buf);
+
+alloc_err:
+	dma_release_channel(stm32port->tx_ch);
+	stm32port->tx_ch = NULL;
+
+	return ret;
+}
+
 static int stm32_serial_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -547,6 +857,14 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = stm32_of_dma_rx_probe(stm32port, pdev);
+	if (ret)
+		dev_info(&pdev->dev, "interrupt mode used for rx (no dma)\n");
+
+	ret = stm32_of_dma_tx_probe(stm32port, pdev);
+	if (ret)
+		dev_info(&pdev->dev, "interrupt mode used for tx (no dma)\n");
+
 	platform_set_drvdata(pdev, &stm32port->port);
 
 	return 0;
@@ -556,6 +874,27 @@ static int stm32_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+
+	if (stm32_port->rx_ch)
+		dma_release_channel(stm32_port->rx_ch);
+
+	if (stm32_port->rx_dma_buf)
+		dma_free_coherent(&pdev->dev,
+				  RX_BUF_L, stm32_port->rx_buf,
+				  stm32_port->rx_dma_buf);
+
+	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
+
+	if (stm32_port->tx_ch)
+		dma_release_channel(stm32_port->tx_ch);
+
+	if (stm32_port->tx_dma_buf)
+		dma_free_coherent(&pdev->dev,
+				  TX_BUF_L, stm32_port->tx_buf,
+				  stm32_port->tx_dma_buf);
 
 	clk_disable_unprepare(stm32_port->clk);
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 75f8388..41d9749 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -99,6 +99,9 @@ struct stm32_usart_info stm32f7_info = {
 /* Dummy bits */
 #define USART_SR_DUMMY_RX	BIT(16)
 
+/* USART_ICR (F7) */
+#define USART_CR_TC		BIT(6)
+
 /* USART_DR */
 #define USART_DR_MASK		GENMASK(8, 0)
 
@@ -204,10 +207,21 @@ struct stm32_usart_info stm32f7_info = {
 #define STM32_SERIAL_NAME "ttyS"
 #define STM32_MAX_PORTS 6
 
+#define RX_BUF_L 200		 /* dma rx buffer length     */
+#define RX_BUF_P RX_BUF_L	 /* dma rx buffer period     */
+#define TX_BUF_L 200		 /* dma tx buffer length     */
+
 struct stm32_port {
 	struct uart_port port;
 	struct clk *clk;
 	struct stm32_usart_info *info;
+	struct dma_chan *rx_ch;  /* dma rx channel            */
+	dma_addr_t rx_dma_buf;   /* dma rx buffer bus address */
+	unsigned char *rx_buf;   /* dma rx buffer cpu address */
+	struct dma_chan *tx_ch;  /* dma tx channel            */
+	dma_addr_t tx_dma_buf;   /* dma tx buffer bus address */
+	unsigned char *tx_buf;   /* dma tx buffer cpu address */
+	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
 };
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
