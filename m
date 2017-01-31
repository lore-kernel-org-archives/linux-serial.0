From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 0/5] Serial slave device bus
Date: Tue, 31 Jan 2017 04:02:41 +0100
Message-ID: <20170131030241.kehmuuxsbnbk5nnt@earth>
References: <20170125202343.30923-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ahoigkmfqvrizowx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125202343.30923-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--ahoigkmfqvrizowx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 25, 2017 at 02:23:38PM -0600, Rob Herring wrote:
> Here's V3 of the serdev bus support with all the review feedback so far
> incorporated. Greg applied the first 4 patches already. I also found a
> problem in the tty_port_wakeup changes and have fixed that.
>=20
> I've added serdev support to the BT hci_ll.c driver as it turns out it wo=
rks
> on newer TI chips too, but just needed firmware loading. That avoids the
> impossible mess of cleaning up the TI-ST driver, and it's in a much closer
> state to being ready for upstream. I've sent that out separately.
>=20
> Changelog is in individual patches. Previous versions are here[1][2]. This
> series and the mentioned drivers can be found here[3].
>=20
> Rob
>=20
> [1] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1304151.h=
tml
> [2] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1311650.h=
tml
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serial-b=
us-v4

I rebased my nokia bluetooth driver on top of [3]. It's not yet
working, but everything added by this patchset (and
"bluetooth: hci_uart: add serdev driver support library") seems
to work as expected, so for the whole series:

Tested-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--ahoigkmfqvrizowx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliP/k4ACgkQ2O7X88g7
+pogSg//Zy/hPlEc3B6QQWL6PvbUNcKzpYOeAA89HaZpbIa5cOSBmPMbVK3v83a+
XWWFj+n+bOrjSgs5bVozeizgDcNwaeoPer7NFSrPm0Nt4pTDd6eNRvxuuDPSp1m/
3FI2wR59W28D8HegD1Eh156KdaSOak1yjLNWqklv5lOPBaU21H7XVpy5wLGVYt5S
d+i1Iy6yZZ9+RZDTcpPKpZzhqVWJWFgkR/SlQvqr0YsRWqObYqUl0Q7Dt5EsMtsJ
WNWD+olxdr2FiSS3UcRgkDXqeylPvHFyGEICT3AWPSZts6NeBBJiczWZbPFId+fB
jOYkltgbcQ1aYXjh/bL67QBnlIHFuqx1jTmBifj6s9zgmQqlnfySza+K9v9g1Rs5
ZYjcBdVzTHxuKIX384RDC0KvEf6IhZm7yCZHvwimiRmRu1NtKZe6wXEzfTLxqH3b
lpCB2qcEEJh6z765XnHszqVJyf0YPdyPAFaew1k/qu6kM+qE7KTaOhEEi70cy5jM
kmAbVSfBbdNckDxUesemN50zAjfj1uTmbpXcrtGdj1942nqv9UuXhgIjq6jHMImj
g4SHVHD2EDN+SLm3WqaBNbJ0iXakYaqu8tG2E9iYEaGkI/J0VwbNVXf58q5HOGff
PhEqMRbmm52C6Ecr2scSCs2fvDB6zV7EjbGH9Je01IrslaS9uRE=
=Vymv
-----END PGP SIGNATURE-----

--ahoigkmfqvrizowx--
