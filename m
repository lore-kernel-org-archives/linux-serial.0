From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 7/7] serial: imx: get rid of imx_uart_rts_auto()
Date: Thu, 27 Jun 2019 08:08:38 +0200
Message-ID: <20190627060838.ls5ghzngkoiczqex@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
 <1561558293-7683-8-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1561558293-7683-8-git-send-email-sorganov@gmail.com>
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

On Wed, Jun 26, 2019 at 05:11:33PM +0300, Sergey Organov wrote:
> Called in only one place, for RS232, it only obscures things, as it
> doesn't go well with 2 similar named functions,
> imx_uart_rts_inactive() and imx_uart_rts_active(), that both are
> RS485-specific.
> =

> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> =

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 171347d..a5e80a0 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -402,13 +402,6 @@ static void imx_uart_rts_inactive(struct imx_port *s=
port, u32 *ucr2)
>  	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
>  }
>  =

> -/* called with port.lock taken and irqs caller dependent */
> -static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
> -{
> -	if (*ucr2 & UCR2_CTS)
> -		*ucr2 |=3D UCR2_CTSC;
> -}
> -
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_start_rx(struct uart_port *port)
>  {
> @@ -1598,8 +1591,10 @@ imx_uart_set_termios(struct uart_port *port, struc=
t ktermios *termios,
>  		else
>  			imx_uart_rts_inactive(sport, &ucr2);
>  =

> -	} else if (termios->c_cflag & CRTSCTS)
> -		imx_uart_rts_auto(sport, &ucr2);
> +	} else if (termios->c_cflag & CRTSCTS) {
> +		if (ucr2 & UCR2_CTS)
> +			ucr2 |=3D UCR2_CTSC;
> +	}

At least before it was (somewhat) clear that this is about RTS and it
is about something automatic. So I don't like the patch.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
