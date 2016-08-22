From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 16:45:33 +0100
Message-ID: <20160822164533.688a6aec@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <12886761.WF058qtZp8@wuerfel>
        <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
        <2775954.hrE2UdODgU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2775954.hrE2UdODgU@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> Would it make sense then to define a DT binding that can cover these
> four cases independent of the Linux usage:
> 
> a) an existing tty line discipline matched to a tty port
> b) a serio device using the N_MOUSE line discipline (which
>    happens to cover non-mouse devices these days)

These two are the same basic thing

	port x expects ldisc y {with properties ...}

> c) a uart_port slave attached directly to the uart (like in your
>    current code)

c) needs to be a tty_port slave attached directly to a tty_port.
Important detail, but as uart_port is just a subset of tty_port it's a
trivial detail to the DT.

> d) the same slave drivers using a new tty line discipline

and this is also just a/b again.


What use cases and connectivity do you need to describe. Looking at the
ACPI platforms we have

- the expected serial port configuration
- the properties of the port (FIFO etc)
- the power management for the port

- the children of the port
- the power management of the children (at a very simplistic abstracted
  level)

So we want to be able to describe something like

  ttyS0 {
	baud: 1152008N1
	protocol: bluetooth hci
	fixed: yes
	powermanagement: { ... }
  }

and if I look at the usermode crapfest on a lot of Android systems it
looks similar but with the notion of things like being able to describe

-	Use GPIO mode sleeping and assume first char is X to save power

-	Power up, wait n ms, write, read, wait n ms, power down (which
	has to be driven at the ldisc/user level as only the ldisc
	understands transactions, or via ioctls (right now Android user
	space tends to do hardcoded writes to /sys.. gpio to drive power

-	And a few variants thereof (power up on write, off on a timer
  	etc)

So I can imagine wanting to describe something like

-	The bluetooth HCI hardware is managed by gpio 11 (or UART DTR,
	or PMIC n etc)
	The uart can switch into GPIO mode and is gpio 15

or

-	Raise gpio 4 when writing, drop it after 50mS with no read/write

Then the ldisc needs to make port->ops. calls for enabling/disabling low
power mode and expected char, and the uarts that can do it need to
implement the gpio/uart switching and any timers.

Alan
