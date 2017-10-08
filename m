From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: [PATCH] serdev: Update drivers/tty/serdev/Kconfig for ACPI
 support
Date: Sun, 8 Oct 2017 14:20:33 +1100
Message-ID: <df3c9f2c-ffb0-35ab-4fa6-e19032b25214@gmail.com>
References: <a4051ac2-1156-751d-ec16-2dbbb30b9258@gmail.com>
 <20171007152414.GK2618@localhost>
 <8D8274B0-4EF6-41A0-8B76-95023F6DD26C@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <8D8274B0-4EF6-41A0-8B76-95023F6DD26C@holtmann.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hovold <johan@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 10/8/17 6:57 AM, Marcel Holtmann wrote:
> Hi Johan,
> 
>>> The current Kconfig for serdev is not compatible when adding ACPI support as it does not work when built as a module as it requires config SERIAL_DEV_CTRL_TTYPORT to be set. This patch makes serdev compiled into the kernel if selected so that config SERIAL_DEV_CTRL_TTYPORT can be correctly set if requiring ACPI support.
<snip>
>> I understand why you want this (to prevent hci_bcm from breaking), but we
>> should generally not have new entries default to y.
>>
<snip>
>> It may be better to have BT_HCIUART_BCM depend on (or select?)
>> SERIAL_DEV_CTRL_TTYPORT instead.
> 
> if we move SERIAL_DEV_BUS to bool, then I would just have it be selected by BT_HCIUART_BCM. Frankly the SERIAL_DEV_BUS option is pretty hard to find in the kernel config. And if we depend on TTY, but then select SERIAL_DEV_BUS, I think that is a good compromise.
> 
> Regards
> 
> Marcel
> 

Hi,

Many thanks for everyone's comments on my earlier patch to Kconfigs for ACPI serdev support.

I've submitted a revised patch set which addresses the points raised by making BT_HCIUART_BCM dependent on SERIAL_DEV_CTRL_TTYPORT which in turn is dependent on SERIAL_DEV_BUS and ensures that if SERIAL_DEV_BUS is selected is the code is build it.

Please can you review and let me know if any further changes are required?

Regards,
Ian
