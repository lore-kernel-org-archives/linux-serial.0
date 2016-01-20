From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Wed, 20 Jan 2016 18:33:03 +0100
Message-ID: <8AF21869-5D8B-413C-A93B-F311E2F2D7F0@goldelico.com>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com> <569913A1.80606@cogentembedded.com> <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com> <56992959.2020204@hurleysoftware.com> <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com> <744620565.20160116103445@cogentembedded.com> <20160116233157.GA7774@rob-hp-laptop> <3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com> <20160117141912.4aa2e46c@lxorguk.ukuu.org.uk> <1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com> <20160117193849.69d00c28@lxorguk.ukuu.org.uk> <37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com> <20160118111926.0882b422@lxorguk.ukuu.org.uk> <07F3B6C0-0C87-4
 78C-B6DD-5C0EECB42D0D@goldelico.com> <20160118220319.051c9cc0@lxorguk.ukuu.org.uk> <C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22@goldelico.com> <20160119142542.5bf64395@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160119142542.5bf64395-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Next mail.

Am 19.01.2016 um 15:25 schrieb One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>:

>>> Whoever puts the distribution together. The kernel runs init. Beyond that
>>> we don't care. Not our problem. You can boot into emacs if you want.
>> 
>> Well, it is my big problem which goes contrary to our goal to have the best
>> supported platform... We would have to provide and maintain such things
>> so that they are compatible to a plethora of unknown runtime environments.
> 
> Every platform does this and has to do this. GTA04 userspace is different
> to Raspberry PI userspace is different to PC userspace etc. Your graphics
> is different to other people, you don't have a keyboard. All these
> require there is some customisation going on.

Not necessarily. If it is well designed and every problem is solved at the right
place.

In the case of our GPS chip some customization is already there in standard
user space code. Users can just choose or configure some /dev/tty name for
their standard navigation apps and daemons and it everything else should be
done by the kernel.

Neil did describe the goal long ago:

http://neil.brown.name/blog/20120724060722

> 
>>> - There isn't a nice way to bind extra non device specific behaviour to
>>> open and close (but we have the right places to add one)
>>> 
>>> - There isn't a way to monitor rx data (and this is *really* hard to
>>> sort especially when the uart is powered down)
>> 
>> Exactly. This is why we already work 3 years on this topic...
>> 
>> The solution is to optionally keep it powered up - as long as the peer
>> device asks for.
> 
> That won't work on a lot of platforms. They need to power down the uart
> to get the power savings and they expect some kind of other monitor like
> GPIO. Eg some x86 power states are not achievable on certain SoCs with the
> uart powered up. We are already using GPIO triggers on lots of devices,
> even if people haven't noticed what is going on because the firmware
> hides it all or it's done in user space on the device.

Our proposal is completely optional. If there is no UART peer, everything
runs as it does today. Only in the case the device driver needs the UART
to stay powered on it remains powered on.

> 
> For that to work generically we would need a way to go from a serial port
> to a gpio or other monitor setting, described via ACPI and/or DT.

In other words you ask for a device driver... A device driver that knows
which serial port and which gpio. And its exact setting are defined by DT.

This is exactly what we propose. We just need the connection from a
serial interface to that driver to do the monitoring.

> We'd
> also need a way to open a port in powered off mode, or perhaps to be able
> to make open() block for an event on the downed port (just like today you
> can block for carrier), but do it before bringing the port active and thus
> powering it on.
> 
> I don't like the open case because it then means you can't use poll() on
> a set of ports to wait cleanly for an event to power them on but the
> alternative is really hard because you would have to know that no other
> thread of execution or IRQ handler or timer for the port could touch the
> hardware
> 
> - you were the only thread of execution in the driver
> - you held sufficient locks to prevent any other thread of execution
>  entering your tty code and touching the hardware
> 
> and then in effect do
> 
> 	tty_port_shutdown	// power down
> 	port->ops->monitor_rx() (some new method)
> 	tty_port_open		// power up
> 
> We don't normally get into the situation where we have a userspace or
> kernel reference open to a device which may be physically powered off.
> 
> In that sense having the gpio monitoring separate and the relationship
> described to user space (or to some gpio/monitoring driver) by DT is a
> lot cleaner IMHO.
> 
> The open case can be made to work so that opening the tty can block with
> it powered off until an event happens, then powers up the uart. That one
> would be doable.

In our solution it simply powers up the UART and then it sets the mctrl DTR line
This will make the driver wake up the device. I.e. the problem you describe
does not exist.

> 
>>>> What is in your view the right abstraction point for a peer device driver to get
>>>> notified about rx characters (even if the tty is currently not open)?
>>> 
>>> I don't think you have one. A lot of hardware has the receiver and
>>> transceiver physically powered off when the tty is closed. You can't even
>>> touch the registers in some cases (eg a PCI port in D3

Ok, I think it is time to summarize (a little exaggerated) the discussion:

1. technical side:
* you prefer to attach to the tty layer
* you can solve the open/close issue
* you can not solve the rx monitoring issue
* we attach to the uart_port layer
* we have a working solution
* we avoid to handle rx monitoring and rx data processing separately

2. non-techncial side ("belief" level)
* you see the GTA04 as a small corner case which is not worth considering
* you do not account for others who have expressed that they are looking for something very similar
* you point out alternatives:
	* user space daemon
	* /sysfs control
	* virtual gpio
  but we are sitting between all chairs because all subsystems are directing us elsewhere
* you don't wan't anyone to touch uart_port because it may get magically removed
* you don't want to accept new interfaces since you fear that nobody maintains them
* and deprecating is also not a way to go because users will whine instead of following

This is impossible to argue against on technical level (except for the alternatives
because they are differently power efficient and fast - but they are also sort of
"beliefs" unless someone really benchmarks them).

Unfortunately how this discussion turned, breaks my believe that our project is something
exceptional and really welcome :(

Especially as I don't understand your role in this discussion (you are not listed as a MAINTAINER
of tty/serial-core).

And we see that almost all other smartphone projects who use Linux don't even think about
mainlining their things (just a note: our special Community is called "Open Pho(n)e (w. Li)nux"
and therefore *is* Linux (=kernel) based).

They just *use* Linux but don't contribute. If we are happy, they publish the sources
and some volunteer takes the time to integrate it into mainline. But may face the
same barriers as we do.

How this discussion went is a little disillusioning for me about the openness of
open source projects. It is open to discuss, but needs too much energy to really
contribute to the official project. Energy that is urgently missing elsewhere.

So I am now thinking about a third option (because daemon is not a good
option for me): we run our own kernel branch where we maintain these UART peer
patches. And rebase on top of every Linux release that comes. So it will
be available and maintained by the GTA04 project. But not on kernel.org.

That this is the outcome makes me sad because our dream is to be able
to say to everyone who wants "the" kernel: look at kernel.org. But this needs
acceptance. We were not able to get over 3 years of trying.

Going this way saves me a lot of enthusiasm to be put into pushing forwards
other things. And is not much work to maintain. Much less than rewriting the
code according to your proposals.

>From time to time we will tease LKML that there is something. And maybe
as time passes, you might reconsider everything.

BR and thanks for your PoV,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
