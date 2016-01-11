From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: RFC: out-of-tree tty driver breakage (changing ASYNC_ bits)
Date: Sun, 10 Jan 2016 16:36:35 -0800
Message-ID: <5692F913.5090804@hurleysoftware.com>
References: <5692D054.7050203@hurleysoftware.com>
 <20160110234439.4191f3f4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160110234439.4191f3f4@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On 01/10/2016 03:44 PM, One Thousand Gnomes wrote:
> On Sun, 10 Jan 2016 13:42:44 -0800
> Peter Hurley <peter@hurleysoftware.com> wrote:
> 
>> The tty/serial core uses 5 bits in the tty_port.flags field to
>> manage state. They are:
>>
>> ASYNCB_INITIALIZED
>> ASYNCB_SUSPENDED
>> ASYNCB_NORMAL_ACTIVE
>> - and -
>> ASYNCB_CTS_FLOW
>> ASYNCB_CHECK_CD
>>
>> Unfortunately, updates to this field (tty_port.flags) are often
>> non-atomic. Additionally, the field is visible to/modifiable by
>> userspace (the first 3 bits above are not modifiable by userspace
>> though). Lastly, the multi-bit ASYNC_SPD_ bitfield is in this
>> tty_port.flags field as well.
> 
> ASYNC_SPD ought to just get retired, it's been obsolete and warning
> people since forever 8)
> 
> Two comments:
> 
> 1. Making something unsigned long doesn't magically make it atomic. You
> either use atomic_foo() or you use set_bit() and friends or the compiler
> sneaks up on you and does evil things. It might make it "a bit more
> atomic" but it doesn't make it correct. The compiler is free to do stupid
> things like turn
> 
>                 x |= 1
> 
> into
> 		store 1 to memory
> 		or memory with reg (holding old x)
> 
> gcc won't afaik ever do that on any platform we support, but it's not
> against the rules if its ever optimal !
> 
> 2. On a lot of architectures it's going to be easier to just use set_bit()
> and friends I suspect than take the cache hit of 5 unsigned longs. At the
> very least re-order the struct to keep the hot stuff together.
> 
> The compiler will also play other games with your intentions. It'll defer
> or even eliminate invisible writes that don't get protected by memory
> barriers or forced by say function calls.

To answer both comments, here's an example follow-on patch that would
update the equivalent of ASYNC_INITIALIZED atomically without concern
for what else might overwrite tty_port.flags.

Regards,
Peter Hurley

--- >% ---
Subject: [PATCH] tty: Replace ASYNC_INITIALIZED bit and update atomically

Replace ASYNC_INITIALIZED bit in the tty_port::flags field with
ASY_ON bit in the tty_port::iflags field, and use atomic bit ops.
---
 drivers/char/pcmcia/synclink_cs.c  | 12 +++++-----
 drivers/ipack/devices/ipoctal.c    |  4 ++--
 drivers/isdn/i4l/isdn_tty.c        | 10 ++++-----
 drivers/s390/char/con3215.c        | 10 ++++-----
 drivers/tty/amiserial.c            | 14 ++++++------
 drivers/tty/cyclades.c             | 14 ++++++------
 drivers/tty/isicom.c               |  4 ++--
 drivers/tty/moxa.c                 | 10 ++++-----
 drivers/tty/mxser.c                | 10 ++++-----
 drivers/tty/n_gsm.c                |  4 ++--
 drivers/tty/rocket.c               | 12 +++++-----
 drivers/tty/serial/68328serial.c   |  8 +++----
 drivers/tty/serial/crisv10.c       | 16 ++++++-------
 drivers/tty/serial/serial_core.c   | 22 +++++++++---------
 drivers/tty/synclink.c             | 46 ++++++++++++++++++--------------------
 drivers/tty/synclink_gt.c          | 16 ++++++-------
 drivers/tty/synclinkmp.c           | 16 ++++++-------
 drivers/tty/tty_port.c             | 19 ++++++++--------
 drivers/usb/class/cdc-acm.c        |  4 ++--
 drivers/usb/serial/console.c       |  4 ++--
 drivers/usb/serial/generic.c       |  6 ++---
 drivers/usb/serial/mxuport.c       |  6 ++---
 drivers/usb/serial/sierra.c        |  4 ++--
 drivers/usb/serial/usb-serial.c    |  2 +-
 drivers/usb/serial/usb_wwan.c      |  4 ++--
 net/irda/ircomm/ircomm_tty.c       | 13 +++++------
 net/irda/ircomm/ircomm_tty_ioctl.c |  2 +-
 27 files changed, 144 insertions(+), 148 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 9c42672..1a78860 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1272,7 +1272,7 @@ static int startup(MGSLPC_INFO * info, struct tty_struct *tty)
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):startup(%s)\n", __FILE__, __LINE__, info->device_name);
 
-	if (info->port.flags & ASYNC_INITIALIZED)
+	if (test_bit(ASY_ON, &info->port.iflags))
 		return 0;
 
 	if (!info->tx_buf) {
@@ -1311,7 +1311,7 @@ static int startup(MGSLPC_INFO * info, struct tty_struct *tty)
 	if (tty)
 		clear_bit(TTY_IO_ERROR, &tty->flags);
 
-	info->port.flags |= ASYNC_INITIALIZED;
+	set_bit(ASY_ON, &info->port.iflags);
 
 	return 0;
 }
@@ -1322,7 +1322,7 @@ static void shutdown(MGSLPC_INFO * info, struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		return;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -1361,7 +1361,7 @@ static void shutdown(MGSLPC_INFO * info, struct tty_struct *tty)
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 
-	info->port.flags &= ~ASYNC_INITIALIZED;
+	clear_bit(ASY_ON, &info->port.iflags);
 }
 
 static void mgslpc_program_hw(MGSLPC_INFO *info, struct tty_struct *tty)
@@ -2345,7 +2345,7 @@ static void mgslpc_close(struct tty_struct *tty, struct file * filp)
 	if (tty_port_close_start(port, tty, filp) == 0)
 		goto cleanup;
 
-	if (port->flags & ASYNC_INITIALIZED)
+	if (test_bit(ASY_ON, &port->iflags))
 		mgslpc_wait_until_sent(tty, info->timeout);
 
 	mgslpc_flush_buffer(tty);
@@ -2378,7 +2378,7 @@ static void mgslpc_wait_until_sent(struct tty_struct *tty, int timeout)
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_wait_until_sent"))
 		return;
 
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		goto exit;
 
 	orig_jiffies = jiffies;
diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index 035d544..40212eb 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -630,7 +630,7 @@ static void ipoctal_hangup(struct tty_struct *tty)
 
 	ipoctal_reset_channel(channel);
 
-	clear_bit(ASYNCB_INITIALIZED, &channel->tty_port.flags);
+	clear_bit(ASY_ON, &channel->tty_port.iflags);
 	wake_up_interruptible(&channel->tty_port.open_wait);
 }
 
@@ -642,7 +642,7 @@ static void ipoctal_shutdown(struct tty_struct *tty)
 		return;
 
 	ipoctal_reset_channel(channel);
-	clear_bit(ASYNCB_INITIALIZED, &channel->tty_port.flags);
+	clear_bit(ASY_ON, &channel->tty_port.iflags);
 }
 
 static void ipoctal_cleanup(struct tty_struct *tty)
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index 4f297ba..817100f 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1053,7 +1053,7 @@ isdn_tty_change_speed(modem_info *info)
 static int
 isdn_tty_startup(modem_info *info)
 {
-	if (info->port.flags & ASYNC_INITIALIZED)
+	if (test_bit(ASY_ON, &info->port.iflags))
 		return 0;
 	isdn_lock_drivers();
 #ifdef ISDN_DEBUG_MODEM_OPEN
@@ -1070,7 +1070,7 @@ isdn_tty_startup(modem_info *info)
 	 */
 	isdn_tty_change_speed(info);
 
-	info->port.flags |= ASYNC_INITIALIZED;
+	set_bit(ASY_ON, &info->port.iflags);
 	info->msr |= (UART_MSR_DSR | UART_MSR_CTS);
 	info->send_outstanding = 0;
 	return 0;
@@ -1083,7 +1083,7 @@ isdn_tty_startup(modem_info *info)
 static void
 isdn_tty_shutdown(modem_info *info)
 {
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		return;
 #ifdef ISDN_DEBUG_MODEM_OPEN
 	printk(KERN_DEBUG "Shutting down isdnmodem port %d ....\n", info->line);
@@ -1103,7 +1103,7 @@ isdn_tty_shutdown(modem_info *info)
 	if (info->port.tty)
 		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
 
-	info->port.flags &= ~ASYNC_INITIALIZED;
+	clear_bit(ASY_ON, &info->port.iflags);
 }
 
 /* isdn_tty_write() is the main send-routine. It is called from the upper
@@ -1581,7 +1581,7 @@ isdn_tty_close(struct tty_struct *tty, struct file *filp)
 	 * interrupt driver to stop checking the data ready bit in the
 	 * line status register.
 	 */
-	if (port->flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &port->iflags)) {
 		tty_wait_until_sent(tty, 3000);	/* 30 seconds timeout */
 		/*
 		 * Before we drop DTR, make sure the UART transmitter
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index a7b2ef0..9877b21 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -311,7 +311,7 @@ static void raw3215_timeout(unsigned long __data)
  */
 static inline void raw3215_try_io(struct raw3215_info *raw)
 {
-	if (!(raw->port.flags & ASYNC_INITIALIZED) ||
+	if (!test_bit(ASY_ON, &raw->port.iflags) ||
 	    test_bit(ASY_SUSPENDED, &raw->port.iflags))
 		return;
 	if (raw->queued_read != NULL)
@@ -616,10 +616,10 @@ static int raw3215_startup(struct raw3215_info *raw)
 {
 	unsigned long flags;
 
-	if (raw->port.flags & ASYNC_INITIALIZED)
+	if (test_bit(ASY_ON, &raw->port.iflags))
 		return 0;
 	raw->line_pos = 0;
-	raw->port.flags |= ASYNC_INITIALIZED;
+	set_bit(ASY_ON, &raw->port.iflags);
 	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 	raw3215_try_io(raw);
 	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
@@ -635,7 +635,7 @@ static void raw3215_shutdown(struct raw3215_info *raw)
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 
-	if (!(raw->port.flags & ASYNC_INITIALIZED) ||
+	if (!test_bit(ASY_ON, &raw->port.iflags) ||
 	    (raw->flags & RAW3215_FIXED))
 		return;
 	/* Wait for outstanding requests, then free irq */
@@ -650,7 +650,7 @@ static void raw3215_shutdown(struct raw3215_info *raw)
 		spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 		remove_wait_queue(&raw->empty_wait, &wait);
 		set_current_state(TASK_RUNNING);
-		raw->port.flags &= ~ASYNC_INITIALIZED;
+		clear_bit(ASY_ON, &raw->port.iflags);
 	}
 	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index c2d0e35..6a6d3c9 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -525,7 +525,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 
 	local_irq_save(flags);
 
-	if (port->flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &port->iflags)) {
 		free_page(page);
 		goto errout;
 	}
@@ -586,7 +586,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 	 */
 	change_speed(tty, info, NULL);
 
-	port->flags |= ASYNC_INITIALIZED;
+	set_bit(ASY_ON, &port->iflags);
 	local_irq_restore(flags);
 	return 0;
 
@@ -604,7 +604,7 @@ static void shutdown(struct tty_struct *tty, struct serial_state *info)
 	unsigned long	flags;
 	struct serial_state *state;
 
-	if (!(info->tport.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->tport.iflags))
 		return;
 
 	state = info;
@@ -645,7 +645,7 @@ static void shutdown(struct tty_struct *tty, struct serial_state *info)
 
 	set_bit(TTY_IO_ERROR, &tty->flags);
 
-	info->tport.flags &= ~ASYNC_INITIALIZED;
+	clear_bit(ASY_ON, &info->tport.iflags);
 	local_irq_restore(flags);
 }
 
@@ -1089,7 +1089,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 	port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
 check_and_exit:
-	if (port->flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &port->iflags)) {
 		if (change_spd) {
 			if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
 				tty->alt_speed = 57600;
@@ -1395,7 +1395,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	 * line status register.
 	 */
 	state->read_status_mask &= ~UART_LSR_DR;
-	if (port->flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &port->iflags)) {
 	        /* disable receive interrupts */
 	        custom.intena = IF_RBF;
 		mb();
@@ -1543,7 +1543,7 @@ static inline void line_info(struct seq_file *m, int line,
 
 	local_irq_save(flags);
 	status = ciab.pra;
-	control = (state->tport.flags & ASYNC_INITIALIZED) ? state->MCR : status;
+	control = test_bit(ASY_ON, &state->tport.iflags) ? state->MCR : status;
 	local_irq_restore(flags);
 
 	stat_buf[0] = 0;
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 54fa4a23..3210cdc 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -1279,7 +1279,7 @@ static int cy_startup(struct cyclades_port *info, struct tty_struct *tty)
 
 	spin_lock_irqsave(&card->card_lock, flags);
 
-	if (info->port.flags & ASYNC_INITIALIZED)
+	if (test_bit(ASY_ON, &info->port.iflags))
 		goto errout;
 
 	if (!info->type) {
@@ -1364,7 +1364,7 @@ static int cy_startup(struct cyclades_port *info, struct tty_struct *tty)
 		/* enable send, recv, modem !!! */
 	}
 
-	info->port.flags |= ASYNC_INITIALIZED;
+	set_bit(ASY_ON, &info->port.iflags);
 
 	clear_bit(TTY_IO_ERROR, &tty->flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
@@ -1424,7 +1424,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 	struct cyclades_card *card;
 	unsigned long flags;
 
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		return;
 
 	card = info->card;
@@ -1448,7 +1448,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 		   some later date (after testing)!!! */
 
 		set_bit(TTY_IO_ERROR, &tty->flags);
-		info->port.flags &= ~ASYNC_INITIALIZED;
+		clear_bit(ASY_ON, &info->port.iflags);
 		spin_unlock_irqrestore(&card->card_lock, flags);
 	} else {
 #ifdef CY_DEBUG_OPEN
@@ -1473,7 +1473,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 			tty_port_lower_dtr_rts(&info->port);
 
 		set_bit(TTY_IO_ERROR, &tty->flags);
-		info->port.flags &= ~ASYNC_INITIALIZED;
+		clear_bit(ASY_ON, &info->port.iflags);
 
 		spin_unlock_irqrestore(&card->card_lock, flags);
 	}
@@ -1711,7 +1711,7 @@ static void cy_do_close(struct tty_port *port)
 		/* Stop accepting input */
 		cyy_writeb(info, CyCAR, channel & 0x03);
 		cyy_writeb(info, CySRER, cyy_readb(info, CySRER) & ~CyRxData);
-		if (info->port.flags & ASYNC_INITIALIZED) {
+		if (test_bit(ASY_ON, &info->port.iflags)) {
 			/* Waiting for on-board buffers to be empty before
 			   closing the port */
 			spin_unlock_irqrestore(&card->card_lock, flags);
@@ -2342,7 +2342,7 @@ cy_set_serial_info(struct cyclades_port *info, struct tty_struct *tty,
 	info->port.closing_wait = new_serial.closing_wait * HZ / 100;
 
 check_and_exit:
-	if (info->port.flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &info->port.iflags)) {
 		cy_set_line_char(info, tty);
 		ret = 0;
 	} else {
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 04a664d..bf04f1c 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -438,7 +438,7 @@ static void isicom_tx(unsigned long _data)
 
 	for (; count > 0; count--, port++) {
 		/* port not active or tx disabled to force flow control */
-		if (!(port->port.flags & ASYNC_INITIALIZED) ||
+		if (!test_bit(ASY_ON, &port->port.iflags) ||
 				!(port->status & ISI_TXOK))
 			continue;
 
@@ -553,7 +553,7 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 	port = card->ports + channel;
-	if (!(port->port.flags & ASYNC_INITIALIZED)) {
+	if (!test_bit(ASY_ON, &port->port.iflags)) {
 		outw(0x0000, base+0x04); /* enable interrupts */
 		spin_unlock(&card->card_lock);
 		return IRQ_HANDLED;
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 92982d7..d78b409 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -912,7 +912,7 @@ static void moxa_board_deinit(struct moxa_board_conf *brd)
 
 	/* pci hot-un-plug support */
 	for (a = 0; a < brd->numPorts; a++)
-		if (brd->ports[a].port.flags & ASYNC_INITIALIZED)
+		if (test_bit(ASY_ON, &brd->ports[a].port.iflags))
 			tty_port_tty_hangup(&brd->ports[a].port, false);
 
 	for (a = 0; a < MAX_PORTS_PER_BOARD; a++)
@@ -921,7 +921,7 @@ static void moxa_board_deinit(struct moxa_board_conf *brd)
 	while (1) {
 		opened = 0;
 		for (a = 0; a < brd->numPorts; a++)
-			if (brd->ports[a].port.flags & ASYNC_INITIALIZED)
+			if (test_bit(ASY_ON, &brd->ports[a].port.iflags))
 				opened++;
 		mutex_unlock(&moxa_openlock);
 		if (!opened)
@@ -1192,13 +1192,13 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 	tty->driver_data = ch;
 	tty_port_tty_set(&ch->port, tty);
 	mutex_lock(&ch->port.mutex);
-	if (!(ch->port.flags & ASYNC_INITIALIZED)) {
+	if (!test_bit(ASY_ON, &ch->port.iflags)) {
 		ch->statusflags = 0;
 		moxa_set_tty_param(tty, &tty->termios);
 		MoxaPortLineCtrl(ch, 1, 1);
 		MoxaPortEnable(ch);
 		MoxaSetFifo(ch, ch->type == PORT_16550A);
-		ch->port.flags |= ASYNC_INITIALIZED;
+		set_bit(ASY_ON, &ch->port.iflags);
 	}
 	mutex_unlock(&ch->port.mutex);
 	mutex_unlock(&moxa_openlock);
@@ -1379,7 +1379,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 {
 	struct tty_struct *tty = tty_port_tty_get(&p->port);
 	void __iomem *ofsAddr;
-	unsigned int inited = p->port.flags & ASYNC_INITIALIZED;
+	unsigned int inited = test_bit(ASY_ON, &p->port.iflags);
 	u16 intr;
 
 	if (tty) {
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index f51f1fb..c668f00 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1086,12 +1086,12 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	mutex_lock(&port->mutex);
 	mxser_close_port(port);
 	mxser_flush_buffer(tty);
-	if (test_bit(ASYNCB_INITIALIZED, &port->flags)) {
+	if (test_bit(ASY_ON, &port->iflags)) {
 		if (C_HUPCL(tty))
 			tty_port_lower_dtr_rts(port);
 	}
 	mxser_shutdown_port(port);
-	clear_bit(ASYNCB_INITIALIZED, &port->flags);
+	clear_bit(ASY_ON, &port->iflags);
 	mutex_unlock(&port->mutex);
 	info->closing = 0;
 	/* Right now the tty_port set is done outside of the close_end helper
@@ -1287,7 +1287,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 
 	process_txrx_fifo(info);
 
-	if (test_bit(ASYNCB_INITIALIZED, &port->flags)) {
+	if (test_bit(ASY_ON, &port->iflags)) {
 		if (flags != (port->flags & ASYNC_SPD_MASK)) {
 			spin_lock_irqsave(&info->slock, sl_flags);
 			mxser_change_speed(tty, NULL);
@@ -1296,7 +1296,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 	} else {
 		retval = mxser_activate(port, tty);
 		if (retval == 0)
-			set_bit(ASYNCB_INITIALIZED, &port->flags);
+			set_bit(ASY_ON, &port->iflags);
 	}
 	return retval;
 }
@@ -2257,7 +2257,7 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 				iir &= MOXA_MUST_IIR_MASK;
 				tty = tty_port_tty_get(&port->port);
 				if (!tty || port->closing ||
-				    !(port->port.flags & ASYNC_INITIALIZED)) {
+				    !test_bit(ASY_ON, &port->port.iflags)) {
 					status = inb(port->ioaddr + UART_LSR);
 					outb(0x27, port->ioaddr + UART_FCR);
 					inb(port->ioaddr + UART_MSR);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c016207..c3bd263 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2947,7 +2947,7 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 	dlci->modem_rx = 0;
 	/* We could in theory open and close before we wait - eg if we get
 	   a DM straight back. This is ok as that will have caused a hangup */
-	set_bit(ASYNCB_INITIALIZED, &port->flags);
+	set_bit(ASY_ON, &port->iflags);
 	/* Start sending off SABM messages */
 	gsm_dlci_begin_open(dlci);
 	/* And wait for virtual carrier */
@@ -2970,7 +2970,7 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
 	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
 		return;
 	gsm_dlci_begin_close(dlci);
-	if (test_bit(ASYNCB_INITIALIZED, &dlci->port.flags)) {
+	if (test_bit(ASY_ON, &dlci->port.iflags)) {
 		if (C_HUPCL(tty))
 			tty_port_lower_dtr_rts(&dlci->port);
 	}
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 3c99dde..6b3ce8f 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -495,7 +495,7 @@ static void rp_handle_port(struct r_port *info)
 	if (!info)
 		return;
 
-	if ((info->port.flags & ASYNC_INITIALIZED) == 0) {
+	if (!test_bit(ASY_ON, &info->port.iflags)) {
 		printk(KERN_WARNING "rp: WARNING: rp_handle_port called with "
 				"info->flags & NOT_INIT\n");
 		return;
@@ -920,7 +920,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 	/*
 	 * Info->count is now 1; so it's safe to sleep now.
 	 */
-	if (!test_bit(ASYNCB_INITIALIZED, &port->flags)) {
+	if (!test_bit(ASY_ON, &port->iflags)) {
 		cp = &info->channel;
 		sSetRxTrigger(cp, TRIG_1);
 		if (sGetChanStatus(cp) & CD_ACT)
@@ -944,7 +944,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 		sEnRxFIFO(cp);
 		sEnTransmit(cp);
 
-		set_bit(ASYNCB_INITIALIZED, &info->port.flags);
+		set_bit(ASY_ON, &info->port.iflags);
 
 		/*
 		 * Set up the tty->alt_speed kludge
@@ -1041,11 +1041,9 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 			info->xmit_buf = NULL;
 		}
 	}
-	spin_lock_irq(&port->lock);
-	info->port.flags &= ~ASYNC_INITIALIZED;
+	clear_bit(ASY_ON, &info->port.iflags);
 	clear_bit(ASY_ACTIVE, &info->port.iflags);
 	tty->closing = 0;
-	spin_unlock_irq(&port->lock);
 	mutex_unlock(&port->mutex);
 	tty_port_tty_set(port, NULL);
 
@@ -1513,7 +1511,7 @@ static void rp_hangup(struct tty_struct *tty)
 	sDisCTSFlowCtl(cp);
 	sDisTxSoftFlowCtl(cp);
 	sClrTxXOFF(cp);
-	clear_bit(ASYNCB_INITIALIZED, &info->port.flags);
+	clear_bit(ASY_ON, &info->port.iflags);
 
 	wake_up_interruptible(&info->port.open_wait);
 }
diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68328serial.c
index e94fa93..98d2ad5 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -375,7 +375,7 @@ static int startup(struct m68k_serial *info, struct tty_struct *tty)
 	m68328_uart *uart = &uart_addr[info->line];
 	unsigned long flags;
 	
-	if (info->tport.flags & ASYNC_INITIALIZED)
+	if (test_bit(ASY_ON, &info->tport.iflags))
 		return 0;
 
 	if (!info->xmit_buf) {
@@ -415,7 +415,7 @@ static int startup(struct m68k_serial *info, struct tty_struct *tty)
 
 	change_speed(info, tty);
 
-	info->tport.flags |= ASYNC_INITIALIZED;
+	set_bit(ASY_ON, &info->tport.iflags);
 	local_irq_restore(flags);
 	return 0;
 }
@@ -430,7 +430,7 @@ static void shutdown(struct m68k_serial *info, struct tty_struct *tty)
 	unsigned long	flags;
 
 	uart->ustcnt = 0; /* All off! */
-	if (!(info->tport.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->tport.iflags))
 		return;
 
 	local_irq_save(flags);
@@ -443,7 +443,7 @@ static void shutdown(struct m68k_serial *info, struct tty_struct *tty)
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 	
-	info->tport.flags &= ~ASYNC_INITIALIZED;
+	clear_bit(ASY_ON, &info->tport.iflags);
 	local_irq_restore(flags);
 }
 
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index fcacc1a..30a2198 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -2599,7 +2599,7 @@ startup(struct e100_serial * info)
 
 	/* if it was already initialized, skip this */
 
-	if (info->port.flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &info->port.iflags)) {
 		local_irq_restore(flags);
 		free_page(xmit_page);
 		return 0;
@@ -2703,7 +2703,7 @@ startup(struct e100_serial * info)
 	e100_rts(info, 1);
 	e100_dtr(info, 1);
 
-	info->port.flags |= ASYNC_INITIALIZED;
+	set_bit(ASY_ON, &info->port.iflags);
 
 	local_irq_restore(flags);
 	return 0;
@@ -2745,7 +2745,7 @@ shutdown(struct e100_serial * info)
 		info->tr_running = 0;
 	}
 
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		return;
 
 #ifdef SERIAL_DEBUG_OPEN
@@ -2776,7 +2776,7 @@ shutdown(struct e100_serial * info)
 	if (info->port.tty)
 		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
 
-	info->port.flags &= ~ASYNC_INITIALIZED;
+	clear_bit(ASY_ON, &info->port.iflags);
 	local_irq_restore(flags);
 }
 
@@ -3273,9 +3273,9 @@ set_serial_info(struct e100_serial *info,
 	info->port.low_latency = (info->port.flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
  check_and_exit:
-	if (info->port.flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &info->port.iflags))
 		change_speed(info);
-	} else
+	else
 		retval = startup(info);
 	return retval;
 }
@@ -3628,7 +3628,7 @@ rs_close(struct tty_struct *tty, struct file * filp)
 	e100_disable_rx(info);
 	e100_disable_rx_irq(info);
 
-	if (info->port.flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &info->port.iflags)) {
 		/*
 		 * Before we drop DTR, make sure the UART transmitter
 		 * has completely drained; this is especially
@@ -3789,7 +3789,7 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 		local_irq_restore(flags);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
-		    !(info->port.flags & ASYNC_INITIALIZED)) {
+		    !test_bit(ASY_ON, &info->port.iflags)) {
 #ifdef SERIAL_DO_RESTART
 			if (info->port.flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8b4fa9c..643af05 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -237,7 +237,7 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 	struct tty_port *port = &state->port;
 	int retval;
 
-	if (port->flags & ASYNC_INITIALIZED)
+	if (test_bit(ASY_ON, &port->iflags))
 		return 0;
 
 	/*
@@ -248,7 +248,7 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 
 	retval = uart_port_startup(tty, state, init_hw);
 	if (!retval) {
-		set_bit(ASYNCB_INITIALIZED, &port->flags);
+		set_bit(ASY_ON, &port->iflags);
 		clear_bit(TTY_IO_ERROR, &tty->flags);
 	} else if (retval > 0)
 		retval = 0;
@@ -274,7 +274,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 
-	if (test_and_clear_bit(ASYNCB_INITIALIZED, &port->flags)) {
+	if (test_and_clear_bit(ASY_ON, &port->iflags)) {
 		/*
 		 * Turn off DTR and RTS early.
 		 */
@@ -964,7 +964,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	retval = 0;
 	if (uport->type == PORT_UNKNOWN)
 		goto exit;
-	if (port->flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &port->iflags)) {
 		if (((old_flags ^ uport->flags) & UPF_SPD_MASK) ||
 		    old_custom_divisor != uport->custom_divisor) {
 			/*
@@ -1499,7 +1499,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	 * At this point, we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts.
 	 */
-	if ((port->flags & ASYNC_INITIALIZED) &&
+	if (test_bit(ASY_ON, &port->iflags) &&
 	    !WARN(!uport, "detached port still initialized!\n")) {
 		spin_lock_irq(&uport->lock);
 		uport->ops->stop_rx(uport);
@@ -2188,12 +2188,12 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 
 	uport->suspended = 1;
 
-	if (port->flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &port->iflags)) {
 		const struct uart_ops *ops = uport->ops;
 		int tries;
 
 		set_bit(ASY_SUSPENDED, &port->iflags);
-		clear_bit(ASYNCB_INITIALIZED, &port->flags);
+		clear_bit(ASY_ON, &port->iflags);
 
 		spin_lock_irq(&uport->lock);
 		ops->stop_tx(uport);
@@ -2292,7 +2292,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 				ops->set_mctrl(uport, uport->mctrl);
 				ops->start_tx(uport);
 				spin_unlock_irq(&uport->lock);
-				set_bit(ASYNCB_INITIALIZED, &port->flags);
+				set_bit(ASY_ON, &port->iflags);
 			} else {
 				/*
 				 * Failed to resume - maybe hardware went away?
@@ -2434,10 +2434,10 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 	ret = 0;
 	if (uport->ops->poll_init) {
 		/*
-		 * We don't set ASYNCB_INITIALIZED as we only initialized the
-		 * hw, e.g. state->xmit is still uninitialized.
+		 * We don't set ASY_ON as we only initialized the hw,
+		 * e.g. state->xmit is still uninitialized.
 		 */
-		if (!test_bit(ASYNCB_INITIALIZED, &port->flags))
+		if (!test_bit(ASY_ON, &port->iflags))
 			ret = uport->ops->poll_init(uport);
 	}
 
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index a98d63c..4c5e061 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -1749,13 +1749,13 @@ static irqreturn_t mgsl_interrupt(int dummy, void *dev_id)
 static int startup(struct mgsl_struct * info)
 {
 	int retval = 0;
-	
+
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk("%s(%d):mgsl_startup(%s)\n",__FILE__,__LINE__,info->device_name);
-		
-	if (info->port.flags & ASYNC_INITIALIZED)
+
+	if (test_bit(ASY_ON, &info->port.iflags))
 		return 0;
-	
+
 	if (!info->xmit_buf) {
 		/* allocate a page of memory for a transmit buffer */
 		info->xmit_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
@@ -1788,14 +1788,13 @@ static int startup(struct mgsl_struct * info)
 
 	/* program hardware for current parameters */
 	mgsl_change_params(info);
-	
+
 	if (info->port.tty)
 		clear_bit(TTY_IO_ERROR, &info->port.tty->flags);
 
-	info->port.flags |= ASYNC_INITIALIZED;
-	
+	set_bit(ASY_ON, &info->port.iflags);
+
 	return 0;
-	
 }	/* end of startup() */
 
 /* shutdown()
@@ -1808,8 +1807,8 @@ static int startup(struct mgsl_struct * info)
 static void shutdown(struct mgsl_struct * info)
 {
 	unsigned long flags;
-	
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		return;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -1853,13 +1852,12 @@ static void shutdown(struct mgsl_struct * info)
 
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
-	mgsl_release_resources(info);	
-	
+	mgsl_release_resources(info);
+
 	if (info->port.tty)
 		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
 
-	info->port.flags &= ~ASYNC_INITIALIZED;
-	
+	clear_bit(ASY_ON, &info->port.iflags);
 }	/* end of shutdown() */
 
 static void mgsl_program_hw(struct mgsl_struct *info)
@@ -3091,7 +3089,7 @@ static void mgsl_close(struct tty_struct *tty, struct file * filp)
 		goto cleanup;
 
 	mutex_lock(&info->port.mutex);
- 	if (info->port.flags & ASYNC_INITIALIZED)
+ 	if (test_bit(ASY_ON, &info->port.iflags))
  		mgsl_wait_until_sent(tty, info->timeout);
 	mgsl_flush_buffer(tty);
 	tty_ldisc_flush(tty);
@@ -3129,15 +3127,15 @@ static void mgsl_wait_until_sent(struct tty_struct *tty, int timeout)
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_wait_until_sent(%s) entry\n",
 			 __FILE__,__LINE__, info->device_name );
-      
+
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_wait_until_sent"))
 		return;
 
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		goto exit;
-	 
+
 	orig_jiffies = jiffies;
-      
+
 	/* Set check interval to 1/5 of estimated time to
 	 * send a character, and make it at least 1. The check
 	 * interval should also be less than the timeout.
@@ -3297,14 +3295,14 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 	port->count--;
 	spin_unlock_irqrestore(&info->irq_spinlock, flags);
 	port->blocked_open++;
-	
+
 	while (1) {
-		if (C_BAUD(tty) && test_bit(ASYNCB_INITIALIZED, &port->flags))
+		if (C_BAUD(tty) && test_bit(ASY_ON, &port->iflags))
 			tty_port_raise_dtr_rts(port);
-		
+
 		set_current_state(TASK_INTERRUPTIBLE);
-		
-		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)){
+
+		if (tty_hung_up_p(filp) || !test_bit(ASY_ON, &port->iflags)) {
 			retval = (port->flags & ASYNC_HUP_NOTIFY) ?
 					-EAGAIN : -ERESTARTSYS;
 			break;
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 63c95f8..fdcd5ed 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -726,7 +726,7 @@ static void close(struct tty_struct *tty, struct file *filp)
 		goto cleanup;
 
 	mutex_lock(&info->port.mutex);
- 	if (info->port.flags & ASYNC_INITIALIZED)
+ 	if (test_bit(ASY_ON, &info->port.iflags))
  		wait_until_sent(tty, info->timeout);
 	flush_buffer(tty);
 	tty_ldisc_flush(tty);
@@ -893,7 +893,7 @@ static void wait_until_sent(struct tty_struct *tty, int timeout)
 	if (sanity_check(info, tty->name, "wait_until_sent"))
 		return;
 	DBGINFO(("%s wait_until_sent entry\n", info->device_name));
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		goto exit;
 
 	orig_jiffies = jiffies;
@@ -2421,7 +2421,7 @@ static int startup(struct slgt_info *info)
 {
 	DBGINFO(("%s startup\n", info->device_name));
 
-	if (info->port.flags & ASYNC_INITIALIZED)
+	if (test_bit(ASY_ON, &info->port.iflags))
 		return 0;
 
 	if (!info->tx_buf) {
@@ -2442,7 +2442,7 @@ static int startup(struct slgt_info *info)
 	if (info->port.tty)
 		clear_bit(TTY_IO_ERROR, &info->port.tty->flags);
 
-	info->port.flags |= ASYNC_INITIALIZED;
+	set_bit(ASY_ON, &info->port.iflags);
 
 	return 0;
 }
@@ -2454,7 +2454,7 @@ static void shutdown(struct slgt_info *info)
 {
 	unsigned long flags;
 
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		return;
 
 	DBGINFO(("%s shutdown\n", info->device_name));
@@ -2489,7 +2489,7 @@ static void shutdown(struct slgt_info *info)
 	if (info->port.tty)
 		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
 
-	info->port.flags &= ~ASYNC_INITIALIZED;
+	clear_bit(ASY_ON, &info->port.iflags);
 }
 
 static void program_hw(struct slgt_info *info)
@@ -3294,12 +3294,12 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	port->blocked_open++;
 
 	while (1) {
-		if (C_BAUD(tty) && test_bit(ASYNCB_INITIALIZED, &port->flags))
+		if (C_BAUD(tty) && test_bit(ASY_ON, &port->iflags))
 			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)){
+		if (tty_hung_up_p(filp) || !test_bit(ASY_ON, &port->iflags)) {
 			retval = (port->flags & ASYNC_HUP_NOTIFY) ?
 					-EAGAIN : -ERESTARTSYS;
 			break;
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 5325934..8b6d9ee 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -812,7 +812,7 @@ static void close(struct tty_struct *tty, struct file *filp)
 		goto cleanup;
 
 	mutex_lock(&info->port.mutex);
- 	if (info->port.flags & ASYNC_INITIALIZED)
+ 	if (test_bit(ASY_ON, &info->port.iflags))
  		wait_until_sent(tty, info->timeout);
 
 	flush_buffer(tty);
@@ -1061,7 +1061,7 @@ static void wait_until_sent(struct tty_struct *tty, int timeout)
 	if (sanity_check(info, tty->name, "wait_until_sent"))
 		return;
 
-	if (!test_bit(ASYNCB_INITIALIZED, &info->port.flags))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		goto exit;
 
 	orig_jiffies = jiffies;
@@ -2636,7 +2636,7 @@ static int startup(SLMP_INFO * info)
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk("%s(%d):%s tx_releaseup()\n",__FILE__,__LINE__,info->device_name);
 
-	if (info->port.flags & ASYNC_INITIALIZED)
+	if (test_bit(ASY_ON, &info->port.iflags))
 		return 0;
 
 	if (!info->tx_buf) {
@@ -2662,7 +2662,7 @@ static int startup(SLMP_INFO * info)
 	if (info->port.tty)
 		clear_bit(TTY_IO_ERROR, &info->port.tty->flags);
 
-	info->port.flags |= ASYNC_INITIALIZED;
+	set_bit(ASY_ON, &info->port.iflags);
 
 	return 0;
 }
@@ -2673,7 +2673,7 @@ static void shutdown(SLMP_INFO * info)
 {
 	unsigned long flags;
 
-	if (!(info->port.flags & ASYNC_INITIALIZED))
+	if (!test_bit(ASY_ON, &info->port.iflags))
 		return;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -2705,7 +2705,7 @@ static void shutdown(SLMP_INFO * info)
 	if (info->port.tty)
 		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
 
-	info->port.flags &= ~ASYNC_INITIALIZED;
+	clear_bit(ASY_ON, &info->port.iflags);
 }
 
 static void program_hw(SLMP_INFO *info)
@@ -3315,12 +3315,12 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	port->blocked_open++;
 
 	while (1) {
-		if (C_BAUD(tty) && test_bit(ASYNCB_INITIALIZED, &port->flags))
+		if (C_BAUD(tty) && test_bit(ASY_ON, &port->iflags))
 			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)){
+		if (tty_hung_up_p(filp) || !test_bit(ASY_ON, &port->iflags)) {
 			retval = (port->flags & ASYNC_HUP_NOTIFY) ?
 					-EAGAIN : -ERESTARTSYS;
 			break;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 6d2e1ef..1a1d983 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -204,7 +204,7 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 	if (port->console)
 		goto out;
 
-	if (test_and_clear_bit(ASYNCB_INITIALIZED, &port->flags)) {
+	if (test_and_clear_bit(ASY_ON, &port->iflags)) {
 		/*
 		 * Drop DTR/RTS if HUPCL is set. This causes any attached
 		 * modem to hang up the line.
@@ -234,9 +234,10 @@ void tty_port_hangup(struct tty_port *port)
 	struct tty_struct *tty;
 	unsigned long flags;
 
+	clear_bit(ASY_ACTIVE, &port->iflags);
+
 	spin_lock_irqsave(&port->lock, flags);
 	port->count = 0;
-	clear_bit(ASY_ACTIVE, &port->iflags);
 	tty = port->tty;
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
@@ -393,13 +394,13 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 	while (1) {
 		/* Indicate we are open */
-		if (C_BAUD(tty) && test_bit(ASYNCB_INITIALIZED, &port->flags))
+		if (C_BAUD(tty) && test_bit(ASY_ON, &port->iflags))
 			tty_port_raise_dtr_rts(port);
 
 		prepare_to_wait(&port->open_wait, &wait, TASK_INTERRUPTIBLE);
 		/* Check for a hangup or uninitialised port.
 							Return accordingly */
-		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
+		if (tty_hung_up_p(filp) || !test_bit(ASY_ON, &port->iflags)) {
 			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
@@ -430,9 +431,9 @@ int tty_port_block_til_ready(struct tty_port *port,
 	if (!tty_hung_up_p(filp))
 		port->count++;
 	port->blocked_open--;
+	spin_unlock_irqrestore(&port->lock, flags);
 	if (retval == 0)
 		set_bit(ASY_ACTIVE, &port->iflags);
-	spin_unlock_irqrestore(&port->lock, flags);
 	return retval;
 }
 EXPORT_SYMBOL(tty_port_block_til_ready);
@@ -480,7 +481,7 @@ int tty_port_close_start(struct tty_port *port,
 
 	tty->closing = 1;
 
-	if (test_bit(ASYNCB_INITIALIZED, &port->flags)) {
+	if (test_bit(ASY_ON, &port->iflags)) {
 		/* Don't block on a stalled port, just pull the chain */
 		if (tty->flow_stopped)
 			tty_driver_flush_buffer(tty);
@@ -516,8 +517,8 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 		spin_lock_irqsave(&port->lock, flags);
 		wake_up_interruptible(&port->open_wait);
 	}
-	clear_bit(ASY_ACTIVE, &port->iflags);
 	spin_unlock_irqrestore(&port->lock, flags);
+	clear_bit(ASY_ACTIVE, &port->iflags);
 }
 EXPORT_SYMBOL(tty_port_close_end);
 
@@ -580,7 +581,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 
 	mutex_lock(&port->mutex);
 
-	if (!test_bit(ASYNCB_INITIALIZED, &port->flags)) {
+	if (!test_bit(ASY_ON, &port->iflags)) {
 		clear_bit(TTY_IO_ERROR, &tty->flags);
 		if (port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
@@ -589,7 +590,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 				return retval;
 			}
 		}
-		set_bit(ASYNCB_INITIALIZED, &port->flags);
+		set_bit(ASY_ON, &port->iflags);
 	}
 	mutex_unlock(&port->mutex);
 	return tty_port_block_til_ready(port, tty, filp);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 26ca4f9..a495c38 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1605,7 +1605,7 @@ static int acm_resume(struct usb_interface *intf)
 	if (--acm->susp_count)
 		goto out;
 
-	if (test_bit(ASYNCB_INITIALIZED, &acm->port.flags)) {
+	if (test_bit(ASY_ON, &acm->port.iflags)) {
 		rv = usb_submit_urb(acm->ctrlurb, GFP_ATOMIC);
 
 		for (;;) {
@@ -1635,7 +1635,7 @@ static int acm_reset_resume(struct usb_interface *intf)
 {
 	struct acm *acm = usb_get_intfdata(intf);
 
-	if (test_bit(ASYNCB_INITIALIZED, &acm->port.flags))
+	if (test_bit(ASY_ON, &acm->port.iflags))
 		tty_port_tty_hangup(&acm->port, false);
 
 	return acm_resume(intf);
diff --git a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
index a66b01b..9f4af3d 100644
--- a/drivers/usb/serial/console.c
+++ b/drivers/usb/serial/console.c
@@ -127,7 +127,7 @@ static int usb_console_setup(struct console *co, char *options)
 	info->port = port;
 
 	++port->port.count;
-	if (!test_bit(ASYNCB_INITIALIZED, &port->port.flags)) {
+	if (!test_bit(ASY_ON, &port->port.iflags)) {
 		if (serial->type->set_termios) {
 			/*
 			 * allocate a fake tty so the driver can initialize
@@ -168,7 +168,7 @@ static int usb_console_setup(struct console *co, char *options)
 			tty_port_tty_set(&port->port, NULL);
 			tty_kref_put(tty);
 		}
-		set_bit(ASYNCB_INITIALIZED, &port->port.flags);
+		set_bit(ASY_ON, &port->port.iflags);
 	}
 	/* Now that any required fake tty operations are completed restore
 	 * the tty port count */
diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 54e170d..0804308 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -473,7 +473,7 @@ static bool usb_serial_generic_msr_changed(struct tty_struct *tty,
 	 * Use tty-port initialised flag to detect all hangups including the
 	 * one generated at USB-device disconnect.
 	 */
-	if (!test_bit(ASYNCB_INITIALIZED, &port->port.flags))
+	if (!test_bit(ASY_ON, &port->port.iflags))
 		return true;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -503,7 +503,7 @@ int usb_serial_generic_tiocmiwait(struct tty_struct *tty, unsigned long arg)
 
 	ret = wait_event_interruptible(port->port.delta_msr_wait,
 			usb_serial_generic_msr_changed(tty, arg, &cnow));
-	if (!ret && !test_bit(ASYNCB_INITIALIZED, &port->port.flags))
+	if (!ret && !test_bit(ASY_ON, &port->port.iflags))
 		ret = -EIO;
 
 	return ret;
@@ -606,7 +606,7 @@ int usb_serial_generic_resume(struct usb_serial *serial)
 
 	for (i = 0; i < serial->num_ports; i++) {
 		port = serial->port[i];
-		if (!test_bit(ASYNCB_INITIALIZED, &port->port.flags))
+		if (!test_bit(ASY_ON, &port->port.iflags))
 			continue;
 
 		if (port->bulk_in_size) {
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index 31a8b47..063080c 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -503,7 +503,7 @@ static void mxuport_process_read_urb_demux_data(struct urb *urb)
 			return;
 		}
 
-		if (test_bit(ASYNCB_INITIALIZED, &demux_port->port.flags)) {
+		if (test_bit(ASY_ON, &demux_port->port.iflags)) {
 			ch = data + HEADER_SIZE;
 			mxuport_process_read_urb_data(demux_port, ch, rcv_len);
 		} else {
@@ -544,7 +544,7 @@ static void mxuport_process_read_urb_demux_event(struct urb *urb)
 		}
 
 		demux_port = serial->port[rcv_port];
-		if (test_bit(ASYNCB_INITIALIZED, &demux_port->port.flags)) {
+		if (test_bit(ASY_ON, &demux_port->port.iflags)) {
 			ch = data + HEADER_SIZE;
 			rcv_event = get_unaligned_be16(data + 2);
 			mxuport_process_read_urb_event(demux_port, ch,
@@ -1339,7 +1339,7 @@ static int mxuport_resume(struct usb_serial *serial)
 
 	for (i = 0; i < serial->num_ports; i++) {
 		port = serial->port[i];
-		if (!test_bit(ASYNCB_INITIALIZED, &port->port.flags))
+		if (!test_bit(ASY_ON, &port->port.iflags))
 			continue;
 
 		r = usb_serial_generic_write_start(port, GFP_NOIO);
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 07d1ecd..533a8d1 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -776,7 +776,7 @@ static void sierra_close(struct usb_serial_port *port)
 
 	/*
 	 * Need to take susp_lock to make sure port is not already being
-	 * resumed, but no need to hold it due to ASYNC_INITIALIZED.
+	 * resumed, but no need to hold it due to ASY_ON.
 	 */
 	spin_lock_irq(&intfdata->susp_lock);
 	if (--intfdata->open_ports == 0)
@@ -1039,7 +1039,7 @@ static int sierra_resume(struct usb_serial *serial)
 	for (i = 0; i < serial->num_ports; i++) {
 		port = serial->port[i];
 
-		if (!test_bit(ASYNCB_INITIALIZED, &port->port.flags))
+		if (!test_bit(ASY_ON, &port->port.iflags))
 			continue;
 
 		err = sierra_submit_delayed_urbs(port);
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 46f1f13..2a48de9 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -254,7 +254,7 @@ static int serial_open(struct tty_struct *tty, struct file *filp)
  *
  * Shut down a USB serial port. Serialized against activate by the
  * tport mutex and kept to matching open/close pairs
- * of calls by the ASYNCB_INITIALIZED flag.
+ * of calls by the ASY_ON flag.
  *
  * Not called if tty is console.
  */
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index be9cb61..198d743 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -464,7 +464,7 @@ void usb_wwan_close(struct usb_serial_port *port)
 
 	/*
 	 * Need to take susp_lock to make sure port is not already being
-	 * resumed, but no need to hold it due to ASYNC_INITIALIZED.
+	 * resumed, but no need to hold it due to ASY_ON.
 	 */
 	spin_lock_irq(&intfdata->susp_lock);
 	if (--intfdata->open_ports == 0)
@@ -682,7 +682,7 @@ int usb_wwan_resume(struct usb_serial *serial)
 	for (i = 0; i < serial->num_ports; i++) {
 		port = serial->port[i];
 
-		if (!test_bit(ASYNCB_INITIALIZED, &port->port.flags))
+		if (!test_bit(ASY_ON, &port->port.iflags))
 			continue;
 
 		portdata = usb_get_serial_port_data(port);
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index b3220e5..20c0adc 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -220,7 +220,7 @@ static int ircomm_tty_startup(struct ircomm_tty_cb *self)
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
 	/* Check if already open */
-	if (test_and_set_bit(ASYNCB_INITIALIZED, &self->port.flags)) {
+	if (test_and_set_bit(ASY_ON, &self->port.iflags)) {
 		pr_debug("%s(), already open so break out!\n", __func__);
 		return 0;
 	}
@@ -257,7 +257,7 @@ static int ircomm_tty_startup(struct ircomm_tty_cb *self)
 
 	return 0;
 err:
-	clear_bit(ASYNCB_INITIALIZED, &self->port.flags);
+	clear_bit(ASY_ON, &self->port.iflags);
 	return ret;
 }
 
@@ -318,13 +318,12 @@ static int ircomm_tty_block_til_ready(struct ircomm_tty_cb *self,
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	while (1) {
-		if (C_BAUD(tty) && test_bit(ASYNCB_INITIALIZED, &port->flags))
+		if (C_BAUD(tty) && test_bit(ASY_ON, &port->iflags))
 			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (tty_hung_up_p(filp) ||
-		    !test_bit(ASYNCB_INITIALIZED, &port->flags)) {
+		if (tty_hung_up_p(filp) || !test_bit(ASY_ON, &port->iflags)) {
 			retval = (port->flags & ASYNC_HUP_NOTIFY) ?
 					-EAGAIN : -ERESTARTSYS;
 			break;
@@ -876,7 +875,7 @@ static void ircomm_tty_shutdown(struct ircomm_tty_cb *self)
 	IRDA_ASSERT(self != NULL, return;);
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
-	if (!test_and_clear_bit(ASYNCB_INITIALIZED, &self->port.flags))
+	if (!test_and_clear_bit(ASY_ON, &self->port.iflags))
 		return;
 
 	ircomm_tty_detach_cable(self);
@@ -1259,7 +1258,7 @@ static void ircomm_tty_line_info(struct ircomm_tty_cb *self, struct seq_file *m)
 		seq_printf(m, "%cASYNC_CHECK_CD", sep);
 		sep = '|';
 	}
-	if (self->port.flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &self->port.iflags)) {
 		seq_printf(m, "%cASYNC_INITIALIZED", sep);
 		sep = '|';
 	}
diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index f74541c..ca4d17c 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -328,7 +328,7 @@ static int ircomm_tty_set_serial_info(struct ircomm_tty_cb *self,
 
  check_and_exit:
 
-	if (self->flags & ASYNC_INITIALIZED) {
+	if (test_bit(ASY_ON, &self->iflags) {
 		if (((old_state.flags & ASYNC_SPD_MASK) !=
 		     (self->flags & ASYNC_SPD_MASK)) ||
 		    (old_driver.custom_divisor != driver->custom_divisor)) {
-- 
2.7.0
