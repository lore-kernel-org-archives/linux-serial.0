From: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] Make the Startech UART detection 'more correct'.
Date: Tue, 9 Sep 2003 12:23:12 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030909192312.GB1489@ip68-0-152-218.tc.ph.cox.net>
References: <20030909171859.D4216@flint.arm.linux.org.uk> <000701c37706$513a9a10$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fed1mtao07.cox.net ([68.6.19.124]:64698 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S264392AbTIITXO
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Sep 2003 15:23:14 -0400
Content-Disposition: inline
In-Reply-To: <000701c37706$513a9a10$294b82ce@stuartm>
List-Id: linux-serial@vger.kernel.org
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: 'Russell King' <rmk@arm.linux.org.uk>, tytso@mit.edu, 'Kernel Mailing List' <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, gallen@arlut.utexas.edu


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2003 at 03:12:30PM -0400, Stuart MacDonald wrote:
> From: linux-kernel-owner@vger.kernel.org=20
[snip]
> > I'd suggest something like:
> >=20
> > 	serial_outp(port, UART_LCR, UART_LCR_DLAB);
> > 	efr =3D serial_in(port, UART_EFR);
> > 	if ((efr & 0xfc) =3D=3D 0) {
> > 		serial_out(port, UART_EFR, 0xac | (efr & 3));
> > 		/* if top 6 bits return zero, its motorola */
> > 		if (serial_in(port, UART_EFR) =3D=3D (efr & 3)) {
> > 			/* motorola port */
> > 		} else {
> > 			/* ST16C650V1 port */
> > 		}
> > 		/* restore old value */
> > 		serial_outb(port, UART_EFR, efr);
> > 	}
> >=20
> > If you can guarantee that the lower two bits will always be=20
> > zero, you can
> > drop the frobbing to ignore/preseve the lower two bits.
>=20
> Does the Motorola chip have an ID register at all? Certainly using the
> fifo size is a weak test and should only be a last resort.

No, there is not an ID on the motorola duarts.

--=20
Tom Rini
http://gate.crashing.org/~trini/

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/XiigdZngf2G4WwMRAhpSAJsEqAP0xsifbgfzXJ1DzWEgVqH9KQCeOZzn
QV/mIBqayIuWbsXoy1tN+Ys=
=4re2
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
