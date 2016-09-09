From: Rob Herring <robh@kernel.org>
Subject: [PATCH 4/9] tty: move TTY_IO_ERROR flag to tty_port iflags
Date: Fri,  9 Sep 2016 17:37:05 -0500
Message-ID: <20160909223711.26238-5-robh@kernel.org>
References: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

TTY_IO_ERROR is a property of the tty port rather than the tty, so move
it to tty_port struct and remove another dependency on tty_struct from
drivers.

Partially converted with coccinelle:

@@
identifier t;
identifier func;
@@
- func(TTY_IO_ERROR, &t->flags)
+ func(TTY_PORT_IO_ERROR, &t->port->iflags)

@@
expression port;
identifier func;
@@
- func(TTY_IO_ERROR, &port.tty->flags)
+ func(TTY_PORT_IO_ERROR, &port.iflags)

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/pcmcia/synclink_cs.c   |  6 +++---
 drivers/isdn/i4l/isdn_tty.c         |  4 ++--
 drivers/mmc/card/sdio_uart.c        |  4 ++--
 drivers/staging/fwserial/fwserial.c |  4 ++--
 drivers/tty/amiserial.c             |  6 +++---
 drivers/tty/cyclades.c              | 12 ++++++------
 drivers/tty/mxser.c                 |  6 +++---
 drivers/tty/pty.c                   |  6 +++---
 drivers/tty/serial/crisv10.c        |  4 ++--
 drivers/tty/serial/ioc4_serial.c    |  2 +-
 drivers/tty/serial/serial_core.c    |  5 ++---
 drivers/tty/synclink.c              |  6 +++---
 drivers/tty/synclink_gt.c           |  4 ++--
 drivers/tty/synclinkmp.c            |  4 ++--
 drivers/tty/tty_port.c              |  6 +++---
 include/linux/tty.h                 |  5 +++--
 net/bluetooth/rfcomm/tty.c          |  2 +-
 net/irda/ircomm/ircomm_tty.c        |  2 +-
 18 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 39a3748ef6c9..86ff86712ee7 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1300,7 +1300,7 @@ static int startup(MGSLPC_INFO * info, struct tty_struct *tty)
 
 	if (retval) {
 		if (capable(CAP_SYS_ADMIN) && tty)
-			set_bit(TTY_IO_ERROR, &tty->flags);
+			set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 		release_resources(info);
 		return retval;
 	}
@@ -1309,7 +1309,7 @@ static int startup(MGSLPC_INFO * info, struct tty_struct *tty)
 	mgslpc_change_params(info, tty);
 
 	if (tty)
-		clear_bit(TTY_IO_ERROR, &tty->flags);
+		clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 
 	tty_port_set_initialized(&info->port, 1);
 
@@ -1359,7 +1359,7 @@ static void shutdown(MGSLPC_INFO * info, struct tty_struct *tty)
 	release_resources(info);
 
 	if (tty)
-		set_bit(TTY_IO_ERROR, &tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 
 	tty_port_set_initialized(&info->port, 0);
 }
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index ca5ea73a3fc9..76bb852c3dc9 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1060,7 +1060,7 @@ isdn_tty_startup(modem_info *info)
 	 */
 	info->mcr = UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2;
 	if (info->port.tty)
-		clear_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		clear_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 	/*
 	 * and set the speed of the serial port
 	 */
@@ -1097,7 +1097,7 @@ isdn_tty_shutdown(modem_info *info)
 		}
 	}
 	if (info->port.tty)
-		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 
 	tty_port_set_initialized(&info->port, 0);
 }
diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index d6d6a2e345ea..fa99cd32999f 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -607,7 +607,7 @@ static int sdio_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 	 * Set the TTY IO error marker - we will only clear this
 	 * once we have successfully opened the port.
 	 */
-	set_bit(TTY_IO_ERROR, &tty->flags);
+	set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 
 	kfifo_reset(&port->xmit_fifo);
 
@@ -655,7 +655,7 @@ static int sdio_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 		if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS))
 			tty->port->hw_stopped = 1;
 
-	clear_bit(TTY_IO_ERROR, &tty->flags);
+	clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 
 	/* Kick the IRQ handler once while we're still holding the host lock */
 	sdio_uart_irq(port->func);
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 0dfdc9dc9672..aff79647fd0e 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -992,7 +992,7 @@ static int fwtty_port_activate(struct tty_port *tty_port,
 	unsigned int baud;
 	int err;
 
-	set_bit(TTY_IO_ERROR, &tty->flags);
+	set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 
 	err = dma_fifo_alloc(&port->tx_fifo, FWTTY_PORT_TXFIFO_LEN,
 			     cache_line_size(),
@@ -1019,7 +1019,7 @@ static int fwtty_port_activate(struct tty_port *tty_port,
 	__fwtty_write_port_status(port);
 	spin_unlock_bh(&port->lock);
 
-	clear_bit(TTY_IO_ERROR, &tty->flags);
+	clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 
 	return 0;
 }
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index be6d59b910f8..7b2e44bb85f6 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -547,7 +547,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 	retval = request_irq(IRQ_AMIGA_VERTB, ser_vbl_int, 0, "serial status", info);
 	if (retval) {
 	  if (serial_isroot()) {
-	      set_bit(TTY_IO_ERROR, &tty->flags);
+	      set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	    retval = 0;
 	  }
 	  goto errout;
@@ -566,7 +566,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 	  info->MCR = SER_DTR | SER_RTS;
 	rtsdtr_ctrl(info->MCR);
 
-	clear_bit(TTY_IO_ERROR, &tty->flags);
+	clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	info->xmit.head = info->xmit.tail = 0;
 
 	/*
@@ -643,7 +643,7 @@ static void shutdown(struct tty_struct *tty, struct serial_state *info)
 		info->MCR &= ~(SER_DTR|SER_RTS);
 	rtsdtr_ctrl(info->MCR);
 
-	set_bit(TTY_IO_ERROR, &tty->flags);
+	set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 
 	tty_port_set_initialized(&info->tport, 0);
 	local_irq_restore(flags);
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 07f92c04cd6d..14370d97d199 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -1281,7 +1281,7 @@ static int cy_startup(struct cyclades_port *info, struct tty_struct *tty)
 		goto errout;
 
 	if (!info->type) {
-		set_bit(TTY_IO_ERROR, &tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 		goto errout;
 	}
 
@@ -1364,7 +1364,7 @@ static int cy_startup(struct cyclades_port *info, struct tty_struct *tty)
 
 	tty_port_set_initialized(&info->port, 1);
 
-	clear_bit(TTY_IO_ERROR, &tty->flags);
+	clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
 	info->breakon = info->breakoff = 0;
 	memset((char *)&info->idle_stats, 0, sizeof(info->idle_stats));
@@ -1445,7 +1445,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 		/* it may be appropriate to clear _XMIT at
 		   some later date (after testing)!!! */
 
-		set_bit(TTY_IO_ERROR, &tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 		tty_port_set_initialized(&info->port, 0);
 		spin_unlock_irqrestore(&card->card_lock, flags);
 	} else {
@@ -1470,7 +1470,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 		if (C_HUPCL(&tty->termios))
 			tty_port_lower_dtr_rts(&info->port);
 
-		set_bit(TTY_IO_ERROR, &tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 		tty_port_set_initialized(&info->port, 0);
 
 		spin_unlock_irqrestore(&card->card_lock, flags);
@@ -2147,7 +2147,7 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 		else
 			cyy_change_rts_dtr(info, TIOCM_DTR, 0);
 
-		clear_bit(TTY_IO_ERROR, &tty->flags);
+		clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 		spin_unlock_irqrestore(&card->card_lock, flags);
 
 	} else {
@@ -2267,7 +2267,7 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 				"was %x\n", info->line, retval);
 		}
 
-		clear_bit(TTY_IO_ERROR, &tty->flags);
+		clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	}
 }				/* set_line_char */
 
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 72ae8a990a79..ec3a6ecc4b58 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -870,7 +870,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	spin_lock_irqsave(&info->slock, flags);
 
 	if (!info->ioaddr || !info->type) {
-		set_bit(TTY_IO_ERROR, &tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 		free_page(page);
 		spin_unlock_irqrestore(&info->slock, flags);
 		return 0;
@@ -897,7 +897,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	if (inb(info->ioaddr + UART_LSR) == 0xff) {
 		spin_unlock_irqrestore(&info->slock, flags);
 		if (capable(CAP_SYS_ADMIN)) {
-			set_bit(TTY_IO_ERROR, &tty->flags);
+			set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 			return 0;
 		} else
 			return -ENODEV;
@@ -935,7 +935,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	(void) inb(info->ioaddr + UART_IIR);
 	(void) inb(info->ioaddr + UART_MSR);
 
-	clear_bit(TTY_IO_ERROR, &tty->flags);
+	clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
 
 	/*
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 7c51ff7f9030..e77579e0e3c5 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -49,7 +49,7 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 		if (tty->count > 2)
 			return;
 	}
-	set_bit(TTY_IO_ERROR, &tty->flags);
+	set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	wake_up_interruptible(&tty->read_wait);
 	wake_up_interruptible(&tty->write_wait);
 	spin_lock_irq(&tty->ctrl_lock);
@@ -246,13 +246,13 @@ static int pty_open(struct tty_struct *tty, struct file *filp)
 	if (tty->driver->subtype == PTY_TYPE_SLAVE && tty->link->count != 1)
 		goto out;
 
-	clear_bit(TTY_IO_ERROR, &tty->flags);
+	clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
 	set_bit(TTY_THROTTLED, &tty->flags);
 	return 0;
 
 out:
-	set_bit(TTY_IO_ERROR, &tty->flags);
+	set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	return -EIO;
 }
 
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index a45dc9d27b87..906ca2621f6a 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -2659,7 +2659,7 @@ startup(struct e100_serial * info)
 	}
 
 	if (info->port.tty)
-		clear_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		clear_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 
 	info->xmit.head = info->xmit.tail = 0;
 	info->first_recv_buffer = info->last_recv_buffer = NULL;
@@ -2775,7 +2775,7 @@ shutdown(struct e100_serial * info)
 	}
 
 	if (info->port.tty)
-		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 
 	tty_port_set_initialized(&info->port, 0);
 	local_irq_restore(flags);
diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index e5c42fef69d2..284639e2cea6 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -2442,7 +2442,7 @@ static void ic4_shutdown(struct uart_port *the_port)
 	wake_up_interruptible(&state->port.delta_msr_wait);
 
 	if (state->port.tty)
-		set_bit(TTY_IO_ERROR, &state->port.tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &state->port.iflags);
 
 	spin_lock_irqsave(&the_port->lock, port_flags);
 	set_notification(port, N_ALL, 0);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 73b7a7ae7862..70aea76dbfb7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -237,7 +237,7 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 
 	retval = uart_port_startup(tty, state, init_hw);
 	if (retval)
-		set_bit(TTY_IO_ERROR, &tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &port->iflags);
 
 	return retval;
 }
@@ -257,8 +257,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	/*
 	 * Set the TTY IO error marker
 	 */
-	if (tty)
-		set_bit(TTY_IO_ERROR, &tty->flags);
+	set_bit(TTY_PORT_IO_ERROR, &port->iflags);
 
 	if (tty_port_initialized(port)) {
 		tty_port_set_initialized(port, 0);
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 57f678c6484e..48e63dd15595 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -1780,7 +1780,7 @@ static int startup(struct mgsl_struct * info)
 		
 	if ( retval ) {
   		if (capable(CAP_SYS_ADMIN) && info->port.tty)
-			set_bit(TTY_IO_ERROR, &info->port.tty->flags);
+			set_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 		mgsl_release_resources(info);
   		return retval;
   	}
@@ -1789,7 +1789,7 @@ static int startup(struct mgsl_struct * info)
 	mgsl_change_params(info);
 
 	if (info->port.tty)
-		clear_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		clear_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 
 	tty_port_set_initialized(&info->port, 1);
 
@@ -1854,7 +1854,7 @@ static void shutdown(struct mgsl_struct * info)
 	mgsl_release_resources(info);
 
 	if (info->port.tty)
-		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 
 	tty_port_set_initialized(&info->port, 0);
 }	/* end of shutdown() */
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 7e56d62039e8..314a8cd897ff 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -2440,7 +2440,7 @@ static int startup(struct slgt_info *info)
 	change_params(info);
 
 	if (info->port.tty)
-		clear_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		clear_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 
 	tty_port_set_initialized(&info->port, 1);
 
@@ -2487,7 +2487,7 @@ static void shutdown(struct slgt_info *info)
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	if (info->port.tty)
-		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 
 	tty_port_set_initialized(&info->port, 0);
 }
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 46ab0c9808f7..1cfa66178487 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -2660,7 +2660,7 @@ static int startup(SLMP_INFO * info)
 	mod_timer(&info->status_timer, jiffies + msecs_to_jiffies(10));
 
 	if (info->port.tty)
-		clear_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		clear_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 
 	tty_port_set_initialized(&info->port, 1);
 
@@ -2703,7 +2703,7 @@ static void shutdown(SLMP_INFO * info)
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	if (info->port.tty)
-		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &info->port.iflags);
 
 	tty_port_set_initialized(&info->port, 0);
 }
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 5ad4bda512e2..5f7a41547901 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -239,7 +239,7 @@ void tty_port_hangup(struct tty_port *port)
 	port->count = 0;
 	tty = port->tty;
 	if (tty)
-		set_bit(TTY_IO_ERROR, &tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	port->tty = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_port_set_active(port, 0);
@@ -531,7 +531,7 @@ void tty_port_close(struct tty_port *port, struct tty_struct *tty,
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
 	tty_port_shutdown(port, tty);
-	set_bit(TTY_IO_ERROR, &tty->flags);
+	set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	tty_port_close_end(port, tty);
 	tty_port_tty_set(port, NULL);
 }
@@ -580,7 +580,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 	mutex_lock(&port->mutex);
 
 	if (!tty_port_initialized(port)) {
-		clear_bit(TTY_IO_ERROR, &tty->flags);
+		clear_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 		if (port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
 			if (retval) {
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 3b0de8ac7ee4..524df94ed437 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -256,6 +256,8 @@ struct tty_port {
 #define TTY_PORT_CTS_FLOW	3	/* h/w flow control enabled */
 #define TTY_PORT_CHECK_CD	4	/* carrier detect enabled */
 
+#define TTY_PORT_IO_ERROR	3	/* device has I/O error */
+
 /*
  * Where all of the state associated with a tty is kept while the tty
  * is open.  Since the termios state should be kept even if the tty
@@ -347,7 +349,6 @@ struct tty_file_private {
  * clear_bit() to make things atomic.
  */
 #define TTY_THROTTLED 		0	/* Call unthrottle() at threshold min */
-#define TTY_IO_ERROR 		1	/* Cause an I/O error (may be no ldisc too) */
 #define TTY_OTHER_CLOSED 	2	/* Other side (if any) has closed */
 #define TTY_EXCLUSIVE 		3	/* Exclusive open mode */
 #define TTY_DO_WRITE_WAKEUP 	5	/* Call write_wakeup after queuing new */
@@ -374,7 +375,7 @@ static inline void tty_set_flow_change(struct tty_struct *tty, int val)
 
 static inline bool tty_io_error(struct tty_struct *tty)
 {
-	return test_bit(TTY_IO_ERROR, &tty->flags);
+	return test_bit(TTY_PORT_IO_ERROR, &tty->port->flags);
 }
 
 static inline bool tty_throttled(struct tty_struct *tty)
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 8e385a0ae60e..dfb177f1d5ae 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -115,7 +115,7 @@ static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
 
 	err = rfcomm_dlc_open(dev->dlc, &dev->src, &dev->dst, dev->channel);
 	if (err)
-		set_bit(TTY_IO_ERROR, &tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &tty->port->iflags);
 	return err;
 }
 
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index c55dd956d309..3ee3b75f6d22 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -927,7 +927,7 @@ static void ircomm_tty_hangup(struct tty_struct *tty)
 
 	spin_lock_irqsave(&port->lock, flags);
 	if (port->tty) {
-		set_bit(TTY_IO_ERROR, &port->tty->flags);
+		set_bit(TTY_PORT_IO_ERROR, &port->iflags);
 		tty_kref_put(port->tty);
 	}
 	port->tty = NULL;
-- 
2.9.3
