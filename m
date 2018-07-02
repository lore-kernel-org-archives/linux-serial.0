From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 0/8] Tegra Combined UART driver
Date: Mon, 2 Jul 2018 16:03:43 +0200
Message-ID: <20180702140343.GO13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Iys0Un1O+0sigPHU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-1-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org
Cc: jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--Iys0Un1O+0sigPHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:25PM +0300, Mikko Perttunen wrote:
> Hi, here's v3. Changes are in individual patches. Acks are still
> missing from the following patches:
>=20
> mailbox: Add transmit done by blocking option
> mailbox: tegra-hsp: Refactor in preparation of mailboxes
> mailbox: tegra-hsp: Add support for shared mailboxes
> serial: Add Tegra Combined UART driver

There don't seem to be any build-time dependencies between the above, so
technically I guess these could be applied to the respective trees
separately. The only thing we need to be careful about is to not merge
the final patch before the others, because it will break serial console
if the other patches aren't applied.

Jassi, Greg,

What I could do to resolve the runtime dependency is pull the mailbox
patches into a separate branch, create another separate branch for the
TCU driver that is based on the mailbox branch and then base the DT
changes on that branch, or possibly send a separate pull request for
just the DT change late in the merge window or shortly after v4.19-rc1.

Obviously the latter would be equivalent to you guys merging the patches
through your trees for v4.19-rc1 and me sending out a late pull request
for the DT bits.

Any preference?

Thierry

--Iys0Un1O+0sigPHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6ML8ACgkQ3SOs138+
s6GrjxAApVMK4gKLyqmXitg+u5FHQadFlJu89OVNUqmuF2AWqg3qq74JssA/QLAH
dv6nRRrhGvizXqcj6B6F2U8It0cvah8fJYxci1oDKxlPo0ejPuNGGCRMw79MO+Jk
SHhufCIoB7HisBIh/ocjLowlFD+B9Z9udhEiIqJHAZ9xhA+t4EvuGNqdnqxELX+6
0gK20Of2tXdF8TZPIQ9qZDt0mH97oLWofygzv2zO6GsQeead7H1MXMa6QBHBt8NC
yUeLKncthYL/x9NA7GBhfL2RJFrUFCjUt3um2+CPEv1OmGrz8DFu+ozcoqWwYzDE
q4Wa+uYsW5Qupt0Oj9F2DdMeqi7aHFtptKOxHLUNj6fHj2maIDfUU2AAcfiFogkP
kk8VO1o7DikltjWT7NeZRRaUa8SkWW1xgQKKWRFiMu3J1BowoYrE/Qo9IZPOj82b
T4UScNA0zNO87u0sJBCLZo+VFMEM32qdPPYYe04SiT/Bh3Cnsh2mJC++ctT3lGWT
OUYiiDn+1MJRiuatb1PkVbKaOnUxNyi98duTTksHbqODfyYuybvMAHS+EUYjc80k
vMX9Kt7FJR1DQSx8k2f4R+ebk7g8upDQWc/RWUTlA0PDuzPmGFe/Gdg+tWIDVGOB
I0TXw3stMEQezthrRaBwy9l+f58tOpWYJX6qaewtCzgMqE0/DY4=
=llM5
-----END PGP SIGNATURE-----

--Iys0Un1O+0sigPHU--
