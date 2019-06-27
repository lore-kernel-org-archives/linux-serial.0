From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] serial: imx: remove duplicate handling of CTS change
Date: Thu, 27 Jun 2019 09:59:32 +0200
Message-ID: <20190627075932.4bs7dckal4np7u6n@pengutronix.de>
References: <20190626101557.26299-1-s.hauer@pengutronix.de>
 <20190626101557.26299-2-s.hauer@pengutronix.de>
 <20190627061607.4ehhr6jj6vkfjorl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190627061607.4ehhr6jj6vkfjorl@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 27, 2019 at 08:16:07AM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Jun 26, 2019 at 12:15:56PM +0200, Sascha Hauer wrote:
> > We have an interrupt for the CTS input (RTS in FSL speech). Its handler
> > calls uart_handle_cts_change(), so we shouldn't do this in
> > imx_uart_mctrl_check() again.
> > =

> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/tty/serial/imx.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > =

> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index a5e80a028e83..0419a084c0ed 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -805,12 +805,8 @@ static void imx_uart_clear_rx_errors(struct imx_po=
rt *sport);
> >  static unsigned int imx_uart_get_hwmctrl(struct imx_port *sport)
> >  {
> >  	unsigned int tmp =3D TIOCM_DSR;
> > -	unsigned usr1 =3D imx_uart_readl(sport, USR1);
> >  	unsigned usr2 =3D imx_uart_readl(sport, USR2);
> >  =

> > -	if (usr1 & USR1_RTSS)
> > -		tmp |=3D TIOCM_CTS;
> > -
> >  	/* in DCE mode DCDIN is always 0 */
> >  	if (!(usr2 & USR2_DCDIN))
> >  		tmp |=3D TIOCM_CAR;
> =

> Is this hunk supposed to be included in this patch? I think it's wrong.

The rationale was that when we do not evaluate the TIOCM_CTS anymore in
the return value of imx_uart_get_hwmctrl() then there's no point in
setting it in the first place. However, imx_uart_get_hwmctrl() also has
another user which needs the flag, so right, this hunk shouldn't be
here.

> =

> > @@ -843,8 +839,6 @@ static void imx_uart_mctrl_check(struct imx_port *s=
port)
> >  		sport->port.icount.dsr++;
> >  	if (changed & TIOCM_CAR)
> >  		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
> > -	if (changed & TIOCM_CTS)
> > -		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);
> =

> This doesn't hurt, does it?

With this patch the number of CTS changes is correctly counted, I have
verified this with a logic analyzer. Without it port->icount.cts has 978
changes when it should be only 968 changes.

> Also imx_uart_mctrl_check is called from
> imx_uart_timeout which is supposed to catch missed interrupts and in
> this case uart_handle_cts_change() must be called.

Beginning with 2/2 uart_handle_cts_change() is needed for nothing else
but statistic counting. There won't be any timeout due to missed
interrupts as the hardware handles CTS itself.

Sascha

-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
