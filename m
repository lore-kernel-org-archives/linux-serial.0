From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Mon, 18 Jan 2016 11:19:26 +0000
Message-ID: <20160118111926.0882b422@lxorguk.ukuu.org.uk>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

> I have not counted how often I have explained that, but I am happy to do it
> again.
> 
> * the GTA04 device is an open hackable smartphone platform where power saving is highest priority

Yep I did real the manual before replying last time.

> * the wi2wi,w2sg0084 chip is a GPS chip (it does not understand HCI protocol, it just sends NMEA records if powered on)
> * we want to provide NMEA data through /dev/ttyO1 (it uses an OMAP UART) because a tty port is the most common interface for GPS devices (e.g. a bluetooth GPS mouse is also presented as a tty)
> * we want the chip to automatically power up as soon (but not before) as any gps client opens /dev/ttyO1 (or activates the DTR mctrl)
> * we want the chip to automatically power down if no process uses /dev/ttyO1 any more
> The standard logic of GPS daemons and applications is to receive
> NMEA records through some serial /dev/tty.
> 
> Please tell me how power on/off management can be done without intercepting
> somewhere in the kernel that /dev/ttyO1 is opened/closed (which is not the same
> as suspend/resume).

Your user space can do it (as most Android does).

> Secondly, the chip has a very special logic that it may end up in the opposite
> power state than the kernel driver thinks. Especially after boot it simply can not
> know the state. The chip might be powered up/send records or might not.
> 
> A driver can only detect such a discrepancy if it thinks the GPS chip is powered off,
> but there is still data coming through the UART.

To play devils advocate a moment: so can user space.

> Please tell me how this situation can be detected without monitoring the data stream
> in the kernel going to /dev/ttyO1 - from the UART behind it - even if /dev/ttyO1 is closed.
> 
> This are *our* requirements.

The Linux kernel runs on billions of devices. If we put kernel hooks in
random glue layers for every weird little platform corner case it would
collapse in a heap. Those are *our* requirements. Thus it is good to push
back on stuff that can be done in user space just as well.

> Other people think that our approach helps to solve their driver architecture as well
> and have added their requirements on top. This is why I attempt to make the API
> more general than just for our own use-cases.

If it's going to be generic then it needs to be dealing with this at the
tty/tty_port level not uart. uart isn't a general serial abstraction,
tty_port and tty are. uart is just a helper library for some types of
port.

In practise that ought to be a small distinction. If you have to bind
some kind of device logic to the port activation/deactivation then bind
it to tty_port not uart. uart open/close is basically an implementation
of the tty port->ops->activate() and port->ops->shutdown() method.

> 
> > 
> > The 8686 is already working in serial mode  with no kernel hackery on
> > other boards.
> 
> You appear to mix the chips we are talking about. We have the w2sg0084 gps
> chip and a w2cbw003, which is a combo of an 8686 and a CSR BT serial device.
> 
> Both chips need somehow to be powered on or off if not used. Ideally automatically
> at the moment no user space client is using them any more. For the bluetooth side
> the moment to power off is when a hciattach is killed.
> 
> Other 8686 boards appear not to have such critical power restrictions and then they
> just leave power on.

The ones I am familiar with either have the userspace managing it via
sysfs (which has some latency advantages when doing clever stuff) or
wired the power control to the carrier signal (or that is declared the
gpio that controls it to be the carrier).

> No, the opposite: it can be any open source application, which by principle
> could be changed in any way. But we can't because we as the hardware
> platform+kernel developers have no (and don't want to have) control over
> the the user space. So we have to fit into the standards of the user space.

Well the standard of user space today *is* managing via sysfs or the
carrier trick. Take a look at all the Android devices out there - they
all tackle it that way. Some of them do very aggressive power management
as you can imagine. But yes that's ugly 8)

> Here, we need to solve the problem to power down the chip if NO
> tty port is open any more.

port->ops->shutdown in the tty layer.

> > You can just report EBUSY in your open method. You don't need to touch
> > the serial core layer. It's quite sufficient to do
> > 
> > 	if (busy)
> > 		return -EBUSY;
> > 
> > at the top of your uart open method.
> 
> Hm. I am not writing a new UART driver or touch them. I am using the existing
> ones (omap-serial). They all call this uart_add_one_port() in their probe() function.

At the moment. But they may not, or they may get folded together.

> If I would modify just omap-serial, people would for sure complain that the solution
> is not generic enough.

I would say two things

1. If you modify omap-serial it's not that generic, but it doesn't mess
with library code it shouldn't. That is better than messing with uart
layer code. It also solves your problem and localises the solution. That
to me is a win.

2. If not then hook tty_port_shutdown() and tty_port_open() because those
are the right abstraction point. Everything in the kernel that is a tty
is a tty_port.

> > The uart layer is part of the tty layer. It's just a glue library to make
> > writing some tty drivers a bit easier.
> 
> Yes, and exactly that is helpful to solve this problem. We attach only to the
> glue layer and everything is done.

It's the wrong place - it's not the abstraction.

What I am trying to say is that if you do this generically then add the
needed method calls into tty_port_open and tty_port_shutdown, make them
run after port->ops->activate and before port->ops->shutdown so there is
a sensible ordering if you need to do something to the port itself, and
also so on open it only runs if port->ops->activate succeeded.

Something like

       if (!test_bit(ASYNCB_INITIALIZED, &port->flags)) {
                clear_bit(TTY_IO_ERROR, &tty->flags);
                if (port->ops->activate) {
                        int retval = port->ops->activate(port, tty);
                        if (retval) {
                                mutex_unlock(&port->mutex);
                                return retval;
                        }
                }
		/* Wake the device if we have one tied to us */
		if (port->ops->activate_slave)
			port->ops->activate_slave(port, tty);
                set_bit(ASYNCB_INITIALIZED, &port->flags);
	}

Then all you need is the (possibly device specific) small patches to check
the device tree for the bindings on init, and if so set the port->ops
methods according to the binding.

> > It's tied deeply to the tty_port
> > implementation. One day it might even cease to exist replaced by more
> > generic tty_port helpers.
> 
> Is there a concrete plan to change that? Is anyone working on it now?

Nobody wants to lose the ability to do so or to move stuff around.

> If not, I would not worry about this, because it is not specific to the problem
> we want to solve today (to be precise: since 3 years).

You solve it today you block other things for the next 20 years. The
kernel has to deal in long terms.

> > The tty layer is also an *abstract* concept. There is no real world tie
> > between physical collections of shift registers that dribble bits to one
> > another and tty devices in the kernel. You only need a tty driver for
> > certain types of user interaction.
> 
> And we need it to process the GPS data by standard applications and tools.

Ok - no problem with that, and for what you've explained that bit makes
sense.

Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
