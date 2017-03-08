From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 08/10] serdev: add serdev_device_get_cts
Date: Wed, 8 Mar 2017 09:13:56 -0600
Message-ID: <CAL_JsqL86La9R=mcnC9Hgba9yWV8Zpbewpiir5_=P7pwiDqkXA@mail.gmail.com>
References: <20170304115833.3538-1-sre@kernel.org> <20170304115833.3538-9-sre@kernel.org>
 <CAL_Jsq+6NCC35zBMhvNhXug2sYmBqBoJ20pgdREhvRPGzePNkw@mail.gmail.com> <20170307211243.zecbitmkbozd3s2j@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170307211243.zecbitmkbozd3s2j@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 7, 2017 at 3:12 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Rob,
>
> On Tue, Mar 07, 2017 at 10:03:37AM -0600, Rob Herring wrote:
>> On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre@kernel.org> wrote:
>> > Add method to get current CTS line state.
>> >
>> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
>> > ---
>> >  drivers/tty/serdev/core.c           | 11 +++++++++++
>> >  drivers/tty/serdev/serdev-ttyport.c | 15 +++++++++++++++
>> >  include/linux/serdev.h              |  6 ++++++
>> >  3 files changed, 32 insertions(+)
>> >
>> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> > index a63b74031e22..36eb3dfb1477 100644
>> > --- a/drivers/tty/serdev/core.c
>> > +++ b/drivers/tty/serdev/core.c
>> > @@ -184,6 +184,17 @@ void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
>> >  }
>> >  EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
>> >
>> > +bool serdev_device_get_cts(struct serdev_device *serdev)
>>
>> I wonder if this should just be the wait for cts in the core. I think
>> that would be the common use for reading the CTS state. IIRC, I saw
>> some other device needing the same thing.
>
> mh. I think it fits nicely to serdev_device_set_rts(). But I guess
> it makes sense to have the wait feature directly in serdev. So I
> suggest to add the function in addition to the simple get_cts
> function. Does that make sense to you?

Sure. You should be able to implement that just in the core. Then the
host driver stays simple and we're not duplicating the wait in host
drivers (not that we expect to have lots of host drivers).

Rob
