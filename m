From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH -firmware 3/3] rp2: Initial commit of Comtrol RocketPort
 2 microcode
Date: Sun, 30 Dec 2012 13:29:51 +0100
Message-ID: <1356870591.4821.11.camel@deadeye.wl.decadent.org.uk>
References: <bd10fdeead3e321db2bb291c0b722203@localhost>
	 <4afa5e3b9acea9c3d4a9255a0f5be260@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-WVgIhvfw9l01LD2rojmZ"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43662 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754466Ab2L3MaL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 30 Dec 2012 07:30:11 -0500
In-Reply-To: <4afa5e3b9acea9c3d4a9255a0f5be260@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: dwmw2@infradead.org, alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org


--=-WVgIhvfw9l01LD2rojmZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-12-29 at 23:23 -0800, Kevin Cernekee wrote:
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  WHENCE |   13 +++++++++++++
>  rp2.fw |  Bin 0 -> 63 bytes
>  2 files changed, 13 insertions(+)
>  create mode 100644 rp2.fw
>=20
>=20
> This is intended for the linux-firmware repo.
>=20
> Also available from: git://github.com/cernekee/linux-firmware rp2
>=20
>=20
> diff --git a/WHENCE b/WHENCE
> index b7dcda3..3923185 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -2034,3 +2034,16 @@ useful, but WITHOUT ANY WARRANTY; without even the=
 implied warranty
>  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> =20
>  ------------------------------------------------------------------------=
--
> +
> +Driver: rp2 -- Comtrol RocketPort 2 serial driver
> +
> +File: rp2.fw
> +
> +Licence: Allegedly GPLv2+, but no source visible. Marked:
[...]

The 'GPL' blobs already in the Linux source tree were grandfathered in
but I don't think we should add any more like this.  Please ask the
vendor to clarify the licence or provide source for this.

Ben.

--=20
Ben Hutchings
It is easier to change the specification to fit the program than vice versa=
.

--=-WVgIhvfw9l01LD2rojmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUOAzv+e/yOyVhhEJAQqXtRAAp0jnV9WMWr2gCUEZmJYrHwEddBpGIrxf
yh1ulxDlL7EdvU5BvrGdZmJ/4X8gy10sLS9PPteEmzWt4dpUlBIP1FZhFaG5iHic
bYv3+H2CvlB97ceLrngFwxZoQSldmiTjfrH2aNfGSlprBeDycQGav9lgQS5E6CDA
bHJzWucW+/OGN6LeFRA9hI1cyxDR5ruq1RDJE8nEHQccT0Iq7p1Yekc7dIpR3mRe
wu15COamE+m/7d9+iH94+v7qc+Ic5tfEKcsLQGJNvRR0te1dIv12VctFQZZPA28L
ouXTW6UUXN6+5ECLwUnhTEVWpeiAzYHjH6azLGD76gRgs096cTahUSmM/wLHKV0S
1MtSC+ujyu0VvKYWxhwhARAG6oUhNk95xvlhpYtAF7tOSgVoc6ch4ZSeMPW2Wh9E
TJL7yIebBmn0WIlAQfR4XAmELfA5Mfd9OXyBcc6omo06Kmpr+wx8Gi2ro1G3St9P
mARe11i5CksqLTEfubO3hdW68qiXlmZhXeKJ/Q+E82Thr+5BSKNJ9cH2QUNX5nes
yP6HM36ElwZUunXPewn8cZ3nX5gQcqGeG7YzWPaQ1v+wFG6t/jfngskeTlwB1kj1
slj+Hm+Wsd8fyf2YlxF6XkJBs3dT72S38JdCzotr/9qCADE6DINvYxGGpvoiXYJQ
sSPgeMkXaWM=
=Yq+r
-----END PGP SIGNATURE-----

--=-WVgIhvfw9l01LD2rojmZ--
