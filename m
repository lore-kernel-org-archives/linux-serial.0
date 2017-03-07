From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/10] serdev: add serdev_device_wait_until_sent
Date: Tue, 7 Mar 2017 10:46:06 -0600
Message-ID: <CAL_JsqLLJw_k2pYuoLkYchu1HBCOL+jcBmvXgcqMuxjQ7Ce-jQ@mail.gmail.com>
References: <20170304115833.3538-1-sre@kernel.org> <20170304115833.3538-8-sre@kernel.org>
 <CAL_Jsq+BCE1u6Ysz0FOdh--wHm-PZxqcmqTgQMyDcvQNkYp3gw@mail.gmail.com> <20170307155508.olbiecapfs7ep6xm@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170307155508.olbiecapfs7ep6xm@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 7, 2017 at 9:55 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> On Tue, Mar 07, 2017 at 09:34:49AM -0600, Rob Herring wrote:
>> On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > Add method, which waits until the transmission buffer has been sent.
>> >
>> > Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> > ---
>> >  drivers/tty/serdev/core.c           | 11 +++++++++++
>> >  drivers/tty/serdev/serdev-ttyport.c | 15 ++++++++++++++-
>> >  include/linux/serdev.h              |  3 +++
>> >  3 files changed, 28 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> > index f4c6c90add78..a63b74031e22 100644
>> > --- a/drivers/tty/serdev/core.c
>> > +++ b/drivers/tty/serdev/core.c
>> > @@ -173,6 +173,17 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
>> >  }
>> >  EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
>> >
>> > +void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
>> > +{
>> > +       struct serdev_controller *ctrl = serdev->ctrl;
>> > +
>> > +       if (!ctrl || !ctrl->ops->wait_until_sent)
>> > +               return;
>> > +
>> > +       ctrl->ops->wait_until_sent(ctrl, timeout);
>> > +}
>> > +EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
>> > +
>> >  static int serdev_drv_probe(struct device *dev)
>> >  {
>> >         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
>> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
>> > index d05393594f15..db2bc601e554 100644
>> > --- a/drivers/tty/serdev/serdev-ttyport.c
>> > +++ b/drivers/tty/serdev/serdev-ttyport.c
>> > @@ -14,6 +14,7 @@
>> >  #include <linux/serdev.h>
>> >  #include <linux/tty.h>
>> >  #include <linux/tty_driver.h>
>> > +#include <linux/poll.h>
>> >
>> >  #define SERPORT_ACTIVE         1
>> >
>> > @@ -47,10 +48,13 @@ static void ttyport_write_wakeup(struct tty_port *port)
>> >         struct serport *serport = serdev_controller_get_drvdata(ctrl);
>> >
>> >         if (!test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags))
>> > -               return;
>> > +               goto out;
>> >
>> >         if (test_bit(SERPORT_ACTIVE, &serport->flags))
>> >                 serdev_controller_write_wakeup(ctrl);
>> > +
>> > +out:
>> > +       wake_up_interruptible_poll(&port->tty->write_wait, POLLOUT);
>>
>> Shouldn't this be separate patch?
>
> That change is needed for tty_wait_until_sent to work correctly, which
> starts with a wait_event_interruptible_timeout() on write_wait.

Okay.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
