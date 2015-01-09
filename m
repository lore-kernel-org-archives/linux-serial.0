From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 3/5] tty/serial: at91: fix error handling in atmel_serial_probe()
Date: Fri, 9 Jan 2015 16:28:58 +0100
Message-ID: <54AFF3BA.7090704@atmel.com>
References: <cover.1418131298.git.cyrille.pitchen@atmel.com> <95ff85410e2f93993a4f7c5d255c4a88993fd462.1418131298.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95ff85410e2f93993a4f7c5d255c4a88993fd462.1418131298.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, voice.shen@atmel.com, josh.wu@atmel.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Le 09/12/2014 14:31, Cyrille Pitchen a =E9crit :
> -EDEFER error wasn't handle properly by atmel_serial_probe().
> As an example, when atmel_serial_probe() is called for the first time=
, we pass
> the test_and_set_bit() test to check whether the port has already bee=
n
> initalized. Then we call atmel_init_port(), which may return -EDEFER,=
 possibly
> returned before by clk_get(). Consequently atmel_serial_probe() used =
to return
> this error code WITHOUT clearing the port bit in the "atmel_ports_in_=
use" mask.
> When atmel_serial_probe() was called for the second time, it used to =
fail on
> the test_and_set_bit() function then returning -EBUSY.
>=20
> When atmel_serial_probe() fails, this patch make it clear the port bi=
t in the
> "atmel_ports_in_use" mask, if needed, before returning the error code=
=2E
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
and you can also add:
Cc: <stable@vger.kernel.org> # 3.12+

Thanks.

> ---
>  drivers/tty/serial/atmel_serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index c6621dc..92a8b26 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2565,7 +2565,7 @@ static int atmel_serial_probe(struct platform_d=
evice *pdev)
> =20
>  	ret =3D atmel_init_port(port, pdev);
>  	if (ret)
> -		goto err;
> +		goto err_clear_bit;
> =20
>  	if (!atmel_use_pdc_rx(&port->uart)) {
>  		ret =3D -ENOMEM;
> @@ -2628,6 +2628,8 @@ err_alloc_ring:
>  		clk_put(port->clk);
>  		port->clk =3D NULL;
>  	}
> +err_clear_bit:
> +	clear_bit(port->uart.line, atmel_ports_in_use);
>  err:
>  	return ret;
>  }
>=20


--=20
Nicolas Ferre
