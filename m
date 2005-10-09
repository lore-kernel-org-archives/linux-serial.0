From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [patch 3/4] new serial flow control
Date: Sun, 9 Oct 2005 13:33:13 +0200
Message-ID: <20051009113313.GD5104@bouh.residence.ens-lyon.fr>
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr> <20051009000153.GA23083@flint.arm.linux.org.uk> <20051009002129.GJ5150@bouh.residence.ens-lyon.fr> <20051009083724.GA14335@flint.arm.linux.org.uk> <20051009100909.GF5150@bouh.residence.ens-lyon.fr> <20051009111718.GA13144@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailfe11.tele2.fr ([212.247.155.76]:32693 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932269AbVJILdV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Oct 2005 07:33:21 -0400
Content-Disposition: inline
In-Reply-To: <20051009111718.GA13144@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi,

Russell King, le Sun 09 Oct 2005 12:17:18 +0100, a =E9crit :
> On Sun, Oct 09, 2005 at 12:09:09PM +0200, Samuel Thibault wrote:
> > - some other use it as a strobe for acknowledging characters, some =
other
> > use it as a strobe for acknowledging frames (announced by CTS).
>=20
> The last has no business being in the serial driver though -
> the driver knows nothing about frames of characters.  It's more
> a userland (in which case it's TIOCM* ioctls) or ldisc issue
> (tty_driver->tiocmset).

In principle, yes. But implementing it in userland is not responsive
enough doesn't work reliably, while it can actually be implemented in
the serial driver as "acknowledge any CTS upfront" (if the device is no=
t
throttled), and then it works fine. Writing a whole line discipline (an=
d
getting it accepted in the kernel) just for this is a bit overkill.

> > > However, bear in mind that the majority of the more inteligent 82=
50-
> > > compatible UARTs with large FIFOs only do hardware flow control o=
n
> > > RTS/CTS
> >=20
> > Hardward flow control is usually performed in software. Can't their
> > hardware implementation of hardware flow control be disabled when
> > control method is not usual RTS/CTS?
>=20
> You missed the point.  Of course the hardware flow control can be
> disabled.  However, if you do have on-chip CTS flow control disabled
> with UARTs with large FIFOs,
> etc..

Yes, of course. But can't this be disabled too? (people won't mind cpu
overhead if they can at least get their device working).

Regards,
Samuel
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
