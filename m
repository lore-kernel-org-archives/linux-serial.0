From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Tue, 19 Jan 2016 14:25:42 +0000
Message-ID: <20160119142542.5bf64395@lxorguk.ukuu.org.uk>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
	<1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com>
	<20160115110106.GA3262@leverpostej>
	<69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com>
	<569913A1.80606@cogentembedded.com>
	<CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com>
	<56992959.2020204@hurleysoftware.com>
	<CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com>
	<744620565.20160116103445@cogentembedded.com>
	<20160116233157.GA7774@rob-hp-laptop>
	<3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com>
	<20160117141912.4aa2e46c@lxorguk.ukuu.org.uk>
	<1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com>
	<20160117193849.69d00c28@lxorguk.ukuu.org.uk>
	<37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com>
	<20160118111926.0882b422@lxorguk.ukuu.org.uk>
	<07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D@goldelico.com>
	<20160118220319.051c9cc0@lxorguk.ukuu.org.uk>
	<C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

> > Whoever puts the distribution together. The kernel runs init. Beyond that
> > we don't care. Not our problem. You can boot into emacs if you want.
> 
> Well, it is my big problem which goes contrary to our goal to have the best
> supported platform... We would have to provide and maintain such things
> so that they are compatible to a plethora of unknown runtime environments.

Every platform does this and has to do this. GTA04 userspace is different
to Raspberry PI userspace is different to PC userspace etc. Your graphics
is different to other people, you don't have a keyboard. All these
require there is some customisation going on.

> > - There isn't a nice way to bind extra non device specific behaviour to
> >  open and close (but we have the right places to add one)
> > 
> > - There isn't a way to monitor rx data (and this is *really* hard to
> >  sort especially when the uart is powered down)
> 
> Exactly. This is why we already work 3 years on this topic...
> 
> The solution is to optionally keep it powered up - as long as the peer
> device asks for.

That won't work on a lot of platforms. They need to power down the uart
to get the power savings and they expect some kind of other monitor like
GPIO. Eg some x86 power states are not achievable on certain SoCs with the
uart powered up. We are already using GPIO triggers on lots of devices,
even if people haven't noticed what is going on because the firmware
hides it all or it's done in user space on the device.

For that to work generically we would need a way to go from a serial port
to a gpio or other monitor setting, described via ACPI and/or DT. We'd
also need a way to open a port in powered off mode, or perhaps to be able
to make open() block for an event on the downed port (just like today you
can block for carrier), but do it before bringing the port active and thus
powering it on.

I don't like the open case because it then means you can't use poll() on
a set of ports to wait cleanly for an event to power them on but the
alternative is really hard because you would have to know that no other
thread of execution or IRQ handler or timer for the port could touch the
hardware

- you were the only thread of execution in the driver
- you held sufficient locks to prevent any other thread of execution
  entering your tty code and touching the hardware

and then in effect do

	tty_port_shutdown	// power down
	port->ops->monitor_rx() (some new method)
	tty_port_open		// power up

We don't normally get into the situation where we have a userspace or
kernel reference open to a device which may be physically powered off.

In that sense having the gpio monitoring separate and the relationship
described to user space (or to some gpio/monitoring driver) by DT is a
lot cleaner IMHO.

The open case can be made to work so that opening the tty can block with
it powered off until an event happens, then powers up the uart. That one
would be doable.

> >> What is in your view the right abstraction point for a peer device driver to get
> >> notified about rx characters (even if the tty is currently not open)?
> > 
> > I don't think you have one. A lot of hardware has the receiver and
> > transceiver physically powered off when the tty is closed. You can't even
> > touch the registers in some cases (eg a PCI port in D3 state).
> 
> This is why I want to keep the UART open as long as the peer driver
> tells to do so.

For the cases that works this is the same as user space keeping the tty
open. You might want a peer driver just to avoid continually waking up
user space, but that could probably also be an ldisc.
 
> >> For me it appears to only solves a small part of the whole problem.
> >> 
> >> 1. it must be possible to start the UART before any user-space open()
> > 
> > There is no tty layer support at any level to do this, nor any reason
> > I've seen advanced to justify all the extra complexity needed.
> 
> This is why I want to do it on the uart_port.

The problem is pretty much the same for uart and tty_port. There is also
no reason you've yet given that to me justifies need to open it from
kernel space.

However doing the open/close hooks is the same in both cases. The termios
one for modem state monitoring is a tiny shift of a method between two
places (and the ripple of the change through all the drivers). The one
that causes all the trouble is monitoring receive data because that goes
directly via the tty flip buffers if the device is powered on, so there
is nowhere to intercept it cleanly. Not only that but when the port is
present but not bound to a userspace tty most devices don't even read the
bytes from the hardware interface and queue them.

If we take your patch then

The hook to uart_update_mctrl becomes a hook to the tty_port termios
method (which right now is for historical reasons still in tty but can
move)

The hook to uart_port_startup becomes the hook I posted to the
tty_port_open method. Probably the method needs to be a
tty_port->slave_ops and not tty_port->ops because ops is const and shared
between physical interfaces. That's a detail.

The hook to uart_port_shutdown becomes a hook to tty_port_shutdown.

Those three are fairly trivial.

Your patch to uart_insert_char doesn't work anyway as that is an
*optional* helper that only some uart drivers use.

That would mean
- Firmware describes the port relationship
- The firmware parsing installs the tty_port->slave_ops pointer at boot
  time or when the module for the serial port is loaded. (Care needed for
  serial console that gets one), and does the right thing on hot
  unplugging, and has the right locking for unplug while scanning

that is much as you have in the patch now, but with the right abstraction
layer and I think some locking tweaks.

> >> 2. the UART must be kept running as long as the peer driver wants to
> >> monitor rx data
> > 
> > Correct, otherwise in the general case the uart may be physically powered
> > off and the kernel will in fact try aggressively to do so.
> > 
> >> 3. we need a hook to monitor: that (and which) data is incoming
> > 
> > That isn't tty_port related - but it's certainly hard.
> 
> Not, if we do it on uart_port level... It already works with two not very
> big patches.

If you require the uart to be powered up then your "peer" is just a line
discipline pushed onto the port by a userspace process holding the tty
open.

So I'd do

	open /dev/ttyWhatever
	set the ldisc to a new "don't wake me until X happens" ldisc
	poll (blocks until X happens)
	set the ldisc to N_TTY
	do stuff
	close

> > Because all your hooks would break.
> 
> Only if you do big changes. That is why I ask if such big changes are planned
> or can be anticipated. They probably don't come unexpectedly around the corner.

They often do. 

> And it looks that we either need a kernel solution or a user space solution - but
> none makes the responsible party happy... Although that is not a criterion for
> a whole system architecture. There the more efficient solution should be done.
> Efficient in terms of LOC, speed, maintenance requirements.

As measured for the sum of the kernel community not just Gta04 users.

Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
