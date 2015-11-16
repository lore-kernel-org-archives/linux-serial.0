From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: fix a possible NULL dereference
Date: Mon, 16 Nov 2015 13:14:45 +0100
Message-ID: <20151116121445.GC22022@pengutronix.de>
References: <1447314381-31145-1-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447314381-31145-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Thu, Nov 12, 2015 at 08:46:21AM +0100, LABBE Corentin wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
>=20
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 016e4be..22e91f7 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1857,8 +1857,7 @@ static int serial_imx_probe_dt(struct imx_port =
*sport,
>  		struct platform_device *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
> -	const struct of_device_id *of_id =3D
> -			of_match_device(imx_uart_dt_ids, &pdev->dev);
> +	const struct of_device_id *of_id;
>  	int ret;
> =20
>  	if (!np)
> @@ -1878,6 +1877,9 @@ static int serial_imx_probe_dt(struct imx_port =
*sport,
>  	if (of_get_property(np, "fsl,dte-mode", NULL))
>  		sport->dte_mode =3D 1;
> =20
> +	of_id =3D of_match_device(imx_uart_dt_ids, &pdev->dev);
> +	if (!of_id)
> +		return -ENODEV;
>  	sport->devdata =3D of_id->data;
> =20
>  	return 0;

I'd do something like:

-	if (!np)
+	sport->devdata =3D of_device_get_match_data(&pdev->dev);
+	if (!sport->devdata)
 		/* no device tree device */
 		return 1;

instead.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
