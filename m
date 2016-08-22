From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 17:07:06 -0400
Message-ID: <FAD4CEF6-93F4-41D1-915E-823867F740F7@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <12886761.WF058qtZp8@wuerfel> <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com> <2775954.hrE2UdODgU@wuerfel> <20160822164533.688a6aec@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822164533.688a6aec@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Alan,

>> Would it make sense then to define a DT binding that can cover these
>> four cases independent of the Linux usage:
>> 
>> a) an existing tty line discipline matched to a tty port
>> b) a serio device using the N_MOUSE line discipline (which
>>   happens to cover non-mouse devices these days)
> 
> These two are the same basic thing
> 
> 	port x expects ldisc y {with properties ...}
> 
>> c) a uart_port slave attached directly to the uart (like in your
>>   current code)
> 
> c) needs to be a tty_port slave attached directly to a tty_port.
> Important detail, but as uart_port is just a subset of tty_port it's a
> trivial detail to the DT.
> 
>> d) the same slave drivers using a new tty line discipline
> 
> and this is also just a/b again.
> 
> 
> What use cases and connectivity do you need to describe. Looking at the
> ACPI platforms we have
> 
> - the expected serial port configuration
> - the properties of the port (FIFO etc)
> - the power management for the port
> 
> - the children of the port
> - the power management of the children (at a very simplistic abstracted
>  level)
> 
> So we want to be able to describe something like
> 
>  ttyS0 {
> 	baud: 1152008N1
> 	protocol: bluetooth hci
> 	fixed: yes
> 	powermanagement: { ... }
>  }

we also need to know what Bluetooth vendor is there. Since we need to match the vendor to the firmware loading and configuration.

Additionally there might be PCM audio configurations that need to be considered. Since we have to configure direct PCM interconnect with the audio codec.

> and if I look at the usermode crapfest on a lot of Android systems it
> looks similar but with the notion of things like being able to describe
> 
> -	Use GPIO mode sleeping and assume first char is X to save power
> 
> -	Power up, wait n ms, write, read, wait n ms, power down (which
> 	has to be driven at the ldisc/user level as only the ldisc
> 	understands transactions, or via ioctls (right now Android user
> 	space tends to do hardcoded writes to /sys.. gpio to drive power
> 
> -	And a few variants thereof (power up on write, off on a timer
>  	etc)

Actually the sad part about the Android mess is that we can fix it for Bluetooth. We have HCI User Channel that allows to grab a HCI device and assign it to Bluedroid stack on Android. So it would work with whatever bus or whatever vendor is underneath. All this hacking would go away. And we have used this successfully for Intel based Android platforms. We know this works.

> So I can imagine wanting to describe something like
> 
> -	The bluetooth HCI hardware is managed by gpio 11 (or UART DTR,
> 	or PMIC n etc)
> 	The uart can switch into GPIO mode and is gpio 15
> 
> or
> 
> -	Raise gpio 4 when writing, drop it after 50mS with no read/write
> 
> Then the ldisc needs to make port->ops. calls for enabling/disabling low
> power mode and expected char, and the uarts that can do it need to
> implement the gpio/uart switching and any timers.

I now wonder if we can not just turn the ldisc into a bus. So we have a ldisc bus that exposes devices that have no business of having a userspace /dev/ttyX exposed. And our Bluetooth UART support just turns into a ldisc driver on the ldisc bus.

One of the problems is that attaching the ldisc from userspace you still need to figure out what /dev/ttyX you get assigned in the end. And figure out which one is the Bluetooth UART. If we want single images where things just work out of the box, we need to get extra information for doing auto-detection. So some sort of bus enumeration is key to make this work smoothly.

Regards

Marcel
