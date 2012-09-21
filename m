From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Fri, 21 Sep 2012 19:52:04 +0200
Message-ID: <CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
	<20120920190034.GB15609@n2100.arm.linux.org.uk>
	<CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
	<20120921162543.1ed18775@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36554 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab2IURwG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 13:52:06 -0400
Received: by wgbdr13 with SMTP id dr13so1624676wgb.1
        for <linux-serial@vger.kernel.org>; Fri, 21 Sep 2012 10:52:04 -0700 (PDT)
In-Reply-To: <20120921162543.1ed18775@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Fri, Sep 21, 2012 at 5:25 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Untested but I suspect the following may help

Nope it doesn't, it's not this part that goes wrong, it's the call to
tty_termios_encode_baud_rate() that is the problem, not how it
gets called. It's that function that fuzzes and "snaps" the baudrate
to some rough-fit speed and screws things up for me.

But I looked a bit at the patch as such.

It doesn't compile, but when I fix it like this:

> -               if (baud >= min && baud <= max)
> +               if (baud >= min && baud <= max) {
> +                       tty_termios_encode_baud_rate(tty, baud, baud);

s/tty/termios/

Then it compiles, but regresses.

What's going wrong is that the termios encoding of zero does
not happen anymore, for baudrate 0, i.e whereas we used to
encode 0 into termios and then return 9600 this encodes
9600 and returns 9600.

So if I handle baudrate 9600 specially instead like this it works:

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7d9fbb8..a2442fb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -351,8 +351,9 @@ uart_get_baud_rate(struct uart_port *port, struct
ktermios *termios,
 	else if (flags == UPF_SPD_WARP)
 		altbaud = 460800;

+	baud = tty_termios_baud_rate(termios);
+
 	for (try = 0; try < 2; try++) {
-		baud = tty_termios_baud_rate(termios);

 		/*
 		 * The spd_hi, spd_vhi, spd_shi, spd_warp kludge...
@@ -362,26 +363,27 @@ uart_get_baud_rate(struct uart_port *port,
struct ktermios *termios,
 			baud = altbaud;

 		/*
-		 * Special case: B0 rate.
+		 * Special case: B0 rate. Note: this breaks if the
+		 * device cannot support 9600 baud
 		 */
 		if (baud == 0) {
 			hung_up = 1;
-			baud = 9600;
+			/* Encode zeroes to preserve semantics */
+			tty_termios_encode_baud_rate(termios, 0, 0);
+			return 9600;
 		}

-		if (baud >= min && baud <= max)
+		if (baud >= min && baud <= max) {
+			tty_termios_encode_baud_rate(termios, baud, baud);
 			return baud;
+		}

 		/*
 		 * Oops, the quotient was zero.  Try again with
 		 * the old baud rate if possible.
 		 */
-		termios->c_cflag &= ~CBAUD;
 		if (old) {
 			baud = tty_termios_baud_rate(old);
-			if (!hung_up)
-				tty_termios_encode_baud_rate(termios,
-								baud, baud);
 			old = NULL;
 			continue;
 		}
@@ -392,11 +394,9 @@ uart_get_baud_rate(struct uart_port *port, struct
ktermios *termios,
 		 */
 		if (!hung_up) {
 			if (baud <= min)
-				tty_termios_encode_baud_rate(termios,
-							min + 1, min + 1);
+				baud = min + 1;
 			else
-				tty_termios_encode_baud_rate(termios,
-							max - 1, max - 1);
+				baud = max - 1;
 		}
 	}
 	/* Should never happen */

(FWIW Signed-off-by: Linus Walleij <linus.walleij@linaro.org> for the twoliner)

But as mentioned I get the same errors...

Yours,
Linus Walleij
