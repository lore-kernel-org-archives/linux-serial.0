From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v2 2/2] serial: tegra: Convert to devm_ioremap_resource()
Date: Fri, 1 Feb 2013 12:24:37 +0100
Message-ID: <20130201112437.GB29105@avionic-0098.mockup.avionic-design.de>
References: <1359713277-14228-1-git-send-email-sachin.kamat@linaro.org>
 <1359713277-14228-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52174 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756709Ab3BALYl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Feb 2013 06:24:41 -0500
Content-Disposition: inline
In-Reply-To: <1359713277-14228-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Laxman Dewangan <ldewangan@nvidia.com>, linux-serial@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2013 at 03:37:57PM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: linux-serial@vger.kernel.org
> ---
> Patch based & compile tested on linux-next tree (20130128).
> Changes since v1:
> * Dropped the error message as it is now handled by devm_ioremap_resource=
()
> itself.
> ---
>  drivers/tty/serial/serial-tegra.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index 4f5e629..24ced23 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -26,6 +26,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
> +#include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/module.h>
> @@ -1302,11 +1303,9 @@ static int tegra_uart_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  	u->mapbase =3D resource->start;
> -	u->membase =3D devm_request_and_ioremap(&pdev->dev, resource);
> -	if (!u->membase) {
> -		dev_err(&pdev->dev, "memregion/iomap address req failed\n");
> -		return -EADDRNOTAVAIL;
> -	}
> +	u->membase =3D devm_ioremap_resource(&pdev->dev, resource);
> +	if (IS_ERR(u->membase))
> +		return PTR_ERR(u->membase);
> =20
>  	tup->uart_clk =3D devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(tup->uart_clk)) {

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRC6X1AAoJEN0jrNd/PrOhLMEP/AqXdJNkHjhBz3z/T1/rzLN8
psDb4jtRUdT9auiBEi0Nsimuov/Q90OWjcAfKZLHLIMvVNd+t91bzO8OUAk801DB
j1EUdsqeKPKMjJa5wiO8lqY/e1t0KWYmNIAui9ig/Mt5grHm6t48wGDE9qBZcb/8
w6pPZ9ZfIlHj68BaDTs9N/z5+GGy/Pwq7ei9xkEmngSCmgBrV3HXnKLYAivr/MGo
DyvtUcjN6x5SxaA5k3vvPX+ZsZ3SYtWpScHDexfdTOsGsmLJqijTi2XDQ4NESt1S
FyC2YI7NSvze6vJYcszZp5Zc4RmxftHE7UwXWTuFy5pKgAl4tBIXruQdcn02F7Wi
6Y5BQy1M/pHlQce2e0s8fObFm2n1B0yjIJ0rGjgjUOm2JxhV7MPjJwZaps49zkwi
wkSWKwToWw06+BAsOueD+IHrJVPgf4VBpsuMY0k9V6UFoQl0kzDN288c9tn3dtBI
jGOIIzGCIDsyeyQlRtuHnY9JsKLnStwB8lV0prczaiTzIjc/pGt5nbO1LYz7luNi
Mgw1gNTSDSa2hTgdv0sgmcgdhuDCQkZKs2YEo3aZbbUkNN7CHMYnix2Dh8VMTVCM
auugtzal+8IAVwD7H8fi/Yhpj7wHMWIgDnYuQv1XwWAVpuiKHHeU0aVT0wHEFkds
dZURgGCUvhfD2FJD12mu
=iQpb
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
