From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 18:02:54 +0100
Message-ID: <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <12886761.WF058qtZp8@wuerfel>
        <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
        <2775954.hrE2UdODgU@wuerfel>
        <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> > I think there are two other valuable features provided by serio:
> >
> > - an existing set of drivers written to the API
> > - the implementation of the tty_ldisc  
> 
> True, though I'd expect little of the data flow part of it to be reused.

Then your design is broken.

> - a child of the uart node
> - a reg property containing the line number if the parent has multiple
> uarts (I'd expect this to rarely be used).

That surprises me as for current x86 platforms it would be the norm,
except that we use ACPI.

> - baudrate and other line configuration (though I would expect the
> slave driver to know all this and set it w/o DT. Also, we already have
> a way to set baudrate in the parent node at least.)
> - other standard device properties for interrupt, gpios, regulators.
> 
> Also to consider is whether muxing of multiple slaves is needed. It's
> not anything I've seen come up, but it's not hard to imagine. I think
> that can be considered later and shouldn't impact the initial binding
> or infrastructure.

You can describe the child of the serial device as a mux and the children
of the mux as whatever so it comes out fine when you get to that point.

Alan
