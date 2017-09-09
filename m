From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 2/3] ACPI / scan: Fix enumeration for special UART devices
Date: Sat, 9 Sep 2017 20:49:08 +0200
Message-ID: <A4210376-D665-4D24-B273-90ED033D4DE1@holtmann.org>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-3-git-send-email-frederic.danis.oss@gmail.com>
 <2C6832A9-2BA5-42CD-A398-CD7BA5AE7C8E@holtmann.org>
 <ce2e3693-437b-1e51-61ad-3873a9e0f0f4@gmail.com>
 <20170909172406.GA32618@wunner.de>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170909172406.GA32618@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Lukas,

>>>> --- a/include/acpi/acpi_bus.h
>>>> +++ b/include/acpi/acpi_bus.h
>>>> @@ -211,7 +211,7 @@ struct acpi_device_flags {
>>>> 	u32 of_compatible_ok:1;
>>>> 	u32 coherent_dma:1;
>>>> 	u32 cca_seen:1;
>>>> -	u32 spi_i2c_slave:1;
>>>> +	u32 serial_slave:1;
>>>> 	u32 reserved:19;
>>>> };
>>> I am not an ACPI expert, but wouldn't we better have a serial_bus_slave
>>> here. And the serial_bus_slave can be either UART or I2C? Or have a
>>> pretty good commit message explaining why this is serial_slave only.
>> 
>> I will rename it.
>> serial_bus_slave can be either SPI, I2C or UART
>> (cf. http://elixir.free-electrons.com/linux/latest/source/include/acpi/acrestyp.h#L446).
> 
> Another idea would be to describe the *effect*, rather than the devices
> affected, i.e. something like:
> 
> -	u32 spi_i2c_slave:1;
> +	u32 parent_enumerated:1;
> 
> such that it could be extended to slaves on a non-serial bus in the
> future.

that might work as well. However right now I would be fine with serial_bus_slave here. Since that makes it clear that this is more than just UART devices. It is generic serial bus based devices.

Regards

Marcel

