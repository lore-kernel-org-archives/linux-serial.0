From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX 5/6] tty: xuartps: Remove '_OFFSET' suffix from #defines
Date: Mon, 11 Jan 2016 17:41:40 -0800
Message-ID: <1452562901-17848-6-git-send-email-soren.brinkmann@xilinx.com>
References: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Remove the _OFFSET suffix from all register defines which makes code a
little easier to read and avoids a few line breaks.

Suggested-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v4:
 - added this patch
---
 drivers/tty/serial/xilinx_uartps.c | 221 ++++++++++++++++++-------------------
 1 file changed, 106 insertions(+), 115 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0eecba88298f..3ff6e3c2347c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -50,24 +50,24 @@ module_param(rx_timeout, uint, S_IRUGO);
 MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 
 /* Register offsets for the UART. */
-#define CDNS_UART_CR_OFFSET		0x00  /* Control Register */
-#define CDNS_UART_MR_OFFSET		0x04  /* Mode Register */
-#define CDNS_UART_IER_OFFSET		0x08  /* Interrupt Enable */
-#define CDNS_UART_IDR_OFFSET		0x0C  /* Interrupt Disable */
-#define CDNS_UART_IMR_OFFSET		0x10  /* Interrupt Mask */
-#define CDNS_UART_ISR_OFFSET		0x14  /* Interrupt Status */
-#define CDNS_UART_BAUDGEN_OFFSET	0x18  /* Baud Rate Generator */
-#define CDNS_UART_RXTOUT_OFFSET		0x1C  /* RX Timeout */
-#define CDNS_UART_RXWM_OFFSET		0x20  /* RX FIFO Trigger Level */
-#define CDNS_UART_MODEMCR_OFFSET	0x24  /* Modem Control */
-#define CDNS_UART_MODEMSR_OFFSET	0x28  /* Modem Status */
-#define CDNS_UART_SR_OFFSET		0x2C  /* Channel Status */
-#define CDNS_UART_FIFO_OFFSET		0x30  /* FIFO */
-#define CDNS_UART_BAUDDIV_OFFSET	0x34  /* Baud Rate Divider */
-#define CDNS_UART_FLOWDEL_OFFSET	0x38  /* Flow Delay */
-#define CDNS_UART_IRRX_PWIDTH_OFFSET	0x3C  /* IR Min Received Pulse Width */
-#define CDNS_UART_IRTX_PWIDTH_OFFSET	0x40  /* IR Transmitted pulse Width */
-#define CDNS_UART_TXWM_OFFSET		0x44  /* TX FIFO Trigger Level */
+#define CDNS_UART_CR		0x00  /* Control Register */
+#define CDNS_UART_MR		0x04  /* Mode Register */
+#define CDNS_UART_IER		0x08  /* Interrupt Enable */
+#define CDNS_UART_IDR		0x0C  /* Interrupt Disable */
+#define CDNS_UART_IMR		0x10  /* Interrupt Mask */
+#define CDNS_UART_ISR		0x14  /* Interrupt Status */
+#define CDNS_UART_BAUDGEN	0x18  /* Baud Rate Generator */
+#define CDNS_UART_RXTOUT		0x1C  /* RX Timeout */
+#define CDNS_UART_RXWM		0x20  /* RX FIFO Trigger Level */
+#define CDNS_UART_MODEMCR	0x24  /* Modem Control */
+#define CDNS_UART_MODEMSR	0x28  /* Modem Status */
+#define CDNS_UART_SR		0x2C  /* Channel Status */
+#define CDNS_UART_FIFO		0x30  /* FIFO */
+#define CDNS_UART_BAUDDIV	0x34  /* Baud Rate Divider */
+#define CDNS_UART_FLOWDEL	0x38  /* Flow Delay */
+#define CDNS_UART_IRRX_PWIDTH	0x3C  /* IR Min Received Pulse Width */
+#define CDNS_UART_IRTX_PWIDTH	0x40  /* IR Transmitted pulse Width */
+#define CDNS_UART_TXWM		0x44  /* TX FIFO Trigger Level */
 
 /* Control Register Bit Definitions */
 #define CDNS_UART_CR_STOPBRK	0x00000100  /* Stop TX break */
@@ -184,15 +184,14 @@ static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
 	 * there's another non-zero byte at the end of the sequence.
 	 */
 	if (isrstatus & CDNS_UART_IXR_FRAMING) {
-		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
+		while (!(readl(port->membase + CDNS_UART_SR) &
 					CDNS_UART_SR_RXEMPTY)) {
-			if (!readl(port->membase + CDNS_UART_FIFO_OFFSET)) {
+			if (!readl(port->membase + CDNS_UART_FIFO)) {
 				port->read_status_mask |= CDNS_UART_IXR_BRK;
 				isrstatus &= ~CDNS_UART_IXR_FRAMING;
 			}
 		}
-		writel(CDNS_UART_IXR_FRAMING,
-				port->membase + CDNS_UART_ISR_OFFSET);
+		writel(CDNS_UART_IXR_FRAMING, port->membase + CDNS_UART_ISR);
 	}
 
 	/* drop byte with parity error if IGNPAR specified */
@@ -205,12 +204,11 @@ static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
 	if (!(isrstatus & (CDNS_UART_IXR_TOUT | CDNS_UART_IXR_RXTRIG)))
 		return;
 
-	while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
-				CDNS_UART_SR_RXEMPTY)) {
+	while (!(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_RXEMPTY)) {
 		u32 data;
 		char status = TTY_NORMAL;
 
-		data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
+		data = readl(port->membase + CDNS_UART_FIFO);
 
 		/* Non-NULL byte after BREAK is garbage (99%) */
 		if (data && (port->read_status_mask & CDNS_UART_IXR_BRK)) {
@@ -259,7 +257,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	/* Read the interrupt status register to determine which
 	 * interrupt(s) is/are active.
 	 */
-	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
+	isrstatus = readl(port->membase + CDNS_UART_ISR);
 
 	if (isrstatus & CDNS_UART_RX_IRQS)
 		cdns_uart_handle_rx(port, isrstatus);
@@ -268,7 +266,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) == CDNS_UART_IXR_TXEMPTY) {
 		if (uart_circ_empty(&port->state->xmit)) {
 			writel(CDNS_UART_IXR_TXEMPTY,
-					port->membase + CDNS_UART_IDR_OFFSET);
+					port->membase + CDNS_UART_IDR);
 		} else {
 			numbytes = port->fifosize;
 			/* Break if no more data available in the UART buffer */
@@ -281,7 +279,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 				 */
 				writel(port->state->xmit.buf[
 						port->state->xmit.tail],
-					port->membase + CDNS_UART_FIFO_OFFSET);
+					port->membase + CDNS_UART_FIFO);
 
 				port->icount.tx++;
 
@@ -299,7 +297,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		}
 	}
 
-	writel(isrstatus, port->membase + CDNS_UART_ISR_OFFSET);
+	writel(isrstatus, port->membase + CDNS_UART_ISR);
 
 	/* be sure to release the lock and tty before leaving */
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -389,14 +387,14 @@ static unsigned int cdns_uart_set_baud_rate(struct uart_port *port,
 			&div8);
 
 	/* Write new divisors to hardware */
-	mreg = readl(port->membase + CDNS_UART_MR_OFFSET);
+	mreg = readl(port->membase + CDNS_UART_MR);
 	if (div8)
 		mreg |= CDNS_UART_MR_CLKSEL;
 	else
 		mreg &= ~CDNS_UART_MR_CLKSEL;
-	writel(mreg, port->membase + CDNS_UART_MR_OFFSET);
-	writel(cd, port->membase + CDNS_UART_BAUDGEN_OFFSET);
-	writel(bdiv, port->membase + CDNS_UART_BAUDDIV_OFFSET);
+	writel(mreg, port->membase + CDNS_UART_MR);
+	writel(cd, port->membase + CDNS_UART_BAUDGEN);
+	writel(bdiv, port->membase + CDNS_UART_BAUDDIV);
 	cdns_uart->baud = baud;
 
 	return calc_baud;
@@ -443,9 +441,9 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 		spin_lock_irqsave(&cdns_uart->port->lock, flags);
 
 		/* Disable the TX and RX to set baud rate */
-		ctrl_reg = readl(port->membase + CDNS_UART_CR_OFFSET);
+		ctrl_reg = readl(port->membase + CDNS_UART_CR);
 		ctrl_reg |= CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS;
-		writel(ctrl_reg, port->membase + CDNS_UART_CR_OFFSET);
+		writel(ctrl_reg, port->membase + CDNS_UART_CR);
 
 		spin_unlock_irqrestore(&cdns_uart->port->lock, flags);
 
@@ -470,11 +468,11 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 			spin_lock_irqsave(&cdns_uart->port->lock, flags);
 
 		/* Set TX/RX Reset */
-		ctrl_reg = readl(port->membase + CDNS_UART_CR_OFFSET);
+		ctrl_reg = readl(port->membase + CDNS_UART_CR);
 		ctrl_reg |= CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST;
-		writel(ctrl_reg, port->membase + CDNS_UART_CR_OFFSET);
+		writel(ctrl_reg, port->membase + CDNS_UART_CR);
 
-		while (readl(port->membase + CDNS_UART_CR_OFFSET) &
+		while (readl(port->membase + CDNS_UART_CR) &
 				(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 			cpu_relax();
 
@@ -483,11 +481,11 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 		 * enable bit and RX enable bit to enable the transmitter and
 		 * receiver.
 		 */
-		writel(rx_timeout, port->membase + CDNS_UART_RXTOUT_OFFSET);
-		ctrl_reg = readl(port->membase + CDNS_UART_CR_OFFSET);
+		writel(rx_timeout, port->membase + CDNS_UART_RXTOUT);
+		ctrl_reg = readl(port->membase + CDNS_UART_CR);
 		ctrl_reg &= ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS);
 		ctrl_reg |= CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN;
-		writel(ctrl_reg, port->membase + CDNS_UART_CR_OFFSET);
+		writel(ctrl_reg, port->membase + CDNS_UART_CR);
 
 		spin_unlock_irqrestore(&cdns_uart->port->lock, flags);
 
@@ -513,15 +511,15 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	 * Set the TX enable bit and clear the TX disable bit to enable the
 	 * transmitter.
 	 */
-	status = readl(port->membase + CDNS_UART_CR_OFFSET);
+	status = readl(port->membase + CDNS_UART_CR);
 	status &= ~CDNS_UART_CR_TX_DIS;
 	status |= CDNS_UART_CR_TX_EN;
-	writel(status, port->membase + CDNS_UART_CR_OFFSET);
+	writel(status, port->membase + CDNS_UART_CR);
 
 	if (uart_circ_empty(&port->state->xmit))
 		return;
 
-	while (numbytes-- && ((readl(port->membase + CDNS_UART_SR_OFFSET) &
+	while (numbytes-- && ((readl(port->membase + CDNS_UART_SR) &
 				CDNS_UART_SR_TXFULL)) != CDNS_UART_SR_TXFULL) {
 		/* Break if no more data available in the UART buffer */
 		if (uart_circ_empty(&port->state->xmit))
@@ -531,7 +529,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
 		 * write it to the cdns_uart's TX_FIFO register.
 		 */
 		writel(port->state->xmit.buf[port->state->xmit.tail],
-				port->membase + CDNS_UART_FIFO_OFFSET);
+				port->membase + CDNS_UART_FIFO);
 		port->icount.tx++;
 
 		/* Adjust the tail of the UART buffer and wrap
@@ -540,9 +538,9 @@ static void cdns_uart_start_tx(struct uart_port *port)
 		port->state->xmit.tail = (port->state->xmit.tail + 1) &
 					(UART_XMIT_SIZE - 1);
 	}
-	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR_OFFSET);
+	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 	/* Enable the TX Empty interrupt */
-	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER_OFFSET);
+	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
 
 	if (uart_circ_chars_pending(&port->state->xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
@@ -556,10 +554,10 @@ static void cdns_uart_stop_tx(struct uart_port *port)
 {
 	unsigned int regval;
 
-	regval = readl(port->membase + CDNS_UART_CR_OFFSET);
+	regval = readl(port->membase + CDNS_UART_CR);
 	regval |= CDNS_UART_CR_TX_DIS;
 	/* Disable the transmitter */
-	writel(regval, port->membase + CDNS_UART_CR_OFFSET);
+	writel(regval, port->membase + CDNS_UART_CR);
 }
 
 /**
@@ -571,12 +569,12 @@ static void cdns_uart_stop_rx(struct uart_port *port)
 	unsigned int regval;
 
 	/* Disable RX IRQs */
-	writel(CDNS_UART_RX_IRQS, port->membase + CDNS_UART_IDR_OFFSET);
+	writel(CDNS_UART_RX_IRQS, port->membase + CDNS_UART_IDR);
 
 	/* Disable the receiver */
-	regval = readl(port->membase + CDNS_UART_CR_OFFSET);
+	regval = readl(port->membase + CDNS_UART_CR);
 	regval |= CDNS_UART_CR_RX_DIS;
-	writel(regval, port->membase + CDNS_UART_CR_OFFSET);
+	writel(regval, port->membase + CDNS_UART_CR);
 }
 
 /**
@@ -589,7 +587,7 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
 {
 	unsigned int status;
 
-	status = readl(port->membase + CDNS_UART_SR_OFFSET) &
+	status = readl(port->membase + CDNS_UART_SR) &
 				CDNS_UART_SR_TXEMPTY;
 	return status ? TIOCSER_TEMT : 0;
 }
@@ -607,15 +605,15 @@ static void cdns_uart_break_ctl(struct uart_port *port, int ctl)
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	status = readl(port->membase + CDNS_UART_CR_OFFSET);
+	status = readl(port->membase + CDNS_UART_CR);
 
 	if (ctl == -1)
 		writel(CDNS_UART_CR_STARTBRK | status,
-				port->membase + CDNS_UART_CR_OFFSET);
+				port->membase + CDNS_UART_CR);
 	else {
 		if ((status & CDNS_UART_CR_STOPBRK) == 0)
 			writel(CDNS_UART_CR_STOPBRK | status,
-					port->membase + CDNS_UART_CR_OFFSET);
+					port->membase + CDNS_UART_CR);
 	}
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -638,18 +636,18 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Wait for the transmit FIFO to empty before making changes */
-	if (!(readl(port->membase + CDNS_UART_CR_OFFSET) &
+	if (!(readl(port->membase + CDNS_UART_CR) &
 				CDNS_UART_CR_TX_DIS)) {
-		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
+		while (!(readl(port->membase + CDNS_UART_SR) &
 				CDNS_UART_SR_TXEMPTY)) {
 			cpu_relax();
 		}
 	}
 
 	/* Disable the TX and RX to set baud rate */
-	ctrl_reg = readl(port->membase + CDNS_UART_CR_OFFSET);
+	ctrl_reg = readl(port->membase + CDNS_UART_CR);
 	ctrl_reg |= CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS;
-	writel(ctrl_reg, port->membase + CDNS_UART_CR_OFFSET);
+	writel(ctrl_reg, port->membase + CDNS_UART_CR);
 
 	/*
 	 * Min baud rate = 6bps and Max Baud Rate is 10Mbps for 100Mhz clk
@@ -668,20 +666,20 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* Set TX/RX Reset */
-	ctrl_reg = readl(port->membase + CDNS_UART_CR_OFFSET);
+	ctrl_reg = readl(port->membase + CDNS_UART_CR);
 	ctrl_reg |= CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST;
-	writel(ctrl_reg, port->membase + CDNS_UART_CR_OFFSET);
+	writel(ctrl_reg, port->membase + CDNS_UART_CR);
 
 	/*
 	 * Clear the RX disable and TX disable bits and then set the TX enable
 	 * bit and RX enable bit to enable the transmitter and receiver.
 	 */
-	ctrl_reg = readl(port->membase + CDNS_UART_CR_OFFSET);
+	ctrl_reg = readl(port->membase + CDNS_UART_CR);
 	ctrl_reg &= ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS);
 	ctrl_reg |= CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN;
-	writel(ctrl_reg, port->membase + CDNS_UART_CR_OFFSET);
+	writel(ctrl_reg, port->membase + CDNS_UART_CR);
 
-	writel(rx_timeout, port->membase + CDNS_UART_RXTOUT_OFFSET);
+	writel(rx_timeout, port->membase + CDNS_UART_RXTOUT);
 
 	port->read_status_mask = CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRIG |
 			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
@@ -701,7 +699,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
 			CDNS_UART_IXR_TOUT | CDNS_UART_IXR_PARITY |
 			CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN;
 
-	mode_reg = readl(port->membase + CDNS_UART_MR_OFFSET);
+	mode_reg = readl(port->membase + CDNS_UART_MR);
 
 	/* Handling Data Size */
 	switch (termios->c_cflag & CSIZE) {
@@ -742,7 +740,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
 		cval |= CDNS_UART_MR_PARITY_NONE;
 	}
 	cval |= mode_reg & 1;
-	writel(cval, port->membase + CDNS_UART_MR_OFFSET);
+	writel(cval, port->membase + CDNS_UART_MR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -763,45 +761,45 @@ static int cdns_uart_startup(struct uart_port *port)
 
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
-			port->membase + CDNS_UART_CR_OFFSET);
+			port->membase + CDNS_UART_CR);
 
 	/* Set the Control Register with TX/RX Enable, TX/RX Reset,
 	 * no break chars.
 	 */
 	writel(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST,
-			port->membase + CDNS_UART_CR_OFFSET);
+			port->membase + CDNS_UART_CR);
 
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
 	 */
-	status = readl(port->membase + CDNS_UART_CR_OFFSET);
+	status = readl(port->membase + CDNS_UART_CR);
 	status &= CDNS_UART_CR_RX_DIS;
 	status |= CDNS_UART_CR_RX_EN;
-	writel(status, port->membase + CDNS_UART_CR_OFFSET);
+	writel(status, port->membase + CDNS_UART_CR);
 
 	/* Set the Mode Register with normal mode,8 data bits,1 stop bit,
 	 * no parity.
 	 */
 	writel(CDNS_UART_MR_CHMODE_NORM | CDNS_UART_MR_STOPMODE_1_BIT
 		| CDNS_UART_MR_PARITY_NONE | CDNS_UART_MR_CHARLEN_8_BIT,
-		port->membase + CDNS_UART_MR_OFFSET);
+		port->membase + CDNS_UART_MR);
 
 	/*
 	 * Set the RX FIFO Trigger level to use most of the FIFO, but it
 	 * can be tuned with a module parameter
 	 */
-	writel(rx_trigger_level, port->membase + CDNS_UART_RXWM_OFFSET);
+	writel(rx_trigger_level, port->membase + CDNS_UART_RXWM);
 
 	/*
 	 * Receive Timeout register is enabled but it
 	 * can be tuned with a module parameter
 	 */
-	writel(rx_timeout, port->membase + CDNS_UART_RXTOUT_OFFSET);
+	writel(rx_timeout, port->membase + CDNS_UART_RXTOUT);
 
 	/* Clear out any pending interrupts before enabling them */
-	writel(readl(port->membase + CDNS_UART_ISR_OFFSET),
-			port->membase + CDNS_UART_ISR_OFFSET);
+	writel(readl(port->membase + CDNS_UART_ISR),
+			port->membase + CDNS_UART_ISR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -813,7 +811,7 @@ static int cdns_uart_startup(struct uart_port *port)
 	}
 
 	/* Set the Interrupt Registers with desired interrupts */
-	writel(CDNS_UART_RX_IRQS, port->membase + CDNS_UART_IER_OFFSET);
+	writel(CDNS_UART_RX_IRQS, port->membase + CDNS_UART_IER);
 
 	return 0;
 }
@@ -830,13 +828,13 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable interrupts */
-	status = readl(port->membase + CDNS_UART_IMR_OFFSET);
-	writel(status, port->membase + CDNS_UART_IDR_OFFSET);
-	writel(0xffffffff, port->membase + CDNS_UART_ISR_OFFSET);
+	status = readl(port->membase + CDNS_UART_IMR);
+	writel(status, port->membase + CDNS_UART_IDR);
+	writel(0xffffffff, port->membase + CDNS_UART_ISR);
 
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
-			port->membase + CDNS_UART_CR_OFFSET);
+			port->membase + CDNS_UART_CR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -941,7 +939,7 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	u32 val;
 
-	val = readl(port->membase + CDNS_UART_MODEMCR_OFFSET);
+	val = readl(port->membase + CDNS_UART_MODEMCR);
 
 	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR);
 
@@ -950,7 +948,7 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (mctrl & TIOCM_DTR)
 		val |= CDNS_UART_MODEMCR_DTR;
 
-	writel(val, port->membase + CDNS_UART_MODEMCR_OFFSET);
+	writel(val, port->membase + CDNS_UART_MODEMCR);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -962,11 +960,10 @@ static int cdns_uart_poll_get_char(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Check if FIFO is empty */
-	if (readl(port->membase + CDNS_UART_SR_OFFSET) & CDNS_UART_SR_RXEMPTY)
+	if (readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_RXEMPTY)
 		c = NO_POLL_CHAR;
 	else /* Read a character */
-		c = (unsigned char) readl(
-					port->membase + CDNS_UART_FIFO_OFFSET);
+		c = (unsigned char) readl(port->membase + CDNS_UART_FIFO);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -980,16 +977,14 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Wait until FIFO is empty */
-	while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
-				CDNS_UART_SR_TXEMPTY))
+	while (!(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXEMPTY))
 		cpu_relax();
 
 	/* Write a character */
-	writel(c, port->membase + CDNS_UART_FIFO_OFFSET);
+	writel(c, port->membase + CDNS_UART_FIFO);
 
 	/* Wait until FIFO is empty */
-	while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
-				CDNS_UART_SR_TXEMPTY))
+	while (!(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXEMPTY))
 		cpu_relax();
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -1066,8 +1061,7 @@ static struct uart_port *cdns_uart_get_port(int id)
  */
 static void cdns_uart_console_wait_tx(struct uart_port *port)
 {
-	while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
-				CDNS_UART_SR_TXEMPTY))
+	while (!(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXEMPTY))
 		barrier();
 }
 
@@ -1079,7 +1073,7 @@ static void cdns_uart_console_wait_tx(struct uart_port *port)
 static void cdns_uart_console_putchar(struct uart_port *port, int ch)
 {
 	cdns_uart_console_wait_tx(port);
-	writel(ch, port->membase + CDNS_UART_FIFO_OFFSET);
+	writel(ch, port->membase + CDNS_UART_FIFO);
 }
 
 static void __init cdns_early_write(struct console *con, const char *s,
@@ -1124,25 +1118,25 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* save and disable interrupt */
-	imr = readl(port->membase + CDNS_UART_IMR_OFFSET);
-	writel(imr, port->membase + CDNS_UART_IDR_OFFSET);
+	imr = readl(port->membase + CDNS_UART_IMR);
+	writel(imr, port->membase + CDNS_UART_IDR);
 
 	/*
 	 * Make sure that the tx part is enabled. Set the TX enable bit and
 	 * clear the TX disable bit to enable the transmitter.
 	 */
-	ctrl = readl(port->membase + CDNS_UART_CR_OFFSET);
+	ctrl = readl(port->membase + CDNS_UART_CR);
 	ctrl &= ~CDNS_UART_CR_TX_DIS;
 	ctrl |= CDNS_UART_CR_TX_EN;
-	writel(ctrl, port->membase + CDNS_UART_CR_OFFSET);
+	writel(ctrl, port->membase + CDNS_UART_CR);
 
 	uart_console_write(port, s, count, cdns_uart_console_putchar);
 	cdns_uart_console_wait_tx(port);
 
-	writel(ctrl, port->membase + CDNS_UART_CR_OFFSET);
+	writel(ctrl, port->membase + CDNS_UART_CR);
 
 	/* restore interrupt state */
-	writel(imr, port->membase + CDNS_UART_IER_OFFSET);
+	writel(imr, port->membase + CDNS_UART_IER);
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -1254,14 +1248,13 @@ static int cdns_uart_suspend(struct device *device)
 
 		spin_lock_irqsave(&port->lock, flags);
 		/* Empty the receive FIFO 1st before making changes */
-		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
+		while (!(readl(port->membase + CDNS_UART_SR) &
 					CDNS_UART_SR_RXEMPTY))
-			readl(port->membase + CDNS_UART_FIFO_OFFSET);
+			readl(port->membase + CDNS_UART_FIFO);
 		/* set RX trigger level to 1 */
-		writel(1, port->membase + CDNS_UART_RXWM_OFFSET);
+		writel(1, port->membase + CDNS_UART_RXWM);
 		/* disable RX timeout interrups */
-		writel(CDNS_UART_IXR_TOUT,
-				port->membase + CDNS_UART_IDR_OFFSET);
+		writel(CDNS_UART_IXR_TOUT, port->membase + CDNS_UART_IDR);
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
@@ -1300,30 +1293,28 @@ static int cdns_uart_resume(struct device *device)
 		spin_lock_irqsave(&port->lock, flags);
 
 		/* Set TX/RX Reset */
-		ctrl_reg = readl(port->membase + CDNS_UART_CR_OFFSET);
+		ctrl_reg = readl(port->membase + CDNS_UART_CR);
 		ctrl_reg |= CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST;
-		writel(ctrl_reg, port->membase + CDNS_UART_CR_OFFSET);
-		while (readl(port->membase + CDNS_UART_CR_OFFSET) &
+		writel(ctrl_reg, port->membase + CDNS_UART_CR);
+		while (readl(port->membase + CDNS_UART_CR) &
 				(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 			cpu_relax();
 
 		/* restore rx timeout value */
-		writel(rx_timeout, port->membase + CDNS_UART_RXTOUT_OFFSET);
+		writel(rx_timeout, port->membase + CDNS_UART_RXTOUT);
 		/* Enable Tx/Rx */
-		ctrl_reg = readl(port->membase + CDNS_UART_CR_OFFSET);
+		ctrl_reg = readl(port->membase + CDNS_UART_CR);
 		ctrl_reg &= ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS);
 		ctrl_reg |= CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN;
-		writel(ctrl_reg, port->membase + CDNS_UART_CR_OFFSET);
+		writel(ctrl_reg, port->membase + CDNS_UART_CR);
 
 		spin_unlock_irqrestore(&port->lock, flags);
 	} else {
 		spin_lock_irqsave(&port->lock, flags);
 		/* restore original rx trigger level */
-		writel(rx_trigger_level,
-				port->membase + CDNS_UART_RXWM_OFFSET);
+		writel(rx_trigger_level, port->membase + CDNS_UART_RXWM);
 		/* enable RX timeout interrupt */
-		writel(CDNS_UART_IXR_TOUT,
-				port->membase + CDNS_UART_IER_OFFSET);
+		writel(CDNS_UART_IXR_TOUT, port->membase + CDNS_UART_IER);
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
-- 
2.7.0.3.g497ea1e
