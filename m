Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7992327603B;
	Wed, 11 Jun 2025 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636261; cv=none; b=qOCCzlC20AhhCcB6QkczZrC6rM9YPyfVPnHiNHJkem7p1YFyJmwDE4RXiDYNivRedew/qfiiTpDuD/1GOewj5M4vGUZgtZoZsCi/5Wxjshjn6hvtLbmsmqKBAAXrGpLjrsKEeayrQwcHvOVtbJHeYt5MdmI1ecdON65CaFC01+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636261; c=relaxed/simple;
	bh=MANMkRvyaEm4TFMefQFhtP9hAEWswU83yvGivjHb7QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saBZHGOGpiIfajgAO0yupticJD7Mvzv9q1pgcslzywQSHmgzA8KSg9+3IMq2XvEW0VeGSW8guOZciYncNg25yIWpodb97KBVInUjFKOJ+s/ZXpIn38U0CdUguyBwtDuCQpz4RWMT+sRTp5K/0neFdhOfDhL+3T1FXJ+xzccD6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR/ZTJ+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR/ZTJ+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFA7C4CEEE;
	Wed, 11 Jun 2025 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636261;
	bh=MANMkRvyaEm4TFMefQFhtP9hAEWswU83yvGivjHb7QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CR/ZTJ+ZcmGKEnb9ZkxE0xcgQAw9muJk8UDpS9Q2wepnQ3ZMxBZ8d136jIFhulonv
	 1/PFEbkNDbvn72bs/13ariMYZ69iBRtLnVqArI6aFatTQqxCJvRc598cJTFDuapr1t
	 Wv3HEk82mTY1Y+ulFFHtiPMHKefruAjRkkeEey+zKAnQMy7YtSNQZP7HO1X0Dtczbr
	 cquNCKlf99c/R0NAvuGR87ZCxwzGpMnv2zgjbTKl4sGbFuTE95O+R1dfXUA7PL4d+O
	 /zvxaVArfLI/ayCjSrRJDBA+lPFTKAYQy7ap4RfzlOTtlATGwYXSHdK/CJdsj72+a0
	 xvv9uIZUReCyQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 33/33] serial: 8250_omap: use uart_port pointer when available
Date: Wed, 11 Jun 2025 12:03:19 +0200
Message-ID: <20250611100319.186924-34-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are unnecessary "up->port." accesses on many places in 8250_omap.
"port" is avalable on most places, so instead simply use "port->".

And make port available in omap8250_restore_regs() too. It's used on
many places in there.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 53 +++++++++++++++--------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 72ae08d6204f..6707f55bdbe7 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -176,7 +176,7 @@ static u32 uart_read(struct omap8250_priv *priv, u32 reg)
 static void __omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	struct omap8250_priv *priv = up->port.private_data;
+	struct omap8250_priv *priv = port->private_data;
 	u8 lcr;
 
 	serial8250_do_set_mctrl(port, mctrl);
@@ -303,12 +303,13 @@ static void omap8250_update_mdr1(struct uart_8250_port *up,
 
 static void omap8250_restore_regs(struct uart_8250_port *up)
 {
-	struct omap8250_priv *priv = up->port.private_data;
+	struct uart_port *port = &up->port;
+	struct omap8250_priv *priv = port->private_data;
 	struct uart_8250_dma	*dma = up->dma;
 	u8 mcr = serial8250_in_MCR(up);
 
 	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&up->port.lock);
+	lockdep_assert_held_once(&port->lock);
 
 	if (dma && dma->tx_running) {
 		/*
@@ -359,12 +360,12 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 
 	omap8250_update_mdr1(up, priv);
 
-	__omap8250_set_mctrl(&up->port, up->port.mctrl);
+	__omap8250_set_mctrl(port, port->mctrl);
 
 	serial_out(up, UART_OMAP_MDR3, priv->mdr3);
 
-	if (up->port.rs485.flags & SER_RS485_ENABLED &&
-	    up->port.rs485_config == serial8250_em485_config)
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    port->rs485_config == serial8250_em485_config)
 		serial8250_em485_stop_tx(up, true);
 }
 
@@ -377,7 +378,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 				  const struct ktermios *old)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	struct omap8250_priv *priv = up->port.private_data;
+	struct omap8250_priv *priv = port->private_data;
 	unsigned char cval = 0;
 	unsigned int baud;
 
@@ -418,39 +419,39 @@ static void omap_8250_set_termios(struct uart_port *port,
 	 * ignoring of characters only occurs if the bit is set
 	 * in @ignore_status_mask as well.
 	 */
-	up->port.read_status_mask = UART_LSR_OE | UART_LSR_DR;
+	port->read_status_mask = UART_LSR_OE | UART_LSR_DR;
 	if (termios->c_iflag & INPCK)
-		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+		port->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
 	if (termios->c_iflag & (IGNBRK | PARMRK))
-		up->port.read_status_mask |= UART_LSR_BI;
+		port->read_status_mask |= UART_LSR_BI;
 
 	/*
 	 * Characters to ignore
 	 */
-	up->port.ignore_status_mask = 0;
+	port->ignore_status_mask = 0;
 	if (termios->c_iflag & IGNPAR)
-		up->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+		port->ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
 	if (termios->c_iflag & IGNBRK) {
-		up->port.ignore_status_mask |= UART_LSR_BI;
+		port->ignore_status_mask |= UART_LSR_BI;
 		/*
 		 * If we're ignoring parity and break indicators,
 		 * ignore overruns too (for real raw support).
 		 */
 		if (termios->c_iflag & IGNPAR)
-			up->port.ignore_status_mask |= UART_LSR_OE;
+			port->ignore_status_mask |= UART_LSR_OE;
 	}
 
 	/*
 	 * ignore all characters if CREAD is not set
 	 */
 	if ((termios->c_cflag & CREAD) == 0)
-		up->port.ignore_status_mask |= UART_LSR_DR;
+		port->ignore_status_mask |= UART_LSR_DR;
 
 	/*
 	 * Modem status interrupts
 	 */
 	up->ier &= ~UART_IER_MSI;
-	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
+	if (UART_ENABLE_MS(port, termios->c_cflag))
 		up->ier |= UART_IER_MSI;
 
 	up->lcr = cval;
@@ -488,15 +489,15 @@ static void omap_8250_set_termios(struct uart_port *port,
 	priv->xoff = termios->c_cc[VSTOP];
 
 	priv->efr = 0;
-	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
+	port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
-	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW &&
+	if (termios->c_cflag & CRTSCTS && port->flags & UPF_HARD_FLOW &&
 	    !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS) &&
 	    !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_CTS)) {
 		/* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
-		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
+		port->status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 		priv->efr |= UART_EFR_CTS;
-	} else	if (up->port.flags & UPF_SOFT_FLOW) {
+	} else	if (port->flags & UPF_SOFT_FLOW) {
 		/*
 		 * OMAP rx s/w flow control is borked; the transmitter remains
 		 * stuck off even if rx flow control is subsequently disabled
@@ -508,7 +509,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 		 * Transmit XON1, XOFF1
 		 */
 		if (termios->c_iflag & IXOFF) {
-			up->port.status |= UPSTAT_AUTOXOFF;
+			port->status |= UPSTAT_AUTOXOFF;
 			priv->efr |= OMAP_UART_SW_TX;
 		}
 	}
@@ -770,7 +771,7 @@ static int omap_8250_startup(struct uart_port *port)
 		uart_port_unlock_irq(port);
 	}
 
-	enable_irq(up->port.irq);
+	enable_irq(port->irq);
 
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
@@ -797,7 +798,7 @@ static void omap_8250_shutdown(struct uart_port *port)
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
 	uart_port_unlock_irq(port);
-	disable_irq_nosync(up->port.irq);
+	disable_irq_nosync(port->irq);
 	dev_pm_clear_wake_irq(port->dev);
 
 	serial8250_release_dma(up);
@@ -1310,7 +1311,7 @@ static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
 static int omap_8250_dma_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	struct omap8250_priv *priv = up->port.private_data;
+	struct omap8250_priv *priv = port->private_data;
 	u16 status;
 	u8 iir;
 
@@ -1332,8 +1333,8 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
 	serial8250_modem_status(up);
 	if (status & UART_LSR_THRE && up->dma->tx_err) {
-		if (uart_tx_stopped(&up->port) ||
-		    kfifo_is_empty(&up->port.state->port.xmit_fifo)) {
+		if (uart_tx_stopped(port) ||
+		    kfifo_is_empty(&port->state->port.xmit_fifo)) {
 			up->dma->tx_err = 0;
 			serial8250_tx_chars(up);
 		} else  {
-- 
2.49.0

