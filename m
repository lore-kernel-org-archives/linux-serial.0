From: Rob Herring <robh@kernel.org>
Subject: [PATCH 3/9] tty: move hw_stopped flag to tty_port
Date: Fri,  9 Sep 2016 17:37:04 -0500
Message-ID: <20160909223711.26238-4-robh@kernel.org>
References: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

hw_stopped is a property of the tty port rather than the tty, so move it
to tty_port struct and remove another dependency on tty_struct from
drivers.

Converted with coccinelle:

@@
identifier t;
@@
- t->hw_stopped
+ t->port->hw_stopped

@@
expression port;
@@
- port.tty->hw_stopped
+ port.hw_stopped

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/pcmcia/synclink_cs.c   | 16 ++++++++--------
 drivers/mmc/card/sdio_uart.c        | 14 +++++++-------
 drivers/staging/fwserial/fwserial.c | 20 +++++++++----------
 drivers/tty/amiserial.c             | 38 ++++++++++++++++++-------------------
 drivers/tty/cyclades.c              | 14 +++++++-------
 drivers/tty/isicom.c                | 14 +++++++-------
 drivers/tty/mxser.c                 | 28 +++++++++++++--------------
 drivers/tty/serial/bfin_uart.c      |  6 +++---
 drivers/tty/synclink.c              | 16 ++++++++--------
 drivers/tty/synclink_gt.c           | 14 +++++++-------
 drivers/tty/synclinkmp.c            | 16 ++++++++--------
 include/linux/tty.h                 |  2 +-
 net/irda/ircomm/ircomm_tty.c        | 20 +++++++++----------
 net/irda/ircomm/ircomm_tty_attach.c |  6 +++---
 net/irda/ircomm/ircomm_tty_ioctl.c  |  2 +-
 15 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 8f5528abc390..39a3748ef6c9 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -987,7 +987,7 @@ static void tx_done(MGSLPC_INFO *info, struct tty_struct *tty)
 	else
 #endif
 	{
-		if (tty && (tty->stopped || tty->hw_stopped)) {
+		if (tty && (tty->stopped || tty->port->hw_stopped)) {
 			tx_stop(info);
 			return;
 		}
@@ -1007,7 +1007,7 @@ static void tx_ready(MGSLPC_INFO *info, struct tty_struct *tty)
 		if (!info->tx_active)
 			return;
 	} else {
-		if (tty && (tty->stopped || tty->hw_stopped)) {
+		if (tty && (tty->stopped || tty->port->hw_stopped)) {
 			tx_stop(info);
 			return;
 		}
@@ -1058,11 +1058,11 @@ static void cts_change(MGSLPC_INFO *info, struct tty_struct *tty)
 	wake_up_interruptible(&info->event_wait_q);
 
 	if (tty && tty_port_cts_enabled(&info->port)) {
-		if (tty->hw_stopped) {
+		if (tty->port->hw_stopped) {
 			if (info->serial_signals & SerialSignal_CTS) {
 				if (debug_level >= DEBUG_LEVEL_ISR)
 					printk("CTS tx start...");
-				tty->hw_stopped = 0;
+				tty->port->hw_stopped = 0;
 				tx_start(info, tty);
 				info->pending_bh |= BH_TRANSMIT;
 				return;
@@ -1071,7 +1071,7 @@ static void cts_change(MGSLPC_INFO *info, struct tty_struct *tty)
 			if (!(info->serial_signals & SerialSignal_CTS)) {
 				if (debug_level >= DEBUG_LEVEL_ISR)
 					printk("CTS tx stop...");
-				tty->hw_stopped = 1;
+				tty->port->hw_stopped = 1;
 				tx_stop(info);
 			}
 		}
@@ -1528,7 +1528,7 @@ static void mgslpc_flush_chars(struct tty_struct *tty)
 		return;
 
 	if (info->tx_count <= 0 || tty->stopped ||
-	    tty->hw_stopped || !info->tx_buf)
+	    tty->port->hw_stopped || !info->tx_buf)
 		return;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
@@ -1596,7 +1596,7 @@ static int mgslpc_write(struct tty_struct * tty,
 		ret += c;
 	}
 start:
-	if (info->tx_count && !tty->stopped && !tty->hw_stopped) {
+	if (info->tx_count && !tty->stopped && !tty->port->hw_stopped) {
 		spin_lock_irqsave(&info->lock, flags);
 		if (!info->tx_active)
 			tx_start(info, tty);
@@ -2318,7 +2318,7 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 
 	/* Handle turning off CRTSCTS */
 	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(&tty->termios)) {
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		tx_release(tty);
 	}
 }
diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index 4a6decfcad03..d6d6a2e345ea 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -445,7 +445,7 @@ static void sdio_uart_transmit_chars(struct sdio_uart_port *port)
 	tty = tty_port_tty_get(&port->port);
 
 	if (tty == NULL || !kfifo_len(xmit) ||
-				tty->stopped || tty->hw_stopped) {
+				tty->stopped || tty->port->hw_stopped) {
 		sdio_uart_stop_tx(port);
 		tty_kref_put(tty);
 		return;
@@ -495,15 +495,15 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
 		tty = tty_port_tty_get(&port->port);
 		if (tty && C_CRTSCTS(&tty->termios)) {
 			int cts = (status & UART_MSR_CTS);
-			if (tty->hw_stopped) {
+			if (tty->port->hw_stopped) {
 				if (cts) {
-					tty->hw_stopped = 0;
+					tty->port->hw_stopped = 0;
 					sdio_uart_start_tx(port);
 					tty_wakeup(tty);
 				}
 			} else {
 				if (!cts) {
-					tty->hw_stopped = 1;
+					tty->port->hw_stopped = 1;
 					sdio_uart_stop_tx(port);
 				}
 			}
@@ -653,7 +653,7 @@ static int sdio_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 
 	if (C_CRTSCTS(&tty->termios))
 		if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS))
-			tty->hw_stopped = 1;
+			tty->port->hw_stopped = 1;
 
 	clear_bit(TTY_IO_ERROR, &tty->flags);
 
@@ -902,14 +902,14 @@ static void sdio_uart_set_termios(struct tty_struct *tty,
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		sdio_uart_start_tx(port);
 	}
 
 	/* Handle turning on CRTSCTS */
 	if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
 		if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS)) {
-			tty->hw_stopped = 1;
+			tty->port->hw_stopped = 1;
 			sdio_uart_stop_tx(port);
 		}
 	}
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index e391344d227c..0dfdc9dc9672 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -340,9 +340,9 @@ static void fwtty_update_port_status(struct fwtty_port *port,
 	if (delta & TIOCM_CTS) {
 		tty = tty_port_tty_get(&port->port);
 		if (tty && C_CRTSCTS(&tty->termios)) {
-			if (tty->hw_stopped) {
+			if (tty->port->hw_stopped) {
 				if (status & TIOCM_CTS) {
-					tty->hw_stopped = 0;
+					tty->port->hw_stopped = 0;
 					if (port->loopback)
 						__fwtty_restart_tx(port);
 					else
@@ -350,7 +350,7 @@ static void fwtty_update_port_status(struct fwtty_port *port,
 				}
 			} else {
 				if (~status & TIOCM_CTS)
-					tty->hw_stopped = 1;
+					tty->port->hw_stopped = 1;
 			}
 		}
 		tty_kref_put(tty);
@@ -358,9 +358,9 @@ static void fwtty_update_port_status(struct fwtty_port *port,
 	} else if (delta & OOB_TX_THROTTLE) {
 		tty = tty_port_tty_get(&port->port);
 		if (tty) {
-			if (tty->hw_stopped) {
+			if (tty->port->hw_stopped) {
 				if (~status & OOB_TX_THROTTLE) {
-					tty->hw_stopped = 0;
+					tty->port->hw_stopped = 0;
 					if (port->loopback)
 						__fwtty_restart_tx(port);
 					else
@@ -368,7 +368,7 @@ static void fwtty_update_port_status(struct fwtty_port *port,
 				}
 			} else {
 				if (status & OOB_TX_THROTTLE)
-					tty->hw_stopped = 1;
+					tty->port->hw_stopped = 1;
 			}
 		}
 		tty_kref_put(tty);
@@ -735,7 +735,7 @@ static int fwtty_tx(struct fwtty_port *port, bool drain)
 
 	/* try to write as many dma transactions out as possible */
 	n = -EAGAIN;
-	while (!tty->stopped && !tty->hw_stopped &&
+	while (!tty->stopped && !tty->port->hw_stopped &&
 	       !test_bit(STOP_TX, &port->flags)) {
 		txn = kmem_cache_alloc(fwtty_txn_cache, GFP_ATOMIC);
 		if (!txn) {
@@ -1014,7 +1014,7 @@ static int fwtty_port_activate(struct tty_port *tty_port,
 	}
 
 	if (C_CRTSCTS(&tty->termios) && ~port->mstatus & TIOCM_CTS)
-		tty->hw_stopped = 1;
+		tty->port->hw_stopped = 1;
 
 	__fwtty_write_port_status(port);
 	spin_unlock_bh(&port->lock);
@@ -1316,11 +1316,11 @@ static void fwtty_set_termios(struct tty_struct *tty, struct ktermios *old)
 
 	if (old->c_cflag & CRTSCTS) {
 		if (!C_CRTSCTS(&tty->termios)) {
-			tty->hw_stopped = 0;
+			tty->port->hw_stopped = 0;
 			fwtty_restart_tx(port);
 		}
 	} else if (C_CRTSCTS(&tty->termios) && ~port->mstatus & TIOCM_CTS) {
-		tty->hw_stopped = 1;
+		tty->port->hw_stopped = 1;
 	}
 }
 
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 16483a6cc347..be6d59b910f8 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -16,7 +16,7 @@
  * Richard Lucock 28/12/99
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
- *  Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 
+ *  Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997,
  * 		1998, 1999  Theodore Ts'o
  *
  */
@@ -237,7 +237,7 @@ static void rs_start(struct tty_struct *tty)
  * rs_interrupt() should try to keep the interrupt handler as fast as
  * possible.  After you are done making modifications, it is not a bad
  * idea to do:
- * 
+ *
  * gcc -S -DKERNEL -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer serial.c
  *
  * and look at the resulting assemble code in serial.s.
@@ -347,7 +347,7 @@ static void transmit_chars(struct serial_state *info)
 	}
 	if (info->xmit.head == info->xmit.tail
 	    || info->tport.tty->stopped
-	    || info->tport.tty->hw_stopped) {
+	    || info->tport.hw_stopped) {
 		info->IER &= ~UART_IER_THRI;
 	        custom.intena = IF_TBE;
 		mb();
@@ -414,12 +414,12 @@ static void check_modem_status(struct serial_state *info)
 		}
 	}
 	if (tty_port_cts_enabled(port)) {
-		if (port->tty->hw_stopped) {
+		if (port->hw_stopped) {
 			if (!(status & SER_CTS)) {
 #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
 				printk("CTS tx start...");
 #endif
-				port->tty->hw_stopped = 0;
+				port->hw_stopped = 0;
 				info->IER |= UART_IER_THRI;
 				custom.intena = IF_SETCLR | IF_TBE;
 				mb();
@@ -434,7 +434,7 @@ static void check_modem_status(struct serial_state *info)
 #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
 				printk("CTS tx stop...");
 #endif
-				port->tty->hw_stopped = 1;
+				port->hw_stopped = 1;
 				info->IER &= ~UART_IER_THRI;
 				/* disable Tx interrupt and remove any pending interrupts */
 				custom.intena = IF_TBE;
@@ -756,7 +756,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 	if (I_IGNBRK(&tty->termios)) {
 		info->ignore_status_mask |= UART_LSR_BI;
 		/*
-		 * If we're ignore parity and break indicators, ignore 
+		 * If we're ignore parity and break indicators, ignore
 		 * overruns too.  (For real raw support).
 		 */
 		if (I_IGNPAR(&tty->termios))
@@ -824,7 +824,7 @@ static void rs_flush_chars(struct tty_struct *tty)
 
 	if (info->xmit.head == info->xmit.tail
 	    || tty->stopped
-	    || tty->hw_stopped
+	    || tty->port->hw_stopped
 	    || !info->xmit.buf)
 		return;
 
@@ -871,7 +871,7 @@ static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count
 
 	if (info->xmit.head != info->xmit.tail
 	    && !tty->stopped
-	    && !tty->hw_stopped
+	    && !tty->port->hw_stopped
 	    && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
 		local_irq_disable();
@@ -950,7 +950,7 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
 /*
  * ------------------------------------------------------------
  * rs_throttle()
- * 
+ *
  * This routine is called by the upper-layer tty layer to signal that
  * incoming characters should be throttled.
  * ------------------------------------------------------------
@@ -1011,7 +1011,7 @@ static int get_serial_info(struct tty_struct *tty, struct serial_state *state,
 			   struct serial_struct __user * retinfo)
 {
 	struct serial_struct tmp;
-   
+
 	if (!retinfo)
 		return -EFAULT;
 	memset(&tmp, 0, sizeof(tmp));
@@ -1049,7 +1049,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 		tty_unlock(tty);
 		return -EINVAL;
 	}
-  
+
 	if (!serial_isroot()) {
 		if ((new_serial.baud_base != state->baud_base) ||
 		    (new_serial.close_delay != port->close_delay) ||
@@ -1111,7 +1111,7 @@ check_and_exit:
  * 	    release the bus after transmitting. This must be done when
  * 	    the transmit shift register is empty, not be done when the
  * 	    transmit holding register is empty.  This functionality
- * 	    allows an RS485 driver to be written in user space. 
+ * 	    allows an RS485 driver to be written in user space.
  */
 static int get_lsr_info(struct serial_state *info, unsigned int __user *value)
 {
@@ -1283,7 +1283,7 @@ static int rs_ioctl(struct tty_struct *tty,
 				local_irq_save(flags);
 				cnow = info->icount; /* atomic copy */
 				local_irq_restore(flags);
-				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr && 
+				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr &&
 				    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
 					ret = -EIO; /* no change => error */
 					break;
@@ -1346,7 +1346,7 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		rs_start(tty);
 	}
 
@@ -1365,7 +1365,7 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 /*
  * ------------------------------------------------------------
  * rs_close()
- * 
+ *
  * This routine is called when the serial port gets closed.  First, we
  * wait for the last remaining data to be sent.  Then, we unlink its
  * async structure from the interrupt chain if necessary, and we free
@@ -1407,7 +1407,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	}
 	shutdown(tty, state);
 	rs_flush_buffer(tty);
-		
+
 	tty_ldisc_flush(tty);
 	port->tty = NULL;
 
@@ -1435,7 +1435,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	 * Set the check interval to be 1/5 of the estimated time to
 	 * send a single character, and make it at least 1.  The check
 	 * interval should also be less than the timeout.
-	 * 
+	 *
 	 * Note: we have to use pretty tight timings here to satisfy
 	 * the NIST-PCTS.
 	 */
@@ -1699,7 +1699,7 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	state = rs_table;
 	state->port = (int)&custom.serdatr; /* Just to give it a value */
 	state->custom_divisor = 0;
-	state->icount.cts = state->icount.dsr = 
+	state->icount.cts = state->icount.dsr =
 	  state->icount.rng = state->icount.dcd = 0;
 	state->icount.rx = state->icount.tx = 0;
 	state->icount.frame = state->icount.parity = 0;
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 2d165282f483..07f92c04cd6d 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -633,7 +633,7 @@ static void cyy_chip_tx(struct cyclades_card *cinfo, unsigned int chip,
 				cyy_readb(info, CySRER) & ~CyTxRdy);
 			goto done;
 		}
-		if (tty->stopped || tty->hw_stopped) {
+		if (tty->stopped || tty->port->hw_stopped) {
 			cyy_writeb(info, CySRER,
 				cyy_readb(info, CySRER) & ~CyTxRdy);
 			goto done;
@@ -719,11 +719,11 @@ static void cyy_chip_modem(struct cyclades_card *cinfo, int chip,
 			tty_hangup(tty);
 	}
 	if ((mdm_change & CyCTS) && tty_port_cts_enabled(&info->port)) {
-		if (tty->hw_stopped) {
+		if (tty->port->hw_stopped) {
 			if (mdm_status & CyCTS) {
 				/* cy_start isn't used
 				   because... !!! */
-				tty->hw_stopped = 0;
+				tty->port->hw_stopped = 0;
 				cyy_writeb(info, CySRER,
 					cyy_readb(info, CySRER) | CyTxRdy);
 				tty_wakeup(tty);
@@ -732,7 +732,7 @@ static void cyy_chip_modem(struct cyclades_card *cinfo, int chip,
 			if (!(mdm_status & CyCTS)) {
 				/* cy_stop isn't used
 				   because ... !!! */
-				tty->hw_stopped = 1;
+				tty->port->hw_stopped = 1;
 				cyy_writeb(info, CySRER,
 					cyy_readb(info, CySRER) & ~CyTxRdy);
 			}
@@ -1800,7 +1800,7 @@ static int cy_write(struct tty_struct *tty, const unsigned char *buf, int count)
 	info->idle_stats.xmit_bytes += ret;
 	info->idle_stats.xmit_idle = jiffies;
 
-	if (info->xmit_cnt && !tty->stopped && !tty->hw_stopped)
+	if (info->xmit_cnt && !tty->stopped && !tty->port->hw_stopped)
 		start_xmit(info);
 
 	return ret;
@@ -1858,7 +1858,7 @@ static void cy_flush_chars(struct tty_struct *tty)
 	if (serial_paranoia_check(info, tty->name, "cy_flush_chars"))
 		return;
 
-	if (info->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped ||
+	if (info->xmit_cnt <= 0 || tty->stopped || tty->port->hw_stopped ||
 			!info->port.xmit_buf)
 		return;
 
@@ -2785,7 +2785,7 @@ static void cy_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 	cy_set_line_char(info, tty);
 
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		cy_start(tty);
 	}
 #if 0
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 2478aa559834..240c766b4a04 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -443,7 +443,7 @@ static void isicom_tx(unsigned long _data)
 			continue;
 
 		txcount = min_t(short, TX_SIZE, port->xmit_cnt);
-		if (txcount <= 0 || tty->stopped || tty->hw_stopped)
+		if (txcount <= 0 || tty->stopped || tty->port->hw_stopped)
 			continue;
 
 		if (!(inw(base + 0x02) & (1 << port->channel)))
@@ -601,16 +601,16 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 			}
 
 			if (tty_port_cts_enabled(&port->port)) {
-				if (tty->hw_stopped) {
+				if (tty->port->hw_stopped) {
 					if (header & ISI_CTS) {
-						tty->hw_stopped = 0;
+						tty->port->hw_stopped = 0;
 						/* start tx ing */
 						port->status |= (ISI_TXOK
 							| ISI_CTS);
 						tty_wakeup(tty);
 					}
 				} else if (!(header & ISI_CTS)) {
-					tty->hw_stopped = 1;
+					tty->port->hw_stopped = 1;
 					/* stop tx ing */
 					port->status &= ~(ISI_TXOK | ISI_CTS);
 				}
@@ -966,7 +966,7 @@ static int isicom_write(struct tty_struct *tty,	const unsigned char *buf,
 		count -= cnt;
 		total += cnt;
 	}
-	if (port->xmit_cnt && !tty->stopped && !tty->hw_stopped)
+	if (port->xmit_cnt && !tty->stopped && !tty->port->hw_stopped)
 		port->status |= ISI_TXOK;
 	spin_unlock_irqrestore(&card->card_lock, flags);
 	return total;
@@ -1003,7 +1003,7 @@ static void isicom_flush_chars(struct tty_struct *tty)
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_chars"))
 		return;
 
-	if (port->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped ||
+	if (port->xmit_cnt <= 0 || tty->stopped || tty->port->hw_stopped ||
 			!port->port.xmit_buf)
 		return;
 
@@ -1201,7 +1201,7 @@ static void isicom_set_termios(struct tty_struct *tty,
 	spin_unlock_irqrestore(&port->card->card_lock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		isicom_start(tty);
 	}
 }
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 1a5fb2887b0e..72ae8a990a79 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -718,9 +718,9 @@ static int mxser_change_speed(struct tty_struct *tty,
 			info->MCR |= UART_MCR_AFE;
 		} else {
 			status = inb(info->ioaddr + UART_MSR);
-			if (tty->hw_stopped) {
+			if (tty->port->hw_stopped) {
 				if (status & UART_MSR_CTS) {
-					tty->hw_stopped = 0;
+					tty->port->hw_stopped = 0;
 					if (info->type != PORT_16550A &&
 							!info->board->chip_flag) {
 						outb(info->IER & ~UART_IER_THRI,
@@ -734,7 +734,7 @@ static int mxser_change_speed(struct tty_struct *tty,
 				}
 			} else {
 				if (!(status & UART_MSR_CTS)) {
-					tty->hw_stopped = 1;
+					tty->port->hw_stopped = 1;
 					if ((info->type != PORT_16550A) &&
 							(!info->board->chip_flag)) {
 						info->IER &= ~UART_IER_THRI;
@@ -829,9 +829,9 @@ static void mxser_check_modem_status(struct tty_struct *tty,
 	}
 
 	if (tty_port_cts_enabled(&port->port)) {
-		if (tty->hw_stopped) {
+		if (tty->port->hw_stopped) {
 			if (status & UART_MSR_CTS) {
-				tty->hw_stopped = 0;
+				tty->port->hw_stopped = 0;
 
 				if ((port->type != PORT_16550A) &&
 						(!port->board->chip_flag)) {
@@ -845,7 +845,7 @@ static void mxser_check_modem_status(struct tty_struct *tty,
 			}
 		} else {
 			if (!(status & UART_MSR_CTS)) {
-				tty->hw_stopped = 1;
+				tty->port->hw_stopped = 1;
 				if (port->type != PORT_16550A &&
 						!port->board->chip_flag) {
 					port->IER &= ~UART_IER_THRI;
@@ -1123,7 +1123,7 @@ static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int cou
 	}
 
 	if (info->xmit_cnt && !tty->stopped) {
-		if (!tty->hw_stopped ||
+		if (!tty->port->hw_stopped ||
 				(info->type == PORT_16550A) ||
 				(info->board->chip_flag)) {
 			spin_lock_irqsave(&info->slock, flags);
@@ -1154,7 +1154,7 @@ static int mxser_put_char(struct tty_struct *tty, unsigned char ch)
 	info->xmit_cnt++;
 	spin_unlock_irqrestore(&info->slock, flags);
 	if (!tty->stopped) {
-		if (!tty->hw_stopped ||
+		if (!tty->port->hw_stopped ||
 				(info->type == PORT_16550A) ||
 				info->board->chip_flag) {
 			spin_lock_irqsave(&info->slock, flags);
@@ -1174,7 +1174,7 @@ static void mxser_flush_chars(struct tty_struct *tty)
 	unsigned long flags;
 
 	if (info->xmit_cnt <= 0 || tty->stopped || !info->port.xmit_buf ||
-			(tty->hw_stopped && info->type != PORT_16550A &&
+			(tty->port->hw_stopped && info->type != PORT_16550A &&
 			 !info->board->chip_flag))
 		return;
 
@@ -1778,7 +1778,7 @@ static int mxser_ioctl(struct tty_struct *tty,
 		else
 			info->mon_data.hold_reason |= NPPI_NOTIFY_XOFFXENT;
 
-		if (tty->hw_stopped)
+		if (tty->port->hw_stopped)
 			info->mon_data.hold_reason |= NPPI_NOTIFY_CTSHOLD;
 		else
 			info->mon_data.hold_reason &= ~NPPI_NOTIFY_CTSHOLD;
@@ -1946,7 +1946,7 @@ static void mxser_set_termios(struct tty_struct *tty, struct ktermios *old_termi
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		mxser_start(tty);
 	}
 
@@ -2172,9 +2172,9 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 		return;
 
 	if (port->xmit_cnt <= 0 || tty->stopped ||
-			(tty->hw_stopped &&
-			(port->type != PORT_16550A) &&
-			(!port->board->chip_flag))) {
+			(tty->port->hw_stopped &&
+			 (port->type != PORT_16550A) &&
+			 (!port->board->chip_flag))) {
 		port->IER &= ~UART_IER_THRI;
 		outb(port->IER, port->ioaddr + UART_IER);
 		return;
diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 293ecbb00684..fc24c9ec1935 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -113,14 +113,14 @@ static irqreturn_t bfin_serial_mctrl_cts_int(int irq, void *dev_id)
 #ifdef SERIAL_BFIN_HARD_CTSRTS
 
 	UART_CLEAR_SCTS(uart);
-	if (uport->hw_stopped) {
+	if (uport->port->hw_stopped) {
 		if (status) {
-			uport->hw_stopped = 0;
+			uport->port->hw_stopped = 0;
 			uart_write_wakeup(uport);
 		}
 	} else {
 		if (!status)
-			uport->hw_stopped = 1;
+			uport->port->hw_stopped = 1;
 	}
 #else
 	uart_handle_cts_change(uport, status & TIOCM_CTS);
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 712776cf7ab7..57f678c6484e 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -1259,7 +1259,7 @@ static void mgsl_isr_transmit_status( struct mgsl_struct *info )
 	else 
 #endif
 	{
-		if (info->port.tty->stopped || info->port.tty->hw_stopped) {
+		if (info->port.tty->stopped || info->port.hw_stopped) {
 			usc_stop_transmitter(info);
 			return;
 		}
@@ -1357,11 +1357,11 @@ static void mgsl_isr_io_pin( struct mgsl_struct *info )
 	
 		if (tty_port_cts_enabled(&info->port) &&
 		     (status & MISCSTATUS_CTS_LATCHED) ) {
-			if (info->port.tty->hw_stopped) {
+			if (info->port.hw_stopped) {
 				if (status & MISCSTATUS_CTS) {
 					if ( debug_level >= DEBUG_LEVEL_ISR )
 						printk("CTS tx start...");
-					info->port.tty->hw_stopped = 0;
+					info->port.hw_stopped = 0;
 					usc_start_transmitter(info);
 					info->pending_bh |= BH_TRANSMIT;
 					return;
@@ -1371,7 +1371,7 @@ static void mgsl_isr_io_pin( struct mgsl_struct *info )
 					if ( debug_level >= DEBUG_LEVEL_ISR )
 						printk("CTS tx stop...");
 					if (info->port.tty)
-						info->port.tty->hw_stopped = 1;
+						info->port.hw_stopped = 1;
 					usc_stop_transmitter(info);
 				}
 			}
@@ -1405,7 +1405,7 @@ static void mgsl_isr_transmit_data( struct mgsl_struct *info )
 			
 	usc_ClearIrqPendingBits( info, TRANSMIT_DATA );
 	
-	if (info->port.tty->stopped || info->port.tty->hw_stopped) {
+	if (info->port.tty->stopped || info->port.hw_stopped) {
 		usc_stop_transmitter(info);
 		return;
 	}
@@ -2050,7 +2050,7 @@ static void mgsl_flush_chars(struct tty_struct *tty)
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_flush_chars"))
 		return;
 
-	if (info->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped ||
+	if (info->xmit_cnt <= 0 || tty->stopped || tty->port->hw_stopped ||
 	    !info->xmit_buf)
 		return;
 
@@ -2190,7 +2190,7 @@ static int mgsl_write(struct tty_struct * tty,
 		}
 	}	
 	
- 	if (info->xmit_cnt && !tty->stopped && !tty->hw_stopped) {
+ 	if (info->xmit_cnt && !tty->stopped && !tty->port->hw_stopped) {
 		spin_lock_irqsave(&info->irq_spinlock,flags);
 		if (!info->tx_active)
 		 	usc_start_transmitter(info);
@@ -3048,7 +3048,7 @@ static void mgsl_set_termios(struct tty_struct *tty, struct ktermios *old_termio
 
 	/* Handle turning off CRTSCTS */
 	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(&tty->termios)) {
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		mgsl_start(tty);
 	}
 
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 055fa71bc2fb..7e56d62039e8 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -793,7 +793,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios)) {
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		tx_release(tty);
 	}
 }
@@ -825,7 +825,7 @@ static int write(struct tty_struct *tty,
 	if (!info->tx_buf || (count > info->max_frame_size))
 		return -EIO;
 
-	if (!count || tty->stopped || tty->hw_stopped)
+	if (!count || tty->stopped || tty->port->hw_stopped)
 		return 0;
 
 	spin_lock_irqsave(&info->lock, flags);
@@ -947,7 +947,7 @@ static void flush_chars(struct tty_struct *tty)
 	DBGINFO(("%s flush_chars entry tx_count=%d\n", info->device_name, info->tx_count));
 
 	if (info->tx_count <= 0 || tty->stopped ||
-	    tty->hw_stopped || !info->tx_buf)
+	    tty->port->hw_stopped || !info->tx_buf)
 		return;
 
 	DBGINFO(("%s flush_chars start transmit\n", info->device_name));
@@ -2039,15 +2039,15 @@ static void cts_change(struct slgt_info *info, unsigned short status)
 
 	if (tty_port_cts_enabled(&info->port)) {
 		if (info->port.tty) {
-			if (info->port.tty->hw_stopped) {
+			if (info->port.hw_stopped) {
 				if (info->signals & SerialSignal_CTS) {
-		 			info->port.tty->hw_stopped = 0;
+		 			info->port.hw_stopped = 0;
 					info->pending_bh |= BH_TRANSMIT;
 					return;
 				}
 			} else {
 				if (!(info->signals & SerialSignal_CTS))
-		 			info->port.tty->hw_stopped = 1;
+		 			info->port.hw_stopped = 1;
 			}
 		}
 	}
@@ -2323,7 +2323,7 @@ static void isr_txeom(struct slgt_info *info, unsigned short status)
 		else
 #endif
 		{
-			if (info->port.tty && (info->port.tty->stopped || info->port.tty->hw_stopped)) {
+			if (info->port.tty && (info->port.tty->stopped || info->port.hw_stopped)) {
 				tx_stop(info);
 				return;
 			}
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index ffefc5e6d66c..46ab0c9808f7 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -890,7 +890,7 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 
 	/* Handle turning off CRTSCTS */
 	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(&tty->termios)) {
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		tx_release(tty);
 	}
 }
@@ -969,7 +969,7 @@ static int write(struct tty_struct *tty,
 		tx_load_dma_buffer(info, info->tx_buf, info->tx_count);
 	}
 start:
- 	if (info->tx_count && !tty->stopped && !tty->hw_stopped) {
+ 	if (info->tx_count && !tty->stopped && !tty->port->hw_stopped) {
 		spin_lock_irqsave(&info->lock,flags);
 		if (!info->tx_active)
 		 	tx_start(info);
@@ -1149,7 +1149,7 @@ static void flush_chars(struct tty_struct *tty)
 	if (sanity_check(info, tty->name, "flush_chars"))
 		return;
 
-	if (info->tx_count <= 0 || tty->stopped || tty->hw_stopped ||
+	if (info->tx_count <= 0 || tty->stopped || tty->port->hw_stopped ||
 	    !info->tx_buf)
 		return;
 
@@ -2261,7 +2261,7 @@ static void isr_txeom(SLMP_INFO * info, unsigned char status)
 		else
 #endif
 		{
-			if (info->port.tty && (info->port.tty->stopped || info->port.tty->hw_stopped)) {
+			if (info->port.tty && (info->port.tty->stopped || info->port.hw_stopped)) {
 				tx_stop(info);
 				return;
 			}
@@ -2316,7 +2316,7 @@ static void isr_txrdy(SLMP_INFO * info)
 		return;
 	}
 
-	if (info->port.tty && (info->port.tty->stopped || info->port.tty->hw_stopped)) {
+	if (info->port.tty && (info->port.tty->stopped || info->port.hw_stopped)) {
 		tx_stop(info);
 		return;
 	}
@@ -2481,11 +2481,11 @@ static void isr_io_pin( SLMP_INFO *info, u16 status )
 		if (tty_port_cts_enabled(&info->port) &&
 		     (status & MISCSTATUS_CTS_LATCHED) ) {
 			if ( info->port.tty ) {
-				if (info->port.tty->hw_stopped) {
+				if (info->port.hw_stopped) {
 					if (status & SerialSignal_CTS) {
 						if ( debug_level >= DEBUG_LEVEL_ISR )
 							printk("CTS tx start...");
-			 			info->port.tty->hw_stopped = 0;
+			 			info->port.hw_stopped = 0;
 						tx_start(info);
 						info->pending_bh |= BH_TRANSMIT;
 						return;
@@ -2494,7 +2494,7 @@ static void isr_io_pin( SLMP_INFO *info, u16 status )
 					if (!(status & SerialSignal_CTS)) {
 						if ( debug_level >= DEBUG_LEVEL_ISR )
 							printk("CTS tx stop...");
-			 			info->port.tty->hw_stopped = 1;
+			 			info->port.hw_stopped = 1;
 						tx_stop(info);
 					}
 				}
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 73a8c38987f5..3b0de8ac7ee4 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -228,6 +228,7 @@ struct tty_port {
 	int			count;		/* Usage count */
 	wait_queue_head_t	open_wait;	/* Open waiters */
 	wait_queue_head_t	delta_msr_wait;	/* Modem status change */
+	int hw_stopped;
 	unsigned long		flags;		/* User TTY flags ASYNC_ */
 	unsigned long		iflags;		/* Internal flags TTY_PORT_ */
 	unsigned char		console:1,	/* port is a console */
@@ -300,7 +301,6 @@ struct tty_struct {
 	unsigned long stopped:1,	/* flow_lock */
 		      flow_stopped:1,
 		      unused:BITS_PER_LONG - 2;
-	int hw_stopped;
 	unsigned long ctrl_status:8,	/* ctrl_lock */
 		      packet:1,
 		      unused_ctrl:BITS_PER_LONG - 9;
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index ccfff1c1d278..c55dd956d309 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -552,7 +552,7 @@ static void ircomm_tty_do_softint(struct work_struct *work)
 		dev_kfree_skb(ctrl_skb);
 	}
 
-	if (tty->hw_stopped)
+	if (tty->port->hw_stopped)
 		goto put;
 
 	/* Unlink transmit buffer */
@@ -595,7 +595,7 @@ static int ircomm_tty_write(struct tty_struct *tty,
 	int size;
 
 	pr_debug("%s(), count=%d, hw_stopped=%d\n", __func__ , count,
-		 tty->hw_stopped);
+		 tty->port->hw_stopped);
 
 	IRDA_ASSERT(self != NULL, return -1;);
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
@@ -736,7 +736,7 @@ static int ircomm_tty_write_room(struct tty_struct *tty)
 	/* Check if we are allowed to transmit any data.
 	 * hw_stopped is the regular flow control.
 	 * Jean II */
-	if (tty->hw_stopped)
+	if (tty->port->hw_stopped)
 		ret = 0;
 	else {
 		spin_lock_irqsave(&self->spinlock, flags);
@@ -1016,10 +1016,10 @@ void ircomm_tty_check_modem_status(struct ircomm_tty_cb *self)
 		}
 	}
 	if (tty && tty_port_cts_enabled(&self->port)) {
-		if (tty->hw_stopped) {
+		if (tty->port->hw_stopped) {
 			if (status & IRCOMM_CTS) {
 				pr_debug("%s(), CTS tx start...\n", __func__);
-				tty->hw_stopped = 0;
+				tty->port->hw_stopped = 0;
 
 				/* Wake up processes blocked on open */
 				wake_up_interruptible(&self->port.open_wait);
@@ -1030,7 +1030,7 @@ void ircomm_tty_check_modem_status(struct ircomm_tty_cb *self)
 		} else {
 			if (!(status & IRCOMM_CTS)) {
 				pr_debug("%s(), CTS tx stop...\n", __func__);
-				tty->hw_stopped = 1;
+				tty->port->hw_stopped = 1;
 			}
 		}
 	}
@@ -1066,7 +1066,7 @@ static int ircomm_tty_data_indication(void *instance, void *sap,
 	 * Devices like WinCE can do this, and since they don't send any
 	 * params, we can just as well declare the hardware for running.
 	 */
-	if (tty->hw_stopped && (self->flow == FLOW_START)) {
+	if (tty->port->hw_stopped && (self->flow == FLOW_START)) {
 		pr_debug("%s(), polling for line settings!\n", __func__);
 		ircomm_param_request(self, IRCOMM_POLL, TRUE);
 
@@ -1136,7 +1136,7 @@ static void ircomm_tty_flow_indication(void *instance, void *sap,
 	case FLOW_START:
 		pr_debug("%s(), hw start!\n", __func__);
 		if (tty)
-			tty->hw_stopped = 0;
+			tty->port->hw_stopped = 0;
 
 		/* ircomm_tty_do_softint will take care of the rest */
 		schedule_work(&self->tqueue);
@@ -1145,7 +1145,7 @@ static void ircomm_tty_flow_indication(void *instance, void *sap,
 	case FLOW_STOP:
 		pr_debug("%s(), hw stopped!\n", __func__);
 		if (tty)
-			tty->hw_stopped = 1;
+			tty->port->hw_stopped = 1;
 		break;
 	}
 
@@ -1282,7 +1282,7 @@ static void ircomm_tty_line_info(struct ircomm_tty_cb *self, struct seq_file *m)
 	tty = tty_port_tty_get(&self->port);
 	if (tty) {
 		seq_printf(m, "Hardware: %s\n",
-			       tty->hw_stopped ? "Stopped" : "Running");
+			       tty->port->hw_stopped ? "Stopped" : "Running");
 		tty_kref_put(tty);
 	}
 }
diff --git a/net/irda/ircomm/ircomm_tty_attach.c b/net/irda/ircomm/ircomm_tty_attach.c
index 0a411019c098..36a3ec31bb71 100644
--- a/net/irda/ircomm/ircomm_tty_attach.c
+++ b/net/irda/ircomm/ircomm_tty_attach.c
@@ -140,7 +140,7 @@ int ircomm_tty_attach_cable(struct ircomm_tty_cb *self)
 	/* Make sure nobody tries to write before the link is up */
 	tty = tty_port_tty_get(&self->port);
 	if (tty) {
-		tty->hw_stopped = 1;
+		tty->port->hw_stopped = 1;
 		tty_kref_put(tty);
 	}
 
@@ -405,7 +405,7 @@ void ircomm_tty_disconnect_indication(void *instance, void *sap,
 	self->flow = FLOW_STOP;
 
 	/* Stop data transfers */
-	tty->hw_stopped = 1;
+	tty->port->hw_stopped = 1;
 
 	ircomm_tty_do_event(self, IRCOMM_TTY_DISCONNECT_INDICATION, NULL,
 			    NULL);
@@ -563,7 +563,7 @@ void ircomm_tty_link_established(struct ircomm_tty_cb *self)
 	} else {
 		pr_debug("%s(), starting hardware!\n", __func__);
 
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 
 		/* Wake up processes blocked on open */
 		wake_up_interruptible(&self->port.open_wait);
diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index 78349fc346f3..25e143c95caa 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -170,7 +170,7 @@ void ircomm_tty_set_termios(struct tty_struct *tty,
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(&tty->termios))
 	{
-		tty->hw_stopped = 0;
+		tty->port->hw_stopped = 0;
 		ircomm_tty_start(tty);
 	}
 }
-- 
2.9.3
