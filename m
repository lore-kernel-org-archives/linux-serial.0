From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Date: Mon, 2 Jul 2018 14:37:48 +0200
Message-ID: <20180702123748.GA13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-2-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-2-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:26PM +0300, Mikko Perttunen wrote:
> HSP interrupts can be routed through exposed "shared interrupts". These
> interrupts can be mapped to various internal interrupt lines. Add
> interrupt properties for shared interrupts to the tegra186-hsp device
> tree bindings.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>=20
> Notes:
>     v2:
>     - Edited commit message to not say that doorbell interrupts cannot be
>       routed to shared interrupts.
>     - Added tegra194 compatibility string.
>    =20
>     v3:
>     - Added Jon's A-b and Rob's R-b
>=20
>  Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6HJoACgkQ3SOs138+
s6Hn+A/+Odk5wqDMnlfiw/LHOl8gKOTI9dFik4nUtwIonK5a3l4mflfBpDcyEKmk
1I3Tz93choYczev+mmnh0DWDFWEFmXdKFUgU7mzGw2ZLvtlmYjpSTdigERg3MN9j
p8qFpHDf9Mg6FQJuba1znZbOwaTe6PAA6sOOUzaqSQ0AXqLBT4iWuxJioVDhis3/
ppyQXe2OcnukmDlTxzBK9rP/AZbnOkRgzQKyWKP8GMwNW72H5zuTI1T+BfMTsqni
DRck2GPEBM59j10XW9XR3FAizasV03z+AyZ+D2pASpAo1iwtnVIuh2JkxzCAu3RD
ep7aYVi+BP/AsJr/T1J2B6/50hJHu6ovwDtRaUQgSkINwqItv4aFbeaxy55HzE83
gPIYIoolgj5q/7B9hAUApkVH6UPKlrKGfbCBQN/6BilWHhZnQrqPSg3Ry+EusCma
6n/sIPHg5ZF8zV/nuu4DHcRlmmuUSEBNyb6VPuJuyabMMUWZ0p+hKymn4POvwpxR
xxO9I9dUvHFG2Q2YZ7QtFL533KTwWcrx8oQBg2LIv4g+FVGWUnEysqSfUpjIbpDi
YDfI+Xq0ckNrmft8rcOKfYmKOY8SGg8QFO2V6XA+lOIlRUv2Mke/z5qtXa9+ez28
YJsRgwMggua/pG4Yk9WxdT6sexZGdYFmUi6GhJB08K/CpAzHIPk=
=RaT6
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
