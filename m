Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDCE1C9DDA;
	Wed,  7 Aug 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019059; cv=none; b=qLZqKB4tFrC4F/RPZyOOAI7tJO5T40a09zJxQJ/jmFk490BUy+lDQltXDf1TB8hiA1oBYLKIKwiNHcXBFCV3xo1cWL+AGh7OxnGtQ1c8+aAklc/zKp9ZPtjVIzfBV5kp+jY84tzzBI0qv4TInqXio5Ls6y/OZCDHzYs77zsHNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019059; c=relaxed/simple;
	bh=X/JptzBp44C9v+duQp9x/39KcrWm0ygGr5LVQ4+tAbo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LlKNkiDRpnTKEgtTxs/8/KiRYtzb/nBUu9m+9sfUaDRNwTx08+Ixq23CGsWZwRwPFKDbWSup0Udrcrran1jL8nK+YBRXF5R85uvMH+gG+QXMU1xrJkpKvIFMYJqxp8IBTG5z4Fq7my8VLnDgifC3mnoFh/U0jp1/rbsE/bvc2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8BxXZsvL7Nm_yYKAA--.5568S3;
	Wed, 07 Aug 2024 16:24:15 +0800 (CST)
Received: from [10.20.4.132] (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMBxsuEuL7NmVLUHAA--.10864S2;
	Wed, 07 Aug 2024 16:24:14 +0800 (CST)
Message-ID: <77b249fd-3cf7-4cb4-a2b4-64c0c2ba96fa@loongson.cn>
Date: Wed, 7 Aug 2024 16:24:14 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?6YOR6LGq5aiB?= <zhenghaowei@loongson.cn>
Subject: Re: [PATCH v2 2/3] tty: serial: 8250: Add loongson uart driver
 support
To: Krzysztof Kozlowski <krzk@kernel.org>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
 <20240804063834.70022-2-zhenghaowei@loongson.cn>
 <84ff11bd-1d11-4d66-a56b-84bf915af346@kernel.org>
Content-Language: en-US
In-Reply-To: <84ff11bd-1d11-4d66-a56b-84bf915af346@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxsuEuL7NmVLUHAA--.10864S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAQECBGayEXMQKgABsL
X-Coremail-Antispam: 1Uk129KBj93XoW3GFyxJF18Gw43Aw1fXw4fJFc_yoWfJr45pF
	yDtF4qkrWjqFyxGw1kXr1UZFWavr1Ikr12kry7Ka4akr90y3sYgryrKFyq9r9YyrWkCryj
	vF1UCrWI9F15XFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4ZqXDUUUU


在 2024/8/4 23:33, Krzysztof Kozlowski 写道:
> On 04/08/2024 08:38,zhenghaowei@loongson.cn wrote:
>> From: Haowei Zheng<zhenghaowei@loongson.cn>
>>
>> Due to certain hardware design challenges, we have opted to
>> utilize a dedicated UART driver to probe the UART interface.
>>
>> Presently, we have defined four parameters — 'fractional-division',
>> 'invert-rts', 'invert-dtr', 'invert-cts', and 'invert-dsr' — which
>> will be employed as needed.
>>
>> Signed-off-by: Haowei Zheng<zhenghaowei@loongson.cn>
>> ---
>>   drivers/tty/serial/8250/8250_loongson.c | 208 ++++++++++++++++++++++++
>>   drivers/tty/serial/8250/8250_port.c     |   8 +
>>   drivers/tty/serial/8250/Kconfig         |   9 +
>>   drivers/tty/serial/8250/Makefile        |   1 +
>>   include/uapi/linux/serial_core.h        |   1 +
>>   5 files changed, 227 insertions(+)
>>   create mode 100644 drivers/tty/serial/8250/8250_loongson.c
>>
>> diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial/8250/8250_loongson.c
>> new file mode 100644
>> index 000000000000..eb16677f1dde
>> --- /dev/null
>> +++ b/drivers/tty/serial/8250/8250_loongson.c
>> @@ -0,0 +1,208 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2020-2024 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/acpi.h>
> How is this used?

I forgot to drop it, Before this, when the kernel was booted in ACPI 
mode, we used acpi_match_table

for driver registration. To maintain code simplicity, now we use 
"PRP0001" for driver registration, so we

don't need 'acpi.h' anymore.

>> +#include <linux/clk.h>
> And this?
Currently, it doesn't seem to serve much purpose, and I will remove it 
in the next version.
>> +#include <linux/console.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/reset.h>
>> +
>> +#include "8250.h"
>> +
>> +struct loongson_uart_data {
>> +	struct reset_control *rst;
>> +	int line;
>> +	int mcr_invert;
>> +	int msr_invert;
>> +};
> ...
>
>> +static int loongson_uart_probe(struct platform_device *pdev)
>> +{
>> +	struct uart_8250_port uart = {};
>> +	struct loongson_uart_data *data;
>> +	struct uart_port *port;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	port = &uart.port;
>> +	spin_lock_init(&port->lock);
>> +
>> +	port->flags		= UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
>> +	port->iotype		= UPIO_MEM;
>> +	port->regshift		= 0;
>> +	port->dev		= &pdev->dev;
>> +	port->type		= (unsigned long)device_get_match_data(&pdev->dev);
>> +	port->serial_in		= loongson_serial_in;
>> +	port->serial_out	= loongson_serial_out;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -ENODEV;
>> +
>> +	port->membase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> +	if (!port->membase)
>> +		return -ENOMEM;
>> +
> Use wrapper combining both calls.

I got it, did you mean like this?

+    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+    if (!res)
+        return -ENODEV;
+
+    port->mapbase = res->start;
+    port->mapsize = resource_size(res);
+
+    port->membase = devm_ioremap(&pdev->dev, port->mapbase, port->mapsize);
+    if (!port->membase)
  +       return -ENOMEM;

>> +	port->mapbase = res->start;
>> +	port->mapsize = resource_size(res);
>> +
>> +	port->irq = platform_get_irq(pdev, 0);
>> +	if (port->irq < 0)
>> +		return -EINVAL;
>> +
>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	port->private_data = data;
>> +
>> +	if (device_property_read_bool(&pdev->dev, "fractional-division")) {
>> +		port->get_divisor = loongson_frac_get_divisor;
>> +		port->set_divisor = loongson_frac_set_divisor;
>> +	}
>> +
>> +	if (device_property_read_bool(&pdev->dev, "rts-invert"))
>> +		data->mcr_invert |= UART_MCR_RTS;
>> +
>> +	if (device_property_read_bool(&pdev->dev, "dtr-invert"))
>> +		data->mcr_invert |= UART_MCR_DTR;
>> +
>> +	if (device_property_read_bool(&pdev->dev, "cts-invert"))
>> +		data->msr_invert |= UART_MSR_CTS;
>> +
>> +	if (device_property_read_bool(&pdev->dev, "dsr-invert"))
>> +		data->msr_invert |= UART_MSR_DSR;
>> +
>> +	data->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
>> +	if (IS_ERR(data->rst))
>> +		return PTR_ERR(data->rst);
>> +
>> +	device_property_read_u32(&pdev->dev, "clock-frequency", &port->uartclk);
>> +
>> +	ret = reset_control_deassert(data->rst);
>> +	if (ret)
>> +		goto err_unprepare;
>> +
>> +	ret = serial8250_register_8250_port(&uart);
>> +	if (ret < 0)
>> +		goto err_unprepare;
>> +
>> +	platform_set_drvdata(pdev, data);
>> +	data->line = ret;
>> +
>> +	return 0;
>> +
>> +err_unprepare:
>> +
>> +	return ret;
>> +}
>> +
>> +static void loongson_uart_remove(struct platform_device *pdev)
>> +{
>> +	struct loongson_uart_data *data = platform_get_drvdata(pdev);
>> +
>> +	serial8250_unregister_port(data->line);
>> +	reset_control_assert(data->rst);
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int loongson_uart_suspend(struct device *dev)
>> +{
>> +	struct loongson_uart_data *data = dev_get_drvdata(dev);
>> +
>> +	serial8250_suspend_port(data->line);
>> +
>> +	return 0;
>> +}
>> +
>> +static int loongson_uart_resume(struct device *dev)
>> +{
>> +	struct loongson_uart_data *data = dev_get_drvdata(dev);
>> +
>> +	serial8250_resume_port(data->line);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops loongson_uart_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(loongson_uart_suspend, loongson_uart_resume)
>> +};
>> +
>> +static const struct of_device_id of_platform_serial_table[] = {
>> +	{.compatible = "loongson,ls7a-uart", .data = (void *)PORT_LOONGSON},
> Why do you need match data if there is no choice?

Considering whether new port types might be added in the future.

Of course, currently it doesn't seem necessary to do so.

>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, of_platform_serial_table);
>> +
>> +static struct platform_driver loongson_uart_driver = {
>> +	.probe = loongson_uart_probe,
>> +	.remove = loongson_uart_remove,
>> +	.driver = {
>> +		.name = "ls7a-uart",
>> +		.pm = &loongson_uart_pm_ops,
>> +		.of_match_table = of_match_ptr(of_platform_serial_table),
> Except that this does not build... drop of_match_ptr(), not needed and
> causes warnings.
>
Ok, I got it.
>> +	},
>> +};
>> +
>> +module_platform_driver(loongson_uart_driver);
>> +
>> +MODULE_DESCRIPTION("LOONGSON 8250 Driver");
>> +MODULE_AUTHOR("Haowei Zheng<zhenghaowei@loongson.cn>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 2786918aea98..60b72c785028 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -319,6 +319,14 @@ static const struct serial8250_config uart_config[] = {
>>   		.rxtrig_bytes	= {1, 8, 16, 30},
>>   		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
>>   	},
>> +	[PORT_LOONGSON] = {
>> +		.name		= "Loongson",
>> +		.fifo_size	= 16,
>> +		.tx_loadsz	= 16,
>> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>> +		.rxtrig_bytes   = {1, 4, 8, 14},
>> +		.flags		= UART_CAP_FIFO,
>> +	},
>>   };
>>   
>>   /* Uart divisor latch read */
>> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
>> index 47ff50763c04..a696afc4f8a8 100644
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>> @@ -568,6 +568,15 @@ config SERIAL_8250_BCM7271
>>   	  including DMA support and high accuracy BAUD rates, say
>>   	  Y to this option. If unsure, say N.
>>   
>> +config SERIAL_8250_LOONGSON
>> +	tristate "Loongson 8250 serial port support"
>> +	default SERIAL_8250
>> +	depends on SERIAL_8250
>> +	depends on LOONGARCH || MIPS
> MIPS? Why?
>
> You also miss COMPILE_TEST.
>
>
>
> Best regards,
> Krzysztof

The addition of mips was intended to maintain compatibility with 
loongson-3a4000 and earlier chips.

Currently, it appears that this lacks sufficient validation, and I will 
remove it in the next version.


I compiled and verified it on the Loongson 3A6000 machine, and currently 
it seems to have issues.

I will fix the compilation problem in the next version.


Best regards,

Haowei Zheng

