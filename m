From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 3/4] tty: serial: 8250: omap: convert to using cyclic transfers
Date: Fri, 22 Jan 2016 11:27:50 +0100
Message-ID: <87zivxq57d.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, peter@hurleysoftware.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

By using cyclic transfers it is possible to sustain long running
DMA transfers at 3Mbit, even without flow control.

The ring buffer used for cyclic dma transfers will grow according
to the baud rate to allow at least 1 second of buffering. This way
a large (367KiB) ring buffer would only be allocated if very high
baud rates are used (3Mbit).

A hrtimer is used as a watchdog to monitor that data in the ring
buffer is not overwritten before being processed by the tty layer.

Note that an ugly device-tree lookup hack is implemented in order
to detect if the sDMA engine is being used. This is necessary
because the sDMA driver does not implement pause/resume correctly
and therefore requires slightly different logic for the UART
driver.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 patch against next-20160122

 drivers/tty/serial/8250/8250.h      |    2 +
 drivers/tty/serial/8250/8250_omap.c |  420 ++++++++++++++++++++++++-----------
 2 files changed, 293 insertions(+), 129 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index d54dcd8..61b5a52 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -42,6 +42,8 @@ struct uart_8250_dma {
 	size_t			rx_size;
 	size_t			tx_size;
 
+	unsigned int		rx_pos;
+
 	unsigned char		tx_running;
 	unsigned char		tx_err;
 	unsigned char		rx_running;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6cf3b4f..ef7a60b 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -25,6 +25,7 @@
 #include <linux/pm_qos.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
+#include <linux/hrtimer.h>
 
 #include "8250.h"
 
@@ -38,6 +39,7 @@
  * The same errata is applicable to AM335x and DRA7x processors too.
  */
 #define UART_ERRATA_CLOCK_DISABLE	(1 << 3)
+#define OMAP_DMA_RX_RESUME_STARTOVER	(1 << 4)
 
 #define OMAP_UART_FCR_RX_TRIG		6
 #define OMAP_UART_FCR_TX_TRIG		4
@@ -110,9 +112,14 @@ struct omap8250_priv {
 	u32 calc_latency;
 	struct pm_qos_request pm_qos_request;
 	struct work_struct qos_work;
+
+#ifdef CONFIG_SERIAL_8250_DMA
 	struct uart_8250_dma omap8250_dma;
 	spinlock_t rx_dma_lock;
-	bool rx_dma_broken;
+	struct hrtimer rx_dma_wd;
+	ktime_t rx_half_fill_time;
+	int rx_dma_wd_ready;
+#endif
 };
 
 static u32 uart_read(struct uart_8250_port *up, u32 reg)
@@ -310,6 +317,8 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 	up->port.ops->set_mctrl(&up->port, up->port.mctrl);
 }
 
+static void realloc_rx_dma_buf(struct uart_8250_port *p, unsigned int baud);
+
 /*
  * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have have
  * some differences in how we want to handle flow control.
@@ -357,6 +366,9 @@ static void omap_8250_set_termios(struct uart_port *port,
 				  port->uartclk / 13);
 	omap_8250_get_divisor(port, baud, priv);
 
+	if (up->dma && up->dma->rxchan)
+		realloc_rx_dma_buf(up, baud);
+
 	/*
 	 * Ok, we're now changing the port state. Do it with
 	 * interrupts disabled.
@@ -560,9 +572,7 @@ static void omap8250_uart_qos_work(struct work_struct *work)
 	pm_qos_update_request(&priv->pm_qos_request, priv->latency);
 }
 
-#ifdef CONFIG_SERIAL_8250_DMA
-static int omap_8250_dma_handle_irq(struct uart_port *port);
-#endif
+static int omap_8250_dma_handle_irq(struct uart_port *port, unsigned int iir);
 
 static irqreturn_t omap8250_irq(int irq, void *dev_id)
 {
@@ -571,21 +581,19 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 	unsigned int iir;
 	int ret;
 
-#ifdef CONFIG_SERIAL_8250_DMA
-	if (up->dma) {
-		ret = omap_8250_dma_handle_irq(port);
-		return IRQ_RETVAL(ret);
-	}
-#endif
-
 	serial8250_rpm_get(up);
 	iir = serial_port_in(port, UART_IIR);
-	ret = serial8250_handle_irq(port, iir);
+	if (up->dma)
+		ret = omap_8250_dma_handle_irq(port, iir);
+	else
+		ret = serial8250_handle_irq(port, iir);
 	serial8250_rpm_put(up);
 
 	return IRQ_RETVAL(ret);
 }
 
+static int omap_8250_rx_dma_setup(struct uart_8250_port *p);
+
 static int omap_8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -608,7 +616,11 @@ static int omap_8250_startup(struct uart_port *port)
 	up->lsr_saved_flags = 0;
 	up->msr_saved_flags = 0;
 
+#ifdef CONFIG_SERIAL_8250_DMA
 	if (up->dma) {
+		/* watchdog timer not used until a baud rate is set */
+		priv->rx_dma_wd_ready = 0;
+
 		ret = serial8250_request_dma(up);
 		if (ret) {
 			dev_warn_ratelimited(port->dev,
@@ -616,6 +628,7 @@ static int omap_8250_startup(struct uart_port *port)
 			up->dma = NULL;
 		}
 	}
+#endif
 
 	ret = request_irq(port->irq, omap8250_irq, IRQF_SHARED,
 			  dev_name(port->dev), port);
@@ -636,7 +649,7 @@ static int omap_8250_startup(struct uart_port *port)
 	serial_out(up, UART_OMAP_WER, priv->wer);
 
 	if (up->dma)
-		up->dma->rx_dma(up, 0);
+		omap_8250_rx_dma_setup(up);
 
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
@@ -648,6 +661,8 @@ err:
 	return ret;
 }
 
+static void omap_8250_rx_dma_teardown(struct uart_8250_port *p);
+
 static void omap_8250_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -655,7 +670,7 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 	flush_work(&priv->qos_work);
 	if (up->dma)
-		up->dma->rx_dma(up, UART_IIR_RX_TIMEOUT);
+		omap_8250_rx_dma_teardown(up);
 
 	pm_runtime_get_sync(port->dev);
 
@@ -714,142 +729,231 @@ static void omap_8250_unthrottle(struct uart_port *port)
 	pm_runtime_put_autosuspend(port->dev);
 }
 
+static inline int rx_period_align(int val)
+{
+	return (val + (RX_TRIGGER - (val % RX_TRIGGER)));
+}
+
 #ifdef CONFIG_SERIAL_8250_DMA
-static int omap_8250_rx_dma(struct uart_8250_port *p, unsigned int iir);
+static void update_rx_dma_wd(struct omap8250_priv *priv)
+{
+	if (!priv->rx_dma_wd_ready)
+		return;
+
+	hrtimer_start(&priv->rx_dma_wd, priv->rx_half_fill_time,
+		      HRTIMER_MODE_REL);
+}
 
-static void __dma_rx_do_complete(struct uart_8250_port *p, bool error)
+static int dma_rx_pos(struct uart_8250_dma *dma)
+{
+	struct dma_tx_state state;
+
+	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	if (state.residue == 0)
+		return 0;
+	return (dma->rx_size - state.residue);
+}
+
+static enum hrtimer_restart omap8250_rx_dma_wd(struct hrtimer *timer)
+{
+	struct omap8250_priv *priv = container_of(timer, struct omap8250_priv,
+						  rx_dma_wd);
+	struct uart_8250_port *p = serial8250_get_port(priv->line);
+	struct uart_8250_dma *dma = &priv->omap8250_dma;
+	int ret = HRTIMER_RESTART;
+	ktime_t expires;
+	ktime_t diff;
+	ktime_t now;
+
+	spin_lock(&priv->rx_dma_lock);
+
+	expires = hrtimer_get_expires(timer);
+	now = hrtimer_cb_get_time(timer);
+
+	diff = ktime_sub(now, expires);
+
+	/* if timer latency is greater than 50%, we possibly overflowed */
+	if (ktime_compare(diff, priv->rx_half_fill_time) > 0)
+		p->port.icount.buf_overrun++;
+
+	if (dma_rx_pos(dma) != dma->rx_pos) {
+		dmaengine_pause(dma->rxchan);
+		ret = HRTIMER_NORESTART;
+	} else {
+		hrtimer_forward_now(&priv->rx_dma_wd, priv->rx_half_fill_time);
+	}
+
+	spin_unlock(&priv->rx_dma_lock);
+
+	return ret;
+}
+
+static void dma_rx_copy_buffer(struct uart_8250_port *p, bool update_wdog)
 {
 	struct omap8250_priv	*priv = p->port.private_data;
 	struct uart_8250_dma    *dma = p->dma;
 	struct tty_port         *tty_port = &p->port.state->port;
-	struct dma_tx_state     state;
-	int                     count;
+	int			in_progress;
 	unsigned long		flags;
 	int			ret;
-
-	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
-				dma->rx_size, DMA_FROM_DEVICE);
+	int			pos;
 
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
 
-	if (!dma->rx_running)
-		goto unlock;
+	if (update_wdog)
+		update_rx_dma_wd(priv);
 
-	dma->rx_running = 0;
-	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
-	dmaengine_terminate_all(dma->rxchan);
+	pos = dma_rx_pos(dma);
+
+	/*
+	 * Ignore DMA data in progress. A new interrupt
+	 * will be generated when it is completed.
+	 */
+	in_progress = pos % RX_TRIGGER;
+	if (in_progress)
+		pos -= in_progress;
 
-	count = dma->rx_size - state.residue;
+	if (pos == dma->rx_pos)
+		goto out;
 
-	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
+	if (pos > dma->rx_pos) {
+		dma_sync_single_for_cpu(dma->rxchan->device->dev,
+					dma->rx_addr + dma->rx_pos,
+					pos - dma->rx_pos, DMA_FROM_DEVICE);
+	} else {
+		dma_sync_single_for_cpu(dma->rxchan->device->dev,
+					dma->rx_addr + dma->rx_pos,
+					dma->rx_size - dma->rx_pos,
+					DMA_FROM_DEVICE);
+		if (pos > 0) {
+			dma_sync_single_for_cpu(dma->rxchan->device->dev,
+						dma->rx_addr, pos,
+						DMA_FROM_DEVICE);
+		}
+	}
 
-	p->port.icount.rx += ret;
-	p->port.icount.buf_overrun += count - ret;
-unlock:
-	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
+	while (dma->rx_pos != pos) {
+		ret = tty_insert_flip_string(tty_port,
+					     dma->rx_buf + dma->rx_pos,
+					     RX_TRIGGER);
 
-	if (!error)
-		omap_8250_rx_dma(p, 0);
+		p->port.icount.rx += ret;
+		p->port.icount.buf_overrun += RX_TRIGGER - ret;
+
+		dma->rx_pos += RX_TRIGGER;
+		if (dma->rx_pos == dma->rx_size)
+			dma->rx_pos = 0;
+	}
 
 	tty_flip_buffer_push(tty_port);
+out:
+	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
 }
 
 static void __dma_rx_complete(void *param)
 {
-	__dma_rx_do_complete(param, false);
+	dma_rx_copy_buffer(param, true);
 }
 
-static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
+/*
+ * realloc_rx_dma_buf - Ensure the current DMA ring buffer is large enough to
+ *     fit 1 second of continuous data at the specified baud rate. If the DMA
+ *     ring buffer is not large enough for this, reallocate a DMA ring buffer
+ *     that is. This function also adjusts the watchdog timer interval so that
+ *     it triggers at 50% ring buffer full for continuous data at the
+ *     specified baud rate.
+ */
+static void realloc_rx_dma_buf(struct uart_8250_port *p, unsigned int baud)
 {
-	struct omap8250_priv	*priv = p->port.private_data;
-	struct uart_8250_dma	*dma = p->dma;
-	unsigned long		flags;
-	int ret;
+	struct omap8250_priv *priv = p->port.private_data;
+	struct uart_8250_dma *dma = p->dma;
+	int do_dma_setup = 0;
+	dma_addr_t rx_addr;
+	unsigned long val;
+	size_t rx_size;
+	void *rx_buf;
+
+	/* ring buffer should hold at least 1 second of data */
+	rx_size = rx_period_align(baud / 8);
+
+	/* we are only interested in size increases */
+	if (rx_size <= dma->rx_size)
+		goto out;
 
-	spin_lock_irqsave(&priv->rx_dma_lock, flags);
+	rx_buf = dma_alloc_coherent(dma->rxchan->device->dev, rx_size,
+				    &rx_addr, GFP_KERNEL);
+	if (!rx_buf)
+		goto out;
 
-	if (!dma->rx_running) {
-		spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
-		return;
-	}
+	/* temporarily stop DMA to switch ring buffers */
+	omap_8250_rx_dma_teardown(p);
 
-	ret = dmaengine_pause(dma->rxchan);
-	if (WARN_ON_ONCE(ret))
-		priv->rx_dma_broken = true;
+	dma_free_coherent(dma->rxchan->device->dev, dma->rx_size,
+			  dma->rx_buf, dma->rx_addr);
 
-	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
+	dma->rx_addr = rx_addr;
+	dma->rx_buf = rx_buf;
+	dma->rx_size = rx_size;
 
-	__dma_rx_do_complete(p, true);
+	/* setup DMA again */
+	do_dma_setup = 1;
+out:
+	/* determine time for 50% ring buffer full (in ms) */
+	val = ((MSEC_PER_SEC / 2) * dma->rx_size) / rx_size;
+	/* convert time to relative ktime */
+	priv->rx_half_fill_time = ktime_set(val / MSEC_PER_SEC,
+					(val % MSEC_PER_SEC) * NSEC_PER_MSEC);
+	priv->rx_dma_wd_ready = 1;
+
+	if (do_dma_setup)
+		omap_8250_rx_dma_setup(p);
+	else
+		update_rx_dma_wd(priv);
 }
 
-static int omap_8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
+static int omap_8250_rx_dma_setup(struct uart_8250_port *p)
 {
 	struct omap8250_priv		*priv = p->port.private_data;
-	struct uart_8250_dma            *dma = p->dma;
+	struct uart_8250_dma		*dma = p->dma;
 	int				err = 0;
-	struct dma_async_tx_descriptor  *desc;
-	unsigned long			flags;
-
-	switch (iir & 0x3f) {
-	case UART_IIR_RLSI:
-		/* 8250_core handles errors and break interrupts */
-		omap_8250_rx_dma_flush(p);
-		return -EIO;
-	case UART_IIR_RX_TIMEOUT:
-		/*
-		 * If RCVR FIFO trigger level was not reached, complete the
-		 * transfer and let 8250_core copy the remaining data.
-		 */
-		omap_8250_rx_dma_flush(p);
-		return -ETIMEDOUT;
-	case UART_IIR_RDI:
-		/*
-		 * The OMAP UART is a special BEAST. If we receive RDI we _have_
-		 * a DMA transfer programmed but it didn't work. One reason is
-		 * that we were too slow and there were too many bytes in the
-		 * FIFO, the UART counted wrong and never kicked the DMA engine
-		 * to do anything. That means once we receive RDI on OMAP then
-		 * the DMA won't do anything soon so we have to cancel the DMA
-		 * transfer and purge the FIFO manually.
-		 */
-		omap_8250_rx_dma_flush(p);
-		return -ETIMEDOUT;
-
-	default:
-		break;
-	}
-
-	if (priv->rx_dma_broken)
-		return -EINVAL;
+	struct dma_async_tx_descriptor	*desc;
 
-	spin_lock_irqsave(&priv->rx_dma_lock, flags);
+	hrtimer_init(&priv->rx_dma_wd, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	priv->rx_dma_wd.function = omap8250_rx_dma_wd;
 
-	if (dma->rx_running)
-		goto out;
+	desc = dmaengine_prep_dma_cyclic(dma->rxchan, dma->rx_addr,
+					 dma->rx_size, RX_TRIGGER,
+					 DMA_DEV_TO_MEM,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return -EBUSY;
 
-	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
-					   dma->rx_size, DMA_DEV_TO_MEM,
-					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc) {
-		err = -EBUSY;
-		goto out;
-	}
-
-	dma->rx_running = 1;
 	desc->callback = __dma_rx_complete;
 	desc->callback_param = p;
 
+	dma->rx_pos = 0;
 	dma->rx_cookie = dmaengine_submit(desc);
 
 	dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
 				   dma->rx_size, DMA_FROM_DEVICE);
 
+	update_rx_dma_wd(priv);
 	dma_async_issue_pending(dma->rxchan);
-out:
-	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
+
 	return err;
 }
 
+static void omap_8250_rx_dma_teardown(struct uart_8250_port *p)
+{
+	struct omap8250_priv	*priv = p->port.private_data;
+	struct uart_8250_dma	*dma = p->dma;
+
+	dmaengine_pause(dma->rxchan);
+	hrtimer_cancel(&priv->rx_dma_wd);
+	dma_rx_copy_buffer(p, false);
+	dmaengine_terminate_all(dma->rxchan);
+}
+
 static int omap_8250_tx_dma(struct uart_8250_port *p);
 
 static void omap_8250_dma_tx_complete(void *param)
@@ -1000,39 +1104,54 @@ err:
  * hoook for RX/TX and need different logic for them in the ISR. Therefore we
  * use the default routine in the non-DMA case and this one for with DMA.
  */
-static int omap_8250_dma_handle_irq(struct uart_port *port)
+static int omap_8250_dma_handle_irq(struct uart_port *port, unsigned int iir)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	struct omap8250_priv *priv = up->port.private_data;
+	struct uart_8250_dma *dma = up->dma;
 	unsigned char status;
-	unsigned long flags;
-	u8 iir;
-	int dma_err = 0;
-
-	serial8250_rpm_get(up);
+	int dma_err;
 
-	iir = serial_port_in(port, UART_IIR);
-	if (iir & UART_IIR_NO_INT) {
-		serial8250_rpm_put(up);
+	if (iir & UART_IIR_NO_INT)
 		return 0;
-	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	status = serial_port_in(port, UART_LSR);
 
 	if (status & (UART_LSR_DR | UART_LSR_BI)) {
 
-		dma_err = omap_8250_rx_dma(up, iir);
-		if (dma_err) {
-			status = serial8250_rx_chars(up, status, NULL);
-			omap_8250_rx_dma(up, 0);
+		switch (iir & 0x3f) {
+		case UART_IIR_RLSI:
+		case UART_IIR_RX_TIMEOUT:
+			/* pause the DMA */
+			dmaengine_pause(dma->rxchan);
+			hrtimer_cancel(&priv->rx_dma_wd);
+
+			/* get any data in the DMA buffer */
+			dma_rx_copy_buffer(up, false);
+
+			/*
+			 * Empty the FIFO using PIO. We pass a lock in
+			 * order to synchronize tty_flip_buffer_push()
+			 * against the rx dma callback.
+			 */
+			status = serial8250_rx_chars(up, status,
+						     &priv->rx_dma_lock);
+
+			/* resume the DMA */
+			if (priv->habit & OMAP_DMA_RX_RESUME_STARTOVER)
+				dma->rx_pos = 0;
+			update_rx_dma_wd(priv);
+			dmaengine_resume(dma->rxchan);
+			break;
 		}
 	}
 	serial8250_modem_status(up);
-	if (status & UART_LSR_THRE && up->dma->tx_err) {
+	if (status & UART_LSR_THRE && dma->tx_err) {
 		if (uart_tx_stopped(&up->port) ||
 		    uart_circ_empty(&up->port.state->xmit)) {
-			up->dma->tx_err = 0;
+			dma->tx_err = 0;
 			serial8250_tx_chars(up);
 		} else  {
 			/*
@@ -1045,8 +1164,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 		}
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
-	serial8250_rpm_put(up);
+	spin_unlock(&port->lock);
 	return 1;
 }
 
@@ -1057,10 +1175,28 @@ static bool the_no_dma_filter_fn(struct dma_chan *chan, void *param)
 
 #else
 
-static inline int omap_8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
+static inline void dma_rx_copy_buffer(struct uart_8250_port *p)
+{
+}
+
+static inline void realloc_rx_dma_buf(struct uart_8250_port *p,
+				      unsigned int baud)
+{
+}
+
+static inline int omap_8250_rx_dma_setup(struct uart_8250_port *p)
 {
 	return -EINVAL;
 }
+
+static inline void omap_8250_rx_dma_teardown(struct uart_8250_port *p)
+{
+}
+
+static int omap_8250_dma_handle_irq(struct uart_port *port, unsigned int iir)
+{
+	return 0;
+}
 #endif
 
 static int omap8250_no_handle_irq(struct uart_port *port)
@@ -1181,8 +1317,6 @@ static int omap8250_probe(struct platform_device *pdev)
 			   priv->latency);
 	INIT_WORK(&priv->qos_work, omap8250_uart_qos_work);
 
-	spin_lock_init(&priv->rx_dma_lock);
-
 	device_init_wakeup(&pdev->dev, true);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
@@ -1195,6 +1329,8 @@ static int omap8250_probe(struct platform_device *pdev)
 	omap_serial_fill_features_erratas(&up, priv);
 	up.port.handle_irq = omap8250_no_handle_irq;
 #ifdef CONFIG_SERIAL_8250_DMA
+	spin_lock_init(&priv->rx_dma_lock);
+
 	if (pdev->dev.of_node) {
 		/*
 		 * Oh DMA support. If there are no DMA properties in the DT then
@@ -1206,21 +1342,47 @@ static int omap8250_probe(struct platform_device *pdev)
 		 */
 		ret = of_property_count_strings(pdev->dev.of_node, "dma-names");
 		if (ret == 2) {
+			struct platform_device *dma_pdev;
+			struct device_node *dma_np;
+			struct device_node *np;
+
 			up.dma = &priv->omap8250_dma;
 			priv->omap8250_dma.fn = the_no_dma_filter_fn;
 			priv->omap8250_dma.tx_dma = omap_8250_tx_dma;
-			priv->omap8250_dma.rx_dma = omap_8250_rx_dma;
-			priv->omap8250_dma.rx_size = RX_TRIGGER;
+			/* default ring buffer setup for B230400 */
+			priv->omap8250_dma.rx_size =
+						rx_period_align(230400 / 8);
 			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
 			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
 
 			if (of_machine_is_compatible("ti,am33xx"))
 				priv->habit |= OMAP_DMA_TX_KICK;
+
 			/*
-			 * pause is currently not supported atleast on omap-sdma
-			 * and edma on most earlier kernels.
+			 * The sDMA driver will not resume from the same
+			 * buffer position that it had after pause. It will
+			 * start from the beginning of the buffer each time.
 			 */
-			priv->rx_dma_broken = true;
+			dma_np = of_parse_phandle(pdev->dev.of_node, "dmas", 0);
+			if (dma_np) {
+				/* resolve possible dma router */
+				np = of_parse_phandle(dma_np, "dma-masters", 0);
+				if (np) {
+					of_node_put(dma_np);
+					dma_np = np;
+				}
+
+				/* set habit if we are using sDMA driver */
+				dma_pdev = of_find_device_by_node(dma_np);
+				if (dma_pdev && dma_pdev->dev.driver &&
+				    strcmp(dma_pdev->dev.driver->name,
+					   "omap-dma-engine") == 0) {
+					priv->habit |=
+						OMAP_DMA_RX_RESUME_STARTOVER;
+				}
+
+				of_node_put(dma_np);
+			}
 		}
 	}
 #endif
@@ -1367,7 +1529,7 @@ static int omap8250_runtime_suspend(struct device *dev)
 	}
 
 	if (up->dma && up->dma->rxchan)
-		omap_8250_rx_dma(up, UART_IIR_RX_TIMEOUT);
+		omap_8250_rx_dma_teardown(up);
 
 	priv->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
 	schedule_work(&priv->qos_work);
@@ -1392,7 +1554,7 @@ static int omap8250_runtime_resume(struct device *dev)
 		omap8250_restore_regs(up);
 
 	if (up->dma && up->dma->rxchan)
-		omap_8250_rx_dma(up, 0);
+		omap_8250_rx_dma_setup(up);
 
 	priv->latency = priv->calc_latency;
 	schedule_work(&priv->qos_work);
-- 
1.7.10.4
