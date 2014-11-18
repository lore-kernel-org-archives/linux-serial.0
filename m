From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [RFC PATCH] serial: mxs-auart: Take missing uart port locks
Date: Tue, 18 Nov 2014 15:46:41 +0100
Message-ID: <1416322001-28491-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:57470 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933099AbaKROod (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Nov 2014 09:44:33 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Hector Palacios <hector.palacios@digi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viguera Javier <Javier.Viguera@digi.com>, Craig McQueen <craig.mcqueen@beamcommunications.com>, Janusz Uzycki <j.uzycki@elproma.com.pl>

The patch adds missing spin-locks and allows to change termios
settings during tx.
The patch also fixes direct call its enable_ms() according to
commit d41510ce2f07
("serial: Take uart port lock for direct *_enable_ms()")

The patch applies to next. Please test it with DMA enabled.
Most lock places come from commit 332ec0558ca of the repo
https://github.com/dgii/yocto-linux
According to atmel_serial's code and other drivers code
tty_flip_buffer_push() shouldn't be in lock - so I fixed it.
However I'm not convinced they are right so RFC sent.
The lock is not always used when auart's registers touched -
is it ok?

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 35 +++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 518eac6..7667c95 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -210,7 +210,9 @@ static void dma_tx_callback(void *param)
 {
 	struct mxs_auart_port *s = param;
 	struct circ_buf *xmit = &s->port.state->xmit;
+	unsigned long flags;
 
+	spin_lock_irqsave(&s->port.lock, flags);
 	dma_unmap_sg(s->dev, &s->tx_sgl, 1, DMA_TO_DEVICE);
 
 	/* clear the bit used to serialize the DMA tx. */
@@ -220,6 +222,7 @@ static void dma_tx_callback(void *param)
 	/* wake up the possible processes. */
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&s->port);
+	spin_unlock_irqrestore(&s->port.lock, flags);
 
 	mxs_auart_tx_chars(s);
 }
@@ -261,6 +264,7 @@ static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
 static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 {
 	struct circ_buf *xmit = &s->port.state->xmit;
+	unsigned long flags;
 
 	if (auart_dma_enabled(s)) {
 		u32 i = 0;
@@ -313,8 +317,11 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 		} else
 			break;
 	}
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
+		spin_lock_irqsave(&s->port.lock, flags);
 		uart_write_wakeup(&s->port);
+		spin_unlock_irqrestore(&s->port.lock, flags);
+	}
 
 	if (uart_circ_empty(&(s->port.state->xmit)))
 		writel(AUART_INTR_TXIEN,
@@ -375,6 +382,7 @@ out:
 static void mxs_auart_rx_chars(struct mxs_auart_port *s)
 {
 	u32 stat = 0;
+	unsigned long flags;
 
 	for (;;) {
 		stat = readl(s->port.membase + AUART_STAT);
@@ -383,7 +391,9 @@ static void mxs_auart_rx_chars(struct mxs_auart_port *s)
 		mxs_auart_rx_char(s);
 	}
 
+	spin_lock_irqsave(&s->port.lock, flags);
 	writel(stat, s->port.membase + AUART_STAT);
+	spin_unlock_irqrestore(&s->port.lock, flags);
 	tty_flip_buffer_push(&s->port.state->port);
 }
 
@@ -534,7 +544,9 @@ static void dma_rx_callback(void *arg)
 	struct tty_port *port = &s->port.state->port;
 	int count;
 	u32 stat;
+	unsigned long flags;
 
+	spin_lock_irqsave(&s->port.lock, flags);
 	dma_unmap_sg(s->dev, &s->rx_sgl, 1, DMA_FROM_DEVICE);
 
 	stat = readl(s->port.membase + AUART_STAT);
@@ -545,6 +557,7 @@ static void dma_rx_callback(void *arg)
 	tty_insert_flip_string(port, s->rx_dma_buf, count);
 
 	writel(stat, s->port.membase + AUART_STAT);
+	spin_unlock_irqrestore(&s->port.lock, flags);
 	tty_flip_buffer_push(port);
 
 	/* start the next DMA for RX. */
@@ -606,7 +619,9 @@ static void mxs_auart_dma_exit_channel(struct mxs_auart_port *s)
 
 static void mxs_auart_dma_exit(struct mxs_auart_port *s)
 {
+	unsigned long flags;
 
+	spin_lock_irqsave(&s->port.lock, flags);
 	writel(AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE | AUART_CTRL2_DMAONERR,
 		s->port.membase + AUART_CTRL2_CLR);
 
@@ -614,13 +629,17 @@ static void mxs_auart_dma_exit(struct mxs_auart_port *s)
 	s->flags &= ~MXS_AUART_DMA_ENABLED;
 	clear_bit(MXS_AUART_DMA_TX_SYNC, &s->flags);
 	clear_bit(MXS_AUART_DMA_RX_READY, &s->flags);
+	spin_unlock_irqrestore(&s->port.lock, flags);
 }
 
 static int mxs_auart_dma_init(struct mxs_auart_port *s)
 {
+	unsigned long flags;
+
 	if (auart_dma_enabled(s))
 		return 0;
 
+	spin_lock_irqsave(&s->port.lock, flags);
 	/* init for RX */
 	s->rx_dma_chan = dma_request_slave_channel(s->dev, "rx");
 	if (!s->rx_dma_chan)
@@ -644,9 +663,12 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	s->port.fifosize = UART_XMIT_SIZE;
 
+	spin_unlock_irqrestore(&s->port.lock, flags);
+
 	return 0;
 
 err_out:
+	spin_unlock_irqrestore(&s->port.lock, flags);
 	mxs_auart_dma_exit_channel(s);
 	return -EINVAL;
 
@@ -663,6 +685,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 	struct mxs_auart_port *s = to_auart_port(u);
 	u32 bm, ctrl, ctrl2, div;
 	unsigned int cflag, baud;
+	unsigned long flags;
 
 	cflag = termios->c_cflag;
 
@@ -760,11 +783,15 @@ static void mxs_auart_settermios(struct uart_port *u,
 	ctrl |= AUART_LINECTRL_BAUD_DIVFRAC(div & 0x3F);
 	ctrl |= AUART_LINECTRL_BAUD_DIVINT(div >> 6);
 
+	spin_lock_irqsave(&s->port.lock, flags);
+
 	writel(ctrl, u->membase + AUART_LINECTRL);
 	writel(ctrl2, u->membase + AUART_CTRL2);
 
 	uart_update_timeout(u, termios->c_cflag, baud);
 
+	spin_unlock_irqrestore(&s->port.lock, flags);
+
 	/* prepare for the DMA RX. */
 	if (auart_dma_enabled(s) &&
 		!test_and_set_bit(MXS_AUART_DMA_RX_READY, &s->flags)) {
@@ -778,18 +805,24 @@ static void mxs_auart_settermios(struct uart_port *u,
 		}
 	}
 
+	spin_lock_irqsave(&s->port.lock, flags);
+
 	/* CTS flow-control and modem-status interrupts */
 	if (UART_ENABLE_MS(u, termios->c_cflag))
 		mxs_auart_enable_ms(u);
 	else
 		mxs_auart_disable_ms(u);
+
+	spin_unlock_irqrestore(&s->port.lock, flags);
 }
 
 static void mxs_auart_set_ldisc(struct uart_port *port, int new)
 {
 	if (new == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
+		spin_lock_irq(&port->lock);
 		mxs_auart_enable_ms(port);
+		spin_unlock_irq(&port->lock);
 	} else {
 		port->flags &= ~UPF_HARDPPS_CD;
 	}
-- 
1.7.11.3

