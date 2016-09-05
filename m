From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/2] serial: 8250_dw: make dw8250_set_termios as
 default set_termios callback
Date: Mon, 5 Sep 2016 09:28:53 +0800
Message-ID: <793806a7-f57d-def2-8b22-31c6479ad5ec@huawei.com>
References: <1472614152-43136-1-git-send-email-wangkefeng.wang@huawei.com>
 <1472614152-43136-2-git-send-email-wangkefeng.wang@huawei.com>
 <20160831120756.GG1751@kuha.fi.intel.com>
 <20160902112106.GB21737@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160902112106.GB21737@kuha.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, guohanjun@huawei.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org, z.liuxinliang@hisilicon.com, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 2016/9/2 19:21, Heikki Krogerus wrote:
> On Wed, Aug 31, 2016 at 03:07:56PM +0300, Heikki Krogerus wrote:
>> Hi,
>>
>> On Wed, Aug 31, 2016 at 11:29:11AM +0800, Kefeng Wang wrote:
>>> Make dw8250_set_termios() handle all cases of dw8250_data->clk properly,
>>> then we can safely use dw8250_set_termios() as the default set_termios
>>> callback instead of serial8250_do_set_termios(), so do it.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>  drivers/tty/serial/8250/8250_dw.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>>> index 5c0c123..adecece 100644
>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>> @@ -235,7 +235,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>>>  	unsigned int rate;
>>>  	int ret;
>>>  
>>> -	if (IS_ERR(d->clk) || !old)
>>> +	if (IS_ERR_OR_NULL(d->clk) || !old)
>>>  		goto out;
>>
>> This part is fine, but...
>>
>>>  	clk_disable_unprepare(d->clk);
>>> @@ -308,13 +308,11 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>>>  			p->serial_in = dw8250_serial_in32;
>>>  			data->uart_16550_compatible = true;
>>>  		}
>>> -		p->set_termios = dw8250_set_termios;
>>>  	}
>>>  
>>>  	/* Platforms with iDMA */
>>>  	if (platform_get_resource_byname(to_platform_device(p->dev),
>>>  					 IORESOURCE_MEM, "lpss_priv")) {
>>> -		p->set_termios = dw8250_set_termios;
>>>  		data->dma.rx_param = p->dev->parent;
>>>  		data->dma.tx_param = p->dev->parent;
>>>  		data->dma.fn = dw8250_idma_filter;
>>> @@ -391,6 +389,7 @@ static int dw8250_probe(struct platform_device *pdev)
>>>  	p->iotype	= UPIO_MEM;
>>>  	p->serial_in	= dw8250_serial_in;
>>>  	p->serial_out	= dw8250_serial_out;
>>> +	p->set_termios	= dw8250_set_termios;
>>
>> I'm a bit worried about this. If I remember correctly, we didn't set
>> the set_termios hook by default in the past because somebody was using
>> a type of clk that can't handle rate rounding and ended up using
>> improper clock frequency for some baud rates. Unfortunately I can't
>> remember who had that problem and on which platform.
>>
>> On the other hand, I'm not sure if drivers should worry about things
>> like that. This should be done the other way around. The platform
>> with the problem should unset the p->set_termios hook in a quirk, but
>> by default everybody would use dw8250_set_termios.
> 
> No comments... I would suggest we skip this for now. I don't think
> it's necessary for Hisilicon Hip05 SoC support, so perhaps you can
> just propose this change separately.

OK,  will send it separately, like you said, if some platform has issue
with this change, let's work around it in dw8250_quirks().

Thanks,
Kefeng

