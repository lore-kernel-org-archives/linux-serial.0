From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 02/10] serdev: add serdev_device_wait_until_sent
Date: Mon, 10 Apr 2017 08:46:57 -0500
Message-ID: <CAL_JsqLK=pbF7Nx-2w98t62N53zbL1oGZpGEbZUK-xg5ms4AZw@mail.gmail.com>
References: <20170328155939.31566-1-sre@kernel.org> <20170328155939.31566-3-sre@kernel.org>
 <20170408165740.GA20058@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170408165740.GA20058-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 8, 2017 at 11:57 AM, Greg Kroah-Hartman
<gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Tue, Mar 28, 2017 at 05:59:31PM +0200, Sebastian Reichel wrote:
>> Add method, which waits until the transmission buffer has been sent.
>> Note, that the change in ttyport_write_wakeup is related, since
>> tty_wait_until_sent will hang without that change.
>>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
>> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> ---
>> Changes since PATCHv2:
>>  * Avoid goto in ttyport_write_wakeup
>> ---
>>  drivers/tty/serdev/core.c           | 11 +++++++++++
>>  drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++----
>>  include/linux/serdev.h              |  3 +++
>>  3 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> index f4c6c90add78..a63b74031e22 100644
>> --- a/drivers/tty/serdev/core.c
>> +++ b/drivers/tty/serdev/core.c
>> @@ -173,6 +173,17 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
>>  }
>>  EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
>>
>> +void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
>> +{
>> +     struct serdev_controller *ctrl = serdev->ctrl;
>> +
>> +     if (!ctrl || !ctrl->ops->wait_until_sent)
>> +             return;
>> +
>> +     ctrl->ops->wait_until_sent(ctrl, timeout);
>> +}
>> +EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
>
> Is this still needed now that we have serdev_device_write() with an
> unlimited timeout available?

Yes, because only this waits until the data is on the wire.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
