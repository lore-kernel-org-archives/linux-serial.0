From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial/efm32: parse location property
Date: Thu, 7 Mar 2013 10:38:29 +0100
Message-ID: <20130307093829.GG15375@pengutronix.de>
References: <1358774576-13275-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130304143854.395EF3E206B@localhost>
 <CACRpkdZuNOFco+GTe9YOD=qy+dgEaokoqvWaPA2mCxYHs9oxVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZuNOFco+GTe9YOD=qy+dgEaokoqvWaPA2mCxYHs9oxVA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree-discuss@lists.ozlabs.org, kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Linus,

On Thu, Mar 07, 2013 at 08:37:38AM +0100, Linus Walleij wrote:
> On Mon, Mar 4, 2013 at 3:38 PM, Grant Likely <grant.likely@secretlab.=
ca> wrote:
> > On Mon, 21 Jan 2013 14:22:56 +0100, Uwe Kleine-K=F6nig <u.kleine-ko=
enig@pengutronix.de> wrote:
> >> The non-dt probing allowed passing the location via platform data =
from
> >> the beginning. So make up leeway for device tree probing.
> >>
> >> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >
> > Linus, does this look like some thing that should be done using pin=
ctrl?
>=20
> Hm it's a bit weird actually.
That was my first impression, too :-)

> Most platforms will have some cetral entity dealing with pin multiple=
xing,
> and often it is combined with either a system controller register ran=
ge,
> or it's combined with a GPIO controller (which is more common).
>=20
> This is a new oddity: it's like multiplexing is distributed out among=
 the
> peripherals on the EFM32, or atleast for this UART, so there is a
> register on the peripheral itself selecting where to route it.
>=20
> If all peripherals on the system follows this pattern, like if there =
is
> some such "location" register on each and every peripheral, ideally
I didn't check if all do, but it's a common pattern for the efm32
peripherals to have such a ROUTE register.

> that should be centralized into some file like drivers/pinctrl/pinctr=
l-efm32.c
> but the thing is that then that driver needs to own a single register
> or even just part of a register in each peripheral device memory
> range.
>=20
> And that seems a bit complex to handle.
>=20
> But if the EFM32 is using device tree exclusively it's actually
> just an array of named  <&ampersand> references in the node for
> the pin controller, pointing to each peripheral with a mux register.
> So maybe that's not that bad after all.
>=20
> Still it might be a bit overzealous to request that each device
> ask a central entity to write one of its own registers. So it needs
> to buy you something - like for example if it is possible to
> completely screw up the muxing if different peripherals are
> muxed to the same pins.
I don't know what happens then.
=20
> So it all depends, we need a birds-eye view of the system to
> determine this. I tried looking at the datasheet but couldn't figure
> it out. Uwe how does this work on EFM32?
OK, here comes the rough overview:

Several peripherals have a ROUTE register. They have a location field
that determines a group of pins and an enable bit for each role. E.g.
The Clock Management Unit's ROUTE register has supports three locations
and two functions (CLKOUT1 and CLKOUT2). Depending on which location is
used CLKOUT[12] is routed to the following pins:

          Location | CLKOUT0 | CLKOUT1
              0    |   PA1   |   PA1
              1    |    -    |   PD8
              2    |   PD7   |  PE12

The GPIO controller is involved, too, because that one needs to
configure the pins direction. So if you want to get out some clock to
the PA1 pin, you need to do the following in the CMU's register set:
	- CMU_ROUTE.LOCATION =3D 0;
	- CMU_ROUTE.CLKOUT0PEN =3D 1;
	- (configure which clock to output in CMU_CTRL)

and additionally in the GPIO peripheral:

	- configure PA1 as output (this includes selecting PUSHPULL or
	  WIREDOR with a pull down or WIREDAND with a filter applied or
	  one of several more alternatives)

and optionally:

	- configure drive strength (applies to all A pins)

=46or the USART (i.e. UART + SPI peripheral) there are 6 different
locations and 4 roles:

	CLK    \
	CS     - only used for spi mode
	TX
	RX

and analogous you have to use one of the 3 input modes for the RX pin
and an output mode for the others in the GPIO register space.

Currently I do the settings in the GPIO register space in the bootloade=
r
and don't let Linux modify them. So the gpio driver's direction_output
callback looks like:

	direction_output(pin, initval):
		if pin isn't already configured as output:
			return -ESOMETHING
		else:
			set value of pin =3D initval
			return 0

To complicate the matter, the layout of the ROUTE register isn't
uniform. So for CMU the location filed occupies bits 2:4, for USART it'=
s
bits 8:10. Also the offsets in the peripheral's register space differ
from peripheral to peripheral.

If you have an idea how to model this such that it fits nicely into the
various subsystems (most interesting: gpio and pinmux), any input is
welcome. (Implementation has to wait probably for a while, because we
currently don't have a business case for it and I have to look for the
Cortex-M3 basics first.) In case you are interested in more details, th=
e
Reference Manual and the Data Sheet are available at

	http://www.energymicro.com/products/efm32gg980f64-efm32gg980f128-efm32=
gg980f256-efm32gg980f512-efm32gg980f1024

(or ask).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
