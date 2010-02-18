From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2] Add DMA support for the sh-sci.c serial driver
Date: Thu, 18 Feb 2010 17:30:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002181726230.4373@axis700.grange>
References: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48395 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758579Ab0BRQaC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Feb 2010 11:30:02 -0500
In-Reply-To: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org

Support using DMA for sending and receiving data over SCI(F) interfaces of 
various SH SoCs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Tested on Migo-R (sh7722), partially on ms7724se (sh7724), the latter 
seems to be unable to use DMA with SCIFA ports (3-5).

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9a8e9f0..52f28e1 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1016,6 +1016,12 @@ config SERIAL_SH_SCI_CONSOLE
 	depends on SERIAL_SH_SCI=y
 	select SERIAL_CORE_CONSOLE
 
+config SH_SCI_USE_DMA
+	bool "DMA support"
+	depends on SERIAL_SH_SCI
+	select DMADEVICES
+	select SH_DMAE
+
 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
 	depends on MIPS && (SOC_PNX8550 || SOC_PNX833X)
diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 2cf3b6d..36e608e 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -48,6 +48,9 @@
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/list.h>
+#include <linux/dmaengine.h>
+#include <linux/scatterlist.h>
+#include <linux/timer.h>
 
 #ifdef CONFIG_SUPERH
 #include <asm/sh_bios.h>
@@ -84,6 +87,27 @@ struct sci_port {
 	struct clk		*dclk;
 
 	struct list_head	node;
+	struct dma_chan			*chan_tx;
+	struct dma_chan			*chan_rx;
+#ifdef CONFIG_SH_SCI_USE_DMA
+	struct device			*dma_dev;
+	enum sh_dmae_slave_chan_id	slave_tx;
+	enum sh_dmae_slave_chan_id	slave_rx;
+	struct dma_async_tx_descriptor	*desc_tx;
+	struct dma_async_tx_descriptor	*desc_rx[2];
+	dma_cookie_t			cookie_tx;
+	dma_cookie_t			cookie_rx[2];
+	dma_cookie_t			active_rx;
+	struct scatterlist		sg_tx;
+	unsigned int			sg_len_tx;
+	struct scatterlist		sg_rx[2];
+	size_t				buf_len_rx;
+	struct sh_dmae_slave		param_tx;
+	struct sh_dmae_slave		param_rx;
+	struct work_struct		work_tx;
+	struct work_struct		work_rx;
+	struct timer_list		rx_timer;
+#endif
 };
 
 struct sh_sci_priv {
@@ -273,29 +297,44 @@ static inline void sci_init_pins(struct uart_port *port, unsigned int cflag)
     defined(CONFIG_CPU_SUBTYPE_SH7780) || \
     defined(CONFIG_CPU_SUBTYPE_SH7785) || \
     defined(CONFIG_CPU_SUBTYPE_SH7786)
-static inline int scif_txroom(struct uart_port *port)
+static int scif_txfill(struct uart_port *port)
 {
-	return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0xff);
+	return sci_in(port, SCTFDR) & 0xff;
 }
 
-static inline int scif_rxroom(struct uart_port *port)
+static int scif_txroom(struct uart_port *port)
+{
+	return SCIF_TXROOM_MAX - scif_txfill(port);
+}
+
+static int scif_rxfill(struct uart_port *port)
 {
 	return sci_in(port, SCRFDR) & 0xff;
 }
 #elif defined(CONFIG_CPU_SUBTYPE_SH7763)
-static inline int scif_txroom(struct uart_port *port)
+static int scif_txfill(struct uart_port *port)
 {
-	if ((port->mapbase == 0xffe00000) ||
-	    (port->mapbase == 0xffe08000)) {
+	if (port->mapbase == 0xffe00000 ||
+	    port->mapbase == 0xffe08000)
 		/* SCIF0/1*/
-		return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0xff);
-	} else {
+		return sci_in(port, SCTFDR) & 0xff;
+	else
 		/* SCIF2 */
-		return SCIF2_TXROOM_MAX - (sci_in(port, SCFDR) >> 8);
-	}
+		return sci_in(port, SCFDR) >> 8;
+}
+
+static int scif_txroom(struct uart_port *port)
+{
+	if (port->mapbase == 0xffe00000 ||
+	    port->mapbase == 0xffe08000)
+		/* SCIF0/1*/
+		return SCIF_TXROOM_MAX - scif_txfill(port);
+	else
+		/* SCIF2 */
+		return SCIF2_TXROOM_MAX - scif_txfill(port);
 }
 
-static inline int scif_rxroom(struct uart_port *port)
+static int scif_rxfill(struct uart_port *port)
 {
 	if ((port->mapbase == 0xffe00000) ||
 	    (port->mapbase == 0xffe08000)) {
@@ -307,23 +346,33 @@ static inline int scif_rxroom(struct uart_port *port)
 	}
 }
 #else
-static inline int scif_txroom(struct uart_port *port)
+static int scif_txfill(struct uart_port *port)
 {
-	return SCIF_TXROOM_MAX - (sci_in(port, SCFDR) >> 8);
+	return sci_in(port, SCFDR) >> 8;
 }
 
-static inline int scif_rxroom(struct uart_port *port)
+static int scif_txroom(struct uart_port *port)
+{
+	return SCIF_TXROOM_MAX - scif_txfill(port);
+}
+
+static int scif_rxfill(struct uart_port *port)
 {
 	return sci_in(port, SCFDR) & SCIF_RFDC_MASK;
 }
 #endif
 
-static inline int sci_txroom(struct uart_port *port)
+static int sci_txfill(struct uart_port *port)
 {
-	return (sci_in(port, SCxSR) & SCI_TDRE) != 0;
+	return !(sci_in(port, SCxSR) & SCI_TDRE);
 }
 
-static inline int sci_rxroom(struct uart_port *port)
+static int sci_txroom(struct uart_port *port)
+{
+	return !sci_txfill(port);
+}
+
+static int sci_rxfill(struct uart_port *port)
 {
 	return (sci_in(port, SCxSR) & SCxSR_RDxF(port)) != 0;
 }
@@ -410,9 +459,9 @@ static inline void sci_receive_chars(struct uart_port *port)
 
 	while (1) {
 		if (port->type == PORT_SCI)
-			count = sci_rxroom(port);
+			count = sci_rxfill(port);
 		else
-			count = scif_rxroom(port);
+			count = scif_rxfill(port);
 
 		/* Don't copy more bytes than there is room for in the buffer */
 		count = tty_buffer_request_room(tty, count);
@@ -457,10 +506,10 @@ static inline void sci_receive_chars(struct uart_port *port)
 				}
 
 				/* Store data and status */
-				if (status&SCxSR_FER(port)) {
+				if (status & SCxSR_FER(port)) {
 					flag = TTY_FRAME;
 					dev_notice(port->dev, "frame error\n");
-				} else if (status&SCxSR_PER(port)) {
+				} else if (status & SCxSR_PER(port)) {
 					flag = TTY_PARITY;
 					dev_notice(port->dev, "parity error\n");
 				} else
@@ -622,13 +671,39 @@ static inline int sci_handle_breaks(struct uart_port *port)
 	return copied;
 }
 
-static irqreturn_t sci_rx_interrupt(int irq, void *port)
+static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 {
+#ifdef CONFIG_SH_SCI_USE_DMA
+	struct uart_port *port = ptr;
+	struct sci_port *s = to_sci_port(port);
+
+	if (s->chan_rx) {
+		unsigned long tout;
+		u16 scr = sci_in(port, SCSCR);
+		u16 ssr = sci_in(port, SCxSR);
+
+		/* Disable future Rx interrupts */
+		sci_out(port, SCSCR, scr & ~SCI_CTRL_FLAGS_RIE);
+		/* Clear current interrupt */
+		sci_out(port, SCxSR, ssr & ~(1 | SCxSR_RDxF(port)));
+		/* Calculate delay for 1.5 DMA buffers */
+		tout = (port->timeout - HZ / 50) * s->buf_len_rx * 3 /
+			port->fifosize / 2;
+		dev_dbg(port->dev, "Rx IRQ: setup timeout in %u ms\n",
+			tout * 1000 / HZ);
+		if (tout < 2)
+			tout = 2;
+		mod_timer(&s->rx_timer, jiffies + tout);
+
+		return IRQ_HANDLED;
+	}
+#endif
+
 	/* I think sci_receive_chars has to be called irrespective
 	 * of whether the I_IXOFF is set, otherwise, how is the interrupt
 	 * to be disabled?
 	 */
-	sci_receive_chars(port);
+	sci_receive_chars(ptr);
 
 	return IRQ_HANDLED;
 }
@@ -684,6 +759,9 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 {
 	unsigned short ssr_status, scr_status, err_enabled;
 	struct uart_port *port = ptr;
+#ifdef CONFIG_SH_SCI_USE_DMA
+	struct sci_port *s = to_sci_port(port);
+#endif
 	irqreturn_t ret = IRQ_NONE;
 
 	ssr_status = sci_in(port, SCxSR);
@@ -691,10 +769,15 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	err_enabled = scr_status & (SCI_CTRL_FLAGS_REIE | SCI_CTRL_FLAGS_RIE);
 
 	/* Tx Interrupt */
-	if ((ssr_status & SCxSR_TDxE(port)) && (scr_status & SCI_CTRL_FLAGS_TIE))
+	if ((ssr_status & SCxSR_TDxE(port)) && (scr_status & SCI_CTRL_FLAGS_TIE) &&
+	    !s->chan_tx)
 		ret = sci_tx_interrupt(irq, ptr);
-	/* Rx Interrupt */
-	if ((ssr_status & SCxSR_RDxF(port)) && (scr_status & SCI_CTRL_FLAGS_RIE))
+	/*
+	 * Rx Interrupt: if we're using DMA, the DMA controller clears RDF /
+	 * DR flags
+	 */
+	if (((ssr_status & SCxSR_RDxF(port)) || s->chan_rx) &&
+	    (scr_status & SCI_CTRL_FLAGS_RIE))
 		ret = sci_rx_interrupt(irq, ptr);
 	/* Error Interrupt */
 	if ((ssr_status & SCxSR_ERRORS(port)) && err_enabled)
@@ -703,6 +786,10 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	if ((ssr_status & SCxSR_BRK(port)) && err_enabled)
 		ret = sci_br_interrupt(irq, ptr);
 
+	WARN_ONCE(ret == IRQ_NONE,
+		  "%s: %d IRQ %d, status %x, control %x\n", __func__,
+		  irq, port->line, ssr_status, scr_status);
+
 	return ret;
 }
 
@@ -804,7 +891,9 @@ static void sci_free_irq(struct sci_port *port)
 static unsigned int sci_tx_empty(struct uart_port *port)
 {
 	unsigned short status = sci_in(port, SCxSR);
-	return status & SCxSR_TEND(port) ? TIOCSER_TEMT : 0;
+	unsigned short in_tx_fifo = scif_txfill(port);
+
+	return (status & SCxSR_TEND(port)) && !in_tx_fifo ? TIOCSER_TEMT : 0;
 }
 
 static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
@@ -816,16 +905,301 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static unsigned int sci_get_mctrl(struct uart_port *port)
 {
-	/* This routine is used for geting signals of: DTR, DCD, DSR, RI,
+	/* This routine is used for getting signals of: DTR, DCD, DSR, RI,
 	   and CTS/RTS */
 
 	return TIOCM_DTR | TIOCM_RTS | TIOCM_DSR;
 }
 
+#ifdef CONFIG_SH_SCI_USE_DMA
+static void sci_dma_tx_complete(void *arg)
+{
+	struct sci_port *s = arg;
+	struct uart_port *port = &s->port;
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long flags;
+
+	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	xmit->tail += s->sg_tx.length;
+	xmit->tail &= UART_XMIT_SIZE - 1;
+
+	port->icount.tx += s->sg_tx.length;
+
+	async_tx_ack(s->desc_tx);
+	s->cookie_tx = -EINVAL;
+	s->desc_tx = NULL;
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_chars_pending(xmit))
+		schedule_work(&s->work_tx);
+}
+
+/* Locking: called with port lock held */
+static int sci_dma_rx_push(struct sci_port *s, struct tty_struct *tty,
+			   size_t count)
+{
+	struct uart_port *port = &s->port;
+	int i, active, room;
+
+	room = tty_buffer_request_room(tty, count);
+
+	if (s->active_rx == s->cookie_rx[0]) {
+		active = 0;
+	} else if (s->active_rx == s->cookie_rx[1]) {
+		active = 1;
+	} else {
+		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
+		return 0;
+	}
+
+	if (room < count)
+		dev_warn(port->dev, "Rx overrun: dropping %u bytes\n",
+			 count - room);
+	if (!room)
+		return room;
+
+	for (i = 0; i < room; i++)
+		tty_insert_flip_char(tty, ((u8 *)sg_virt(&s->sg_rx[active]))[i],
+				     TTY_NORMAL);
+
+	port->icount.rx += room;
+
+	return room;
+}
+
+static void sci_dma_rx_complete(void *arg)
+{
+	struct sci_port *s = arg;
+	struct uart_port *port = &s->port;
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned long flags;
+	int count;
+
+	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	count = sci_dma_rx_push(s, tty, s->buf_len_rx);
+
+	mod_timer(&s->rx_timer, jiffies + msecs_to_jiffies(5));
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (count)
+		tty_flip_buffer_push(tty);
+
+	schedule_work(&s->work_rx);
+}
+
+static void sci_start_rx(struct uart_port *port);
+static void sci_start_tx(struct uart_port *port);
+
+static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
+{
+	struct dma_chan *chan = s->chan_rx;
+	struct uart_port *port = &s->port;
+	unsigned long flags;
+
+	s->chan_rx = NULL;
+	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
+	dma_release_channel(chan);
+	dma_free_coherent(port->dev, s->buf_len_rx * 2,
+			  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
+	if (enable_pio)
+		sci_start_rx(port);
+}
+
+static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
+{
+	struct dma_chan *chan = s->chan_tx;
+	struct uart_port *port = &s->port;
+	unsigned long flags;
+
+	s->chan_tx = NULL;
+	s->cookie_tx = -EINVAL;
+	dma_release_channel(chan);
+	if (enable_pio)
+		sci_start_tx(port);
+}
+
+static void sci_submit_rx(struct sci_port *s)
+{
+	struct dma_chan *chan = s->chan_rx;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct scatterlist *sg = &s->sg_rx[i];
+		struct dma_async_tx_descriptor *desc;
+
+		desc = chan->device->device_prep_slave_sg(chan,
+			sg, 1, DMA_FROM_DEVICE, DMA_PREP_INTERRUPT);
+
+		if (desc) {
+			s->desc_rx[i] = desc;
+			desc->callback = sci_dma_rx_complete;
+			desc->callback_param = s;
+			s->cookie_rx[i] = desc->tx_submit(desc);
+		}
+
+		if (!desc || s->cookie_rx[i] < 0) {
+			if (i) {
+				async_tx_ack(s->desc_rx[0]);
+				s->cookie_rx[0] = -EINVAL;
+			}
+			if (desc) {
+				async_tx_ack(desc);
+				s->cookie_rx[i] = -EINVAL;
+			}
+			dev_warn(s->port.dev,
+				 "failed to re-start DMA, using PIO\n");
+			sci_rx_dma_release(s, true);
+			return;
+		}
+	}
+
+	s->active_rx = s->cookie_rx[0];
+
+	dma_async_issue_pending(chan);
+
+	return;
+}
+
+static void work_fn_rx(struct work_struct *work)
+{
+	struct sci_port *s = container_of(work, struct sci_port, work_rx);
+	struct uart_port *port = &s->port;
+	struct dma_async_tx_descriptor *desc;
+	int new;
+
+	if (s->active_rx == s->cookie_rx[0]) {
+		new = 0;
+	} else if (s->active_rx == s->cookie_rx[1]) {
+		new = 1;
+	} else {
+		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
+		return;
+	}
+	desc = s->desc_rx[new];
+
+	if (dma_async_is_tx_complete(s->chan_rx, s->active_rx, NULL, NULL) !=
+	    DMA_SUCCESS) {
+		/* Handle incomplete DMA receive */
+		struct tty_struct *tty = port->state->port.tty;
+		struct dma_chan *chan = s->chan_rx;
+		struct sh_desc *sh_desc = container_of(desc, struct sh_desc,
+						       async_tx);
+		unsigned long flags;
+		int count;
+
+		chan->device->device_terminate_all(chan);
+		dev_dbg(port->dev, "Read %u bytes with cookie %d\n",
+			sh_desc->partial, sh_desc->cookie);
+
+		spin_lock_irqsave(&port->lock, flags);
+		count = sci_dma_rx_push(s, tty, sh_desc->partial);
+		spin_unlock_irqrestore(&port->lock, flags);
+
+		if (count)
+			tty_flip_buffer_push(tty);
+
+		sci_submit_rx(s);
+
+		return;
+	}
+
+	s->cookie_rx[new] = desc->tx_submit(desc);
+	if (s->cookie_rx[new] < 0) {
+		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
+		sci_rx_dma_release(s, true);
+		return;
+	}
+
+	dev_dbg(port->dev, "%s: cookie %d #%d\n", __func__,
+		s->cookie_rx[new], new);
+
+	s->active_rx = s->cookie_rx[!new];
+}
+
+static void work_fn_tx(struct work_struct *work)
+{
+	struct sci_port *s = container_of(work, struct sci_port, work_tx);
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *chan = s->chan_tx;
+	struct uart_port *port = &s->port;
+	struct circ_buf *xmit = &port->state->xmit;
+	struct scatterlist *sg = &s->sg_tx;
+
+	/*
+	 * DMA is idle now.
+	 * Port xmit buffer is already mapped, and it is one page... Just adjust
+	 * offsets and lengths. Since it is a circular buffer, we have to
+	 * transmit till the end, and then the rest. Take the port lock to get a
+	 * consistent xmit buffer state.
+	 */
+	spin_lock_irq(&port->lock);
+	sg->offset = xmit->tail & (UART_XMIT_SIZE - 1);
+	sg->dma_address = (sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1)) +
+		sg->offset;
+	sg->length = min((int)CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
+		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE));
+	sg->dma_length = sg->length;
+	spin_unlock_irq(&port->lock);
+
+	BUG_ON(!sg->length);
+
+	desc = chan->device->device_prep_slave_sg(chan,
+			sg, s->sg_len_tx, DMA_TO_DEVICE,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		/* switch to PIO */
+		sci_tx_dma_release(s, true);
+		return;
+	}
+
+	dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
+
+	spin_lock_irq(&port->lock);
+	s->desc_tx = desc;
+	desc->callback = sci_dma_tx_complete;
+	desc->callback_param = s;
+	spin_unlock_irq(&port->lock);
+	s->cookie_tx = desc->tx_submit(desc);
+	if (s->cookie_tx < 0) {
+		dev_warn(port->dev, "Failed submitting Tx DMA descriptor\n");
+		/* switch to PIO */
+		sci_tx_dma_release(s, true);
+		return;
+	}
+
+	dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n", __func__,
+		xmit->buf, xmit->tail, xmit->head, s->cookie_tx);
+
+	dma_async_issue_pending(chan);
+}
+#endif
+
 static void sci_start_tx(struct uart_port *port)
 {
 	unsigned short ctrl;
 
+#ifdef CONFIG_SH_SCI_USE_DMA
+	struct sci_port *s = to_sci_port(port);
+
+	if (s->chan_tx) {
+		if (!uart_circ_empty(&s->port.state->xmit) && s->cookie_tx < 0)
+			schedule_work(&s->work_tx);
+
+		return;
+	}
+#endif
+
 	/* Set TIE (Transmit Interrupt Enable) bit in SCSCR */
 	ctrl = sci_in(port, SCSCR);
 	ctrl |= SCI_CTRL_FLAGS_TIE;
@@ -842,13 +1216,12 @@ static void sci_stop_tx(struct uart_port *port)
 	sci_out(port, SCSCR, ctrl);
 }
 
-static void sci_start_rx(struct uart_port *port, unsigned int tty_start)
+static void sci_start_rx(struct uart_port *port)
 {
-	unsigned short ctrl;
+	unsigned short ctrl = SCI_CTRL_FLAGS_RIE | SCI_CTRL_FLAGS_REIE;
 
 	/* Set RIE (Receive Interrupt Enable) bit in SCSCR */
-	ctrl = sci_in(port, SCSCR);
-	ctrl |= SCI_CTRL_FLAGS_RIE | SCI_CTRL_FLAGS_REIE;
+	ctrl |= sci_in(port, SCSCR);
 	sci_out(port, SCSCR, ctrl);
 }
 
@@ -872,16 +1245,154 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 	/* Nothing here yet .. */
 }
 
+#ifdef CONFIG_SH_SCI_USE_DMA
+static bool filter(struct dma_chan *chan, void *slave)
+{
+	struct sh_dmae_slave *param = slave;
+
+	dev_dbg(chan->device->dev, "%s: slave ID %d\n", __func__,
+		param->slave_id);
+
+	if (param->dma_dev == chan->device->dev) {
+		chan->private = param;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+static void rx_timer_fn(unsigned long arg)
+{
+	struct sci_port *s = (struct sci_port *)arg;
+	struct uart_port *port = &s->port;
+
+	u16 scr = sci_in(port, SCSCR);
+	sci_out(port, SCSCR, scr | SCI_CTRL_FLAGS_RIE);
+	dev_dbg(port->dev, "DMA Rx timed out\n");
+	schedule_work(&s->work_rx);
+}
+
+static void sci_request_dma(struct uart_port *port)
+{
+	struct sci_port *s = to_sci_port(port);
+	struct sh_dmae_slave *param;
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+	int nent;
+
+	dev_dbg(port->dev, "%s: port %d DMA %p\n", __func__,
+		port->line, s->dma_dev);
+
+	if (!s->dma_dev)
+		return;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	param = &s->param_tx;
+
+	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_TX */
+	param->slave_id = s->slave_tx;
+	param->dma_dev = s->dma_dev;
+
+	s->cookie_tx = -EINVAL;
+	chan = dma_request_channel(mask, filter, param);
+	dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
+	if (chan) {
+		s->chan_tx = chan;
+		sg_init_table(&s->sg_tx, 1);
+		/* UART circular tx buffer is an aligned page. */
+		BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
+		sg_set_page(&s->sg_tx, virt_to_page(port->state->xmit.buf),
+			    UART_XMIT_SIZE, (int)port->state->xmit.buf & ~PAGE_MASK);
+		nent = dma_map_sg(port->dev, &s->sg_tx, 1, DMA_TO_DEVICE);
+		if (!nent)
+			sci_tx_dma_release(s, false);
+		else
+			dev_dbg(port->dev, "%s: mapped %d@%p to %x\n", __func__,
+				sg_dma_len(&s->sg_tx),
+				port->state->xmit.buf, sg_dma_address(&s->sg_tx));
+
+		s->sg_len_tx = nent;
+
+		INIT_WORK(&s->work_tx, work_fn_tx);
+	}
+
+	param = &s->param_rx;
+
+	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_RX */
+	param->slave_id = s->slave_rx;
+	param->dma_dev = s->dma_dev;
+
+	chan = dma_request_channel(mask, filter, param);
+	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
+	if (chan) {
+		dma_addr_t dma[2];
+		void *buf[2];
+		int i;
+
+		s->chan_rx = chan;
+
+		s->buf_len_rx = 2 * max(16, (int)port->fifosize);
+		buf[0] = dma_alloc_coherent(port->dev, s->buf_len_rx * 2,
+					    &dma[0], GFP_KERNEL);
+
+		if (!buf[0]) {
+			dev_warn(port->dev,
+				 "failed to allocate dma buffer, using PIO\n");
+			sci_rx_dma_release(s, true);
+			return;
+		}
+
+		buf[1] = buf[0] + s->buf_len_rx;
+		dma[1] = dma[0] + s->buf_len_rx;
+
+		for (i = 0; i < 2; i++) {
+			struct scatterlist *sg = &s->sg_rx[i];
+
+			sg_init_table(sg, 1);
+			sg_set_page(sg, virt_to_page(buf[i]), s->buf_len_rx,
+				    (int)buf[i] & ~PAGE_MASK);
+			sg->dma_address = dma[i];
+			sg->dma_length = sg->length;
+		}
+
+		INIT_WORK(&s->work_rx, work_fn_rx);
+		setup_timer(&s->rx_timer, rx_timer_fn, (unsigned long)s);
+
+		sci_submit_rx(s);
+	}
+}
+
+static void sci_free_dma(struct uart_port *port)
+{
+	struct sci_port *s = to_sci_port(port);
+
+	if (!s->dma_dev)
+		return;
+
+	if (s->chan_tx)
+		sci_tx_dma_release(s, false);
+	if (s->chan_rx)
+		sci_rx_dma_release(s, false);
+}
+#endif
+
 static int sci_startup(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
 
+	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
+
 	if (s->enable)
 		s->enable(port);
 
 	sci_request_irq(s);
+#ifdef CONFIG_SH_SCI_USE_DMA
+	sci_request_dma(port);
+#endif
 	sci_start_tx(port);
-	sci_start_rx(port, 1);
+	sci_start_rx(port);
 
 	return 0;
 }
@@ -890,8 +1401,13 @@ static void sci_shutdown(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
 
+	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
+
 	sci_stop_rx(port);
 	sci_stop_tx(port);
+#ifdef CONFIG_SH_SCI_USE_DMA
+	sci_free_dma(port);
+#endif
 	sci_free_irq(s);
 
 	if (s->disable)
@@ -941,6 +1457,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sci_out(port, SCSMR, smr_val);
 
+	dev_dbg(port->dev, "%s: SMR %x, t %x, SCSCR %x\n", __func__, smr_val, t,
+		SCSCR_INIT(port));
+
 	if (t > 0) {
 		if (t >= 256) {
 			sci_out(port, SCSMR, (sci_in(port, SCSMR) & ~3) | 1);
@@ -958,7 +1477,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	sci_out(port, SCSCR, SCSCR_INIT(port));
 
 	if ((termios->c_cflag & CREAD) != 0)
-		sci_start_rx(port, 0);
+		sci_start_rx(port);
 }
 
 static const char *sci_type(struct uart_port *port)
@@ -1053,19 +1572,21 @@ static void __devinit sci_init_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p)
 {
-	sci_port->port.ops	= &sci_uart_ops;
-	sci_port->port.iotype	= UPIO_MEM;
-	sci_port->port.line	= index;
+	struct uart_port *port = &sci_port->port;
+
+	port->ops	= &sci_uart_ops;
+	port->iotype	= UPIO_MEM;
+	port->line	= index;
 
 	switch (p->type) {
 	case PORT_SCIFA:
-		sci_port->port.fifosize = 64;
+		port->fifosize = 64;
 		break;
 	case PORT_SCIF:
-		sci_port->port.fifosize = 16;
+		port->fifosize = 16;
 		break;
 	default:
-		sci_port->port.fifosize = 1;
+		port->fifosize = 1;
 		break;
 	}
 
@@ -1074,19 +1595,28 @@ static void __devinit sci_init_single(struct platform_device *dev,
 		sci_port->dclk = clk_get(&dev->dev, "peripheral_clk");
 		sci_port->enable = sci_clk_enable;
 		sci_port->disable = sci_clk_disable;
-		sci_port->port.dev = &dev->dev;
+		port->dev = &dev->dev;
 	}
 
 	sci_port->break_timer.data = (unsigned long)sci_port;
 	sci_port->break_timer.function = sci_break_timer;
 	init_timer(&sci_port->break_timer);
 
-	sci_port->port.mapbase	= p->mapbase;
-	sci_port->port.membase	= p->membase;
+	port->mapbase	= p->mapbase;
+	port->membase	= p->membase;
 
-	sci_port->port.irq	= p->irqs[SCIx_TXI_IRQ];
-	sci_port->port.flags	= p->flags;
-	sci_port->type		= sci_port->port.type = p->type;
+	port->irq	= p->irqs[SCIx_TXI_IRQ];
+	port->flags	= p->flags;
+	sci_port->type	= port->type = p->type;
+
+#ifdef CONFIG_SH_SCI_USE_DMA
+	sci_port->dma_dev	= p->dma_dev;
+	sci_port->slave_tx	= p->dma_slave_tx;
+	sci_port->slave_rx	= p->dma_slave_rx;
+
+	dev_dbg(port->dev, "%s: DMA device %p, tx %d, rx %d\n", __func__,
+		p->dma_dev, p->dma_slave_tx, p->dma_slave_rx);
+#endif
 
 	memcpy(&sci_port->irqs, &p->irqs, sizeof(p->irqs));
 }
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 1c297dd..1b177d2 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -2,6 +2,7 @@
 #define __LINUX_SERIAL_SCI_H
 
 #include <linux/serial_core.h>
+#include <asm/dmaengine.h>
 
 /*
  * Generic header for SuperH SCI(F) (used by sh/sh64/h8300 and related parts)
@@ -16,6 +17,8 @@ enum {
 	SCIx_NR_IRQS,
 };
 
+struct device;
+
 /*
  * Platform device specific platform_data struct
  */
@@ -26,6 +29,9 @@ struct plat_sci_port {
 	unsigned int	type;			/* SCI / SCIF / IRDA */
 	upf_t		flags;			/* UPF_* flags */
 	char		*clk;			/* clock string */
+	struct device	*dma_dev;
+	enum sh_dmae_slave_chan_id dma_slave_tx;
+	enum sh_dmae_slave_chan_id dma_slave_rx;
 };
 
 #endif /* __LINUX_SERIAL_SCI_H */
