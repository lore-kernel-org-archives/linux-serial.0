From: Axel Hosemann <axel.hosemann@freesurf.ch>
Subject: Suggested patch for linux
Date: Thu, 10 Jul 2008 01:16:37 +0200
Message-ID: <487546D5.8050908@freesurf.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050804000409090501030307"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-proxy-be-01.sunrise.ch ([194.158.229.48]:32649 "EHLO
	gw-out-be-02.be08.sunrise.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756721AbYGJEzR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Jul 2008 00:55:17 -0400
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by gw-out-be-02.be08.sunrise.ch (8.13.1/8.13.5) with ESMTP id m69NGqqF002310
	for <linux-serial@vger.kernel.org>; Thu, 10 Jul 2008 01:16:52 +0200
Received: by fk-out-0910.google.com with SMTP id f40so2026271fka.1
        for <linux-serial@vger.kernel.org>; Wed, 09 Jul 2008 16:16:45 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-usb@vger.kernel.org

This is a multi-part message in MIME format.
--------------050804000409090501030307
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sirs,
the support of the serial interface by linux systems nowadays suffers 
from the disadvantage, that hardware handshake is only supported for the 
full duplex mode. That means, that the RTS signal is getting always 
asserted immediately after the serial was opened. So the RTS signal 
under linux, as far as I understood it, carries exactly the same 
information as the DTR line. That means, that there is no half-duplex 
behaviour provided by linux.  A half-duplex  application as e.g. RS-485 
controllers or radio modems  are depending on a different behaviour: The 
serial port asserts DTR after it was opened, but RTS must only be 
asserted, when data has been written to the tx buffer for transmission. 
Stimulated by  the RTS signal, the DCE will then engage the channel for 
transmission and release it, after the RTS has been deasserted when the 
buffer had been sent. This behaviour is up to now not supported by the 
linux serial drivers.
Therefore I make a suggestion for adding the half-duplex support for 
linux kernels by the attached patch, which I  created and tested on a 
UART 16550 compliant  hardware and additionally by means of a ftdi usb 
to serial port adaptor.  The patch was compiled and tested with an 
UBUNTU 2.6.24-19-generic environment.
If you see a chance, to add this functionality for future linux kernels, 
I would be interested in further discussions about this patch.

Regards

Axel Hosemann
Bergstrasse 6f
CH 5644 Auw

--------------050804000409090501030307
Content-Type: text/x-patch;
 name="serialHalfDuplex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serialHalfDuplex.patch"

diff -urN linux-2.6.24/drivers/serial/serial_core.c linux-2.6.24-new/drivers/serial/serial_core.c
--- linux-2.6.24/drivers/serial/serial_core.c	2008-02-11 06:51:11.000000000 +0100
+++ linux-2.6.24-new/drivers/serial/serial_core.c	2008-07-07 22:36:16.000000000 +0200
@@ -75,6 +75,9 @@
 	 */
 	BUG_ON(!info);
 	tasklet_schedule(&info->tlet);
+#ifdef RTSHDX
+	wake_up_interruptible(&port->rts_wait);
+#endif
 }
 
 static void uart_stop(struct tty_struct *tty)
@@ -181,8 +184,15 @@
 			 * Setup the RTS and DTR signals once the
 			 * port is open and ready to respond.
 			 */
-			if (info->tty->termios->c_cflag & CBAUD)
+			if (info->tty->termios->c_cflag & CBAUD){
+#ifdef RTSHDX
+				port->toggleRTS = false;
+				uart_set_mctrl(port, TIOCM_DTR);
+				uart_clear_mctrl(port, TIOCM_RTS);
+#else
 				uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
+#endif
+			}
 		}
 
 		if (info->flags & UIF_CTS_FLOW) {
@@ -473,6 +483,47 @@
 	uart_start(tty);
 }
 
+#ifdef RTSHDX
+static void uart_wait_infinite_until_sent(struct tty_struct *tty)
+{
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->port;
+	unsigned long char_time;
+
+	BUG_ON(!kernel_locked());
+
+	char_time = (port->timeout - HZ/50) / port->fifosize;
+	char_time = char_time / 5;
+	if (char_time == 0)
+		char_time = 1;
+	
+	if (port->type == PORT_UNKNOWN || port->fifosize == 0)
+		return;
+
+	/*
+	 * Check whether the transmitter is empty every 'char_time'.
+	 */
+	while (!port->ops->tx_empty(port)) {
+		msleep_interruptible(jiffies_to_msecs(char_time));
+	}
+	//wait again until shift register is empty
+	msleep_interruptible(jiffies_to_msecs(char_time));
+	set_current_state(TASK_RUNNING); /* might not be needed */
+}
+
+static void simplified_sleep_on(wait_queue_head_t *queue)
+{
+	wait_queue_t wait;
+
+	init_waitqueue_entry(&wait, current);
+	current->state = TASK_INTERRUPTIBLE;
+
+	add_wait_queue(queue, &wait);
+	schedule();
+	remove_wait_queue (queue, &wait);
+}
+#endif
+
 static int
 uart_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
@@ -497,6 +548,9 @@
 	if (!circ->buf)
 		return 0;
 
+#ifdef RTSHDX
+	uart_set_mctrl(port, TIOCM_RTS);
+#endif
 	spin_lock_irqsave(&port->lock, flags);
 	while (1) {
 		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
@@ -513,6 +567,16 @@
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	uart_start(tty);
+#ifdef RTSHDX
+	if(port->toggleRTS){
+		//first wait until the device indicates transmission started
+		simplified_sleep_on(&port->rts_wait);
+		//second wait until the device indicates transmission done
+		uart_wait_infinite_until_sent(tty);
+		//now we are ready to deassert RTS
+		uart_clear_mctrl(port, TIOCM_RTS);
+	}
+#endif	
 	return ret;
 }
 
@@ -1143,6 +1207,15 @@
 	unsigned int cflag = tty->termios->c_cflag;
 
 	BUG_ON(!kernel_locked());
+#ifdef RTSHDX
+	state->port->toggleRTS = tty->termios->c_lflag & RTSHDX ? true : false;
+	if(state->port->toggleRTS){
+		uart_clear_mctrl(state->port, TIOCM_RTS);
+	}
+	else {
+		uart_set_mctrl(state->port, TIOCM_RTS);
+	}
+#endif	
 
 	/*
 	 * These are the bits that are used to setup various
@@ -1167,8 +1240,14 @@
 	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		unsigned int mask = TIOCM_DTR;
 		if (!(cflag & CRTSCTS) ||
-		    !test_bit(TTY_THROTTLED, &tty->flags))
+		    !test_bit(TTY_THROTTLED, &tty->flags)){
+#ifdef RTSHDX
+			if(!state->port->toggleRTS)
+				mask |= TIOCM_RTS;
+#else	
 			mask |= TIOCM_RTS;
+#endif	
+		}
 		uart_set_mctrl(state->port, mask);
 	}
 
@@ -1413,8 +1492,15 @@
 		/*
 		 * And finally enable the RTS and DTR signals.
 		 */
-		if (tty->termios->c_cflag & CBAUD)
+		if (tty->termios->c_cflag & CBAUD){
+#ifdef RTSHDX
+			//uart_update_mctrl(port,TIOCM_DTR,TIOCM_RTS);
+			uart_clear_mctrl(port, TIOCM_RTS);
+			uart_set_mctrl(port, TIOCM_DTR);
+#else
 			uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+#endif
+		}		
 	}
 }
 
@@ -1527,6 +1613,9 @@
 		if (state->info) {
 			init_waitqueue_head(&state->info->open_wait);
 			init_waitqueue_head(&state->info->delta_msr_wait);
+#ifdef RTSHDX
+			init_waitqueue_head(&state->port->rts_wait);
+#endif
 
 			/*
 			 * Link the info into the other structures.
diff -urN linux-2.6.24/drivers/usb/serial/ftdi_sio.c linux-2.6.24-new/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.24/drivers/usb/serial/ftdi_sio.c	2008-02-11 06:51:11.000000000 +0100
+++ linux-2.6.24-new/drivers/usb/serial/ftdi_sio.c	2008-07-07 22:40:30.000000000 +0200
@@ -301,6 +301,12 @@
 	unsigned long tx_bytes;
 	unsigned long tx_outstanding_bytes;
 	unsigned long tx_outstanding_urbs;
+#ifdef RTSHDX
+	unsigned char charLen;
+	bool toggleRTS;
+	char extended_status;
+	wait_queue_head_t rts_wait; // Used for blocking write
+#endif
 };
 
 /* struct ftdi_sio_quirk is used by devices requiring special attention. */
@@ -722,6 +728,20 @@
 	 return(ftdi_232bm_baud_base_to_divisor(baud, 48000000));
 }
 
+#ifdef RTSHDX
+static void simplified_sleep_on(wait_queue_head_t *queue)
+{
+	wait_queue_t wait;
+
+	init_waitqueue_entry(&wait, current);
+	current->state = TASK_INTERRUPTIBLE;
+
+	add_wait_queue(queue, &wait);
+	schedule();
+	remove_wait_queue (queue, &wait);
+}
+#endif
+
 #define set_mctrl(port, set)		update_mctrl((port), (set), 0)
 #define clear_mctrl(port, clear)	update_mctrl((port), 0, (clear))
 
@@ -1221,6 +1241,9 @@
 	spin_lock_init(&priv->rx_lock);
 	spin_lock_init(&priv->tx_lock);
         init_waitqueue_head(&priv->delta_msr_wait);
+#ifdef RTSHDX
+	init_waitqueue_head(&priv->rts_wait);
+#endif
 	/* This will push the characters through immediately rather
 	   than queue a task to deliver them */
 	priv->flags = ASYNC_LOW_LATENCY;
@@ -1372,8 +1395,13 @@
 	/* FIXME: Flow control might be enabled, so it should be checked -
 	   we have no control of defaults! */
 	/* Turn on RTS and DTR since we are not flow controlling by default */
+#ifdef RTSHDX
+	priv->toggleRTS = false;
+	set_mctrl(port, TIOCM_DTR);
+	clear_mctrl(port, TIOCM_RTS);
+#else
 	set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
-
+#endif
 	/* Not throttled */
 	spin_lock_irqsave(&priv->rx_lock, flags);
 	priv->rx_flags &= ~(THROTTLED | ACTUALLY_THROTTLED);
@@ -1453,7 +1481,9 @@
 	int status;
 	int transfer_size;
 	unsigned long flags;
-
+#ifdef RTSHDX
+  int baud;
+#endif
 	dbg("%s port %d, %d bytes", __FUNCTION__, port->number, count);
 
 	if (count == 0) {
@@ -1529,6 +1559,9 @@
 		      usb_sndbulkpipe(port->serial->dev, port->bulk_out_endpointAddress),
 		      buffer, transfer_size,
 		      ftdi_write_bulk_callback, port);
+#ifdef RTSHDX
+	set_mctrl(port, TIOCM_RTS);
+#endif
 
 	status = usb_submit_urb(urb, GFP_ATOMIC);
 	if (status) {
@@ -1545,10 +1578,25 @@
 	/* we are done with this urb, so let the host driver
 	 * really free it when it is finished with it */
 	usb_free_urb(urb);
+#ifdef RTSHDX
+	if(priv->toggleRTS){
+		priv->extended_status &= (~FTDI_RS_TEMT);
+		while((priv!=NULL)&&(!(priv->extended_status & FTDI_RS_TEMT))){
+			simplified_sleep_on(&priv->rts_wait);
+		}
+		baud = tty_get_baud_rate(port->tty);      
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(usecs_to_jiffies((2000000 * priv->charLen) / baud));
+		clear_mctrl(port, TIOCM_RTS);
+	}
+#endif
 
 	dbg("%s write returning: %d", __FUNCTION__, count);
 	return count;
 error:
+#ifdef RTSHDX
+	clear_mctrl(port, TIOCM_RTS);
+#endif
 	usb_free_urb(urb);
 error_no_urb:
 	kfree (buffer);
@@ -1769,12 +1817,22 @@
 		/* N.B. packet may be processed more than once, but differences
 		 * are only processed once.  */
 		if (priv != NULL) {
+#ifdef RTSHDX
+			char new_ext_status;
+#endif      
 			char new_status = data[packet_offset+0] & FTDI_STATUS_B0_MASK;
 			if (new_status != priv->prev_status) {
 				priv->diff_status |= new_status ^ priv->prev_status;
 				wake_up_interruptible(&priv->delta_msr_wait);
 				priv->prev_status = new_status;
 			}
+#ifdef RTSHDX
+			new_ext_status = data[packet_offset+1] & FTDI_RS_TEMT;
+			if ((new_ext_status != (priv->extended_status & FTDI_RS_TEMT)) && (new_ext_status != 0)){
+				priv->extended_status |= new_ext_status;
+				wake_up_interruptible(&priv->rts_wait);
+			}
+#endif
 		}
 
 		length = min(PKTSZ, urb->actual_length-packet_offset)-2;
@@ -1940,6 +1998,9 @@
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct ktermios *termios = port->tty->termios;
 	unsigned int cflag = termios->c_cflag;
+#ifdef RTSHDX
+	unsigned int lflag = termios->c_lflag;
+#endif
 	__u16 urb_value; /* will hold the new flags */
 	char buf[1]; /* Perhaps I should dynamically alloc this? */
 
@@ -1974,25 +2035,67 @@
 
 	/* Set number of data bits, parity, stop bits */
 
+#ifdef RTSHDX
+	priv->charLen = 1;
+#endif      
 	termios->c_cflag &= ~CMSPAR;
 
 	urb_value = 0;
 	urb_value |= (cflag & CSTOPB ? FTDI_SIO_SET_DATA_STOP_BITS_2 :
 		      FTDI_SIO_SET_DATA_STOP_BITS_1);
+#ifdef RTSHDX
+	priv->charLen += cflag & CSTOPB ? 2 : 1;
+#endif      
 	urb_value |= (cflag & PARENB ?
 		      (cflag & PARODD ? FTDI_SIO_SET_DATA_PARITY_ODD :
 		       FTDI_SIO_SET_DATA_PARITY_EVEN) :
 		      FTDI_SIO_SET_DATA_PARITY_NONE);
-	if (cflag & CSIZE) {
-		switch (cflag & CSIZE) {
-		case CS5: urb_value |= 5; dbg("Setting CS5"); break;
-		case CS6: urb_value |= 6; dbg("Setting CS6"); break;
-		case CS7: urb_value |= 7; dbg("Setting CS7"); break;
-		case CS8: urb_value |= 8; dbg("Setting CS8"); break;
+#ifdef RTSHDX
+	priv->charLen += cflag & PARENB ? 1 : 0;
+#endif      
+	if (cflag & CSIZE){
+		switch (cflag & CSIZE){
+		case CS5:
+#ifdef RTSHDX
+			priv->charLen += 5;
+#endif      
+			urb_value |= 5;
+			dbg("Setting CS5");
+			break;
+		case CS6:
+#ifdef RTSHDX
+			priv->charLen += 6;
+#endif      
+			urb_value |= 6;
+			dbg("Setting CS6");
+			break;
+		case CS7:
+#ifdef RTSHDX
+			priv->charLen += 7;
+#endif      
+			urb_value |= 7;
+			dbg("Setting CS7");
+			break;
+		case CS8:
+#ifdef RTSHDX
+			priv->charLen += 8;
+#endif      
+			urb_value |= 8;
+			dbg("Setting CS8");
+			break;
 		default:
 			err("CSIZE was set but not CS5-CS8");
 		}
 	}
+#ifdef RTSHDX
+	if(lflag & RTSHDX){
+		priv->toggleRTS = true;
+	}
+	else{
+		priv->toggleRTS = false;
+		set_mctrl(port, TIOCM_RTS);
+	}
+#endif
 
 	/* This is needed by the break command since it uses the same command - but is
 	 *  or'ed with this value  */
@@ -2025,7 +2128,17 @@
 		}
 		/* Ensure RTS and DTR are raised when baudrate changed from 0 */
 		if (!old_termios || (old_termios->c_cflag & CBAUD) == B0) {
+#ifdef RTSHDX
+			set_mctrl(port, TIOCM_DTR);
+			if(priv->toggleRTS){
+				clear_mctrl(port, TIOCM_RTS);
+			}
+			else{
+				set_mctrl(port, TIOCM_RTS);
+			}
+#else
 			set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+#endif
 		}
 	}
 
diff -urN linux-2.6.24/include/asm-x86/termbits.h linux-2.6.24-new/include/asm-x86/termbits.h
--- linux-2.6.24/include/asm-x86/termbits.h	2008-02-11 06:51:11.000000000 +0100
+++ linux-2.6.24-new/include/asm-x86/termbits.h	2008-06-15 00:24:00.000000000 +0200
@@ -176,6 +176,7 @@
 #define ECHOPRT	0002000
 #define ECHOKE	0004000
 #define FLUSHO	0010000
+#define RTSHDX  0020000
 #define PENDIN	0040000
 #define IEXTEN	0100000
 
diff -urN linux-2.6.24/include/linux/serial_core.h linux-2.6.24-new/include/linux/serial_core.h
--- linux-2.6.24/include/linux/serial_core.h	2008-02-11 06:51:11.000000000 +0100
+++ linux-2.6.24-new/include/linux/serial_core.h	2008-06-16 00:28:06.000000000 +0200
@@ -297,6 +297,10 @@
 	unsigned char		suspended;
 	unsigned char		unused[2];
 	void			*private_data;		/* generic platform data pointer */
+#ifdef RTSHDX
+	bool toggleRTS;
+	wait_queue_head_t rts_wait; // Used for blocking write
+#endif	
 };
 
 /*

--------------050804000409090501030307--
