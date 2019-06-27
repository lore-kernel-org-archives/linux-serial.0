From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/7] serial: imx: set_termios(): clarify RTS/CTS bits
 calculation
Date: Thu, 27 Jun 2019 07:26:52 +0200
Message-ID: <20190627052652.ey7cmzkztylfy7k3@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
 <1561558293-7683-4-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1561558293-7683-4-git-send-email-sorganov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergey Organov <sorganov@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 26, 2019 at 05:11:29PM +0300, Sergey Organov wrote:
> Avoid repeating the same code for rs485 twice.
> =

> Make it obvious we clear CRTSCTS bit in termios->c_cflag whenever
> sport->have_rtscts is false.
> =

> Make it obvious we clear UCR2_IRTS whenever CRTSCTS is set.
> =

> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> =

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 87802fd..17e2322 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1567,35 +1567,25 @@ imx_uart_set_termios(struct uart_port *port, stru=
ct ktermios *termios,
>  	if ((termios->c_cflag & CSIZE) =3D=3D CS8)
>  		ucr2 |=3D UCR2_WS;
>  =

> -	if (termios->c_cflag & CRTSCTS) {
> -		if (sport->have_rtscts) {
> -			ucr2 &=3D ~UCR2_IRTS;
> +	if (!sport->have_rtscts)
> +		termios->c_cflag &=3D ~CRTSCTS;
>  =

> -			if (port->rs485.flags & SER_RS485_ENABLED) {
> -				/*
> -				 * RTS is mandatory for rs485 operation, so keep
> -				 * it under manual control and keep transmitter
> -				 * disabled.
> -				 */
> -				if (port->rs485.flags &
> -				    SER_RS485_RTS_AFTER_SEND)
> -					imx_uart_rts_active(sport, &ucr2);
> -				else
> -					imx_uart_rts_inactive(sport, &ucr2);
> -			} else {
> -				imx_uart_rts_auto(sport, &ucr2);
> -			}
> -		} else {
> -			termios->c_cflag &=3D ~CRTSCTS;
> -		}
> -	} else if (port->rs485.flags & SER_RS485_ENABLED) {
> -		/* disable transmitter */
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		/*
> +		 * RTS is mandatory for rs485 operation, so keep
> +		 * it under manual control and keep transmitter
> +		 * disabled.
> +		 */
>  		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
>  			imx_uart_rts_active(sport, &ucr2);
>  		else
>  			imx_uart_rts_inactive(sport, &ucr2);
> -	}
>  =

> +	} else if (termios->c_cflag & CRTSCTS)
> +		imx_uart_rts_auto(sport, &ucr2);

Here a set of braces is needed even if the body has only a single line.

> +
> +	if (termios->c_cflag & CRTSCTS)
> +		ucr2 &=3D ~UCR2_IRTS;
>  =

>  	if (termios->c_cflag & CSTOPB)
>  		ucr2 |=3D UCR2_STPB;

Is this patch intended to not change semantic? I wonder if it hides a
fix because if imx_uart_set_termios() was called with termios->c_cflag
& CRTSCTS and !sport->have_rtscts the rs485 block was not reached. Now
it is.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
