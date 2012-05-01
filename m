From: NeilBrown <neilb@suse.de>
Subject: Re: Question:  How to power-manage UART-attached devices.
Date: Tue, 1 May 2012 10:12:10 +1000
Message-ID: <20120501101210.508190eb@notabene.brown>
References: <20120501082209.0b560708@notabene.brown>
	<4F9F178F.3030408@zytor.com>
	<20120501003420.028b57ec@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/l0YFVpK+6Xzry/kzbXpiHW5"; protocol="application/pgp-signature"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43361 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756584Ab2EAAMN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Apr 2012 20:12:13 -0400
In-Reply-To: <20120501003420.028b57ec@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

--Sig_/l0YFVpK+6Xzry/kzbXpiHW5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 1 May 2012 00:34:20 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mon, 30 Apr 2012 15:51:59 -0700
> "H. Peter Anvin" <hpa@zytor.com> wrote:
>=20
> > On 04/30/2012 03:22 PM, NeilBrown wrote:
> > >=20
> > > What I would really like is to integrate it closely with the state
> > > of the UART.  i.e. if the /dev/ttyO1 device is open, then the GPS
> > > is "on".  If not then it is "off".  Similarly if /dev/tty/O0 is
> > > open, bluetooth is "on", else "off". However I cannot find any way
> > > to "plug in" to the tty or serial drivers to perform an arbitrary
> > > action on first-open or last-close.  Is something like that
> > > possible? If not, is it a reasonable thing to ask? Any suggests
> > > about where to put such a hook?
> > >=20
> >=20
> > I don't think that's the right interface.  Just because the port is
> > currently open doesn't mean the device is active, nor vice versa.  ALL
> > it means is that someone currently has an access handle to it.
> >=20
> > Since a serial port models, well, a *port*, it is logical to think of
> > a (hypothetical) socket containing an RS-232 connector as well as a
> > power outlet.  Given that, it would be logical to drive the "power
> > connector" using the same type of interface used for the other parts
> > of an RS-232 control, meaning either with termios flags or via a
> > dedicated control ioctl (TIOCPOWER?).
>=20
> Actually several of our virtual tty interfaces treat open as meaning
> powered up. It's a fairly logical power management model. A lot of our
> real tty ports do the same as well and kill power on the last close.
>=20
> At the tty layer the tty_port helper callbacks port->activate() and
> port->shutdown() provide the needed functionality.
>=20
> You don't however want to be "hooking" this - your platform needs to
> provide its own versions of the relevant operations in the OMAP serial
> driver.

Hi Alan,
 thanks for the pointers.

 Looking at serial_core.c, which appears the be the gateway between tty_port
 and the OMAP serial driver, the activate() function it provides is a no-op,
 and the shutdown() function calls uport->ops->shutdown() (and a couple of
 other things).
 However there is  a uart_port_startup() which claims to be called
 once-per-open even though activate() doesn't call it (tty_operations.open()
 does).  And it calls uport->ops->startup().

 The omap-serial handlers for these are serial_omap_startup() and
 serial_omap_shutdown().  I think you are suggesting that I should plug in
 there somehow.  I wonder how.

 Maybe I could teach it to use a given GPIO as a 'DTR', and then write a
 separate driver which registers with gpiolib as providing an output GPIO a=
nd
 which responds to changes on that GPIO by turning the device 'on' or 'off'.

 Does that sound reasonably sane?

Thanks,
NeilBrown

--Sig_/l0YFVpK+6Xzry/kzbXpiHW5
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBT58qWjnsnt1WYoG5AQLBRg/+N4dqmPDUZXQR0MaHVgAdzeIOmnpCcRKT
t7BTD7wS/Lyu7RwLIGRiybPAhGU235RCu5kyAUkN9VVXQ4kZ/ZAn0FF8cDRciWo6
CQm/EawGeUCwv34vyD4tXgZTm5LP6brmlMY45/cfRrwXfbLsVUZuASPnqWAD+9Ec
XYkZZjhbA1LvjYnEJ+8arPzp2NflqxwEQ6Y1uVdKOMyit/u4e//S0D3+efCi+cVx
YNCckjWdchSZwsvkR+UPCdKkYQ4avRBTk9Swu/pDpNXla42OZitFz3rPA4vJr5rA
DulAn4BCB9ofOjjJirFMp/3z1QJD+zdP973RSoz4JYReOXOZ4sDilhffRN2xi60A
XI3JIQnXGEJLDum8b2cdNH/2l+bpKSpTVXX+Q4E2GQDq183F4yEGqSrKMp6M2w12
Lz9vegyqVkaGCKYrKfe1NnUrhEjyJjKS1eZl7VpLmZlW9gKVR2oVzG3r8g1oUWaT
m9OKwn7kOPrai7TAP5b2dMFqMzIGP7+LHCG9HlP9u8AZhkhtWYCpDeCCj4gCAMPi
WCBgKgij1iCfqds4oQRkP58akVNZekptlOimCgjSePWCLrlWqKqjfgqoLeY2OdSn
8y0CXnsfMP6rfwkti1XI6OB7VD/CYhdliEHJvokSlKdOwxh0rYL+LBMNQJJGUQxS
ZafFeY/Y2Hs=
=vQfJ
-----END PGP SIGNATURE-----

--Sig_/l0YFVpK+6Xzry/kzbXpiHW5--
