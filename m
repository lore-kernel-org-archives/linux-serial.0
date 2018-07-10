From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
Date: Tue, 10 Jul 2018 17:49:26 +0200
Message-ID: <20180710154926.GB8492@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5631047396355467356=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180702114033.15654-4-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jonathanh@nvidia.com, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============5631047396355467356==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:28PM +0300, Mikko Perttunen wrote:
> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
> send_data function of the mailbox driver is expected to block until
> the message has been sent. The new option is used with the Tegra
> Combined UART driver to minimize unnecessary overhead when transmitting
> data.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/mailbox/mailbox.c | 30 +++++++++++++++++++++---------
>  drivers/mailbox/mailbox.h |  1 +
>  2 files changed, 22 insertions(+), 9 deletions(-)

Jassi,

any comments on this patch and 4/8 and 5/8? Greg's already said that
he'd be fine if I take the serial driver (patch 6/8) through the Tegra
tree to resolve the dependencies. If you're okay with the three mailbox
patches I can pick them up as well with your Acked-by.

Otherwise, if you'd prefer to take these through the mailbox tree, let
me know and I'll wait until sometime after v4.19-rc1 before I send out
pull requests for the DT changes.

Thanks,
Thierry

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltE1YIACgkQ3SOs138+
s6EsOQ/9HaN/N6V7yRKfJ3THVBcHNhpECScMRxyZdsrDA6gKQaXCkgWWE7dwV7a0
upPIqevAo4GRX8Jx4ETP1M1Z0pLEozFqsOCcwo58JnFduXXfETXbb5RmeJRwj6Ep
kVRkhyLtc50JfSgKo/4LTAWmktoFAZokiPGQahl82EyU/ZryltmALJgRUK5d3gP9
RphFtyyUfMXW0JmHOVnQKNYwm5lnr+tHxSeP4WDow6EXtzq12//hELp8J6jpxVaW
/F83+5UNROde84jNKVtiBXithQJGoUTI29SDFrzncw3VTH64A0kzAgXKsCOigSE7
eFMNT0gkxPmdg+JjfJezldTeYxmi6vl6ikPSBSOwie2OZjCEjXc787rT0PkL8Djt
5JYKl5p2W9f64eoNwMUe4hKdiUPCWZ4vjt0NTG84gw9FKPmclKhImqFs5RmiBhZt
Syod6TZL5qWwwuHYMMr2TWuKH+JeHaAnb7KMqf2MB3E1mqA3W/3mLXYTNfp9Z6Sy
rNy2shb2ZjTJKMrfYSuqajwEyvR/r0VFQcPUmGjVDJbDug9eLlH/j6cskjx+BqnS
9NZQQpjrgAkXrpLVvZ7R7p8HIipTAwbQljkEVEpulG4ZMUiVCGvP/ObZ2HI4WzZp
OhhvIifTVTmCH3wTyzkXqAsEVfuRdw5AGe4hU6QDWQN29tJHs1U=
=NUWu
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--


--===============5631047396355467356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5631047396355467356==--
