From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Hang in uart_block_til_ready()
Date: Sun, 2 Apr 2006 17:42:40 +0200
Message-ID: <20060402154240.GB402@hansmi.ch>
References: <20060402135138.GC2954@hansmi.ch> <20060402143827.GA3565@flint.arm.linux.org.uk> <20060402151739.GA402@hansmi.ch> <20060402152350.GA5283@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:5405 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751221AbWDBPmm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Apr 2006 11:42:42 -0400
Content-Disposition: inline
In-Reply-To: <20060402152350.GA5283@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2006 at 04:23:50PM +0100, Russell King wrote:
> Have you checked the state of the DCD line in both cases?  Look in
> /proc/tty/driver/serial.

HP box:
2: uart:16550A port:000003E8 irq:4 tx:12888 rx:147 RTS|CTS|DTR|DSR

other box:
0: uart:16550A port:000003F8 irq:4 tx:18886 rx:299 RTS|CTS|DTR|DSR|CD

So, yes. The other box has CD set (unless CD is not DCD). It might be
that the serial cable used there does this, but I can't check it because
the box is several hundreds of kilometers away.

> Probably "works" on the first box because it happens to have DCD asserted
> on the real serial port.

Yes, that explains it.

Thanks for your help,
Michael

--=20
Gentoo Linux developer, http://hansmi.ch/, http://forkbomb.ch/

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEL/Dw6J0saEpRu+oRAub8AJ9h6iNsTdWY7OocjG/1oaZDKUrjpACfUJnJ
Q8v6Wyl6hXKlHQMLPYPLYaY=
=ag0l
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
