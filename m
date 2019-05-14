From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] serial: sh-sci: disable DMA for uart_console
Date: Tue, 14 May 2019 17:54:51 +0200
Message-ID: <20190514155450.GB6508@kunai>
References: <1557762446-23811-1-git-send-email-george_davis@mentor.com>
 <CAMuHMdVaNWa=Q-7K-+_rM-8yYWB0-+4_o4hgACK6o-4BOrY07A@mail.gmail.com>
 <20190514153021.GC18528@mam-gdavis-lt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190514153021.GC18528@mam-gdavis-lt>
Sender: linux-kernel-owner@vger.kernel.org
To: "George G. Davis" <george_davis@mentor.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eugeniu Rosca <erosca@de.adit-jv.com>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Chris Brandt <chris.brandt@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Andy Lowe <andy_lowe@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Fixes: https://patchwork.kernel.org/patch/10929511/
> >=20
> > I don't think this is an appropriate reference, as it points to a patch=
 that
> > was never applied.
>=20
> I included it as a link to an upstream problem report similar to other co=
mmits
> that I previewed. The link provides the extra context that I was perhaps =
to
> lazy to note in the commit header.

We have a "Link:" tag for things like this, e.g.:

Link: https://patchwork.kernel.org/patch/10929511/


--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlza5MYACgkQFA3kzBSg
KbbkfQ/+PL1lLGOvBp4WLSQof0j9gnQWmDJDxCG61/wtuAsqm6CkBe4BlgZIhoDq
ZgOk6lcFvge3gPJPP+DOiPVa9Uebjx84+gJV8t/hJx5EkZ5d/VBzxLS9C74ae9KQ
yC1BN8slbFbu4aS4bzbOoYCOGjRq2Wh7Se6MtdV5pCHZA6DxV60KvbrwvgVD8DrT
2YgoyE5pVyou/2gn4FxoUVzKDPTxvFr7rTTcJLHdEBXiXxy5x+5gBIGsl0521+qy
XIsJdaQXkI1wyssp/gRrUhZiAf/Du8W9MW0g4vXTC0a7nX8O5ENKW23FyV6FrzoX
BpPl7ICCxAarMabDkaNvhlO+TCC8f88yhYaiZ8UZ2ZyzIg8MPGJBQ0jdOTOeWjkU
DoLS5eVr8C2N9jT6iFY/f2UI/RfJlCx2gjdpgX23dUtn2uAkGjeFke4hXN0hmNnF
HYHyfTDOODnfnM3QzowRGaMOHE9nVcUcTcR5VKK8M0GtnzKHr8yBzfFJJkfKeiHi
CLjR9N37CcCUCKe5qDhIxwnmkXjJoUp6rgZxAS2hewGiv/CKi0WtfCvk6BzEkUV9
Eg3rZ1Ipeqt0fSHK4EK4ltIrs+iSZp+nhx7W61UE2teWQ6IG+weOdVvBCHpe9FUN
6RMlFFMcVzfvFKw2z+Q8uua9EPlKFFnUe7SAbydWO7d81KNyUGI=
=BcaQ
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
