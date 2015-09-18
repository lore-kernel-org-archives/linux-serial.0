From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] tty/serial: at91: move ATMEL_MAX_UART
Date: Fri, 18 Sep 2015 16:23:47 +0200
Message-ID: <55FC1E73.8020101@atmel.com>
References: <1441877343-20248-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441877343-20248-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Le 10/09/2015 11:29, Alexandre Belloni a =E9crit :
> Move ATMEL_MAX_UART from platform_data/atmel.h to atmel_serial.c as t=
his is
> the only file using it and it is common practise from tty/serial driv=
ers to
> define it directly in the driver file.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>

Okay:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/tty/serial/atmel_serial.c   | 6 ++++++
>  include/linux/platform_data/atmel.h | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 5ca5cf3e9359..98c84038518e 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -112,6 +112,12 @@ struct atmel_uart_char {
>  #define ATMEL_SERIAL_RINGSIZE 1024
> =20
>  /*
> + * at91: 6 USARTs and one DBGU port (SAM9260)
> + * avr32: 4
> + */
> +#define ATMEL_MAX_UART		7
> +
> +/*
>   * We wrap our port structure around the generic uart_port.
>   */
>  struct atmel_uart_port {
> diff --git a/include/linux/platform_data/atmel.h b/include/linux/plat=
form_data/atmel.h
> index 527a85c61924..c4bc90bfebe0 100644
> --- a/include/linux/platform_data/atmel.h
> +++ b/include/linux/platform_data/atmel.h
> @@ -19,12 +19,6 @@
>  #include <linux/serial.h>
>  #include <linux/platform_data/macb.h>
> =20
> -/*
> - * at91: 6 USARTs and one DBGU port (SAM9260)
> - * avr32: 4
> - */
> -#define ATMEL_MAX_UART	7
> -
>   /* USB Device */
>  struct at91_udc_data {
>  	int	vbus_pin;		/* high =3D=3D host powering us */
>=20


--=20
Nicolas Ferre
