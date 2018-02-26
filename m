From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
Date: Mon, 26 Feb 2018 12:37:25 +0000
Message-ID: <19f8ce20-db49-68a9-e2fa-a45284d08837@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
 <1519407117.10722.124.camel@linux.intel.com>
 <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
 <1519638828.10722.153.camel@linux.intel.com>
 <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
 <1519644517.10722.179.camel@linux.intel.com>
 <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
 <1519647669.10722.184.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519647669.10722.184.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de, ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

On 26/02/2018 12:21, Andy Shevchenko wrote:
> On Mon, 2018-02-26 at 11:56 +0000, John Garry wrote:
>>>>>>> Why you can't do properly in ACPI?
>>>>>
>>>>> No answer here either.
>>>>>
>>>>> Sorry, but with this level of communication it's no go for the
>>>>> series.
>>>>>
>>>>
>>>> Sorry if my answers did not tell you want you want to know.
>>>>
>>>> My point was that the 8250_pnp driver would be used for a
>>>> pnp_device,
>>>> but we are creating a platform device for this UART slave so would
>>>> require a platform device driver, that which 8250_dw.c is. But I
>>>> will
>>>> check on pnp device support.
>>
>> Hi Andy,
>>
>>> Perhaps it's not visible, though below is a description of the
>>> drivers
>>> we have:
>>>
>>> 8250_dw - OF/ACPI driver for Synopsys DW (+ DW DMA)
>>> 8250_lpss - PCI driver for Synopsys DW (+ DW DMA)
>>> 8250_of -  generic 8250 compatible driver for OF
>>> 8250_pci - generic 8250 compatible driver for PCI
>>> 8250_pnp - generic 8250 compatible driver for ACPI
>>>
>>> 8250_* (except core parts) - custom glue drivers per some IPs
>>>
>>> By description you gave your driver fits 8250_pnp if ACPI tables
>>> crafted
>>> properly.
>>>
>>> Share the ACPI excerpt and we can discuss further how to improve
>>> them.
>>>

Hi Andy,

>>
>> For a bit of background, MFD support was discussed here initially:
>> https://lkml.org/lkml/2017/6/13/796
>>
>> Here is the ACPI table:
>> Scope(_SB) {
>>    Device (LPC0) {
>>      Name (_HID, "HISI0191")  // HiSi LPC
>>      Name (_CRS, ResourceTemplate () {
>>        Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
>>      })
>>    }
>>
>>    Device (LPC0.CON0) {
>>      Name (_HID, "HISI1031")
>>      // Name (_CID, "PNP0501") // cannot support PNP
>>      Name (LORS, ResourceTemplate() {
>>        QWordIO (
>>          ResourceConsumer,
>>      MinNotFixed,     // _MIF
>>      MaxNotFixed,     // _MAF
>>      PosDecode,
>>      EntireRange,
>>      0x0,             // _GRA
>>      0x2F8,           // _MIN
>
>>      0x3fff,          // _MAX
>
> Shouldn't be 0x2ff ?

Yes, something like this. I have asked for it to be fixed.

>
>>      0x0,             // _TRA
>>      0x08,            // _LEN
>>      , ,
>>      IO02
>>
>>
>> The latest framework changes and host driver patchset are here:
>> https://lkml.org/lkml/2018/2/19/465
>>
>
> It still doesn't explain impediments you have.
>
> Just few approaches comes to my mind:
>  - move UART outside of parent device

In this case the UART would not be a child and would not be enumerated 
to have the correct iobase.

>  - register PNP driver manually for that cell instead of MFD

Maybe it could work.

>  - use serial8250 platform driver (I totally forgot that we have a
> generic platform driver, so, it might be what you need to use at the
> end)

Let me check this also. I am not fimilar.

>

Thanks for the support!
John
