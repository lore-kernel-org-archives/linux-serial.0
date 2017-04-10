From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 02/10] serdev: add serdev_device_wait_until_sent
Date: Mon, 10 Apr 2017 16:03:13 +0200
Message-ID: <20170410140313.GA31894@kroah.com>
References: <20170328155939.31566-1-sre@kernel.org>
 <20170328155939.31566-3-sre@kernel.org>
 <20170408165740.GA20058@kroah.com>
 <CAL_JsqLK=pbF7Nx-2w98t62N53zbL1oGZpGEbZUK-xg5ms4AZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLK=pbF7Nx-2w98t62N53zbL1oGZpGEbZUK-xg5ms4AZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 10, 2017 at 08:46:57AM -0500, Rob Herring wrote:
> On Sat, Apr 8, 2017 at 11:57 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Mar 28, 2017 at 05:59:31PM +0200, Sebastian Reichel wrote:
> >> Add method, which waits until the transmission buffer has been sent.
> >> Note, that the change in ttyport_write_wakeup is related, since
> >> tty_wait_until_sent will hang without that change.
> >>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> Acked-by: Pavel Machek <pavel@ucw.cz>
> >> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> >> ---
> >> Changes since PATCHv2:
> >>  * Avoid goto in ttyport_write_wakeup
> >> ---
> >>  drivers/tty/serdev/core.c           | 11 +++++++++++
> >>  drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++----
> >>  include/linux/serdev.h              |  3 +++
> >>  3 files changed, 28 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> >> index f4c6c90add78..a63b74031e22 100644
> >> --- a/drivers/tty/serdev/core.c
> >> +++ b/drivers/tty/serdev/core.c
> >> @@ -173,6 +173,17 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
> >>  }
> >>  EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
> >>
> >> +void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
> >> +{
> >> +     struct serdev_controller *ctrl = serdev->ctrl;
> >> +
> >> +     if (!ctrl || !ctrl->ops->wait_until_sent)
> >> +             return;
> >> +
> >> +     ctrl->ops->wait_until_sent(ctrl, timeout);
> >> +}
> >> +EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
> >
> > Is this still needed now that we have serdev_device_write() with an
> > unlimited timeout available?
> 
> Yes, because only this waits until the data is on the wire.

What "wire" is that?  The serial wire?  How do you know this?  Many usb
to serial devices have no way to determine this, given that there is
another uart hanging off of the end of a USB connection.

Doesn't serdev_device_write() return when the write is finished?  I
think we need some good documentation here for all of the different
variants of how to send data, as I'm sure confused...

thanks,

greg k-h
