From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v3 1/3] serial: 8250_dw: make dw8250_set_termios as
 default set_termios callback
Date: Wed, 24 Aug 2016 16:09:01 +0800
Message-ID: <3dca2d98-1272-0daa-20a5-4649d8ae2405@huawei.com>
References: <1468580485-28567-1-git-send-email-wangkefeng.wang@huawei.com>
 <1468580485-28567-2-git-send-email-wangkefeng.wang@huawei.com>
 <1471864110.4887.199.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1471864110.4887.199.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, guohanjun@huawei.com, z.liuxinliang@hisilicon.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org
List-Id: linux-serial@vger.kernel.org



On 2016/8/22 19:08, Andy Shevchenko wrote:
> On Fri, 2016-07-15 at 19:01 +0800, Kefeng Wang wrote:
>> We can safely use dw8250_set_termios() as the default set_termios
>> callback instead of serial8250_do_set_termios(), so do it.
> 
> So, current set_termios() relies on clock to be defined or be an error
> pointer. I'm not sure that it handles NULL properly.
> 
> So, the question is does set_termios() handle all possible cases? If no,
> do we guarantee that the case it doesn't handle never happened?
> 
> Answer to this question and amend either the patch or improve commit
> message.
> 

If clk do be NUL, uartclk will be set wrong value, zero, will judge this case
in dw8250_set_termios, then make it as default callback.


>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  drivers/tty/serial/8250/8250_dw.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c
>> b/drivers/tty/serial/8250/8250_dw.c
>> index e199696..65f3da7 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -301,7 +301,6 @@ static void dw8250_quirks(struct uart_port *p,
>> struct dw8250_data *data)
>>  		p->iotype = UPIO_MEM32;
>>  		p->regshift = 2;
>>  		p->serial_in = dw8250_serial_in32;
>> -		p->set_termios = dw8250_set_termios;
>>  		/* So far none of there implement the Busy
>> Functionality */
>>  		data->uart_16550_compatible = true;
>>  	}
>> @@ -309,7 +308,6 @@ static void dw8250_quirks(struct uart_port *p,
>> struct dw8250_data *data)
>>  	/* Platforms with iDMA */
>>  	if (platform_get_resource_byname(to_platform_device(p->dev),
>>  					 IORESOURCE_MEM,
>> "lpss_priv")) {
>> -		p->set_termios = dw8250_set_termios;
>>  		data->dma.rx_param = p->dev->parent;
>>  		data->dma.tx_param = p->dev->parent;
>>  		data->dma.fn = dw8250_idma_filter;
>> @@ -386,6 +384,7 @@ static int dw8250_probe(struct platform_device
>> *pdev)
>>  	p->iotype	= UPIO_MEM;
>>  	p->serial_in	= dw8250_serial_in;
>>  	p->serial_out	= dw8250_serial_out;
>> +	p->set_termios	= dw8250_set_termios;
>>  
>>  	p->membase = devm_ioremap(&pdev->dev, regs->start,
>> resource_size(regs));
>>  	if (!p->membase)
> 

