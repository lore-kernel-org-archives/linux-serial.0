From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 8/9] tty: Use termios c_*flag macros
Date: Sun, 10 Jan 2016 20:36:15 -0800
Message-ID: <1452486976-7594-9-git-send-email-peter@hurleysoftware.com>
References: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Expressions of the form "tty->termios.c_*flag & FLAG"
are more clearly expressed with the termios flags macros,
I_FLAG(), C_FLAG(), O_FLAG(), and L_FLAG().

Convert treewide.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/char/pcmcia/synclink_cs.c    | 21 ++++++++-------------
 drivers/mmc/card/sdio_uart.c         | 14 +++++++-------
 drivers/staging/dgap/dgap.c          |  2 +-
 drivers/staging/dgnc/dgnc_tty.c      |  2 +-
 drivers/tty/amiserial.c              | 22 ++++++++--------------
 drivers/tty/cyclades.c               | 14 ++++++--------
 drivers/tty/isicom.c                 |  3 +--
 drivers/tty/mxser.c                  | 10 ++++------
 drivers/tty/n_gsm.c                  |  6 +++---
 drivers/tty/pty.c                    |  3 +--
 drivers/tty/rocket.c                 |  8 ++++----
 drivers/tty/serial/68328serial.c     |  4 +---
 drivers/tty/serial/crisv10.c         | 18 +++++++-----------
 drivers/tty/serial/jsm/jsm_tty.c     |  3 +--
 drivers/tty/serial/serial_core.c     | 20 +++++++++-----------
 drivers/tty/synclink.c               | 23 +++++++++--------------
 drivers/tty/synclink_gt.c            | 19 +++++++------------
 drivers/tty/synclinkmp.c             | 19 +++++++------------
 drivers/tty/tty_ioctl.c              | 12 ++++++------
 drivers/tty/tty_port.c               |  2 +-
 drivers/usb/serial/cypress_m8.c      |  3 +--
 drivers/usb/serial/digi_acceleport.c |  8 ++++----
 drivers/usb/serial/io_edgeport.c     |  4 ++--
 drivers/usb/serial/mct_u232.c        |  2 +-
 drivers/usb/serial/mos7720.c         |  4 ++--
 drivers/usb/serial/mos7840.c         |  4 ++--
 net/irda/ircomm/ircomm_tty.c         | 11 +++++------
 net/irda/ircomm/ircomm_tty_ioctl.c   | 13 ++++---------
 28 files changed, 113 insertions(+), 161 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 45df4bf..22c2765 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1349,7 +1349,7 @@ static void shutdown(MGSLPC_INFO * info, struct tty_struct *tty)
 	/* TODO:disable interrupts instead of reset to preserve signal states */
 	reset_device(info);
 
-	if (!tty || tty->termios.c_cflag & HUPCL) {
+	if (!tty || C_HUPCL(tty)) {
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		set_signals(info);
 	}
@@ -1390,7 +1390,7 @@ static void mgslpc_program_hw(MGSLPC_INFO *info, struct tty_struct *tty)
 	port_irq_enable(info, (unsigned char) PVR_DSR | PVR_RI);
 	get_signals(info);
 
-	if (info->netcount || (tty && (tty->termios.c_cflag & CREAD)))
+	if (info->netcount || (tty && C_CREAD(tty)))
 		rx_start(info);
 
 	spin_unlock_irqrestore(&info->lock, flags);
@@ -1733,7 +1733,7 @@ static void mgslpc_throttle(struct tty_struct * tty)
 	if (I_IXOFF(tty))
 		mgslpc_send_xchar(tty, STOP_CHAR(tty));
 
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock, flags);
 		info->serial_signals &= ~SerialSignal_RTS;
 		set_signals(info);
@@ -1762,7 +1762,7 @@ static void mgslpc_unthrottle(struct tty_struct * tty)
 			mgslpc_send_xchar(tty, START_CHAR(tty));
 	}
 
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock, flags);
 		info->serial_signals |= SerialSignal_RTS;
 		set_signals(info);
@@ -2306,8 +2306,7 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 	mgslpc_change_params(info, tty);
 
 	/* Handle transition to B0 status */
-	if (old_termios->c_cflag & CBAUD &&
-	    !(tty->termios.c_cflag & CBAUD)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		spin_lock_irqsave(&info->lock, flags);
 		set_signals(info);
@@ -2315,21 +2314,17 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) &&
-	    tty->termios.c_cflag & CBAUD) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
 		info->serial_signals |= SerialSignal_DTR;
-		if (!(tty->termios.c_cflag & CRTSCTS) ||
-		    !test_bit(TTY_THROTTLED, &tty->flags)) {
+		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
 			info->serial_signals |= SerialSignal_RTS;
-		}
 		spin_lock_irqsave(&info->lock, flags);
 		set_signals(info);
 		spin_unlock_irqrestore(&info->lock, flags);
 	}
 
 	/* Handle turning off CRTSCTS */
-	if (old_termios->c_cflag & CRTSCTS &&
-	    !(tty->termios.c_cflag & CRTSCTS)) {
+	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(tty)) {
 		tty->hw_stopped = 0;
 		tx_release(tty);
 	}
diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index d2de592..5415056 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -493,7 +493,7 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
 	if (status & UART_MSR_DCTS) {
 		port->icount.cts++;
 		tty = tty_port_tty_get(&port->port);
-		if (tty && (tty->termios.c_cflag & CRTSCTS)) {
+		if (tty && C_CRTSCTS(tty)) {
 			int cts = (status & UART_MSR_CTS);
 			if (tty->hw_stopped) {
 				if (cts) {
@@ -648,10 +648,10 @@ static int sdio_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 
 	sdio_uart_change_speed(port, &tty->termios, NULL);
 
-	if (tty->termios.c_cflag & CBAUD)
+	if (C_BAUD(tty))
 		sdio_uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
 
-	if (tty->termios.c_cflag & CRTSCTS)
+	if (C_CRTSCTS(tty))
 		if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS))
 			tty->hw_stopped = 1;
 
@@ -833,7 +833,7 @@ static void sdio_uart_throttle(struct tty_struct *tty)
 {
 	struct sdio_uart_port *port = tty->driver_data;
 
-	if (!I_IXOFF(tty) && !(tty->termios.c_cflag & CRTSCTS))
+	if (!I_IXOFF(tty) && !C_CRTSCTS(tty))
 		return;
 
 	if (sdio_uart_claim_func(port) != 0)
@@ -844,7 +844,7 @@ static void sdio_uart_throttle(struct tty_struct *tty)
 		sdio_uart_start_tx(port);
 	}
 
-	if (tty->termios.c_cflag & CRTSCTS)
+	if (C_CRTSCTS(tty))
 		sdio_uart_clear_mctrl(port, TIOCM_RTS);
 
 	sdio_uart_irq(port->func);
@@ -855,7 +855,7 @@ static void sdio_uart_unthrottle(struct tty_struct *tty)
 {
 	struct sdio_uart_port *port = tty->driver_data;
 
-	if (!I_IXOFF(tty) && !(tty->termios.c_cflag & CRTSCTS))
+	if (!I_IXOFF(tty) && !C_CRTSCTS(tty))
 		return;
 
 	if (sdio_uart_claim_func(port) != 0)
@@ -870,7 +870,7 @@ static void sdio_uart_unthrottle(struct tty_struct *tty)
 		}
 	}
 
-	if (tty->termios.c_cflag & CRTSCTS)
+	if (C_CRTSCTS(tty))
 		sdio_uart_set_mctrl(port, TIOCM_RTS);
 
 	sdio_uart_irq(port->func);
diff --git a/drivers/staging/dgap/dgap.c b/drivers/staging/dgap/dgap.c
index 5413ed8..294c1c8 100644
--- a/drivers/staging/dgap/dgap.c
+++ b/drivers/staging/dgap/dgap.c
@@ -1530,7 +1530,7 @@ static void dgap_input(struct channel_t *ch)
 	if ((bd->state != BOARD_READY) || !tp  ||
 	    (tp->magic != TTY_MAGIC) ||
 	    !(ch->ch_tun.un_flags & UN_ISOPEN) ||
-	    !(tp->termios.c_cflag & CREAD) ||
+	    !C_CREAD(tp) ||
 	    (ch->ch_tun.un_flags & UN_CLOSING)) {
 		writew(head, &bs->rx_tail);
 		writeb(1, &bs->idata);
diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index c152048..9f9a73f 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -541,7 +541,7 @@ void dgnc_input(struct channel_t *ch)
 	 */
 	if (!tp || (tp->magic != TTY_MAGIC) ||
 	    !(ch->ch_tun.un_flags & UN_ISOPEN) ||
-	    !(tp->termios.c_cflag & CREAD) ||
+	    !C_CREAD(tp) ||
 	    (ch->ch_tun.un_flags & UN_CLOSING)) {
 		ch->ch_r_head = tail;
 
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 6ba5681..eacf4c9 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -639,7 +639,7 @@ static void shutdown(struct tty_struct *tty, struct serial_state *info)
 	custom.adkcon = AC_UARTBRK;
 	mb();
 
-	if (tty->termios.c_cflag & HUPCL)
+	if (C_HUPCL(tty))
 		info->MCR &= ~(SER_DTR|SER_RTS);
 	rtsdtr_ctrl(info->MCR);
 
@@ -974,7 +974,7 @@ static void rs_throttle(struct tty_struct * tty)
 	if (I_IXOFF(tty))
 		rs_send_xchar(tty, STOP_CHAR(tty));
 
-	if (tty->termios.c_cflag & CRTSCTS)
+	if (C_CRTSCTS(tty))
 		info->MCR &= ~SER_RTS;
 
 	local_irq_save(flags);
@@ -999,7 +999,7 @@ static void rs_unthrottle(struct tty_struct * tty)
 		else
 			rs_send_xchar(tty, START_CHAR(tty));
 	}
-	if (tty->termios.c_cflag & CRTSCTS)
+	if (C_CRTSCTS(tty))
 		info->MCR |= SER_RTS;
 	local_irq_save(flags);
 	rtsdtr_ctrl(info->MCR);
@@ -1332,8 +1332,7 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	change_speed(tty, info, old_termios);
 
 	/* Handle transition to B0 status */
-	if ((old_termios->c_cflag & CBAUD) &&
-	    !(cflag & CBAUD)) {
+	if ((old_termios->c_cflag & CBAUD) && !(cflag & CBAUD)) {
 		info->MCR &= ~(SER_DTR|SER_RTS);
 		local_irq_save(flags);
 		rtsdtr_ctrl(info->MCR);
@@ -1341,21 +1340,17 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) &&
-	    (cflag & CBAUD)) {
+	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		info->MCR |= SER_DTR;
-		if (!(tty->termios.c_cflag & CRTSCTS) || 
-		    !test_bit(TTY_THROTTLED, &tty->flags)) {
+		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
 			info->MCR |= SER_RTS;
-		}
 		local_irq_save(flags);
 		rtsdtr_ctrl(info->MCR);
 		local_irq_restore(flags);
 	}
 
 	/* Handle turning off CRTSCTS */
-	if ((old_termios->c_cflag & CRTSCTS) &&
-	    !(tty->termios.c_cflag & CRTSCTS)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
 		tty->hw_stopped = 0;
 		rs_start(tty);
 	}
@@ -1367,8 +1362,7 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	 * XXX  It's not clear whether the current behavior is correct
 	 * or not.  Hence, this may change.....
 	 */
-	if (!(old_termios->c_cflag & CLOCAL) &&
-	    (tty->termios.c_cflag & CLOCAL))
+	if (!(old_termios->c_cflag & CLOCAL) && C_CLOCAL(tty))
 		wake_up_interruptible(&info->open_wait);
 #endif
 }
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index a48e7e6..d67e542 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -1440,7 +1440,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 			info->port.xmit_buf = NULL;
 			free_page((unsigned long)temp);
 		}
-		if (tty->termios.c_cflag & HUPCL)
+		if (C_HUPCL(tty))
 			cyy_change_rts_dtr(info, 0, TIOCM_RTS | TIOCM_DTR);
 
 		cyy_issue_cmd(info, CyCHAN_CTL | CyDIS_RCVR);
@@ -1469,7 +1469,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 			free_page((unsigned long)temp);
 		}
 
-		if (tty->termios.c_cflag & HUPCL)
+		if (C_HUPCL(tty))
 			tty_port_lower_dtr_rts(&info->port);
 
 		set_bit(TTY_IO_ERROR, &tty->flags);
@@ -2795,8 +2795,7 @@ static void cy_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 
 	cy_set_line_char(info, tty);
 
-	if ((old_termios->c_cflag & CRTSCTS) &&
-			!(tty->termios.c_cflag & CRTSCTS)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
 		tty->hw_stopped = 0;
 		cy_start(tty);
 	}
@@ -2807,8 +2806,7 @@ static void cy_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	 * XXX  It's not clear whether the current behavior is correct
 	 * or not.  Hence, this may change.....
 	 */
-	if (!(old_termios->c_cflag & CLOCAL) &&
-	    (tty->termios.c_cflag & CLOCAL))
+	if (!(old_termios->c_cflag & CLOCAL) && C_CLOCAL(tty))
 		wake_up_interruptible(&info->port.open_wait);
 #endif
 }				/* cy_set_termios */
@@ -2868,7 +2866,7 @@ static void cy_throttle(struct tty_struct *tty)
 			info->throttle = 1;
 	}
 
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		if (!cy_is_Z(card)) {
 			spin_lock_irqsave(&card->card_lock, flags);
 			cyy_change_rts_dtr(info, 0, TIOCM_RTS);
@@ -2905,7 +2903,7 @@ static void cy_unthrottle(struct tty_struct *tty)
 			cy_send_xchar(tty, START_CHAR(tty));
 	}
 
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		card = info->card;
 		if (!cy_is_Z(card)) {
 			spin_lock_irqsave(&card->card_lock, flags);
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 9987594..8bf6763 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -1204,8 +1204,7 @@ static void isicom_set_termios(struct tty_struct *tty,
 	isicom_config_port(tty);
 	spin_unlock_irqrestore(&port->card->card_lock, flags);
 
-	if ((old_termios->c_cflag & CRTSCTS) &&
-			!(tty->termios.c_cflag & CRTSCTS)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
 		tty->hw_stopped = 0;
 		isicom_start(tty);
 	}
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 4c4a236..e9600ce 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1864,7 +1864,7 @@ static void mxser_stoprx(struct tty_struct *tty)
 		}
 	}
 
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		info->MCR &= ~UART_MCR_RTS;
 		outb(info->MCR, info->ioaddr + UART_MCR);
 	}
@@ -1901,7 +1901,7 @@ static void mxser_unthrottle(struct tty_struct *tty)
 		}
 	}
 
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		info->MCR |= UART_MCR_RTS;
 		outb(info->MCR, info->ioaddr + UART_MCR);
 	}
@@ -1949,15 +1949,13 @@ static void mxser_set_termios(struct tty_struct *tty, struct ktermios *old_termi
 	mxser_change_speed(tty, old_termios);
 	spin_unlock_irqrestore(&info->slock, flags);
 
-	if ((old_termios->c_cflag & CRTSCTS) &&
-			!(tty->termios.c_cflag & CRTSCTS)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
 		tty->hw_stopped = 0;
 		mxser_start(tty);
 	}
 
 	/* Handle sw stopped */
-	if ((old_termios->c_iflag & IXON) &&
-			!(tty->termios.c_iflag & IXON)) {
+	if ((old_termios->c_iflag & IXON) && !I_IXON(tty)) {
 		tty->stopped = 0;
 
 		if (info->board->chip_flag) {
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e3cc277..c016207 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1066,7 +1066,7 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 	/* Carrier drop -> hangup */
 	if (tty) {
 		if ((mlines & TIOCM_CD) == 0 && (dlci->modem_rx & TIOCM_CD))
-			if (!(tty->termios.c_cflag & CLOCAL))
+			if (!C_CLOCAL(tty))
 				tty_hangup(tty);
 	}
 	if (brk & 0x01)
@@ -3116,7 +3116,7 @@ static void gsmtty_throttle(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return;
-	if (tty->termios.c_cflag & CRTSCTS)
+	if (C_CRTSCTS(tty))
 		dlci->modem_tx &= ~TIOCM_DTR;
 	dlci->throttled = 1;
 	/* Send an MSC with DTR cleared */
@@ -3128,7 +3128,7 @@ static void gsmtty_unthrottle(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return;
-	if (tty->termios.c_cflag & CRTSCTS)
+	if (C_CRTSCTS(tty))
 		dlci->modem_tx |= TIOCM_DTR;
 	dlci->throttled = 0;
 	/* Send an MSC with DTR set */
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index ed54f74..244ce9c 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -307,8 +307,7 @@ static void pty_set_termios(struct tty_struct *tty,
 {
 	/* See if packet mode change of state. */
 	if (tty->link && tty->link->packet) {
-		int extproc = (old_termios->c_lflag & EXTPROC) |
-				(tty->termios.c_lflag & EXTPROC);
+		int extproc = (old_termios->c_lflag & EXTPROC) | L_EXTPROC(tty);
 		int old_flow = ((old_termios->c_iflag & IXON) &&
 				(old_termios->c_cc[VSTOP] == '\023') &&
 				(old_termios->c_cc[VSTART] == '\021'));
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 9dd02da..2ab3b6f 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -959,7 +959,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 			tty->alt_speed = 460800;
 
 		configure_r_port(tty, info, NULL);
-		if (tty->termios.c_cflag & CBAUD) {
+		if (C_BAUD(tty)) {
 			sSetDTR(cp);
 			sSetRTS(cp);
 		}
@@ -1084,18 +1084,18 @@ static void rp_set_termios(struct tty_struct *tty,
 	cp = &info->channel;
 
 	/* Handle transition to B0 status */
-	if ((old_termios->c_cflag & CBAUD) && !(tty->termios.c_cflag & CBAUD)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
 		sClrDTR(cp);
 		sClrRTS(cp);
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) && (tty->termios.c_cflag & CBAUD)) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
 		sSetRTS(cp);
 		sSetDTR(cp);
 	}
 
-	if ((old_termios->c_cflag & CRTSCTS) && !(tty->termios.c_cflag & CRTSCTS))
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty))
 		rp_start(tty);
 }
 
diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68328serial.c
index 90639b5..4931212 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -976,10 +976,8 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 
 	change_speed(info, tty);
 
-	if ((old_termios->c_cflag & CRTSCTS) &&
-	    !(tty->termios.c_cflag & CRTSCTS))
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty))
 		rs_start(tty);
-	
 }
 
 /*
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index e98aef7..37f10c4 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -1413,9 +1413,8 @@ rs_stop(struct tty_struct *tty)
 		xoff = IO_FIELD(R_SERIAL0_XOFF, xoff_char,
 				STOP_CHAR(info->port.tty));
 		xoff |= IO_STATE(R_SERIAL0_XOFF, tx_stop, stop);
-		if (tty->termios.c_iflag & IXON ) {
+		if (I_IXON(tty))
 			xoff |= IO_STATE(R_SERIAL0_XOFF, auto_xoff, enable);
-		}
 
 		*((unsigned long *)&info->ioport[REG_XOFF]) = xoff;
 		local_irq_restore(flags);
@@ -1436,9 +1435,8 @@ rs_start(struct tty_struct *tty)
 					 info->xmit.tail,SERIAL_XMIT_SIZE)));
 		xoff = IO_FIELD(R_SERIAL0_XOFF, xoff_char, STOP_CHAR(tty));
 		xoff |= IO_STATE(R_SERIAL0_XOFF, tx_stop, enable);
-		if (tty->termios.c_iflag & IXON ) {
+		if (I_IXON(tty))
 			xoff |= IO_STATE(R_SERIAL0_XOFF, auto_xoff, enable);
-		}
 
 		*((unsigned long *)&info->ioport[REG_XOFF]) = xoff;
 		if (!info->uses_dma_out &&
@@ -3166,7 +3164,7 @@ rs_throttle(struct tty_struct * tty)
 	DFLOW(DEBUG_LOG(info->line,"rs_throttle\n"));
 
 	/* Do RTS before XOFF since XOFF might take some time */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		/* Turn off RTS line */
 		e100_rts(info, 0);
 	}
@@ -3185,7 +3183,7 @@ rs_unthrottle(struct tty_struct * tty)
 	DFLOW(DEBUG_LOG(info->line,"rs_unthrottle ldisc\n"));
 	DFLOW(DEBUG_LOG(info->line,"rs_unthrottle flip.count: %i\n", tty->flip.count));
 	/* Do RTS before XOFF since XOFF might take some time */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		/* Assert RTS line  */
 		e100_rts(info, 1);
 	}
@@ -3553,8 +3551,7 @@ rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	change_speed(info);
 
 	/* Handle turning off CRTSCTS */
-	if ((old_termios->c_cflag & CRTSCTS) &&
-	    !(tty->termios.c_cflag & CRTSCTS))
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty))
 		rs_start(tty);
 
 }
@@ -3765,9 +3762,8 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 		return 0;
 	}
 
-	if (tty->termios.c_cflag & CLOCAL) {
-			do_clocal = 1;
-	}
+	if (C_CLOCAL(tty))
+		do_clocal = 1;
 
 	/*
 	 * Block waiting for the carrier detect and the line to become
diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 524e86a..00cac10 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -569,8 +569,7 @@ void jsm_input(struct jsm_channel *ch)
 	 *If the device is not open, or CREAD is off, flush
 	 *input data and return immediately.
 	 */
-	if (!tp ||
-		!(tp->termios.c_cflag & CREAD) ) {
+	if (!tp || !C_CREAD(tp)) {
 
 		jsm_dbg(READ, &ch->ch_bd->pci_dev,
 			"input. dropping %d bytes on port %d...\n",
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b1f54ab..1efdc2b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -171,14 +171,12 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		 */
 		uart_change_speed(tty, state, NULL);
 
-		if (init_hw) {
-			/*
-			 * Setup the RTS and DTR signals once the
-			 * port is open and ready to respond.
-			 */
-			if (tty->termios.c_cflag & CBAUD)
-				uart_set_mctrl(uport, TIOCM_RTS | TIOCM_DTR);
-		}
+		/*
+		 * Setup the RTS and DTR signals once the
+		 * port is open and ready to respond.
+		 */
+		if (init_hw && C_BAUD(tty))
+			uart_set_mctrl(uport, TIOCM_RTS | TIOCM_DTR);
 	}
 
 	/*
@@ -240,7 +238,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		if (uart_console(uport) && tty)
 			uport->cons->cflag = tty->termios.c_cflag;
 
-		if (!tty || (tty->termios.c_cflag & HUPCL))
+		if (!tty || C_HUPCL(tty))
 			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 
 		uart_port_shutdown(port);
@@ -639,7 +637,7 @@ static void uart_throttle(struct tty_struct *tty)
 
 	if (I_IXOFF(tty))
 		mask |= UPSTAT_AUTOXOFF;
-	if (tty->termios.c_cflag & CRTSCTS)
+	if (C_CRTSCTS(tty))
 		mask |= UPSTAT_AUTORTS;
 
 	if (port->status & mask) {
@@ -662,7 +660,7 @@ static void uart_unthrottle(struct tty_struct *tty)
 
 	if (I_IXOFF(tty))
 		mask |= UPSTAT_AUTOXOFF;
-	if (tty->termios.c_cflag & CRTSCTS)
+	if (C_CRTSCTS(tty))
 		mask |= UPSTAT_AUTORTS;
 
 	if (port->status & mask) {
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 6188059..f5476e2 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -2363,7 +2363,7 @@ static void mgsl_throttle(struct tty_struct * tty)
 	if (I_IXOFF(tty))
 		mgsl_send_xchar(tty, STOP_CHAR(tty));
 
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 		info->serial_signals &= ~SerialSignal_RTS;
 	 	usc_set_serial_signals(info);
@@ -2397,7 +2397,7 @@ static void mgsl_unthrottle(struct tty_struct * tty)
 			mgsl_send_xchar(tty, START_CHAR(tty));
 	}
 
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 		info->serial_signals |= SerialSignal_RTS;
 	 	usc_set_serial_signals(info);
@@ -3039,30 +3039,25 @@ static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termio
 	mgsl_change_params(info);
 
 	/* Handle transition to B0 status */
-	if (old_termios->c_cflag & CBAUD &&
-	    !(tty->termios.c_cflag & CBAUD)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 	 	usc_set_serial_signals(info);
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	}
-	
+
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) &&
-	    tty->termios.c_cflag & CBAUD) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
 		info->serial_signals |= SerialSignal_DTR;
- 		if (!(tty->termios.c_cflag & CRTSCTS) || 
- 		    !test_bit(TTY_THROTTLED, &tty->flags)) {
+		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
 			info->serial_signals |= SerialSignal_RTS;
- 		}
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 	 	usc_set_serial_signals(info);
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	}
-	
+
 	/* Handle turning off CRTSCTS */
-	if (old_termios->c_cflag & CRTSCTS &&
-	    !(tty->termios.c_cflag & CRTSCTS)) {
+	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(tty)) {
 		tty->hw_stopped = 0;
 		mgsl_start(tty);
 	}
@@ -3281,7 +3276,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 		return 0;
 	}
 
-	if (tty->termios.c_cflag & CLOCAL)
+	if (C_CLOCAL(tty))
 		do_clocal = true;
 
 	/* Wait for carrier detect and the line to become
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 5505ea8..c0a2f5a 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -774,8 +774,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	change_params(info);
 
 	/* Handle transition to B0 status */
-	if (old_termios->c_cflag & CBAUD &&
-	    !(tty->termios.c_cflag & CBAUD)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
 		info->signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		spin_lock_irqsave(&info->lock,flags);
 		set_signals(info);
@@ -783,21 +782,17 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) &&
-	    tty->termios.c_cflag & CBAUD) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
 		info->signals |= SerialSignal_DTR;
- 		if (!(tty->termios.c_cflag & CRTSCTS) ||
- 		    !test_bit(TTY_THROTTLED, &tty->flags)) {
+ 		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
 			info->signals |= SerialSignal_RTS;
- 		}
 		spin_lock_irqsave(&info->lock,flags);
 	 	set_signals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 
 	/* Handle turning off CRTSCTS */
-	if (old_termios->c_cflag & CRTSCTS &&
-	    !(tty->termios.c_cflag & CRTSCTS)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
 		tty->hw_stopped = 0;
 		tx_release(tty);
 	}
@@ -1362,7 +1357,7 @@ static void throttle(struct tty_struct * tty)
 	DBGINFO(("%s throttle\n", info->device_name));
 	if (I_IXOFF(tty))
 		send_xchar(tty, STOP_CHAR(tty));
- 	if (tty->termios.c_cflag & CRTSCTS) {
+ 	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->signals &= ~SerialSignal_RTS;
 	 	set_signals(info);
@@ -1387,7 +1382,7 @@ static void unthrottle(struct tty_struct * tty)
 		else
 			send_xchar(tty, START_CHAR(tty));
 	}
- 	if (tty->termios.c_cflag & CRTSCTS) {
+ 	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->signals |= SerialSignal_RTS;
 	 	set_signals(info);
@@ -3280,7 +3275,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		return 0;
 	}
 
-	if (tty->termios.c_cflag & CLOCAL)
+	if (C_CLOCAL(tty))
 		do_clocal = true;
 
 	/* Wait for carrier detect and the line to become
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index fb00a06..4b314b6 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -871,8 +871,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	change_params(info);
 
 	/* Handle transition to B0 status */
-	if (old_termios->c_cflag & CBAUD &&
-	    !(tty->termios.c_cflag & CBAUD)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		spin_lock_irqsave(&info->lock,flags);
 	 	set_signals(info);
@@ -880,21 +879,17 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) &&
-	    tty->termios.c_cflag & CBAUD) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
 		info->serial_signals |= SerialSignal_DTR;
- 		if (!(tty->termios.c_cflag & CRTSCTS) ||
- 		    !test_bit(TTY_THROTTLED, &tty->flags)) {
+ 		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
 			info->serial_signals |= SerialSignal_RTS;
- 		}
 		spin_lock_irqsave(&info->lock,flags);
 	 	set_signals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 
 	/* Handle turning off CRTSCTS */
-	if (old_termios->c_cflag & CRTSCTS &&
-	    !(tty->termios.c_cflag & CRTSCTS)) {
+	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(tty)) {
 		tty->hw_stopped = 0;
 		tx_release(tty);
 	}
@@ -1472,7 +1467,7 @@ static void throttle(struct tty_struct * tty)
 	if (I_IXOFF(tty))
 		send_xchar(tty, STOP_CHAR(tty));
 
- 	if (tty->termios.c_cflag & CRTSCTS) {
+ 	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->serial_signals &= ~SerialSignal_RTS;
 	 	set_signals(info);
@@ -1501,7 +1496,7 @@ static void unthrottle(struct tty_struct * tty)
 			send_xchar(tty, START_CHAR(tty));
 	}
 
- 	if (tty->termios.c_cflag & CRTSCTS) {
+ 	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->serial_signals |= SerialSignal_RTS;
 	 	set_signals(info);
@@ -3297,7 +3292,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		return 0;
 	}
 
-	if (tty->termios.c_cflag & CLOCAL)
+	if (C_CLOCAL(tty))
 		do_clocal = true;
 
 	/* Wait for carrier detect and the line to become
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 0ea3513..23bf5bb 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -719,16 +719,16 @@ static int get_sgflags(struct tty_struct *tty)
 {
 	int flags = 0;
 
-	if (!(tty->termios.c_lflag & ICANON)) {
-		if (tty->termios.c_lflag & ISIG)
+	if (!L_ICANON(tty)) {
+		if (L_ISIG(tty))
 			flags |= 0x02;		/* cbreak */
 		else
 			flags |= 0x20;		/* raw */
 	}
-	if (tty->termios.c_lflag & ECHO)
+	if (L_ECHO(tty))
 		flags |= 0x08;			/* echo */
-	if (tty->termios.c_oflag & OPOST)
-		if (tty->termios.c_oflag & ONLCR)
+	if (O_OPOST(tty))
+		if (O_ONLCR(tty))
 			flags |= 0x10;		/* crmod */
 	return flags;
 }
@@ -908,7 +908,7 @@ static int tty_change_softcar(struct tty_struct *tty, int arg)
 	tty->termios.c_cflag |= bit;
 	if (tty->ops->set_termios)
 		tty->ops->set_termios(tty, &old);
-	if ((tty->termios.c_cflag & CLOCAL) != bit)
+	if (C_CLOCAL(tty) != bit)
 		ret = -EINVAL;
 	up_write(&tty->termios_rwsem);
 	return ret;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index a76aec2..0473fc7 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -370,7 +370,7 @@ int tty_port_block_til_ready(struct tty_port *port,
 	}
 	if (filp->f_flags & O_NONBLOCK) {
 		/* Indicate we are open */
-		if (tty->termios.c_cflag & CBAUD)
+		if (C_BAUD(tty))
 			tty_port_raise_dtr_rts(port);
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 01bf533..b283eb8 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -1165,8 +1165,7 @@ static void cypress_read_int_callback(struct urb *urb)
 
 	/* hangup, as defined in acm.c... this might be a bad place for it
 	 * though */
-	if (tty && !(tty->termios.c_cflag & CLOCAL) &&
-			!(priv->current_status & UART_CD)) {
+	if (tty && !C_CLOCAL(tty) && !(priv->current_status & UART_CD)) {
 		dev_dbg(dev, "%s - calling hangup\n", __func__);
 		tty_hangup(tty);
 		goto continue_read;
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 12b0e67..010a42a 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -695,11 +695,11 @@ static void digi_set_termios(struct tty_struct *tty,
 		arg = -1;
 
 		/* reassert DTR and (maybe) RTS on transition from B0 */
-		if ((old_cflag&CBAUD) == B0) {
+		if ((old_cflag & CBAUD) == B0) {
 			/* don't set RTS if using hardware flow control */
 			/* and throttling input */
 			modem_signals = TIOCM_DTR;
-			if (!(tty->termios.c_cflag & CRTSCTS) ||
+			if (!C_CRTSCTS(tty) ||
 			    !test_bit(TTY_THROTTLED, &tty->flags))
 				modem_signals |= TIOCM_RTS;
 			digi_set_modem_signals(port, modem_signals, 1);
@@ -1491,8 +1491,8 @@ static int digi_read_oob_callback(struct urb *urb)
 
 		rts = 0;
 		if (tty)
-			rts = tty->termios.c_cflag & CRTSCTS;
-		
+			rts = C_CRTSCTS(tty);
+
 		if (tty && opcode == DIGI_CMD_READ_INPUT_SIGNALS) {
 			spin_lock(&priv->dp_port_lock);
 			/* convert from digi flags to termiox flags */
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index c086697..2470470 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1400,7 +1400,7 @@ static void edge_throttle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		edge_port->shadowMCR &= ~MCR_RTS;
 		status = send_cmd_write_uart_register(edge_port, MCR,
 							edge_port->shadowMCR);
@@ -1437,7 +1437,7 @@ static void edge_unthrottle(struct tty_struct *tty)
 			return;
 	}
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		edge_port->shadowMCR |= MCR_RTS;
 		send_cmd_write_uart_register(edge_port, MCR,
 						edge_port->shadowMCR);
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index fd707d6..4446b8d 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -428,7 +428,7 @@ static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	 * either.
 	 */
 	spin_lock_irqsave(&priv->lock, flags);
-	if (tty && (tty->termios.c_cflag & CBAUD))
+	if (tty && C_BAUD(tty))
 		priv->control_state = TIOCM_DTR | TIOCM_RTS;
 	else
 		priv->control_state = 0;
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 78b4f64..2eddbe5 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1308,7 +1308,7 @@ static void mos7720_throttle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		mos7720_port->shadowMCR &= ~UART_MCR_RTS;
 		write_mos_reg(port->serial, port->port_number, MOS7720_MCR,
 			      mos7720_port->shadowMCR);
@@ -1338,7 +1338,7 @@ static void mos7720_unthrottle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		mos7720_port->shadowMCR |= UART_MCR_RTS;
 		write_mos_reg(port->serial, port->port_number, MOS7720_MCR,
 			      mos7720_port->shadowMCR);
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 8ac9b55..5ba8fe9 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1425,7 +1425,7 @@ static void mos7840_throttle(struct tty_struct *tty)
 			return;
 	}
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		mos7840_port->shadowMCR &= ~MCR_RTS;
 		status = mos7840_set_uart_reg(port, MODEM_CONTROL_REGISTER,
 					 mos7840_port->shadowMCR);
@@ -1466,7 +1466,7 @@ static void mos7840_unthrottle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		mos7840_port->shadowMCR |= MCR_RTS;
 		status = mos7840_set_uart_reg(port, MODEM_CONTROL_REGISTER,
 					 mos7840_port->shadowMCR);
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index a423770..1776fe5 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -287,14 +287,14 @@ static int ircomm_tty_block_til_ready(struct ircomm_tty_cb *self,
 
 	if (filp->f_flags & O_NONBLOCK) {
 		/* nonblock mode is set */
-		if (tty->termios.c_cflag & CBAUD)
+		if (C_BAUD(tty))
 			tty_port_raise_dtr_rts(port);
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		pr_debug("%s(), O_NONBLOCK requested!\n", __func__);
 		return 0;
 	}
 
-	if (tty->termios.c_cflag & CLOCAL) {
+	if (C_CLOCAL(tty)) {
 		pr_debug("%s(), doing CLOCAL!\n", __func__);
 		do_clocal = 1;
 	}
@@ -806,7 +806,7 @@ static void ircomm_tty_throttle(struct tty_struct *tty)
 		ircomm_tty_send_xchar(tty, STOP_CHAR(tty));
 
 	/* Hardware flow control? */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		self->settings.dte &= ~IRCOMM_RTS;
 		self->settings.dte |= IRCOMM_DELTA_RTS;
 
@@ -831,12 +831,11 @@ static void ircomm_tty_unthrottle(struct tty_struct *tty)
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
 	/* Using software flow control? */
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(tty))
 		ircomm_tty_send_xchar(tty, START_CHAR(tty));
-	}
 
 	/* Using hardware flow control? */
-	if (tty->termios.c_cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		self->settings.dte |= (IRCOMM_RTS|IRCOMM_DELTA_RTS);
 
 		ircomm_param_request(self, IRCOMM_DTE, TRUE);
diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index 75ccdbd..d3687aa 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -158,26 +158,21 @@ void ircomm_tty_set_termios(struct tty_struct *tty,
 	ircomm_tty_change_speed(self, tty);
 
 	/* Handle transition to B0 status */
-	if ((old_termios->c_cflag & CBAUD) &&
-	    !(cflag & CBAUD)) {
+	if ((old_termios->c_cflag & CBAUD) && !(cflag & CBAUD)) {
 		self->settings.dte &= ~(IRCOMM_DTR|IRCOMM_RTS);
 		ircomm_param_request(self, IRCOMM_DTE, TRUE);
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) &&
-	    (cflag & CBAUD)) {
+	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		self->settings.dte |= IRCOMM_DTR;
-		if (!(tty->termios.c_cflag & CRTSCTS) ||
-		    !test_bit(TTY_THROTTLED, &tty->flags)) {
+		if (!C_CRTSCTS(tty) || !test_bit(TTY_THROTTLED, &tty->flags))
 			self->settings.dte |= IRCOMM_RTS;
-		}
 		ircomm_param_request(self, IRCOMM_DTE, TRUE);
 	}
 
 	/* Handle turning off CRTSCTS */
-	if ((old_termios->c_cflag & CRTSCTS) &&
-	    !(tty->termios.c_cflag & CRTSCTS))
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty))
 	{
 		tty->hw_stopped = 0;
 		ircomm_tty_start(tty);
-- 
2.7.0
