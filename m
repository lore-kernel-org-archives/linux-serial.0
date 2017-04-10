From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 02/10] serdev: add serdev_device_wait_until_sent
Date: Mon, 10 Apr 2017 11:12:39 -0500
Message-ID: <CAL_JsqJCjob6NDfHe0r7X3dXPEniKh5vChXhBxfyHZRu7Fov7A@mail.gmail.com>
References: <20170328155939.31566-1-sre@kernel.org> <20170328155939.31566-3-sre@kernel.org>
 <20170408165740.GA20058@kroah.com> <CAL_JsqLK=pbF7Nx-2w98t62N53zbL1oGZpGEbZUK-xg5ms4AZw@mail.gmail.com>
 <20170410140313.GA31894@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170410140313.GA31894-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrey Smirnov <andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

+ Andrey

On Mon, Apr 10, 2017 at 9:03 AM, Greg Kroah-Hartman
<gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Mon, Apr 10, 2017 at 08:46:57AM -0500, Rob Herring wrote:
>> On Sat, Apr 8, 2017 at 11:57 AM, Greg Kroah-Hartman
>> <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
>> > On Tue, Mar 28, 2017 at 05:59:31PM +0200, Sebastian Reichel wrote:
>> >> Add method, which waits until the transmission buffer has been sent.
>> >> Note, that the change in ttyport_write_wakeup is related, since
>> >> tty_wait_until_sent will hang without that change.
>> >>
>> >> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> >> Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
>> >> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> >> ---
>> >> Changes since PATCHv2:
>> >>  * Avoid goto in ttyport_write_wakeup
>> >> ---
>> >>  drivers/tty/serdev/core.c           | 11 +++++++++++
>> >>  drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++----
>> >>  include/linux/serdev.h              |  3 +++
>> >>  3 files changed, 28 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> >> index f4c6c90add78..a63b74031e22 100644
>> >> --- a/drivers/tty/serdev/core.c
>> >> +++ b/drivers/tty/serdev/core.c
>> >> @@ -173,6 +173,17 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
>> >>  }
>> >>  EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
>> >>
>> >> +void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
>> >> +{
>> >> +     struct serdev_controller *ctrl = serdev->ctrl;
>> >> +
>> >> +     if (!ctrl || !ctrl->ops->wait_until_sent)
>> >> +             return;
>> >> +
>> >> +     ctrl->ops->wait_until_sent(ctrl, timeout);
>> >> +}
>> >> +EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
>> >
>> > Is this still needed now that we have serdev_device_write() with an
>> > unlimited timeout available?
>>
>> Yes, because only this waits until the data is on the wire.
>
> What "wire" is that?  The serial wire?  How do you know this?  Many usb
> to serial devices have no way to determine this, given that there is
> another uart hanging off of the end of a USB connection.

Okay, maybe it's just out of linux s/w buffers for h/w which you don't
know. It is the same semantics as tty_wait_until_sent which is
documented as: "Wait for characters pending in a tty driver to hit the
wire, or for a timeout to occur (eg due to flow control)"

> Doesn't serdev_device_write() return when the write is finished?

No, it returns when data is accepted by the tty layer (as serdev has
no buffering of its own).

>  I
> think we need some good documentation here for all of the different
> variants of how to send data, as I'm sure confused...

Fair enough. However, I think that's somewhat orthogonal to this function.

There's 2 modes of sending data which are basically sync and async operation.

- serdev_device_write_buf - Only sends what can be immediately
accepted by lower layers. Caller should provide write_wakeup callback
to be notified.

- serdev_device_write - Sleeps until all data is accepted by lower
layers or a timeout occurs.

It's valid to call serdev_device_wait_until_sent in either case.


Yes, the naming is not the best, but we kept serdev_device_write_buf
to avoid any cross tree merges. We can remove or rename later as it is
just a wrapper now for serdev_device_write.

Rob
