From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [RFC PATCH] serial: omap: only inform once about missing wakeirq
 support
Date: Thu, 13 Feb 2014 10:47:11 +0100
Message-ID: <20140213094711.GG31787@pengutronix.de>
References: <1392283510-16774-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60805 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbaBMJrQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 04:47:16 -0500
Content-Disposition: inline
In-Reply-To: <1392283510-16774-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, kernel@pengutronix.de, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@linaro.org>

Hi,

On Thu, Feb 13, 2014 at 10:25:10AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The unconditional output in serial_omap_startup clutters dmesg quite =
a
> bit when booting with systemd because the console device is opened
> repeatedly.
>=20
> Without this patch, directly after boot + login I get:
>=20
> 	# dmesg | grep -c 'omap_uart 48024000.serial: no wakeirq for uart2'
> 	79
>=20
> This was introduced in commit 2a0b965cfb6e (serial: omap: Add support
> for optional wake-up) which was applied for v3.13-rc1.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I sent a similar patch, that moves the info message to the probe
function [1].

Regards

Markus

[1]
Message-Id: <1390583381-9076-1-git-send-email-mpa@pengutronix.de>
http://thread.gmane.org/gmane.linux.ports.arm.omap/110058

> ---
> Hello,
>=20
> actually this change is not optimal because it would be nicer to repo=
rt
> once per device instead of not once per driver. But adding a variable=
 to
> driver data just for that seems overkill, too. Maybe downgrading the
> message to dev_dbg is fine, too?
>=20
> What do you think?
>=20
> Best regards
> Uwe
>=20
>  drivers/tty/serial/omap-serial.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index 2116e76b9559..bbcd95360553 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -739,8 +739,13 @@ static int serial_omap_startup(struct uart_port =
*port)
>  		}
>  		disable_irq(up->wakeirq);
>  	} else {
> -		dev_info(up->port.dev, "no wakeirq for uart%d\n",
> -			 up->port.line);
> +		static int once =3D 1;
> +
> +		if (once) {
> +			dev_info(up->port.dev, "no wakeirq for uart%d\n",
> +				 up->port.line);
> +			once =3D 0;
> +		}
>  	}
> =20
>  	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
> --=20
> 1.8.5.3
>=20
>=20

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
