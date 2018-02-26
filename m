From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
Date: Mon, 26 Feb 2018 09:33:51 +0000
Message-ID: <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
 <1519407117.10722.124.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519407117.10722.124.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de, ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

On 23/02/2018 17:31, Andy Shevchenko wrote:
> On Fri, 2018-02-23 at 11:02 +0000, John Garry wrote:
>> On 23/02/2018 10:30, Andy Shevchenko wrote:
>>> On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:
>>>> There is a requirement
>>
>>> Where?
>>

Hi Andy,

>> We require it for a development board for our hip06 platform.
>
> Okay, and this particular platform uses Synopsys IP?

As I see this uart is really a virtual 8250, so HW details like apb 
clocks and the like are hidden, so may not be relevant.

However I will check with the BMC team to know the specific details.

>
>>>>  for supporting an 8250-compatible UART with
>>>> the following profile/features:
>>>> - platform device
>>>> - polling mode (i.e. no interrupt support)
>>>> - ACPI FW
>>>
>>> Elaborate this one, please.
>>
>> So we need to define our own HID here, and cannot use PNP compatible
>> CID
>> (like PNP0501) as we cannot use the 8250 PNP driver.
>
> Why not? What are the impediments?
>

To support the host controller for this device, we will create an MFD, 
i.e. platform device, per slave device.

>> This is related to the Hisi LPC ACPI support, where we would create
>> an
>> MFD (i.e. platform device) for the UART.
>
> Why you can't do properly in ACPI?
>
>>>> - IO port iotype
>>>> - 16550-compatible
>>>>
>>>> For OF, we have 8250_of.c, and for PNP device we have 8250_pnp.c
>>>> drivers. However there does not seem to any driver satisfying
>>>> the above requirements. So this RFC is to find opinion on
>>>> modifying the Synopsys DW 8250_dw.c driver to support these
>>>> generic features.
>>>
>>> Synopsys 8250 is a particular case of platform drivers. It doesn't
>>> satisfy "8250-compatible UART" requirement.
>
>> Right, but I wanted to try to use the generic parts of the driver to
>> support this UART to save writing yet another driver.
>
> It's still odd. Why this one, why not 8250_foo_bar to touch instead?
>

Agreed, it's odd. I choose as 8250_dw.c as it has ACPI support already. 
And I recognise the hw from popularity. No stronger reasons than that.

Thanks,
John
