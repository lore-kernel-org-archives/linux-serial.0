From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial/efm32: add new driver
Date: Mon, 9 Jan 2012 11:34:58 +0100
Message-ID: <20120109103458.GD14252@pengutronix.de>
References: <20111221202847.4ffeba10@bob.linux.org.uk>
 <1324561092-1945-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201112231035.23215.arnd@arndb.de>
 <20111223204428.GI24496@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111223204428.GI24496@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, kernel@pengutronix.de, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Fri, Dec 23, 2011 at 09:44:28PM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Dec 23, 2011 at 10:35:22AM +0000, Arnd Bergmann wrote:
> > On Thursday 22 December 2011, Uwe Kleine-K=F6nig wrote:
> >=20
> > > @@ -0,0 +1,14 @@
> > > +* Energymicro efm32 UART
> > > +
> > > +Required properties:
> > > +- compatible : Should be "efm32,usart"
> > > +- reg : Address and length of the register set
> > > +- interrupts : Should contain uart interrupt
> > > +
> > > +Example:
> > > +
> > > +uart@0x4000c400 {
> > > +	compatible =3D "efm32,usart";
> > > +	reg =3D <0x4000c400 0x400>;
> > > +	interrupts =3D <15>;
> > > +};
> >=20
> > Do you know if the usart was actually designed by energymicro or li=
censed
> > from another party? If it is a licensed part, it would be better to
> > list the "compatible" value under the company name that made it.
> I don't know so I passed the question to them.
I got an answer here over the holidays and Energy Micro designed the
part.
=20
> > I would suggest that you also support the "clock-frequency" and/or
> > "current-speed" properties that are defined for serial ports, see t=
he
> > of_serial driver.
> I will have a look to find out what they mean and update the patch
> accordingly.
I took that look and I don't understand what they are good for in my
case.
clock-frequency is used to initialize port->uartclk (and helps setting
up port->custom_divisor if current-speed is given). The driver I posted
uses the clk API to determine the clock frequency. So shouldn't the fre=
quency
better be specified in the clk part of the dt? (I don't know yet how a
dt binding for clks should/can look like, so this is a bit speculative,
but I'd expect to have nothing more clk related in a device
specification but a reference to a clk definition.)

Independant of my driver I wonder if defining current-speed should also
result in

	port->flags |=3D UPF_SPD_CUST;

(in of_platform_serial_setup()).

Having said that and taking into account that my driver doesn't use
port->custom_divisor, do you keep suggesting that I should use
"clock-frequency" and/or "current-speed"?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
