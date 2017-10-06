From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: [PATCH 0/2] ACPI serdev support
Date: Fri, 6 Oct 2017 18:33:42 +1100
Message-ID: <25008d7b-db06-49ad-033f-63c0b72d9c34@gmail.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <A58D9E0F-99FC-4C13-95E8-F60EC61C18B2@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <A58D9E0F-99FC-4C13-95E8-F60EC61C18B2@holtmann.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-serial@vger.kernel.org

On 10/6/17 2:21 AM, Marcel Holtmann wrote:
> Hi Fred,
> 
>> Add ACPI support for serial attached devices.
>>
>> Currently, serial devices are not set as enumerated during ACPI scan for SPI
>> or i2c buses (but not for UART). This should also be done for UART serial
>> devices.
>> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
>>
>> For hci_bcm, this needs Hans de Goede's "Bluetooth: hci_bcm: Add (runtime)pm
>> support to the serdev drv" patches to work.
>>
>> Tested on T100TA with Broadcom BCM2E39.
>>
>> Since RFC:
>>  - Add or reword commit messages
>>  - Rename *serial_slave* to *serial_bus_slave*
>>  - Add specific check for Apple in acpi_is_serial_bus_slave(), thanks to
>>    Lukas Wunner
>>  - Update comment in acpi_default_enumeration()
>>  - Remove patch 3 "Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39"
>>    in favor of patches from Hans de Goede
> 
> I already applied Hans’ patch series to bluetooth-next tree. And I have no objections or comments for these changes. They should be reviewed and acked by the appropriate maintainers as well, but from my side this looks good.
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> 
> What we should discuss on how we get them upstream since besides the Bluetooth subsystem, they cover ACPI and TTY subsystems.
> 
> Regards
> 
> Marcel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hi Marcel,

I've tested these two patches along with the nine patches (plus revert patch) from Hans's series but cannot get bluetooth to work on some of my devices using these two patches as is, specifically on MINIX Z83-4 based PCs. 

In order for bluetooth to function on these devices I submitted the patch 'Bluetooth: BCM: Add support for MINIX Z83-4 based devices' as they require the trigger type IRQF_TRIGGER_FALLING. With Hans's new patch series I've had to modify the patch which I've resubmitted as version 2. However when I apply the second patch from Fred's series 'ACPI / scan: Fix enumeration for special UART devices' I have found the bluetooth device (BCM2EA4) is no longer enumerated. Specifically I've found that the removal of the check 'if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)' causes this failure and if I re-add the 'if' statement then the device is loaded. However a 'btattach' is still required for functioning bluetooth.

In terms on applying the patches I have some questions. 

Like Hans I too would like one of my patches to be applied to v4.14. A lot of people have been waiting to get bluetooth working on the MINIX Z83-4 family of devices so is it possible to get my original (resend) patch for bluetooth on MINIX Z83-4 based devices applied to v4.14? If so and assuming the nine patches from Hans go into v4.15 I can then send an additional patch to extend his second patch (Bluetooth: hci_bcm: Fix setting of irq trigger type) to delete the extra line '.driver_data = &acpi_active_low,'. 

If the original (resend) version of my patch for MINIX Z83-4 cannot be applied to v4.14 then I would like to request that my second version of my patch for MINIX Z83-4 based devices be applied to bluetooth-next tree so that they are included in v4.15.

Finally I would like to request some help in addressing the issue caused by Fred's 'Fix enumeration for special UART devices' patch so as to prevent a regression.

Regards,
Ian


