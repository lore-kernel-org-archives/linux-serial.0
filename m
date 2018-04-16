From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: serial: imx: half-duplex RS485 operation with RTS active low
Date: Mon, 16 Apr 2018 11:22:57 +0200
Message-ID: <20180416092257.frbmooduhm4zrhhl@pengutronix.de>
References: <0e88706a05a302201be396d2f03c3e9e@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0e88706a05a302201be396d2f03c3e9e@agner.ch>
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
Cc: linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, baruch@tkos.co.il, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Stefan,

On Mon, Apr 16, 2018 at 11:14:32AM +0200, Stefan Agner wrote:
> Using upstream I noticed that RS-485 does not work in the default
> configuration for our platforms (Toradex Apalis/Colibri). Closer

This is an i.MX6?

> debugging shows that it is related to "serial: imx: default to half
> duplex rs485".
> =

> We use the i.MX UART in DTE mode and control the RS-485 transceiver
> using the RTS signal in low-active mode.
> =

> 	uart-has-rtscts;
> 	fsl,dte-mode;
> 	linux,rs485-enabled-at-boot-time;
> 	rs485-rts-active-low;

That means you're not using a GPIO for RTS signaling, right?
 =

> Using this setting leads to the RTS signal not getting asserted (the
> oscilloscope only shows a very short fluke before the start bit is
> sent).
> =

> However, using
> =

> 	uart-has-rtscts;
> 	fsl,dte-mode;
> 	linux,rs485-enabled-at-boot-time;
> 	rs485-rts-active-low;
> 	rs485-rx-during-tx;
> =

> Asserts the RTS signal low active just fine...
> =

> Is this a known problem? Any idea where that could come from? It looks
> as if the receiver part is actually enabling RTS...?

Which kernel version do you use? My latest rs485 related patches went
into v4.17-rc1. With that I managed to make rs485 half duplex work on
several customer boards.

> Also, isn't enabling RX even in half-duplex mode quite common in order
> to detect collisions?

I don't know.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
