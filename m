From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH RFC 4/7] serial: imx: set_termios(): do not enable
 autoRTS if RTS is unset
Date: Thu, 20 Jun 2019 11:37:41 +0200
Message-ID: <20190620093741.7wom6a475be2byob@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
 <1560514294-29111-5-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1560514294-29111-5-git-send-email-sorganov@gmail.com>
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
Cc: linux-arm-kernel@lists.infradead.org, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Sergey,

On Fri, Jun 14, 2019 at 03:11:31PM +0300, Sergey Organov wrote:
> set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS (=TIOCM_RTS) is
> cleared. Added corresponding check in imx_uart_rts_auto() to fix this.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 17e2322..8ee910f 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>  /* called with port.lock taken and irqs caller dependent */
>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
>  {
> -	*ucr2 |= UCR2_CTSC;
> +	if (*ucr2 & UCR2_CTS)
> +		*ucr2 |= UCR2_CTSC;
>  }

*ucr2 is set like this in imx_uart_set_termios():

	ucr2 = UCR2_SRST | UCR2_IRTS;
	if ((termios->c_cflag & CSIZE) == CS8)
		ucr2 |= UCR2_WS;
	...
	imx_uart_rts_auto(sport, &ucr2);

So the UCR2_CTS bit is never set, hence UCR2_CTSC will never be set.
You meant to pass in the actual register value of the UCR2 register.

This is shifted around a bit in the following patches, as an end result
we have:

	old_ucr2 = imx_uart_readl(sport, UCR2);
	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTSC);
	...
	if (ucr2 & UCR2_CTS)
		ucr2 |= UCR2_CTSC;

Again the test can never be true, it should probably be if (old_ucr2 &
UCR2_CTS).

With this issue and the one Lothar has found fixed this series works for
me.

With these issues fixed I'd be happy to test this series and apply it in
favour of my patch.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
