From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 6/7] serial: imx: set_mctrl(): correctly restore
 autoRTS state
Date: Thu, 27 Jun 2019 08:05:37 +0200
Message-ID: <20190627060537.brmgsmoh3usr4vo6@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
 <1561558293-7683-7-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1561558293-7683-7-git-send-email-sorganov@gmail.com>
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

On Wed, Jun 26, 2019 at 05:11:32PM +0300, Sergey Organov wrote:
> imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
> was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
> turning handshake on only when CRTSCTS bit for the port is set.
> =

> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 4867f80..171347d 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -970,10 +970,19 @@ static void imx_uart_set_mctrl(struct uart_port *po=
rt, unsigned int mctrl)
>  	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
>  		u32 ucr2;
>  =

> +		/*
> +		 * Turn off autoRTS (UCR2_CTSC) if RTS is lowered and restore
> +		 * autoRTS setting if RTS is raised. Inverted UCR2_IRTS is set
> +		 * if and only if CRTSCTS bit is set for the port, so we use it
> +		 * to get the state to restore to.
> +		 */

The comment is quite complicated. I like the comments of Sascha's patch
that addressed the same issue better.

Are you using UCR2_IRTS as an indicator if CRTSCTS is set? If it's that
what you intend to express in the second sentence that is hard to grasp.
Something like:

	UCR2_IRTS is unset iff the port is configured for CRTSCTS

Also as the value of the CTS bit doesn't matter if CTSC is set, the
order of the checks could be swapped to result in easier code (IMHO at
least) that doesn't need a nested if.

Something like:

	ucr2 =3D imx_uart_readl(sport, UCR2);
	ucr2 &=3D ~(UCR2_CTS | UCR2_CTSC);

	/* UCR2_IRTS is unset iff the port is configured for CRTSCTS */
	crtscts =3D !(ucr2 & UCR2_IRTS);

	if (!(mctrl & TIOCM_RTS)) {
		/* Force RTS inactive, i.e. UCR2_CTS=3D0 and UCR2_CTSC=3D0 */
	} else if (crtscts) {
		/* let the receiver control RTS */
		ucr2 |=3D UCR2_CTSC;
	} else {
		/* Force RTS active */
		ucr2 |=3D UCR2_CTS;
	}

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
