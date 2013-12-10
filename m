From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] serial: amba-pl011: fix race conditions during
 initialisation
Date: Tue, 10 Dec 2013 18:09:40 +0000
Message-ID: <20131210180940.GA19513@sirena.org.uk>
References: <1386670740-16914-1-git-send-email-tixy@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:49833 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab3LJSKJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Dec 2013 13:10:09 -0500
Content-Disposition: inline
In-Reply-To: <1386670740-16914-1-git-send-email-tixy@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jon Medhurst <tixy@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2013 at 10:18:57AM +0000, Jon Medhurst wrote:

> When a UART that is being used for a kernel console is also opened
> by user-side, e.g. for use as a terminal, then there are race conditions
> which can lead to terminal input being disabled and console output being
> corrupted. This small patch series fixes these.
>=20
> Jon Medhurst (3):
>       serial: amba-pl011: use port lock to guard control register access
>       serial: amba-pl011: factor out code for writing LCR_H register
>       serial: amba-pl011: preseserve hardware settings during initialisat=
ion

Given that this seems relatively easy to trigger when you know how and
renders the device non-functional perhaps this should be considered for
stable too?

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSp1jgAAoJELSic+t+oim9THMQAJqnNkkBAemHn1UhG45cQvrc
0aY7qtCsaHAgQX8hyJN4Pjij4JjlUOkVNXe8a32GsFQsucTDupL1ekzLTsdVSdWh
YdyO4vi48xBTtFqci67x0wPMV7HkD/GqyuxUA6RjQ9MX0BEmVgaNReYge5DhyYYS
oal+jDIn4+B0cirZ6swXWlS1RBL+RyqXcSHB7X8jQYJGMJK7V6VScjKAmEWvau7L
v6F+lp3jVYWI84U98EWqC0sU10Bxv2h2ii9PAmgtqac80HZLqQ8W0hZf3b0x8Eh+
C/ZqFJ23qH3FNm2nY2SmXaqtA6VtXSpYzO05UeHR7TV8MCyxsWJiUX+aMcJt0Ffp
EyyLdd7YDSDC7sTqByMKWqEcqsFwapfsssXquh4KaeuaFePT6hM/iH6IxNsmdNFf
0EjpXTgKEvkQ0tYviuuCRL+3m15C+2CfqUjQH4KSsHrCpUHn7IPlbitgX9VOfjxB
kqnpUyPW2At4/XFF2FyalEy4zXrWK/6IaJBgd11i+Gt0Z46JYFx7OsTQWTSZKFTu
u7+AAyqEGgIdaizzQqVE3xSCJan0DsXu7nii1Qv+UisbC6S5y94s5seZHBgR6GHp
Kp3Ak0uRQ+1lvb31bVi033RcpWOGBsxlv/XEISmj0r957c+PXwtMB5zG+hLcW4HJ
0QiNrAhBdrgW3OdTyD8l
=vyIV
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
