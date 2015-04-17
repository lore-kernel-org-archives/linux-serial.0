From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] tty: Remove leftover dependencies on PPC_OF
Date: Fri, 17 Apr 2015 14:01:05 +0800
Message-ID: <20150417060104.GH6256@pek-khao-d1.corp.ad.wrs.com>
References: <1429248059-18461-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429248059-18461-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-serial@vger.kernel.org


--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2015 at 10:20:59PM -0700, Guenter Roeck wrote:
> powerpc qemu runs fail with the current upstream kernel.
> Bisect points to commit 52d996270032 ("powerpc: kill PPC_OF").
> Unfortunately, that commit did not remove all instances of PPC_OF.
> Practical impact is that the serial driver used by powerpc qemu
> targets is no longer built into the test kernel.

Sorry for the break. This is a dependency issue. The patch 213dce3c17a6
("tty: kconfig: remove the superfluous dependency on PPC_OF") has already
been merged into tty-next, but still not propagate to upstream yet. I failed
to reminder Michael of this when the pulling request is sent to Linus.

Thanks,
Kevin
>=20
> Fixes: 52d996270032 ("powerpc: kill PPC_OF")
> Cc: Kevin Hao <haokexin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/tty/serial/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index d2501f01cd03..77471d3db8d3 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -835,7 +835,7 @@ config SERIAL_MCF_CONSOLE
> =20
>  config SERIAL_PMACZILOG
>  	tristate "Mac or PowerMac z85c30 ESCC support"
> -	depends on (M68K && MAC) || (PPC_OF && PPC_PMAC)
> +	depends on (M68K && MAC) || PPC_PMAC
>  	select SERIAL_CORE
>  	help
>  	  This driver supports the Zilog z85C30 serial ports found on
> @@ -1153,7 +1153,7 @@ config SERIAL_OMAP_CONSOLE
> =20
>  config SERIAL_OF_PLATFORM_NWPSERIAL
>  	tristate "NWP serial port driver"
> -	depends on PPC_OF && PPC_DCR
> +	depends on PPC_DCR
>  	select SERIAL_OF_PLATFORM
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_CORE
> --=20
> 2.1.0
>=20

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVMKGgAAoJEJNY7TDerrFxsuoIAMRdOy+v3yfMaBjtsw+3ZZVS
ZmFhEPYZqohgbn1uSbsBzxq4/BcOcFdg02/M5UFBieOl0S3d8+OEGCGjWvmY8PjS
ANbbDDaPYsXEaymP3sLz26e+yB34lKLjwUxEPdHmxaH75o2yY+zP54ghEdaHdnPW
H46vOEyEndV7fsG1/6zbv2jsRBzC1B3GjpB7qPUq1vwTAfBqszLJh6ji3PFQzs21
sHWIYY1LdtWgyACj6AxaiwY/+nrAMsKXApApvndf+tVOcd01VvQGLVLN4y8MhLeZ
zA9jQ0n6n2zlFMYJfr+v6zzE5IyXG/kegKmQ4v9MwZBphXS2BCFx90Eehem5AmA=
=Gipg
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--
