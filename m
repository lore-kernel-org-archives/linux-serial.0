From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2] serial: 8250_of: Fix for lack of interrupt support
Date: Mon, 17 Sep 2018 15:55:20 +0100
Message-ID: <2064e8da-d0da-6d55-e700-af3f428b348d@huawei.com>
References: <1535620130-199328-1-git-send-email-john.garry@huawei.com>
 <055f5ee8-4905-c229-0e33-6379cf65dfbc@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <055f5ee8-4905-c229-0e33-6379cf65dfbc@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>, jslaby@suse.com, robh@kernel.org, joel@jms.id.au, kurt@linutronix.de, yamada.masahiro@socionext.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

On 30/08/2018 19:21, Alexander Sverdlin wrote:
> Hello John!
>

Hi Greg,

Can you kindly consider picking up this patch?

It still applies to the branches today in your tty git, but let me know 
if you still rather I resend.

Thanks,
John

> On 30/08/2018 11:08, John Garry wrote:
>> In commit c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ"), a
>> check was added for the UART driver being probed prior to the parent IRQ
>> controller.
>>
>> Unfortunately this breaks certain boards which have no interrupt support,
>> like Huawei D03.
>>
>> Indeed, the 8250 DT bindings state that interrupts should be supported -
>> not must.
>>
>> To fix, switch from irq_of_parse_and_map() to of_irq_get(), which
>> does relay whether the IRQ host controller domain is not ready, i.e.
>> defer probe, instead of assuming it.
>>
>> Fixes: c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ")
>> Signed-off-by: John Garry <john.garry@huawei.com>
>
> This indeed looks like a proper way to handle both cases:
>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
>> ---
>>
>> Change in v2:
>> - fix check on irq value
>>
>> Note: I think that it would better if we could try to get the interrupt
>> 	  before clk+pm enabling, so we don't need to disable later when
>> 	  deferring, but this is not a fix.
>>
>> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
>> index af8beef..877fd7f 100644
>> --- a/drivers/tty/serial/8250/8250_of.c
>> +++ b/drivers/tty/serial/8250/8250_of.c
>> @@ -58,7 +58,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>>  	struct resource resource;
>>  	struct device_node *np = ofdev->dev.of_node;
>>  	u32 clk, spd, prop;
>> -	int ret;
>> +	int ret, irq;
>>
>>  	memset(port, 0, sizeof *port);
>>
>> @@ -143,21 +143,27 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>>  	if (ret >= 0)
>>  		port->line = ret;
>>
>> -	port->irq = irq_of_parse_and_map(np, 0);
>> -	if (!port->irq) {
>> -		ret = -EPROBE_DEFER;
>> -		goto err_unprepare;
>> +	irq = of_irq_get(np, 0);
>> +	if (irq < 0) {
>> +		if (irq == -EPROBE_DEFER) {
>> +			ret = -EPROBE_DEFER;
>> +			goto err_unprepare;
>> +		}
>> +		/* IRQ support not mandatory */
>> +		irq = 0;
>>  	}
>>
>> +	port->irq = irq;
>> +
>>  	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
>>  	if (IS_ERR(info->rst)) {
>>  		ret = PTR_ERR(info->rst);
>> -		goto err_dispose;
>> +		goto err_unprepare;
>>  	}
>>
>>  	ret = reset_control_deassert(info->rst);
>>  	if (ret)
>> -		goto err_dispose;
>> +		goto err_unprepare;
>>
>>  	port->type = type;
>>  	port->uartclk = clk;
>> @@ -184,8 +190,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>>  		port->handle_irq = fsl8250_handle_irq;
>>
>>  	return 0;
>> -err_dispose:
>> -	irq_dispose_mapping(port->irq);
>>  err_unprepare:
>>  	clk_disable_unprepare(info->clk);
>>  err_pmruntime:
>>
>
