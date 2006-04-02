From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Hang in uart_block_til_ready()
Date: Sun, 2 Apr 2006 17:17:39 +0200
Message-ID: <20060402151739.GA402@hansmi.ch>
References: <20060402135138.GC2954@hansmi.ch> <20060402143827.GA3565@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:10013 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750819AbWDBPRl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Apr 2006 11:17:41 -0400
Content-Disposition: inline
In-Reply-To: <20060402143827.GA3565@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Russell

On Sun, Apr 02, 2006 at 03:38:27PM +0100, Russell King wrote:
> On Sun, Apr 02, 2006 at 03:51:38PM +0200, Michael Hanselmann wrote:
> > I've discovered a problem where I'm not sure wether it's an error in the
> > kernel or in the hardware.

> It's neither - it's a bug in your test program.  If you want "callout"
> semantics, open the port using O_NONBLOCK mode.

I've now patched screen(1) and it works, but one thing is amazing me.
The other computer I wrote about has the serial console on ttyS0 and
starting screen(1) on the serial console works. Here's the relevant
strace part:

screen-strace:open("/dev/ttyS0", O_RDWR|O_NONBLOCK) =3D 3
screen-strace.23801:open("/dev/ttyS0", O_RDWR) =3D 3

This doesn't work on the HP box with the serial console on ttyS2. After
adding O_NONBLOCK, it works. Here's the strace:

screen-strace:open("/dev/ttyS2", O_RDWR|O_NONBLOCK) =3D 3
screen-strace.31830:open("/dev/ttyS2", O_RDWR|O_NONBLOCK) =3D 3

Am I going correct that this is a bug in screen(1) and it only works on
the first box by some mysterious reason? Mabye some timing issue?

Thanks,
Michael

--=20
Gentoo Linux developer, http://hansmi.ch/, http://forkbomb.ch/

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEL+sT6J0saEpRu+oRAn+4AJ94evFRc3ahs7yUxgzq/5O1rxJrUACeNJVl
9Xga+rRT57jVpXKY+UkHpPE=
=QcPi
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
