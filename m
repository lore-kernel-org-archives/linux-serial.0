From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/7] serial: 8250_dw: add support for clk api
Date: Tue, 19 Mar 2013 11:50:17 +0100
Message-ID: <514842E9.401@free-electrons.com>
References: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com> <1363689316-7847-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42886 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3CSKuV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Mar 2013 06:50:21 -0400
In-Reply-To: <1363689316-7847-2-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, sunny@allwinnertech.com, shuge@allwinnertech.com, Jiri Slaby <jslaby@suse.cz>, kevin@allwinnertech.com

Hi,

Le 19/03/2013 11:35, Maxime Ripard a =C3=A9crit :
> From: Emilio L=C3=B3pez <emilio@elopez.com.ar>
>=20
> This commit implements support for using the clk api; this lets us us=
e
> the "clocks" property with device tree, instead of having to use
> clock-frequency.
>=20
> Signed-off-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
> ---
>  drivers/tty/serial/8250/8250_dw.c |   33 ++++++++++++++++++++++++---=
------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8=
250/8250_dw.c
> index db0e66f..3dedd24 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/clk.h>
> =20
>  #include "8250.h"
> =20
> @@ -55,8 +56,9 @@
> =20
> =20
>  struct dw8250_data {
> -	int	last_lcr;
> -	int	line;
> +	int		last_lcr;
> +	int		line;
> +	struct clk	*clk;
>  };
> =20
>  static void dw8250_serial_out(struct uart_port *p, int offset, int v=
alue)
> @@ -136,8 +138,13 @@ static int dw8250_probe_of(struct uart_port *p)
>  	if (!of_property_read_u32(np, "reg-shift", &val))
>  		p->regshift =3D val;
> =20
> +	/* clock got configured through clk api, all done */
> +	if (IS_ERR(p->uartclk))

Hmm, I messed up here.

I'll resend a new version of this mail without this IS_ERR call

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
