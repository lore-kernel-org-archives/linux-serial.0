From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 6/8] serial: Add Tegra Combined UART driver
Date: Mon, 2 Jul 2018 15:18:51 +0200
Message-ID: <20180702131851.GH13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-7-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-7-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:31PM +0300, Mikko Perttunen wrote:
> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> multiplexing multiple "virtual UARTs" into a single hardware serial
> port. The TCU is the primary serial port on Tegra194 devices.
>=20
> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> are part of Tegra HSP blocks that are already controlled by the Tegra
> HSP mailbox driver.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>=20
> Notes:
>     v2:
>     - Removed (void) casts for unused variables.
>     - Changed the uart_set_options() call to be on one line, even if its
>       over 80 characters.
>     - Added defines for magic numbers.
>     - Style fixes.
>     - Changed Kconfig entry to depend on the Tegra HSP driver instead of
>       just the mailbox framework.
>    =20
>     v3:
>     - Removed FLUSH bit, as it's unnecessary and slows down printing
>     - Removed call to uart_set_options
>     - Added mbox_free_channel calls to remove()
>=20
>  drivers/tty/serial/Kconfig       |   9 ++
>  drivers/tty/serial/Makefile      |   1 +
>  drivers/tty/serial/tegra-tcu.c   | 291 +++++++++++++++++++++++++++++++++=
++++++
>  include/uapi/linux/serial_core.h |   3 +
>  4 files changed, 304 insertions(+)
>  create mode 100644 drivers/tty/serial/tegra-tcu.c

The driver looks good to me. But for my own understanding, is there some
way we can make use of the multiplexing? That is, could we add a
mechanism to have the driver filter out only a specific stream? Could we
also specify which stream to send data back to? What happens by default?
Which stream is data sent to?

Thierry

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6JjsACgkQ3SOs138+
s6Eocg//ecQc8Nx/NJvOletPxaThwcsEtINjIWHInHZq6CzmY/lrvS9ewzqWHocv
xV+qUziWgRY5i8LUnQ/bPnCRRHP3oEZQOhAigZCK4sZX17LyaL/RMFqcT61+Umlv
pE98vpYGeBFKt92VMv3ou5pKNQH/CM9CM0pVhhUSlm7LCgy3M4PZqxPApSCdbWLw
MoQE4Ex0E5uZr5L7x/S9V5xz051pey3vfTziOvZj8FasXSZZtoZ0zIEkuzKO25q+
2XYSH0j2Xihfp9bvOcO70pVAPykSLYF0QYqmoFH6apJnwomSEYYompC67BXUYOit
0l8NXCED1RG6a3mkCU9fr/tfcyKoz83iADrJv3gNI3QJhWFWduIEaSQS8rqeHZSn
e2cXirbqp28L3PVmOKWbKuDQY0/Uow7eLZw+ckd8PBXsOTDPdsdjm12IyGEEKugJ
NPBtX6oQms2hauvJGAvv6hb1XZafTeiaF7fMXzOQJVNL1owNPx5dd908XFLP6ca0
HVuq5pq+T/sFuM0yyX4zHbTKHWu1+DkManiN8AQw3V42LbN6/3GdGx7+PbYHVdCA
9gFUv28cY5uq+Dju5BSOi3tPMcv7gNxWhb2EPOImR+0UND+ET7DzVLLkhK6dUZsL
nHx/r0HX0CnHn8o2243Jb6KIzvmuqkbbE3jEOlgSedC34qH56Os=
=+LfL
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
