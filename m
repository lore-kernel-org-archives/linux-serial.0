From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 04/14] serial: tegra: protect IER against LCR.DLAB
Date: Tue, 13 Aug 2019 11:46:35 +0200
Message-ID: <20190813094635.GI1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-5-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565609303-27000-5-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Ahung Cheng <ahcheng@nvidia.com>
List-Id: linux-serial@vger.kernel.org


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:13PM +0530, Krishna Yarlagadda wrote:
> From: Ahung Cheng <ahcheng@nvidia.com>
>=20
> The IER and DLH registers occupy the same address space, selected by
> the LCR.DLAB bit. Hence, add port lock to protect IER when LCR.DLAB bit
> is set.
>=20
> Signed-off-by: Ahung Cheng <ahcheng@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ShvoACgkQ3SOs138+
s6ELYg/+O1adqcMU5/CWtP2Mlzii/9QsLg7Ocr3E1iAHX1QgRkmcf85BzjkgPUt1
2T6erGS1mdXQFtlWADtskxzCWdKeOoUlKAdPmbApwB0QF+ELBUhjbOGfRS1vUg6I
/9jeiW70PL9cvuw1/X2E/hIwMTNPWmKfnvP+ONzUwlwQ2Kw98FoW9zbNAUlPgS1B
tj61fXIFNgNhVL2PbAUsWXfakFADl/X4dGxs+pDLOL61xUi4Ag4CXhS6tGckEKwS
6alqh/cxVmOl4OFAdaTo5dUX3rZ91dAg7Q420SjpkzVZBqxuj5lW2yHLetYVyXXZ
4LX/QOa7wSo8ImnnxhcNJQcEyL6DxP1szp2Cpp077tfokinqLg7jd1wf+PYJgRcU
8hE2XwpiUOg2+MHCZ2seseQ16zBJIgwI4CW+hmQJaxDeO45TCObZVD2Q/UqT+pFC
s8RnxF33IpYatRaIFrrDMJNOrg0+hPbZQlip2epvheR5uXNmtGVX9D9hIlnaaGLj
VfFr04huq6qaW8VPzYjWNnFQaclFHCt5OLJqa7KUHZlmGD6GB2XPiJIcuQ/MEoBd
iZDvcHNDuonVWu7YlDqaj+Zk+AU/mstYsNjF+j9mdwKbg3/UI61YCvtXLRTgNUmX
A5lpw2v9X1xdro8y9hJ6vKDQCaRSgwxd5nf7KCkNnRtQ6HOgefw=
=itlT
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--
