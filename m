From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 7/7] tty: serial: imx: split all dma setup operations out of 'port.lock' protector
Date: Thu, 14 Jun 2018 22:03:02 +0800
Message-ID: <1528984982-5074-8-git-send-email-yibin.gong@nxp.com>
References: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de, dan.j.williams@intel.com, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

After sdma driver change to virt-dma, all bds will be allocated
dynamically with 'port.lock' acquired instead of statically allocated
before. That means the lock sequence is 'port.lock' -> 'fs_reclaim_acquire'
.But in case uart rx/tx dma callback coming after other kernel code which
have already acquired 'fs_reclaim_acquire' lock, which means the above lock
sequence reverted as 'fs_reclaim_acquire' -> 'port.lock'(acquired in uart
dma callback), thus, lockdep warning comes as beow. Actually don't need to
spinlock all DMA operations in UART driver with 'port.lock', because dma
driver can wipe off race condition by commone virt-dma lock . Split all dma
operations out of the code areas which protected by 'port.lock'.

[   46.155406] =====================================================
[   46.161503] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[   46.168122] 4.17.0-rc6-00008-g7caafa3-dirty #48 Not tainted
[   46.173696] -----------------------------------------------------
[   46.179795] mxc_uart_stress/419 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[   46.186934] fa7c1440 (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part.3+0x0/0x48
[   46.194270]
[   46.194270] and this task is already holding:
[   46.200106] 09a17fda (&port_lock_key){-.-.}, at: uart_write+0x84/0x190
[   46.206658] which would create a new lock dependency:
[   46.211710]  (&port_lock_key){-.-.} -> (fs_reclaim){+.+.}
[   46.217132]
[   46.217132] but this new dependency connects a HARDIRQ-irq-safe lock:
[   46.225051]  (&port_lock_key){-.-.}
[   46.225062]
[   46.225062] ... which became HARDIRQ-irq-safe at:
[   46.234740]   lock_acquire+0x70/0x90
[   46.238326]   _raw_spin_lock_irqsave+0x40/0x54
[   46.242777]   imx_uart_console_write+0x1bc/0x1e0
[   46.247402]   console_unlock+0x320/0x5f0
[   46.251329]   vprintk_emit+0x22c/0x3fc
[   46.255082]   vprintk_default+0x28/0x30
[   46.258923]   vprintk_func+0x78/0xcc
[   46.262503]   printk+0x34/0x54
[   46.265566]   crng_fast_load+0xf8/0x138
[   46.269407]   add_interrupt_randomness+0x21c/0x24c
[   46.274204]   handle_irq_event_percpu+0x40/0x84
[   46.278739]   handle_irq_event+0x40/0x64
[   46.282667]   handle_fasteoi_irq+0xbc/0x178
[   46.286854]   generic_handle_irq+0x28/0x3c
[   46.290954]   __handle_domain_irq+0x6c/0xe8
[   46.295148]   gic_handle_irq+0x64/0xc4
[   46.298904]   __irq_svc+0x70/0x98
[   46.302225]   _raw_spin_unlock_irq+0x30/0x34
[   46.306505]   finish_task_switch+0xc0/0x27c
[   46.310693]   __schedule+0x2c0/0x79c
[   46.314272]   schedule_idle+0x40/0x84
[   46.317941]   do_idle+0x178/0x2b4
[   46.321259]   cpu_startup_entry+0x20/0x24
[   46.325278]   rest_init+0x214/0x264
[   46.328775]   start_kernel+0x39c/0x424
[   46.332527]     (null)
[   46.334891]
[   46.334891] to a HARDIRQ-irq-unsafe lock:
[   46.340379]  (fs_reclaim){+.+.}
[   46.340391]
[   46.340391] ... which became HARDIRQ-irq-unsafe at:
[   46.349885] ...
[   46.349895]   lock_acquire+0x70/0x90
[   46.355225]   fs_reclaim_acquire.part.3+0x38/0x48
[   46.359933]   fs_reclaim_acquire+0x1c/0x20
[   46.364036]   kmem_cache_alloc+0x2c/0x174
[   46.368051]   alloc_worker.constprop.10+0x1c/0x58
[   46.372759]   init_rescuer.part.4+0x18/0xa4
[   46.376952]   workqueue_init+0xc0/0x210
[   46.380793]   kernel_init_freeable+0x58/0x1d8
[   46.385156]   kernel_init+0x10/0x11c
[   46.388736]   ret_from_fork+0x14/0x20
[   46.392399]     (null)
[   46.394762]
[   46.394762] other info that might help us debug this:
[   46.394762]
[   46.402769]  Possible interrupt unsafe locking scenario:
[   46.402769]
[   46.409560]        CPU0                    CPU1
[   46.414092]        ----                    ----
[   46.418622]   lock(fs_reclaim);
[   46.421772]                                local_irq_disable();
[   46.427693]                                lock(&port_lock_key);
[   46.433707]                                lock(fs_reclaim);
[   46.439372]   <Interrupt>
[   46.441993]     lock(&port_lock_key);
[   46.445661]
[   46.445661]  *** DEADLOCK ***
[   46.445661]

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/tty/serial/imx.c | 97 ++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b83bc2c..f2a2966 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -223,6 +223,7 @@ struct imx_port {
 	dma_cookie_t		rx_cookie;
 	unsigned int		tx_bytes;
 	unsigned int		dma_tx_nents;
+	struct work_struct	tsk_dma_tx;
 	unsigned int            saved_reg[10];
 	bool			context_saved;
 };
@@ -491,8 +492,6 @@ static void imx_uart_enable_ms(struct uart_port *port)
 	mctrl_gpio_enable_ms(sport->gpios);
 }
 
-static void imx_uart_dma_tx(struct imx_port *sport);
-
 /* called with port.lock taken and irqs off */
 static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 {
@@ -524,7 +523,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 			imx_uart_writel(sport, ucr1, UCR1);
 		} else {
 			imx_uart_writel(sport, ucr1, UCR1);
-			imx_uart_dma_tx(sport);
+			schedule_work(&sport->tsk_dma_tx);
 		}
 
 		return;
@@ -574,7 +573,7 @@ static void imx_uart_dma_tx_callback(void *data)
 		uart_write_wakeup(&sport->port);
 
 	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
-		imx_uart_dma_tx(sport);
+		schedule_work(&sport->tsk_dma_tx);
 	else if (sport->port.rs485.flags & SER_RS485_ENABLED) {
 		u32 ucr4 = imx_uart_readl(sport, UCR4);
 		ucr4 |= UCR4_TCEN;
@@ -584,19 +583,21 @@ static void imx_uart_dma_tx_callback(void *data)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
-/* called with port.lock taken and irqs off */
-static void imx_uart_dma_tx(struct imx_port *sport)
+static void dma_tx_work(struct work_struct *w)
 {
+	struct imx_port *sport = container_of(w, struct imx_port, tsk_dma_tx);
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	struct scatterlist *sgl = sport->tx_sgl;
 	struct dma_async_tx_descriptor *desc;
 	struct dma_chan	*chan = sport->dma_chan_tx;
 	struct device *dev = sport->port.dev;
+	unsigned long flags;
 	u32 ucr1, ucr4;
 	int ret;
 
+	spin_lock_irqsave(&sport->port.lock, flags);
 	if (sport->dma_is_txing)
-		return;
+		goto work_out;
 
 	ucr4 = imx_uart_readl(sport, UCR4);
 	ucr4 &= ~UCR4_TCEN;
@@ -604,45 +605,51 @@ static void imx_uart_dma_tx(struct imx_port *sport)
 
 	sport->tx_bytes = uart_circ_chars_pending(xmit);
 
-	if (xmit->tail < xmit->head) {
-		sport->dma_tx_nents = 1;
-		sg_init_one(sgl, xmit->buf + xmit->tail, sport->tx_bytes);
-	} else {
-		sport->dma_tx_nents = 2;
-		sg_init_table(sgl, 2);
-		sg_set_buf(sgl, xmit->buf + xmit->tail,
-				UART_XMIT_SIZE - xmit->tail);
-		sg_set_buf(sgl + 1, xmit->buf, xmit->head);
-	}
+	if (sport->tx_bytes > 0) {
+		if (xmit->tail < xmit->head) {
+			sport->dma_tx_nents = 1;
+			sg_init_one(sgl, xmit->buf + xmit->tail,
+					sport->tx_bytes);
+		} else {
+			sport->dma_tx_nents = 2;
+			sg_init_table(sgl, 2);
+			sg_set_buf(sgl, xmit->buf + xmit->tail,
+					UART_XMIT_SIZE - xmit->tail);
+			sg_set_buf(sgl + 1, xmit->buf, xmit->head);
+		}
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	ret = dma_map_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
-	if (ret == 0) {
-		dev_err(dev, "DMA mapping error for TX.\n");
-		return;
-	}
-	desc = dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
+		ret = dma_map_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
+		if (ret == 0) {
+			dev_err(dev, "DMA mapping error for TX.\n");
+			return;
+		}
+		desc = dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
 					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
-	if (!desc) {
-		dma_unmap_sg(dev, sgl, sport->dma_tx_nents,
-			     DMA_TO_DEVICE);
-		dev_err(dev, "We cannot prepare for the TX slave dma!\n");
-		return;
-	}
-	desc->callback = imx_uart_dma_tx_callback;
-	desc->callback_param = sport;
+		if (!desc) {
+			dma_unmap_sg(dev, sgl, sport->dma_tx_nents,
+				     DMA_TO_DEVICE);
+			dev_err(dev, "We cannot prepare for the TX slave dma!\n");
+			return;
+		}
+		desc->callback = imx_uart_dma_tx_callback;
+		desc->callback_param = sport;
 
-	dev_dbg(dev, "TX: prepare to send %lu bytes by DMA.\n",
-			uart_circ_chars_pending(xmit));
+		dev_dbg(dev, "TX: prepare to send %lu bytes by DMA.\n",
+				uart_circ_chars_pending(xmit));
 
-	ucr1 = imx_uart_readl(sport, UCR1);
-	ucr1 |= UCR1_TXDMAEN;
-	imx_uart_writel(sport, ucr1, UCR1);
+		ucr1 = imx_uart_readl(sport, UCR1);
+		ucr1 |= UCR1_TXDMAEN;
+		imx_uart_writel(sport, ucr1, UCR1);
 
-	/* fire it */
-	sport->dma_is_txing = 1;
-	dmaengine_submit(desc);
-	dma_async_issue_pending(chan);
-	return;
+		/* fire it */
+		sport->dma_is_txing = 1;
+		dmaengine_submit(desc);
+		dma_async_issue_pending(chan);
+		return;
+	}
+work_out:
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 /* called with port.lock taken and irqs off */
@@ -696,7 +703,7 @@ static void imx_uart_start_tx(struct uart_port *port)
 
 		if (!uart_circ_empty(&port->state->xmit) &&
 		    !uart_tx_stopped(port))
-			imx_uart_dma_tx(sport);
+			schedule_work(&sport->tsk_dma_tx);
 		return;
 	}
 }
@@ -1405,7 +1412,9 @@ static int imx_uart_startup(struct uart_port *port)
 	 */
 	imx_uart_enable_ms(&sport->port);
 
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 	if (dma_is_inited) {
+		INIT_WORK(&sport->tsk_dma_tx, dma_tx_work);
 		imx_uart_enable_dma(sport);
 		imx_uart_start_rx_dma(sport);
 	} else {
@@ -1418,8 +1427,6 @@ static int imx_uart_startup(struct uart_port *port)
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
-
 	return 0;
 }
 
@@ -1435,6 +1442,8 @@ static void imx_uart_shutdown(struct uart_port *port)
 		dmaengine_terminate_sync(sport->dma_chan_tx);
 		dmaengine_terminate_sync(sport->dma_chan_rx);
 
+		cancel_work_sync(&sport->tsk_dma_tx);
+
 		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_uart_stop_tx(port);
 		imx_uart_stop_rx(port);
-- 
2.7.4
