From: =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
Subject: [PATCH v2 2/4] drivers: tty: 68328serial.c: remove trailing whitespaces
Date: Wed, 16 Dec 2015 16:16:59 +0100
Message-ID: <1450279021-17154-3-git-send-email-frederik.voelkel@fau.de>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
 <1450279021-17154-1-git-send-email-frederik.voelkel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450279021-17154-1-git-send-email-frederik.voelkel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, lukas.braun@fau.de, linux-kernel@i4.cs.fau.de, =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
List-Id: linux-serial@vger.kernel.org

This patch removes trailing whitespaces reported by checkpatch.

Signed-off-by: Frederik V=C3=B6lkel <frederik.voelkel@fau.de>
Signed-off-by: Lukas Braun <lukas.braun@fau.de>
---
 drivers/tty/serial/68328serial.c | 98 ++++++++++++++++++++------------=
--------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/6832=
8serial.c
index 183f6d9..f7f9b7e 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -217,7 +217,7 @@ static void rs_stop(struct tty_struct *tty)
=20
 	if (serial_paranoia_check(info, tty->name, "rs_stop"))
 		return;
-=09
+
 	local_irq_save(flags);
 	uart->ustcnt &=3D ~USTCNT_TXEN;
 	local_irq_restore(flags);
@@ -246,10 +246,10 @@ static void rs_start(struct tty_struct *tty)
 	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
 	m68328_uart *uart =3D &uart_addr[info->line];
 	unsigned long flags;
-=09
+
 	if (serial_paranoia_check(info, tty->name, "rs_start"))
 		return;
-=09
+
 	local_irq_save(flags);
 	if (info->xmit_cnt && info->xmit_buf && !(uart->ustcnt & USTCNT_TXEN)=
) {
 #ifdef USE_INTS
@@ -267,13 +267,13 @@ static void receive_chars(struct m68k_serial *inf=
o, unsigned short rx)
 	unsigned char ch, flag;
=20
 	/*
-	 * This do { } while() loop will get ALL chars out of Rx FIFO=20
+	 * This do { } while() loop will get ALL chars out of Rx FIFO
 	 */
 #ifndef CONFIG_XCOPILOT_BUGS
 	do {
-#endif=09
+#endif
 		ch =3D GET_FIELD(rx, URX_RXDATA);
-=09
+
 		if (info->is_cons) {
 			if (URX_BREAK & rx) { /* whee, break received */
 				return;
@@ -374,7 +374,7 @@ static int startup(struct m68k_serial *info, struct=
 tty_struct *tty)
 {
 	m68328_uart *uart =3D &uart_addr[info->line];
 	unsigned long flags;
-=09
+
 	if (info->tport.flags & ASYNC_INITIALIZED)
 		return 0;
=20
@@ -399,7 +399,7 @@ static int startup(struct m68k_serial *info, struct=
 tty_struct *tty)
 	 * Finally, enable sequencing and interrupts
 	 */
 #ifdef USE_INTS
-	uart->ustcnt =3D USTCNT_UEN | USTCNT_RXEN |=20
+	uart->ustcnt =3D USTCNT_UEN | USTCNT_RXEN |
 		USTCNT_RX_INTR_MASK | USTCNT_TX_INTR_MASK;
 #else
 	uart->ustcnt =3D USTCNT_UEN | USTCNT_RXEN | USTCNT_RX_INTR_MASK;
@@ -434,7 +434,7 @@ static void shutdown(struct m68k_serial *info, stru=
ct tty_struct *tty)
 		return;
=20
 	local_irq_save(flags);
-=09
+
 	if (info->xmit_buf) {
 		free_page((unsigned long) info->xmit_buf);
 		info->xmit_buf =3D 0;
@@ -442,7 +442,7 @@ static void shutdown(struct m68k_serial *info, stru=
ct tty_struct *tty)
=20
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
-=09
+
 	info->tport.flags &=3D ~ASYNC_INITIALIZED;
 	local_irq_restore(flags);
 }
@@ -491,7 +491,7 @@ struct {
 	{1, 0x26}, /* 38400 */
 	{0, 0x26}, /* 57600 */
 	{1, 0x38}, /* 115200 */
-};=20
+};
 #endif
 /* rate =3D 1036800 / ((65 - prescale) * (1<<divider)) */
=20
@@ -520,14 +520,14 @@ static void change_speed(struct m68k_serial *info=
, struct tty_struct *tty)
 		i =3D (i & ~CBAUDEX) + B38400;
 	}
=20
-	uart->ubaud =3D PUT_FIELD(UBAUD_DIVIDE,    hw_baud_table[i].divisor) =
|=20
+	uart->ubaud =3D PUT_FIELD(UBAUD_DIVIDE,    hw_baud_table[i].divisor) =
|
 		PUT_FIELD(UBAUD_PRESCALER, hw_baud_table[i].prescale);
=20
 	ustcnt &=3D ~(USTCNT_PARITYEN | USTCNT_ODD_EVEN | USTCNT_STOP | USTCN=
T_8_7);
-=09
+
 	if ((cflag & CSIZE) =3D=3D CS8)
 		ustcnt |=3D USTCNT_8_7;
-	=09
+
 	if (cflag & CSTOPB)
 		ustcnt |=3D USTCNT_STOP;
=20
@@ -535,7 +535,7 @@ static void change_speed(struct m68k_serial *info, =
struct tty_struct *tty)
 		ustcnt |=3D USTCNT_PARITYEN;
 	if (cflag & PARODD)
 		ustcnt |=3D USTCNT_ODD_EVEN;
-=09
+
 #ifdef CONFIG_SERIAL_68328_RTS_CTS
 	if (cflag & CRTSCTS) {
 		uart->utx.w &=3D ~UTX_NOCTS;
@@ -545,7 +545,7 @@ static void change_speed(struct m68k_serial *info, =
struct tty_struct *tty)
 #endif
=20
 	ustcnt |=3D USTCNT_TXEN;
-=09
+
 	uart->ustcnt =3D ustcnt;
 	return;
 }
@@ -590,7 +590,7 @@ static void rs_fair_output(void)
 void console_print_68328(const char *p)
 {
 	char c;
-=09
+
 	while ((c =3D *(p++)) !=3D 0) {
 		if (c =3D=3D '\n')
 			rs_put_char('\r');
@@ -611,7 +611,7 @@ static void rs_set_ldisc(struct tty_struct *tty)
 		return;
=20
 	info->is_cons =3D (tty->termios.c_line =3D=3D N_TTY);
-=09
+
 	printk("ttyS%d console mode %s\n", info->line, info->is_cons ? "on" :=
 "off");
 }
=20
@@ -677,7 +677,7 @@ static int rs_write(struct tty_struct *tty,
=20
 	local_save_flags(flags);
 	while (1) {
-		local_irq_disable();	=09
+		local_irq_disable();
 		c =3D min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 				   SERIAL_XMIT_SIZE - info->xmit_head));
 		local_irq_restore(flags);
@@ -698,7 +698,7 @@ static int rs_write(struct tty_struct *tty,
=20
 	if (info->xmit_cnt && !tty->stopped) {
 		/* Enable transmitter */
-		local_irq_disable();	=09
+		local_irq_disable();
 #ifndef USE_INTS
 		while (info->xmit_cnt) {
 #endif
@@ -728,7 +728,7 @@ static int rs_write_room(struct tty_struct *tty)
 {
 	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
 	int	ret;
-			=09
+
 	if (serial_paranoia_check(info, tty->name, "rs_write_room"))
 		return 0;
 	ret =3D SERIAL_XMIT_SIZE - info->xmit_cnt - 1;
@@ -740,7 +740,7 @@ static int rs_write_room(struct tty_struct *tty)
 static int rs_chars_in_buffer(struct tty_struct *tty)
 {
 	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
-			=09
+
 	if (serial_paranoia_check(info, tty->name, "rs_chars_in_buffer"))
 		return 0;
 	return info->xmit_cnt;
@@ -750,7 +750,7 @@ static void rs_flush_buffer(struct tty_struct *tty)
 {
 	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
 	unsigned long flags;
-			=09
+
 	if (serial_paranoia_check(info, tty->name, "rs_flush_buffer"))
 		return;
 	local_irq_save(flags);
@@ -762,7 +762,7 @@ static void rs_flush_buffer(struct tty_struct *tty)
 /*
  * ------------------------------------------------------------
  * rs_throttle()
- *=20
+ *
  * This routine is called by the upper-layer tty layer to signal that
  * incoming characters should be throttled.
  * ------------------------------------------------------------
@@ -773,7 +773,7 @@ static void rs_throttle(struct tty_struct *tty)
=20
 	if (serial_paranoia_check(info, tty->name, "rs_throttle"))
 		return;
-=09
+
 	if (I_IXOFF(tty))
 		info->x_char =3D STOP_CHAR(tty);
=20
@@ -786,7 +786,7 @@ static void rs_unthrottle(struct tty_struct *tty)
=20
 	if (serial_paranoia_check(info, tty->name, "rs_unthrottle"))
 		return;
-=09
+
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char =3D 0;
@@ -807,7 +807,7 @@ static int get_serial_info(struct m68k_serial *info=
,
 			   struct serial_struct *retinfo)
 {
 	struct serial_struct tmp;
- =20
+
 	if (!retinfo)
 		return -EFAULT;
 	memset(&tmp, 0, sizeof(tmp));
@@ -832,7 +832,7 @@ static int set_serial_info(struct m68k_serial *info=
, struct tty_struct *tty,
 	struct tty_port *port =3D &info->tport;
 	struct serial_struct new_serial;
 	struct m68k_serial old_info;
-	int 			retval =3D 0;
+	int			retval =3D 0;
=20
 	if (!new_info)
 		return -EFAULT;
@@ -881,7 +881,7 @@ check_and_exit:
  * 	    release the bus after transmitting. This must be done when
  * 	    the transmit shift register is empty, not be done when the
  * 	    transmit holding register is empty.  This functionality
- * 	    allows an RS485 driver to be written in user space.=20
+ *	    allows an RS485 driver to be written in user space.
  */
 static int get_lsr_info(struct m68k_serial *info, unsigned int *value)
 {
@@ -911,11 +911,11 @@ static void send_break(struct m68k_serial *info, =
unsigned int duration)
 	if (!info->port)
 		return;
 	local_irq_save(flags);
-#ifdef USE_INTS=09
+#ifdef USE_INTS
 	uart->utx.w |=3D UTX_SEND_BREAK;
 	msleep_interruptible(duration);
 	uart->utx.w &=3D ~UTX_SEND_BREAK;
-#endif	=09
+#endif
 	local_irq_restore(flags);
 }
=20
@@ -934,7 +934,7 @@ static int rs_ioctl(struct tty_struct *tty,
 		if (tty->flags & (1 << TTY_IO_ERROR))
 		    return -EIO;
 	}
-=09
+
 	switch (cmd) {
 		case TCSBRK:	/* SVID version: non-zero arg --> no break */
 			retval =3D tty_check_change(tty);
@@ -979,13 +979,13 @@ static void rs_set_termios(struct tty_struct *tty=
, struct ktermios *old_termios)
 	if ((old_termios->c_cflag & CRTSCTS) &&
 	    !(tty->termios.c_cflag & CRTSCTS))
 		rs_start(tty);
-=09
+
 }
=20
 /*
  * ------------------------------------------------------------
  * rs_close()
- *=20
+ *
  * This routine is called when the serial port gets closed.  First, we
  * wait for the last remaining data to be sent.  Then, we unlink its
  * S structure from the interrupt chain if necessary, and we free
@@ -1001,14 +1001,14 @@ static void rs_close(struct tty_struct *tty, st=
ruct file *filp)
=20
 	if (serial_paranoia_check(info, tty->name, "rs_close"))
 		return;
-=09
+
 	local_irq_save(flags);
-=09
+
 	if (tty_hung_up_p(filp)) {
 		local_irq_restore(flags);
 		return;
 	}
-=09
+
 	if ((tty->count =3D=3D 1) && (port->count !=3D 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
@@ -1032,7 +1032,7 @@ static void rs_close(struct tty_struct *tty, stru=
ct file *filp)
 	}
 	port->flags |=3D ASYNC_CLOSING;
 	/*
-	 * Now we wait for the transmit buffer to clear; and we notify=20
+	 * Now we wait for the transmit buffer to clear; and we notify
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing =3D 1;
@@ -1050,11 +1050,11 @@ static void rs_close(struct tty_struct *tty, st=
ruct file *filp)
=20
 	shutdown(info, tty);
 	rs_flush_buffer(tty);
-	=09
+
 	tty_ldisc_flush(tty);
 	tty->closing =3D 0;
 	tty_port_tty_set(&info->tport, NULL);
-#warning "This is not and has never been valid so fix it"=09
+#warning "This is not and has never been valid so fix it"
 #if 0
 	if (tty->ldisc.num !=3D ldiscs[N_TTY].num) {
 		if (tty->ldisc.close)
@@ -1064,7 +1064,7 @@ static void rs_close(struct tty_struct *tty, stru=
ct file *filp)
 		if (tty->ldisc.open)
 			(tty->ldisc.open)(tty);
 	}
-#endif=09
+#endif
 	if (port->blocked_open) {
 		if (port->close_delay)
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
@@ -1080,10 +1080,10 @@ static void rs_close(struct tty_struct *tty, st=
ruct file *filp)
 void rs_hangup(struct tty_struct *tty)
 {
 	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
-=09
+
 	if (serial_paranoia_check(info, tty->name, "rs_hangup"))
 		return;
-=09
+
 	rs_flush_buffer(tty);
 	shutdown(info, tty);
 	info->tport.count =3D 0;
@@ -1166,14 +1166,14 @@ rs68328_init(void)
=20
 	/* Initialize the tty_driver structure */
 	/* SPARC: Not all of this is exactly right for us. */
-=09
+
 	serial_driver->name =3D "ttyS";
 	serial_driver->major =3D TTY_MAJOR;
 	serial_driver->minor_start =3D 64;
 	serial_driver->type =3D TTY_DRIVER_TYPE_SERIAL;
 	serial_driver->subtype =3D SERIAL_TYPE_NORMAL;
 	serial_driver->init_termios =3D tty_std_termios;
-	serial_driver->init_termios.c_cflag =3D=20
+	serial_driver->init_termios.c_cflag =3D
 			m68328_console_cbaud | CS8 | CREAD | HUPCL | CLOCAL;
 	serial_driver->flags =3D TTY_DRIVER_REAL_RAW;
 	tty_set_operations(serial_driver, &rs_ops);
@@ -1192,11 +1192,11 @@ rs68328_init(void)
 	    info->x_char =3D 0;
 	    info->line =3D i;
 	    info->is_cons =3D 1; /* Means shortcuts work */
-	   =20
-	    printk("%s%d at 0x%08x (irq =3D %d)", serial_driver->name, info->=
line,=20
+
+	    printk("%s%d at 0x%08x (irq =3D %d)", serial_driver->name, info->=
line,
 		   info->port, info->irq);
 	    printk(" is a builtin MC68328 UART\n");
-	   =20
+
 #ifdef CONFIG_M68VZ328
 		if (i > 0)
 			PJSEL &=3D 0xCF;  /* PSW enable second port output */
@@ -1244,7 +1244,7 @@ again:
 		goto again;
 	}
=20
-	UBAUD =3D PUT_FIELD(UBAUD_DIVIDE,    hw_baud_table[i].divisor) |=20
+	UBAUD =3D PUT_FIELD(UBAUD_DIVIDE,    hw_baud_table[i].divisor) |
 		PUT_FIELD(UBAUD_PRESCALER, hw_baud_table[i].prescale);
 	ustcnt &=3D ~(USTCNT_PARITYEN | USTCNT_ODD_EVEN | USTCNT_STOP | USTCN=
T_8_7);
 	ustcnt |=3D USTCNT_8_7;
--=20
1.9.1
