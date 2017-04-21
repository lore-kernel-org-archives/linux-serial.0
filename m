From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 3/4] tty/serdev: add serdev registration interface
Date: Fri, 21 Apr 2017 17:16:32 +0200
Message-ID: <20170421151632.GI2823@localhost>
References: <20170411170731.4085-1-johan@kernel.org>
 <20170411170731.4085-4-johan@kernel.org>
 <CAL_Jsq+zm3EoO_-9zyNp-Oe1LRrvVQuE6Q8u2wSxY0mbLt2Lpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+zm3EoO_-9zyNp-Oe1LRrvVQuE6Q8u2wSxY0mbLt2Lpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 20, 2017 at 12:52:50PM -0500, Rob Herring wrote:
> On Tue, Apr 11, 2017 at 12:07 PM, Johan Hovold <johan@kernel.org> wrote:
> > Add a new interface for registering a serdev controller and clients, and
> > a helper function to deregister serdev devices (or a tty device) that
> > were previously registered using the new interface.
> >
> > Once every driver currently using the tty_port_register_device() helpers
> > have been vetted and converted to use the new serdev registration
> > interface (at least for deregistration), we can move serdev registration
> > to the current helpers and get rid of the serdev-specific functions.
> 
> I don't really think this is necessary. While in theory any tty port
> can work with serdev, the reality is it only ever going to be used
> with a few. There's about 31 possible drivers. Of those, there's a
> fair number that an attached device is not going to make sense (e.g.
> ISDN CAPI, rfcomm?, goldfish, etc.). Second, right now serdev only
> works with DT binding. There are only 3 drivers supporting DT:
> serial_core, goldfish, and ehv_bytechan.

There are also about ten PCI-based drivers (e.g. rocket.c), which, if
I'm not mistaken, could have an associated DT-node already today. And so
could the SPI-based ifx6x60 driver (modem).

> Likely drivers I'm aware of to use serdev in addition to serial_core
> are USB serial and greybus.  But for those, we currently only could
> support them if the whole bus topology is described in DT. Otherwise,
> we first have to figure out how to apply DT overlays to arbitrary
> devices not described in DT.

There's also cdc-acm and possibly fw-serial (in staging).

And while our current USB device-tree implementation is limited to
describing USB devices, extending this to interfaces, which our USB
drivers bind to, should be easily done (I'm looking into it now).

There's also a comment in serdev about adding support for "ACPI and
platform" descriptions, and you mentioned being able to switch between
cdev and serdev as a possible future extension.

The point is that serdev currently hooks into the tty layer through a
generic function, and if and how a client can be described is just
an implementation detail. Rather than using such a large hammer, it
seems to me that enabling serdev on a per-driver basis after making sure
that nothing breaks (e.g. resources are released on deregistration) is
preferred.

> OTOH, we are at least explicit with what tty ports support serdev.

That would be another benefit.

Johan
