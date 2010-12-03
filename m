From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pl011: added clock management feature
Date: Fri, 3 Dec 2010 15:15:47 +0000
Message-ID: <20101203151547.GA30898@n2100.arm.linux.org.uk>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com> <20101109224012.GA21992@kroah.com> <AANLkTikUmq7qeFb+0XPpmzcvp5q_Z4SMjBaAgNZaCRqV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53377 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0LCPQS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Dec 2010 10:16:18 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikUmq7qeFb+0XPpmzcvp5q_Z4SMjBaAgNZaCRqV@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Grzegorz Sygieda <grzegorz.sygieda@tieto.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 03, 2010 at 12:47:14PM +0100, Vitaly Wool wrote:
> On Tue, Nov 9, 2010 at 11:40 PM, Greg KH <greg@kroah.com> wrote:
> > On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
> >> From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
> >>
> >> This patch allows to control the pl011 clock using set_termios
> >> callback. Any positive baudrate passed enables clock, otherwise
> >> disables. This saves a lot of power on submicron designs since
> >> we can clock off and disable unused UARTs.
> >
> > That's nice, but it seems like an overload of what people tradition=
ally
> > think of when it comes to baud rates. =A0Why not just power down po=
rts
> > that are not open instead?
>=20
> I like the idea as well and this is definitely gonna help conserving
> the power for Bluetooth UARTs.
>=20
> But using baud rate 0 is something I don't like.

You can't use the baud rate of 0 to power down ports - that already has
a POSIX-defined function (hang up).

> Why don't you stop
> the clocks if RTS is cleared? This would have allowed the line
> discipline driver to implicitly control the UART clock and there will
> be no risk of losing data, as well as no non-standard behavior
> involved. In fact, you'll be transparent to the upper layers in this
> case.

I've no idea what you're thinking, but you can't stop the UART clock
because RTS is deasserted - or DTR for that matter.  Neither of those
two define whether characters will be transmitted or received.

There are specialist protocols and devices out there which require
RTS and DTR to be held at certain non-standard states for them to work.
One range of devices are car OBD-II interfaces, where RTS controls the
L line and sometimes the TX/RX direction on the bidirectional K data
line.

Similar things are done with DTR, and there's protocols which use
DTR as a handshake.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
