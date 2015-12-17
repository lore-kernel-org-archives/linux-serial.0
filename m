From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] drivers/tty/serial: delete unused MODULE_DEVICE_TABLE
 from atmel_serial.c
Date: Thu, 17 Dec 2015 16:43:38 +0100
Message-ID: <5672D82A.1090401@atmel.com>
References: <1450364746-815-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450364746-815-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Sudip Mukherjee <sudip@vectorindia.org>
List-Id: linux-serial@vger.kernel.org

Le 17/12/2015 16:05, Paul Gortmaker a =E9crit :
> In commit c39dfebc7798956fd2140ae6321786ff35da30c3 ("drivers/tty/seri=
al:
> make serial/atmel_serial.c explicitly non-modular") we removed the co=
de
> relating to modular support since it currently only supports built in=
=2E
>=20
> However, when redoing my build coverage for mips allmodconfig, which
> sets CONFIG_OF, I noticed a remaining line that needs to be removed,
> else we will get a build failure for an undefined module macro.
>=20
> Unfortunately this didn't appear for any of the other arch I tested
> more frequently, such as ARM.
>=20
> Since MODULE_DEVICE_TABLE is a no-op for non-modular code, we can jus=
t
> remove the offending line.
>=20
> Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c =
explicitly non-modular")
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Absolutely:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thank you Sudip and Paul.

Bye,


> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sudip Mukherjee <sudip@vectorindia.org>
> Reported-by: Sudip Mukherjee <sudip@vectorindia.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 50e785a0ea73..1c0884d8ef32 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -188,8 +188,6 @@ static const struct of_device_id atmel_serial_dt_=
ids[] =3D {
>  	{ .compatible =3D "atmel,at91sam9260-usart" },
>  	{ /* sentinel */ }
>  };
> -
> -MODULE_DEVICE_TABLE(of, atmel_serial_dt_ids);
>  #endif
> =20
>  static inline struct atmel_uart_port *
>=20


--=20
Nicolas Ferre
