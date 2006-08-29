From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: Serial custom speed deprecated?
Date: Tue, 29 Aug 2006 08:20:49 +0200
Message-ID: <20060829062049.GA18752@bitwizard.nl>
References: <20060827065210.GA6932@bitwizard.nl> <000901c6caac$478bfca0$294b82ce@stuartm> <20060828200918.GA959@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:29432 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751239AbWH2GUv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 02:20:51 -0400
Content-Disposition: inline
In-Reply-To: <20060828200918.GA959@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stuart MacDonald <stuartm@connecttech.com>, 'Rogier Wolff' <R.E.Wolff@BitWizard.nl>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, "'linux-os (Dick Johnson)'" <linux-os@analogic.com>, 'Krzysztof Halasa' <khc@pm.waw.pl>, 'David Woodhouse' <dwmw2@infradead.org>, linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>

On Mon, Aug 28, 2006 at 09:09:18PM +0100, Russell King wrote:

> So, while I whole heartedly agree with passing baud rates
> numerically, I do not think we need any of this inexact flagging
> nonsense provided we implement something as userland programs expect
> - iow, the POSIX behaviour.

I fully agree we should implement Posix behaviour. Wether that specifies
what userland programmers expect is where I disagree. 

If you happen to change RTS/CTS at the same time as you change baud,
the call will return succes, even though the most important part (for
you) of your call failed. Note that if the succes of the call depends
on the previous state of RTS/CTS. Thus the error will depend on
whatever happened before. This creates difficult-to-diagnose problems
for sysadmins. 

Anyway, this would not happen if the programmer had read the full text
of the POSIX spec. IMHO, most programmers have a good idea of the
filosopy, and program against that: If some call fails it returns
error.

Anyway, here I am again rambling against the Posix spec. But again:
we should implement POSIX as good as we can. Alan already did the
most important footwork. Good job!

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
