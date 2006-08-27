From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Serial custom speed deprecated?
Date: Sun, 27 Aug 2006 11:00:13 +0100
Message-ID: <20060827100013.GA25333@flint.arm.linux.org.uk>
References: <028a01c6c6fc$e792be90$294b82ce@stuartm> <1156411101.3012.15.camel@pmac.infradead.org> <m3bqqap09a.fsf@defiant.localdomain> <1156441293.3007.184.camel@localhost.localdomain> <m31wr6otlr.fsf@defiant.localdomain> <Pine.LNX.4.61.0608241635090.13499@chaos.analogic.com> <1156457501.3007.193.camel@localhost.localdomain> <20060827065210.GA6932@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:39696 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932080AbWH0KA2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Aug 2006 06:00:28 -0400
Content-Disposition: inline
In-Reply-To: <20060827065210.GA6932@bitwizard.nl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>, David Woodhouse <dwmw2@infradead.org>, Stuart MacDonald <stuartm@connecttech.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sun, Aug 27, 2006 at 08:52:11AM +0200, Rogier Wolff wrote:
> Once this is in place, you lose a lot of "figure out the baud rate
> integer from the B_xxx settings" code in all the drivers, as well as
> that we get to provide a new interface to userspace without having to
> change ALL drivers at the same time. This decouples the drivers from
> the kernel<->userspace interface.

This has been helped along by serial_core - drivers have helper
functions which they call (along with their min/max baud rate)
which handles all this stuff.

The one thing your idea is missing is how to handle the "user
requested 15mbaud but I can only do 115200baud" case - POSIX
prefers you to report back what you actually selected rather
than error out.  If you merely pass an integer to the drivers,
they can't do that.

Note also that some drivers effectively have run-time configurable
max baud rates, so you can't pass a fixed set of capabilities to
the tty layer on driver initialisation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
