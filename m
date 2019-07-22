From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6 2/3] serial: imx: set_mctrl(): correctly restore
 autoRTS state
Date: Mon, 22 Jul 2019 22:24:06 +0200
Message-ID: <20190722202406.hr74mg64sxoovah7@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563823331-5629-1-git-send-email-sorganov@gmail.com>
 <1563823331-5629-3-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1563823331-5629-3-git-send-email-sorganov@gmail.com>
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
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 10:22:10PM +0300, Sergey Organov wrote:
> imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
> was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
> turning handshake on only when CRTSCTS bit for the port is set.
> =

> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 32f36d8..059ba35 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -974,10 +974,22 @@ static void imx_uart_set_mctrl(struct uart_port *po=
rt, unsigned int mctrl)
>  	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
>  		u32 ucr2;
>  =

> +		/*
> +		 * Turn off autoRTS if RTS is lowered and restore autoRTS
> +		 * setting if RTS is raised.

"lower" and "raising" are misleading here. I recommend sticking to
"active" and "inactive".

> +		 */
>  		ucr2 =3D imx_uart_readl(sport, UCR2);
>  		ucr2 &=3D ~(UCR2_CTS | UCR2_CTSC);
> -		if (mctrl & TIOCM_RTS)
> -			ucr2 |=3D UCR2_CTS | UCR2_CTSC;
> +		if (mctrl & TIOCM_RTS) {
> +			ucr2 |=3D UCR2_CTS;
> +			/*
> +			 * UCR2_IRTS is unset if and only if the port is
> +			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
> +			 * to get the state to restore to.
> +			 */
> +			if (!(ucr2 & UCR2_IRTS))
> +				ucr2 |=3D UCR2_CTSC;
> +		}

If you teach imx_uart_rts_auto about IRTS this function could be reused
here I think.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
