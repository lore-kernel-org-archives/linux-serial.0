From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Mon, 18 Jan 2016 22:03:19 +0000
Message-ID: <20160118220319.051c9cc0@lxorguk.ukuu.org.uk>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
	<20160113191542.GA12086@leverpostej>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

> > Your user space can do it (as most Android does).
> 
> How can it do it in automatically in a standardized way without need for daemon support?

You don't need to - it can be device specific. In Android it usually is.
I've never understood why low end devices don't also abstract user space
descriptions of power control into DT nodes as well as kernel properties ?

> * how can the daemon present another /dev/tty so that applications expecting such
> an interface can attach to it (maybe through pty - but isn't that an overkill?)

You don't need to - you can monitor the rx/tx stats via procfs too. Not
pretty but given the daemon can do both the decoding and the monitoring
for your device it all seems a strawman. I'd argue given the sheer range
of ways people PM a GPS that you ought to have those power abstractions
in the user space daemon. They might use kernel methods, they might not.

> * Who makes sure that this daemon is installed and running right after boot up on *any* Linux system
> so that it can always react in case that the chip did start when it should be off?

Whoever puts the distribution together. The kernel runs init. Beyond that
we don't care. Not our problem. You can boot into emacs if you want.

> More generally: what is a kernel good for? Why do we need kernel drivers?

To maintain security, to manage hardware elements that cannot be managed
in user space, and to provide abstractions where the abstraction is
necessary and meaningful to a large number of users (not a corner case
phone device unless the abstraction can be made meaningful and widely
useful).

> Just think about waking up the daemon process if a character is received. This is
> much more costly than calling a notification function in the kernel driver which might
> have to execute just 4 or 5 assembler instructions to decide what to do.

The logical continuation of that is of course not to have user space but
write your entire phone device in ring 0. Point being it is always a
trade off.

Your only way currently to do that is to open the tty and set a line
discipline which does your monitoring then hold it open. We can't stack
ldiscs either. If you want to monitor the line state with the physical
uart receiver powered down then this won't work at all.

> So kernel drivers are sometimes the best solution and more efficient and controllable
> than a user space daemon.

Sometimes but not always. And even if a kernel device is the right
solution to your device that doesn't mean it's general purpose enough to
justify being stuffed upstream. Android is full of "interesting" device
specific tweaks the sum of which would sink the kernel project.

> I understand that. But what is Linux good for? For it's own sake or for
> users and platforms using it? Isn't it that we take it from the community
> and contribute improvements back to it?

Only when the community benefits overall.

> So to me it appears that such a kernel feature is missing. Therefore we
> are discussing it.

I'm glad - because it raises some hard questions and while I don't agree
with some of your starting points (like needing to "open" a uart without
user space) I do agree that

- There isn't a nice way to bind extra non device specific behaviour to
  open and close (but we have the right places to add one)

- There isn't a way to monitor rx data (and this is *really* hard to
  sort especially when the uart is powered down)

- Monitoring mctrl via a nice abstraction is going to need the mctrl
  ops moving from tty to tty_port if you want to use that to trigger tty
  slave behaviour. Doable but a change.

> well I think most driver projects that have expressed that they want to have
> such a solution just want an UART abstraction and not a general tty/serial
> interface with all bells and whistles.

There isn't any difference at the proper abstraction layer. If you wanted
your monitor to power on and off when you open a console that's the same
problem space.

> > uart is just a helper library for some types of
> > port.
> 
> Yes, this is the type of port, our peer devices are directly connected to.

Think about the bigger picture. The high level abstraction is the tty and
the tty_port. But see below as I think your mental model is perhaps wrong
and this is a point of confusion ?

> Another question if we discuss moving the hooks into the tty_port layer:
> 
> is it possible from tty layer to activate the UART without a user-space open()
> and keep it activated after a close()?

No the entire tty layer from top to bottom assumes that you activate a
device by opening it from user space. uart, tty, the lot. The only
corner case weird exception is the serial console and that is a horrible
hack for output only - so anything that fixes that assumption should also
be made to fix the console case.

It's never really mattered because the obscure corner cases where you
want a tty held open the cost is minimal because you just let systemd or
similar own the file handle along with everything else it is hanging on
to.

> > The ones I am familiar with either have the userspace managing it via
> > sysfs (which has some latency advantages when doing clever stuff) or
> > wired the power control to the carrier signal (or that is declared the
> > gpio that controls it to be the carrier).
> 
> How many of these special drivers are in mainline? Our target is to get full support
> by mainline and not run our own kernel branch forever. Because we are not
> yet-another-android-thing-that-just-needs-to-work-for-6-months-and-nobody-cares-
> about-updates-and-GPL.

Both of those techniques work in mainline without kernel changes (at
least on devices where the right gpio sysfs nodes exist). Not pretty and
it would be better to abstract it - although ACPI often abstracts it by
having the kernel power down the uart which calls into ACPI which pokes a
GPIO line so presumably devicetree could learn the same tricks if it got
better at describing power management.

> In all mainlining attempts I know, the user-space control approach was rejected
> because it was said that the kernel should take care of and not a /sysfs or some
> other artificial protocol.

I'm not sure who said that but they obviously didn't look at the real
world 8)

> But anyway, it would not solve the device RX data stream monitoring problem.
> It just could be a solution to know when to turn the chip on or off.

This I think is actually the really hard and interesting part of the
problem. The "tell me about open and close" case is simple and can be
done via tty_port today with minimal extra hooks. There is a small
question about how you set those hooks from a DT binding - mostly because
we want the tty_port method table to be const for security reasons.

The data one is much harder because the abstractions in the tty_port
never see data. It goes direct from the hardware interface (possibly via
a support library liek uart but not always) on to the core of the tty
code. It's also a very hot path on things like older USB 3G modems that
use AT commands. Peter has done minor miracles on making it more
efficient but a USB modem can still really stress a small CPU without any
further callbacks appearing.

> Neil's proposal to monitor the RX line was rejected because it was doing
> nasty tricks with switching pinmux states and setting a temporary interrupt
> on the UART RX line.

For some hardware that is the only way I know to do this because the
power hungry uart receiver is physically powered down. I would have to
check but I *think* that is true even on a modern x86 PC that supports
wakeups via serial - although it may be well hidden in ACPI and firmware.

> Therefore we now want to monitor the RX line "behind" the UART, i.e. on the
> byte stream coming from the UART shift registers.
> 
> This did lead to tty/uart slaves concept and everybody wanted it. Now as we
> have code proposals it should go back to become a user space daemon...

I'm not personally opoosed to the tty slave idea providing it ends up
attached to the tty_port not just uart.

> > 2. If not then hook tty_port_shutdown() and tty_port_open() because those
> > are the right abstraction point. Everything in the kernel that is a tty
> > is a tty_port.
> 
> What is in your view the right abstraction point for a peer device driver to get
> notified about rx characters (even if the tty is currently not open)?

I don't think you have one. A lot of hardware has the receiver and
transceiver physically powered off when the tty is closed. You can't even
touch the registers in some cases (eg a PCI port in D3 state).

I certainly have no good ideas for that specific case because apart from
things buried in stuff like ACPI I don't know of any general purpose way
to ask "how do I make some other piece of hardware peek at the level on
that line and/or trigger on rising or falling edges"

> I think on a level of abstraction of all the different UART drivers. Which is sufficient
> to access the UART by the peer driver. This is why I call it UART-peer (and
> not serial or tty peer).

Not all uarts use the uart layer. It's an optional helper.

> You want to abstract from UART and add all tty bells and whistles. We need them
> for the GPS chip's data stream (because our unknown GPS applications might
> use them) - but other low level UART peer drivers do not even need them.

Ok I think the model you have may be wrong.

The lowest level physical interface abstraction in the whole tty stack is
the tty_port. Every object which can be opened as a tty contains a
tty_port, and the tty_port lifetime is the lifetime of the "physical"
interface to which it is attached.

tty_port requires the device provide a set of methods.

uart optionally sits on top of tty_port. It provides the tty_port methods
and provides a differentish set of low level abstractions more suited to
byte oriended serial port devices. Console doesn't use it, sdio serial
doesn't use it, some uarts don't use it, usb doesn't use it (including
on-board HSIC and SSIC devices), most jtag serials don't use it either.

The tty layer talks to the tty_port layer and also directly to tty
methods provided by the physical device. Conveniently for you the
tty_port abstracts opening and closing the device. Inconveniently for you
it doesn't really mediate receiving and sending data although it does hold
the buffers used.

> > Then all you need is the (possibly device specific) small patches to check
> > the device tree for the bindings on init, and if so set the port->ops
> > methods according to the binding.
> 
> For me it appears to only solves a small part of the whole problem.
> 
> 1. it must be possible to start the UART before any user-space open()

There is no tty layer support at any level to do this, nor any reason
I've seen advanced to justify all the extra complexity needed.

> 2. the UART must be kept running as long as the peer driver wants to
> monitor rx data

Correct, otherwise in the general case the uart may be physically powered
off and the kernel will in fact try aggressively to do so.

> 3. we need a hook to monitor: that (and which) data is incoming

That isn't tty_port related - but it's certainly hard.

> Another aspect is that on a physical RS232 the DTR line is usually
> used to power on/off a remote device (the DCE). Therefore I prefer
> to mimic that in software by intercepting the mctrl changes. This
> additionally allows a client to turn off power of the chip through a "standard"
> protocol, even while the tty file is kept open.

The mctrl currently goes via tty->ops->tiocmset()/tiocmget. That IMHO is
actually an oddity and moving it to the tty_port would make sense anyway
because it's state and behaviour that is persistent at hardware level.

I don't know what Peter thinks about that however.

> > Nobody wants to lose the ability to do so or to move stuff around.
> 
> Indeed. But why would you loose this ability at all?

Because all your hooks would break.

> If significant architectural changes are to be done, you can deprecate this
> API and ask all users (driver authors) to replace it with something new.
> And if they aren't adjusted within some time or no new interface is proposed,
> they get removed. The *I* have the problem back on my table and not you :)
> 
> Isn't this a standard way to handle such situations?
> 
> Things are gradually changed every now and then. And other parts have to
> follow. BTW: most of my work to update a production kernel to a new -rc1 is
> to adjust non-mainline (or not-yet) drivers to such API changes.

What usually happens is the creator the tangle has despite best
intentions ended up somewhere else on another project, their users whine
if we break it, someone screams regression and it all gets dumped on the
maintainers.

Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
