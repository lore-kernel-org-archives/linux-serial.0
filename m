Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743681;
	b=FTKPa9KbLUeKpCY/JFjw4iiDf100pmfAfWeSR1tIKxWVTleAygIOeHXtRoOgr345iVqu
	 XE0hR2eGqbWF2Bbqw02L3DKTWJqdLgAAc1W+0jrc1EuoItZvCt35YAIKYufnfrY7EzHOz
	 ZAbSZYCgZcI7LoY5w58fOC9AfqpYCKc9mDH6wtWi79TDF9uoO8iZ+AXJRF97JxYk0FUSd
	 MmMHESOqTIM19nsLJknw68HncPwkandcLm1KKNAMUXxPUR8Yl2aLcAqDjef8pjUJWm3uM
	 C6GnY3yFQGfMMJ/WFaWDuqGhZGWcIE7WsbmNNnMoqrjrR6RKAMdQV8WMMBoVFhlOIUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743681;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=LAf3EGIZ3UDRLTIol5vWBA35xQfNrglTSqSi1AKyLio=;
	b=BhSdGuowvyXK4EbEyaqiVs65KmMqnDDHU0LsKRwzi/Xbq6KU07tr1qGNuZuF0yDOR9Mv
	 t2E6541Py5P5X+CXNAFTRCD5OsDK/jbU5DgF6z+HbxialWrmfahTGxTVnIjiuarvDbYA0
	 Z6pv/b4OnvpLIk7529LX382Zwup/Q36YuuJ7wdpbKhomR81HED/cXn+wBOnACVtNQIYtV
	 IELQzTgHTK4izI8ziHfSdU85RPchJzJXEjnuwYhpL3Gd01TPhjw8G8H8Me3lyj0SVHnTb
	 yTBI5C4dBrQYwCq5/IAeGFHSQpdOwexD6Qz3cxu07VlGQDwavcho1VQhidYKoflb3Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD87606A32E;
	Tue,  3 Nov 2026 22:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AD87606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DDF3792009E; Tue,  3 Nov 2026 23:07:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D707792009C;
	Tue,  3 Nov 2026 22:07:58 +0000 (GMT)
Date: Tue, 3 Nov 2026 22:07:58 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    Johan Hovold <johan@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Karl Mehltretter <kmehltretter@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: [PATCH v3 2/2] serial: core: Don't clobber the baud rate on hangup
 via B0
In-Reply-To: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2611032050590.15685@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Requesting hangup via the B0 baud rate has this nasty side effect of 
clobbering the previously set rate for the port unless it happens to be 
9600bps or the port minimum rate if higher.  Consequently if there's a 
consumer still active at the other end, then it receives corrupt data 
from any other producers outputting messages to the port, such as 
init(8) or the kernel console.

There doesn't appear to be any particular reason for this clobbering 
other than that we have been doing it since 2.1.131, so take a saner 
approach and keep track of the most recently set baud rate and then use 
it whenever hangup has been requested.

There is one issue however with serial8250_console_restore(), possibly 
called from the NMI context on some platforms, in which case there is a 
concurrency issue owing to `port->mutex' not being held by the function.  
Consequently `port->hup_speed' could be written midway through an update 
being made by a termios call, causing the value saved to clobber the 
baud rate programmed into hardware with a later B0 rate selection.

Handle it by renaming uart_get_baud_rate() to uart_get_baud_rate_save() 
and giving the function an extra `save' parameter to control whether or 
not to have the baud rate saved in `port->hup_speed' that is returned by 
the function.  Then use that parameter to suppress saving when called by 
serial8250_console_restore(), observing that the call is only ever made 
to restore the baud rate most recently set.  Any concurrent interrupted 
termios call, once it has been passed control again, will then program 
hardware consistently with the value it may have written already or will 
otherwise write to `port->hup_speed'.

In the unlikely case `port->hup_speed' is zero where the B0 rate has 
been requested as the first one since the system boot for a non-console 
device, resort to the current default of max(min, 9600).

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Changes from v2, 
<https://lore.kernel.org/r/alpine.DEB.2.21.2610120231550.55767@angie.orcam.me.uk/>:

- Add a `save' parameter to uart_get_baud_rate() and rename the function 
  to uart_get_baud_rate_save().

- Add a uart_get_baud_rate() static inline wrapper for regular cases in 
  drivers such as handling termios calls.

- Use the `save' parameter appropriately in serial8250_get_baud_rate() to 
  handle serial8250_console_restore() calls.

Changes from v1, 
<https://lore.kernel.org/r/alpine.DEB.2.21.2605242242330.1450@angie.orcam.me.uk/>:

- Cache the most recently set actual baud rate in port->hup_speed and use 
  it whenever the B0 rate has been requested since the old termios may be 
  NULL or have the B0 rate recorded.
---
 drivers/tty/serial/8250/8250_port.c |    9 +++++----
 drivers/tty/serial/serial_core.c    |   25 ++++++++++++++++---------
 include/linux/serial_core.h         |   28 +++++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 16 deletions(-)

linux-serial-uart-get-baud-rate-hup.diff
Index: linux-macro/drivers/tty/serial/8250/8250_port.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/8250/8250_port.c
+++ linux-macro/drivers/tty/serial/8250/8250_port.c
@@ -2626,7 +2626,8 @@ static void serial8250_set_divisor(struc
 
 static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 					     struct ktermios *termios,
-					     const struct ktermios *old)
+					     const struct ktermios *old,
+					     bool save)
 {
 	unsigned int tolerance = port->uartclk / 100;
 	unsigned int min;
@@ -2651,7 +2652,7 @@ static unsigned int serial8250_get_baud_
 	 * slower than nominal still match standard baud rates without
 	 * causing transmission errors.
 	 */
-	return uart_get_baud_rate(port, termios, old, min, max);
+	return uart_get_baud_rate_save(port, termios, old, min, max, save);
 }
 
 /*
@@ -2842,7 +2843,7 @@ serial8250_do_set_termios(struct uart_po
 
 	serial8250_set_mini(port, termios);
 	lcr = serial8250_compute_lcr(up, termios->c_cflag);
-	baud = serial8250_get_baud_rate(port, termios, old);
+	baud = serial8250_get_baud_rate(port, termios, old, true);
 	quot = serial8250_get_divisor(port, baud, &frac);
 
 	/*
@@ -3339,7 +3340,7 @@ static void serial8250_console_restore(s
 		termios.c_ospeed = port->state->port.tty->termios.c_ospeed;
 	}
 
-	baud = serial8250_get_baud_rate(port, &termios, NULL);
+	baud = serial8250_get_baud_rate(port, &termios, NULL, false);
 	quot = serial8250_get_divisor(port, baud, &frac);
 
 	serial8250_set_divisor(port, baud, quot, frac);
Index: linux-macro/drivers/tty/serial/serial_core.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/serial_core.c
+++ linux-macro/drivers/tty/serial/serial_core.c
@@ -454,29 +454,32 @@ uart_update_timeout(struct uart_port *po
 EXPORT_SYMBOL(uart_update_timeout);
 
 /**
- * uart_get_baud_rate - return baud rate for a particular port
+ * uart_get_baud_rate_save - return baud rate for a particular port
  * @port: uart_port structure describing the port in question.
  * @termios: desired termios settings
  * @old: old termios (or %NULL)
  * @min: minimum acceptable baud rate
  * @max: maximum acceptable baud rate
+ * @save: whether to save the baud rate chosen
  *
  * Decode the termios structure into a numeric baud rate, taking account of the
- * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to 9600
+ * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to the
+ * previously saved rate provided by @port, or if this is unset, then 9600
  * baud or min argument, whichever is greater.
  *
  * If the new baud rate is invalid, try the @old termios setting. If it's still
  * invalid, clip to the nearest chip supported rate.
  *
  * The @termios structure is updated to reflect the baud rate we're actually
- * going to be using. Don't do this for the case where B0 is requested ("hang
- * up").
+ * going to be using, except where %B0 is requested ("hang up"). Likewise the
+ * @port structure, except where @save is %false.
  *
  * Locking: caller dependent
  */
 unsigned int
-uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
-		   const struct ktermios *old, unsigned int min, unsigned int max)
+uart_get_baud_rate_save(struct uart_port *port,
+			struct ktermios *termios, const struct ktermios *old,
+			unsigned int min, unsigned int max, bool save)
 {
 	unsigned int try;
 	unsigned int baud;
@@ -515,10 +518,14 @@ uart_get_baud_rate(struct uart_port *por
 		 * Special case: B0 rate.
 		 */
 		if (baud == 0)
-			baud = max(min, 9600);
+			baud = (port->hup_speed ?
+				port->hup_speed : max(min, 9600));
 
-		if (baud >= min && baud <= max)
+		if (baud >= min && baud <= max) {
+			if (save)
+				port->hup_speed = baud;
 			return baud;
+		}
 
 		/*
 		 * If the range cannot be met then try again with
@@ -548,7 +555,7 @@ uart_get_baud_rate(struct uart_port *por
 	WARN_ON(1);
 	return 0;
 }
-EXPORT_SYMBOL(uart_get_baud_rate);
+EXPORT_SYMBOL(uart_get_baud_rate_save);
 
 /**
  * uart_get_divisor - return uart clock divisor
Index: linux-macro/include/linux/serial_core.h
===================================================================
--- linux-macro.orig/include/linux/serial_core.h
+++ linux-macro/include/linux/serial_core.h
@@ -573,6 +573,7 @@ struct uart_port {
 
 	bool			hw_stopped;		/* sw-assisted CTS flow state */
 	bool			cons_flow;		/* user specified console flow control */
+	speed_t			hup_speed;		/* speed to use for B0 rate (hang-up) */
 	unsigned int		mctrl;			/* current modem ctrl settings */
 	unsigned int		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
@@ -1036,11 +1037,32 @@ enum UART_TX_FLAGS {
  */
 void uart_update_timeout(struct uart_port *port, unsigned int cflag,
 			 unsigned int baud);
-unsigned int uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
-				const struct ktermios *old, unsigned int min,
-				unsigned int max);
+unsigned int uart_get_baud_rate_save(struct uart_port *port,
+				     struct ktermios *termios,
+				     const struct ktermios *old,
+				     unsigned int min, unsigned int max,
+				     bool save);
 unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
 
+/**
+ * uart_get_baud_rate - return baud rate for a particular port
+ * @port: uart_port structure describing the port in question.
+ * @termios: desired termios settings
+ * @old: old termios (or %NULL)
+ * @min: minimum acceptable baud rate
+ * @max: maximum acceptable baud rate
+ *
+ * See uart_get_baud_rate_save() for more details.
+ */
+static inline unsigned int uart_get_baud_rate(struct uart_port *port,
+					      struct ktermios *termios,
+					      const struct ktermios *old,
+					      unsigned int min,
+					      unsigned int max)
+{
+	return uart_get_baud_rate_save(port, termios, old, min, max, true);
+}
+
 /*
  * Calculates FIFO drain time.
  */
