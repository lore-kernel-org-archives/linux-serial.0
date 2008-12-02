From: Christopher Gibson <chris@toftronix.com.au>
Subject: [PATCH/RFC] Auto RS485 direction control
Date: Wed, 03 Dec 2008 00:09:57 +1100
Message-ID: <1228223397.2968.1.camel@thetriton.toftronix.com.au>
References: <002101c8f6fa$9273ab10$2e01a8c0@acksys.local>
	 <1218033008.6275.86.camel@thetriton.toftronix.com.au>
	 <200808071050.35380.laurentp@cse-semaphore.com>
	 <1218340666.9309.58.camel@thetriton.toftronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:52384 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754898AbYLBN1D (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Dec 2008 08:27:03 -0500
In-Reply-To: <1218340666.9309.58.camel@thetriton.toftronix.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christopher Gibson <chris@toftronix.com.au>
Cc: linux-serial@vger.kernel.org

Have finally put together a patch for UART direction control utilising
either the RTS, or the DTR handshaking lines, with settable pre and post
delay times.

This patch was tested on a 2.6.27.4 version kernel, on an AMD64 bit
machine.  A previous version was tested on an i486 machine, but there
have been many changes since.

This is a software only solution, requiring no special hardware, but
timing control for delays is only accurate to the next nearest jiffy.

I've allowed for setting the delays to microsecond resolution only to
support future work that utilises special UART features.  (I've found
very fine timing control on handshake line release in the Atmel USART
peripherals, and have also seen references to it in various embedded
controllers).


diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 77cb342..5ca3ba3 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1421,4 +1421,32 @@ config SPORT_BAUD_RATE
 	default 19200 if (SERIAL_SPORT_BAUD_RATE_19200)
 	default 9600 if (SERIAL_SPORT_BAUD_RATE_9600)
 
+comment "serial port extensions"
+        depends on EXPERIMENTAL
+
+config SERIAL_PORT_DIRECTION_CONTROL
+        bool "Allow hand shake line half duplex direction signaling"
+        default n
+        select SERIAL_CORE
+        help
+          Some serial communications devices are half-duplex and
require
+          a signal to give the required direction of communications.  
+          
+          One common example of this is when using a MAX202 - MAX485
chip 
+          pair (or similar) as a bridge between a RS232 interface and
a 
+          RS485 interface.
+          
+          Another example is when using simple radio modems, which may
have a 
+          further requirement that the direction should be asserted for
a 
+          specified time before transmission, and held for a specified
time 
+          after packet transmission.
+
+          Select this option to enable kernel control of the
handshaking
+          lines to give direction control.  This will make a serial
port
+          ioctl (TIOCSRS485) available for enabling this feature as
well as
+          for configuration of handshaking line to use (RTS or DTR), 
+          the sense of the line, and pre and post transmission delays.
+
+          Unless you know that you need this say N.
+
 endmenu
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index f977c98..d691338 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -62,6 +62,7 @@ static void uart_change_speed(struct uart_state
*state,
 					struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
 static void uart_change_pm(struct uart_state *state, int pm_state);
+static void direction_control_uart_start(struct tty_struct *tty);
 
 /*
  * This routine is used by the interrupt handler to schedule processing
in
@@ -105,6 +106,12 @@ static void uart_start(struct tty_struct *tty)
 	struct uart_port *port = state->port;
 	unsigned long flags;
 
+#ifdef CONFIG_SERIAL_PORT_DIRECTION_CONTROL
+	if (port->rs485.settings.flags & SER_RS485_MODE) {
+		direction_control_uart_start(tty);
+		return;
+	}
+#endif
 	spin_lock_irqsave(&port->lock, flags);
 	__uart_start(tty);
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -130,8 +137,15 @@ uart_update_mctrl(struct uart_port *port, unsigned
int set, unsigned int clear)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+#ifdef CONFIG_SERIAL_PORT_DIRECTION_CONTROL
+#define uart_set_mctrl(port, set) \
+	uart_update_mctrl(port, (set) & ~port->rs485.mctrl_mask, 0)
+#define uart_clear_mctrl(port, clear) \
+	uart_update_mctrl(port, 0, (clear) & ~port->rs485.mctrl_mask)
+#else
 #define uart_set_mctrl(port, set)	uart_update_mctrl(port, set, 0)
 #define uart_clear_mctrl(port, clear)	uart_update_mctrl(port, 0, clear)
+#endif
 
 /*
  * Startup the port.  This will be called once per open.  All calls
@@ -456,6 +470,169 @@ uart_change_speed(struct uart_state *state, struct
ktermios *old_termios)
 	port->ops->set_termios(port, termios, old_termios);
 }
 
+#ifdef CONFIG_SERIAL_PORT_DIRECTION_CONTROL
+/**
+ * direction_control_init() - initialise direction control state
variables.
+ * @tty:	tty for UART
+ * 
+ * Initialisation call to setup state variables used for the direction
+ * control logic.
+ * Note that the direction control settings themselves have persistence
+ * across device openings.
+ */
+static void direction_control_init(struct tty_struct *tty)
+{
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->port;
+	struct serial_rs485 *rs = &port->rs485;
+
+	init_timer(&rs->pre_post_timer);
+	rs->pre_post_timer.function = NULL;
+	rs->pre_post_timer.data = (unsigned long)tty;
+}
+
+/**
+ * direction_control_timed_post_xmit() - Post transmission delay
callback
+ * @data:	Holds pointer to the tty structure, recorded when timer is 
+ * 		set up.
+ *
+ * This is a kernel timer callback function, that is called after the
post
+ * transmission delay has expired.  It uses a modem control call to set
the
+ * RTS or DTR line for inbound communications.
+ *
+ * Note: This software timing approach limits direction control timing
to
+ * 	granularity to that of the System timer. (Timing is only good to
the 
+ * 	nearest jiffy).  
+ **/
+static void direction_control_timed_post_xmit(unsigned long data)
+{
+	struct tty_struct *tty = (struct tty_struct *)data;
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->port;
+	struct serial_rs485 *rs = &port->rs485;
+	uart_update_mctrl(port,
+			  rs->mctrl_mask & ~rs->mctrl_xmit,
+			  rs->mctrl_mask & rs->mctrl_xmit);
+	rs->pre_post_timer.function = NULL;	/* Back to idle state */
+}
+
+/**
+ * direction_control_timed_xmit_end_detect() - End of transmission
polling
+ * @data:	Holds pointer to the tty structure, recorded when timer is 
+ * 		set up.
+ *
+ * This is a kernel timer callback function, called on every timer tick
until
+ * it is detected that there is no more data to transmit.  The post 
+ * transmission delay is then scheduled.
+ **/
+static void direction_control_timed_xmit_end_detect(unsigned long data)
+{
+	struct tty_struct *tty = (struct tty_struct *)data;
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->port;
+	struct serial_rs485 *rs = &port->rs485;
+
+	if (port->ops->tx_empty(port)) {
+		if (rs->post_jiffies) {
+			/*
+			 * Schedule line turn around after required delay.
+			 */
+			rs->pre_post_timer.function =
+				direction_control_timed_post_xmit;
+			rs->pre_post_timer.expires = jiffies + rs->post_jiffies;
+			add_timer(&rs->pre_post_timer);
+		} else {
+			/*
+			 * No delay required turn line around now.
+			 */
+			direction_control_timed_post_xmit(data);
+		}
+	} else {
+		/* 
+		 * Transmission not finished, so try again next jiffy.
+		 */
+		add_timer(&rs->pre_post_timer);
+	}
+}
+
+/**
+ * direction_control_timed_start_xmit() - Trigger data transmission
+ * @data:	tty pointer for UART type case as unsigned long.
+ * 		(To conform to timer callback function prototype)
+ *
+ * Kicks the UART into transmission mode, and schedules polling of the
+ * UART status for transmission completion once per jiffy.  
+ * Called from a timer if a pre-transmission delay is required or
directly if 
+ * not.
+ */
+static void direction_control_timed_start_xmit(unsigned long data)
+{
+	struct tty_struct *tty = (struct tty_struct *)data;
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->port;
+	struct serial_rs485 *rs = &port->rs485;
+	unsigned long flags;
+
+	rs->pre_post_timer.function = direction_control_timed_xmit_end_detect;
+	rs->pre_post_timer.expires  = jiffies;
+	add_timer(&rs->pre_post_timer);
+	spin_lock_irqsave(&port->lock, flags);
+	__uart_start(tty);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+/**
+ * direction_control_uart_start() - UART Tx start, with direction
control
+ * @tty:	tty for UART
+ *
+ * Changes RTS and/or DTR handshaking lines to prepare for data
transmission.
+ * Schedules a delayed transmission if a required, or initiates
immediate
+ * transmission if pre transmission delay not required.
+ */
+static void direction_control_uart_start(struct tty_struct *tty)
+{
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->port;
+	struct serial_rs485 *rs = &port->rs485;
+	if (!rs->pre_post_timer.function) {	/* Was in idle (Rx) state? */
+		/*
+		 * Set RTS or DTR for transmission.
+		 */
+		uart_update_mctrl(port,
+				  rs->mctrl_mask & rs->mctrl_xmit,
+				  rs->mctrl_mask & ~rs->mctrl_xmit);
+
+		if (rs->pre_jiffies) {
+			/*
+			 * Pre transmission delay required, schedule timer.
+			 */
+			rs->pre_post_timer.function =
+			    direction_control_timed_start_xmit;
+			rs->pre_post_timer.expires = jiffies + rs->pre_jiffies;
+			add_timer(&rs->pre_post_timer);
+		} else {
+			/*
+			 * No pre transmission delay required start 
+			 * immediate transmission.
+			 */
+			direction_control_timed_start_xmit((unsigned long)tty);
+		}
+	} else if (rs->pre_post_timer.function ==
+		   direction_control_timed_start_xmit) {
+		/* 
+		 * Nothing to do - already in pre xmit delay.
+		 */
+	} else {
+		/* 
+		 * Transmitting or in post transmit delay, reschedule the end 
+		 * of transmission polling.
+		 */
+		del_timer(&port->rs485.pre_post_timer);
+		direction_control_timed_start_xmit((unsigned long)tty);
+	}
+}
+#endif
+
 static inline int
 __uart_put_char(struct uart_port *port, struct circ_buf *circ, unsigned
char c)
 {
@@ -1082,6 +1259,70 @@ static int uart_get_count(struct uart_state
*state,
 	return copy_to_user(icnt, &icount, sizeof(icount)) ? -EFAULT : 0;
 }
 
+#ifdef CONFIG_SERIAL_PORT_DIRECTION_CONTROL
+/*
+ * Get the current direction control settings.
+ */
+static int rs485_get_settings(struct tty_struct *tty,
+			      struct serial_rs485_settings __user * uarg)
+{
+	struct uart_state *state = tty->driver_data;
+	int ret;
+	ret = copy_to_user(uarg, &state->port->rs485.settings, sizeof(*uarg));
+	ret = ret ? -EFAULT : 0;
+	return ret;
+}
+
+/*
+ * Set the current direction control settings.
+ */
+static int rs485_set_settings(struct tty_struct *tty,
+			      struct serial_rs485_settings __user * uarg)
+{
+	struct uart_state *state = tty->driver_data;
+	struct serial_rs485 *rs = &state->port->rs485;
+
+	/*-- Get requested settings. */
+	if (copy_from_user(&rs->settings, uarg, sizeof(rs->settings))) {
+		return -EFAULT;
+	}
+	/*
+	 * Alter requested settings to match our capabilities.
+	 * The user can query this by reading the setting back.
+	 */
+	rs->settings.delay_before_send =
+		jiffies_to_usecs(usecs_to_jiffies(
+					rs->settings.delay_before_send)); 
+
+	rs->settings.delay_after_send =
+		jiffies_to_usecs(usecs_to_jiffies(
+					rs->settings.delay_after_send)); 
+
+	/*
+	 * Pre-calculate values based on settings, to make interrupt code
+	 * more efficient.
+	 */
+	rs->pre_jiffies = usecs_to_jiffies(rs->settings.delay_before_send);
+	rs->post_jiffies = usecs_to_jiffies(rs->settings.delay_after_send);
+
+	rs->mctrl_mask = 0;
+	rs->mctrl_xmit = 0;
+	if (rs->settings.flags & SER_RS485_MODE_RTS) {
+		rs->mctrl_mask |= TIOCM_RTS;
+		if ( !(rs->settings.flags & SER_RS485_RTS_TX_LOW) ) {
+			rs->mctrl_xmit |= TIOCM_RTS;
+		}
+	}
+	if (rs->settings.flags & SER_RS485_MODE_DTR) {
+		rs->mctrl_mask |= TIOCM_DTR;
+		if ( !(rs->settings.flags & SER_RS485_DTR_TX_LOW) ) {
+			rs->mctrl_xmit |= TIOCM_DTR;
+		}
+	}
+	return 0;
+}
+#endif
+
 /*
  * Called via sys_ioctl.  We can use spin_lock_irq() here.
  */
@@ -1114,6 +1355,14 @@ uart_ioctl(struct tty_struct *tty, struct file
*filp, unsigned int cmd,
 	case TIOCSERSWILD: /* obsolete */
 		ret = 0;
 		break;
+#ifdef CONFIG_SERIAL_PORT_DIRECTION_CONTROL
+	case TIOCGRS485:
+		ret = rs485_get_settings(tty, uarg);
+		break;
+	case TIOCSRS485:
+		ret = rs485_set_settings(tty, uarg);
+		break;
+#endif
 	}
 
 	if (ret != -ENOIOCTLCMD)
@@ -1680,6 +1929,9 @@ static int uart_open(struct tty_struct *tty,
struct file *filp)
 		state->info->flags |= UIF_NORMAL_ACTIVE;
 
 		uart_update_termios(state);
+#ifdef CONFIG_SERIAL_PORT_DIRECTION_CONTROL
+		direction_control_init(tty);
+#endif
 	}
 
  fail:
diff --git a/include/asm-x86/ioctls.h b/include/asm-x86/ioctls.h
index c0c338b..2cd4775 100644
--- a/include/asm-x86/ioctls.h
+++ b/include/asm-x86/ioctls.h
@@ -51,6 +51,8 @@
 #define TCSETS2		_IOW('T', 0x2B, struct termios2)
 #define TCSETSW2	_IOW('T', 0x2C, struct termios2)
 #define TCSETSF2	_IOW('T', 0x2D, struct termios2)
+#define TIOCGRS485	0x542E
+#define TIOCSRS485	0x542F
 #define TIOCGPTN	_IOR('T', 0x30, unsigned int)
 				/* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T', 0x31, int)  /* Lock/unlock Pty */
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3b2f6c0..1051c8c 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -165,6 +165,7 @@
 #include <linux/tty.h>
 #include <linux/mutex.h>
 #include <linux/sysrq.h>
+#include <linux/timer.h>
 
 struct uart_port;
 struct uart_info;
@@ -239,6 +240,31 @@ struct uart_icount {
 
 typedef unsigned int __bitwise__ upf_t;
 
+#ifdef CONFIG_SERIAL_PORT_DIRECTION_CONTROL
+/* -- Settings used with the TIOCSRS485 & TIOCGRS485 ioctl */
+struct serial_rs485_settings{
+		__u32   flags;			/* RS485 feature flags */
+#define SER_RS485_MODE			(3 << 0)	/* Mask for mode. */
+#define SER_RS485_MODE_DISABLED		(0 << 0)
+#define SER_RS485_MODE_RTS		(1 << 0)
+#define SER_RS485_MODE_DTR		(2 << 0)
+#define SER_RS485_RTS_TX_LOW		(1 << 2)	/* Inverted RTS	*/
+#define SER_RS485_DTR_TX_LOW		(1 << 3)	/* Inverted DTR	*/
+		__u32   delay_before_send;		/* Microseconds */
+		__u32   delay_after_send;		/* Microseconds */
+		__u32   padding[5];             /* Memory is cheap, new structs
+						   are a royal PITA .. */
+};
+struct serial_rs485 {
+	struct serial_rs485_settings	settings;
+	struct	timer_list       	pre_post_timer;
+	u16	pre_jiffies;
+	u16	post_jiffies;
+	unsigned int mctrl_mask;
+	unsigned int mctrl_xmit;		/* Bits for Tx.	*/
+};
+#endif
+
 struct uart_port {
 	spinlock_t		lock;			/* port lock */
 	unsigned int		iobase;			/* in/out[bwl] */
@@ -308,6 +334,9 @@ struct uart_port {
 	unsigned char		suspended;
 	unsigned char		unused[2];
 	void			*private_data;		/* generic platform data pointer */
+#ifdef CONFIG_SERIAL_PORT_DIRECTION_CONTROL
+	struct serial_rs485	rs485;
+#endif
 };
 
 /*


-- 
Christopher Gibson <chris@toftronix.com.au>

