From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] tty: Replace TTY_THROTTLED bit tests with tty_throttled()
Date: Sat,  9 Apr 2016 17:11:36 -0700
Message-ID: <1460247096-6552-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Abstract TTY_THROTTLED bit tests with tty_throttled().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/char/pcmcia/synclink_cs.c      | 2 +-
 drivers/mmc/card/sdio_uart.c           | 2 +-
 drivers/net/usb/hso.c                  | 2 +-
 drivers/staging/fwserial/fwserial.c    | 2 +-
 drivers/staging/speakup/selection.c    | 2 +-
 drivers/tty/amiserial.c                | 2 +-
 drivers/tty/hvc/hvc_console.c          | 2 +-
 drivers/tty/hvc/hvcs.c                 | 2 +-
 drivers/tty/hvc/hvsi.c                 | 2 +-
 drivers/tty/moxa.c                     | 2 +-
 drivers/tty/nozomi.c                   | 2 +-
 drivers/tty/serial/serial_core.c       | 2 +-
 drivers/tty/synclink.c                 | 2 +-
 drivers/tty/synclink_gt.c              | 2 +-
 drivers/tty/synclinkmp.c               | 2 +-
 drivers/tty/tty_ioctl.c                | 4 ++--
 drivers/tty/vt/selection.c             | 2 +-
 drivers/usb/gadget/function/u_serial.c | 4 ++--
 drivers/usb/serial/digi_acceleport.c   | 3 +--
 include/linux/tty.h                    | 5 +++++
 net/irda/ircomm/ircomm_tty_ioctl.c     | 2 +-
 21 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 825db42..bcae5bb 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -2316,7 +2316,7 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
 		info->serial_signals |= SerialSignal_DTR;
-		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
 			info->serial_signals |= SerialSignal_RTS;
 		spin_lock_irqsave(&info->lock, flags);
 		set_signals(info);
diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index 5415056..5af6fb9 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -895,7 +895,7 @@ static void sdio_uart_set_termios(struct tty_struct *tty,
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		unsigned int mask = TIOCM_DTR;
-		if (!(cflag & CRTSCTS) || !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!(cflag & CRTSCTS) || !tty_throttled(tty))
 			mask |= TIOCM_RTS;
 		sdio_uart_set_mctrl(port, mask);
 	}
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 111d907..4b44586 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2029,7 +2029,7 @@ static int put_rxbuf_data(struct urb *urb, struct hso_serial *serial)
 
 	tty = tty_port_tty_get(&serial->port);
 
-	if (tty && test_bit(TTY_THROTTLED, &tty->flags)) {
+	if (tty && tty_throttled(tty)) {
 		tty_kref_put(tty);
 		return -1;
 	}
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 9b23b5c..1f9389d 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1305,7 +1305,7 @@ static void fwtty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	if ((baud == 0) && (old->c_cflag & CBAUD)) {
 		port->mctrl &= ~(TIOCM_DTR | TIOCM_RTS);
 	} else if ((baud != 0) && !(old->c_cflag & CBAUD)) {
-		if (C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
+		if (C_CRTSCTS(tty) || !tty_throttled(tty))
 			port->mctrl |= TIOCM_DTR | TIOCM_RTS;
 		else
 			port->mctrl |= TIOCM_DTR;
diff --git a/drivers/staging/speakup/selection.c b/drivers/staging/speakup/selection.c
index 41ef099..0149edc 100644
--- a/drivers/staging/speakup/selection.c
+++ b/drivers/staging/speakup/selection.c
@@ -150,7 +150,7 @@ static void __speakup_paste_selection(struct work_struct *work)
 	add_wait_queue(&vc->paste_wait, &wait);
 	while (sel_buffer && sel_buffer_lth > pasted) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (test_bit(TTY_THROTTLED, &tty->flags)) {
+		if (tty_throttled(tty)) {
 			schedule();
 			continue;
 		}
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 183e98e..e68208e 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1342,7 +1342,7 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		info->MCR |= SER_DTR;
-		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
 			info->MCR |= SER_RTS;
 		local_irq_save(flags);
 		rtsdtr_ctrl(info->MCR);
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index e46d628..209dad8 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -632,7 +632,7 @@ int hvc_poll(struct hvc_struct *hp)
 		goto bail;
 
 	/* Now check if we can get data (are we throttled ?) */
-	if (test_bit(TTY_THROTTLED, &tty->flags))
+	if (tty_throttled(tty))
 		goto throttled;
 
 	/* If we aren't notifier driven and aren't throttled, we always
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 5997b17..3c4d7c2 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -600,7 +600,7 @@ static int hvcs_io(struct hvcs_struct *hvcsd)
 
 	hvcs_try_write(hvcsd);
 
-	if (!tty || test_bit(TTY_THROTTLED, &tty->flags)) {
+	if (!tty || tty_throttled(tty)) {
 		hvcsd->todo_mask &= ~(HVCS_READ_MASK);
 		goto bail;
 	} else if (!(hvcsd->todo_mask & (HVCS_READ_MASK)))
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index a75146f..96ce6bd 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -509,7 +509,7 @@ static irqreturn_t hvsi_interrupt(int irq, void *arg)
 	}
 
 	spin_lock_irqsave(&hp->lock, flags);
-	if (tty && hp->n_throttle && !test_bit(TTY_THROTTLED, &tty->flags)) {
+	if (tty && hp->n_throttle && !tty_throttled(tty)) {
 		/* we weren't hung up and we weren't throttled, so we can
 		 * deliver the rest now */
 		hvsi_send_overflow(hp);
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 92982d7..ce521d3 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1394,7 +1394,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 			tty_wakeup(tty);
 		}
 
-		if (inited && !test_bit(TTY_THROTTLED, &tty->flags) &&
+		if (inited && !tty_throttled(tty) &&
 				MoxaPortRxQueue(p) > 0) { /* RX */
 			MoxaPortReadData(p);
 			tty_schedule_flip(&p->port);
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 5cc80b8..d6fd0e8 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -826,7 +826,7 @@ static int receive_data(enum port_type index, struct nozomi *dc)
 	size = __le32_to_cpu(readl(addr));
 	/*  DBG1( "%d bytes port: %d", size, index); */
 
-	if (tty && test_bit(TTY_THROTTLED, &tty->flags)) {
+	if (tty && tty_throttled(tty)) {
 		DBG1("No room in tty, don't read data, don't ack interrupt, "
 			"disable interrupt");
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 67b3950..64a5c00 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1350,7 +1350,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	/* Handle transition away from B0 status */
 	else if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		unsigned int mask = TIOCM_DTR;
-		if (!(cflag & CRTSCTS) || !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!(cflag & CRTSCTS) || !tty_throttled(tty))
 			mask |= TIOCM_RTS;
 		uart_set_mctrl(uport, mask);
 	}
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 8b22772..3768e5c 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -3049,7 +3049,7 @@ static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termio
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
 		info->serial_signals |= SerialSignal_DTR;
-		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
 			info->serial_signals |= SerialSignal_RTS;
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 	 	usc_set_serial_signals(info);
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 1f7d6d9..ceeaeb7 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -784,7 +784,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
 		info->signals |= SerialSignal_DTR;
- 		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
 			info->signals |= SerialSignal_RTS;
 		spin_lock_irqsave(&info->lock,flags);
 	 	set_signals(info);
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index e938799..b0cce4b 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -881,7 +881,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
 		info->serial_signals |= SerialSignal_DTR;
- 		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
 			info->serial_signals |= SerialSignal_RTS;
 		spin_lock_irqsave(&info->lock,flags);
 	 	set_signals(info);
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 23bf5bb..bf36ac9 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -158,7 +158,7 @@ int tty_throttle_safe(struct tty_struct *tty)
 	int ret = 0;
 
 	mutex_lock(&tty->throttle_mutex);
-	if (!test_bit(TTY_THROTTLED, &tty->flags)) {
+	if (!tty_throttled(tty)) {
 		if (tty->flow_change != TTY_THROTTLE_SAFE)
 			ret = 1;
 		else {
@@ -189,7 +189,7 @@ int tty_unthrottle_safe(struct tty_struct *tty)
 	int ret = 0;
 
 	mutex_lock(&tty->throttle_mutex);
-	if (test_bit(TTY_THROTTLED, &tty->flags)) {
+	if (tty_throttled(tty)) {
 		if (tty->flow_change != TTY_UNTHROTTLE_SAFE)
 			ret = 1;
 		else {
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 4dd9dd2..368ce18 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -354,7 +354,7 @@ int paste_selection(struct tty_struct *tty)
 	add_wait_queue(&vc->paste_wait, &wait);
 	while (sel_buffer && sel_buffer_lth > pasted) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (test_bit(TTY_THROTTLED, &tty->flags)) {
+		if (tty_throttled(tty)) {
 			schedule();
 			continue;
 		}
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 6af145f..3580f19 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -512,7 +512,7 @@ static void gs_rx_push(unsigned long _port)
 		req = list_first_entry(queue, struct usb_request, list);
 
 		/* leave data queued if tty was rx throttled */
-		if (tty && test_bit(TTY_THROTTLED, &tty->flags))
+		if (tty && tty_throttled(tty))
 			break;
 
 		switch (req->status) {
@@ -579,7 +579,7 @@ static void gs_rx_push(unsigned long _port)
 	 * from starving ... but it's not clear that case ever happens.
 	 */
 	if (!list_empty(queue) && tty) {
-		if (!test_bit(TTY_THROTTLED, &tty->flags)) {
+		if (!tty_throttled(tty)) {
 			if (do_push)
 				tasklet_schedule(&port->push);
 			else
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 010a42a..6138b20 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -699,8 +699,7 @@ static void digi_set_termios(struct tty_struct *tty,
 			/* don't set RTS if using hardware flow control */
 			/* and throttling input */
 			modem_signals = TIOCM_DTR;
-			if (!C_CRTSCTS(tty) ||
-			    !test_bit(TTY_THROTTLED, &tty->flags))
+			if (!C_CRTSCTS(tty) || !tty_throttled(tty))
 				modem_signals |= TIOCM_RTS;
 			digi_set_modem_signals(port, modem_signals, 1);
 		}
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 68d829b..89f9c91 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -365,6 +365,11 @@ static inline bool tty_io_error(struct tty_struct *tty)
 	return test_bit(TTY_IO_ERROR, &tty->flags);
 }
 
+static inline bool tty_throttled(struct tty_struct *tty)
+{
+	return test_bit(TTY_THROTTLED, &tty->flags);
+}
+
 #ifdef CONFIG_TTY
 extern void console_init(void);
 extern void tty_kref_put(struct tty_struct *tty);
diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index 9beb011..8d8fd28 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -166,7 +166,7 @@ void ircomm_tty_set_termios(struct tty_struct *tty,
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		self->settings.dte |= IRCOMM_DTR;
-		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
 			self->settings.dte |= IRCOMM_RTS;
 		ircomm_param_request(self, IRCOMM_DTE, TRUE);
 	}
-- 
2.8.1
