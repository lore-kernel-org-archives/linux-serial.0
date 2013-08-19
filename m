From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 14/25] tty: serial: mfd: drop uart_port->lock before calling tty_flip_buffer_push()
Date: Mon, 19 Aug 2013 20:14:18 +0530
Message-ID: <2cabe7e222cb0b322face31767ed0f4321697862.1376923198.git.viresh.kumar@linaro.org>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:56725 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3HSOqS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Aug 2013 10:46:18 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so4685815pab.13
        for <linux-serial@vger.kernel.org>; Mon, 19 Aug 2013 07:46:18 -0700 (PDT)
In-Reply-To: <cover.1376923198.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376923198.git.viresh.kumar@linaro.org>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

The current driver triggers a lockdep warning for if tty_flip_buffer_push() is
called with uart_port->lock locked. This never shows up on UP kernels and comes
up only on SMP kernels.

Crash looks like this (produced with samsung.c driver):

-----
[<c0014d58>] (unwind_backtrace+0x0/0xf8) from [<c0011908>] (show_stack+0x10/0x14)
[<c0011908>] (show_stack+0x10/0x14) from [<c035da34>] (dump_stack+0x6c/0xac)
[<c035da34>] (dump_stack+0x6c/0xac) from [<c01b59ac>] (do_raw_spin_unlock+0xc4/0xd8)
[<c01b59ac>] (do_raw_spin_unlock+0xc4/0xd8) from [<c03627e4>] (_raw_spin_unlock_irqrestore+0xc/0)
[<c03627e4>] (_raw_spin_unlock_irqrestore+0xc/0x38) from [<c020a1a8>] (s3c24xx_serial_rx_chars+0)
[<c020a1a8>] (s3c24xx_serial_rx_chars+0x12c/0x260) from [<c020aae8>] (s3c64xx_serial_handle_irq+)
[<c020aae8>] (s3c64xx_serial_handle_irq+0x48/0x60) from [<c006aaa0>] (handle_irq_event_percpu+0x)
[<c006aaa0>] (handle_irq_event_percpu+0x50/0x194) from [<c006ac20>] (handle_irq_event+0x3c/0x5c)
[<c006ac20>] (handle_irq_event+0x3c/0x5c) from [<c006d864>] (handle_fasteoi_irq+0x80/0x13c)
[<c006d864>] (handle_fasteoi_irq+0x80/0x13c) from [<c006a4a4>] (generic_handle_irq+0x20/0x30)
[<c006a4a4>] (generic_handle_irq+0x20/0x30) from [<c000f454>] (handle_IRQ+0x38/0x94)
[<c000f454>] (handle_IRQ+0x38/0x94) from [<c0008538>] (gic_handle_irq+0x34/0x68)
[<c0008538>] (gic_handle_irq+0x34/0x68) from [<c00123c0>] (__irq_svc+0x40/0x70)
Exception stack(0xc04cdf70 to 0xc04cdfb8)
df60:                                     00000000 00000000 0000166e 00000000
df80: c04cc000 c050278f c050278f 00000001 c04d444c 410fc0f4 c03649b0 00000000
dfa0: 00000001 c04cdfb8 c000f758 c000f75c 60070013 ffffffff
[<c00123c0>] (__irq_svc+0x40/0x70) from [<c000f75c>] (arch_cpu_idle+0x28/0x30)
[<c000f75c>] (arch_cpu_idle+0x28/0x30) from [<c0054888>] (cpu_startup_entry+0x5c/0x148)
[<c0054888>] (cpu_startup_entry+0x5c/0x148) from [<c0497aa4>] (start_kernel+0x334/0x38c)
BUG: spinlock lockup suspected on CPU#0, kworker/0:1/360
 lock: s3c24xx_serial_ports+0x1d8/0x370, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
CPU: 0 PID: 360 Comm: kworker/0:1 Not tainted 3.11.0-rc6-next-20130819-00003-g75485f1 #2
Workqueue: events flush_to_ldisc
[<c0014d58>] (unwind_backtrace+0x0/0xf8) from [<c0011908>] (show_stack+0x10/0x14)
[<c0011908>] (show_stack+0x10/0x14) from [<c035da34>] (dump_stack+0x6c/0xac)
[<c035da34>] (dump_stack+0x6c/0xac) from [<c01b581c>] (do_raw_spin_lock+0x100/0x17c)
[<c01b581c>] (do_raw_spin_lock+0x100/0x17c) from [<c03628a0>] (_raw_spin_lock_irqsave+0x20/0x28)
[<c03628a0>] (_raw_spin_lock_irqsave+0x20/0x28) from [<c0203224>] (uart_start+0x18/0x34)
[<c0203224>] (uart_start+0x18/0x34) from [<c01ef890>] (__receive_buf+0x4b4/0x738)
[<c01ef890>] (__receive_buf+0x4b4/0x738) from [<c01efb44>] (n_tty_receive_buf2+0x30/0x98)
[<c01efb44>] (n_tty_receive_buf2+0x30/0x98) from [<c01f2ba8>] (flush_to_ldisc+0xec/0x138)
[<c01f2ba8>] (flush_to_ldisc+0xec/0x138) from [<c0031af0>] (process_one_work+0xfc/0x348)
[<c0031af0>] (process_one_work+0xfc/0x348) from [<c0032138>] (worker_thread+0x138/0x37c)
[<c0032138>] (worker_thread+0x138/0x37c) from [<c0037a7c>] (kthread+0xa4/0xb0)
[<c0037a7c>] (kthread+0xa4/0xb0) from [<c000e5f8>] (ret_from_fork+0x14/0x3c)
-----

Release the port lock before calling tty_flip_buffer_push() and reacquire it
after the call.

Similar stuff was already done for few other drivers in the past, like:

commit 2389b272168ceec056ca1d8a870a97fa9c26e11a
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue May 29 21:53:50 2007 +0100

    [ARM] 4417/1: Serial: Fix AMBA drivers locking

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/mfd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 4a82267..d3db042 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -386,7 +386,7 @@ static void serial_hsu_stop_tx(struct uart_port *port)
 
 /* This is always called in spinlock protected mode, so
  * modify timeout timer is safe here */
-void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts)
+void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts, unsigned long *flags)
 {
 	struct hsu_dma_buffer *dbuf = &up->rxbuf;
 	struct hsu_dma_chan *chan = up->rxc;
@@ -438,7 +438,9 @@ void hsu_dma_rx(struct uart_hsu_port *up, u32 int_sts)
 					 | (0x1 << 16)
 					 | (0x1 << 24)	/* timeout bit, see HSU Errata 1 */
 					 );
+	spin_unlock_irqrestore(&up->port.lock, *flags);
 	tty_flip_buffer_push(tport);
+	spin_lock_irqsave(&up->port.lock, *flags);
 
 	chan_writel(chan, HSU_CH_CR, 0x3);
 
@@ -459,7 +461,8 @@ static void serial_hsu_stop_rx(struct uart_port *port)
 	}
 }
 
-static inline void receive_chars(struct uart_hsu_port *up, int *status)
+static inline void receive_chars(struct uart_hsu_port *up, int *status,
+		unsigned long *flags)
 {
 	unsigned int ch, flag;
 	unsigned int max_count = 256;
@@ -519,7 +522,10 @@ static inline void receive_chars(struct uart_hsu_port *up, int *status)
 	ignore_char:
 		*status = serial_in(up, UART_LSR);
 	} while ((*status & UART_LSR_DR) && max_count--);
+
+	spin_unlock_irqrestore(&up->port.lock, *flags);
 	tty_flip_buffer_push(&up->port.state->port);
+	spin_lock_irqsave(&up->port.lock, *flags);
 }
 
 static void transmit_chars(struct uart_hsu_port *up)
@@ -613,7 +619,7 @@ static irqreturn_t port_irq(int irq, void *dev_id)
 
 	lsr = serial_in(up, UART_LSR);
 	if (lsr & UART_LSR_DR)
-		receive_chars(up, &lsr);
+		receive_chars(up, &lsr, &flags);
 	check_modem_status(up);
 
 	/* lsr will be renewed during the receive_chars */
@@ -643,7 +649,7 @@ static inline void dma_chan_irq(struct hsu_dma_chan *chan)
 
 	/* Rx channel */
 	if (chan->dirt == DMA_FROM_DEVICE)
-		hsu_dma_rx(up, int_sts);
+		hsu_dma_rx(up, int_sts, &flags);
 
 	/* Tx channel */
 	if (chan->dirt == DMA_TO_DEVICE) {
-- 
1.7.12.rc2.18.g61b472e

