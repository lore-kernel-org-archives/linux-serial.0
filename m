From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH v4] serial/efm32: add new driver
Date: Wed, 25 Jan 2012 07:52:58 -0800
Message-ID: <20120125155258.GB3608@suse.de>
References: <20120124220522.GA10590@kroah.com>
 <1327478704-4233-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1327478704-4233-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 25, 2012 at 09:05:04AM +0100, Uwe Kleine-K=F6nig wrote:
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> changes since v3 (id:1326127447-20284-1-git-send-email-u.kleine-koeni=
g@pengutronix.de)
>  - increase number of ports to support UART additionally to USART por=
ts
>  - implement choosing route location
>  - implement setting stopbit config
>    (before one stop bit was configured and CSTOPB was set uncondition=
ally which
>    is wrong. Spotted by Russell King.)
>  - implement break, sysrq and overflow detection
>  - drop unrelated changing to make patch apply on v3.3-rc1
>=20
> Hello Greg,
>=20
> On Tue, Jan 24, 2012 at 02:05:22PM -0800, Greg KH wrote:
> > On Mon, Jan 09, 2012 at 05:44:07PM +0100, Uwe Kleine-K=F6nig wrote:
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de=
>
> > > ---
> > > Hello,
> > >=20
> > > changes since v2:
> > > - use {read,write}l_relaxed
> > > - rename driver to efm32-uart as USARTs and UARTs can be handled =
both
> > >   with it
> > > - disable TX in .stop_tx (which needs some changes related to
> > >   USARTn_IF_TXC)
> > >=20
> > > Best regards
> > > Uwe
> > >=20
> > >  .../devicetree/bindings/tty/serial/efm32-uart.txt  |   14 +
> > >  arch/arm/boot/dts/efm32gg-dk3750.dts               |    2 +-
> > >  arch/arm/mach-efm32/devices/pdev-efm32-usart.c     |    6 +-
> >=20
> > This file isn't in 3.3-rc1, so I can't apply this patch :(
> >=20
> > What tree is it supposed to be against?
> Sorry, I messed this up, it bases on my private development tree. The=
se
> two changes should go independant of the driver patch via an ARM tree
> (if at all).
>=20
> I added a few more features in the meantime, so the options are:
>  - take v3 simply droping the hunks changing
>    arch/arm/boot/dts/efm32gg-dk3750.dts and
>    arch/arm/mach-efm32/devices/pdev-efm32-usart.c
>  - take this for 3.3
>  - take this for 3.4
>=20
> My preference would be of course the second option, but for me the ot=
her two
> would be OK if you don't like taking the update that late, too.

I was going to take this for the 3.4 merge, adding it to my tree now.
It should be ok to drop those hunks, right?

greg k-h
