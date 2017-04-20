From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] tty/serdev: add serdev registration interface
Date: Thu, 20 Apr 2017 12:52:50 -0500
Message-ID: <CAL_Jsq+zm3EoO_-9zyNp-Oe1LRrvVQuE6Q8u2wSxY0mbLt2Lpw@mail.gmail.com>
References: <20170411170731.4085-1-johan@kernel.org> <20170411170731.4085-4-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411170731.4085-4-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 11, 2017 at 12:07 PM, Johan Hovold <johan@kernel.org> wrote:
> Add a new interface for registering a serdev controller and clients, and
> a helper function to deregister serdev devices (or a tty device) that
> were previously registered using the new interface.
>
> Once every driver currently using the tty_port_register_device() helpers
> have been vetted and converted to use the new serdev registration
> interface (at least for deregistration), we can move serdev registration
> to the current helpers and get rid of the serdev-specific functions.

I don't really think this is necessary. While in theory any tty port
can work with serdev, the reality is it only ever going to be used
with a few. There's about 31 possible drivers. Of those, there's a
fair number that an attached device is not going to make sense (e.g.
ISDN CAPI, rfcomm?, goldfish, etc.). Second, right now serdev only
works with DT binding. There are only 3 drivers supporting DT:
serial_core, goldfish, and ehv_bytechan. Likely drivers I'm aware of
to use serdev in addition to serial_core are USB serial and greybus.
But for those, we currently only could support them if the whole bus
topology is described in DT. Otherwise, we first have to figure out
how to apply DT overlays to arbitrary devices not described in DT.

OTOH, we are at least explicit with what tty ports support serdev.

Rob
