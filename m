From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Date: Thu, 11 Feb 2016 08:50:57 +0200
Message-ID: <20160211065057.GA17047@tarshish>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Guenter,

On Tue, Feb 09, 2016 at 07:08:59AM -0800, Guenter Roeck wrote:
> IS_ERR_VALUE() assumes that its parameter is an unsigned long.
> It can not be used to check if an unsigned int reflects an error.
> Doing so can result in the following build warning.
>=20
> drivers/tty/serial/digicolor-usart.c: In function =E2=80=98digicolor_=
uart_probe=E2=80=99:
> include/linux/err.h:21:38: warning:
> 	comparison is always false due to limited range of data type
> drivers/tty/serial/digicolor-usart.c:485:6: note:
> 	in expansion of macro =E2=80=98IS_ERR_VALUE=E2=80=99
>=20
> If that warning is seen, an error return from platform_get_irq() is m=
issed.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/tty/serial/digicolor-usart.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/seria=
l/digicolor-usart.c
> index a80cdad114f3..02ad6953b167 100644
> --- a/drivers/tty/serial/digicolor-usart.c
> +++ b/drivers/tty/serial/digicolor-usart.c
> @@ -453,7 +453,7 @@ static struct uart_driver digicolor_uart =3D {
>  static int digicolor_uart_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
> -	int ret, index;
> +	int irq, ret, index;
>  	struct digicolor_port *dp;
>  	struct resource *res;
>  	struct clk *uart_clk;
> @@ -481,9 +481,10 @@ static int digicolor_uart_probe(struct platform_=
device *pdev)
>  	if (IS_ERR(dp->port.membase))
>  		return PTR_ERR(dp->port.membase);
> =20
> -	dp->port.irq =3D platform_get_irq(pdev, 0);
> -	if (IS_ERR_VALUE(dp->port.irq))
> -		return dp->port.irq;
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +	dp->port.irq =3D irq;
> =20
>  	dp->port.iotype =3D UPIO_MEM;
>  	dp->port.uartclk =3D clk_get_rate(uart_clk);

--=20
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Sy=
stems
=3D}------------------------------------------------ooO--U--Ooo--------=
----{=3D
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
