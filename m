From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v3,2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Fri, 2 Feb 2018 11:03:38 +0100
Message-ID: <4eb3d357-bf54-2360-f547-d0c6fbbc8396@gmail.com>
References: <1507710734-32520-3-git-send-email-frederic.danis.oss@gmail.com>
 <20180131142100.GE26342@xora-haswell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180131142100.GE26342@xora-haswell>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Graeme Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Graeme,

Le 31/01/2018 à 15:21, Graeme Gregory a écrit :
> On Wed, Oct 11, 2017 at 10:32:14AM +0200, Frédéric Danis wrote:
>> UART devices is expected to be enumerated by SerDev subsystem.
>>
>> During ACPI scan, serial devices behind SPI, I2C or UART buses are not
>> enumerated, allowing them to be enumerated by their respective parents.
>>
>> Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for serial
>> devices on serial buses (SPI, I2C or UART).
>>
>> On Macs an empty ResourceTemplate is returned for uart slaves.
>> Instead the device properties "baud", "parity", "dataBits", "stopBits" are
>> provided. Add a check for "baud" in acpi_is_serial_bus_slave().
>>
> This patch appears to break UART probing in ACPI on xgene based
> plaforms.
>
> The appropriate chunks of DSDT.
>
>      Device (_SB.AHBC)
>      {
>          OperationRegion (SRST, SystemMemory, 0x1F2AC000, 0x04)
>          OperationRegion (CLKE, SystemMemory, 0x1F2AC004, 0x04)
>          OperationRegion (SRRM, SystemMemory, 0x1F2AD070, 0x04)
>          OperationRegion (RD2F, SystemMemory, 0x1F2AE014, 0x04)
>
>      ...
>
>          Device (UAR0)
>          {
>              Name (_HID, "APMC0D08")  // _HID: Hardware ID
>              Name (_DDN, "UAR0")  // _DDN: DOS Device Name
>              Name (_UID, "UAR0")  // _UID: Unique ID
>              Name (_STR, Unicode ("APM88xxxx UART0 Controller"))  // _STR: Description String
>              Name (_ADR, 0x1C021000)  // _ADR: Address
>              Name (_CID, "NS16550A")  // _CID: Compatible ID
>
>      ...
>
>              Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>              {
>                  Memory32Fixed (ReadWrite,
>                      0x1C021000,         // Address Base
>                      0x00000100,         // Address Length
>                      )
>                  UartSerialBusV2 (0x00002580, DataBitsEight, StopBitsOne,
>                      0x00, LittleEndian, ParityTypeNone, FlowControlHardware,
>                      0x0010, 0x0010, "UAR0",
>                      0x00, ResourceConsumer, , Exclusive,
>                      )
>                  Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
>                  {
>                      0x0000006D,
>                  }
>              })

This seems to be related to 
https://bugzilla.redhat.com/show_bug.cgi?id=1531140
Am I correct?

The SerDev support should allow UART to appear as tty device if not used 
by an underlying component (cf. tty_port_register_device_attr() in 
drivers/tty/tty_port.c).

AFAIU, there is no internal device attached to this serial port.
Is it possible to get complete ACPI DSDT?

Is SerDev enabled on this device?
Boot logs with SerDev debug traces enabled can be useful to understand 
what happens.

Regards,

Fred

-- 
Frédéric Danis                       Embedded Linux Consultant
frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
