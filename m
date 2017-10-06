From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] ACPI serdev support
Date: Fri, 6 Oct 2017 10:16:37 +0200
Message-ID: <6cd58b2f-1ec8-c709-e983-98321bbfea70@gmail.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <A58D9E0F-99FC-4C13-95E8-F60EC61C18B2@holtmann.org>
 <25008d7b-db06-49ad-033f-63c0b72d9c34@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <25008d7b-db06-49ad-033f-63c0b72d9c34-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian W MORRISON <ianwmorrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "bluez mailin list (linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Ian,

Le 06/10/2017 à 09:33, Ian W MORRISON a écrit :
> On 10/6/17 2:21 AM, Marcel Holtmann wrote:
>> Hi Fred,
>>
>>> Add ACPI support for serial attached devices.
>>>
>>> Currently, serial devices are not set as enumerated during ACPI scan for SPI
>>> or i2c buses (but not for UART). This should also be done for UART serial
>>> devices.
>>> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
>>>
>>> For hci_bcm, this needs Hans de Goede's "Bluetooth: hci_bcm: Add (runtime)pm
>>> support to the serdev drv" patches to work.
>>>
>>> Tested on T100TA with Broadcom BCM2E39.
>>>
>>> Since RFC:
>>>   - Add or reword commit messages
>>>   - Rename *serial_slave* to *serial_bus_slave*
>>>   - Add specific check for Apple in acpi_is_serial_bus_slave(), thanks to
>>>     Lukas Wunner
>>>   - Update comment in acpi_default_enumeration()
>>>   - Remove patch 3 "Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39"
>>>     in favor of patches from Hans de Goede
>> I already applied Hans’ patch series to bluetooth-next tree. And I have no objections or comments for these changes. They should be reviewed and acked by the appropriate maintainers as well, but from my side this looks good.
>>
>> Acked-by: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
>>
>> What we should discuss on how we get them upstream since besides the Bluetooth subsystem, they cover ACPI and TTY subsystems.
>>
>> Regards
>>
>> Marcel
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> Hi Marcel,
>
> I've tested these two patches along with the nine patches (plus revert patch) from Hans's series but cannot get bluetooth to work on some of my devices using these two patches as is, specifically on MINIX Z83-4 based PCs.
>
> In order for bluetooth to function on these devices I submitted the patch 'Bluetooth: BCM: Add support for MINIX Z83-4 based devices' as they require the trigger type IRQF_TRIGGER_FALLING. With Hans's new patch series I've had to modify the patch which I've resubmitted as version 2. However when I apply the second patch from Fred's series 'ACPI / scan: Fix enumeration for special UART devices' I have found the bluetooth device (BCM2EA4) is no longer enumerated. Specifically I've found that the removal of the check 'if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)' causes this failure and if I re-add the 'if' statement then the device is loaded. However a 'btattach' is still required for functioning bluetooth.

It seems normal to me that BCM2EA4 is no more enumerated at ACPI level 
as this is moved to serdev.
When removing 'if (ares->data.common_serial_bus.type != 
ACPI_RESOURCE_SERIAL_TYPE_UART)' you stop the serdev module finding the 
Serial UART information. In this case it will not register the device 
and it will fall back to previous behavior needing to use btattach to 
setup Bluetooth.

Can you share:
- btattach you are currently using,
- dmesg with with dynamic debug enabled for serdev and hci_uart modules 
during boot (with Hans's patches, your MINIX Z83-4 patches and mine 
patches).

Regards,

Fred
