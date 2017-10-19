From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
Date: Thu, 19 Oct 2017 16:32:28 +0200
Message-ID: <115502FA-19DE-439C-A171-3CD5E6D92338@holtmann.org>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <20171011090354.GS4269@localhost>
 <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
 <AA38D4FD-5A35-460D-85CF-380BAB933448@holtmann.org>
 <ac53458d-c910-2d0a-a2ad-e7d21f8a5be7@gmail.com>
 <20171018145608.GB27138@kroah.com> <20171019142354.GE5638@localhost>
 <877ea825-eec5-d982-f962-d67067749009@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <877ea825-eec5-d982-f962-d67067749009@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <greg@kroah.com>, =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Hans,

>>>>>>>> Add ACPI support for serial attached devices.
>>>>>>>> 
>>>>>>>> Currently, serial devices are not set as enumerated during
>>>>>>>> ACPI scan for SPI or i2c buses (but not for UART). This
>>>>>>>> should also be done for UART serial devices.  I renamed
>>>>>>>> *spi_i2c_slave* to *serial_bus_slave* to reflect this.
>>>>>>>> 
>>>>>>>> This needs Johan Hovold's "serdev: fix registration of
>>>>>>>> second slave" patch.
>>>>>>> In theory this series could go in through the acpi-tree
>>>>>>> without my fix. It would only affect an error case where an
>>>>>>> unlikely failure to register an ACPI serdev device, would
>>>>>>> prevent the tty-class device from being registered instead of
>>>>>>> the controller. That is, something we can live with until this
>>>>>>> all converges in 4.15-rc1 if needed.
>>>>>>> 
>>>>>>> That said, I think we should consider taking all serdev
>>>>>>> changes, and therefore also the ACPI patch, through the tty
>>>>>>> tree instead in order to avoid merge conflicts. Rafael?
>>>>>> OK
>>>>>> 
>>>>>> Please feel free to add
>>>>>> 
>>>>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>> 
>>>>>> to the ACPI core change.
>>>>>> 
>>>>>> And I will assume that this series will go in via the tty tree.
>>>>> you have to take these two patches now via the TTY tree now. In
>>>>> case you already marked them as someone else problem ;)
>>>> Is there any problem I missed with those patches?
>>>> Do I have to re-send them?
>>> 
>>> No, they are in my queue, still catching up...
>> I just realised that we cannot merge this series (the second acpi patch)
>> until the hci_intel driver gains serdev support or otherwise PM will
>> break for those devices.
>> Specifically, the hci_intel driver uses similar hacks as the hci_bcm
>> driver does for PM, so we need something like Hans's hci_bcm series also
>> for hci_intel before we can do the switch.
> 
> Hmm, I've never actually seen any hardware use an intel BT HCI connected
> to a serdev, but I guess people did not write that code for fun, so those
> do exist ?

they are all ACPI based and could now start using serdev. Previously they were all driven by btattach.

Regards

Marcel

