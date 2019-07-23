From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6 2/3] serial: imx: set_mctrl(): correctly restore
 autoRTS state
Date: Tue, 23 Jul 2019 11:49:02 +0200
Message-ID: <20190723094902.r7v5wzu4lkicrs3o@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563823331-5629-1-git-send-email-sorganov@gmail.com>
 <1563823331-5629-3-git-send-email-sorganov@gmail.com>
 <20190722202406.hr74mg64sxoovah7@pengutronix.de>
 <87h87d1509.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87h87d1509.fsf@osv.gnss.ru>
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

On Tue, Jul 23, 2019 at 12:20:38PM +0300, Sergey Organov wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
> =

> > On Mon, Jul 22, 2019 at 10:22:10PM +0300, Sergey Organov wrote:
> >> imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
> >> was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
> >> turning handshake on only when CRTSCTS bit for the port is set.
> >>
> >> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Oh, you added my Ack for patches 2 and 3, too, even before I looked
again on those :-|

> >> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  drivers/tty/serial/imx.c | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >> index 32f36d8..059ba35 100644
> >> --- a/drivers/tty/serial/imx.c
> >> +++ b/drivers/tty/serial/imx.c
> >> @@ -974,10 +974,22 @@ static void imx_uart_set_mctrl(struct uart_port =
*port, unsigned int mctrl)
> >>  	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
> >>  		u32 ucr2;
> >>
> >> +		/*
> >> +		 * Turn off autoRTS if RTS is lowered and restore autoRTS
> >> +		 * setting if RTS is raised.
> >
> > "lower" and "raising" are misleading here. I recommend sticking to
> > "active" and "inactive".
> =

> This is copy-pasted from the 8250 driver. I'd prefer to leave it as is.

I'd prefer to fix the 8250 accordingly. "raised" is just misleading
because the handshaking signals are low-active and you always have to
think if the logical or the physical signal is raising. "active" is
clear in this regard.

> >> +		 */
> >>  		ucr2 =3D imx_uart_readl(sport, UCR2);
> >>  		ucr2 &=3D ~(UCR2_CTS | UCR2_CTSC);
> >> -		if (mctrl & TIOCM_RTS)
> >> -			ucr2 |=3D UCR2_CTS | UCR2_CTSC;
> >> +		if (mctrl & TIOCM_RTS) {
> >> +			ucr2 |=3D UCR2_CTS;
> >> +			/*
> >> +			 * UCR2_IRTS is unset if and only if the port is
> >> +			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
> >> +			 * to get the state to restore to.
> >> +			 */
> >> +			if (!(ucr2 & UCR2_IRTS))
> >> +				ucr2 |=3D UCR2_CTSC;
> >> +		}
> >
> > If you teach imx_uart_rts_auto about IRTS this function could be reused
> > here I think.
> =

> Yeah, but imx_uart_rts_auto_if_crtscts_and_rts_is_active() ? I feel
> somewhat uncomfortable about that mixing of different purposes.
> =

> Besides, one of the purposes of these patch series was to get rid of
> imx_uart_rts_auto() as its name is confusing in the context of existing
> imx_uart_rts_active() and imx_uart_rts_inactive(), as I already
> explained before.
> =

> We can rename the function to avoid confusion, add yet another check to
> it, and call it from 2 places, but it's still questionable if it's an
> improvement, and could be done as a follow-up step anyway. It will look
> something like this then:
> =

>  -- >8 --
> =

>     serial: imx: factor out common code into new imx_uart_set_auto_rts()
> =

> 	Modified   drivers/tty/serial/imx.c
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index d9a73c7..c8b847e 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -954,6 +954,20 @@ static unsigned int imx_uart_get_mctrl(struct uart_p=
ort *port)
>  	return ret;
>  }
> =

> +/*
> + * Compute and set auto RTS in 'ucr2' according to the current state of =
RTS
> + * signal and CRTSCTS state of port configuration.
> + *
> + * Use inverted UCR2_IRTS to get the state of CRTSCTS, and don't let rec=
eiver
> + * control RTS output if RTS is inactive.
> + *
> + */
> +static void imx_uart_set_auto_rts(u32 *ucr2)
> +{
> +	if ((*ucr2 & UCR2_CTS) && !(*ucr2 & UCR2_IRTS))
> +		*ucr2 |=3D UCR2_CTSC;
> +}
> +

this looks fine and is what I intended to suggest. The comment isn't
optimal yet, I'd write something like:

  /*
   * Enable hardware control of the RTS output iff handshaking is in use
   * and software requested RTS to be active.
   * "handshaking is in use" can be determined from the IRTS bit that is
   * set when handshaking is not used. The requested state by software
   * is represented in the CTS bit.
   */

IMHO go directly to imx_uart_set_auto_rts() before introducing the
second open coding of its logic.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
