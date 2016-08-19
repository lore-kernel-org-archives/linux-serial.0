From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 19 Aug 2016 12:03:55 +0100
Message-ID: <20160819120355.587a5e3f@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <20160818102208.GA20476@kroah.com>
        <CAL_Jsq+Va2OF1pYTivH8YN1GKsiaT1eTOaSv607K_V+H+0Buvw@mail.gmail.com>
        <20160818160449.328b2eec@lxorguk.ukuu.org.uk>
        <CAL_JsqKruW=XG6XFZGh8aQKOpmoqFj=bN-s3NLXi7fbLcDhzWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKruW=XG6XFZGh8aQKOpmoqFj=bN-s3NLXi7fbLcDhzWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> > 2. Only n_tty actually uses the tty_port layer buffering  
> 
> So the first point on 4K is not enough only applies to n_tty? If I
> don't need the tty_port buffer logic, then how am I re-inventing it?

There are two layers of buffering.

1. Some devices buffer bytes into an internal ring buffer in the uart
layer and then kick a handler to push them into the tty layer separately
to the IRQ. For dumb uarts that is pretty much unavoidable. At high speed
you don't have time to do processing.

2. The majority of drivers use the tty_buffer.c buffering alone. Quite a
few that use the #1 above could in fact just use this today but for
historical reasons don't.

The buffering needed to meet latency needs to be sufficient for the
hardware and is always needed on devices that have that problem.

The rest of the buffering functionality is in fact ultimately only used
by n_tty because every other ldisc implements the receive function as

	alloc something
	copy the data
	queue to somewhere
	return

> > At that point you can set tty_port->rx to point to the
> > tty_flip_buffer_push() and everyone can use it. Slow ones will want to
> > queue to a ring buffer then do tty_port->rx (where we do the flush_buffer
> > now), fast ones will do the ->rx directly.  
> 
> I think I understand this for rx, but let's back-up to the
> registration and transmit paths. tty_port and uart_port have nothing
> in common other than name, and tty_port has nothing to do with i/o. So

Yes they do - every uart has a tty_port.

> we still need tty_operations which all take a tty_struct and implies a
> tty_driver. It seems to me we would need surgery all over the tty code
> to make chardev, ldisc and anything else I'm not aware of optional.

Very little today *needs* a tty attached. The callbacks already handle
the no tty case (because they can be called asynchronously to a tty
closing)

The open and close are doable directly, and it is deliberate and ready
for this kind of use that we have port->ops->activate,
tty_port_set_initialized() and tty_port_shutdown() so just need to add a
couple of abstracted out bits of code to give us

	tty_port_activate();
	tty_port_shutdown();

as the pair of methods needed for non tty enabling/disabling of the port

Right now you need tty for transmission because tty manages the outbound
queueing, and for termios changes. Termios is historically attached to
the tty structure and the fact tty->ops->set_termio[sx] exists in tty->
is just a historical quirk. They can just move.

The writing part is slightly harder to untangle. The tty->ops->write()
passes a tty and there are three ways that gets used

1. tty->driver_data to get the underlying device object. That can easily
be moved to port->driver_data

2. access to flow control state tty->stopped and tty->hw_stopped.

Again these can migrate along with the termios bits that are rferenced

3. Calling back to do wakeups, throttle and unthrottle

These again could be migrated to the port, and whatever port writing
method you implement will anyway have to implement this simply because
you have to do flow control and in some cases flow control is pure
software.


The transmit side is the hardest part by far but the infrastructure is
there, and already handles the nasty cases you'll have to deal with like
a transmit being triggered from a receive.

Alan
