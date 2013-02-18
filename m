From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH V2 -firmware] rp2: Initial commit of Comtrol RocketPort
 2 microcode
Date: Mon, 18 Feb 2013 03:26:27 +0000
Message-ID: <1361157987.5374.546.camel@deadeye.wl.decadent.org.uk>
References: <bf2fff0541e90f31c9d92f1dbda5fa2b@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-JI1yD4gTmVXDJQOVVxPL"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47696 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754851Ab3BRD0p (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Feb 2013 22:26:45 -0500
In-Reply-To: <bf2fff0541e90f31c9d92f1dbda5fa2b@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>, grant.edwards@comtrol.com
Cc: dwmw2@infradead.org, linux-serial@vger.kernel.org


--=-JI1yD4gTmVXDJQOVVxPL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the slow response.

On Tue, 2013-01-29 at 10:54 -0800, Kevin Cernekee wrote:
> This is used by drivers/tty/serial/rp2.c.
>=20
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Signed-off-by: Grant Edwards <grant.edwards@comtrol.com>
> ---
>  WHENCE |    8 ++++++++
>  rp2.fw |  Bin 0 -> 63 bytes
>  2 files changed, 8 insertions(+)
>  create mode 100644 rp2.fw
>=20
>=20
> This is intended for the linux-firmware repo.
>=20
> Also available from: git://github.com/cernekee/linux-firmware rp2
>=20
>=20
> diff --git a/WHENCE b/WHENCE
> index 96142c2..c3971a2 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -2046,3 +2046,11 @@ Downloaded from http://linuxwireless.org/en/users/=
Drivers/carl9170
>  Licence: GPLv2. Some build scripts use the New BSD (3-clause) licence.
> =20
>  ------------------------------------------------------------------------=
--
> +
> +Driver: rp2 -- Comtrol RocketPort 2 serial driver
> +
> +File: rp2.fw
> +
> +Licence: Freely redistributable in any format, per Comtrol.

I'm afraid that's rather vague.  Can you provide a full statement of the
copyright holder and licence terms, e.g. "Copyright 20xy Comtrol.
Comtrol grants permission ..."?

Ben.

> +------------------------------------------------------------------------=
--
> diff --git a/rp2.fw b/rp2.fw
> new file mode 100644
> index 0000000000000000000000000000000000000000..a571e77925d479cbd4d17e72f=
49ee9b90bc8e2d7
> GIT binary patch
> literal 63
> zcmey?J@<(45y2S>T#8)1zuFib1SPo`9E2sgel;_4F>pEl?>v;&);Q52wGYhba7b-!
> NVQAvw-~s^-E&$nE6vO}k
>=20
> literal 0
> HcmV?d00001
>=20

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.

--=-JI1yD4gTmVXDJQOVVxPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUSGfY+e/yOyVhhEJAQqPKw//QpZZjEeHq2HZ6rvybjFgLn3GM46LvAe3
7NmAg6YY6o7bq9X9ntPn7uUlD3R4NDWdBzsQIpYF1pseIxFi2NDCkIk05NSZPkGc
6VSBWA1Am3DG2R2TVzfgUcaiobmF+wG/mVAOEwHgLvuuC81l2JOm1Hxt0C02j05G
T1rYcy7gzKSGzhmPAwgT18GWBY5239nVy/6tUlZGYDayPuamCAlk8sKaB/dqNy0y
Hv70xgLDmdcKdga5OBDlo94CdwjvaxT3cVy3haN38Wt3aG82fN5TTazYiVwrxUkA
R2xM3UVmVJRcK2j+RKOJBmN2l2nCt3Z4mjLWlYpQMI3NKflNJCciNdM4aTKPOT57
MR5vynRNELaGmcfpovtaEjYj9cvFKHgd1aG6weA3MCE5rmLbqe8aZ0Jdbo87yc5K
tNtYEuztacY+bIujtw3ZThQ2S6CmDZjtUZKxcf4q2ujWh1rYh0NFH2uALn5Anu0F
Cd01xvPeBny+Pvk9w2t/4YVshgeXdZRO37Q62jPJl0WSV1oaAZBbeql1Acdcifu7
2UUAIKUOUmAJ+cKHbQYjCGhqEa2r/m/ztWTe5JS1wMV2tk9zqzHRYKfDsWLU4mD3
17slEgikTNZUj05pNZHSh3uPSBYqsdfL1flafxhQjSRyMZi3e0sodWPr/v9ZLhwp
aAvXqULzD3k=
=yvcK
-----END PGP SIGNATURE-----

--=-JI1yD4gTmVXDJQOVVxPL--
