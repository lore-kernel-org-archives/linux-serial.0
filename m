From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: RS485 implementation questions (primarly in atmel_serial.c)
Date: Wed, 30 Jan 2013 11:30:25 +0100
Message-ID: <5108F641.40007@evidence.eu.com>
References: <CAJa4H3cYT6QOaacWEy2yZjb0hM3m4p+0L2_fXBYv8tWajYkmGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ziz.elan42.com ([31.171.246.141]:35417 "EHLO ziz.elan42.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab3A3KkN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2013 05:40:13 -0500
In-Reply-To: <CAJa4H3cYT6QOaacWEy2yZjb0hM3m4p+0L2_fXBYv8tWajYkmGw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guido Classen <clagix@gmail.com>
Cc: linux-serial@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>

Il 23/01/2013 23:51, Guido Classen ha scritto:
> Hi everyone on linux serial list,
>
> I'm currently working on upgrading ARM-Linux board of our company
> to a recent Linux kernel and am glad to see, that RS485 support has
> reached the mainline. Firstly many thanks to Claudio Scordino and
> the other contributers, I really appreciate their work. I've contacted
> Claudio, to discuss some issues about RS485. But he is currently to bus, so
> I hope to find others here to discuss my questions and concerns.
>
> I personally work for over 10 years with RS485 stuff (even on
> microprocessor systems from the pre-Linux era) and also implemented
> several years ago RS485 for our company's own AT91 Linux based boards.
> My old implementation was based on the 1ms tick timer and supported
> both, the 16550 chips and at Atmel AT91 USARTS.
>
> I've recently looked at the current atmel_serial.c sources and have
> trouble to understand why RS485 is implemented in this way.
>
> First question is about what is the exact meaning of the
> delay_rts_before/after_send fields in the RS485 ioctl?  Unfortunately
> there is no explanation (except from the sample code) in
> Documentation/serial serial-rs485.txt. It's not even clear in which
> Units this parameters are given. The crisv10.c driver gets the
> delay_before_send in milliseconds and atmel_serial
> delay_rts_after_send in bit-times (means depending on baud rate).
>
> In my opinion (and according the practice in our company) the purpose
> of delay_rts_before/after_send is to make the time in which RTS is
> asserted a bit longer (at choice before and / or after) as the actual
> transmission of the characters take. The reason is that longs lines
> need some time for the transition from tri-state (open circuit voltage
> supplied by pull-up / pull-down resistors) to the active transmission
> level (logical "1"). I think this is called transient oscillation (I'm
> not sure if this is the right English term). Furthermore active
> devices in the RS485 line (repeater, party-line modems) often need to
> know if you want to send a bit earlier than the first character
> arrives to have some time to do internal switching from receiving to
> transmission.
>
> I this cases you need a way to assert RTS some milliseconds before the
> first character of a frame is transmitted and leave it on some
> milliseconds after the end of the frame. In my opinion that is what
> delay_rts_before/after_send should be for. (In other equipment this
> feature is also called turn on / turn off delay)
>
> I've a short look to the sources of the crisv10.c driver (I don't
> actually have such hardware).  Assuming that a frame is written using
> a single write() operation (and I have understood the code right...)
> it will work as I expect. (Doing a single mssleep() per frame
> afterwards RTS is asserted). delay_after_send seems not to be
> implement at all (perhaps its not easly possible to detect when the
> transmitter has shifted out the last bit of the frame).
>
> But in the atmel_serial.c driver rthe Transmit Timeguard function of
> the AT91 USART is used to implement this.  The purpose of the Transmit
> Timeguard function is to throttle transmission in case the receiving
> device is able to receive/process incoming characters at line
> speed. This means the USART will insert a gap between EACH transmitted
> byte and not only the last of a frame.  Atmel surely had its reasons
> to implement such a function, but luckily nowadays such devices are
> rare.  But this function is not especially related to RS485. It is
> also applicable in RS232 mode.  So in my view it is not the
> functionality which is meant by the delay_rts_before/after_send
> fields.  Traditional field bus protocols like Modbus or Profibus use
> an idle gap between the transmitter characters (typically lager 3 char
> length) as a new frame indicator. Also it is not possible to implement
> such a (slave) device in a linux userland application, there are a lot
> of devices which implement this scheme in hardware out there.  But I
> would appreciate if there is some other way to activate it from
> usermode applications.
>
> I think a more general way is an implementation using hrtimers, which
> also can implement delay_rts_before_send.
>
> An other point I don't understand is why ATMEL_US_TXEMPTY interrupt is
> used when in RS485 mode insted of the normal ATMEL_US_TXRDY or
> ATEM_US_ENDTX interrupts. In the RS485 mode the AT91 USART will
> connect the RTS pin to the internal TXEMPTY signal to drive the RTS
> until the last bit is shifted out. But this should not have any affect
> on ow the drive will pump out the bytes to the USART's transmit hold
> register?
>
> I'm happy if anyone can give me some explanation on this topics.
>
> Regards from Germany
>
>    Guido Classen
>
>

Hi Guido.

Sorry for my late response.

I looked at the code, and I understand and agree with your concerns.

The RS485 support for atmel_serial went through several refinements
before being merged, so it is now hard to understand who implemented a
specific line and figure out the reason.

[The whole list of authors is available on commit number
e8faff7330a3501eafc9bfe5f4f15af444be29f5, and I'm going to send them an
email to join this thread of discussion. ]

Since this implementation is already in use in production systems (based
on either AVR32 and ARM), we have to pay attention to properly test any change.

Summarizing your email, you are suggesting to:

  - Add the unit of measure (i.e., milliseconds) in the documentation
    serial-rs485.txt (it's already available in the header file).
    This is straightforward.

  - Set delays using msleep (as in the cris driver) rather than using
    TTGR. This change is trivial too. Unfortunately, however, I don't
    have any hardware to test it at the moment. This means that we will
    need some help for a proper testing.

  - Add a specific ioctl to get/set TTGR. Looking at the existing code, I
    didn't see any specific ioctl to set it. Since this functionality may
    be available on other drivers, and since it is not strictly related
    to RS485 mode, I guess that we should add general ioctls for serial
    drivers. In this case, we need the agreement from the rest of the
    community.

The following patch should take into account all these changes.

Best regards,

	Claudio


Subject: atmel_serial: use msleep for delays
From: Claudio Scordino <claudio@evidence.eu.com>

This patch:

  - Adds the unit of measure (i.e., milliseconds) in the documentation
    serial-rs485.txt (it was already available in the header file).

  - Sets delays using msleep (as in the cris driver) rather than using
    TTGR.

  - Adds two generic ioctls to get/set transmitter timeguards in serial drivers

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Guido Classen <clagix@gmail.com>
---
  Documentation/serial/serial-rs485.txt |    4 ++--
  drivers/tty/serial/atmel_serial.c     |   33 +++++++++++++++++++++++++--------
  include/uapi/asm-generic/ioctls.h     |    2 ++
  3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/Documentation/serial/serial-rs485.txt b/Documentation/serial/serial-rs485.txt
index 41c8378..e30335d 100644
--- a/Documentation/serial/serial-rs485.txt
+++ b/Documentation/serial/serial-rs485.txt
@@ -110,10 +110,10 @@
  	/* or, set logical level for RTS pin equal to 0 after sending: */
  	rs485conf.flags &= ~(SER_RS485_RTS_AFTER_SEND);
  
-	/* Set rts delay before send, if needed: */
+	/* Set rts delay before send (in milliseconds) if needed: */
  	rs485conf.delay_rts_before_send = ...;
  
-	/* Set rts delay after send, if needed: */
+	/* Set rts delay after send (in milliseconds) if needed: */
  	rs485conf.delay_rts_after_send = ...;
  
  	/* Set this flag if you want to receive data even whilst sending data */
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 922e85a..9a7e525 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -30,6 +30,7 @@
  #include <linux/serial.h>
  #include <linux/clk.h>
  #include <linux/console.h>
+#include <linux/delay.h>
  #include <linux/sysrq.h>
  #include <linux/tty_flip.h>
  #include <linux/platform_device.h>
@@ -58,6 +59,9 @@
  #define SUPPORT_SYSRQ
  #endif
  
+/* Maximum value of TTGR according to Atmel datasheet */
+#define MAX_TTGR_VALUE		255
+
  #include <linux/serial_core.h>
  
  static void atmel_start_rx(struct uart_port *port);
@@ -98,6 +102,7 @@ static void atmel_stop_rx(struct uart_port *port);
  #define UART_PUT_BRGR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_BRGR)
  #define UART_PUT_RTOR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_RTOR)
  #define UART_PUT_TTGR(port, v)	__raw_writel(v, (port)->membase + ATMEL_US_TTGR)
+#define UART_GET_TTGR(port, v)	__raw_readl((port)->membase + ATMEL_US_TTGR)
  
   /* PDC registers */
  #define UART_PUT_PTCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_PTCR)
@@ -228,8 +233,6 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
  	if (rs485conf->flags & SER_RS485_ENABLED) {
  		dev_dbg(port->dev, "Setting UART to RS485\n");
  		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-		if ((rs485conf->delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
  		mode |= ATMEL_US_USMODE_RS485;
  	} else {
  		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -304,9 +307,6 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
  
  	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
  		dev_dbg(port->dev, "Setting UART to RS485\n");
-		if ((atmel_port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port,
-					atmel_port->rs485.delay_rts_after_send);
  		mode |= ATMEL_US_USMODE_RS485;
  	} else {
  		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -549,7 +549,12 @@ static void atmel_tx_chars(struct uart_port *port)
  		return;
  
  	while (UART_GET_CSR(port) & atmel_port->tx_done_mask) {
+		if ((atmel_port->rs485.delay_rts_before_send) > 0)
+			msleep(atmel_port->rs485.delay_rts_before_send);
  		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
+		if ((atmel_port->rs485.delay_rts_after_send) > 0)
+			msleep(atmel_port->rs485.delay_rts_after_send);
+
  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
  		port->icount.tx++;
  		if (uart_circ_empty(xmit))
@@ -1232,9 +1237,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
  
  	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
  		dev_dbg(port->dev, "Setting UART to RS485\n");
-		if ((atmel_port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port,
-					atmel_port->rs485.delay_rts_after_send);
  		mode |= ATMEL_US_USMODE_RS485;
  	} else {
  		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -1370,6 +1372,7 @@ static int
  atmel_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
  {
  	struct serial_rs485 rs485conf;
+	u32 timeguard;
  
  	switch (cmd) {
  	case TIOCSRS485:
@@ -1387,6 +1390,20 @@ atmel_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
  			return -EFAULT;
  		break;
  
+	case TIOCSTXTG:
+		if (copy_from_user(&timeguard, (u32 *) arg, sizeof(timeguard)))
+			return -EFAULT;
+		if (timeguard > MAX_TTGR_VALUE)
+			timeguard = MAX_TTGR_VALUE;
+		UART_PUT_TTGR(port, timeguard);
+		break;
+
+	case TIOCGTXTG:
+		UART_GET_TTGR(port, timeguard);
+		if (copy_to_user((u32 *) arg, &timeguard, sizeof(timeguard)))
+			return -EFAULT;
+		break;
+
  	default:
  		return -ENOIOCTLCMD;
  	}
diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
index 143dacb..46cfdee 100644
--- a/include/uapi/asm-generic/ioctls.h
+++ b/include/uapi/asm-generic/ioctls.h
@@ -77,6 +77,8 @@
  #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
  #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
  #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
+#define TIOCGTXTG	0x5441 /* Get transmitter timeguard (if available) */
+#define TIOCSTXTG	0x5442 /* Set transmitter timeguard (if available) */
  
  #define FIONCLEX	0x5450
  #define FIOCLEX		0x5451
-- 
1.7.9.5

