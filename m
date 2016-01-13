From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] serial: earlycon: Add device-tree support for
 earlycon on Tegra
Date: Wed, 13 Jan 2016 18:32:54 +0100
Message-ID: <20160113173254.GU2588@ulmo>
References: <1452594809-17972-1-git-send-email-jonathanh@nvidia.com>
 <20160113160340.GJ2588@ulmo>
 <569687B2.9090609@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y/tKdvIWQpFGRg6x"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <569687B2.9090609-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--Y/tKdvIWQpFGRg6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2016 at 05:21:54PM +0000, Jon Hunter wrote:
>=20
> On 13/01/16 16:03, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Tue, Jan 12, 2016 at 10:33:26AM +0000, Jon Hunter wrote:
> >> For Tegra the early console is support by passing the console informat=
ion
> >> via the boot parameter earlycon. This series allows us to use the
> >> device-tree "stdout-path" property for early console (as well as the
> >> console) on Tegra.
> >>
> >> Jon Hunter (3):
> >>   serial: earlycon: Add device-tree support for other IO types
> >>   serial: 8250_early: Add support for regshift
> >>   serial: 8250_early: Add earlycon support for Tegra
> >>
> >>  drivers/of/fdt.c                     | 26 +++++++++++++++++++++++-
> >>  drivers/tty/serial/8250/8250_early.c | 38 ++++++++++++++++++++++++++-=
---------
> >>  drivers/tty/serial/earlycon.c        |  6 ++++--
> >>  include/linux/serial_core.h          |  3 ++-
> >>  4 files changed, 59 insertions(+), 14 deletions(-)
> >=20
> > The series:
> >=20
> > Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Thanks. However, Peter Hurley also has a series he just refreshed from
> early last year that includes similar changes to patches 1 and 2 [0]. So
> I will probably drop these and just re-post patch 3 once his series is
> merged.

Okay, sounds fine.

> > Jon, do you have plans on adding the stdout-path properties to existing
> > device tree files?
>=20
> I think that it would be a good idea and so I could include that in a
> series with patch #3.

Sounds good.

Thanks,
Thierry

--Y/tKdvIWQpFGRg6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWlopFAAoJEN0jrNd/PrOhv+sP/2HYb4QB17E+hbDhiSIGe3G2
0IkarHVtXNUjGWmZ0nLjtpZZd/A9hAfPqIISpKQqNgKEwAd7il3rlm7hGey05k/G
sQmmJUt1o7ewqeD+pj0P4MGyVUQDpeEaV/kAmk8YsYS4quOSk+2b658+7C3EFDSH
HYu+S+t36OKsZxVgF0Oepmrm6lQsOd1KQ7MJ96FnQim4xCWwGxw7mk8gh+kddDEI
TOoqMZxRsQRFBwYEOlOV3wKdeFnGil6m8yKqSsYaPnyzkEcLeXdS9XWk3iYLwfae
iuUyxp+3/R6VGlulo+o7kQHibe7e0sLZtgUsMvk2Q3/C3IsmNW98//kax2lzasYd
E8Ee3NpueaFzstKEXD3kLuZZQ6bRm+WfKOrtKxEE113EdH/SP+Z8l2GpqC+52P7v
xcLcCoLAJLJqPmimC4atul8/aCuky5uttdHrL5SwjGHWVweHoa6m6hkxwPzV+xBu
RVQvr3jBIj4mGyKFKJJkSzN4EmACvVjE5lSZ+vzsIVxKFMHrED1ZbE2C/hi3wBRM
e3ERy8paNxciwlI1mzBW9KhbF2V2VPW3ubPg/dxpSjRv2xe1jejo0vTOTTw3/xMa
TqTeATtBLBeFPMY0VAdfiQVruv9cDZDBL69GFZsAiCcKfQu5J1/C5/WHVrDyCCcg
anphWruU7i5a50HJdFMt
=/M+U
-----END PGP SIGNATURE-----

--Y/tKdvIWQpFGRg6x--
