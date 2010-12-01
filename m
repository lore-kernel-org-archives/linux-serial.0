From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] 8250: add a UPIO_DWAPB32 for 32 bit accesses (v2)
Date: Wed, 1 Dec 2010 17:17:00 +0000
Message-ID: <20101201171700.GF2898@pulham.picochip.com>
References: <1290436007-683-1-git-send-email-jamie@jamieiles.com>
 <20101201011758.GA21009@kroah.com>
 <20101201081044.GM4398@pulham.picochip.com>
 <20101201170125.GA30594@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45866 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab0LARRF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Dec 2010 12:17:05 -0500
Received: by wwa36 with SMTP id 36so7622818wwa.1
        for <linux-serial@vger.kernel.org>; Wed, 01 Dec 2010 09:17:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201170125.GA30594@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org

On Wed, Dec 01, 2010 at 09:01:25AM -0800, Greg KH wrote:
> On Wed, Dec 01, 2010 at 08:10:44AM +0000, Jamie Iles wrote:
> > --- a/drivers/serial/8250.c
> > +++ b/drivers/serial/8250.c
> > @@ -454,21 +454,40 @@ static void tsi_serial_out(struct uart_port *p, int offset, int value)
> >  		writeb(value, p->membase + offset);
> >  }
> >  
> > +/* Save the LCR value so it can be re-written when a Busy Detect IRQ occurs. */
> > +static inline void dwapb_save_out_value(struct uart_port *p, int offset,
> > +					int value)
> > +{
> > +	struct uart_8250_port *up =
> > +		container_of(p, struct uart_8250_port, port);
> 
> container_of, when the original code did a simple cast:
> 
> >  static void dwapb_serial_out(struct uart_port *p, int offset, int value)
> >  {
> >  	int save_offset = offset;
> >  	offset = map_8250_out_reg(p, offset) << p->regshift;
> > -	/* Save the LCR value so it can be re-written when a
> > -	 * Busy Detect interrupt occurs. */
> > -	if (save_offset == UART_LCR) {
> > -		struct uart_8250_port *up = (struct uart_8250_port *)p;
> > -		up->lcr = value;
> > -	}
> > +	dwapb_save_out_value(p, save_offset, value);
> 
> Because of that, are you sure this is correct now?  You might just be
> getting lucky due to the location of the pointer within the structure,
> but then the old code was wrong.
> 
> Either way, I don't feel comfortable with this, do you?
struct uart_8250_port is defined in drivers/serial/8250.c as:

struct uart_8250_port {
        struct uart_port        port;
        struct timer_list       timer;          /* "no irq" timer */
	...
};

So yes, I'm happy with the change but I could be missing something... I'm also 
happy to convert it back to a cast but container_of() feels a bit safer.  

I've just tried the patch below (on top of my previous patch) to convert all 
of the explicit casts (apart from the timer callbacks that take an unsigned 
long) to container_of() and that works fine on my board. Is this worth 
applying or would you rather I just keep the original cast?

Jamie

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index df43cc3..9839199 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -504,7 +504,8 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
 
 static void set_io_from_upio(struct uart_port *p)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)p;
+	struct uart_8250_port *up =
+		container_of(p, struct uart_8250_port, port);
 	switch (p->iotype) {
 	case UPIO_HUB6:
 		p->serial_in = hub6_serial_in;
@@ -1344,7 +1345,8 @@ static inline void __stop_tx(struct uart_8250_port *p)
 
 static void serial8250_stop_tx(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 
 	__stop_tx(up);
 
@@ -1361,7 +1363,8 @@ static void transmit_chars(struct uart_8250_port *up);
 
 static void serial8250_start_tx(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 
 	if (!(up->ier & UART_IER_THRI)) {
 		up->ier |= UART_IER_THRI;
@@ -1389,7 +1392,8 @@ static void serial8250_start_tx(struct uart_port *port)
 
 static void serial8250_stop_rx(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 
 	up->ier &= ~UART_IER_RLSI;
 	up->port.read_status_mask &= ~UART_LSR_DR;
@@ -1398,7 +1402,8 @@ static void serial8250_stop_rx(struct uart_port *port)
 
 static void serial8250_enable_ms(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 
 	/* no MSR capabilities */
 	if (up->bugs & UART_BUG_NOMSR)
@@ -1807,7 +1812,8 @@ static void serial8250_backup_timeout(unsigned long data)
 
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	unsigned long flags;
 	unsigned int lsr;
 
@@ -1821,7 +1827,8 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 static unsigned int serial8250_get_mctrl(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	unsigned int status;
 	unsigned int ret;
 
@@ -1841,7 +1848,8 @@ static unsigned int serial8250_get_mctrl(struct uart_port *port)
 
 static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	unsigned char mcr = 0;
 
 	if (mctrl & TIOCM_RTS)
@@ -1862,7 +1870,8 @@ static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void serial8250_break_ctl(struct uart_port *port, int break_state)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	unsigned long flags;
 
 	spin_lock_irqsave(&up->port.lock, flags);
@@ -1916,7 +1925,8 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 
 static int serial8250_get_poll_char(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	unsigned char lsr = serial_inp(up, UART_LSR);
 
 	if (!(lsr & UART_LSR_DR))
@@ -1930,7 +1940,8 @@ static void serial8250_put_poll_char(struct uart_port *port,
 			 unsigned char c)
 {
 	unsigned int ier;
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -1964,7 +1975,8 @@ static void serial8250_put_poll_char(struct uart_port *port,
 
 static int serial8250_startup(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	unsigned long flags;
 	unsigned char lsr, iir;
 	int retval;
@@ -2192,7 +2204,8 @@ dont_test_tx_en:
 
 static void serial8250_shutdown(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	unsigned long flags;
 
 	/*
@@ -2261,7 +2274,8 @@ void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          struct ktermios *old)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
 	unsigned int baud, quot;
@@ -2461,7 +2475,8 @@ serial8250_set_ldisc(struct uart_port *port, int new)
 void serial8250_do_pm(struct uart_port *port, unsigned int state,
 		      unsigned int oldstate)
 {
-	struct uart_8250_port *p = (struct uart_8250_port *)port;
+	struct uart_8250_port *p =
+		container_of(port, struct uart_8250_port, port);
 
 	serial8250_set_sleep(p, state != 0);
 }
@@ -2594,7 +2609,8 @@ static void serial8250_release_rsa_resource(struct uart_8250_port *up)
 
 static void serial8250_release_port(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 
 	serial8250_release_std_resource(up);
 	if (up->port.type == PORT_RSA)
@@ -2603,7 +2619,8 @@ static void serial8250_release_port(struct uart_port *port)
 
 static int serial8250_request_port(struct uart_port *port)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	int ret = 0;
 
 	ret = serial8250_request_std_resource(up);
@@ -2618,7 +2635,8 @@ static int serial8250_request_port(struct uart_port *port)
 
 static void serial8250_config_port(struct uart_port *port, int flags)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 	int probeflags = PROBE_ANY;
 	int ret;
 
@@ -2799,7 +2817,8 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 
 static void serial8250_console_putchar(struct uart_port *port, int ch)
 {
-	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
 
 	wait_for_xmitr(up, UART_LSR_THRE);
 	serial_out(up, UART_TX, ch);
