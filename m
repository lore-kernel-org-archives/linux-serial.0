From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [patch 3/4] new serial flow control
Date: Sun, 9 Oct 2005 02:21:30 +0200
Message-ID: <20051009002129.GJ5150@bouh.residence.ens-lyon.fr>
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr> <20051009000153.GA23083@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932196AbVJIAVm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051009000153.GA23083@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Russell King, le Sun 09 Oct 2005 01:01:53 +0100, a =E9crit :
> > How could this look like in userspace?
>=20
> I think they should be termios settings - existing programs know how
> to handle termios to get what they want.=20

Hence a new field in the termios structure?

There was a discussion about this back in 2000:

http://marc.theaimsgroup.com/?t=3D96514848800003&r=3D1&w=3D2

and more precisely a remind of SVR4's termiox structure with an added
x_hflag:

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D96523146720678&w=3D2

I'm not sure about how we'd want to implement that. The SVR4 approach
(orthogonal input/output flow control selection) doesn't seem right to
me: there are really peculiar flow controls that involve both ways. A
mere enumeration of possible methods might be better.

Regards,
Samuel
