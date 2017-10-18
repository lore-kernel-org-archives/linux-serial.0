From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
Date: Wed, 18 Oct 2017 16:46:05 +0200
Message-ID: <ac53458d-c910-2d0a-a2ad-e7d21f8a5be7@gmail.com>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <20171011090354.GS4269@localhost>
 <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
 <AA38D4FD-5A35-460D-85CF-380BAB933448@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <AA38D4FD-5A35-460D-85CF-380BAB933448@holtmann.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <greg@kroah.com>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Greg, Rafael, Marcel,

Le 11/10/2017 à 20:32, Marcel Holtmann a écrit :
> Hi Greg,
>
>>>> Add ACPI support for serial attached devices.
>>>>
>>>> Currently, serial devices are not set as enumerated during ACPI scan for SPI
>>>> or i2c buses (but not for UART). This should also be done for UART serial
>>>> devices.
>>>> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
>>>>
>>>> This needs Johan Hovold's "serdev: fix registration of second slave" patch.
>>> In theory this series could go in through the acpi-tree without my
>>> fix. It would only affect an error case where an unlikely failure to
>>> register an ACPI serdev device, would prevent the tty-class device from
>>> being registered instead of the controller. That is, something we can
>>> live with until this all converges in 4.15-rc1 if needed.
>>>
>>> That said, I think we should consider taking all serdev changes, and
>>> therefore also the ACPI patch, through the tty tree instead in order to
>>> avoid merge conflicts. Rafael?
>> OK
>>
>> Please feel free to add
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> to the ACPI core change.
>>
>> And I will assume that this series will go in via the tty tree.
> you have to take these two patches now via the TTY tree now. In case you already marked them as someone else problem ;)
>
> Regards
>
> Marcel

Is there any problem I missed with those patches?
Do I have to re-send them?

Regards,

Fred
