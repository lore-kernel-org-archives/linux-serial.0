From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [patch 3/4] new serial flow control
Date: Sun, 9 Oct 2005 12:09:09 +0200
Message-ID: <20051009100909.GF5150@bouh.residence.ens-lyon.fr>
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr> <20051009000153.GA23083@flint.arm.linux.org.uk> <20051009002129.GJ5150@bouh.residence.ens-lyon.fr> <20051009083724.GA14335@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailfe10.tele2.fr ([212.247.155.44]:24761 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750800AbVJIKJS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Oct 2005 06:09:18 -0400
Content-Disposition: inline
In-Reply-To: <20051009083724.GA14335@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi,

Russell King, le Sun 09 Oct 2005 09:37:24 +0100, a =E9crit :
> On Sun, Oct 09, 2005 at 02:21:30AM +0200, Samuel Thibault wrote:
> > Russell King, le Sun 09 Oct 2005 01:01:53 +0100, a ?crit :
> > > > How could this look like in userspace?
> > >=20
> > > I think they should be termios settings - existing programs know =
how
> > > to handle termios to get what they want.=20
> >=20
> > Hence a new field in the termios structure?
> >=20
> > There was a discussion about this back in 2000:
> >=20
> > http://marc.theaimsgroup.com/?t=3D96514848800003&r=3D1&w=3D2
>=20
> What I was thinking of was to use some of the spare termios cflag bit=
s
> to select the flow control.  You'd only want one flow control type at
> one time though.  Eg: define two fields, each to select the signal.
>=20
> 0 - RTS
> 1 - DTR
>=20
> 0 - CTS
> 1 - DTR
> 2 - DSR

It looks fine, but it might not be sufficient for expressing that:

- some flow control use RTS to indicate that DTE is ready to send data,
- some other use it to indicate that DTE wants to send data. (and CTS i=
s
used for acknowledgment of this),
- some other use it as a strobe for acknowledging characters, some othe=
r
use it as a strobe for acknowledging frames (announced by CTS).

> However, bear in mind that the majority of the more inteligent 8250-
> compatible UARTs with large FIFOs only do hardware flow control on
> RTS/CTS

Hardward flow control is usually performed in software. Can't their
hardware implementation of hardware flow control be disabled when
control method is not usual RTS/CTS?

Regards,
Samuel
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
