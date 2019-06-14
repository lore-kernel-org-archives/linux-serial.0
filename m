From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: fix RTS/CTS setting
Date: Fri, 14 Jun 2019 09:48:17 +0200
Message-ID: <20190614074817.vmvhvbms32i6jfqo@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190614072801.3187-1-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, Sergey Organov <sorganov@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

[expanded Cc: a bit]

Hello Sascha,

On Fri, Jun 14, 2019 at 09:28:01AM +0200, Sascha Hauer wrote:
> The correct setting of the RTS pin depends on the CRTSCTS termios setting:
> =

> - When CRTSCTS is disabled then RTS shall be controlled by the TIOCM_RTS
>   flag.
> - When CRTSCTS is enabled the expected behaviour of the RTS pin is:
>   - When TIOCM_RTS is set then let the receiver control RTS.
>   - When the TIOCM_RTS flag is cleared then RTS shall be deasserted (to l=
et
>     the upper layers throttle the transfer even when the FIFO in the UART=
 has
>     enough space).
> =

> This patch fixes this behaviour. Previously the RTS pin has always been
> controlled by the receiver once the TIOCM_RTS flag was set and the CRTSCTS
> setting hasn't been taken into account.
> =

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/imx.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8b752e895053..0eddca6455ad 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -216,6 +216,7 @@ struct imx_port {
>  	unsigned int		dma_is_enabled:1;
>  	unsigned int		dma_is_rxing:1;
>  	unsigned int		dma_is_txing:1;
> +	unsigned int		crtscts:1;
>  	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
>  	struct scatterlist	rx_sgl, tx_sgl[2];
>  	void			*rx_buf;
> @@ -967,9 +968,18 @@ static void imx_uart_set_mctrl(struct uart_port *por=
t, unsigned int mctrl)
>  		u32 ucr2;
>  =

>  		ucr2 =3D imx_uart_readl(sport, UCR2);
> +
>  		ucr2 &=3D ~(UCR2_CTS | UCR2_CTSC);
> -		if (mctrl & TIOCM_RTS)
> -			ucr2 |=3D UCR2_CTS | UCR2_CTSC;
> +
> +		if (mctrl & TIOCM_RTS) {
> +			if (sport->crtscts)
> +				/* let the receiver control RTS */
> +				ucr2 |=3D UCR2_CTSC;
> +			else
> +				/* Force RTS active */
> +				ucr2 |=3D UCR2_CTS;
> +		}
> +

Other drivers check for

	port->status & UPSTAT_AUTORTS

instead of CRTSCTS. I didn't manage to grasp all the details from the
quick look I took, but maybe you should better do the same?

>  		imx_uart_writel(sport, ucr2, UCR2);
>  	}
>  =

> @@ -1554,6 +1564,11 @@ imx_uart_set_termios(struct uart_port *port, struc=
t ktermios *termios,
>  	else
>  		ucr2 =3D UCR2_SRST | UCR2_IRTS;
>  =

> +	if (termios->c_cflag & CRTSCTS)
> +		sport->crtscts =3D true;
> +	else
> +		sport->crtscts =3D false;
> +
>  	if (termios->c_cflag & CRTSCTS) {

I'd put setting sport->crtscts in the following if block, maybe even in
the if (sport->have_rtscts) part that starts below here?

>  		if (sport->have_rtscts) {
>  			ucr2 &=3D ~UCR2_IRTS;

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
