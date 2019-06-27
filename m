From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] serial: imx: remove duplicate handling of CTS change
Date: Thu, 27 Jun 2019 08:16:07 +0200
Message-ID: <20190627061607.4ehhr6jj6vkfjorl@pengutronix.de>
References: <20190626101557.26299-1-s.hauer@pengutronix.de>
 <20190626101557.26299-2-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190626101557.26299-2-s.hauer@pengutronix.de>
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 26, 2019 at 12:15:56PM +0200, Sascha Hauer wrote:
> We have an interrupt for the CTS input (RTS in FSL speech). Its handler
> calls uart_handle_cts_change(), so we shouldn't do this in
> imx_uart_mctrl_check() again.
> =

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/imx.c | 6 ------
>  1 file changed, 6 deletions(-)
> =

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index a5e80a028e83..0419a084c0ed 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -805,12 +805,8 @@ static void imx_uart_clear_rx_errors(struct imx_port=
 *sport);
>  static unsigned int imx_uart_get_hwmctrl(struct imx_port *sport)
>  {
>  	unsigned int tmp =3D TIOCM_DSR;
> -	unsigned usr1 =3D imx_uart_readl(sport, USR1);
>  	unsigned usr2 =3D imx_uart_readl(sport, USR2);
>  =

> -	if (usr1 & USR1_RTSS)
> -		tmp |=3D TIOCM_CTS;
> -
>  	/* in DCE mode DCDIN is always 0 */
>  	if (!(usr2 & USR2_DCDIN))
>  		tmp |=3D TIOCM_CAR;

Is this hunk supposed to be included in this patch? I think it's wrong.

> @@ -843,8 +839,6 @@ static void imx_uart_mctrl_check(struct imx_port *spo=
rt)
>  		sport->port.icount.dsr++;
>  	if (changed & TIOCM_CAR)
>  		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
> -	if (changed & TIOCM_CTS)
> -		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);

This doesn't hurt, does it? Also imx_uart_mctrl_check is called from
imx_uart_timeout which is supposed to catch missed interrupts and in
this case uart_handle_cts_change() must be called.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
