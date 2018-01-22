From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Remove platform_device support
Date: Mon, 22 Jan 2018 13:01:22 +0100
Message-ID: <83ACB297-D092-4512-AC5B-3AF1137BE194@holtmann.org>
References: <20180121214645.15004-1-hdegoede@redhat.com>
 <0EA71635-F2C7-4908-B4DE-F87328A148D0@holtmann.org>
 <769dd32b-425e-3002-50b5-0d3c707706d4@redhat.com>
 <1516614127.7000.1152.camel@linux.intel.com>
 <0160ba20-9dc9-9921-ab12-3ac58b33e9ae@redhat.com>
 <1516620806.7000.1165.camel@linux.intel.com>
 <0cae9024-887a-45f7-7710-1684f9c0e54e@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0cae9024-887a-45f7-7710-1684f9c0e54e-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bluez mailing list <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Hans,

>>>>> Andy, I see that you added support for bcm bluetooth over a tty
>>>>> using
>>>>> platform_data instead of ACPI enumeration. Can you change the code
>>>>> instantiating the device to instead instantiate a serdev, so that
>>>>> we
>>>>> kill the platform device support in hci_bcm.c and so that users
>>>>> don't
>>>>> need to do a btattach, but instead the kernel will do the attach
>>>>> itself
>>>>> and things will just work ?
>>>> 
>>>> I'm sorry, I can't do this soon, other more priority tasks in a
>>>> pocket.
>>>> 
>>>> The instantiation of the driver is happened in
>>>> arch/x86/platform/intel-
>>>> mid/device_libs/platform_bt.c
>>>> 
>>>> I would help with review of any patches till I would able to look at
>>>> it
>>>> myself.
>>> 
>>> If I manage to come up with patches do you have hardware and time to
>>> test?
>> Yes and I would find half an hour for sure.
> 
> That is great, thank you, but ...
> 
>>> First point of order to get this working as serdev I think is to
>>> modify drivers/tty/serdev/core.c a and then the
>>> serdev_controller_add()
>>> function to somehow recognize the serial port in question, so
>>> something akin to the of_serdev_register_devices(ctrl) /
>>> acpi_serdev_register_devices(ctrl) functions for platform_devs,
>>> assuming
>>> the tty-parent-dev on the Edison SOM is a platform_dev ?
>> tty parent is PCI device there.
>>> Anyways it looks like this will be really hard to do without access
>>> to the hardware.
>> I can do a BAT.
> 
> Right, sorry I was not clear, when I was talking about hardware
> access I was not (not only) referring to testing.
> 
> The problem is that to figure out how to hook all this together
> will require poking around on the hardware, looking in sysfs, finding
> some id we can use in a pci_serdev_register_devices() to add to
> drivers/tty/serdev/core.c so that it only turns the serial port on
> the Edison into a serdev and not somewhere else, etc.
> 
> But thinking about this more, I too have higher priority items on
> my TODO list, so as much as I would like to see this cleaned up,
> lets shelf this for now until you have time to look into this.
> 
> When you do find time, if you've any questions I'm happy to help.

so in theory the Edison board has SFI. Problem is just that I am not sure the SFI on the board is fully correct and contains enough information to identify the serial port correctly.

If no one is willing to help port this over to serdev, then one option is just to rip it out and see who complains. Or include a version that is trying its best and see who reports issues and who helps to fix it. I am now regretting that I accepted the Edison support in the first place, but sadly serdev was not yet fully baked at that point.

Regards

Marcel
