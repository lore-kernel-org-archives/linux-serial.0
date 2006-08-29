From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Serial custom speed deprecated?
Date: Tue, 29 Aug 2006 08:46:10 +0100
Message-ID: <20060829074610.GA29882@flint.arm.linux.org.uk>
References: <20060827065210.GA6932@bitwizard.nl> <000901c6caac$478bfca0$294b82ce@stuartm> <20060828200918.GA959@flint.arm.linux.org.uk> <20060829062049.GA18752@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:42770 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750808AbWH2HqZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 03:46:25 -0400
Content-Disposition: inline
In-Reply-To: <20060829062049.GA18752@bitwizard.nl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Stuart MacDonald <stuartm@connecttech.com>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, "'linux-os (Dick Johnson)'" <linux-os@analogic.com>, 'Krzysztof Halasa' <khc@pm.waw.pl>, 'David Woodhouse' <dwmw2@infradead.org>, linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>

On Tue, Aug 29, 2006 at 08:20:49AM +0200, Rogier Wolff wrote:
> On Mon, Aug 28, 2006 at 09:09:18PM +0100, Russell King wrote:
> > So, while I whole heartedly agree with passing baud rates
> > numerically, I do not think we need any of this inexact flagging
> > nonsense provided we implement something as userland programs expect
> > - iow, the POSIX behaviour.
> 
> I fully agree we should implement Posix behaviour. Wether that specifies
> what userland programmers expect is where I disagree. 
> 
> If you happen to change RTS/CTS at the same time as you change baud,
> the call will return succes, even though the most important part (for
> you) of your call failed. Note that if the succes of the call depends
> on the previous state of RTS/CTS. Thus the error will depend on
> whatever happened before. This creates difficult-to-diagnose problems
> for sysadmins.

I disagree.  POSIX recommends the following sequence when setting termios
modes:

	tcgetattr(fd, &termios);
	/* modify termios */
	if (tcsetattr(fd, &termios) == -1)
		/* whatever error handling, none of the modes worked */
	tcgetattr(fd, &real_termios);

and in that respect it's the classic negotiation between two differing
sets of code - the application asks for what it wants, and then requests
what it actually got.  It can then check real_termios to see if the
settings it actually got are compatible with what it wants to achieve.

For example, if it couldn't enable CRTSCTS, it might decide to use XON/
XOFF flow control instead.

If tcsetattr() were to return an error if _any_ mode failed, then you
wouldn't know if it failed because CRTSCTS wasn't supported, or the
baud rate, or maybe some other mode you asked for.  That's multiple
times worse, and it would actually result in lots of programs failing
just because one setting wasn't supported - and will result in more
sysadmins scratching their collective heads.

So, the key idea here is that fiddling with termios is a _negotiation_
between the application and the driver.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
