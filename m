From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 17:24:00 +0200
Message-ID: <2775954.hrE2UdODgU@wuerfel>
References: <20160818011445.22726-1-robh@kernel.org> <12886761.WF058qtZp8@wuerfel> <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Monday, August 22, 2016 8:38:23 AM CEST Rob Herring wrote:
> On Mon, Aug 22, 2016 at 7:37 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday, August 17, 2016 8:14:42 PM CEST Rob Herring wrote:
> >>
> >> Before I spend more time on this, I'm looking mainly for feedback on the
> >> general direction and structure (the interface with the existing serial
> >> drivers in particular).
> >
> > Aside from the things that have already been mentioned in the discussion,
> > I wonder how this should relate to the drivers/input/serio framework.
> 
> As I mentioned, I did investigate that route.

Ok, sorry for missing that.

> > My impression is that there is some overlap in what you want
> > to do here, and what serio does today as a line discipline on top
> > of a tty line discipline (and on top of other non-uart serial
> > connections), so we should look into whether the two can be unified
> > or not. Here is what I found so far:
> >
> > For all I can tell, serio is only used for drivers/input/ but could
> > easily be extended to other subsystems. It currently uses its own
> > binary ID matching between drivers and devices through user space
> > interfaces, though adding a DT binding for it would appear to be
> > a good idea regardless.
> >
> > It also has a bus_type already, and with some operations defined on
> > it. In particular, it has an "interrupt" method that is used to
> > notify the client driver when a byte is available (and pass
> > that byte along with it). This seems to be a useful addition to
> > what you have. Since it is based on sending single characters
> > both ways, transferring large amounts of data would be slower,
> > but the interface is somewhat simpler. In principle, both
> > character based and buffer based interfaces could coexist here
> > as they do in some other interfaces (e.g. smbus).
> 
> Given that about the only things it really provided are the bus_type
> and associated boilerplate without much of a client interface, it
> seemed to me that creating a new subsystem first made more sense. Then
> we can convert serio to use the new subsystem.

One possible downside of merging later is that we end up having to
support the existing user space ABI for serio that may not fit well
within whatever we come up with independently.

I think there are two other valuable features provided by serio:

- an existing set of drivers written to the API
- the implementation of the tty_ldisc

> I agree we'll probably need a character at time interface, but for
> initial targets a buffer based interface is what's needed.

I think what's more important than the 'character-at-a-time' interface
is the notification about new data. Maybe I missed how you handle that
today, but it seems that you can currently only handle polling
for data using a blocking read.

> > While serio is typically layered on top of tty-ldisc (on top of
> > tty_port, which is often on top of uart_port) or on top of
> > i8042/ps2 drivers, I suppose we could add another back-end on top
> > of uart_port directly to avoid the ldisc configuration in many
> > cases when using devicetree based setup. This should also address
> > the main concern that Alan raised about generality of the
> > subsystem: we'd always leave the option of either manual configuration
> > of the tty-ldisc (for any tty_port) or configuring on-chip devices
> > (using uart_port) directly through DT. Of course the same thing
> > can be done if we hook into tty_port rather than uart_port.
> 
> There are also some uart drivers that register directly with serio.

Right, I think this is done to have automatic probing for the keyboard,
rather than relying on the user space interface configuration.

> I'm also thinking of using an ldisc backend as well as a way to move
> forward with the slave drivers while tty_port rework is being done. Of
> course that doesn't solve the fundamental problems with using an ldisc
> already. Going the tty_port route is going take some time to
> restructure things in the tty layer and require tree wide changes to
> tty drivers.

Would it make sense then to define a DT binding that can cover these
four cases independent of the Linux usage:

a) an existing tty line discipline matched to a tty port
b) a serio device using the N_MOUSE line discipline (which
   happens to cover non-mouse devices these days)
c) a uart_port slave attached directly to the uart (like in your
   current code)
d) the same slave drivers using a new tty line discipline

If we can handle all four, then at least we have some flexibility
with moving around or merging the Linux implementation later.

	Arnd
