From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: add ACPI support for uart on
 Hisilicon Hip05 soc
Date: Thu, 30 Jun 2016 22:26:00 +0800
Message-ID: <4ba5d9fb-580d-0e32-0ae7-85ab3b68742e@huawei.com>
References: <1467250062-61583-1-git-send-email-wangkefeng.wang@huawei.com>
 <1467250062-61583-3-git-send-email-wangkefeng.wang@huawei.com>
 <1467279517.30123.346.camel@linux.intel.com>
 <1467280468.30123.350.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467280468.30123.350.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, z.liuxinliang@hisilicon.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org, xuwei5@hisilicon.com, graeme.gregory@linaro.org
List-Id: linux-serial@vger.kernel.org



On 2016/6/30 17:54, Andy Shevchenko wrote:
> On Thu, 2016-06-30 at 12:38 +0300, Andy Shevchenko wrote:
>> On Thu, 2016-06-30 at 09:27 +0800, Kefeng Wang wrote:
>>> Add ACPI identifier for UART on Hisilicon Hip05 soc, be careful
>>> that it is not 16550 compatibal.
>>>
>>> Meanwhile, set dw8250_serial_out32 to keep consistent between
>>> serial_out
>>> and serial_in in ACPI.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>  drivers/tty/serial/8250/8250_dw.c | 13 +++++++++++--
>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_dw.c
>>> b/drivers/tty/serial/8250/8250_dw.c
>>> index 65f3da7..096431b 100644
>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>> @@ -272,6 +272,12 @@ static bool dw8250_idma_filter(struct dma_chan
>>> *chan, void *param)
>>>  	return param == chan->device->dev->parent;
>>>  }
>>>  
>>> +/* non 16550 compatible id list*/
>>> +static const struct acpi_device_id non_16550_id_list[] = {
>>> +	{ "HISI0031", 0 },
>>> +	{ },
>>> +};
>>> +
>>
>> On first glance it looks redundant, see below.
> 
> Oh, wait, this is still valid, but the better solution is to use device
> properties for the rest except yours!

Do you mean using something like

static struct property_entry dw8250_properties[] = {
        PROPERTY_ENTRY_U32("reg-io-width", 4),
        PROPERTY_ENTRY_U32("reg-shift", 2),
        PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible"),
        { },
};

then use platform_device_add_properties to add it to the device(16500 compatible),

but for hisi, use another property_entry without PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible")?

Not clear about using device properties.

> 
> I will prepare patch later this week or at the beginning of next week if
> you are in hurry, otherwise I would postpone this a bit (anyway it will
> not make v4.8 cycle).
> 

Thanks, hope that it will come out soon.

BRs,
Kefeng
