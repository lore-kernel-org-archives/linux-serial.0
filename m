From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
Date: Mon, 8 Jun 2015 08:41:13 +0200
Message-ID: <20150608064113.GX18985@pengutronix.de>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433136067-20644-3-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, moorray3-5tc4TXWwyLM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, bhuvanchandra.dv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Mon, Jun 01, 2015 at 10:51:06AM +0530, Bhuvanchandra DV wrote:
> The LPUART does not provide manual control of RTS/CTS signals,
> those can only be controlled by the hardware directly. Therefore
> manual control of those signals through mctrl can not be provided.
> The current implementation enables/disables the automatic control,
> which is not what mctrl should do, hence remove the incorrect
> implementation.
>=20
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 63 +++++--------------------------=
----------
>  1 file changed, 7 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl=
_lpuart.c
> index 08ce76f..532cfb7 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -822,64 +822,15 @@ static unsigned int lpuart32_tx_empty(struct ua=
rt_port *port)
> =20
>  static unsigned int lpuart_get_mctrl(struct uart_port *port)
>  {
> -	unsigned int temp =3D 0;
> -	unsigned char reg;
> -
> -	reg =3D readb(port->membase + UARTMODEM);
> -	if (reg & UARTMODEM_TXCTSE)
> -		temp |=3D TIOCM_CTS;
> -
> -	if (reg & UARTMODEM_RXRTSE)
> -		temp |=3D TIOCM_RTS;
> -
> -	return temp;
=46rom reading the commit log I would expect that you only touch the
set_mctrl function, but not get_mctrl. Assuming your code change is
right, can you mention this in the commit log please? The bits
UARTMODEM_TXCTSE and UARTMODEM_RXRTSE only control the automatic mode?

What is the problem you're fixing here? I'm not sure how such an UART
should be handled, but I imagine that you want to make use of automatic
mode in some cases. Greg?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
