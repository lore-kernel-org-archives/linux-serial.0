From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] serdev: Update drivers/tty/serdev/Kconfig for ACPI
 support
Date: Sat, 7 Oct 2017 21:57:40 +0200
Message-ID: <8D8274B0-4EF6-41A0-8B76-95023F6DD26C@holtmann.org>
References: <a4051ac2-1156-751d-ec16-2dbbb30b9258@gmail.com>
 <20171007152414.GK2618@localhost>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171007152414.GK2618@localhost>
Sender: linux-acpi-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Johan,

>> The current Kconfig for serdev is not compatible when adding ACPI support as it does not work when built as a module as it requires config SERIAL_DEV_CTRL_TTYPORT to be set. This patch makes serdev compiled into the kernel if selected so that config SERIAL_DEV_CTRL_TTYPORT can be correctly set if requiring ACPI support.
>> ---
>> drivers/tty/serdev/Kconfig | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
>> index cdc6b820cf93..a9fb09a9c105 100644
>> --- a/drivers/tty/serdev/Kconfig
>> +++ b/drivers/tty/serdev/Kconfig
>> @@ -2,7 +2,8 @@
>> # Serial bus device driver configuration
>> #
>> menuconfig SERIAL_DEV_BUS
>> -	tristate "Serial device bus"
>> +	bool "Serial device bus"
>> +	default y
> 
> I understand why you want this (to prevent hci_bcm from breaking), but we
> should generally not have new entries default to y.
> 
>> 	help
>> 	  Core support for devices connected via a serial port.
>> 
>> @@ -11,6 +12,6 @@ if SERIAL_DEV_BUS
>> config SERIAL_DEV_CTRL_TTYPORT
>> 	bool "Serial device TTY port controller"
>> 	depends on TTY
>> -	depends on SERIAL_DEV_BUS != m
>> +	default y
> 
> Same here.
> 
> It may be better to have BT_HCIUART_BCM depend on (or select?)
> SERIAL_DEV_CTRL_TTYPORT instead.

if we move SERIAL_DEV_BUS to bool, then I would just have it be selected by BT_HCIUART_BCM. Frankly the SERIAL_DEV_BUS option is pretty hard to find in the kernel config. And if we depend on TTY, but then select SERIAL_DEV_BUS, I think that is a good compromise.

Regards

Marcel

