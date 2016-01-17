From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Sun, 17 Jan 2016 19:38:49 +0000
Message-ID: <20160117193849.69d00c28@lxorguk.ukuu.org.uk>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1D5F146E-D347-453B-9158-8D269F8DA99C-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

> 3. mechanism to open/close the UART by the peer driver (for power management of the
> UART), even if it there is a user-space tty client for the same UART which might or might
> not be open at any time. Manage that in an optimal way.

Power management doesn't have to go via the uart layer. You can even
manage it via the existing sysfs power interfaces (and some Android
devices do in fact do exactly that either by controlling the uart pm or
using a gpio line). Not pretty either but means people are only peeing
in their own backyard. What goes into the kernel costs *everyone*, what
goes in device user space costs only the perpetrator.

It would help to rewind and understand what your needs are not what your
implementation as it stands is. Why can't you just use hciattach like
everyone else ? Improving the PM logic by refining the existing hci
ldisc to be power smart so everyone benefits from any improvement might
be a useful other discussion.

The 8686 is already working in serial mode  with no kernel hackery on
other boards.

> For the GPS chip I am only interested in mctrl and if characters are received. But
> I still want them to arrive at user space through a standard tty interface. So a solution
> that does not interwork and cooperate with the tty layer is not a useable solution for
> my requirements.

Why does it matter how they arrive so long as your user space can
interpret it correctly. Or is your user space some proprietary blob you
can't change ?

Them arriving by a tty interface is fine - no issue with that providing
it doesn't need to mess up core code.

> The reason appears to sit here:
> 
> http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c#L2725
> 
> This means that as soon as some UART is successfully probed, a new tty
> interface is created for it. So we simply have to optionally disable it. This is
> described by requirement 6.

You can just report EBUSY in your open method. You don't need to touch
the serial core layer. It's quite sufficient to do

	if (busy)
		return -EBUSY;

at the top of your uart open method.

> UART drivers we have and work with any of them. This is why I think
> serial-core and struct uart_port is the right level. Even if it looks like a hack.

Your "looks like" instinct is IMHO bang on - looks like a hack, is a
hack. It's also unnecessary as you can hide it in your open method if you
must do that.

> So please wait until I have updated the patch set of our proposal. Then you
> can see that we do not directly touch the tty layer.

The uart layer is part of the tty layer. It's just a glue library to make
writing some tty drivers a bit easier. It's tied deeply to the tty_port
implementation. One day it might even cease to exist replaced by more
generic tty_port helpers.

The tty layer is also an *abstract* concept. There is no real world tie
between physical collections of shift registers that dribble bits to one
another and tty devices in the kernel. You only need a tty driver for
certain types of user interaction.

Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
