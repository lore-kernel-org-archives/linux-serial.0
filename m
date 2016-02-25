From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2] tty/serial: at91: restore dynamic driver binding
Date: Thu, 25 Feb 2016 11:01:07 +0100
Message-ID: <56CED0E3.5070308@atmel.com>
References: <1456392221-30401-1-git-send-email-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456392221-30401-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Le 25/02/2016 10:23, Romain Izard a =E9crit :
> In commit c39dfebc7798956fd2140ae6321786ff35da30c3, the modular suppo=
rt
> code for atmel_serial was removed, as the driver cannot be built as a
> module. Because no use case was proposed, the dynamic driver binding
> support was removed as well.
>=20
> The atmel_serial driver can manage up to 7 serial controllers, which =
are
> multiplexed with other functions. For example, in the Atmel SAMA5D2, =
the
> Flexcom controllers can work as USART, SPI or I2C controllers, and on
> all Atmel devices serial lines can be reconfigured as GPIOs.
>=20
> My use case uses GPIOs to transfer a firmware update using a custom
> protocol on the lines used as a serial port during the normal life of
> the device. If it is not possible to unbind the atmel_serial driver, =
the
> GPIO lines remain reserved and prevent this case from working.
>=20
> This patch reinstates the atmel_serial_remove function, and fixes it =
as
> it failed to clear the "clk" field on removal, triggering an oops whe=
n
> a device was bound again after being unbound.
>=20
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Even if you didn't follow my advice for not including unneeded changes
in of the last patch chunk, there's no use delaying the patch just for
this. So, here is my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye.

PS: another advice: please include linux-arm-kernel as well in your CC
list for work on the AT91 platforms: most of the reviewers are there.

> ---
> Changelog:
> v2: Add the rationale for keeping the "remove" function as a comment.
>=20
>=20
>  drivers/tty/serial/atmel_serial.c | 39 +++++++++++++++++++++++++++++=
+++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 1c0884d8ef32..b1f3a5b26830 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2759,14 +2759,47 @@ err:
>  	return ret;
>  }
> =20
> +/*
> + * Even if the driver is not modular, it makes sense to be able to
> + * unbind a device: there can be many bound devices, and there are
> + * situations where dynamic binding and unbinding can be useful.
> + *
> + * For example, a connected device can require a specific firmware u=
pdate
> + * protocol that needs bitbanging on IO lines, but use the regular s=
erial
> + * port in the normal case.
> + */
> +static int atmel_serial_remove(struct platform_device *pdev)
> +{
> +	struct uart_port *port =3D platform_get_drvdata(pdev);
> +	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> +	int ret =3D 0;
> +
> +	tasklet_kill(&atmel_port->tasklet);
> +
> +	device_init_wakeup(&pdev->dev, 0);
> +
> +	ret =3D uart_remove_one_port(&atmel_uart, port);
> +
> +	kfree(atmel_port->rx_ring.buf);
> +
> +	/* "port" is allocated statically, so we shouldn't free it */
> +
> +	clear_bit(port->line, atmel_ports_in_use);
> +
> +	clk_put(atmel_port->clk);
> +	atmel_port->clk =3D NULL;
> +
> +	return ret;
> +}
> +
>  static struct platform_driver atmel_serial_driver =3D {
>  	.probe		=3D atmel_serial_probe,
> +	.remove		=3D atmel_serial_remove,
>  	.suspend	=3D atmel_serial_suspend,
>  	.resume		=3D atmel_serial_resume,
>  	.driver		=3D {
> -		.name			=3D "atmel_usart",
> -		.of_match_table		=3D of_match_ptr(atmel_serial_dt_ids),
> -		.suppress_bind_attrs    =3D true,
> +		.name	=3D "atmel_usart",
> +		.of_match_table	=3D of_match_ptr(atmel_serial_dt_ids),
>  	},
>  };
> =20
>=20


--=20
Nicolas Ferre
