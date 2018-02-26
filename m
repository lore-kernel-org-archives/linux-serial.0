From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 2/2] serial: 8250_dw: support polling mode
Date: Mon, 26 Feb 2018 10:54:06 +0000
Message-ID: <a97eeee3-07a0-5ca6-edc4-f5550ca4acbf@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519324923-196857-3-git-send-email-john.garry@huawei.com>
 <1519407313.10722.127.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519407313.10722.127.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, slaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de, ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

On 23/02/2018 17:35, Andy Shevchenko wrote:
> On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:
>> It would be useful to make this driver support some
>> 8250-compatible devices which have no interrupt line.
>>
>> For these, we allow for no interrupt, and will fallback on
>> polling mode.
>>
>> Note: the 8250 dt bindings state that "interrupts"
>> is a required property:
>> "interrupts : should contain uart interrupt."
>>
>> But the 8250_of.c driver can live without it. So
>> this patch is going this way also.
>
> It should be documented in the binding.

Agreed. I find the wording a bit ambigious in bindings/serial/8250.txt 
and snps-dw-apb-uart.txt:

Required properties:
[...]
- interrupts : should contain uart interrupt.

It uses the word "should", and not "must". Maybe "should" means "must"...

>
>>  	if (irq < 0) {
>> -		if (irq != -EPROBE_DEFER)
>> -			dev_err(dev, "cannot get irq\n");
>> -		return irq;
>> +		if (irq == -EPROBE_DEFER)
>> +			return irq;
>> +		dev_warn(dev, "cannot get irq, using polling
>> mode\n");
>> +		irq = 0;
>
> NO_IRQ _is_ 0. You need to do something like
>
> if (irq < 0) }
>  ... leave existing code ...
> }
>
> if (!irq)
>  dev_warn(, "Use polling mode\n");

OK

>

Thanks,
John
