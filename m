From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 1/3] serdev: Add ACPI support
Date: Thu, 7 Sep 2017 13:51:14 -0500
Message-ID: <CAL_JsqJOzQ5Th_JH_gnP4s8C7=ms_RYkxbB+ooCxG3PAUZVDXA@mail.gmail.com>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-2-git-send-email-frederic.danis.oss@gmail.com>
 <1BC8D5B0-EC18-4F20-9CBC-D73CB1765683@holtmann.org> <CAL_JsqK9ucGbg=_0Uu8Pugxd7N4gCYHrb4W3PyKaBq_12TdNYA@mail.gmail.com>
 <9316EE4A-6FDF-4024-9709-E44824D26B4C@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <9316EE4A-6FDF-4024-9709-E44824D26B4C@holtmann.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 7, 2017 at 12:57 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Rob,
>
>>>> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
>>>> ---
>>>> drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
>>>> 1 file changed, 94 insertions(+), 5 deletions(-)
>>
>> [...]
>>
>>>> @@ -404,9 +488,14 @@ int serdev_controller_add(struct serdev_controller *ctrl)
>>>>      if (ret)
>>>>              return ret;
>>>>
>>>> -     ret = of_serdev_register_devices(ctrl);
>>>> -     if (ret)
>>>> +     ret_of = of_serdev_register_devices(ctrl);
>>>> +     ret_acpi = acpi_serdev_register_devices(ctrl);
>>>> +     if (ret_of && ret_acpi) {
>>>> +             dev_dbg(&ctrl->dev, "serdev%d no devices registered: of:%d acpi:%d\n",
>>>> +                     ctrl->nr, ret_of, ret_acpi);
>>>> +             ret = -ENODEV;
>>>>              goto out_dev_del;
>>>> +     }
>>>>
>>>>      dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
>>>>              ctrl->nr, &ctrl->dev);
>>>
>>> Shouldn’t we just consider to always register the controller? Even if there are no devices attached to it.
>>
>> You argued for the opposite at least in regards to a serdev ldisc. :)
>> The problem is we use the success or failure here to decide if we
>> create a tty char dev or not. I guess we could move that decision out
>> of the core and let the tty code check for devices and decide.
>
> we never got the serdev ldisc working. Is there still an attempt to get this working. I frankly don’t know what is best here.

I did get it somewhat working, but haven't been working on it more.
Here's what I said in my last mail to you:

> Okay, I've got this kind of working. I can run "ldattach HCI
> /dev/ttyblah" to start the LL driver (nothing attached, just tries
> firmware loading), then kill ldattach and remove the serdev device.
> And it actually works a 2nd time. I've updated my serdev-ldisc branch
> with the fixes. The real question is what have I broken in the tty
> device. At least "echo rob > /dev/ttyS1" still works (in qemu) after
> attaching and de-attaching.

I pushed out my work to serdev-ldisc-v2 branch on my k.org tree.

Rob
