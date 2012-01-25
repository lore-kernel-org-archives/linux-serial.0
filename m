From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial/efm32: add new driver
Date: Wed, 25 Jan 2012 16:56:55 +0000
Message-ID: <201201251656.55514.arnd@arndb.de>
References: <20111221202847.4ffeba10@bob.linux.org.uk> <20111223204428.GI24496@pengutronix.de> <20120109103458.GD14252@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50904 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab2AYQ5H (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Jan 2012 11:57:07 -0500
In-Reply-To: <20120109103458.GD14252@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, kernel@pengutronix.de, linux-serial@vger.kernel.org

On Monday 09 January 2012, Uwe Kleine-K=F6nig wrote:
> On Fri, Dec 23, 2011 at 09:44:28PM +0100, Uwe Kleine-K=F6nig wrote:
> =20
> > > I would suggest that you also support the "clock-frequency" and/o=
r
> > > "current-speed" properties that are defined for serial ports, see=
 the
> > > of_serial driver.
> > I will have a look to find out what they mean and update the patch
> > accordingly.
> I took that look and I don't understand what they are good for in my
> case.
> clock-frequency is used to initialize port->uartclk (and helps settin=
g
> up port->custom_divisor if current-speed is given). The driver I post=
ed
> uses the clk API to determine the clock frequency. So shouldn't the f=
requency
> better be specified in the clk part of the dt? (I don't know yet how =
a
> dt binding for clks should/can look like, so this is a bit speculativ=
e,
> but I'd expect to have nothing more clk related in a device
> specification but a reference to a clk definition.)

The binding for 8250 serial ports is documented at
http://www.openfirmware.org/1275/bindings/devices/html/serial.html

If you can always use the clk API to find out the base clock rate,
that's probably fine, I was mostly trying to make sure we don't
introduce another duplicate API for this.

The "current-speed" property is used to describe the baud rate that
should be used by the kernel for this port in order to talk to
devices connected to the port. This is very useful if you need to
connect the boot console to a fixed-rate device, and would get
used instead of the 115200 default you have when nothing else
is configured on the command line. I don't really know why
there is no respective option to set parity or flow control

> Independant of my driver I wonder if defining current-speed should al=
so
> result in
>=20
> 	port->flags |=3D UPF_SPD_CUST;
>=20
> (in of_platform_serial_setup()).

I believe that is not needed because you don't call uart_get_divisor,
which would be the only place that looks at this flag.

> Having said that and taking into account that my driver doesn't use
> port->custom_divisor, do you keep suggesting that I should use
> "clock-frequency" and/or "current-speed"?

clock-frequency seems to be unnecessary, but current-speed would
still make sense. custom_divisor is simply the method that of_serial
uses to communicate the bit rate to the 8250 base driver, but you
could set the divisor directly.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
