From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [patch 3/4] new serial flow control
Date: Sun, 9 Oct 2005 13:44:06 +0200
Message-ID: <20051009114406.GE5104@bouh.residence.ens-lyon.fr>
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr> <20051009000153.GA23083@flint.arm.linux.org.uk> <20051009002129.GJ5150@bouh.residence.ens-lyon.fr> <20051009083724.GA14335@flint.arm.linux.org.uk> <20051009100909.GF5150@bouh.residence.ens-lyon.fr> <20051009111718.GA13144@flint.arm.linux.org.uk> <20051009113313.GD5104@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailfe10.tele2.fr ([212.247.155.44]:49568 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932259AbVJILoQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Oct 2005 07:44:16 -0400
Content-Disposition: inline
In-Reply-To: <20051009113313.GD5104@bouh.residence.ens-lyon.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Samuel Thibault, le Sun 09 Oct 2005 13:33:13 +0200, a =E9crit :
>=20
> Russell King, le Sun 09 Oct 2005 12:17:18 +0100, a =E9crit :
> > > Hardward flow control is usually performed in software. Can't the=
ir
> > > hardware implementation of hardware flow control be disabled when
> > > control method is not usual RTS/CTS?
> >=20
> > You missed the point.  Of course the hardware flow control can be
> > disabled.  However, if you do have on-chip CTS flow control disable=
d
> > with UARTs with large FIFOs,
> > etc..
>=20
> Yes, of course. But can't this be disabled too?

(I mean, the FIFOs)
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
