From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/8] mailbox: tegra-hsp: Refactor in preparation of
 mailboxes
Date: Mon, 2 Jul 2018 15:12:15 +0200
Message-ID: <20180702131215.GF13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-5-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-5-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:29PM +0300, Mikko Perttunen wrote:
> The HSP driver is currently in many places written with the assumption
> of only supporting doorbells. Prepare for the addition of shared
> mailbox support by removing these assumptions and cleaning up the code.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Notes:
>     v2:
>     - Moved fixes for some style and other issues from the next patch
>       here, where they belong.
>    =20
>     v3:
>     - Added Jon's Reviewed-by.
>=20
>  drivers/mailbox/tegra-hsp.c | 123 +++++++++++++++++++++++++++++---------=
------
>  1 file changed, 81 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 0cde356c11ab..5dc21a6d01bb 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify =
it
>   * under the terms and conditions of the GNU General Public License,
> @@ -42,6 +42,7 @@ struct tegra_hsp_channel;
>  struct tegra_hsp;
> =20
>  struct tegra_hsp_channel {
> +	unsigned int type;

I think it would've been slightly nicer to avoid the type member and the
differentiation made by having different mailbox operations for each
type, but since the mailbox operations are not per "channel", I don't
see how it could be done otherwise, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6JK8ACgkQ3SOs138+
s6GA7xAAwH1TEXunF1LxnJZIbfLflof9BNMD3GWFa/EngNCLESeAohJCuOaNR55h
x7GeAxsZlVodbMqfU7tVbuDSia2Yt6kgpjPvIlULbNhn2FkO9mSV61t8wV/u4zHX
ZmhB9QHTQBzkPCxbJPgZIjF9698Ei3mmF5a567crM3DQrQfnHwfgAogF0h6a0rOu
Pcpj6qjXbXapYnACG2zcG9WkfZeLYp0a8umLFDudKvwDHhJCRWLElg899GaeS8Do
FLo6tsODH0+D2NjGbMqDZDvzr0sULReq6oqh/+10JAn6FIRE8ETyZ5ngaj0s90H5
njAFzyQEagjQAt0DBlxyv3Z2E9ZUalz/gRx4g3i1X/oNTrcJVAEXenqFFsfk/Fup
YUlfKICA21Sk5+YT3BdaOhkhu2zR8iMdZxsWu5jI2fpeM1DGw91HLjmEXZd90jVV
HQ0z8DHE14wpZbw0674uN0hClUH8FBohIoL2ILNilaHArwS+fTvfeKzlhE4OBylG
RH5Bjjr79GUxEIJDZYZP3VcsAmvEfOJy26PF1OwU7wUvT2RwFEpjzM+tV7VX6jIo
cJM7tTN0hiLNkhBe9ETICGCDPTYenk3P8G0UPyMrhq9B8mVtVlfHKIcetxrap6Cd
xsQxiirIExJS14VrFiIkDcPXREvepX0sOvAr8bi/uqotaRCyATg=
=RHlv
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
