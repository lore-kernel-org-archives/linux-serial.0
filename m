From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/8] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
Date: Mon, 2 Jul 2018 14:51:54 +0200
Message-ID: <20180702125154.GD13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-3-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-3-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:27PM +0300, Mikko Perttunen wrote:
> Add bindings for the Tegra Combined UART device used to talk to the
> UART console on Tegra194 systems.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Notes:
>     v2:
>     - Added Rob's Reviewed-by.
>    =20
>     v3:
>     - Added Jon's Acked-by.
>=20
>  .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra=
194-tcu.txt

Acked-by: Thierry Reding <treding@nvidia.com>

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6H+cACgkQ3SOs138+
s6Ftgw/6Al7FwFrx9x0Bqz8/QSQwlP8RexRWeehUJgvEHfqeQvlUuDnGjbzykNwO
HaxhGzpGfckbwKqDAdbrkR1jLOdd/dckJBT1Qz7Co8orMhHcjxlHbmNV43t/t26w
r7qBzH5cM9FkC8vmMjNhRP3REOqDZ1HOuW2Zp4jgO9EeBKGfDWnBzAiyYLWVkH5n
Az1AEjSF5Rw54D7Mbt5EWGQ5oRp5waxyboz8D6qw5jVN6vHwudIM+3f2pNv7iIix
9aNJvJLOk+RAbce8vFOuATAc1N/7CSJhLVvBW97hXGt5cTECPMdb1jmqT8IkofrR
k+3PA+yacx0KLTf3vZXEWrqoAndJMd2XEJFJE1zm2BLZ/s4qvXAA6mZjVCKe8wIU
yKeE8aLcptG7WPgRfF7KI6UO11q9igpQ9FF2LMIUcn8snTFxbli4RqcjX2E6nShD
Mh1iApK4uu05AeKY4G9l4UFd7jFPBK2ajTeG/MprzF9Uyu+mjxCjlZvSZKo3jIAs
wsUkMNeuGap0yDxRdeco+lO1XBXtYWrnSk6twI59KV5IO0bj8nxZrKn2SBgVo5G+
QjvnocC7hno+Abx3xzB735rKnu+VNxH7HDIy3sj4smfwwtGrkwWy0wiSg8OUbtDB
XojFX8e0T14LttZnLKWshq8iAOuTl1lpwhOmMhKTaI+DrFdrRWY=
=1DhX
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
