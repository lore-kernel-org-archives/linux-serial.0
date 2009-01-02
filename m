From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 61/75] synclink_cs: Convert to tty_port
Date: Fri, 02 Jan 2009 13:48:47 +0000
Message-ID: <20090102134844.13472.85737.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37662 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755373AbZABNse (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:48:34 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Use the tty port operations, add refcounting, and refactor a bit to make the
refcounting work cleanly.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/pcmcia/synclink_cs.c |  479 ++++++++++++++-----------------------
 1 files changed, 181 insertions(+), 298 deletions(-)


diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 4d64a02..dc073e1 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -138,20 +138,15 @@ struct _input_signal_events {
  */
 
 typedef struct _mgslpc_info {
+	struct tty_port		port;
 	void *if_ptr;	/* General purpose pointer (used by SPPP) */
 	int			magic;
-	int			flags;
-	int			count;		/* count of opens */
 	int			line;
-	unsigned short		close_delay;
-	unsigned short		closing_wait;	/* time to wait before closing */
 
 	struct mgsl_icount	icount;
 
-	struct tty_struct 	*tty;
 	int			timeout;
 	int			x_char;		/* xon/xoff character */
-	int			blocked_open;	/* # of blocked opens */
 	unsigned char		read_status_mask;
 	unsigned char		ignore_status_mask;
 
@@ -170,9 +165,6 @@ typedef struct _mgslpc_info {
 	int            rx_buf_count;   /* total number of rx buffers */
 	int            rx_frame_count; /* number of full rx buffers */
 
-	wait_queue_head_t	open_wait;
-	wait_queue_head_t	close_wait;
-
 	wait_queue_head_t	status_event_wait_q;
 	wait_queue_head_t	event_wait_q;
 	struct timer_list	tx_timer;	/* HDLC transmit timeout timer */
@@ -375,7 +367,7 @@ static void irq_enable(MGSLPC_INFO *info, unsigned char channel, unsigned short
 static void rx_start(MGSLPC_INFO *info);
 static void rx_stop(MGSLPC_INFO *info);
 
-static void tx_start(MGSLPC_INFO *info);
+static void tx_start(MGSLPC_INFO *info, struct tty_struct *tty);
 static void tx_stop(MGSLPC_INFO *info);
 static void tx_set_idle(MGSLPC_INFO *info);
 
@@ -389,7 +381,8 @@ static void async_mode(MGSLPC_INFO *info);
 
 static void tx_timeout(unsigned long context);
 
-static int ioctl_common(MGSLPC_INFO *info, unsigned int cmd, unsigned long arg);
+static int carrier_raised(struct tty_port *port);
+static void raise_dtr_rts(struct tty_port *port);
 
 #if SYNCLINK_GENERIC_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
@@ -410,7 +403,7 @@ static void release_resources(MGSLPC_INFO *info);
 static void mgslpc_add_device(MGSLPC_INFO *info);
 static void mgslpc_remove_device(MGSLPC_INFO *info);
 
-static bool rx_get_frame(MGSLPC_INFO *info);
+static bool rx_get_frame(MGSLPC_INFO *info, struct tty_struct *tty);
 static void rx_reset_buffers(MGSLPC_INFO *info);
 static int  rx_alloc_buffers(MGSLPC_INFO *info);
 static void rx_free_buffers(MGSLPC_INFO *info);
@@ -421,7 +414,7 @@ static irqreturn_t mgslpc_isr(int irq, void *dev_id);
  * Bottom half interrupt handlers
  */
 static void bh_handler(struct work_struct *work);
-static void bh_transmit(MGSLPC_INFO *info);
+static void bh_transmit(MGSLPC_INFO *info, struct tty_struct *tty);
 static void bh_status(MGSLPC_INFO *info);
 
 /*
@@ -432,10 +425,10 @@ static int tiocmset(struct tty_struct *tty, struct file *file,
 		    unsigned int set, unsigned int clear);
 static int get_stats(MGSLPC_INFO *info, struct mgsl_icount __user *user_icount);
 static int get_params(MGSLPC_INFO *info, MGSL_PARAMS __user *user_params);
-static int set_params(MGSLPC_INFO *info, MGSL_PARAMS __user *new_params);
+static int set_params(MGSLPC_INFO *info, MGSL_PARAMS __user *new_params, struct tty_struct *tty);
 static int get_txidle(MGSLPC_INFO *info, int __user *idle_mode);
 static int set_txidle(MGSLPC_INFO *info, int idle_mode);
-static int set_txenable(MGSLPC_INFO *info, int enable);
+static int set_txenable(MGSLPC_INFO *info, int enable, struct tty_struct *tty);
 static int tx_abort(MGSLPC_INFO *info);
 static int set_rxenable(MGSLPC_INFO *info, int enable);
 static int wait_events(MGSLPC_INFO *info, int __user *mask);
@@ -474,7 +467,7 @@ static struct tty_driver *serial_driver;
 /* number of characters left in xmit buffer before we ask for more */
 #define WAKEUP_CHARS 256
 
-static void mgslpc_change_params(MGSLPC_INFO *info);
+static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty);
 static void mgslpc_wait_until_sent(struct tty_struct *tty, int timeout);
 
 /* PCMCIA prototypes */
@@ -517,6 +510,11 @@ static void ldisc_receive_buf(struct tty_struct *tty,
 	}
 }
 
+static const struct tty_port_operations mgslpc_port_ops = {
+	.carrier_raised = carrier_raised,
+	.raise_dtr_rts = raise_dtr_rts
+};
+
 static int mgslpc_probe(struct pcmcia_device *link)
 {
     MGSLPC_INFO *info;
@@ -532,12 +530,12 @@ static int mgslpc_probe(struct pcmcia_device *link)
     }
 
     info->magic = MGSLPC_MAGIC;
+    tty_port_init(&info->port);
+    info->port.ops = &mgslpc_port_ops;
     INIT_WORK(&info->task, bh_handler);
     info->max_frame_size = 4096;
-    info->close_delay = 5*HZ/10;
-    info->closing_wait = 30*HZ;
-    init_waitqueue_head(&info->open_wait);
-    init_waitqueue_head(&info->close_wait);
+    info->port.close_delay = 5*HZ/10;
+    info->port.closing_wait = 30*HZ;
     init_waitqueue_head(&info->status_event_wait_q);
     init_waitqueue_head(&info->event_wait_q);
     spin_lock_init(&info->lock);
@@ -784,7 +782,7 @@ static void tx_release(struct tty_struct *tty)
 
 	spin_lock_irqsave(&info->lock,flags);
 	if (!info->tx_enabled)
-	 	tx_start(info);
+	 	tx_start(info, tty);
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
@@ -823,6 +821,7 @@ static int bh_action(MGSLPC_INFO *info)
 static void bh_handler(struct work_struct *work)
 {
 	MGSLPC_INFO *info = container_of(work, MGSLPC_INFO, task);
+	struct tty_struct *tty;
 	int action;
 
 	if (!info)
@@ -833,6 +832,7 @@ static void bh_handler(struct work_struct *work)
 			__FILE__,__LINE__,info->device_name);
 
 	info->bh_running = true;
+	tty = tty_port_tty_get(&info->port);
 
 	while((action = bh_action(info)) != 0) {
 
@@ -844,10 +844,10 @@ static void bh_handler(struct work_struct *work)
 		switch (action) {
 
 		case BH_RECEIVE:
-			while(rx_get_frame(info));
+			while(rx_get_frame(info, tty));
 			break;
 		case BH_TRANSMIT:
-			bh_transmit(info);
+			bh_transmit(info, tty);
 			break;
 		case BH_STATUS:
 			bh_status(info);
@@ -859,14 +859,14 @@ static void bh_handler(struct work_struct *work)
 		}
 	}
 
+	tty_kref_put(tty);
 	if (debug_level >= DEBUG_LEVEL_BH)
 		printk( "%s(%d):bh_handler(%s) exit\n",
 			__FILE__,__LINE__,info->device_name);
 }
 
-static void bh_transmit(MGSLPC_INFO *info)
+static void bh_transmit(MGSLPC_INFO *info, struct tty_struct *tty)
 {
-	struct tty_struct *tty = info->tty;
 	if (debug_level >= DEBUG_LEVEL_BH)
 		printk("bh_transmit() entry on %s\n", info->device_name);
 
@@ -945,12 +945,11 @@ static void rx_ready_hdlc(MGSLPC_INFO *info, int eom)
 	issue_command(info, CHA, CMD_RXFIFO);
 }
 
-static void rx_ready_async(MGSLPC_INFO *info, int tcd)
+static void rx_ready_async(MGSLPC_INFO *info, int tcd, struct tty_struct *tty)
 {
 	unsigned char data, status, flag;
 	int fifo_count;
 	int work = 0;
- 	struct tty_struct *tty = info->tty;
  	struct mgsl_icount *icount = &info->icount;
 
 	if (tcd) {
@@ -1013,7 +1012,7 @@ static void rx_ready_async(MGSLPC_INFO *info, int tcd)
 }
 
 
-static void tx_done(MGSLPC_INFO *info)
+static void tx_done(MGSLPC_INFO *info, struct tty_struct *tty)
 {
 	if (!info->tx_active)
 		return;
@@ -1042,7 +1041,7 @@ static void tx_done(MGSLPC_INFO *info)
 	else
 #endif
 	{
-		if (info->tty->stopped || info->tty->hw_stopped) {
+		if (tty->stopped || tty->hw_stopped) {
 			tx_stop(info);
 			return;
 		}
@@ -1050,7 +1049,7 @@ static void tx_done(MGSLPC_INFO *info)
 	}
 }
 
-static void tx_ready(MGSLPC_INFO *info)
+static void tx_ready(MGSLPC_INFO *info, struct tty_struct *tty)
 {
 	unsigned char fifo_count = 32;
 	int c;
@@ -1062,7 +1061,7 @@ static void tx_ready(MGSLPC_INFO *info)
 		if (!info->tx_active)
 			return;
 	} else {
-		if (info->tty->stopped || info->tty->hw_stopped) {
+		if (tty->stopped || tty->hw_stopped) {
 			tx_stop(info);
 			return;
 		}
@@ -1099,7 +1098,7 @@ static void tx_ready(MGSLPC_INFO *info)
 	}
 }
 
-static void cts_change(MGSLPC_INFO *info)
+static void cts_change(MGSLPC_INFO *info, struct tty_struct *tty)
 {
 	get_signals(info);
 	if ((info->cts_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -1112,14 +1111,14 @@ static void cts_change(MGSLPC_INFO *info)
 	wake_up_interruptible(&info->status_event_wait_q);
 	wake_up_interruptible(&info->event_wait_q);
 
-	if (info->flags & ASYNC_CTS_FLOW) {
-		if (info->tty->hw_stopped) {
+	if (info->port.flags & ASYNC_CTS_FLOW) {
+		if (tty->hw_stopped) {
 			if (info->serial_signals & SerialSignal_CTS) {
 				if (debug_level >= DEBUG_LEVEL_ISR)
 					printk("CTS tx start...");
-				if (info->tty)
-					info->tty->hw_stopped = 0;
-				tx_start(info);
+				if (tty)
+					tty->hw_stopped = 0;
+				tx_start(info, tty);
 				info->pending_bh |= BH_TRANSMIT;
 				return;
 			}
@@ -1127,8 +1126,8 @@ static void cts_change(MGSLPC_INFO *info)
 			if (!(info->serial_signals & SerialSignal_CTS)) {
 				if (debug_level >= DEBUG_LEVEL_ISR)
 					printk("CTS tx stop...");
-				if (info->tty)
-					info->tty->hw_stopped = 1;
+				if (tty)
+					tty->hw_stopped = 1;
 				tx_stop(info);
 			}
 		}
@@ -1136,7 +1135,7 @@ static void cts_change(MGSLPC_INFO *info)
 	info->pending_bh |= BH_STATUS;
 }
 
-static void dcd_change(MGSLPC_INFO *info)
+static void dcd_change(MGSLPC_INFO *info, struct tty_struct *tty)
 {
 	get_signals(info);
 	if ((info->dcd_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -1158,17 +1157,17 @@ static void dcd_change(MGSLPC_INFO *info)
 	wake_up_interruptible(&info->status_event_wait_q);
 	wake_up_interruptible(&info->event_wait_q);
 
-	if (info->flags & ASYNC_CHECK_CD) {
+	if (info->port.flags & ASYNC_CHECK_CD) {
 		if (debug_level >= DEBUG_LEVEL_ISR)
 			printk("%s CD now %s...", info->device_name,
 			       (info->serial_signals & SerialSignal_DCD) ? "on" : "off");
 		if (info->serial_signals & SerialSignal_DCD)
-			wake_up_interruptible(&info->open_wait);
+			wake_up_interruptible(&info->port.open_wait);
 		else {
 			if (debug_level >= DEBUG_LEVEL_ISR)
 				printk("doing serial hangup...");
-			if (info->tty)
-				tty_hangup(info->tty);
+			if (tty)
+				tty_hangup(tty);
 		}
 	}
 	info->pending_bh |= BH_STATUS;
@@ -1214,6 +1213,7 @@ static void ri_change(MGSLPC_INFO *info)
 static irqreturn_t mgslpc_isr(int dummy, void *dev_id)
 {
 	MGSLPC_INFO *info = dev_id;
+	struct tty_struct *tty;
 	unsigned short isr;
 	unsigned char gis, pis;
 	int count=0;
@@ -1224,6 +1224,8 @@ static irqreturn_t mgslpc_isr(int dummy, void *dev_id)
 	if (!(info->p_dev->_locked))
 		return IRQ_HANDLED;
 
+	tty = tty_port_tty_get(&info->port);
+
 	spin_lock(&info->lock);
 
 	while ((gis = read_reg(info, CHA + GIS))) {
@@ -1239,9 +1241,9 @@ static irqreturn_t mgslpc_isr(int dummy, void *dev_id)
 		if (gis & (BIT1 + BIT0)) {
 			isr = read_reg16(info, CHB + ISR);
 			if (isr & IRQ_DCD)
-				dcd_change(info);
+				dcd_change(info, tty);
 			if (isr & IRQ_CTS)
-				cts_change(info);
+				cts_change(info, tty);
 		}
 		if (gis & (BIT3 + BIT2))
 		{
@@ -1258,8 +1260,8 @@ static irqreturn_t mgslpc_isr(int dummy, void *dev_id)
 			}
 			if (isr & IRQ_BREAK_ON) {
 				info->icount.brk++;
-				if (info->flags & ASYNC_SAK)
-					do_SAK(info->tty);
+				if (info->port.flags & ASYNC_SAK)
+					do_SAK(tty);
 			}
 			if (isr & IRQ_RXTIME) {
 				issue_command(info, CHA, CMD_RXFIFO_READ);
@@ -1268,7 +1270,7 @@ static irqreturn_t mgslpc_isr(int dummy, void *dev_id)
 				if (info->params.mode == MGSL_MODE_HDLC)
 					rx_ready_hdlc(info, isr & IRQ_RXEOM);
 				else
-					rx_ready_async(info, isr & IRQ_RXEOM);
+					rx_ready_async(info, isr & IRQ_RXEOM, tty);
 			}
 
 			/* transmit IRQs */
@@ -1277,14 +1279,14 @@ static irqreturn_t mgslpc_isr(int dummy, void *dev_id)
 					info->icount.txabort++;
 				else
 					info->icount.txunder++;
-				tx_done(info);
+				tx_done(info, tty);
 			}
 			else if (isr & IRQ_ALLSENT) {
 				info->icount.txok++;
-				tx_done(info);
+				tx_done(info, tty);
 			}
 			else if (isr & IRQ_TXFIFO)
-				tx_ready(info);
+				tx_ready(info, tty);
 		}
 		if (gis & BIT7) {
 			pis = read_reg(info, CHA + PIS);
@@ -1308,6 +1310,7 @@ static irqreturn_t mgslpc_isr(int dummy, void *dev_id)
 	}
 
 	spin_unlock(&info->lock);
+	tty_kref_put(tty);
 
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):mgslpc_isr(%d)exit.\n",
@@ -1318,14 +1321,14 @@ static irqreturn_t mgslpc_isr(int dummy, void *dev_id)
 
 /* Initialize and start device.
  */
-static int startup(MGSLPC_INFO * info)
+static int startup(MGSLPC_INFO * info, struct tty_struct *tty)
 {
 	int retval = 0;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):startup(%s)\n",__FILE__,__LINE__,info->device_name);
 
-	if (info->flags & ASYNC_INITIALIZED)
+	if (info->port.flags & ASYNC_INITIALIZED)
 		return 0;
 
 	if (!info->tx_buf) {
@@ -1352,30 +1355,30 @@ static int startup(MGSLPC_INFO * info)
 		retval = adapter_test(info);
 
 	if ( retval ) {
-  		if (capable(CAP_SYS_ADMIN) && info->tty)
-			set_bit(TTY_IO_ERROR, &info->tty->flags);
+  		if (capable(CAP_SYS_ADMIN) && tty)
+			set_bit(TTY_IO_ERROR, &tty->flags);
 		release_resources(info);
   		return retval;
   	}
 
 	/* program hardware for current parameters */
-	mgslpc_change_params(info);
+	mgslpc_change_params(info, tty);
 
-	if (info->tty)
-		clear_bit(TTY_IO_ERROR, &info->tty->flags);
+	if (tty)
+		clear_bit(TTY_IO_ERROR, &tty->flags);
 
-	info->flags |= ASYNC_INITIALIZED;
+	info->port.flags |= ASYNC_INITIALIZED;
 
 	return 0;
 }
 
 /* Called by mgslpc_close() and mgslpc_hangup() to shutdown hardware
  */
-static void shutdown(MGSLPC_INFO * info)
+static void shutdown(MGSLPC_INFO * info, struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	if (!(info->flags & ASYNC_INITIALIZED))
+	if (!(info->port.flags & ASYNC_INITIALIZED))
 		return;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -1402,7 +1405,7 @@ static void shutdown(MGSLPC_INFO * info)
 	/* TODO:disable interrupts instead of reset to preserve signal states */
 	reset_device(info);
 
- 	if (!info->tty || info->tty->termios->c_cflag & HUPCL) {
+ 	if (!tty || tty->termios->c_cflag & HUPCL) {
  		info->serial_signals &= ~(SerialSignal_DTR + SerialSignal_RTS);
 		set_signals(info);
 	}
@@ -1411,13 +1414,13 @@ static void shutdown(MGSLPC_INFO * info)
 
 	release_resources(info);
 
-	if (info->tty)
-		set_bit(TTY_IO_ERROR, &info->tty->flags);
+	if (tty)
+		set_bit(TTY_IO_ERROR, &tty->flags);
 
-	info->flags &= ~ASYNC_INITIALIZED;
+	info->port.flags &= ~ASYNC_INITIALIZED;
 }
 
-static void mgslpc_program_hw(MGSLPC_INFO *info)
+static void mgslpc_program_hw(MGSLPC_INFO *info, struct tty_struct *tty)
 {
 	unsigned long flags;
 
@@ -1443,7 +1446,7 @@ static void mgslpc_program_hw(MGSLPC_INFO *info)
 	port_irq_enable(info, (unsigned char) PVR_DSR | PVR_RI);
 	get_signals(info);
 
-	if (info->netcount || info->tty->termios->c_cflag & CREAD)
+	if (info->netcount || (tty && (tty->termios->c_cflag & CREAD)))
 		rx_start(info);
 
 	spin_unlock_irqrestore(&info->lock,flags);
@@ -1451,19 +1454,19 @@ static void mgslpc_program_hw(MGSLPC_INFO *info)
 
 /* Reconfigure adapter based on new parameters
  */
-static void mgslpc_change_params(MGSLPC_INFO *info)
+static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty)
 {
 	unsigned cflag;
 	int bits_per_char;
 
-	if (!info->tty || !info->tty->termios)
+	if (!tty || !tty->termios)
 		return;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_change_params(%s)\n",
 			 __FILE__,__LINE__, info->device_name );
 
-	cflag = info->tty->termios->c_cflag;
+	cflag = tty->termios->c_cflag;
 
 	/* if B0 rate (hangup) specified then negate DTR and RTS */
 	/* otherwise assert DTR and RTS */
@@ -1510,7 +1513,7 @@ static void mgslpc_change_params(MGSLPC_INFO *info)
 	 * current data rate.
 	 */
 	if (info->params.data_rate <= 460800) {
-		info->params.data_rate = tty_get_baud_rate(info->tty);
+		info->params.data_rate = tty_get_baud_rate(tty);
 	}
 
 	if ( info->params.data_rate ) {
@@ -1520,24 +1523,24 @@ static void mgslpc_change_params(MGSLPC_INFO *info)
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
 	if (cflag & CRTSCTS)
-		info->flags |= ASYNC_CTS_FLOW;
+		info->port.flags |= ASYNC_CTS_FLOW;
 	else
-		info->flags &= ~ASYNC_CTS_FLOW;
+		info->port.flags &= ~ASYNC_CTS_FLOW;
 
 	if (cflag & CLOCAL)
-		info->flags &= ~ASYNC_CHECK_CD;
+		info->port.flags &= ~ASYNC_CHECK_CD;
 	else
-		info->flags |= ASYNC_CHECK_CD;
+		info->port.flags |= ASYNC_CHECK_CD;
 
 	/* process tty input control flags */
 
 	info->read_status_mask = 0;
-	if (I_INPCK(info->tty))
+	if (I_INPCK(tty))
 		info->read_status_mask |= BIT7 | BIT6;
-	if (I_IGNPAR(info->tty))
+	if (I_IGNPAR(tty))
 		info->ignore_status_mask |= BIT7 | BIT6;
 
-	mgslpc_program_hw(info);
+	mgslpc_program_hw(info, tty);
 }
 
 /* Add a character to the transmit buffer
@@ -1597,7 +1600,7 @@ static void mgslpc_flush_chars(struct tty_struct *tty)
 
 	spin_lock_irqsave(&info->lock,flags);
 	if (!info->tx_active)
-	 	tx_start(info);
+	 	tx_start(info, tty);
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
@@ -1659,7 +1662,7 @@ start:
  	if (info->tx_count && !tty->stopped && !tty->hw_stopped) {
 		spin_lock_irqsave(&info->lock,flags);
 		if (!info->tx_active)
-		 	tx_start(info);
+		 	tx_start(info, tty);
 		spin_unlock_irqrestore(&info->lock,flags);
  	}
 cleanup:
@@ -1764,7 +1767,7 @@ static void mgslpc_send_xchar(struct tty_struct *tty, char ch)
 	if (ch) {
 		spin_lock_irqsave(&info->lock,flags);
 		if (!info->tx_enabled)
-		 	tx_start(info);
+		 	tx_start(info, tty);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 }
@@ -1862,7 +1865,7 @@ static int get_params(MGSLPC_INFO * info, MGSL_PARAMS __user *user_params)
  *
  * Returns:	0 if success, otherwise error code
  */
-static int set_params(MGSLPC_INFO * info, MGSL_PARAMS __user *new_params)
+static int set_params(MGSLPC_INFO * info, MGSL_PARAMS __user *new_params, struct tty_struct *tty)
 {
  	unsigned long flags;
 	MGSL_PARAMS tmp_params;
@@ -1883,7 +1886,7 @@ static int set_params(MGSLPC_INFO * info, MGSL_PARAMS __user *new_params)
 	memcpy(&info->params,&tmp_params,sizeof(MGSL_PARAMS));
 	spin_unlock_irqrestore(&info->lock,flags);
 
- 	mgslpc_change_params(info);
+ 	mgslpc_change_params(info, tty);
 
 	return 0;
 }
@@ -1944,7 +1947,7 @@ static int set_interface(MGSLPC_INFO * info, int if_mode)
 	return 0;
 }
 
-static int set_txenable(MGSLPC_INFO * info, int enable)
+static int set_txenable(MGSLPC_INFO * info, int enable, struct tty_struct *tty)
 {
  	unsigned long flags;
 
@@ -1954,7 +1957,7 @@ static int set_txenable(MGSLPC_INFO * info, int enable)
 	spin_lock_irqsave(&info->lock,flags);
 	if (enable) {
 		if (!info->tx_enabled)
-			tx_start(info);
+			tx_start(info, tty);
 	} else {
 		if (info->tx_enabled)
 			tx_stop(info);
@@ -2263,6 +2266,11 @@ static int mgslpc_ioctl(struct tty_struct *tty, struct file * file,
 			unsigned int cmd, unsigned long arg)
 {
 	MGSLPC_INFO * info = (MGSLPC_INFO *)tty->driver_data;
+	int error;
+	struct mgsl_icount cnow;	/* kernel counter temps */
+	struct serial_icounter_struct __user *p_cuser;	/* user space */
+	void __user *argp = (void __user *)arg;
+	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_ioctl %s cmd=%08X\n", __FILE__,__LINE__,
@@ -2277,22 +2285,11 @@ static int mgslpc_ioctl(struct tty_struct *tty, struct file * file,
 		    return -EIO;
 	}
 
-	return ioctl_common(info, cmd, arg);
-}
-
-static int ioctl_common(MGSLPC_INFO *info, unsigned int cmd, unsigned long arg)
-{
-	int error;
-	struct mgsl_icount cnow;	/* kernel counter temps */
-	struct serial_icounter_struct __user *p_cuser;	/* user space */
-	void __user *argp = (void __user *)arg;
-	unsigned long flags;
-
 	switch (cmd) {
 	case MGSL_IOCGPARAMS:
 		return get_params(info, argp);
 	case MGSL_IOCSPARAMS:
-		return set_params(info, argp);
+		return set_params(info, argp, tty);
 	case MGSL_IOCGTXIDLE:
 		return get_txidle(info, argp);
 	case MGSL_IOCSTXIDLE:
@@ -2302,7 +2299,7 @@ static int ioctl_common(MGSLPC_INFO *info, unsigned int cmd, unsigned long arg)
 	case MGSL_IOCSIF:
 		return set_interface(info,(int)arg);
 	case MGSL_IOCTXENABLE:
-		return set_txenable(info,(int)arg);
+		return set_txenable(info,(int)arg, tty);
 	case MGSL_IOCRXENABLE:
 		return set_rxenable(info,(int)arg);
 	case MGSL_IOCTXABORT:
@@ -2369,7 +2366,7 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 		== RELEVANT_IFLAG(old_termios->c_iflag)))
 	  return;
 
-	mgslpc_change_params(info);
+	mgslpc_change_params(info, tty);
 
 	/* Handle transition to B0 status */
 	if (old_termios->c_cflag & CBAUD &&
@@ -2404,81 +2401,34 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 static void mgslpc_close(struct tty_struct *tty, struct file * filp)
 {
 	MGSLPC_INFO * info = (MGSLPC_INFO *)tty->driver_data;
+	struct tty_port *port = &info->port;
 
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_close"))
 		return;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_close(%s) entry, count=%d\n",
-			 __FILE__,__LINE__, info->device_name, info->count);
-
-	if (!info->count)
-		return;
+			 __FILE__,__LINE__, info->device_name, port->count);
 
-	if (tty_hung_up_p(filp))
-		goto cleanup;
-
-	if ((tty->count == 1) && (info->count != 1)) {
-		/*
-		 * tty->count is 1 and the tty structure will be freed.
-		 * info->count should be one in this case.
-		 * if it's not, correct it so that the port is shutdown.
-		 */
-		printk("mgslpc_close: bad refcount; tty->count is 1, "
-		       "info->count is %d\n", info->count);
-		info->count = 1;
-	}
+	WARN_ON(!port->count);
 
-	info->count--;
-
-	/* if at least one open remaining, leave hardware active */
-	if (info->count)
+	if (tty_port_close_start(port, tty, filp) == 0)
 		goto cleanup;
 
-	info->flags |= ASYNC_CLOSING;
-
-	/* set tty->closing to notify line discipline to
-	 * only process XON/XOFF characters. Only the N_TTY
-	 * discipline appears to use this (ppp does not).
-	 */
-	tty->closing = 1;
-
-	/* wait for transmit data to clear all layers */
-
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE) {
-		if (debug_level >= DEBUG_LEVEL_INFO)
-			printk("%s(%d):mgslpc_close(%s) calling tty_wait_until_sent\n",
-				 __FILE__,__LINE__, info->device_name );
-		tty_wait_until_sent(tty, info->closing_wait);
-	}
-
- 	if (info->flags & ASYNC_INITIALIZED)
+ 	if (port->flags & ASYNC_INITIALIZED)
  		mgslpc_wait_until_sent(tty, info->timeout);
 
 	mgslpc_flush_buffer(tty);
 
 	tty_ldisc_flush(tty);
-
-	shutdown(info);
-
-	tty->closing = 0;
-	info->tty = NULL;
-
-	if (info->blocked_open) {
-		if (info->close_delay) {
-			msleep_interruptible(jiffies_to_msecs(info->close_delay));
-		}
-		wake_up_interruptible(&info->open_wait);
-	}
-
-	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-
-	wake_up_interruptible(&info->close_wait);
-
+	shutdown(info, tty);
+	
+	tty_port_close_end(port, tty);
+	tty_port_tty_set(port, NULL);
 cleanup:
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_close(%s) exit, count=%d\n", __FILE__,__LINE__,
-			tty->driver->name, info->count);
+			tty->driver->name, port->count);
 }
 
 /* Wait until the transmitter is empty.
@@ -2498,7 +2448,7 @@ static void mgslpc_wait_until_sent(struct tty_struct *tty, int timeout)
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_wait_until_sent"))
 		return;
 
-	if (!(info->flags & ASYNC_INITIALIZED))
+	if (!(info->port.flags & ASYNC_INITIALIZED))
 		goto exit;
 
 	orig_jiffies = jiffies;
@@ -2559,120 +2509,40 @@ static void mgslpc_hangup(struct tty_struct *tty)
 		return;
 
 	mgslpc_flush_buffer(tty);
-	shutdown(info);
-
-	info->count = 0;
-	info->flags &= ~ASYNC_NORMAL_ACTIVE;
-	info->tty = NULL;
-
-	wake_up_interruptible(&info->open_wait);
+	shutdown(info, tty);
+	tty_port_hangup(&info->port);
 }
 
-/* Block the current process until the specified port
- * is ready to be opened.
- */
-static int block_til_ready(struct tty_struct *tty, struct file *filp,
-			   MGSLPC_INFO *info)
+static int carrier_raised(struct tty_port *port)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	int		retval;
-	bool		do_clocal = false;
-	bool		extra_count = false;
-	unsigned long	flags;
-
-	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):block_til_ready on %s\n",
-			 __FILE__,__LINE__, tty->driver->name );
-
-	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
-		/* nonblock mode is set or port is not enabled */
-		/* just verify that callout device is not active */
-		info->flags |= ASYNC_NORMAL_ACTIVE;
-		return 0;
-	}
-
-	if (tty->termios->c_cflag & CLOCAL)
-		do_clocal = true;
-
-	/* Wait for carrier detect and the line to become
-	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, info->count is dropped by one, so that
-	 * mgslpc_close() knows when to free things.  We restore it upon
-	 * exit, either normal or abnormal.
-	 */
-
-	retval = 0;
-	add_wait_queue(&info->open_wait, &wait);
-
-	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):block_til_ready before block on %s count=%d\n",
-			 __FILE__,__LINE__, tty->driver->name, info->count );
-
-	spin_lock_irqsave(&info->lock, flags);
-	if (!tty_hung_up_p(filp)) {
-		extra_count = true;
-		info->count--;
-	}
-	spin_unlock_irqrestore(&info->lock, flags);
-	info->blocked_open++;
-
-	while (1) {
-		if ((tty->termios->c_cflag & CBAUD)) {
-			spin_lock_irqsave(&info->lock,flags);
-			info->serial_signals |= SerialSignal_RTS + SerialSignal_DTR;
-		 	set_signals(info);
-			spin_unlock_irqrestore(&info->lock,flags);
-		}
-
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (tty_hung_up_p(filp) || !(info->flags & ASYNC_INITIALIZED)){
-			retval = (info->flags & ASYNC_HUP_NOTIFY) ?
-					-EAGAIN : -ERESTARTSYS;
-			break;
-		}
-
-		spin_lock_irqsave(&info->lock,flags);
-	 	get_signals(info);
-		spin_unlock_irqrestore(&info->lock,flags);
-
- 		if (!(info->flags & ASYNC_CLOSING) &&
- 		    (do_clocal || (info->serial_signals & SerialSignal_DCD)) ) {
- 			break;
-		}
-
-		if (signal_pending(current)) {
-			retval = -ERESTARTSYS;
-			break;
-		}
-
-		if (debug_level >= DEBUG_LEVEL_INFO)
-			printk("%s(%d):block_til_ready blocking on %s count=%d\n",
-				 __FILE__,__LINE__, tty->driver->name, info->count );
-
-		schedule();
-	}
-
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&info->open_wait, &wait);
+	MGSLPC_INFO *info = container_of(port, MGSLPC_INFO, port);
+	unsigned long flags;
 
-	if (extra_count)
-		info->count++;
-	info->blocked_open--;
+	spin_lock_irqsave(&info->lock,flags);
+ 	get_signals(info);
+	spin_unlock_irqrestore(&info->lock,flags);
 
-	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):block_til_ready after blocking on %s count=%d\n",
-			 __FILE__,__LINE__, tty->driver->name, info->count );
+	if (info->serial_signals & SerialSignal_DCD)
+		return 1;
+	return 0;
+}
 
-	if (!retval)
-		info->flags |= ASYNC_NORMAL_ACTIVE;
+static void raise_dtr_rts(struct tty_port *port)
+{
+	MGSLPC_INFO *info = container_of(port, MGSLPC_INFO, port);
+	unsigned long flags;
 
-	return retval;
+	spin_lock_irqsave(&info->lock,flags);
+	info->serial_signals |= SerialSignal_RTS + SerialSignal_DTR;
+	set_signals(info);
+	spin_unlock_irqrestore(&info->lock,flags);
 }
 
+
 static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 {
 	MGSLPC_INFO	*info;
+	struct tty_port *port;
 	int 			retval, line;
 	unsigned long flags;
 
@@ -2691,23 +2561,24 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_open"))
 		return -ENODEV;
 
+	port = &info->port;
 	tty->driver_data = info;
-	info->tty = tty;
+	tty_port_tty_set(port, tty);
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_open(%s), old ref count = %d\n",
-			 __FILE__,__LINE__,tty->driver->name, info->count);
+			 __FILE__,__LINE__,tty->driver->name, port->count);
 
 	/* If port is closing, signal caller to try again */
-	if (tty_hung_up_p(filp) || info->flags & ASYNC_CLOSING){
-		if (info->flags & ASYNC_CLOSING)
-			interruptible_sleep_on(&info->close_wait);
-		retval = ((info->flags & ASYNC_HUP_NOTIFY) ?
+	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING){
+		if (port->flags & ASYNC_CLOSING)
+			interruptible_sleep_on(&port->close_wait);
+		retval = ((port->flags & ASYNC_HUP_NOTIFY) ?
 			-EAGAIN : -ERESTARTSYS);
 		goto cleanup;
 	}
 
-	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
+	tty->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
 	spin_lock_irqsave(&info->netlock, flags);
 	if (info->netcount) {
@@ -2715,17 +2586,19 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 		spin_unlock_irqrestore(&info->netlock, flags);
 		goto cleanup;
 	}
-	info->count++;
+	spin_lock(&port->lock);
+	port->count++;
+	spin_unlock(&port->lock);
 	spin_unlock_irqrestore(&info->netlock, flags);
 
-	if (info->count == 1) {
+	if (port->count == 1) {
 		/* 1st open on this device, init hardware */
-		retval = startup(info);
+		retval = startup(info, tty);
 		if (retval < 0)
 			goto cleanup;
 	}
 
-	retval = block_til_ready(tty, filp, info);
+	retval = tty_port_block_til_ready(&info->port, tty, filp);
 	if (retval) {
 		if (debug_level >= DEBUG_LEVEL_INFO)
 			printk("%s(%d):block_til_ready(%s) returned %d\n",
@@ -2739,13 +2612,6 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	retval = 0;
 
 cleanup:
-	if (retval) {
-		if (tty->count == 1)
-			info->tty = NULL; /* tty layer will release tty struct */
-		if(info->count)
-			info->count--;
-	}
-
 	return retval;
 }
 
@@ -3500,7 +3366,7 @@ static void rx_start(MGSLPC_INFO *info)
 	info->rx_enabled = true;
 }
 
-static void tx_start(MGSLPC_INFO *info)
+static void tx_start(MGSLPC_INFO *info, struct tty_struct *tty)
 {
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):tx_start(%s)\n",
@@ -3524,11 +3390,11 @@ static void tx_start(MGSLPC_INFO *info)
 		if (info->params.mode == MGSL_MODE_ASYNC) {
 			if (!info->tx_active) {
 				info->tx_active = true;
-				tx_ready(info);
+				tx_ready(info, tty);
 			}
 		} else {
 			info->tx_active = true;
-			tx_ready(info);
+			tx_ready(info, tty);
 			mod_timer(&info->tx_timer, jiffies +
 					msecs_to_jiffies(5000));
 		}
@@ -3849,13 +3715,12 @@ static void rx_reset_buffers(MGSLPC_INFO *info)
  *
  * Returns true if frame returned, otherwise false
  */
-static bool rx_get_frame(MGSLPC_INFO *info)
+static bool rx_get_frame(MGSLPC_INFO *info, struct tty_struct *tty)
 {
 	unsigned short status;
 	RXBUF *buf;
 	unsigned int framesize = 0;
 	unsigned long flags;
-	struct tty_struct *tty = info->tty;
 	bool return_frame = false;
 
 	if (info->rx_frame_count == 0)
@@ -4075,7 +3940,11 @@ static void tx_timeout(unsigned long context)
 		hdlcdev_tx_done(info);
 	else
 #endif
-		bh_transmit(info);
+	{
+		struct tty_struct *tty = tty_port_tty_get(&info->port);
+		bh_transmit(info, tty);
+		tty_kref_put(tty);
+	}
 }
 
 #if SYNCLINK_GENERIC_HDLC
@@ -4094,11 +3963,12 @@ static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
 			  unsigned short parity)
 {
 	MGSLPC_INFO *info = dev_to_port(dev);
+	struct tty_struct *tty;
 	unsigned char  new_encoding;
 	unsigned short new_crctype;
 
 	/* return error if TTY interface open */
-	if (info->count)
+	if (info->port.count)
 		return -EBUSY;
 
 	switch (encoding)
@@ -4123,8 +3993,11 @@ static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
 	info->params.crc_type = new_crctype;
 
 	/* if network interface up, reprogram hardware */
-	if (info->netcount)
-		mgslpc_program_hw(info);
+	if (info->netcount) {
+		tty = tty_port_tty_get(&info->port);
+		mgslpc_program_hw(info, tty);
+		tty_kref_put(tty);
+	}
 
 	return 0;
 }
@@ -4165,8 +4038,11 @@ static int hdlcdev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* start hardware transmitter if necessary */
 	spin_lock_irqsave(&info->lock,flags);
-	if (!info->tx_active)
-	 	tx_start(info);
+	if (!info->tx_active) {
+		struct tty_struct *tty = tty_port_tty_get(&info->port);
+	 	tx_start(info, tty);
+	 	tty_kref_put(tty);
+	}
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	return 0;
@@ -4183,6 +4059,7 @@ static int hdlcdev_xmit(struct sk_buff *skb, struct net_device *dev)
 static int hdlcdev_open(struct net_device *dev)
 {
 	MGSLPC_INFO *info = dev_to_port(dev);
+	struct tty_struct *tty;
 	int rc;
 	unsigned long flags;
 
@@ -4195,7 +4072,7 @@ static int hdlcdev_open(struct net_device *dev)
 
 	/* arbitrate between network and tty opens */
 	spin_lock_irqsave(&info->netlock, flags);
-	if (info->count != 0 || info->netcount != 0) {
+	if (info->port.count != 0 || info->netcount != 0) {
 		printk(KERN_WARNING "%s: hdlc_open returning busy\n", dev->name);
 		spin_unlock_irqrestore(&info->netlock, flags);
 		return -EBUSY;
@@ -4203,17 +4080,19 @@ static int hdlcdev_open(struct net_device *dev)
 	info->netcount=1;
 	spin_unlock_irqrestore(&info->netlock, flags);
 
+	tty = tty_port_tty_get(&info->port);
 	/* claim resources and init adapter */
-	if ((rc = startup(info)) != 0) {
+	if ((rc = startup(info, tty)) != 0) {
+		tty_kref_put(tty);
 		spin_lock_irqsave(&info->netlock, flags);
 		info->netcount=0;
 		spin_unlock_irqrestore(&info->netlock, flags);
 		return rc;
 	}
-
 	/* assert DTR and RTS, apply hardware settings */
 	info->serial_signals |= SerialSignal_RTS + SerialSignal_DTR;
-	mgslpc_program_hw(info);
+	mgslpc_program_hw(info, tty);
+	tty_kref_put(tty);
 
 	/* enable network layer transmit */
 	dev->trans_start = jiffies;
@@ -4241,6 +4120,7 @@ static int hdlcdev_open(struct net_device *dev)
 static int hdlcdev_close(struct net_device *dev)
 {
 	MGSLPC_INFO *info = dev_to_port(dev);
+	struct tty_struct *tty = tty_port_tty_get(&info->port);
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -4249,8 +4129,8 @@ static int hdlcdev_close(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	/* shutdown adapter and release resources */
-	shutdown(info);
-
+	shutdown(info, tty);
+	tty_kref_put(tty);
 	hdlc_close(dev);
 
 	spin_lock_irqsave(&info->netlock, flags);
@@ -4281,7 +4161,7 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		printk("%s:hdlcdev_ioctl(%s)\n",__FILE__,dev->name);
 
 	/* return error if TTY interface open */
-	if (info->count)
+	if (info->port.count)
 		return -EBUSY;
 
 	if (cmd != SIOCWANDEV)
@@ -4354,8 +4234,11 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 			info->params.clock_speed = 0;
 
 		/* if network interface up, reprogram hardware */
-		if (info->netcount)
-			mgslpc_program_hw(info);
+		if (info->netcount) {
+			struct tty_struct *tty = tty_port_tty_get(&info->port);
+			mgslpc_program_hw(info, tty);
+			tty_kref_put(tty);
+		}
 		return 0;
 
 	default:

