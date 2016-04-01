From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] serial: 8250_dw: fix wrong logic in dw8250_check_lcr()
Date: Fri, 1 Apr 2016 18:19:26 +0800
Message-ID: <56FE4B2E.30305@huawei.com>
References: <1459501618-21021-1-git-send-email-wangkefeng.wang@huawei.com>
 <1459504683.5907.151.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459504683.5907.151.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Noam Camus <noamc@ezchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, xuwei5@hisilicon.com
List-Id: linux-serial@vger.kernel.org



On 2016/4/1 17:58, Andy Shevchenko wrote:
> On Fri, 2016-04-01 at 17:06 +0800, Kefeng Wang wrote:
>> Commit cdcea058e510("serial: 8250_dw: Avoid serial_outx code
>> duplicate
>> with new dw8250_check_lcr()") introduce a wrong logic when write val
>> to
>> LCR reg. When CONFIG_64BIT enabled, __raw_writeq is used
>> unconditionally.
>>
>> But for !PORT_OCTEON, we better to use coincident write func.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>
>> We met following calltrace twice, if the change is not necessary,
>> correct me,
>> and any advice will be appreciated, thanks.
> 
> So, does this fix you issue? If it does than perhaps you need to Cc
> stable@ and put Fixes tag as well.

We only met this issue twice, for now it is ok, and I will do more
test with this patch.

> 
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -104,15 +104,16 @@ static void dw8250_check_lcr(struct uart_port
>> *p, int value)
>>  		dw8250_force_idle(p);
>>  
>>  #ifdef CONFIG_64BIT
>> -		__raw_writeq(value & 0xff, offset);
>> -#else
>> +		if (p->type == PORT_OCTEON)
>> +			__raw_writeq(value & 0xff, offset);
>> +		else
>> +#endif
> 
> You may also get rid of this one, like
> 
> if (IS_ENABLED(CONFIG_64BIT) && p->type == PORT_OCTEON)
>  ...
> else if
> ...

Agree.

> 
>>  		if (p->iotype == UPIO_MEM32)
>>  			writel(value, offset);
>>  		else if (p->iotype == UPIO_MEM32BE)
>>  			iowrite32be(value, offset);
>>  		else
>>  			writeb(value, offset);
>> -#endif
>>  	}
>>  	/*
>>  	 * FIXME: this deadlocks if port->lock is already held
> 
