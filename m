From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] serial: earlycon: Add device-tree support for
 earlycon on Tegra
Date: Wed, 13 Jan 2016 17:03:40 +0100
Message-ID: <20160113160340.GJ2588@ulmo>
References: <1452594809-17972-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCKy2vjPBX+S/5dE"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452594809-17972-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--FCKy2vjPBX+S/5dE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2016 at 10:33:26AM +0000, Jon Hunter wrote:
> For Tegra the early console is support by passing the console information
> via the boot parameter earlycon. This series allows us to use the
> device-tree "stdout-path" property for early console (as well as the
> console) on Tegra.
>=20
> Jon Hunter (3):
>   serial: earlycon: Add device-tree support for other IO types
>   serial: 8250_early: Add support for regshift
>   serial: 8250_early: Add earlycon support for Tegra
>=20
>  drivers/of/fdt.c                     | 26 +++++++++++++++++++++++-
>  drivers/tty/serial/8250/8250_early.c | 38 ++++++++++++++++++++++++++----=
------
>  drivers/tty/serial/earlycon.c        |  6 ++++--
>  include/linux/serial_core.h          |  3 ++-
>  4 files changed, 59 insertions(+), 14 deletions(-)

The series:

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Jon, do you have plans on adding the stdout-path properties to existing
device tree files?

Thierry

--FCKy2vjPBX+S/5dE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWlnVcAAoJEN0jrNd/PrOhN7wQAIoi6dBpXk/TVhtox0UIVfmT
aeP49h6pdiERyh4qC3Q8MNjT5aIT82b6L+iiUIlPYceDECCTKJaLGxa5IBRAVVIE
QN20YvIaq8Uab6oqTPJYEi8su1J1jMOB9E5DSLx4WLrUAS9SadLG9TWUL1f/tYsA
fT8INaektPkUuAe4yjebPNl3C69kvdopMLuznUzVoXMYQQav0nZBllNnjM3bzaau
aOhSOhtvjhXYX3R8vnl+Oj6O0R/QvQ6q/eRqDaC4G2bW6XTOasSqDIt1X0rAtJDi
gyJm/pD4PUv0FlYq7msT/7D3U4Q09FN5cHV2kMmrDterfpY6OKpzkvBsYtieVizX
a00Rp82UUTr6nytWe9etDr99QAB6QrnX4yekDWz05LhgQAkTOJgZ9Yhvx9OQxtJF
sBYMGdwCtcaN0ZEK1HwmFKOF824zjLrm40DXF0HKCs4434DXSKVr7+qC5dxXxc2w
SaKnElpwf/dxtIIS5qh9oYIzZx+0dGRHN9IcgK2vUwkT0Mwq3pSVDoKluLbg9F9t
ysN/F9eO2i1edKGVcS+afxOHpevybQl7WPUIFIR6pVKXLNTcUFWyQtAdgxjUs3UY
vTpZsFS/xkW/qfROmEP4ENWNHSsKNHsZz+YMfj7j39wJYSzGe9kfX0LYYh5gt+nb
3STBnpGo4RNwkjyHuw+5
=ZJzZ
-----END PGP SIGNATURE-----

--FCKy2vjPBX+S/5dE--
