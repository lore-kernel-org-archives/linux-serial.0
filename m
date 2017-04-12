From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/4] Revert "tty_port: register tty ports with serdev bus"
Date: Wed, 12 Apr 2017 16:39:05 +0200
Message-ID: <20170412143905.GN3119@localhost>
References: <20170411170731.4085-1-johan@kernel.org>
 <20170411170731.4085-2-johan@kernel.org>
 <CAL_JsqJhGDuaPwBH9z0xenr+u=wBp8X9WgDWAm8LuXxg6tA6mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJhGDuaPwBH9z0xenr+u=wBp8X9WgDWAm8LuXxg6tA6mA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 11, 2017 at 08:53:32PM -0500, Rob Herring wrote:
> On Tue, Apr 11, 2017 at 12:07 PM, Johan Hovold <johan@kernel.org> wrote:
> > This reverts commit 8ee3fde047589dc9c201251f07d0ca1dc776feca.
> >
> > The new serdev bus hooked into the tty layer in
> > tty_port_register_device() by registering a serdev controller instead of
> > a tty device whenever a serdev client is present, and by deregistering
> > the controller in the tty-port destructor. This is broken in several
> > ways:
> 
> Just curious, how are you testing this? greybus?

By unbinding a platform device from its serial driver, and by using some
instrumentation code in USB serial.

> > Firstly, it leads to a NULL-pointer dereference whenever a tty driver
> > later deregisters its devices as no corresponding character device will
> > exist.
> >
> > Secondly, far from every tty driver uses tty-port refcounting (e.g.
> > serial core) so the serdev devices might never be deregistered or
> > deallocated.
> >
> > Thirdly, deregistering at tty-port destruction is too late as the
> > underlying device and structures may be long gone by then. A port is not
> > released before an open tty device is closed, something which a
> > registered serdev client can prevent from ever happening. A driver
> > callback while the device is gone typically also leads to crashes.
> >
> > Many tty drivers even keep their ports around until the driver is
> > unloaded (e.g. serial core), something which even if a late callback
> > never happens, leads to leaks if a device is unbound from its driver and
> > is later rebound.
> 
> Isn't this something we want to fix? i.e. everything done in
> probe/release rather than in init/exit.

It keeps some buffers allocated for a while longer than necessary, sure.
But there's quite a few drivers to change and for (non-hotpluggable)
serial drivers it doesn't make that much of difference as I assume
unbinding is mostly done for development purposes.

But we definitely need to make sure all drivers deregisters their
tty/serdev devices before starting to release resources.

> > The right solution here is to add a new tty_port_unregister_device()
> > helper and to never call tty_device_unregister() whenever the port has
> > been claimed by serdev, but since this requires modifying just about
> > every tty driver (and multiple subsystems) it will need to be done
> > incrementally.
> >
> > Reverting the offending patch is the first step in fixing the broken
> > lifetime assumptions. A follow-up patch will add a new pair of
> > tty-device registration helpers, which a vetted tty driver can use to
> > support serdev (initially serial core). When every tty driver uses the
> > serdev helpers (at least for deregistration), we can add serdev
> > registration to tty_port_register_device() again.
> 
> Reverting for 4.11 or not probably isn't that important. There aren't
> any users. I guess if you have a DT with a device added, then you
> could still have some problems.

True, but it only takes a DT child node (with a compatible string) to
trigger, and it's also the overhead added for all users of
tty_port_register_device() (e.g. cdc-acm) mentioned below. And we'd also
avoid enabling something in 4.11 which is then again disabled in 4.12
(for most tty drivers).

> > Note that this also fixes another issue with serdev, which currently
> > allocates and registers a serdev controller for every tty device
> > registered using tty_port_device_register() only to immediately
> > deregister and deallocate it when the corresponding OF node or serdev
> > child node is missing. This should be addressed before enabling serdev
> > for hot-pluggable buses.
> 
> Yeah, hot-plugging is definitely not supported ATM. Though folks are
> already asking about it. We need to figure out how to switch between a
> cdev and serdev.

Yeah, we need to give hotplugging some thought so we don't paint
ourselves into a corner here.

> Generally, the series looks good to me. Thanks for finding and fixing
> these issues. I'll give it a spin soon.

Thanks,
Johan
