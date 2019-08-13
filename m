From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 01/14] serial: tegra: add internal loopback functionality
Date: Tue, 13 Aug 2019 11:38:32 +0200
Message-ID: <20190813093832.GF1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-2-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565609303-27000-2-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Abel <aabel@nvidia.com>
List-Id: linux-serial@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:10PM +0530, Krishna Yarlagadda wrote:
> From: Andreas Abel <aabel@nvidia.com>
>=20
> Add the internal loopback functionality that can be enabled with
> TIOCM_LOOP.
>=20
> Signed-off-by: Andreas Abel <aabel@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ShRgACgkQ3SOs138+
s6FvcA/+O460rdaqlCYb/O1T4GYVbOQkOb/QbYwx+jFmLZ1ZaX43C5NJ4d5vYmqc
Eo9HNlYUgKut+AewjxX1fkNSebJT3SB0OlzW8ynLKsvAvEuloi54J2DfiSTqcRqr
QfkpEb5mAjBV6124k69a8a4vIb3xtgyYtheBmRNmFDgWscPTzm5u5Pys1yaferWV
mWvRFDQivavI/KH/OiN4/bB+w92ukbYZkK4gumohJD02T6T7CTscHLJscW5CGTUj
DET5xdJPKUkDYiOaXSZWxkEyGojGCIIOMpZ+pASUyHI73JanVO3uXVT2lopo49px
zVGqkXGqVCL2VhlHgnzVq/H+q6n2/sxDdeOcwzln/9vB/0BEDg7OI2kn9LcFRwOc
ThnObc5zTHvzagJm4zfAj+kMmLBELAyNYPSXnoJl+/wHhbK9FJutyo7Ys9onuKIi
tq1W34LBiWa6QkTjZaMRX4oLL0p6oa5upyMy5DJ4iaaUCQHlUHtD48UA3SqVQxxY
BmOAtUTjYyDt/w7sg6Ci6cPMYiOTYPyqd7XwleVQnDsmYom9JU2pvaSC2XDdAH2U
oFIrnX/CtBU9XSD8PSDjTl0m9yFVDH7RJQM0LhF7+fEa/2IxqgfgH7Y1yPQZGtQS
nYa7ftvYSqSoz3QLGGOVZmrhYjOzDEOQ3uuH5HX5tPgPJISbAbU=
=KYrm
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
