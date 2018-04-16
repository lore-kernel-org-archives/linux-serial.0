From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: serial: imx: half-duplex RS485 operation with RTS active low
Date: Mon, 16 Apr 2018 15:42:49 +0200
Message-ID: <20180416134249.vdjyye73elv2p5qr@pengutronix.de>
References: <0e88706a05a302201be396d2f03c3e9e@agner.ch>
 <20180416092257.frbmooduhm4zrhhl@pengutronix.de>
 <c6059022d48191909d030584f981d1a2@agner.ch>
 <94f7fcf8873f7607087fc3a59a9422a8@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <94f7fcf8873f7607087fc3a59a9422a8@agner.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Agner <stefan@agner.ch>
Cc: s.hauer@pengutronix.de, baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 16, 2018 at 03:01:44PM +0200, Stefan Agner wrote:
> On 16.04.2018 12:29, Stefan Agner wrote:
> > On 16.04.2018 11:22, Uwe Kleine-K=F6nig wrote:
> >> Hi Stefan,
> >>
> >> On Mon, Apr 16, 2018 at 11:14:32AM +0200, Stefan Agner wrote:
> >>> Using upstream I noticed that RS-485 does not work in the default
> >>> configuration for our platforms (Toradex Apalis/Colibri). Closer
> >>
> >> This is an i.MX6?
> >>
> > =

> > Yes, sorry about that.
> > =

> > But I think it is i.MX UART specific, I noticed the same behavior on
> > i.MX 7 too.
> > =

> >>> debugging shows that it is related to "serial: imx: default to half
> >>> duplex rs485".
> >>>
> >>> We use the i.MX UART in DTE mode and control the RS-485 transceiver
> >>> using the RTS signal in low-active mode.
> >>>
> >>> 	uart-has-rtscts;
> >>> 	fsl,dte-mode;
> >>> 	linux,rs485-enabled-at-boot-time;
> >>> 	rs485-rts-active-low;
> >>
> >> That means you're not using a GPIO for RTS signaling, right?
> >>
> > =

> > I use native RTS capability (which is in DTE mode the CTS signal...)
> > =

> >>> Using this setting leads to the RTS signal not getting asserted (the
> >>> oscilloscope only shows a very short fluke before the start bit is
> >>> sent).
> > =

> > Just FYI, the fluke looks like a proper assert, but it is really only
> > 50ns wide.
> > =

> =

> Also tried DCE mode, the same behavior.
> =

> Two screenshots showing TX/RTS (CTS_B) in different settings:
> https://imgur.com/a/PbUex
> =

> The little fluke disappears when disabling RX before setting CTSC:
> =

> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -657,6 +657,9 @@ static void imx_uart_start_tx(struct uart_port
> *port)
>         if (port->rs485.flags & SER_RS485_ENABLED) {
>                 u32 ucr2;
>  =

> +               if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
> +                       imx_uart_stop_rx(port);
> +
>                 ucr2 =3D imx_uart_readl(sport, UCR2);
>                 if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
>                         imx_uart_rts_active(sport, &ucr2);
> @@ -664,9 +667,6 @@ static void imx_uart_start_tx(struct uart_port
> *port)
>                         imx_uart_rts_inactive(sport, &ucr2);
>                 imx_uart_writel(sport, ucr2, UCR2);
>  =

> -               if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
> -                       imx_uart_stop_rx(port);
> -
>                 /*
>                  * Enable transmitter and shifter empty irq only if DMA
> is off.
>                  * In the DMA case this is done in the tx-callback.
> =

> It seems that if the RX path is disabled, CTS_B is no longer
> controllable. It just stays high. That is not a problem in the high
> active RTS case... However, it breaks low active half-duplex...
> =

> It seems that this thread is describing this situation:
> https://community.nxp.com/thread/385047

So better use a gpio instead of the hardware-function?

Adding a respective check in the driver would be nice though.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
