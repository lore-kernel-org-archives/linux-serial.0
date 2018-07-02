From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 5/8] mailbox: tegra-hsp: Add support for shared
 mailboxes
Date: Mon, 2 Jul 2018 15:13:00 +0200
Message-ID: <20180702131300.GG13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-6-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-6-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:30PM +0300, Mikko Perttunen wrote:
> The Tegra HSP block supports 'shared mailboxes' that are simple 32-bit
> registers consisting of a FULL bit in MSB position and 31 bits of data.
> The hardware can be configured to trigger interrupts when a mailbox
> is empty or full. Add support for these shared mailboxes to the HSP
> driver.
>=20
> The initial use for the mailboxes is the Tegra Combined UART. For this
> purpose, we use interrupts to receive data, and spinning to wait for
> the transmit mailbox to be emptied to minimize unnecessary overhead.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Notes:
>     v3:
>     - Added define HSP_INT0_IE_FULL_SHIFT
>     - Added Jon's Reviewed-by
>    =20
>     v2:
>     - Added defines for some register fields
>     - Simplified bit looping logic in interrupt handler
>     - Changed write done polling to use readl_poll_timeout
>     - Removed unnecessary zero assignments
>     - Fixed two error cases in probe to do proper cleanup
>=20
>  drivers/mailbox/tegra-hsp.c | 211 ++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 191 insertions(+), 20 deletions(-)

Looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6JNwACgkQ3SOs138+
s6GWoRAAjMSzFRnjIqmYTKNAlC3+zWjnHI329p0ETq4v9BEhKuDXsCKv490meKDp
+OFZOvgs7InvdNKX9sUmFYsiHNx7z0AjfyMhbLq2QqFQLJVxLG+h5I1oYdrhIaZ6
PIhOlQNEgrr5b7wYnj/2CvVtANCNB/3uw23gkhQVCvvV0V2SI/SFZzp+JvO4JUT6
KLSvQEGrmialeqaLvDi47nZswcrjh6w28O6YALiJHQWnx66dk3jQFxqS8Ck+4YXk
ihTUSlkG3Qy5PzZQQ/zFESL/S6bh9dLeUkGeFeigsV5B2sBBrcsffP0Sj2Ox3TIQ
LpFHSu9yXAsRRlSxWpeLDVox+AaTrzNNf+earyvItB9tAHKDl1mCLLqAuWrkKyye
AX1hvhLSuT2oXCfvtx/Xiw2XvI19gvXFtuAsMYb1S7fliIcEkuZqruLKT2yeOMLh
3alEYF1QYnVzh7JwInY16Kq7lJ2bHLBOZ01SFVFCAoyZR/Or/yVapoHaHk6LQMwW
vuYBZE7zCWw670+3OS7qRdIwhtt4S1qd5MAoodyu3oA8ZV0C052EhkXASEVG+d0r
QbJCpeNcTfbDnBUnANJ/saLmTe2EAGhmYN4NxR9VKNyH9oKjS9zVr2p42uNvruLq
z+xo5qXKOavNVYhVA93k4MQfEEASqltcqr90nE9/0KeO0u0rdDM=
=30K8
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
