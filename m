From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/9] serial: Add Tegra Combined UART driver
Date: Mon, 29 Oct 2018 11:11:03 +0100
Message-ID: <20181029101103.GA26393@ulmo>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <85092b49-2b62-bd76-05a3-521415835b6e@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <85092b49-2b62-bd76-05a3-521415835b6e@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Pessi <ppessi@nvidia.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mikko Perttunen <mperttunen@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>, Mika Liljeberg <mliljeberg@nvidia.com>, linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 11:04:06AM +0200, Pekka Pessi wrote:
> Hi Thierry,
>=20
> What is the use case for the mailbox driver? What kind of entity will be
> there consuming sent messages and sending messages to kernel?

This is currently only used for the TCU. I'm sure there could be other
cases, but we support none of the upstream at the moment. Are you aware
of any others that we need to take into account?

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvW3LcACgkQ3SOs138+
s6FRIw/+Pw2StMAnCWis5xYWoEvtLTttWYsHVBudkqmZVjFV9kcIODJnsRQU49gr
7wF4DlLbvPiA0Z+PzYw9wPYLRYNCmURdzY/o8AovrV5Fh6gJ3duWMSTGOt1XvEt4
17UEFyQKHO27J+IIhLFcLwc+Q+U9CVWX1AFb94o/tFJTdBLp28lkgH+uWR7rkBm5
L7g0Km2x74VTywGUwiuVof6mRwny7V3OqpluT85Ot6i0PXGfGSAZk1RwU12Pi1dJ
CcNnRMx0/f2/bY/f4CJF5kg3vgoLpr45hi8mZS4RqTCOXACnehELzTW2tX63t/nt
o2pp09x//EwgsoXNNKa4FCdbfQw2VgOcl+MbWrmPNXy4XgRp9+N8UX63rNxp3/Nd
ebyeADdTocSv/1hP0khItpIHvWdvyLCCUgqa3jEVV7+qPv9svgFhJ2rXNEv6j6iC
jQR1R4BFwrHyHilDJ2v+yjV1iNGn5qqFaDkaqT+4C+KtgQV8VNrCZ3AFgWAeHznp
biBoVP/1W4vuk46Ssk3JpzQqqrPN29mYPsiU5yKqzrmkPQMLN4UU19q2nY0RPO/i
7vMMdinA2R9UdtWKfkdumNULkwUGN3hdZqMRMqKO+03wxgKPC2oQPMzxFj31T2Wy
mjpYgAPX4JOjlWDO15An5iRykhcz4+XcWmHMUHUqnfT3SURKbS8=
=yi2X
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
