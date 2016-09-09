From: Rob Herring <robh@kernel.org>
Subject: [PATCH 2/9] tty: remove tty_struct dependency in tty flag macros
Date: Fri,  9 Sep 2016 17:37:03 -0500
Message-ID: <20160909223711.26238-3-robh@kernel.org>
References: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In preparation to support tty drivers having only a tty_port and
possibly not a tty_struct, convert all the termios flag macros to take a
termios ptr instead of the tty_struct ptr. After this change drivers can
be converted to support a termios struct other than tty->termios.

Yes, this is a big, treewide change, but it is mostly contained to
drivers/tty and drivers/usb/serial. I don't see another way to do it
other than defining a new set of macros.

Converted with the following coccinelle script:

@@
expression tty;
identifier x =~ "(I_IGNBRK|I_BRKINT|I_IGNPAR|I_PARMRK|I_INPCK|\
I_ISTRIP|I_INLCR|I_IGNCR|I_ICRNL|I_IUCLC|I_IXON|I_IXANY|I_IXOFF|\
I_IMAXBEL|I_IUTF8|O_OPOST|O_OLCUC|O_ONLCR|O_OCRNL|O_ONOCR|O_ONLRET|\
O_OFILL|O_OFDEL|O_NLDLY|O_CRDLY|O_TABDLY|O_BSDLY|O_VTDLY|O_FFDLY|\
C_BAUD|C_CSIZE|C_CSTOPB|C_CREAD|C_PARENB|C_PARODD|C_HUPCL|C_CLOCAL|\
C_CIBAUD|C_CRTSCTS|C_CMSPAR|L_ISIG|L_ICANON|L_XCASE|L_ECHO|L_ECHOE|\
L_ECHOK|L_ECHONL|L_NOFLSH|L_TOSTOP|L_ECHOCTL|L_ECHOPRT|L_ECHOKE|\
L_FLUSHO|L_PENDIN|L_IEXTEN|L_EXTPROC|INTR_CHAR|QUIT_CHAR|ERASE_CHAR|\
KILL_CHAR|EOF_CHAR|TIME_CHAR|MIN_CHAR|SWTC_CHAR|START_CHAR|STOP_CHAR|\
SUSP_CHAR|EOL_CHAR|REPRINT_CHAR|DISCARD_CHAR|WERASE_CHAR|LNEXT_CHAR|\
EOL2_CHAR)";

@@
- x(tty)
+ x(&tty->termios)

@@
expression tty;
expression flag;
identifier x =~ "_(I|O|C|L)_FLAG";

@@
- x(tty, flag)
+ x(&tty->termios, flag)

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org
---
 arch/ia64/hp/sim/simserial.c          |   8 +-
 drivers/char/pcmcia/synclink_cs.c     |  28 ++--
 drivers/dma/at_xdmac.c                |   4 +-
 drivers/isdn/i4l/isdn_tty.c           |   8 +-
 drivers/mmc/card/sdio_uart.c          |  22 +--
 drivers/net/ppp/ppp_async.c           |   6 +-
 drivers/s390/char/ctrlchar.c          |   6 +-
 drivers/s390/char/tty3270.c           |   4 +-
 drivers/staging/dgnc/dgnc_cls.c       |   4 +-
 drivers/staging/dgnc/dgnc_neo.c       |   4 +-
 drivers/staging/dgnc/dgnc_tty.c       |   6 +-
 drivers/staging/fwserial/fwserial.c   |  32 ++---
 drivers/tty/amiserial.c               |  30 ++--
 drivers/tty/cyclades.c                |  28 ++--
 drivers/tty/hvc/hvc_console.c         |   4 +-
 drivers/tty/hvc/hvsi.c                |   2 +-
 drivers/tty/isicom.c                  |  27 ++--
 drivers/tty/moxa.c                    |   4 +-
 drivers/tty/mxser.c                   |  38 ++---
 drivers/tty/n_gsm.c                   |   8 +-
 drivers/tty/n_tty.c                   | 259 +++++++++++++++++-----------------
 drivers/tty/pty.c                     |   8 +-
 drivers/tty/rocket.c                  |  36 ++---
 drivers/tty/serial/crisv10.c          |  28 ++--
 drivers/tty/serial/etraxfs-uart.c     |   2 +-
 drivers/tty/serial/jsm/jsm_cls.c      |   2 +-
 drivers/tty/serial/jsm/jsm_neo.c      |   2 +-
 drivers/tty/serial/jsm/jsm_tty.c      |   4 +-
 drivers/tty/serial/serial_core.c      |  16 +--
 drivers/tty/synclink.c                |  34 ++---
 drivers/tty/synclink_gt.c             |  34 ++---
 drivers/tty/synclinkmp.c              |  34 ++---
 drivers/tty/tty_audit.c               |   4 +-
 drivers/tty/tty_ioctl.c               |  22 +--
 drivers/tty/tty_port.c                |  10 +-
 drivers/tty/vt/keyboard.c             |   2 +-
 drivers/usb/class/cdc-acm.c           |   2 +-
 drivers/usb/serial/ark3116.c          |   2 +-
 drivers/usb/serial/cypress_m8.c       |   2 +-
 drivers/usb/serial/digi_acceleport.c  |   4 +-
 drivers/usb/serial/f81232.c           |  12 +-
 drivers/usb/serial/ftdi_sio.c         |   2 +-
 drivers/usb/serial/generic.c          |   2 +-
 drivers/usb/serial/io_edgeport.c      |  22 +--
 drivers/usb/serial/io_ti.c            |  22 +--
 drivers/usb/serial/mct_u232.c         |   8 +-
 drivers/usb/serial/mos7720.c          |  12 +-
 drivers/usb/serial/mos7840.c          |  12 +-
 drivers/usb/serial/mxuport.c          |  26 ++--
 drivers/usb/serial/pl2303.c           |  18 +--
 drivers/usb/serial/quatech2.c         |   4 +-
 drivers/usb/serial/ssu100.c           |   4 +-
 drivers/usb/serial/ti_usb_3410_5052.c |  16 +--
 drivers/usb/serial/whiteheat.c        |   6 +-
 include/linux/tty.h                   | 164 ++++++++++-----------
 net/irda/ircomm/ircomm_tty.c          |  18 +--
 net/irda/ircomm/ircomm_tty_ioctl.c    |   4 +-
 57 files changed, 571 insertions(+), 561 deletions(-)

diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index 21fd50def270..f276e6e96e64 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -276,8 +276,8 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
  */
 static void rs_throttle(struct tty_struct * tty)
 {
-	if (I_IXOFF(tty))
-		rs_send_xchar(tty, STOP_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		rs_send_xchar(tty, STOP_CHAR(&tty->termios));
 
 	printk(KERN_INFO "simrs_throttle called\n");
 }
@@ -286,11 +286,11 @@ static void rs_unthrottle(struct tty_struct * tty)
 {
 	struct serial_state *info = tty->driver_data;
 
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else
-			rs_send_xchar(tty, START_CHAR(tty));
+			rs_send_xchar(tty, START_CHAR(&tty->termios));
 	}
 	printk(KERN_INFO "simrs_unthrottle called\n");
 }
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index d28922df01d7..8f5528abc390 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1349,7 +1349,7 @@ static void shutdown(MGSLPC_INFO * info, struct tty_struct *tty)
 	/* TODO:disable interrupts instead of reset to preserve signal states */
 	reset_device(info);
 
-	if (!tty || C_HUPCL(tty)) {
+	if (!tty || C_HUPCL(&tty->termios)) {
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		set_signals(info);
 	}
@@ -1390,7 +1390,7 @@ static void mgslpc_program_hw(MGSLPC_INFO *info, struct tty_struct *tty)
 	port_irq_enable(info, (unsigned char) PVR_DSR | PVR_RI);
 	get_signals(info);
 
-	if (info->netcount || (tty && C_CREAD(tty)))
+	if (info->netcount || (tty && C_CREAD(&tty->termios)))
 		rx_start(info);
 
 	spin_unlock_irqrestore(&info->lock, flags);
@@ -1472,9 +1472,9 @@ static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty)
 	/* process tty input control flags */
 
 	info->read_status_mask = 0;
-	if (I_INPCK(tty))
+	if (I_INPCK(&tty->termios))
 		info->read_status_mask |= BIT7 | BIT6;
-	if (I_IGNPAR(tty))
+	if (I_IGNPAR(&tty->termios))
 		info->ignore_status_mask |= BIT7 | BIT6;
 
 	mgslpc_program_hw(info, tty);
@@ -1723,10 +1723,10 @@ static void mgslpc_throttle(struct tty_struct * tty)
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_throttle"))
 		return;
 
-	if (I_IXOFF(tty))
-		mgslpc_send_xchar(tty, STOP_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		mgslpc_send_xchar(tty, STOP_CHAR(&tty->termios));
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		spin_lock_irqsave(&info->lock, flags);
 		info->serial_signals &= ~SerialSignal_RTS;
 		set_signals(info);
@@ -1748,14 +1748,14 @@ static void mgslpc_unthrottle(struct tty_struct * tty)
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_unthrottle"))
 		return;
 
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else
-			mgslpc_send_xchar(tty, START_CHAR(tty));
+			mgslpc_send_xchar(tty, START_CHAR(&tty->termios));
 	}
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		spin_lock_irqsave(&info->lock, flags);
 		info->serial_signals |= SerialSignal_RTS;
 		set_signals(info);
@@ -2299,7 +2299,7 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 	mgslpc_change_params(info, tty);
 
 	/* Handle transition to B0 status */
-	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(&tty->termios)) {
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		spin_lock_irqsave(&info->lock, flags);
 		set_signals(info);
@@ -2307,9 +2307,9 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(&tty->termios)) {
 		info->serial_signals |= SerialSignal_DTR;
-		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
+		if (!C_CRTSCTS(&tty->termios) || !tty_throttled(tty))
 			info->serial_signals |= SerialSignal_RTS;
 		spin_lock_irqsave(&info->lock, flags);
 		set_signals(info);
@@ -2317,7 +2317,7 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 	}
 
 	/* Handle turning off CRTSCTS */
-	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(tty)) {
+	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(&tty->termios)) {
 		tty->hw_stopped = 0;
 		tx_release(tty);
 	}
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 832cbd647145..e5d7e4db6bdc 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -560,7 +560,7 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
 			dev_err(chan2dev(chan), "invalid src maxburst value\n");
 			return -EINVAL;
 		}
-		atchan->cfg |= AT_XDMAC_CC_CSIZE(csize);
+		atchan->cfg |= AT_XDMAC_CC_CSIZE(&csize->termios);
 		dwidth = ffs(atchan->sconfig.src_addr_width) - 1;
 		if (dwidth < 0) {
 			dev_err(chan2dev(chan), "invalid src addr width value\n");
@@ -583,7 +583,7 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
 			dev_err(chan2dev(chan), "invalid src maxburst value\n");
 			return -EINVAL;
 		}
-		atchan->cfg |= AT_XDMAC_CC_CSIZE(csize);
+		atchan->cfg |= AT_XDMAC_CC_CSIZE(&csize->termios);
 		dwidth = ffs(atchan->sconfig.dst_addr_width) - 1;
 		if (dwidth < 0) {
 			dev_err(chan2dev(chan), "invalid dst addr width value\n");
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index 63eaa0a9f8a1..ca5ea73a3fc9 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1290,8 +1290,8 @@ isdn_tty_throttle(struct tty_struct *tty)
 
 	if (isdn_tty_paranoia_check(info, tty->name, "isdn_tty_throttle"))
 		return;
-	if (I_IXOFF(tty))
-		info->x_char = STOP_CHAR(tty);
+	if (I_IXOFF(&tty->termios))
+		info->x_char = STOP_CHAR(&tty->termios);
 	info->mcr &= ~UART_MCR_RTS;
 }
 
@@ -1302,11 +1302,11 @@ isdn_tty_unthrottle(struct tty_struct *tty)
 
 	if (isdn_tty_paranoia_check(info, tty->name, "isdn_tty_unthrottle"))
 		return;
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else
-			info->x_char = START_CHAR(tty);
+			info->x_char = START_CHAR(&tty->termios);
 	}
 	info->mcr |= UART_MCR_RTS;
 }
diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index 5af6fb9a9ce2..4a6decfcad03 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -493,7 +493,7 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
 	if (status & UART_MSR_DCTS) {
 		port->icount.cts++;
 		tty = tty_port_tty_get(&port->port);
-		if (tty && C_CRTSCTS(tty)) {
+		if (tty && C_CRTSCTS(&tty->termios)) {
 			int cts = (status & UART_MSR_CTS);
 			if (tty->hw_stopped) {
 				if (cts) {
@@ -648,10 +648,10 @@ static int sdio_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 
 	sdio_uart_change_speed(port, &tty->termios, NULL);
 
-	if (C_BAUD(tty))
+	if (C_BAUD(&tty->termios))
 		sdio_uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
 
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS))
 			tty->hw_stopped = 1;
 
@@ -833,18 +833,18 @@ static void sdio_uart_throttle(struct tty_struct *tty)
 {
 	struct sdio_uart_port *port = tty->driver_data;
 
-	if (!I_IXOFF(tty) && !C_CRTSCTS(tty))
+	if (!I_IXOFF(&tty->termios) && !C_CRTSCTS(&tty->termios))
 		return;
 
 	if (sdio_uart_claim_func(port) != 0)
 		return;
 
-	if (I_IXOFF(tty)) {
-		port->x_char = STOP_CHAR(tty);
+	if (I_IXOFF(&tty->termios)) {
+		port->x_char = STOP_CHAR(&tty->termios);
 		sdio_uart_start_tx(port);
 	}
 
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		sdio_uart_clear_mctrl(port, TIOCM_RTS);
 
 	sdio_uart_irq(port->func);
@@ -855,22 +855,22 @@ static void sdio_uart_unthrottle(struct tty_struct *tty)
 {
 	struct sdio_uart_port *port = tty->driver_data;
 
-	if (!I_IXOFF(tty) && !C_CRTSCTS(tty))
+	if (!I_IXOFF(&tty->termios) && !C_CRTSCTS(&tty->termios))
 		return;
 
 	if (sdio_uart_claim_func(port) != 0)
 		return;
 
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (port->x_char) {
 			port->x_char = 0;
 		} else {
-			port->x_char = START_CHAR(tty);
+			port->x_char = START_CHAR(&tty->termios);
 			sdio_uart_start_tx(port);
 		}
 	}
 
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		sdio_uart_set_mctrl(port, TIOCM_RTS);
 
 	sdio_uart_irq(port->func);
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 9c889e0303dd..a1f8f0ce9e4c 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -913,10 +913,10 @@ ppp_async_input(struct asyncppp *ap, const unsigned char *buf,
 			process_input_packet(ap);
 		} else if (c == PPP_ESCAPE) {
 			ap->state |= SC_ESCAPE;
-		} else if (I_IXON(ap->tty)) {
-			if (c == START_CHAR(ap->tty))
+		} else if (I_IXON(&ap->tty->termios)) {
+			if (c == START_CHAR(&ap->tty->termios))
 				start_tty(ap->tty);
-			else if (c == STOP_CHAR(ap->tty))
+			else if (c == STOP_CHAR(&ap->tty->termios))
 				stop_tty(ap->tty);
 		}
 		/* otherwise it's a char in the recv ACCM */
diff --git a/drivers/s390/char/ctrlchar.c b/drivers/s390/char/ctrlchar.c
index f7d92584b993..dc25c2bb1e3b 100644
--- a/drivers/s390/char/ctrlchar.c
+++ b/drivers/s390/char/ctrlchar.c
@@ -68,11 +68,11 @@ ctrlchar_handle(const unsigned char *buf, int len, struct tty_struct *tty)
 
 	switch (tolower(buf[1])) {
 	case 'c':
-		return INTR_CHAR(tty) | CTRLCHAR_CTRL;
+		return INTR_CHAR(&tty->termios) | CTRLCHAR_CTRL;
 	case 'd':
-		return EOF_CHAR(tty)  | CTRLCHAR_CTRL;
+		return EOF_CHAR(&tty->termios)  | CTRLCHAR_CTRL;
 	case 'z':
-		return SUSP_CHAR(tty) | CTRLCHAR_CTRL;
+		return SUSP_CHAR(&tty->termios) | CTRLCHAR_CTRL;
 	}
 	return CTRLCHAR_NONE;
 }
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 272cb6cd1b2a..9aef796819cf 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1782,8 +1782,8 @@ tty3270_set_termios(struct tty_struct *tty, struct ktermios *old)
 	if (!tp)
 		return;
 	spin_lock_bh(&tp->view.lock);
-	if (L_ICANON(tty)) {
-		new = L_ECHO(tty) ? TF_INPUT: TF_INPUTN;
+	if (L_ICANON(&tty->termios)) {
+		new = L_ECHO(&tty->termios) ? TF_INPUT: TF_INPUTN;
 		if (new != tp->inattr) {
 			tp->inattr = new;
 			tty3270_update_prompt(tp, NULL, 0);
diff --git a/drivers/staging/dgnc/dgnc_cls.c b/drivers/staging/dgnc/dgnc_cls.c
index 46c050cc7dbe..71a5e015aad0 100644
--- a/drivers/staging/dgnc/dgnc_cls.c
+++ b/drivers/staging/dgnc/dgnc_cls.c
@@ -519,9 +519,9 @@ static void cls_param(struct tty_struct *tty)
 		 */
 		if (!(ch->ch_tun.un_flags & UN_ISOPEN) &&
 		    (un->un_type == DGNC_PRINT))
-			baud = C_BAUD(ch->ch_pun.un_tty) & 0xff;
+			baud = C_BAUD(&ch->ch_pun.un_tty->termios) & 0xff;
 		else
-			baud = C_BAUD(ch->ch_tun.un_tty) & 0xff;
+			baud = C_BAUD(&ch->ch_tun.un_tty->termios) & 0xff;
 
 		if (ch->ch_c_cflag & CBAUDEX)
 			iindex = 1;
diff --git a/drivers/staging/dgnc/dgnc_neo.c b/drivers/staging/dgnc/dgnc_neo.c
index ba57e9546f72..1c85254304b5 100644
--- a/drivers/staging/dgnc/dgnc_neo.c
+++ b/drivers/staging/dgnc/dgnc_neo.c
@@ -668,9 +668,9 @@ static void neo_param(struct tty_struct *tty)
 		/* Only use the TXPrint baud rate if the terminal unit is NOT open */
 		if (!(ch->ch_tun.un_flags & UN_ISOPEN) &&
 		    (un->un_type == DGNC_PRINT))
-			baud = C_BAUD(ch->ch_pun.un_tty) & 0xff;
+			baud = C_BAUD(&ch->ch_pun.un_tty->termios) & 0xff;
 		else
-			baud = C_BAUD(ch->ch_tun.un_tty) & 0xff;
+			baud = C_BAUD(&ch->ch_tun.un_tty->termios) & 0xff;
 
 		if (ch->ch_c_cflag & CBAUDEX)
 			iindex = 1;
diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index 4eeecc992a02..e96ef44417ee 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -509,7 +509,7 @@ void dgnc_input(struct channel_t *ch)
 	 */
 	if (!tp || (tp->magic != TTY_MAGIC) ||
 	    !(ch->ch_tun.un_flags & UN_ISOPEN) ||
-	    !C_CREAD(tp) ||
+	    !C_CREAD(&tp->termios) ||
 	    (ch->ch_tun.un_flags & UN_CLOSING)) {
 		ch->ch_r_head = tail;
 
@@ -592,7 +592,7 @@ void dgnc_input(struct channel_t *ch)
 		 * and error byte and send them to the buffer one at
 		 * a time.
 		 */
-		if (I_PARMRK(tp) || I_BRKINT(tp) || I_INPCK(tp)) {
+		if (I_PARMRK(&tp->termios) || I_BRKINT(&tp->termios) || I_INPCK(&tp->termios)) {
 			for (i = 0; i < s; i++) {
 				unsigned char ch = *(ch_pos + i);
 				char flag = TTY_NORMAL;
@@ -2593,7 +2593,7 @@ static int dgnc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 
 		spin_unlock_irqrestore(&ch->ch_lock, flags);
 
-		rc = put_user(C_CLOCAL(tty) ? 1 : 0,
+		rc = put_user(C_CLOCAL(&tty->termios) ? 1 : 0,
 			      (unsigned long __user *)arg);
 		return rc;
 
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index c241c0ae3f20..e391344d227c 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -328,7 +328,7 @@ static void fwtty_update_port_status(struct fwtty_port *port,
 
 	if (delta & TIOCM_CAR) {
 		tty = tty_port_tty_get(&port->port);
-		if (tty && !C_CLOCAL(tty)) {
+		if (tty && !C_CLOCAL(&tty->termios)) {
 			if (status & TIOCM_CAR)
 				wake_up_interruptible(&port->port.open_wait);
 			else
@@ -339,7 +339,7 @@ static void fwtty_update_port_status(struct fwtty_port *port,
 
 	if (delta & TIOCM_CTS) {
 		tty = tty_port_tty_get(&port->port);
-		if (tty && C_CRTSCTS(tty)) {
+		if (tty && C_CRTSCTS(&tty->termios)) {
 			if (tty->hw_stopped) {
 				if (status & TIOCM_CTS) {
 					tty->hw_stopped = 0;
@@ -465,7 +465,7 @@ static void fwtty_throttle_port(struct fwtty_port *port)
 
 	old = port->mctrl;
 	port->mctrl |= OOB_RX_THROTTLE;
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		port->mctrl &= ~TIOCM_RTS;
 	if (~old & OOB_RX_THROTTLE)
 		__fwtty_write_port_status(port);
@@ -943,11 +943,11 @@ static unsigned int set_termios(struct fwtty_port *port, struct tty_struct *tty)
 	tty_termios_encode_baud_rate(&tty->termios, baud, baud);
 
 	/* compute bit count of 2 frames */
-	frame = 12 + ((C_CSTOPB(tty)) ? 4 : 2) + ((C_PARENB(tty)) ? 2 : 0);
+	frame = 12 + ((C_CSTOPB(&tty->termios)) ? 4 : 2) + ((C_PARENB(&tty->termios)) ? 2 : 0);
 
-	switch (C_CSIZE(tty)) {
+	switch (C_CSIZE(&tty->termios)) {
 	case CS5:
-		frame -= (C_CSTOPB(tty)) ? 1 : 0;
+		frame -= (C_CSTOPB(&tty->termios)) ? 1 : 0;
 		break;
 	case CS6:
 		frame += 2;
@@ -963,17 +963,17 @@ static unsigned int set_termios(struct fwtty_port *port, struct tty_struct *tty)
 	port->cps = (baud << 1) / frame;
 
 	port->status_mask = UART_LSR_OE;
-	if (_I_FLAG(tty, BRKINT | PARMRK))
+	if (_I_FLAG(&tty->termios, BRKINT | PARMRK))
 		port->status_mask |= UART_LSR_BI;
 
 	port->ignore_mask = 0;
-	if (I_IGNBRK(tty)) {
+	if (I_IGNBRK(&tty->termios)) {
 		port->ignore_mask |= UART_LSR_BI;
-		if (I_IGNPAR(tty))
+		if (I_IGNPAR(&tty->termios))
 			port->ignore_mask |= UART_LSR_OE;
 	}
 
-	port->write_only = !C_CREAD(tty);
+	port->write_only = !C_CREAD(&tty->termios);
 
 	/* turn off echo and newline xlat if loopback */
 	if (port->loopback) {
@@ -1013,7 +1013,7 @@ static int fwtty_port_activate(struct tty_port *tty_port,
 			port->mctrl = TIOCM_DTR | TIOCM_RTS;
 	}
 
-	if (C_CRTSCTS(tty) && ~port->mstatus & TIOCM_CTS)
+	if (C_CRTSCTS(&tty->termios) && ~port->mstatus & TIOCM_CTS)
 		tty->hw_stopped = 1;
 
 	__fwtty_write_port_status(port);
@@ -1185,13 +1185,13 @@ static void fwtty_unthrottle(struct tty_struct *tty)
 {
 	struct fwtty_port *port = tty->driver_data;
 
-	fwtty_dbg(port, "CRTSCTS: %d\n", C_CRTSCTS(tty) != 0);
+	fwtty_dbg(port, "CRTSCTS: %d\n", C_CRTSCTS(&tty->termios) != 0);
 
 	fwtty_profile_fifo(port, port->stats.unthrottle);
 
 	spin_lock_bh(&port->lock);
 	port->mctrl &= ~OOB_RX_THROTTLE;
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		port->mctrl |= TIOCM_RTS;
 	__fwtty_write_port_status(port);
 	spin_unlock_bh(&port->lock);
@@ -1306,7 +1306,7 @@ static void fwtty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	if ((baud == 0) && (old->c_cflag & CBAUD)) {
 		port->mctrl &= ~(TIOCM_DTR | TIOCM_RTS);
 	} else if ((baud != 0) && !(old->c_cflag & CBAUD)) {
-		if (C_CRTSCTS(tty) || !tty_throttled(tty))
+		if (C_CRTSCTS(&tty->termios) || !tty_throttled(tty))
 			port->mctrl |= TIOCM_DTR | TIOCM_RTS;
 		else
 			port->mctrl |= TIOCM_DTR;
@@ -1315,11 +1315,11 @@ static void fwtty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	spin_unlock_bh(&port->lock);
 
 	if (old->c_cflag & CRTSCTS) {
-		if (!C_CRTSCTS(tty)) {
+		if (!C_CRTSCTS(&tty->termios)) {
 			tty->hw_stopped = 0;
 			fwtty_restart_tx(port);
 		}
-	} else if (C_CRTSCTS(tty) && ~port->mstatus & TIOCM_CTS) {
+	} else if (C_CRTSCTS(&tty->termios) && ~port->mstatus & TIOCM_CTS) {
 		tty->hw_stopped = 1;
 	}
 }
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 208f573495dc..16483a6cc347 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -562,7 +562,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 	current_ctl_bits = ciab.pra & (SER_DCD | SER_CTS | SER_DSR);
 
 	info->MCR = 0;
-	if (C_BAUD(tty))
+	if (C_BAUD(&tty->termios))
 	  info->MCR = SER_DTR | SER_RTS;
 	rtsdtr_ctrl(info->MCR);
 
@@ -639,7 +639,7 @@ static void shutdown(struct tty_struct *tty, struct serial_state *info)
 	custom.adkcon = AC_UARTBRK;
 	mb();
 
-	if (C_HUPCL(tty))
+	if (C_HUPCL(&tty->termios))
 		info->MCR &= ~(SER_DTR|SER_RTS);
 	rtsdtr_ctrl(info->MCR);
 
@@ -742,24 +742,24 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 	 */
 
 	info->read_status_mask = UART_LSR_OE | UART_LSR_DR;
-	if (I_INPCK(tty))
+	if (I_INPCK(&tty->termios))
 		info->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
-	if (I_BRKINT(tty) || I_PARMRK(tty))
+	if (I_BRKINT(&tty->termios) || I_PARMRK(&tty->termios))
 		info->read_status_mask |= UART_LSR_BI;
 
 	/*
 	 * Characters to ignore
 	 */
 	info->ignore_status_mask = 0;
-	if (I_IGNPAR(tty))
+	if (I_IGNPAR(&tty->termios))
 		info->ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
-	if (I_IGNBRK(tty)) {
+	if (I_IGNBRK(&tty->termios)) {
 		info->ignore_status_mask |= UART_LSR_BI;
 		/*
 		 * If we're ignore parity and break indicators, ignore 
 		 * overruns too.  (For real raw support).
 		 */
-		if (I_IGNPAR(tty))
+		if (I_IGNPAR(&tty->termios))
 			info->ignore_status_mask |= UART_LSR_OE;
 	}
 	/*
@@ -966,10 +966,10 @@ static void rs_throttle(struct tty_struct * tty)
 	if (serial_paranoia_check(info, tty->name, "rs_throttle"))
 		return;
 
-	if (I_IXOFF(tty))
-		rs_send_xchar(tty, STOP_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		rs_send_xchar(tty, STOP_CHAR(&tty->termios));
 
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		info->MCR &= ~SER_RTS;
 
 	local_irq_save(flags);
@@ -988,13 +988,13 @@ static void rs_unthrottle(struct tty_struct * tty)
 	if (serial_paranoia_check(info, tty->name, "rs_unthrottle"))
 		return;
 
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else
-			rs_send_xchar(tty, START_CHAR(tty));
+			rs_send_xchar(tty, START_CHAR(&tty->termios));
 	}
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		info->MCR |= SER_RTS;
 	local_irq_save(flags);
 	rtsdtr_ctrl(info->MCR);
@@ -1337,7 +1337,7 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		info->MCR |= SER_DTR;
-		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
+		if (!C_CRTSCTS(&tty->termios) || !tty_throttled(tty))
 			info->MCR |= SER_RTS;
 		local_irq_save(flags);
 		rtsdtr_ctrl(info->MCR);
@@ -1345,7 +1345,7 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	}
 
 	/* Handle turning off CRTSCTS */
-	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
 		tty->hw_stopped = 0;
 		rs_start(tty);
 	}
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 5e4fa9206861..2d165282f483 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -1438,7 +1438,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 			info->port.xmit_buf = NULL;
 			free_page((unsigned long)temp);
 		}
-		if (C_HUPCL(tty))
+		if (C_HUPCL(&tty->termios))
 			cyy_change_rts_dtr(info, 0, TIOCM_RTS | TIOCM_DTR);
 
 		cyy_issue_cmd(info, CyCHAN_CTL | CyDIS_RCVR);
@@ -1467,7 +1467,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 			free_page((unsigned long)temp);
 		}
 
-		if (C_HUPCL(tty))
+		if (C_HUPCL(&tty->termios))
 			tty_port_lower_dtr_rts(&info->port);
 
 		set_bit(TTY_IO_ERROR, &tty->flags);
@@ -2112,8 +2112,8 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 
 		/* set line characteristics  according configuration */
 
-		cyy_writeb(info, CySCHR1, START_CHAR(tty));
-		cyy_writeb(info, CySCHR2, STOP_CHAR(tty));
+		cyy_writeb(info, CySCHR1, START_CHAR(&tty->termios));
+		cyy_writeb(info, CySCHR2, STOP_CHAR(&tty->termios));
 		cyy_writeb(info, CyCOR1, info->cor1);
 		cyy_writeb(info, CyCOR2, info->cor2);
 		cyy_writeb(info, CyCOR3, info->cor3);
@@ -2130,7 +2130,7 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 		/* 10ms rx timeout */
 
 		cflags = CyCTS;
-		if (!C_CLOCAL(tty))
+		if (!C_CLOCAL(&tty->termios))
 			cflags |= CyDSR | CyRI | CyDCD;
 		/* without modem intr */
 		cyy_writeb(info, CySRER, cyy_readb(info, CySRER) | CyMdmCh);
@@ -2784,7 +2784,7 @@ static void cy_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 
 	cy_set_line_char(info, tty);
 
-	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
 		tty->hw_stopped = 0;
 		cy_start(tty);
 	}
@@ -2821,9 +2821,9 @@ static void cy_send_xchar(struct tty_struct *tty, char ch)
 	channel = info->line - card->first_line;
 
 	if (cy_is_Z(card)) {
-		if (ch == STOP_CHAR(tty))
+		if (ch == STOP_CHAR(&tty->termios))
 			cyz_issue_cmd(card, channel, C_CM_SENDXOFF, 0L);
-		else if (ch == START_CHAR(tty))
+		else if (ch == START_CHAR(&tty->termios))
 			cyz_issue_cmd(card, channel, C_CM_SENDXON, 0L);
 	}
 }
@@ -2848,14 +2848,14 @@ static void cy_throttle(struct tty_struct *tty)
 
 	card = info->card;
 
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (!cy_is_Z(card))
-			cy_send_xchar(tty, STOP_CHAR(tty));
+			cy_send_xchar(tty, STOP_CHAR(&tty->termios));
 		else
 			info->throttle = 1;
 	}
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		if (!cy_is_Z(card)) {
 			spin_lock_irqsave(&card->card_lock, flags);
 			cyy_change_rts_dtr(info, 0, TIOCM_RTS);
@@ -2885,14 +2885,14 @@ static void cy_unthrottle(struct tty_struct *tty)
 	if (serial_paranoia_check(info, tty->name, "cy_unthrottle"))
 		return;
 
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else
-			cy_send_xchar(tty, START_CHAR(tty));
+			cy_send_xchar(tty, START_CHAR(&tty->termios));
 	}
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		card = info->card;
 		if (!cy_is_Z(card)) {
 			spin_lock_irqsave(&card->card_lock, flags);
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index ce864875330e..630a2a0f0ddf 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -368,7 +368,7 @@ static int hvc_open(struct tty_struct *tty, struct file * filp)
 		printk(KERN_ERR "hvc_open: request_irq failed with rc %d.\n", rc);
 	} else
 		/* We are ready... raise DTR/RTS */
-		if (C_BAUD(tty))
+		if (C_BAUD(&tty->termios))
 			if (hp->ops->dtr_rts)
 				hp->ops->dtr_rts(hp, 1);
 
@@ -403,7 +403,7 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 		/* We are done with the tty pointer now. */
 		tty_port_tty_set(&hp->port, NULL);
 
-		if (C_HUPCL(tty))
+		if (C_HUPCL(&tty->termios))
 			if (hp->ops->dtr_rts)
 				hp->ops->dtr_rts(hp, 0);
 
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index 96ce6bd1cc6f..d293a5ffcd18 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -246,7 +246,7 @@ static void hvsi_recv_control(struct hvsi_struct *hp, uint8_t *packet,
 				/* CD went away; no more connection */
 				pr_debug("hvsi%i: CD dropped\n", hp->index);
 				hp->mctrl &= TIOCM_CD;
-				if (tty && !C_CLOCAL(tty))
+				if (tty && !C_CLOCAL(&tty->termios))
 					tty_hangup(tty);
 			}
 			break;
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index b70187b46d9d..2478aa559834 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -691,7 +691,7 @@ static void isicom_config_port(struct tty_struct *tty)
 	unsigned char flow_ctrl;
 
 	/* FIXME: Switch to new tty baud API */
-	baud = C_BAUD(tty);
+	baud = C_BAUD(&tty->termios);
 	if (baud & CBAUDEX) {
 		baud &= ~CBAUDEX;
 
@@ -733,7 +733,7 @@ static void isicom_config_port(struct tty_struct *tty)
 		outw(0x8000 | (channel << shift_count) | 0x03, base);
 		outw(linuxb_to_isib[baud] << 8 | 0x03, base);
 		channel_setup = 0;
-		switch (C_CSIZE(tty)) {
+		switch (C_CSIZE(&tty->termios)) {
 		case CS5:
 			channel_setup |= ISICOM_CS5;
 			break;
@@ -748,37 +748,38 @@ static void isicom_config_port(struct tty_struct *tty)
 			break;
 		}
 
-		if (C_CSTOPB(tty))
+		if (C_CSTOPB(&tty->termios))
 			channel_setup |= ISICOM_2SB;
-		if (C_PARENB(tty)) {
+		if (C_PARENB(&tty->termios)) {
 			channel_setup |= ISICOM_EVPAR;
-			if (C_PARODD(tty))
+			if (C_PARODD(&tty->termios))
 				channel_setup |= ISICOM_ODPAR;
 		}
 		outw(channel_setup, base);
 		InterruptTheCard(base);
 	}
-	tty_port_set_check_carrier(&port->port, !C_CLOCAL(tty));
+	tty_port_set_check_carrier(&port->port, !C_CLOCAL(&tty->termios));
 
 	/* flow control settings ...*/
 	flow_ctrl = 0;
-	tty_port_set_cts_flow(&port->port, C_CRTSCTS(tty));
-	if (C_CRTSCTS(tty))
+	tty_port_set_cts_flow(&port->port, C_CRTSCTS(&tty->termios));
+	if (C_CRTSCTS(&tty->termios))
 		flow_ctrl |= ISICOM_CTSRTS;
-	if (I_IXON(tty))
+	if (I_IXON(&tty->termios))
 		flow_ctrl |= ISICOM_RESPOND_XONXOFF;
-	if (I_IXOFF(tty))
+	if (I_IXOFF(&tty->termios))
 		flow_ctrl |= ISICOM_INITIATE_XONXOFF;
 
 	if (WaitTillCardIsFree(base) == 0) {
 		outw(0x8000 | (channel << shift_count) | 0x04, base);
 		outw(flow_ctrl << 8 | 0x05, base);
-		outw((STOP_CHAR(tty)) << 8 | (START_CHAR(tty)), base);
+		outw((STOP_CHAR(&tty->termios)) << 8 | (START_CHAR(&tty->termios)),
+		     base);
 		InterruptTheCard(base);
 	}
 
 	/*	rx enabled -> enable port for rx on the card	*/
-	if (C_CREAD(tty)) {
+	if (C_CREAD(&tty->termios)) {
 		card->port_status |= (1 << channel);
 		outw(card->port_status, base + 0x02);
 	}
@@ -1199,7 +1200,7 @@ static void isicom_set_termios(struct tty_struct *tty,
 	isicom_config_port(tty);
 	spin_unlock_irqrestore(&port->card->card_lock, flags);
 
-	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
 		tty->hw_stopped = 0;
 		isicom_start(tty);
 	}
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 60d37b225589..f6e693d91c0e 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1323,7 +1323,7 @@ static void moxa_set_termios(struct tty_struct *tty,
 	if (ch == NULL)
 		return;
 	moxa_set_tty_param(tty, old_termios);
-	if (!(old_termios->c_cflag & CLOCAL) && C_CLOCAL(tty))
+	if (!(old_termios->c_cflag & CLOCAL) && C_CLOCAL(&tty->termios))
 		wake_up_interruptible(&ch->port.open_wait);
 }
 
@@ -1420,7 +1420,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 	if (!inited)
 		goto put;
 
-	if (tty && (intr & IntrBreak) && !I_IGNBRK(tty)) { /* BREAK */
+	if (tty && (intr & IntrBreak) && !I_IGNBRK(&tty->termios)) { /* BREAK */
 		tty_insert_flip_char(&p->port, 0, TTY_BREAK);
 		tty_schedule_flip(&p->port);
 	}
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 69294ae154be..1a5fb2887b0e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -615,7 +615,7 @@ static int mxser_set_baud(struct tty_struct *tty, long newspd)
 	outb(cval, info->ioaddr + UART_LCR);	/* reset DLAB */
 
 #ifdef BOTHER
-	if (C_BAUD(tty) == BOTHER) {
+	if (C_BAUD(&tty->termios) == BOTHER) {
 		quot = info->baud_base % newspd;
 		quot *= 8;
 		if (quot % newspd > newspd / 2) {
@@ -755,21 +755,21 @@ static int mxser_change_speed(struct tty_struct *tty,
 	 * Set up parity check flag
 	 */
 	info->read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
-	if (I_INPCK(tty))
+	if (I_INPCK(&tty->termios))
 		info->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
-	if (I_BRKINT(tty) || I_PARMRK(tty))
+	if (I_BRKINT(&tty->termios) || I_PARMRK(&tty->termios))
 		info->read_status_mask |= UART_LSR_BI;
 
 	info->ignore_status_mask = 0;
 
-	if (I_IGNBRK(tty)) {
+	if (I_IGNBRK(&tty->termios)) {
 		info->ignore_status_mask |= UART_LSR_BI;
 		info->read_status_mask |= UART_LSR_BI;
 		/*
 		 * If we're ignore parity and break indicators, ignore
 		 * overruns too.  (For real raw support).
 		 */
-		if (I_IGNPAR(tty)) {
+		if (I_IGNPAR(&tty->termios)) {
 			info->ignore_status_mask |=
 						UART_LSR_OE |
 						UART_LSR_PE |
@@ -781,16 +781,18 @@ static int mxser_change_speed(struct tty_struct *tty,
 		}
 	}
 	if (info->board->chip_flag) {
-		mxser_set_must_xon1_value(info->ioaddr, START_CHAR(tty));
-		mxser_set_must_xoff1_value(info->ioaddr, STOP_CHAR(tty));
-		if (I_IXON(tty)) {
+		mxser_set_must_xon1_value(info->ioaddr,
+					  START_CHAR(&tty->termios));
+		mxser_set_must_xoff1_value(info->ioaddr,
+					   STOP_CHAR(&tty->termios));
+		if (I_IXON(&tty->termios)) {
 			mxser_enable_must_rx_software_flow_control(
 					info->ioaddr);
 		} else {
 			mxser_disable_must_rx_software_flow_control(
 					info->ioaddr);
 		}
-		if (I_IXOFF(tty)) {
+		if (I_IXOFF(&tty->termios)) {
 			mxser_enable_must_tx_software_flow_control(
 					info->ioaddr);
 		} else {
@@ -1081,7 +1083,7 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	mutex_lock(&port->mutex);
 	mxser_close_port(port);
 	mxser_flush_buffer(tty);
-	if (tty_port_initialized(port) && C_HUPCL(tty))
+	if (tty_port_initialized(port) && C_HUPCL(&tty->termios))
 		tty_port_lower_dtr_rts(port);
 	mxser_shutdown_port(port);
 	tty_port_set_initialized(port, 0);
@@ -1846,19 +1848,19 @@ static void mxser_stoprx(struct tty_struct *tty)
 	struct mxser_port *info = tty->driver_data;
 
 	info->ldisc_stop_rx = 1;
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->board->chip_flag) {
 			info->IER &= ~MOXA_MUST_RECV_ISR;
 			outb(info->IER, info->ioaddr + UART_IER);
 		} else {
-			info->x_char = STOP_CHAR(tty);
+			info->x_char = STOP_CHAR(&tty->termios);
 			outb(0, info->ioaddr + UART_IER);
 			info->IER |= UART_IER_THRI;
 			outb(info->IER, info->ioaddr + UART_IER);
 		}
 	}
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		info->MCR &= ~UART_MCR_RTS;
 		outb(info->MCR, info->ioaddr + UART_MCR);
 	}
@@ -1879,7 +1881,7 @@ static void mxser_unthrottle(struct tty_struct *tty)
 
 	/* startrx */
 	info->ldisc_stop_rx = 0;
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else {
@@ -1887,7 +1889,7 @@ static void mxser_unthrottle(struct tty_struct *tty)
 				info->IER |= MOXA_MUST_RECV_ISR;
 				outb(info->IER, info->ioaddr + UART_IER);
 			} else {
-				info->x_char = START_CHAR(tty);
+				info->x_char = START_CHAR(&tty->termios);
 				outb(0, info->ioaddr + UART_IER);
 				info->IER |= UART_IER_THRI;
 				outb(info->IER, info->ioaddr + UART_IER);
@@ -1895,7 +1897,7 @@ static void mxser_unthrottle(struct tty_struct *tty)
 		}
 	}
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		info->MCR |= UART_MCR_RTS;
 		outb(info->MCR, info->ioaddr + UART_MCR);
 	}
@@ -1943,13 +1945,13 @@ static void mxser_set_termios(struct tty_struct *tty, struct ktermios *old_termi
 	mxser_change_speed(tty, old_termios);
 	spin_unlock_irqrestore(&info->slock, flags);
 
-	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
 		tty->hw_stopped = 0;
 		mxser_start(tty);
 	}
 
 	/* Handle sw stopped */
-	if ((old_termios->c_iflag & IXON) && !I_IXON(tty)) {
+	if ((old_termios->c_iflag & IXON) && !I_IXON(&tty->termios)) {
 		tty->stopped = 0;
 
 		if (info->board->chip_flag) {
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 54cab59e20ed..37ec4736ecc1 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1066,7 +1066,7 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 	/* Carrier drop -> hangup */
 	if (tty) {
 		if ((mlines & TIOCM_CD) == 0 && (dlci->modem_rx & TIOCM_CD))
-			if (!C_CLOCAL(tty))
+			if (!C_CLOCAL(&tty->termios))
 				tty_hangup(tty);
 	}
 	if (brk & 0x01)
@@ -2972,7 +2972,7 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
 	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
 		return;
 	gsm_dlci_begin_close(dlci);
-	if (tty_port_initialized(&dlci->port) && C_HUPCL(tty))
+	if (tty_port_initialized(&dlci->port) && C_HUPCL(&tty->termios))
 		tty_port_lower_dtr_rts(&dlci->port);
 	tty_port_close_end(&dlci->port, tty);
 	tty_port_tty_set(&dlci->port, NULL);
@@ -3116,7 +3116,7 @@ static void gsmtty_throttle(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return;
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		dlci->modem_tx &= ~TIOCM_DTR;
 	dlci->throttled = 1;
 	/* Send an MSC with DTR cleared */
@@ -3128,7 +3128,7 @@ static void gsmtty_unthrottle(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return;
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		dlci->modem_tx |= TIOCM_DTR;
 	dlci->throttled = 0;
 	/* Send an MSC with DTR set */
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index bdf0e6e89991..b3b6b018da12 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -389,7 +389,7 @@ static inline int is_utf8_continuation(unsigned char c)
 
 static inline int is_continuation(unsigned char c, struct tty_struct *tty)
 {
-	return I_IUTF8(tty) && is_utf8_continuation(c);
+	return I_IUTF8(&tty->termios) && is_utf8_continuation(c);
 }
 
 /**
@@ -424,9 +424,9 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 
 	switch (c) {
 	case '\n':
-		if (O_ONLRET(tty))
+		if (O_ONLRET(&tty->termios))
 			ldata->column = 0;
-		if (O_ONLCR(tty)) {
+		if (O_ONLCR(&tty->termios)) {
 			if (space < 2)
 				return -1;
 			ldata->canon_column = ldata->column = 0;
@@ -436,11 +436,11 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 		ldata->canon_column = ldata->column;
 		break;
 	case '\r':
-		if (O_ONOCR(tty) && ldata->column == 0)
+		if (O_ONOCR(&tty->termios) && ldata->column == 0)
 			return 0;
-		if (O_OCRNL(tty)) {
+		if (O_OCRNL(&tty->termios)) {
 			c = '\n';
-			if (O_ONLRET(tty))
+			if (O_ONLRET(&tty->termios))
 				ldata->canon_column = ldata->column = 0;
 			break;
 		}
@@ -448,7 +448,7 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 		break;
 	case '\t':
 		spaces = 8 - (ldata->column & 7);
-		if (O_TABDLY(tty) == XTABS) {
+		if (O_TABDLY(&tty->termios) == XTABS) {
 			if (space < spaces)
 				return -1;
 			ldata->column += spaces;
@@ -463,7 +463,7 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 		break;
 	default:
 		if (!iscntrl(c)) {
-			if (O_OLCUC(tty))
+			if (O_OLCUC(&tty->termios))
 				c = toupper(c);
 			if (!is_continuation(c, tty))
 				ldata->column++;
@@ -548,16 +548,16 @@ static ssize_t process_output_block(struct tty_struct *tty,
 
 		switch (c) {
 		case '\n':
-			if (O_ONLRET(tty))
+			if (O_ONLRET(&tty->termios))
 				ldata->column = 0;
-			if (O_ONLCR(tty))
+			if (O_ONLCR(&tty->termios))
 				goto break_out;
 			ldata->canon_column = ldata->column;
 			break;
 		case '\r':
-			if (O_ONOCR(tty) && ldata->column == 0)
+			if (O_ONOCR(&tty->termios) && ldata->column == 0)
 				goto break_out;
-			if (O_OCRNL(tty))
+			if (O_OCRNL(&tty->termios))
 				goto break_out;
 			ldata->canon_column = ldata->column = 0;
 			break;
@@ -569,7 +569,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
 			break;
 		default:
 			if (!iscntrl(c)) {
-				if (O_OLCUC(tty))
+				if (O_OLCUC(&tty->termios))
 					goto break_out;
 				if (!is_continuation(c, tty))
 					ldata->column++;
@@ -712,7 +712,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 			if (no_space_left)
 				break;
 		} else {
-			if (O_OPOST(tty)) {
+			if (O_OPOST(&tty->termios)) {
 				int retval = do_output_char(c, tty, space);
 				if (retval < 0)
 					break;
@@ -792,7 +792,7 @@ static void flush_echoes(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if ((!L_ECHO(tty) && !L_ECHONL(tty)) ||
+	if ((!L_ECHO(&tty->termios) && !L_ECHONL(&tty->termios)) ||
 	    ldata->echo_commit == ldata->echo_head)
 		return;
 
@@ -914,7 +914,7 @@ static void echo_char(unsigned char c, struct tty_struct *tty)
 		add_echo_byte(ECHO_OP_START, ldata);
 		add_echo_byte(ECHO_OP_START, ldata);
 	} else {
-		if (L_ECHOCTL(tty) && iscntrl(c) && c != '\t')
+		if (L_ECHOCTL(&tty->termios) && iscntrl(c) && c != '\t')
 			add_echo_byte(ECHO_OP_START, ldata);
 		add_echo_byte(c, ldata);
 	}
@@ -958,21 +958,21 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 		/* process_output('\a', tty); */ /* what do you think? */
 		return;
 	}
-	if (c == ERASE_CHAR(tty))
+	if (c == ERASE_CHAR(&tty->termios))
 		kill_type = ERASE;
-	else if (c == WERASE_CHAR(tty))
+	else if (c == WERASE_CHAR(&tty->termios))
 		kill_type = WERASE;
 	else {
-		if (!L_ECHO(tty)) {
+		if (!L_ECHO(&tty->termios)) {
 			ldata->read_head = ldata->canon_head;
 			return;
 		}
-		if (!L_ECHOK(tty) || !L_ECHOKE(tty) || !L_ECHOE(tty)) {
+		if (!L_ECHOK(&tty->termios) || !L_ECHOKE(&tty->termios) || !L_ECHOE(&tty->termios)) {
 			ldata->read_head = ldata->canon_head;
 			finish_erasing(ldata);
-			echo_char(KILL_CHAR(tty), tty);
+			echo_char(KILL_CHAR(&tty->termios), tty);
 			/* Add a newline if ECHOK is on and ECHOKE is off. */
-			if (L_ECHOK(tty))
+			if (L_ECHOK(&tty->termios))
 				echo_char_raw('\n', ldata);
 			return;
 		}
@@ -1002,8 +1002,8 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 		}
 		cnt = ldata->read_head - head;
 		ldata->read_head = head;
-		if (L_ECHO(tty)) {
-			if (L_ECHOPRT(tty)) {
+		if (L_ECHO(&tty->termios)) {
+			if (L_ECHOPRT(&tty->termios)) {
 				if (!ldata->erasing) {
 					echo_char_raw('\\', ldata);
 					ldata->erasing = 1;
@@ -1015,8 +1015,8 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 					echo_char_raw(read_buf(ldata, head), ldata);
 					echo_move_back_col(ldata);
 				}
-			} else if (kill_type == ERASE && !L_ECHOE(tty)) {
-				echo_char(ERASE_CHAR(tty), tty);
+			} else if (kill_type == ERASE && !L_ECHOE(&tty->termios)) {
+				echo_char(ERASE_CHAR(&tty->termios), tty);
 			} else if (c == '\t') {
 				unsigned int num_chars = 0;
 				int after_tab = 0;
@@ -1036,7 +1036,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 						after_tab = 1;
 						break;
 					} else if (iscntrl(c)) {
-						if (L_ECHOCTL(tty))
+						if (L_ECHOCTL(&tty->termios))
 							num_chars += 2;
 					} else if (!is_continuation(c, tty)) {
 						num_chars++;
@@ -1044,12 +1044,12 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 				}
 				echo_erase_tab(num_chars, after_tab, ldata);
 			} else {
-				if (iscntrl(c) && L_ECHOCTL(tty)) {
+				if (iscntrl(c) && L_ECHOCTL(&tty->termios)) {
 					echo_char_raw('\b', ldata);
 					echo_char_raw(' ', ldata);
 					echo_char_raw('\b', ldata);
 				}
-				if (!iscntrl(c) || L_ECHOCTL(tty)) {
+				if (!iscntrl(c) || L_ECHOCTL(&tty->termios)) {
 					echo_char_raw('\b', ldata);
 					echo_char_raw(' ', ldata);
 					echo_char_raw('\b', ldata);
@@ -1059,7 +1059,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 		if (kill_type == ERASE)
 			break;
 	}
-	if (ldata->read_head == ldata->canon_head && L_ECHO(tty))
+	if (ldata->read_head == ldata->canon_head && L_ECHO(&tty->termios))
 		finish_erasing(ldata);
 }
 
@@ -1091,7 +1091,7 @@ static void isig(int sig, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (L_NOFLSH(tty)) {
+	if (L_NOFLSH(&tty->termios)) {
 		/* signal only */
 		__isig(sig, tty);
 
@@ -1139,13 +1139,13 @@ static void n_tty_receive_break(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (I_IGNBRK(tty))
+	if (I_IGNBRK(&tty->termios))
 		return;
-	if (I_BRKINT(tty)) {
+	if (I_BRKINT(&tty->termios)) {
 		isig(SIGINT, tty);
 		return;
 	}
-	if (I_PARMRK(tty)) {
+	if (I_PARMRK(&tty->termios)) {
 		put_tty_queue('\377', ldata);
 		put_tty_queue('\0', ldata);
 	}
@@ -1193,10 +1193,10 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (I_INPCK(tty)) {
-		if (I_IGNPAR(tty))
+	if (I_INPCK(&tty->termios)) {
+		if (I_IGNPAR(&tty->termios))
 			return;
-		if (I_PARMRK(tty)) {
+		if (I_PARMRK(&tty->termios)) {
 			put_tty_queue('\377', ldata);
 			put_tty_queue('\0', ldata);
 			put_tty_queue(c, ldata);
@@ -1210,9 +1210,9 @@ static void
 n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 {
 	isig(signal, tty);
-	if (I_IXON(tty))
+	if (I_IXON(&tty->termios))
 		start_tty(tty);
-	if (L_ECHO(tty)) {
+	if (L_ECHO(&tty->termios)) {
 		echo_char(c, tty);
 		commit_echoes(tty);
 	} else
@@ -1241,56 +1241,56 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (I_IXON(tty)) {
-		if (c == START_CHAR(tty)) {
+	if (I_IXON(&tty->termios)) {
+		if (c == START_CHAR(&tty->termios)) {
 			start_tty(tty);
 			process_echoes(tty);
 			return 0;
 		}
-		if (c == STOP_CHAR(tty)) {
+		if (c == STOP_CHAR(&tty->termios)) {
 			stop_tty(tty);
 			return 0;
 		}
 	}
 
-	if (L_ISIG(tty)) {
-		if (c == INTR_CHAR(tty)) {
+	if (L_ISIG(&tty->termios)) {
+		if (c == INTR_CHAR(&tty->termios)) {
 			n_tty_receive_signal_char(tty, SIGINT, c);
 			return 0;
-		} else if (c == QUIT_CHAR(tty)) {
+		} else if (c == QUIT_CHAR(&tty->termios)) {
 			n_tty_receive_signal_char(tty, SIGQUIT, c);
 			return 0;
-		} else if (c == SUSP_CHAR(tty)) {
+		} else if (c == SUSP_CHAR(&tty->termios)) {
 			n_tty_receive_signal_char(tty, SIGTSTP, c);
 			return 0;
 		}
 	}
 
-	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
+	if (tty->stopped && !tty->flow_stopped && I_IXON(&tty->termios) && I_IXANY(&tty->termios)) {
 		start_tty(tty);
 		process_echoes(tty);
 	}
 
 	if (c == '\r') {
-		if (I_IGNCR(tty))
+		if (I_IGNCR(&tty->termios))
 			return 0;
-		if (I_ICRNL(tty))
+		if (I_ICRNL(&tty->termios))
 			c = '\n';
-	} else if (c == '\n' && I_INLCR(tty))
+	} else if (c == '\n' && I_INLCR(&tty->termios))
 		c = '\r';
 
 	if (ldata->icanon) {
-		if (c == ERASE_CHAR(tty) || c == KILL_CHAR(tty) ||
-		    (c == WERASE_CHAR(tty) && L_IEXTEN(tty))) {
+		if (c == ERASE_CHAR(&tty->termios) || c == KILL_CHAR(&tty->termios) ||
+		    (c == WERASE_CHAR(&tty->termios) && L_IEXTEN(&tty->termios))) {
 			eraser(c, tty);
 			commit_echoes(tty);
 			return 0;
 		}
-		if (c == LNEXT_CHAR(tty) && L_IEXTEN(tty)) {
+		if (c == LNEXT_CHAR(&tty->termios) && L_IEXTEN(&tty->termios)) {
 			ldata->lnext = 1;
-			if (L_ECHO(tty)) {
+			if (L_ECHO(&tty->termios)) {
 				finish_erasing(ldata);
-				if (L_ECHOCTL(tty)) {
+				if (L_ECHOCTL(&tty->termios)) {
 					echo_char_raw('^', ldata);
 					echo_char_raw('\b', ldata);
 					commit_echoes(tty);
@@ -1298,7 +1298,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 			}
 			return 1;
 		}
-		if (c == REPRINT_CHAR(tty) && L_ECHO(tty) && L_IEXTEN(tty)) {
+		if (c == REPRINT_CHAR(&tty->termios) && L_ECHO(&tty->termios) && L_IEXTEN(&tty->termios)) {
 			size_t tail = ldata->canon_head;
 
 			finish_erasing(ldata);
@@ -1312,22 +1312,22 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 			return 0;
 		}
 		if (c == '\n') {
-			if (L_ECHO(tty) || L_ECHONL(tty)) {
+			if (L_ECHO(&tty->termios) || L_ECHONL(&tty->termios)) {
 				echo_char_raw('\n', ldata);
 				commit_echoes(tty);
 			}
 			goto handle_newline;
 		}
-		if (c == EOF_CHAR(tty)) {
+		if (c == EOF_CHAR(&tty->termios)) {
 			c = __DISABLED_CHAR;
 			goto handle_newline;
 		}
-		if ((c == EOL_CHAR(tty)) ||
-		    (c == EOL2_CHAR(tty) && L_IEXTEN(tty))) {
+		if ((c == EOL_CHAR(&tty->termios)) ||
+		    (c == EOL2_CHAR(&tty->termios) && L_IEXTEN(&tty->termios))) {
 			/*
 			 * XXX are EOL_CHAR and EOL2_CHAR echoed?!?
 			 */
-			if (L_ECHO(tty)) {
+			if (L_ECHO(&tty->termios)) {
 				/* Record the column of first canon char. */
 				if (ldata->canon_head == ldata->read_head)
 					echo_set_canon_col(ldata);
@@ -1338,7 +1338,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 			 * XXX does PARMRK doubling happen for
 			 * EOL_CHAR and EOL2_CHAR?
 			 */
-			if (c == (unsigned char) '\377' && I_PARMRK(tty))
+			if (c == (unsigned char) '\377' && I_PARMRK(&tty->termios))
 				put_tty_queue(c, ldata);
 
 handle_newline:
@@ -1351,7 +1351,7 @@ handle_newline:
 		}
 	}
 
-	if (L_ECHO(tty)) {
+	if (L_ECHO(&tty->termios)) {
 		finish_erasing(ldata);
 		if (c == '\n')
 			echo_char_raw('\n', ldata);
@@ -1365,7 +1365,7 @@ handle_newline:
 	}
 
 	/* PARMRK doubling check */
-	if (c == (unsigned char) '\377' && I_PARMRK(tty))
+	if (c == (unsigned char) '\377' && I_PARMRK(&tty->termios))
 		put_tty_queue(c, ldata);
 
 	put_tty_queue(c, ldata);
@@ -1377,11 +1377,11 @@ n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
+	if (tty->stopped && !tty->flow_stopped && I_IXON(&tty->termios) && I_IXANY(&tty->termios)) {
 		start_tty(tty);
 		process_echoes(tty);
 	}
-	if (L_ECHO(tty)) {
+	if (L_ECHO(&tty->termios)) {
 		finish_erasing(ldata);
 		/* Record the column of first canon char. */
 		if (ldata->canon_head == ldata->read_head)
@@ -1390,7 +1390,7 @@ n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
 		commit_echoes(tty);
 	}
 	/* PARMRK doubling check */
-	if (c == (unsigned char) '\377' && I_PARMRK(tty))
+	if (c == (unsigned char) '\377' && I_PARMRK(&tty->termios))
 		put_tty_queue(c, ldata);
 	put_tty_queue(c, ldata);
 }
@@ -1405,11 +1405,11 @@ n_tty_receive_char_fast(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
+	if (tty->stopped && !tty->flow_stopped && I_IXON(&tty->termios) && I_IXANY(&tty->termios)) {
 		start_tty(tty);
 		process_echoes(tty);
 	}
-	if (L_ECHO(tty)) {
+	if (L_ECHO(&tty->termios)) {
 		finish_erasing(ldata);
 		/* Record the column of first canon char. */
 		if (ldata->canon_head == ldata->read_head)
@@ -1422,18 +1422,18 @@ n_tty_receive_char_fast(struct tty_struct *tty, unsigned char c)
 
 static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 {
-	if (I_ISTRIP(tty))
+	if (I_ISTRIP(&tty->termios))
 		c &= 0x7f;
-	if (I_IUCLC(tty) && L_IEXTEN(tty))
+	if (I_IUCLC(&tty->termios) && L_IEXTEN(&tty->termios))
 		c = tolower(c);
 
-	if (I_IXON(tty)) {
-		if (c == STOP_CHAR(tty))
+	if (I_IXON(&tty->termios)) {
+		if (c == STOP_CHAR(&tty->termios))
 			stop_tty(tty);
-		else if (c == START_CHAR(tty) ||
-			 (tty->stopped && !tty->flow_stopped && I_IXANY(tty) &&
-			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
-			  c != SUSP_CHAR(tty))) {
+		else if (c == START_CHAR(&tty->termios) ||
+			 (tty->stopped && !tty->flow_stopped && I_IXANY(&tty->termios) &&
+			  c != INTR_CHAR(&tty->termios) && c != QUIT_CHAR(&tty->termios) &&
+			  c != SUSP_CHAR(&tty->termios))) {
 			start_tty(tty);
 			process_echoes(tty);
 		}
@@ -1467,9 +1467,9 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 
 	ldata->lnext = 0;
 	if (likely(flag == TTY_NORMAL)) {
-		if (I_ISTRIP(tty))
+		if (I_ISTRIP(&tty->termios))
 			c &= 0x7f;
-		if (I_IUCLC(tty) && L_IEXTEN(tty))
+		if (I_IUCLC(&tty->termios) && L_IEXTEN(&tty->termios))
 			c = tolower(c);
 		n_tty_receive_char(tty, c);
 	} else
@@ -1540,11 +1540,11 @@ n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
 		if (likely(flag == TTY_NORMAL)) {
 			unsigned char c = *cp++;
 
-			if (I_ISTRIP(tty))
+			if (I_ISTRIP(&tty->termios))
 				c &= 0x7f;
-			if (I_IUCLC(tty) && L_IEXTEN(tty))
+			if (I_IUCLC(&tty->termios) && L_IEXTEN(&tty->termios))
 				c = tolower(c);
-			if (L_EXTPROC(tty)) {
+			if (L_EXTPROC(&tty->termios)) {
 				put_tty_queue(c, ldata);
 				continue;
 			}
@@ -1591,13 +1591,13 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			  char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	bool preops = I_ISTRIP(tty) || (I_IUCLC(tty) && L_IEXTEN(tty));
+	bool preops = I_ISTRIP(&tty->termios) || (I_IUCLC(&tty->termios) && L_IEXTEN(&tty->termios));
 
 	if (ldata->real_raw)
 		n_tty_receive_buf_real_raw(tty, cp, fp, count);
-	else if (ldata->raw || (L_EXTPROC(tty) && !preops))
+	else if (ldata->raw || (L_EXTPROC(&tty->termios) && !preops))
 		n_tty_receive_buf_raw(tty, cp, fp, count);
-	else if (tty->closing && !L_EXTPROC(tty))
+	else if (tty->closing && !L_EXTPROC(&tty->termios))
 		n_tty_receive_buf_closing(tty, cp, fp, count);
 	else {
 		if (ldata->lnext) {
@@ -1609,7 +1609,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			count--;
 		}
 
-		if (!preops && !I_PARMRK(tty))
+		if (!preops && !I_PARMRK(&tty->termios))
 			n_tty_receive_buf_fast(tty, cp, fp, count);
 		else
 			n_tty_receive_buf_standard(tty, cp, fp, count);
@@ -1619,7 +1619,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			tty->ops->flush_chars(tty);
 	}
 
-	if (ldata->icanon && !L_EXTPROC(tty))
+	if (ldata->icanon && !L_EXTPROC(&tty->termios))
 		return;
 
 	/* publish read_head to consumer */
@@ -1690,7 +1690,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 		size_t tail = smp_load_acquire(&ldata->read_tail);
 
 		room = N_TTY_BUF_SIZE - (ldata->read_head - tail);
-		if (I_PARMRK(tty))
+		if (I_PARMRK(&tty->termios))
 			room = (room + 2) / 3;
 		room--;
 		if (room <= 0) {
@@ -1767,7 +1767,7 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	if (!old || (old->c_lflag ^ tty->termios.c_lflag) & ICANON) {
 		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 		ldata->line_start = ldata->read_tail;
-		if (!L_ICANON(tty) || !read_cnt(ldata)) {
+		if (!L_ICANON(&tty->termios) || !read_cnt(ldata)) {
 			ldata->canon_head = ldata->read_tail;
 			ldata->push = 0;
 		} else {
@@ -1781,50 +1781,53 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 		ldata->lnext = 0;
 	}
 
-	ldata->icanon = (L_ICANON(tty) != 0);
+	ldata->icanon = (L_ICANON(&tty->termios) != 0);
 
-	if (I_ISTRIP(tty) || I_IUCLC(tty) || I_IGNCR(tty) ||
-	    I_ICRNL(tty) || I_INLCR(tty) || L_ICANON(tty) ||
-	    I_IXON(tty) || L_ISIG(tty) || L_ECHO(tty) ||
-	    I_PARMRK(tty)) {
+	if (I_ISTRIP(&tty->termios) || I_IUCLC(&tty->termios) || I_IGNCR(&tty->termios) ||
+	    I_ICRNL(&tty->termios) || I_INLCR(&tty->termios) || L_ICANON(&tty->termios) ||
+	    I_IXON(&tty->termios) || L_ISIG(&tty->termios) || L_ECHO(&tty->termios) ||
+	    I_PARMRK(&tty->termios)) {
 		bitmap_zero(ldata->char_map, 256);
 
-		if (I_IGNCR(tty) || I_ICRNL(tty))
+		if (I_IGNCR(&tty->termios) || I_ICRNL(&tty->termios))
 			set_bit('\r', ldata->char_map);
-		if (I_INLCR(tty))
+		if (I_INLCR(&tty->termios))
 			set_bit('\n', ldata->char_map);
 
-		if (L_ICANON(tty)) {
-			set_bit(ERASE_CHAR(tty), ldata->char_map);
-			set_bit(KILL_CHAR(tty), ldata->char_map);
-			set_bit(EOF_CHAR(tty), ldata->char_map);
+		if (L_ICANON(&tty->termios)) {
+			set_bit(ERASE_CHAR(&tty->termios), ldata->char_map);
+			set_bit(KILL_CHAR(&tty->termios), ldata->char_map);
+			set_bit(EOF_CHAR(&tty->termios), ldata->char_map);
 			set_bit('\n', ldata->char_map);
-			set_bit(EOL_CHAR(tty), ldata->char_map);
-			if (L_IEXTEN(tty)) {
-				set_bit(WERASE_CHAR(tty), ldata->char_map);
-				set_bit(LNEXT_CHAR(tty), ldata->char_map);
-				set_bit(EOL2_CHAR(tty), ldata->char_map);
-				if (L_ECHO(tty))
-					set_bit(REPRINT_CHAR(tty),
+			set_bit(EOL_CHAR(&tty->termios), ldata->char_map);
+			if (L_IEXTEN(&tty->termios)) {
+				set_bit(WERASE_CHAR(&tty->termios),
+					ldata->char_map);
+				set_bit(LNEXT_CHAR(&tty->termios),
+					ldata->char_map);
+				set_bit(EOL2_CHAR(&tty->termios),
+					ldata->char_map);
+				if (L_ECHO(&tty->termios))
+					set_bit(REPRINT_CHAR(&tty->termios),
 						ldata->char_map);
 			}
 		}
-		if (I_IXON(tty)) {
-			set_bit(START_CHAR(tty), ldata->char_map);
-			set_bit(STOP_CHAR(tty), ldata->char_map);
+		if (I_IXON(&tty->termios)) {
+			set_bit(START_CHAR(&tty->termios), ldata->char_map);
+			set_bit(STOP_CHAR(&tty->termios), ldata->char_map);
 		}
-		if (L_ISIG(tty)) {
-			set_bit(INTR_CHAR(tty), ldata->char_map);
-			set_bit(QUIT_CHAR(tty), ldata->char_map);
-			set_bit(SUSP_CHAR(tty), ldata->char_map);
+		if (L_ISIG(&tty->termios)) {
+			set_bit(INTR_CHAR(&tty->termios), ldata->char_map);
+			set_bit(QUIT_CHAR(&tty->termios), ldata->char_map);
+			set_bit(SUSP_CHAR(&tty->termios), ldata->char_map);
 		}
 		clear_bit(__DISABLED_CHAR, ldata->char_map);
 		ldata->raw = 0;
 		ldata->real_raw = 0;
 	} else {
 		ldata->raw = 1;
-		if ((I_IGNBRK(tty) || (!I_BRKINT(tty) && !I_PARMRK(tty))) &&
-		    (I_IGNPAR(tty) || !I_INPCK(tty)) &&
+		if ((I_IGNBRK(&tty->termios) || (!I_BRKINT(&tty->termios) && !I_PARMRK(&tty->termios))) &&
+		    (I_IGNPAR(&tty->termios) || !I_INPCK(&tty->termios)) &&
 		    (tty->driver->flags & TTY_DRIVER_REAL_RAW))
 			ldata->real_raw = 1;
 		else
@@ -1834,7 +1837,7 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	 * Fix tty hang when I_IXON(tty) is cleared, but the tty
 	 * been stopped by STOP_CHAR(tty) before it.
 	 */
-	if (!I_IXON(tty) && old && (old->c_iflag & IXON) && !tty->flow_stopped) {
+	if (!I_IXON(&tty->termios) && old && (old->c_iflag & IXON) && !tty->flow_stopped) {
 		start_tty(tty);
 		process_echoes(tty);
 	}
@@ -1909,9 +1912,9 @@ err:
 static inline int input_available_p(struct tty_struct *tty, int poll)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
+	int amt = poll && !TIME_CHAR(&tty->termios) && MIN_CHAR(&tty->termios) ? MIN_CHAR(&tty->termios) : 1;
 
-	if (ldata->icanon && !L_EXTPROC(tty))
+	if (ldata->icanon && !L_EXTPROC(&tty->termios))
 		return ldata->canon_head != ldata->read_tail;
 	else
 		return ldata->commit_head - ldata->read_tail >= amt;
@@ -1956,11 +1959,11 @@ static int copy_from_read_buf(struct tty_struct *tty,
 		const unsigned char *from = read_buf_addr(ldata, tail);
 		retval = copy_to_user(*b, from, n);
 		n -= retval;
-		is_eof = n == 1 && *from == EOF_CHAR(tty);
+		is_eof = n == 1 && *from == EOF_CHAR(&tty->termios);
 		tty_audit_add_data(tty, from, n);
 		smp_store_release(&ldata->read_tail, ldata->read_tail + n);
 		/* Turn single EOF into zero-length read */
-		if (L_EXTPROC(tty) && ldata->icanon && is_eof &&
+		if (L_EXTPROC(&tty->termios) && ldata->icanon && is_eof &&
 		    (head == ldata->read_tail))
 			n = 0;
 		*b += n;
@@ -2139,11 +2142,11 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	minimum = time = 0;
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (!ldata->icanon) {
-		minimum = MIN_CHAR(tty);
+		minimum = MIN_CHAR(&tty->termios);
 		if (minimum) {
-			time = (HZ / 10) * TIME_CHAR(tty);
+			time = (HZ / 10) * TIME_CHAR(&tty->termios);
 		} else {
-			timeout = (HZ / 10) * TIME_CHAR(tty);
+			timeout = (HZ / 10) * TIME_CHAR(&tty->termios);
 			minimum = 1;
 		}
 	}
@@ -2202,7 +2205,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 			}
 		}
 
-		if (ldata->icanon && !L_EXTPROC(tty)) {
+		if (ldata->icanon && !L_EXTPROC(&tty->termios)) {
 			retval = canon_copy_from_read_buf(tty, &b, &nr);
 			if (retval)
 				break;
@@ -2278,7 +2281,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	ssize_t retval = 0;
 
 	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
-	if (L_TOSTOP(tty) && file->f_op->write != redirected_tty_write) {
+	if (L_TOSTOP(&tty->termios) && file->f_op->write != redirected_tty_write) {
 		retval = tty_check_change(tty);
 		if (retval)
 			return retval;
@@ -2299,7 +2302,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 			retval = -EIO;
 			break;
 		}
-		if (O_OPOST(tty)) {
+		if (O_OPOST(&tty->termios)) {
 			while (nr > 0) {
 				ssize_t num = process_output_block(tty, b, nr);
 				if (num < 0) {
@@ -2427,7 +2430,7 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 		return put_user(tty_chars_in_buffer(tty), (int __user *) arg);
 	case TIOCINQ:
 		down_write(&tty->termios_rwsem);
-		if (L_ICANON(tty))
+		if (L_ICANON(&tty->termios))
 			retval = inq_canon(ldata);
 		else
 			retval = read_cnt(ldata);
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 51e0d32883ba..7c51ff7f9030 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -261,13 +261,13 @@ static void pty_set_termios(struct tty_struct *tty,
 {
 	/* See if packet mode change of state. */
 	if (tty->link && tty->link->packet) {
-		int extproc = (old_termios->c_lflag & EXTPROC) | L_EXTPROC(tty);
+		int extproc = (old_termios->c_lflag & EXTPROC) | L_EXTPROC(&tty->termios);
 		int old_flow = ((old_termios->c_iflag & IXON) &&
 				(old_termios->c_cc[VSTOP] == '\023') &&
 				(old_termios->c_cc[VSTART] == '\021'));
-		int new_flow = (I_IXON(tty) &&
-				STOP_CHAR(tty) == '\023' &&
-				START_CHAR(tty) == '\021');
+		int new_flow = (I_IXON(&tty->termios) &&
+				STOP_CHAR(&tty->termios) == '\023' &&
+				START_CHAR(&tty->termios) == '\021');
 		if ((old_flow != new_flow) || extproc) {
 			spin_lock_irq(&tty->ctrl_lock);
 			if (old_flow != new_flow) {
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b0cc47c77b40..a41dda82747a 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -786,15 +786,15 @@ static void configure_r_port(struct tty_struct *tty, struct r_port *info,
 	 * Handle software flow control in the board
 	 */
 #ifdef ROCKET_SOFT_FLOW
-	if (I_IXON(tty)) {
+	if (I_IXON(&tty->termios)) {
 		sEnTxSoftFlowCtl(cp);
-		if (I_IXANY(tty)) {
+		if (I_IXANY(&tty->termios)) {
 			sEnIXANY(cp);
 		} else {
 			sDisIXANY(cp);
 		}
-		sSetTxXONChar(cp, START_CHAR(tty));
-		sSetTxXOFFChar(cp, STOP_CHAR(tty));
+		sSetTxXONChar(cp, START_CHAR(&tty->termios));
+		sSetTxXOFFChar(cp, STOP_CHAR(&tty->termios));
 	} else {
 		sDisTxSoftFlowCtl(cp);
 		sDisIXANY(cp);
@@ -806,24 +806,24 @@ static void configure_r_port(struct tty_struct *tty, struct r_port *info,
 	 * Set up ignore/read mask words
 	 */
 	info->read_status_mask = STMRCVROVRH | 0xFF;
-	if (I_INPCK(tty))
+	if (I_INPCK(&tty->termios))
 		info->read_status_mask |= STMFRAMEH | STMPARITYH;
-	if (I_BRKINT(tty) || I_PARMRK(tty))
+	if (I_BRKINT(&tty->termios) || I_PARMRK(&tty->termios))
 		info->read_status_mask |= STMBREAKH;
 
 	/*
 	 * Characters to ignore
 	 */
 	info->ignore_status_mask = 0;
-	if (I_IGNPAR(tty))
+	if (I_IGNPAR(&tty->termios))
 		info->ignore_status_mask |= STMFRAMEH | STMPARITYH;
-	if (I_IGNBRK(tty)) {
+	if (I_IGNBRK(&tty->termios)) {
 		info->ignore_status_mask |= STMBREAKH;
 		/*
 		 * If we're ignoring parity and break indicators,
 		 * ignore overruns too.  (For real raw support).
 		 */
-		if (I_IGNPAR(tty))
+		if (I_IGNPAR(&tty->termios))
 			info->ignore_status_mask |= STMRCVROVRH;
 	}
 
@@ -960,7 +960,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 			tty->alt_speed = 460800;
 
 		configure_r_port(tty, info, NULL);
-		if (C_BAUD(tty)) {
+		if (C_BAUD(&tty->termios)) {
 			sSetDTR(cp);
 			sSetRTS(cp);
 		}
@@ -1019,7 +1019,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 	sFlushRxFIFO(cp);
 	sFlushTxFIFO(cp);
 	sClrRTS(cp);
-	if (C_HUPCL(tty))
+	if (C_HUPCL(&tty->termios))
 		sClrDTR(cp);
 
 	rp_flush_buffer(tty);
@@ -1086,18 +1086,18 @@ static void rp_set_termios(struct tty_struct *tty,
 	cp = &info->channel;
 
 	/* Handle transition to B0 status */
-	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(&tty->termios)) {
 		sClrDTR(cp);
 		sClrRTS(cp);
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(&tty->termios)) {
 		sSetRTS(cp);
 		sSetDTR(cp);
 	}
 
-	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty))
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios))
 		rp_start(tty);
 }
 
@@ -1366,8 +1366,8 @@ static void rp_throttle(struct tty_struct *tty)
 	if (rocket_paranoia_check(info, "rp_throttle"))
 		return;
 
-	if (I_IXOFF(tty))
-		rp_send_xchar(tty, STOP_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		rp_send_xchar(tty, STOP_CHAR(&tty->termios));
 
 	sClrRTS(&info->channel);
 }
@@ -1382,8 +1382,8 @@ static void rp_unthrottle(struct tty_struct *tty)
 	if (rocket_paranoia_check(info, "rp_unthrottle"))
 		return;
 
-	if (I_IXOFF(tty))
-		rp_send_xchar(tty, START_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		rp_send_xchar(tty, START_CHAR(&tty->termios));
 
 	sSetRTS(&info->channel);
 }
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 315c84979b18..a45dc9d27b87 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -1411,9 +1411,9 @@ rs_stop(struct tty_struct *tty)
 					 info->xmit.tail,SERIAL_XMIT_SIZE)));
 
 		xoff = IO_FIELD(R_SERIAL0_XOFF, xoff_char,
-				STOP_CHAR(info->port.tty));
+				STOP_CHAR(&info->port.tty->termios));
 		xoff |= IO_STATE(R_SERIAL0_XOFF, tx_stop, stop);
-		if (I_IXON(tty))
+		if (I_IXON(&tty->termios))
 			xoff |= IO_STATE(R_SERIAL0_XOFF, auto_xoff, enable);
 
 		*((unsigned long *)&info->ioport[REG_XOFF]) = xoff;
@@ -1433,9 +1433,10 @@ rs_start(struct tty_struct *tty)
 		DFLOW(DEBUG_LOG(info->line, "XOFF rs_start xmit %i\n",
 				CIRC_CNT(info->xmit.head,
 					 info->xmit.tail,SERIAL_XMIT_SIZE)));
-		xoff = IO_FIELD(R_SERIAL0_XOFF, xoff_char, STOP_CHAR(tty));
+		xoff = IO_FIELD(R_SERIAL0_XOFF, xoff_char,
+				STOP_CHAR(&tty->termios));
 		xoff |= IO_STATE(R_SERIAL0_XOFF, tx_stop, enable);
-		if (I_IXON(tty))
+		if (I_IXON(&tty->termios))
 			xoff |= IO_STATE(R_SERIAL0_XOFF, auto_xoff, enable);
 
 		*((unsigned long *)&info->ioport[REG_XOFF]) = xoff;
@@ -2906,7 +2907,8 @@ change_speed(struct e100_serial *info)
 
 	info->ioport[REG_TR_CTRL] = info->tx_ctrl;
 	info->ioport[REG_REC_CTRL] = info->rx_ctrl;
-	xoff = IO_FIELD(R_SERIAL0_XOFF, xoff_char, STOP_CHAR(info->port.tty));
+	xoff = IO_FIELD(R_SERIAL0_XOFF, xoff_char,
+			STOP_CHAR(&info->port.tty->termios));
 	xoff |= IO_STATE(R_SERIAL0_XOFF, tx_stop, enable);
 	if (info->port.tty->termios.c_iflag & IXON ) {
 		DFLOW(DEBUG_LOG(info->line, "FLOW XOFF enabled 0x%02X\n",
@@ -3164,12 +3166,12 @@ rs_throttle(struct tty_struct * tty)
 	DFLOW(DEBUG_LOG(info->line,"rs_throttle\n"));
 
 	/* Do RTS before XOFF since XOFF might take some time */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		/* Turn off RTS line */
 		e100_rts(info, 0);
 	}
-	if (I_IXOFF(tty))
-		rs_send_xchar(tty, STOP_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		rs_send_xchar(tty, STOP_CHAR(&tty->termios));
 
 }
 
@@ -3183,16 +3185,16 @@ rs_unthrottle(struct tty_struct * tty)
 	DFLOW(DEBUG_LOG(info->line,"rs_unthrottle ldisc\n"));
 	DFLOW(DEBUG_LOG(info->line,"rs_unthrottle flip.count: %i\n", tty->flip.count));
 	/* Do RTS before XOFF since XOFF might take some time */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		/* Assert RTS line  */
 		e100_rts(info, 1);
 	}
 
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else
-			rs_send_xchar(tty, START_CHAR(tty));
+			rs_send_xchar(tty, START_CHAR(&tty->termios));
 	}
 
 }
@@ -3551,7 +3553,7 @@ rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	change_speed(info);
 
 	/* Handle turning off CRTSCTS */
-	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty))
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios))
 		rs_start(tty);
 
 }
@@ -3760,7 +3762,7 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 		return 0;
 	}
 
-	if (C_CLOCAL(tty))
+	if (C_CLOCAL(&tty->termios))
 		do_clocal = 1;
 
 	/*
diff --git a/drivers/tty/serial/etraxfs-uart.c b/drivers/tty/serial/etraxfs-uart.c
index 2f80bc7e44fb..8dd313fc2054 100644
--- a/drivers/tty/serial/etraxfs-uart.c
+++ b/drivers/tty/serial/etraxfs-uart.c
@@ -777,7 +777,7 @@ etraxfs_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (up->port.state && up->port.state->port.tty &&
 	    (up->port.state->port.tty->termios.c_iflag & IXON)) {
-		xoff.chr = STOP_CHAR(up->port.state->port.tty);
+		xoff.chr = STOP_CHAR(&up->port.state->port.tty->termios);
 		xoff.automatic = regk_ser_yes;
 	} else
 		xoff.automatic = regk_ser_no;
diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 4eb12a9cae76..6f3e050f9526 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -718,7 +718,7 @@ static void cls_param(struct jsm_channel *ch)
 		return;
 	}
 
-	cflag = C_BAUD(ch->uart_port.state->port.tty);
+	cflag = C_BAUD(&ch->uart_port.state->port.tty->termios);
 	baud = 9600;
 	for (i = 0; i < ARRAY_SIZE(baud_rates); i++) {
 		if (baud_rates[i].cflag == cflag) {
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index c6fdd6369534..bba1772fb59c 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -987,7 +987,7 @@ static void neo_param(struct jsm_channel *ch)
 			{     50, B50     },
 		};
 
-		cflag = C_BAUD(ch->uart_port.state->port.tty);
+		cflag = C_BAUD(&ch->uart_port.state->port.tty->termios);
 		baud = 9600;
 		for (i = 0; i < ARRAY_SIZE(baud_rates); i++) {
 			if (baud_rates[i].cflag == cflag) {
diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index ec7d8383900f..5588e6c3c679 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -568,7 +568,7 @@ void jsm_input(struct jsm_channel *ch)
 	 *If the device is not open, or CREAD is off, flush
 	 *input data and return immediately.
 	 */
-	if (!tp || !C_CREAD(tp)) {
+	if (!tp || !C_CREAD(&tp->termios)) {
 
 		jsm_dbg(READ, &ch->ch_bd->pci_dev,
 			"input. dropping %d bytes on port %d...\n",
@@ -616,7 +616,7 @@ void jsm_input(struct jsm_channel *ch)
 			 * a time.
 			 */
 
-		if (I_PARMRK(tp) || I_BRKINT(tp) || I_INPCK(tp)) {
+		if (I_PARMRK(&tp->termios) || I_BRKINT(&tp->termios) || I_INPCK(&tp->termios)) {
 			for (i = 0; i < s; i++) {
 				/*
 				 * Give the Linux ld the flags in the
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 240d3e7a548c..73b7a7ae7862 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -211,7 +211,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		 * Setup the RTS and DTR signals once the
 		 * port is open and ready to respond.
 		 */
-		if (init_hw && C_BAUD(tty))
+		if (init_hw && C_BAUD(&tty->termios))
 			uart_set_mctrl(uport, TIOCM_RTS | TIOCM_DTR);
 	}
 
@@ -269,7 +269,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		if (uport && uart_console(uport) && tty)
 			uport->cons->cflag = tty->termios.c_cflag;
 
-		if (!tty || C_HUPCL(tty))
+		if (!tty || C_HUPCL(&tty->termios))
 			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 
 		uart_port_shutdown(port);
@@ -671,9 +671,9 @@ static void uart_throttle(struct tty_struct *tty)
 	if (!port)
 		return;
 
-	if (I_IXOFF(tty))
+	if (I_IXOFF(&tty->termios))
 		mask |= UPSTAT_AUTOXOFF;
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		mask |= UPSTAT_AUTORTS;
 
 	if (port->status & mask) {
@@ -685,7 +685,7 @@ static void uart_throttle(struct tty_struct *tty)
 		uart_clear_mctrl(port, TIOCM_RTS);
 
 	if (mask & UPSTAT_AUTOXOFF)
-		uart_send_xchar(tty, STOP_CHAR(tty));
+		uart_send_xchar(tty, STOP_CHAR(&tty->termios));
 
 	uart_port_deref(port);
 }
@@ -700,9 +700,9 @@ static void uart_unthrottle(struct tty_struct *tty)
 	if (!port)
 		return;
 
-	if (I_IXOFF(tty))
+	if (I_IXOFF(&tty->termios))
 		mask |= UPSTAT_AUTOXOFF;
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		mask |= UPSTAT_AUTORTS;
 
 	if (port->status & mask) {
@@ -714,7 +714,7 @@ static void uart_unthrottle(struct tty_struct *tty)
 		uart_set_mctrl(port, TIOCM_RTS);
 
 	if (mask & UPSTAT_AUTOXOFF)
-		uart_send_xchar(tty, START_CHAR(tty));
+		uart_send_xchar(tty, START_CHAR(&tty->termios));
 
 	uart_port_deref(port);
 }
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index c13e27ecb0b7..712776cf7ab7 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -1969,19 +1969,19 @@ static void mgsl_change_params(struct mgsl_struct *info)
 	/* process tty input control flags */
 	
 	info->read_status_mask = RXSTATUS_OVERRUN;
-	if (I_INPCK(info->port.tty))
+	if (I_INPCK(&info->port.tty->termios))
 		info->read_status_mask |= RXSTATUS_PARITY_ERROR | RXSTATUS_FRAMING_ERROR;
- 	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
+ 	if (I_BRKINT(&info->port.tty->termios) || I_PARMRK(&info->port.tty->termios))
  		info->read_status_mask |= RXSTATUS_BREAK_RECEIVED;
 	
-	if (I_IGNPAR(info->port.tty))
+	if (I_IGNPAR(&info->port.tty->termios))
 		info->ignore_status_mask |= RXSTATUS_PARITY_ERROR | RXSTATUS_FRAMING_ERROR;
-	if (I_IGNBRK(info->port.tty)) {
+	if (I_IGNBRK(&info->port.tty->termios)) {
 		info->ignore_status_mask |= RXSTATUS_BREAK_RECEIVED;
 		/* If ignoring parity and break indicators, ignore 
 		 * overruns too.  (For real raw support).
 		 */
-		if (I_IGNPAR(info->port.tty))
+		if (I_IGNPAR(&info->port.tty->termios))
 			info->ignore_status_mask |= RXSTATUS_OVERRUN;
 	}
 
@@ -2350,10 +2350,10 @@ static void mgsl_throttle(struct tty_struct * tty)
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_throttle"))
 		return;
 	
-	if (I_IXOFF(tty))
-		mgsl_send_xchar(tty, STOP_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		mgsl_send_xchar(tty, STOP_CHAR(&tty->termios));
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 		info->serial_signals &= ~SerialSignal_RTS;
 	 	usc_set_serial_signals(info);
@@ -2380,14 +2380,14 @@ static void mgsl_unthrottle(struct tty_struct * tty)
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_unthrottle"))
 		return;
 	
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else
-			mgsl_send_xchar(tty, START_CHAR(tty));
+			mgsl_send_xchar(tty, START_CHAR(&tty->termios));
 	}
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 		info->serial_signals |= SerialSignal_RTS;
 	 	usc_set_serial_signals(info);
@@ -3029,7 +3029,7 @@ static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termio
 	mgsl_change_params(info);
 
 	/* Handle transition to B0 status */
-	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(&tty->termios)) {
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 	 	usc_set_serial_signals(info);
@@ -3037,9 +3037,9 @@ static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termio
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(&tty->termios)) {
 		info->serial_signals |= SerialSignal_DTR;
-		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
+		if (!C_CRTSCTS(&tty->termios) || !tty_throttled(tty))
 			info->serial_signals |= SerialSignal_RTS;
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 	 	usc_set_serial_signals(info);
@@ -3047,7 +3047,7 @@ static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termio
 	}
 
 	/* Handle turning off CRTSCTS */
-	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(tty)) {
+	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(&tty->termios)) {
 		tty->hw_stopped = 0;
 		mgsl_start(tty);
 	}
@@ -3266,7 +3266,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 		return 0;
 	}
 
-	if (C_CLOCAL(tty))
+	if (C_CLOCAL(&tty->termios))
 		do_clocal = true;
 
 	/* Wait for carrier detect and the line to become
@@ -3289,7 +3289,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 	port->blocked_open++;
 
 	while (1) {
-		if (C_BAUD(tty) && tty_port_initialized(port))
+		if (C_BAUD(&tty->termios) && tty_port_initialized(port))
 			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 7aca2d4670e4..055fa71bc2fb 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -774,7 +774,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	change_params(info);
 
 	/* Handle transition to B0 status */
-	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(&tty->termios)) {
 		info->signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		spin_lock_irqsave(&info->lock,flags);
 		set_signals(info);
@@ -782,9 +782,9 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(&tty->termios)) {
 		info->signals |= SerialSignal_DTR;
-		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
+		if (!C_CRTSCTS(&tty->termios) || !tty_throttled(tty))
 			info->signals |= SerialSignal_RTS;
 		spin_lock_irqsave(&info->lock,flags);
 	 	set_signals(info);
@@ -792,7 +792,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	}
 
 	/* Handle turning off CRTSCTS */
-	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
 		tty->hw_stopped = 0;
 		tx_release(tty);
 	}
@@ -1355,9 +1355,9 @@ static void throttle(struct tty_struct * tty)
 	if (sanity_check(info, tty->name, "throttle"))
 		return;
 	DBGINFO(("%s throttle\n", info->device_name));
-	if (I_IXOFF(tty))
-		send_xchar(tty, STOP_CHAR(tty));
- 	if (C_CRTSCTS(tty)) {
+	if (I_IXOFF(&tty->termios))
+		send_xchar(tty, STOP_CHAR(&tty->termios));
+ 	if (C_CRTSCTS(&tty->termios)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->signals &= ~SerialSignal_RTS;
 	 	set_signals(info);
@@ -1376,13 +1376,13 @@ static void unthrottle(struct tty_struct * tty)
 	if (sanity_check(info, tty->name, "unthrottle"))
 		return;
 	DBGINFO(("%s unthrottle\n", info->device_name));
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else
-			send_xchar(tty, START_CHAR(tty));
+			send_xchar(tty, START_CHAR(&tty->termios));
 	}
- 	if (C_CRTSCTS(tty)) {
+ 	if (C_CRTSCTS(&tty->termios)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->signals |= SerialSignal_RTS;
 	 	set_signals(info);
@@ -2582,18 +2582,18 @@ static void change_params(struct slgt_info *info)
 	/* process tty input control flags */
 
 	info->read_status_mask = IRQ_RXOVER;
-	if (I_INPCK(info->port.tty))
+	if (I_INPCK(&info->port.tty->termios))
 		info->read_status_mask |= MASK_PARITY | MASK_FRAMING;
- 	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
+ 	if (I_BRKINT(&info->port.tty->termios) || I_PARMRK(&info->port.tty->termios))
  		info->read_status_mask |= MASK_BREAK;
-	if (I_IGNPAR(info->port.tty))
+	if (I_IGNPAR(&info->port.tty->termios))
 		info->ignore_status_mask |= MASK_PARITY | MASK_FRAMING;
-	if (I_IGNBRK(info->port.tty)) {
+	if (I_IGNBRK(&info->port.tty->termios)) {
 		info->ignore_status_mask |= MASK_BREAK;
 		/* If ignoring parity and break indicators, ignore
 		 * overruns too.  (For real raw support).
 		 */
-		if (I_IGNPAR(info->port.tty))
+		if (I_IGNPAR(&info->port.tty->termios))
 			info->ignore_status_mask |= MASK_OVERRUN;
 	}
 
@@ -3268,7 +3268,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		return 0;
 	}
 
-	if (C_CLOCAL(tty))
+	if (C_CLOCAL(&tty->termios))
 		do_clocal = true;
 
 	/* Wait for carrier detect and the line to become
@@ -3287,7 +3287,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	port->blocked_open++;
 
 	while (1) {
-		if (C_BAUD(tty) && tty_port_initialized(port))
+		if (C_BAUD(&tty->termios) && tty_port_initialized(port))
 			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index dec156586de1..ffefc5e6d66c 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -871,7 +871,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	change_params(info);
 
 	/* Handle transition to B0 status */
-	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
+	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(&tty->termios)) {
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		spin_lock_irqsave(&info->lock,flags);
 	 	set_signals(info);
@@ -879,9 +879,9 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	}
 
 	/* Handle transition away from B0 status */
-	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(tty)) {
+	if (!(old_termios->c_cflag & CBAUD) && C_BAUD(&tty->termios)) {
 		info->serial_signals |= SerialSignal_DTR;
-		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
+		if (!C_CRTSCTS(&tty->termios) || !tty_throttled(tty))
 			info->serial_signals |= SerialSignal_RTS;
 		spin_lock_irqsave(&info->lock,flags);
 	 	set_signals(info);
@@ -889,7 +889,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	}
 
 	/* Handle turning off CRTSCTS */
-	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(tty)) {
+	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(&tty->termios)) {
 		tty->hw_stopped = 0;
 		tx_release(tty);
 	}
@@ -1464,10 +1464,10 @@ static void throttle(struct tty_struct * tty)
 	if (sanity_check(info, tty->name, "throttle"))
 		return;
 
-	if (I_IXOFF(tty))
-		send_xchar(tty, STOP_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		send_xchar(tty, STOP_CHAR(&tty->termios));
 
- 	if (C_CRTSCTS(tty)) {
+ 	if (C_CRTSCTS(&tty->termios)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->serial_signals &= ~SerialSignal_RTS;
 	 	set_signals(info);
@@ -1489,14 +1489,14 @@ static void unthrottle(struct tty_struct * tty)
 	if (sanity_check(info, tty->name, "unthrottle"))
 		return;
 
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else
-			send_xchar(tty, START_CHAR(tty));
+			send_xchar(tty, START_CHAR(&tty->termios));
 	}
 
- 	if (C_CRTSCTS(tty)) {
+ 	if (C_CRTSCTS(&tty->termios)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->serial_signals |= SerialSignal_RTS;
 	 	set_signals(info);
@@ -2819,18 +2819,18 @@ static void change_params(SLMP_INFO *info)
 	/* process tty input control flags */
 
 	info->read_status_mask2 = OVRN;
-	if (I_INPCK(info->port.tty))
+	if (I_INPCK(&info->port.tty->termios))
 		info->read_status_mask2 |= PE | FRME;
- 	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
+ 	if (I_BRKINT(&info->port.tty->termios) || I_PARMRK(&info->port.tty->termios))
  		info->read_status_mask1 |= BRKD;
-	if (I_IGNPAR(info->port.tty))
+	if (I_IGNPAR(&info->port.tty->termios))
 		info->ignore_status_mask2 |= PE | FRME;
-	if (I_IGNBRK(info->port.tty)) {
+	if (I_IGNBRK(&info->port.tty->termios)) {
 		info->ignore_status_mask1 |= BRKD;
 		/* If ignoring parity and break indicators, ignore
 		 * overruns too.  (For real raw support).
 		 */
-		if (I_IGNPAR(info->port.tty))
+		if (I_IGNPAR(&info->port.tty->termios))
 			info->ignore_status_mask2 |= OVRN;
 	}
 
@@ -3285,7 +3285,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		return 0;
 	}
 
-	if (C_CLOCAL(tty))
+	if (C_CLOCAL(&tty->termios))
 		do_clocal = true;
 
 	/* Wait for carrier detect and the line to become
@@ -3308,7 +3308,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	port->blocked_open++;
 
 	while (1) {
-		if (C_BAUD(tty) && tty_port_initialized(port))
+		if (C_BAUD(&tty->termios) && tty_port_initialized(port))
 			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index df2d735338e2..bc0ac47424d0 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -204,7 +204,7 @@ static struct tty_audit_buf *tty_audit_buf_get(void)
 void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size)
 {
 	struct tty_audit_buf *buf;
-	unsigned int icanon = !!L_ICANON(tty);
+	unsigned int icanon = !!L_ICANON(&tty->termios);
 	unsigned int audit_tty;
 	dev_t dev;
 
@@ -219,7 +219,7 @@ void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size)
 	    && tty->driver->subtype == PTY_TYPE_MASTER)
 		return;
 
-	if ((~audit_tty & AUDIT_TTY_LOG_PASSWD) && icanon && !L_ECHO(tty))
+	if ((~audit_tty & AUDIT_TTY_LOG_PASSWD) && icanon && !L_ECHO(&tty->termios))
 		return;
 
 	buf = tty_audit_buf_get();
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index bf36ac9aee41..5d311c6baa7a 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -719,16 +719,16 @@ static int get_sgflags(struct tty_struct *tty)
 {
 	int flags = 0;
 
-	if (!L_ICANON(tty)) {
-		if (L_ISIG(tty))
+	if (!L_ICANON(&tty->termios)) {
+		if (L_ISIG(&tty->termios))
 			flags |= 0x02;		/* cbreak */
 		else
 			flags |= 0x20;		/* raw */
 	}
-	if (L_ECHO(tty))
+	if (L_ECHO(&tty->termios))
 		flags |= 0x08;			/* echo */
-	if (O_OPOST(tty))
-		if (O_ONLCR(tty))
+	if (O_OPOST(&tty->termios))
+		if (O_ONLCR(&tty->termios))
 			flags |= 0x10;		/* crmod */
 	return flags;
 }
@@ -908,7 +908,7 @@ static int tty_change_softcar(struct tty_struct *tty, int arg)
 	tty->termios.c_cflag |= bit;
 	if (tty->ops->set_termios)
 		tty->ops->set_termios(tty, &old);
-	if (C_CLOCAL(tty) != bit)
+	if (C_CLOCAL(&tty->termios) != bit)
 		ret = -EINVAL;
 	up_write(&tty->termios_rwsem);
 	return ret;
@@ -1140,12 +1140,14 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 			spin_unlock_irq(&tty->flow_lock);
 			break;
 		case TCIOFF:
-			if (STOP_CHAR(tty) != __DISABLED_CHAR)
-				retval = tty_send_xchar(tty, STOP_CHAR(tty));
+			if (STOP_CHAR(&tty->termios) != __DISABLED_CHAR)
+				retval = tty_send_xchar(tty,
+							STOP_CHAR(&tty->termios));
 			break;
 		case TCION:
-			if (START_CHAR(tty) != __DISABLED_CHAR)
-				retval = tty_send_xchar(tty, START_CHAR(tty));
+			if (START_CHAR(&tty->termios) != __DISABLED_CHAR)
+				retval = tty_send_xchar(tty,
+							START_CHAR(&tty->termios));
 			break;
 		default:
 			return -EINVAL;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index c3f9d93ba227..5ad4bda512e2 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -210,7 +210,7 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 		 * Drop DTR/RTS if HUPCL is set. This causes any attached
 		 * modem to hang up the line.
 		 */
-		if (tty && C_HUPCL(tty))
+		if (tty && C_HUPCL(&tty->termios))
 			tty_port_lower_dtr_rts(port);
 
 		if (port->ops->shutdown)
@@ -260,7 +260,7 @@ void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 {
 	struct tty_struct *tty = tty_port_tty_get(port);
 
-	if (tty && (!check_clocal || !C_CLOCAL(tty)))
+	if (tty && (!check_clocal || !C_CLOCAL(&tty->termios)))
 		tty_hangup(tty);
 	tty_kref_put(tty);
 }
@@ -371,13 +371,13 @@ int tty_port_block_til_ready(struct tty_port *port,
 	}
 	if (filp->f_flags & O_NONBLOCK) {
 		/* Indicate we are open */
-		if (C_BAUD(tty))
+		if (C_BAUD(&tty->termios))
 			tty_port_raise_dtr_rts(port);
 		tty_port_set_active(port, 1);
 		return 0;
 	}
 
-	if (C_CLOCAL(tty))
+	if (C_CLOCAL(&tty->termios))
 		do_clocal = 1;
 
 	/* Block waiting until we can proceed. We may need to wait for the
@@ -394,7 +394,7 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 	while (1) {
 		/* Indicate we are open */
-		if (C_BAUD(tty) && tty_port_initialized(port))
+		if (C_BAUD(&tty->termios) && tty_port_initialized(port))
 			tty_port_raise_dtr_rts(port);
 
 		prepare_to_wait(&port->open_wait, &wait, TASK_INTERRUPTIBLE);
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 0f8caae4267d..93c72688a497 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1380,7 +1380,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 
 	if (rep &&
 	    (!vc_kbd_mode(kbd, VC_REPEAT) ||
-	     (tty && !L_ECHO(tty) && tty_chars_in_buffer(tty)))) {
+	     (tty && !L_ECHO(&tty->termios) && tty_chars_in_buffer(tty)))) {
 		/*
 		 * Don't repeat a key if the input buffers are not empty and the
 		 * characters get aren't echoed locally. This makes key repeat
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 0f3f62e81e5b..9a91ae55d880 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1067,7 +1067,7 @@ static void acm_tty_set_termios(struct tty_struct *tty,
 	/* FIXME: Needs to clear unsupported bits in the termios */
 	acm->clocal = ((termios->c_cflag & CLOCAL) != 0);
 
-	if (C_BAUD(tty) == B0) {
+	if (C_BAUD(&tty->termios) == B0) {
 		newline.dwDTERate = acm->line.dwDTERate;
 		newctrl &= ~ACM_CTRL_DTR;
 	} else if (termios_old && (termios_old->c_cflag & CBAUD) == B0) {
diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 1532cde8a437..37f5ed6fc071 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -324,7 +324,7 @@ static void ark3116_set_termios(struct tty_struct *tty,
 	mutex_unlock(&priv->hw_lock);
 
 	/* check for software flow control */
-	if (I_IXOFF(tty) || I_IXON(tty)) {
+	if (I_IXOFF(&tty->termios) || I_IXON(&tty->termios)) {
 		dev_warn(&serial->dev->dev,
 			 "%s: don't know how to do software flow control\n",
 			 KBUILD_MODNAME);
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index bbeeb2bd55a8..4e157e9e0173 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -1164,7 +1164,7 @@ static void cypress_read_int_callback(struct urb *urb)
 
 	/* hangup, as defined in acm.c... this might be a bad place for it
 	 * though */
-	if (tty && !C_CLOCAL(tty) && !(priv->current_status & UART_CD)) {
+	if (tty && !C_CLOCAL(&tty->termios) && !(priv->current_status & UART_CD)) {
 		dev_dbg(dev, "%s - calling hangup\n", __func__);
 		tty_hangup(tty);
 		goto continue_read;
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 6a1df9e824ca..391e42ce1ce7 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -699,7 +699,7 @@ static void digi_set_termios(struct tty_struct *tty,
 			/* don't set RTS if using hardware flow control */
 			/* and throttling input */
 			modem_signals = TIOCM_DTR;
-			if (!C_CRTSCTS(tty) || !tty_throttled(tty))
+			if (!C_CRTSCTS(&tty->termios) || !tty_throttled(tty))
 				modem_signals |= TIOCM_RTS;
 			digi_set_modem_signals(port, modem_signals, 1);
 		}
@@ -1509,7 +1509,7 @@ static int digi_read_oob_callback(struct urb *urb)
 
 		rts = 0;
 		if (tty)
-			rts = C_CRTSCTS(tty);
+			rts = C_CRTSCTS(&tty->termios);
 
 		if (tty && opcode == DIGI_CMD_READ_INPUT_SIGNALS) {
 			spin_lock(&priv->dp_port_lock);
diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 972f5a5fe577..3f103645af02 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -447,7 +447,7 @@ static void f81232_set_termios(struct tty_struct *tty,
 	if (old_termios && !tty_termios_hw_change(&tty->termios, old_termios))
 		return;
 
-	if (C_BAUD(tty) == B0)
+	if (C_BAUD(&tty->termios) == B0)
 		f81232_set_mctrl(port, 0, TIOCM_DTR | TIOCM_RTS);
 	else if (old_termios && (old_termios->c_cflag & CBAUD) == B0)
 		f81232_set_mctrl(port, TIOCM_DTR | TIOCM_RTS, 0);
@@ -461,20 +461,20 @@ static void f81232_set_termios(struct tty_struct *tty,
 		f81232_set_baudrate(port, baudrate);
 	}
 
-	if (C_PARENB(tty)) {
+	if (C_PARENB(&tty->termios)) {
 		new_lcr |= UART_LCR_PARITY;
 
-		if (!C_PARODD(tty))
+		if (!C_PARODD(&tty->termios))
 			new_lcr |= UART_LCR_EPAR;
 
-		if (C_CMSPAR(tty))
+		if (C_CMSPAR(&tty->termios))
 			new_lcr |= UART_LCR_SPAR;
 	}
 
-	if (C_CSTOPB(tty))
+	if (C_CSTOPB(&tty->termios))
 		new_lcr |= UART_LCR_STOP;
 
-	switch (C_CSIZE(tty)) {
+	switch (C_CSIZE(&tty->termios)) {
 	case CS5:
 		new_lcr |= UART_LCR_WLEN5;
 		break;
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b2d767e743fc..ab2c8098d1ff 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2224,7 +2224,7 @@ static void ftdi_set_termios(struct tty_struct *tty,
 	 *       The vendor didn't bother with a custom VID/PID of
 	 *       course.
 	 */
-	if (C_CSIZE(tty) == CS6) {
+	if (C_CSIZE(&tty->termios) == CS6) {
 		dev_warn(ddev, "requested CSIZE setting not supported\n");
 
 		termios->c_cflag &= ~CSIZE;
diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 944de657a07a..2b1ba969c1b1 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -596,7 +596,7 @@ void usb_serial_handle_dcd_change(struct usb_serial_port *usb_port,
 
 	if (status)
 		wake_up_interruptible(&port->open_wait);
-	else if (tty && !C_CLOCAL(tty))
+	else if (tty && !C_CLOCAL(&tty->termios))
 		tty_hangup(tty);
 }
 EXPORT_SYMBOL_GPL(usb_serial_handle_dcd_change);
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 11c05ce2f35f..74d1253c5a6d 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1390,15 +1390,15 @@ static void edge_throttle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing XON/XOFF, send the stop character */
-	if (I_IXOFF(tty)) {
-		unsigned char stop_char = STOP_CHAR(tty);
+	if (I_IXOFF(&tty->termios)) {
+		unsigned char stop_char = STOP_CHAR(&tty->termios);
 		status = edge_write(tty, port, &stop_char, 1);
 		if (status <= 0)
 			return;
 	}
 
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		edge_port->shadowMCR &= ~MCR_RTS;
 		status = send_cmd_write_uart_register(edge_port, MCR,
 							edge_port->shadowMCR);
@@ -1428,14 +1428,14 @@ static void edge_unthrottle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing XON/XOFF, send the start character */
-	if (I_IXOFF(tty)) {
-		unsigned char start_char = START_CHAR(tty);
+	if (I_IXOFF(&tty->termios)) {
+		unsigned char start_char = START_CHAR(&tty->termios);
 		status = edge_write(tty, port, &start_char, 1);
 		if (status <= 0)
 			return;
 	}
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		edge_port->shadowMCR |= MCR_RTS;
 		send_cmd_write_uart_register(edge_port, MCR,
 						edge_port->shadowMCR);
@@ -2457,9 +2457,9 @@ static void change_port_settings(struct tty_struct *tty,
 
 	/* if we are implementing XON/XOFF, set the start and stop character
 	   in the device */
-	if (I_IXOFF(tty) || I_IXON(tty)) {
-		unsigned char stop_char  = STOP_CHAR(tty);
-		unsigned char start_char = START_CHAR(tty);
+	if (I_IXOFF(&tty->termios) || I_IXON(&tty->termios)) {
+		unsigned char stop_char  = STOP_CHAR(&tty->termios);
+		unsigned char start_char = START_CHAR(&tty->termios);
 
 		if (!edge_serial->is_epic ||
 		    edge_serial->epic_descriptor.Supports.IOSPSetXChar) {
@@ -2470,7 +2470,7 @@ static void change_port_settings(struct tty_struct *tty,
 		}
 
 		/* if we are implementing INBOUND XON/XOFF */
-		if (I_IXOFF(tty)) {
+		if (I_IXOFF(&tty->termios)) {
 			rxFlow |= IOSP_RX_FLOW_XON_XOFF;
 			dev_dbg(dev, "%s - INBOUND XON/XOFF is enabled, XON = %2x, XOFF = %2x\n",
 				__func__, start_char, stop_char);
@@ -2479,7 +2479,7 @@ static void change_port_settings(struct tty_struct *tty,
 		}
 
 		/* if we are implementing OUTBOUND XON/XOFF */
-		if (I_IXON(tty)) {
+		if (I_IXON(&tty->termios)) {
 			txFlow |= IOSP_TX_FLOW_XON_XOFF;
 			dev_dbg(dev, "%s - OUTBOUND XON/XOFF is enabled, XON = %2x, XOFF = %2x\n",
 				__func__, start_char, stop_char);
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index fce82fd79f77..910447ea32b7 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -1585,7 +1585,7 @@ static void handle_new_msr(struct edgeport_port *edge_port, __u8 msr)
 
 	tty = tty_port_tty_get(&edge_port->port->port);
 	/* handle CTS flow control */
-	if (tty && C_CRTSCTS(tty)) {
+	if (tty && C_CRTSCTS(&tty->termios)) {
 		if (msr & EDGEPORT_MSR_CTS)
 			tty_wakeup(tty);
 	}
@@ -2155,8 +2155,8 @@ static void edge_throttle(struct tty_struct *tty)
 		return;
 
 	/* if we are implementing XON/XOFF, send the stop character */
-	if (I_IXOFF(tty)) {
-		unsigned char stop_char = STOP_CHAR(tty);
+	if (I_IXOFF(&tty->termios)) {
+		unsigned char stop_char = STOP_CHAR(&tty->termios);
 		status = edge_write(tty, port, &stop_char, 1);
 		if (status <= 0) {
 			dev_err(&port->dev, "%s - failed to write stop character, %d\n", __func__, status);
@@ -2167,7 +2167,7 @@ static void edge_throttle(struct tty_struct *tty)
 	 * if we are implementing RTS/CTS, stop reads
 	 * and the Edgeport will clear the RTS line
 	 */
-	if (C_CRTSCTS(tty))
+	if (C_CRTSCTS(&tty->termios))
 		stop_read(edge_port);
 
 }
@@ -2182,8 +2182,8 @@ static void edge_unthrottle(struct tty_struct *tty)
 		return;
 
 	/* if we are implementing XON/XOFF, send the start character */
-	if (I_IXOFF(tty)) {
-		unsigned char start_char = START_CHAR(tty);
+	if (I_IXOFF(&tty->termios)) {
+		unsigned char start_char = START_CHAR(&tty->termios);
 		status = edge_write(tty, port, &start_char, 1);
 		if (status <= 0) {
 			dev_err(&port->dev, "%s - failed to write start character, %d\n", __func__, status);
@@ -2193,7 +2193,7 @@ static void edge_unthrottle(struct tty_struct *tty)
 	 * if we are implementing RTS/CTS, restart reads
 	 * are the Edgeport will assert the RTS line
 	 */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		status = restart_read(edge_port);
 		if (status)
 			dev_err(&port->dev,
@@ -2318,11 +2318,11 @@ static void change_port_settings(struct tty_struct *tty,
 	 * if we are implementing XON/XOFF, set the start and stop
 	 * character in the device
 	 */
-	config->cXon  = START_CHAR(tty);
-	config->cXoff = STOP_CHAR(tty);
+	config->cXon  = START_CHAR(&tty->termios);
+	config->cXoff = STOP_CHAR(&tty->termios);
 
 	/* if we are implementing INBOUND XON/XOFF */
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(&tty->termios)) {
 		config->wFlags |= UMP_MASK_UART_FLAGS_IN_X;
 		dev_dbg(dev, "%s - INBOUND XON/XOFF is enabled, XON = %2x, XOFF = %2x\n",
 			__func__, config->cXon, config->cXoff);
@@ -2330,7 +2330,7 @@ static void change_port_settings(struct tty_struct *tty,
 		dev_dbg(dev, "%s - INBOUND XON/XOFF is disabled\n", __func__);
 
 	/* if we are implementing OUTBOUND XON/XOFF */
-	if (I_IXON(tty)) {
+	if (I_IXON(&tty->termios)) {
 		config->wFlags |= UMP_MASK_UART_FLAGS_OUT_X;
 		dev_dbg(dev, "%s - OUTBOUND XON/XOFF is enabled, XON = %2x, XOFF = %2x\n",
 			__func__, config->cXon, config->cXoff);
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 885655315de1..8f97b8acea99 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -230,7 +230,7 @@ static int mct_u232_set_baud_rate(struct tty_struct *tty,
 			"failed (error = %d)\n", MCT_U232_SET_UNKNOWN1_REQUEST,
 			rc);
 
-	if (port && C_CRTSCTS(tty))
+	if (port && C_CRTSCTS(&tty->termios))
 	   cts_enable_byte = 1;
 
 	dev_dbg(&port->dev, "set_baud_rate: send second control message, data = %02X\n",
@@ -435,7 +435,7 @@ static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	 * either.
 	 */
 	spin_lock_irqsave(&priv->lock, flags);
-	if (tty && C_BAUD(tty))
+	if (tty && C_BAUD(&tty->termios))
 		priv->control_state = TIOCM_DTR | TIOCM_RTS;
 	else
 		priv->control_state = 0;
@@ -743,7 +743,7 @@ static void mct_u232_throttle(struct tty_struct *tty)
 
 	spin_lock_irq(&priv->lock);
 	priv->rx_flags |= THROTTLED;
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		priv->control_state &= ~TIOCM_RTS;
 		control_state = priv->control_state;
 		spin_unlock_irq(&priv->lock);
@@ -760,7 +760,7 @@ static void mct_u232_unthrottle(struct tty_struct *tty)
 	unsigned int control_state;
 
 	spin_lock_irq(&priv->lock);
-	if ((priv->rx_flags & THROTTLED) && C_CRTSCTS(tty)) {
+	if ((priv->rx_flags & THROTTLED) && C_CRTSCTS(&tty->termios)) {
 		priv->rx_flags &= ~THROTTLED;
 		priv->control_state |= TIOCM_RTS;
 		control_state = priv->control_state;
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index de9992b492b0..9bd79ff04713 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1300,15 +1300,15 @@ static void mos7720_throttle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing XON/XOFF, send the stop character */
-	if (I_IXOFF(tty)) {
-		unsigned char stop_char = STOP_CHAR(tty);
+	if (I_IXOFF(&tty->termios)) {
+		unsigned char stop_char = STOP_CHAR(&tty->termios);
 		status = mos7720_write(tty, port, &stop_char, 1);
 		if (status <= 0)
 			return;
 	}
 
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		mos7720_port->shadowMCR &= ~UART_MCR_RTS;
 		write_mos_reg(port->serial, port->port_number, MOS7720_MCR,
 			      mos7720_port->shadowMCR);
@@ -1330,15 +1330,15 @@ static void mos7720_unthrottle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing XON/XOFF, send the start character */
-	if (I_IXOFF(tty)) {
-		unsigned char start_char = START_CHAR(tty);
+	if (I_IXOFF(&tty->termios)) {
+		unsigned char start_char = START_CHAR(&tty->termios);
 		status = mos7720_write(tty, port, &start_char, 1);
 		if (status <= 0)
 			return;
 	}
 
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		mos7720_port->shadowMCR |= UART_MCR_RTS;
 		write_mos_reg(port->serial, port->port_number, MOS7720_MCR,
 			      mos7720_port->shadowMCR);
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 57426d703a09..a6d104697e76 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1418,14 +1418,14 @@ static void mos7840_throttle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing XON/XOFF, send the stop character */
-	if (I_IXOFF(tty)) {
-		unsigned char stop_char = STOP_CHAR(tty);
+	if (I_IXOFF(&tty->termios)) {
+		unsigned char stop_char = STOP_CHAR(&tty->termios);
 		status = mos7840_write(tty, port, &stop_char, 1);
 		if (status <= 0)
 			return;
 	}
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		mos7840_port->shadowMCR &= ~MCR_RTS;
 		status = mos7840_set_uart_reg(port, MODEM_CONTROL_REGISTER,
 					 mos7840_port->shadowMCR);
@@ -1458,15 +1458,15 @@ static void mos7840_unthrottle(struct tty_struct *tty)
 	}
 
 	/* if we are implementing XON/XOFF, send the start character */
-	if (I_IXOFF(tty)) {
-		unsigned char start_char = START_CHAR(tty);
+	if (I_IXOFF(&tty->termios)) {
+		unsigned char start_char = START_CHAR(&tty->termios);
 		status = mos7840_write(tty, port, &start_char, 1);
 		if (status <= 0)
 			return;
 	}
 
 	/* if we are implementing RTS/CTS, toggle that line */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		mos7840_port->shadowMCR |= MCR_RTS;
 		status = mos7840_set_uart_reg(port, MODEM_CONTROL_REGISTER,
 					 mos7840_port->shadowMCR);
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index c88215a0fa3d..a57cac60f048 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -775,8 +775,8 @@ static int mxuport_set_termios_flow(struct tty_struct *tty,
 				    struct usb_serial_port *port,
 				    struct usb_serial *serial)
 {
-	u8 xon = START_CHAR(tty);
-	u8 xoff = STOP_CHAR(tty);
+	u8 xon = START_CHAR(&tty->termios);
+	u8 xoff = STOP_CHAR(&tty->termios);
 	int enable;
 	int err;
 	u8 *buf;
@@ -787,7 +787,7 @@ static int mxuport_set_termios_flow(struct tty_struct *tty,
 		return -ENOMEM;
 
 	/* S/W flow control settings */
-	if (I_IXOFF(tty) || I_IXON(tty)) {
+	if (I_IXOFF(&tty->termios) || I_IXON(&tty->termios)) {
 		enable = 1;
 		buf[0] = xon;
 		buf[1] = xoff;
@@ -813,17 +813,17 @@ static int mxuport_set_termios_flow(struct tty_struct *tty,
 
 	/* H/W flow control settings */
 	if (!old_termios ||
-	    C_CRTSCTS(tty) != (old_termios->c_cflag & CRTSCTS)) {
-		if (C_CRTSCTS(tty))
+	    C_CRTSCTS(&tty->termios) != (old_termios->c_cflag & CRTSCTS)) {
+		if (C_CRTSCTS(&tty->termios))
 			rts = MX_RTS_HW;
 		else
 			rts = MX_RTS_ENABLE;
 	}
 
-	if (C_BAUD(tty)) {
+	if (C_BAUD(&tty->termios)) {
 		if (old_termios && (old_termios->c_cflag & CBAUD) == B0) {
 			/* Raise DTR and RTS */
-			if (C_CRTSCTS(tty))
+			if (C_CRTSCTS(&tty->termios))
 				rts = MX_RTS_HW;
 			else
 				rts = MX_RTS_ENABLE;
@@ -867,7 +867,7 @@ static void mxuport_set_termios(struct tty_struct *tty,
 		return;
 
 	/* Set data bit of termios */
-	switch (C_CSIZE(tty)) {
+	switch (C_CSIZE(&tty->termios)) {
 	case CS5:
 		data_bits = MX_WORDLENGTH_5;
 		break;
@@ -884,14 +884,14 @@ static void mxuport_set_termios(struct tty_struct *tty,
 	}
 
 	/* Set parity of termios */
-	if (C_PARENB(tty)) {
-		if (C_CMSPAR(tty)) {
-			if (C_PARODD(tty))
+	if (C_PARENB(&tty->termios)) {
+		if (C_CMSPAR(&tty->termios)) {
+			if (C_PARODD(&tty->termios))
 				parity = MX_PARITY_MARK;
 			else
 				parity = MX_PARITY_SPACE;
 		} else {
-			if (C_PARODD(tty))
+			if (C_PARODD(&tty->termios))
 				parity = MX_PARITY_ODD;
 			else
 				parity = MX_PARITY_EVEN;
@@ -901,7 +901,7 @@ static void mxuport_set_termios(struct tty_struct *tty,
 	}
 
 	/* Set stop bit of termios */
-	if (C_CSTOPB(tty))
+	if (C_CSTOPB(&tty->termios))
 		stop_bits = MX_STOP_BITS_2;
 	else
 		stop_bits = MX_STOP_BITS_1;
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index ae682e4eeaef..7f64e081defa 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -499,7 +499,7 @@ static void pl2303_set_termios(struct tty_struct *tty,
 
 	pl2303_get_line_request(port, buf);
 
-	switch (C_CSIZE(tty)) {
+	switch (C_CSIZE(&tty->termios)) {
 	case CS5:
 		buf[6] = 5;
 		break;
@@ -521,12 +521,12 @@ static void pl2303_set_termios(struct tty_struct *tty,
 	/* For reference buf[4]=0 is 1 stop bits */
 	/* For reference buf[4]=1 is 1.5 stop bits */
 	/* For reference buf[4]=2 is 2 stop bits */
-	if (C_CSTOPB(tty)) {
+	if (C_CSTOPB(&tty->termios)) {
 		/*
 		 * NOTE: Comply with "real" UARTs / RS232:
 		 *       use 1.5 instead of 2 stop bits with 5 data bits
 		 */
-		if (C_CSIZE(tty) == CS5) {
+		if (C_CSIZE(&tty->termios) == CS5) {
 			buf[4] = 1;
 			dev_dbg(&port->dev, "stop bits = 1.5\n");
 		} else {
@@ -538,14 +538,14 @@ static void pl2303_set_termios(struct tty_struct *tty,
 		dev_dbg(&port->dev, "stop bits = 1\n");
 	}
 
-	if (C_PARENB(tty)) {
+	if (C_PARENB(&tty->termios)) {
 		/* For reference buf[5]=0 is none parity */
 		/* For reference buf[5]=1 is odd parity */
 		/* For reference buf[5]=2 is even parity */
 		/* For reference buf[5]=3 is mark parity */
 		/* For reference buf[5]=4 is space parity */
-		if (C_PARODD(tty)) {
-			if (C_CMSPAR(tty)) {
+		if (C_PARODD(&tty->termios)) {
+			if (C_CMSPAR(&tty->termios)) {
 				buf[5] = 3;
 				dev_dbg(&port->dev, "parity = mark\n");
 			} else {
@@ -553,7 +553,7 @@ static void pl2303_set_termios(struct tty_struct *tty,
 				dev_dbg(&port->dev, "parity = odd\n");
 			}
 		} else {
-			if (C_CMSPAR(tty)) {
+			if (C_CMSPAR(&tty->termios)) {
 				buf[5] = 4;
 				dev_dbg(&port->dev, "parity = space\n");
 			} else {
@@ -587,7 +587,7 @@ static void pl2303_set_termios(struct tty_struct *tty,
 	/* change control lines if we are switching to or from B0 */
 	spin_lock_irqsave(&priv->lock, flags);
 	control = priv->line_control;
-	if (C_BAUD(tty) == B0)
+	if (C_BAUD(&tty->termios) == B0)
 		priv->line_control &= ~(CONTROL_DTR | CONTROL_RTS);
 	else if (old_termios && (old_termios->c_cflag & CBAUD) == B0)
 		priv->line_control |= (CONTROL_DTR | CONTROL_RTS);
@@ -599,7 +599,7 @@ static void pl2303_set_termios(struct tty_struct *tty,
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		if (spriv->quirks & PL2303_QUIRK_LEGACY)
 			pl2303_vendor_write(serial, 0x0, 0x41);
 		else
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 85acb50a7ee2..e301099b6814 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -321,8 +321,8 @@ static void qt2_set_termios(struct tty_struct *tty,
 		dev_err(&port->dev, "%s - set HW flow control failed: %i\n",
 			__func__, status);
 
-	if (I_IXOFF(tty) || I_IXON(tty)) {
-		u16 x = ((u16) (START_CHAR(tty) << 8) | (u16) (STOP_CHAR(tty)));
+	if (I_IXOFF(&tty->termios) || I_IXON(&tty->termios)) {
+		u16 x = ((u16) (START_CHAR(&tty->termios) << 8) | (u16) (STOP_CHAR(&tty->termios)));
 
 		status = qt2_control_msg(dev, QT_SW_FLOW_CONTROL_MASK,
 					 x, port_priv->device_port);
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 70a098de429f..a889e2c5d542 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -258,8 +258,8 @@ static void ssu100_set_termios(struct tty_struct *tty,
 	if (result < 0)
 		dev_dbg(&port->dev, "%s - set HW flow control failed\n", __func__);
 
-	if (I_IXOFF(tty) || I_IXON(tty)) {
-		u16 x = ((u16)(START_CHAR(tty) << 8) | (u16)(STOP_CHAR(tty)));
+	if (I_IXOFF(&tty->termios) || I_IXON(&tty->termios)) {
+		u16 x = ((u16)(START_CHAR(&tty->termios) << 8) | (u16)(STOP_CHAR(&tty->termios)));
 
 		result = ssu100_control_msg(dev, QT_SW_FLOW_CONTROL_MASK,
 					    x, 0);
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 07b4bf01061d..3e1c1a42d14a 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -903,7 +903,7 @@ static void ti_throttle(struct tty_struct *tty)
 	if (tport == NULL)
 		return;
 
-	if (I_IXOFF(tty) || C_CRTSCTS(tty))
+	if (I_IXOFF(&tty->termios) || C_CRTSCTS(&tty->termios))
 		ti_stop_read(tport, tty);
 
 }
@@ -918,7 +918,7 @@ static void ti_unthrottle(struct tty_struct *tty)
 	if (tport == NULL)
 		return;
 
-	if (I_IXOFF(tty) || C_CRTSCTS(tty)) {
+	if (I_IXOFF(&tty->termios) || C_CRTSCTS(&tty->termios)) {
 		status = ti_restart_read(tport, tty);
 		if (status)
 			dev_err(&port->dev, "%s - cannot restart read, %d\n",
@@ -1027,16 +1027,16 @@ static void ti_set_termios(struct tty_struct *tty,
 		ti_restart_read(tport, tty);
 	}
 
-	if (I_IXOFF(tty) || I_IXON(tty)) {
-		config->cXon  = START_CHAR(tty);
-		config->cXoff = STOP_CHAR(tty);
+	if (I_IXOFF(&tty->termios) || I_IXON(&tty->termios)) {
+		config->cXon  = START_CHAR(&tty->termios);
+		config->cXoff = STOP_CHAR(&tty->termios);
 
-		if (I_IXOFF(tty))
+		if (I_IXOFF(&tty->termios))
 			config->wFlags |= TI_UART_ENABLE_X_IN;
 		else
 			ti_restart_read(tport, tty);
 
-		if (I_IXON(tty))
+		if (I_IXON(&tty->termios))
 			config->wFlags |= TI_UART_ENABLE_X_OUT;
 	}
 
@@ -1549,7 +1549,7 @@ static void ti_handle_new_msr(struct ti_port *tport, __u8 msr)
 
 	/* handle CTS flow control */
 	tty = tty_port_tty_get(&tport->tp_port->port);
-	if (tty && C_CRTSCTS(tty)) {
+	if (tty && C_CRTSCTS(&tty->termios)) {
 		if (msr & TI_MSR_CTS)
 			tty_wakeup(tty);
 	}
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index d3ea90bef84d..d11edb41db75 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -726,14 +726,14 @@ static void firm_setup_port(struct tty_struct *tty)
 	    (port_settings.hflow & WHITEHEAT_HFLOW_DTR) ? "DTR" : "");
 
 	/* determine software flow control */
-	if (I_IXOFF(tty))
+	if (I_IXOFF(&tty->termios))
 		port_settings.sflow = WHITEHEAT_SFLOW_RXTX;
 	else
 		port_settings.sflow = WHITEHEAT_SFLOW_NONE;
 	dev_dbg(dev, "%s - software flow control = %c\n", __func__, port_settings.sflow);
 
-	port_settings.xon = START_CHAR(tty);
-	port_settings.xoff = STOP_CHAR(tty);
+	port_settings.xon = START_CHAR(&tty->termios);
+	port_settings.xoff = STOP_CHAR(&tty->termios);
 	dev_dbg(dev, "%s - XON = %2x, XOFF = %2x\n", __func__, port_settings.xon, port_settings.xoff);
 
 	/* get the baud rate wanted */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 40144f382516..73a8c38987f5 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -101,88 +101,88 @@ struct tty_bufhead {
 #define TTY_PARITY	3
 #define TTY_OVERRUN	4
 
-#define INTR_CHAR(tty) ((tty)->termios.c_cc[VINTR])
-#define QUIT_CHAR(tty) ((tty)->termios.c_cc[VQUIT])
-#define ERASE_CHAR(tty) ((tty)->termios.c_cc[VERASE])
-#define KILL_CHAR(tty) ((tty)->termios.c_cc[VKILL])
-#define EOF_CHAR(tty) ((tty)->termios.c_cc[VEOF])
-#define TIME_CHAR(tty) ((tty)->termios.c_cc[VTIME])
-#define MIN_CHAR(tty) ((tty)->termios.c_cc[VMIN])
-#define SWTC_CHAR(tty) ((tty)->termios.c_cc[VSWTC])
-#define START_CHAR(tty) ((tty)->termios.c_cc[VSTART])
-#define STOP_CHAR(tty) ((tty)->termios.c_cc[VSTOP])
-#define SUSP_CHAR(tty) ((tty)->termios.c_cc[VSUSP])
-#define EOL_CHAR(tty) ((tty)->termios.c_cc[VEOL])
-#define REPRINT_CHAR(tty) ((tty)->termios.c_cc[VREPRINT])
-#define DISCARD_CHAR(tty) ((tty)->termios.c_cc[VDISCARD])
-#define WERASE_CHAR(tty) ((tty)->termios.c_cc[VWERASE])
-#define LNEXT_CHAR(tty)	((tty)->termios.c_cc[VLNEXT])
-#define EOL2_CHAR(tty) ((tty)->termios.c_cc[VEOL2])
-
-#define _I_FLAG(tty, f)	((tty)->termios.c_iflag & (f))
-#define _O_FLAG(tty, f)	((tty)->termios.c_oflag & (f))
-#define _C_FLAG(tty, f)	((tty)->termios.c_cflag & (f))
-#define _L_FLAG(tty, f)	((tty)->termios.c_lflag & (f))
-
-#define I_IGNBRK(tty)	_I_FLAG((tty), IGNBRK)
-#define I_BRKINT(tty)	_I_FLAG((tty), BRKINT)
-#define I_IGNPAR(tty)	_I_FLAG((tty), IGNPAR)
-#define I_PARMRK(tty)	_I_FLAG((tty), PARMRK)
-#define I_INPCK(tty)	_I_FLAG((tty), INPCK)
-#define I_ISTRIP(tty)	_I_FLAG((tty), ISTRIP)
-#define I_INLCR(tty)	_I_FLAG((tty), INLCR)
-#define I_IGNCR(tty)	_I_FLAG((tty), IGNCR)
-#define I_ICRNL(tty)	_I_FLAG((tty), ICRNL)
-#define I_IUCLC(tty)	_I_FLAG((tty), IUCLC)
-#define I_IXON(tty)	_I_FLAG((tty), IXON)
-#define I_IXANY(tty)	_I_FLAG((tty), IXANY)
-#define I_IXOFF(tty)	_I_FLAG((tty), IXOFF)
-#define I_IMAXBEL(tty)	_I_FLAG((tty), IMAXBEL)
-#define I_IUTF8(tty)	_I_FLAG((tty), IUTF8)
-
-#define O_OPOST(tty)	_O_FLAG((tty), OPOST)
-#define O_OLCUC(tty)	_O_FLAG((tty), OLCUC)
-#define O_ONLCR(tty)	_O_FLAG((tty), ONLCR)
-#define O_OCRNL(tty)	_O_FLAG((tty), OCRNL)
-#define O_ONOCR(tty)	_O_FLAG((tty), ONOCR)
-#define O_ONLRET(tty)	_O_FLAG((tty), ONLRET)
-#define O_OFILL(tty)	_O_FLAG((tty), OFILL)
-#define O_OFDEL(tty)	_O_FLAG((tty), OFDEL)
-#define O_NLDLY(tty)	_O_FLAG((tty), NLDLY)
-#define O_CRDLY(tty)	_O_FLAG((tty), CRDLY)
-#define O_TABDLY(tty)	_O_FLAG((tty), TABDLY)
-#define O_BSDLY(tty)	_O_FLAG((tty), BSDLY)
-#define O_VTDLY(tty)	_O_FLAG((tty), VTDLY)
-#define O_FFDLY(tty)	_O_FLAG((tty), FFDLY)
-
-#define C_BAUD(tty)	_C_FLAG((tty), CBAUD)
-#define C_CSIZE(tty)	_C_FLAG((tty), CSIZE)
-#define C_CSTOPB(tty)	_C_FLAG((tty), CSTOPB)
-#define C_CREAD(tty)	_C_FLAG((tty), CREAD)
-#define C_PARENB(tty)	_C_FLAG((tty), PARENB)
-#define C_PARODD(tty)	_C_FLAG((tty), PARODD)
-#define C_HUPCL(tty)	_C_FLAG((tty), HUPCL)
-#define C_CLOCAL(tty)	_C_FLAG((tty), CLOCAL)
-#define C_CIBAUD(tty)	_C_FLAG((tty), CIBAUD)
-#define C_CRTSCTS(tty)	_C_FLAG((tty), CRTSCTS)
-#define C_CMSPAR(tty)	_C_FLAG((tty), CMSPAR)
-
-#define L_ISIG(tty)	_L_FLAG((tty), ISIG)
-#define L_ICANON(tty)	_L_FLAG((tty), ICANON)
-#define L_XCASE(tty)	_L_FLAG((tty), XCASE)
-#define L_ECHO(tty)	_L_FLAG((tty), ECHO)
-#define L_ECHOE(tty)	_L_FLAG((tty), ECHOE)
-#define L_ECHOK(tty)	_L_FLAG((tty), ECHOK)
-#define L_ECHONL(tty)	_L_FLAG((tty), ECHONL)
-#define L_NOFLSH(tty)	_L_FLAG((tty), NOFLSH)
-#define L_TOSTOP(tty)	_L_FLAG((tty), TOSTOP)
-#define L_ECHOCTL(tty)	_L_FLAG((tty), ECHOCTL)
-#define L_ECHOPRT(tty)	_L_FLAG((tty), ECHOPRT)
-#define L_ECHOKE(tty)	_L_FLAG((tty), ECHOKE)
-#define L_FLUSHO(tty)	_L_FLAG((tty), FLUSHO)
-#define L_PENDIN(tty)	_L_FLAG((tty), PENDIN)
-#define L_IEXTEN(tty)	_L_FLAG((tty), IEXTEN)
-#define L_EXTPROC(tty)	_L_FLAG((tty), EXTPROC)
+#define INTR_CHAR(termios)	((termios)->c_cc[VINTR])
+#define QUIT_CHAR(termios)	((termios)->c_cc[VQUIT])
+#define ERASE_CHAR(termios)	((termios)->c_cc[VERASE])
+#define KILL_CHAR(termios)	((termios)->c_cc[VKILL])
+#define EOF_CHAR(termios)	((termios)->c_cc[VEOF])
+#define TIME_CHAR(termios)	((termios)->c_cc[VTIME])
+#define MIN_CHAR(termios)	((termios)->c_cc[VMIN])
+#define SWTC_CHAR(termios)	((termios)->c_cc[VSWTC])
+#define START_CHAR(termios)	((termios)->c_cc[VSTART])
+#define STOP_CHAR(termios)	((termios)->c_cc[VSTOP])
+#define SUSP_CHAR(termios)	((termios)->c_cc[VSUSP])
+#define EOL_CHAR(termios)	((termios)->c_cc[VEOL])
+#define REPRINT_CHAR(termios)	((termios)->c_cc[VREPRINT])
+#define DISCARD_CHAR(termios)	((termios)->c_cc[VDISCARD])
+#define WERASE_CHAR(termios)	((termios)->c_cc[VWERASE])
+#define LNEXT_CHAR(termios)	((termios)->c_cc[VLNEXT])
+#define EOL2_CHAR(termios)	((termios)->c_cc[VEOL2])
+
+#define _I_FLAG(termios, f)	((termios)->c_iflag & (f))
+#define _O_FLAG(termios, f)	((termios)->c_oflag & (f))
+#define _C_FLAG(termios, f)	((termios)->c_cflag & (f))
+#define _L_FLAG(termios, f)	((termios)->c_lflag & (f))
+
+#define I_IGNBRK(termios)	_I_FLAG((termios), IGNBRK)
+#define I_BRKINT(termios)	_I_FLAG((termios), BRKINT)
+#define I_IGNPAR(termios)	_I_FLAG((termios), IGNPAR)
+#define I_PARMRK(termios)	_I_FLAG((termios), PARMRK)
+#define I_INPCK(termios)	_I_FLAG((termios), INPCK)
+#define I_ISTRIP(termios)	_I_FLAG((termios), ISTRIP)
+#define I_INLCR(termios)	_I_FLAG((termios), INLCR)
+#define I_IGNCR(termios)	_I_FLAG((termios), IGNCR)
+#define I_ICRNL(termios)	_I_FLAG((termios), ICRNL)
+#define I_IUCLC(termios)	_I_FLAG((termios), IUCLC)
+#define I_IXON(termios)		_I_FLAG((termios), IXON)
+#define I_IXANY(termios)	_I_FLAG((termios), IXANY)
+#define I_IXOFF(termios)	_I_FLAG((termios), IXOFF)
+#define I_IMAXBEL(termios)	_I_FLAG((termios), IMAXBEL)
+#define I_IUTF8(termios)	_I_FLAG((termios), IUTF8)
+
+#define O_OPOST(termios)	_O_FLAG((termios), OPOST)
+#define O_OLCUC(termios)	_O_FLAG((termios), OLCUC)
+#define O_ONLCR(termios)	_O_FLAG((termios), ONLCR)
+#define O_OCRNL(termios)	_O_FLAG((termios), OCRNL)
+#define O_ONOCR(termios)	_O_FLAG((termios), ONOCR)
+#define O_ONLRET(termios)	_O_FLAG((termios), ONLRET)
+#define O_OFILL(termios)	_O_FLAG((termios), OFILL)
+#define O_OFDEL(termios)	_O_FLAG((termios), OFDEL)
+#define O_NLDLY(termios)	_O_FLAG((termios), NLDLY)
+#define O_CRDLY(termios)	_O_FLAG((termios), CRDLY)
+#define O_TABDLY(termios)	_O_FLAG((termios), TABDLY)
+#define O_BSDLY(termios)	_O_FLAG((termios), BSDLY)
+#define O_VTDLY(termios)	_O_FLAG((termios), VTDLY)
+#define O_FFDLY(termios)	_O_FLAG((termios), FFDLY)
+
+#define C_BAUD(termios)		_C_FLAG((termios), CBAUD)
+#define C_CSIZE(termios)	_C_FLAG((termios), CSIZE)
+#define C_CSTOPB(termios)	_C_FLAG((termios), CSTOPB)
+#define C_CREAD(termios)	_C_FLAG((termios), CREAD)
+#define C_PARENB(termios)	_C_FLAG((termios), PARENB)
+#define C_PARODD(termios)	_C_FLAG((termios), PARODD)
+#define C_HUPCL(termios)	_C_FLAG((termios), HUPCL)
+#define C_CLOCAL(termios)	_C_FLAG((termios), CLOCAL)
+#define C_CIBAUD(termios)	_C_FLAG((termios), CIBAUD)
+#define C_CRTSCTS(termios)	_C_FLAG((termios), CRTSCTS)
+#define C_CMSPAR(termios)	_C_FLAG((termios), CMSPAR)
+
+#define L_ISIG(termios)		_L_FLAG((termios), ISIG)
+#define L_ICANON(termios)	_L_FLAG((termios), ICANON)
+#define L_XCASE(termios)	_L_FLAG((termios), XCASE)
+#define L_ECHO(termios)		_L_FLAG((termios), ECHO)
+#define L_ECHOE(termios)	_L_FLAG((termios), ECHOE)
+#define L_ECHOK(termios)	_L_FLAG((termios), ECHOK)
+#define L_ECHONL(termios)	_L_FLAG((termios), ECHONL)
+#define L_NOFLSH(termios)	_L_FLAG((termios), NOFLSH)
+#define L_TOSTOP(termios)	_L_FLAG((termios), TOSTOP)
+#define L_ECHOCTL(termios)	_L_FLAG((termios), ECHOCTL)
+#define L_ECHOPRT(termios)	_L_FLAG((termios), ECHOPRT)
+#define L_ECHOKE(termios)	_L_FLAG((termios), ECHOKE)
+#define L_FLUSHO(termios)	_L_FLAG((termios), FLUSHO)
+#define L_PENDIN(termios)	_L_FLAG((termios), PENDIN)
+#define L_IEXTEN(termios)	_L_FLAG((termios), IEXTEN)
+#define L_EXTPROC(termios)	_L_FLAG((termios), EXTPROC)
 
 struct device;
 struct signal_struct;
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index 873c4b707d6a..ccfff1c1d278 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -288,14 +288,14 @@ static int ircomm_tty_block_til_ready(struct ircomm_tty_cb *self,
 
 	if (filp->f_flags & O_NONBLOCK) {
 		/* nonblock mode is set */
-		if (C_BAUD(tty))
+		if (C_BAUD(&tty->termios))
 			tty_port_raise_dtr_rts(port);
 		tty_port_set_active(port, 1);
 		pr_debug("%s(), O_NONBLOCK requested!\n", __func__);
 		return 0;
 	}
 
-	if (C_CLOCAL(tty)) {
+	if (C_CLOCAL(&tty->termios)) {
 		pr_debug("%s(), doing CLOCAL!\n", __func__);
 		do_clocal = 1;
 	}
@@ -319,7 +319,7 @@ static int ircomm_tty_block_til_ready(struct ircomm_tty_cb *self,
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	while (1) {
-		if (C_BAUD(tty) && tty_port_initialized(port))
+		if (C_BAUD(&tty->termios) && tty_port_initialized(port))
 			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -802,11 +802,11 @@ static void ircomm_tty_throttle(struct tty_struct *tty)
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
 	/* Software flow control? */
-	if (I_IXOFF(tty))
-		ircomm_tty_send_xchar(tty, STOP_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		ircomm_tty_send_xchar(tty, STOP_CHAR(&tty->termios));
 
 	/* Hardware flow control? */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		self->settings.dte &= ~IRCOMM_RTS;
 		self->settings.dte |= IRCOMM_DELTA_RTS;
 
@@ -831,11 +831,11 @@ static void ircomm_tty_unthrottle(struct tty_struct *tty)
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
 	/* Using software flow control? */
-	if (I_IXOFF(tty))
-		ircomm_tty_send_xchar(tty, START_CHAR(tty));
+	if (I_IXOFF(&tty->termios))
+		ircomm_tty_send_xchar(tty, START_CHAR(&tty->termios));
 
 	/* Using hardware flow control? */
-	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(&tty->termios)) {
 		self->settings.dte |= (IRCOMM_RTS|IRCOMM_DELTA_RTS);
 
 		ircomm_param_request(self, IRCOMM_DTE, TRUE);
diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index 8f5678cb6263..78349fc346f3 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -162,13 +162,13 @@ void ircomm_tty_set_termios(struct tty_struct *tty,
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		self->settings.dte |= IRCOMM_DTR;
-		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
+		if (!C_CRTSCTS(&tty->termios) || !tty_throttled(tty))
 			self->settings.dte |= IRCOMM_RTS;
 		ircomm_param_request(self, IRCOMM_DTE, TRUE);
 	}
 
 	/* Handle turning off CRTSCTS */
-	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty))
+	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios))
 	{
 		tty->hw_stopped = 0;
 		ircomm_tty_start(tty);
-- 
2.9.3
