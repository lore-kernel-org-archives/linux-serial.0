Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE01B0F36;
	Wed,  4 Dec 2024 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311968; cv=none; b=o/YqFD0rBZdNJAJvwkrf0/o9CP+e1gf7y56dO9wxUuYQz5OB6sFHvmzfCsOgpOtmK8/EV04D0IyjpHDFlZUevPVBEqZCAmLgsJXUckb645Cvk1elLgiujrmm2ztuJEj7Qk5/x1zG0XjlDBjYxURXCqoxAk9zCZPfBvS1qm6NibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311968; c=relaxed/simple;
	bh=dA1yiddXlJ43w+M4Cyz2yPT4xcOLtzQ6cRdcjBQFf5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EG6kutDxfRbszBP5ga3D2c4BLq2+NrHs9M4jNQr3B4cqopI8U2Ql7wCHtMrtWr6N+BevOStup5pmUN2PI6hGucDVP+CDUY+BLX5JimAgOjdivx//0UXyAuH6eLTBJz6oSML19lML2UpGaDMM2m1JYlE9Ky5/tNR2ZOSTHIbcecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=bbjt92vz; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="bbjt92vz"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7886640004;
	Wed,  4 Dec 2024 11:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733311958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gg5n5zYJ5hayh4Xp4MAljdiNLsCqbkWepRSpw2Wh1aU=;
	b=bbjt92vzK5cON2e4T4g0ZMH7LTJ21rPNUwGRcQPyXkSAHnl/ojxXCbgiUVYhrrE8d6HAgy
	OPS44/6Io+2+RY+Hg4tn4g1m+LHTNJRIcWoRvvAD3PMdZ/Xng5OsshdRx8OvX0btDeQ1kL
	TElYjcdtE+howsLUHTGlUiQ9fsa6hLkT6n42ylg8oow56k7S9mERweKL0w8WZlMSoo+0sn
	HNCh6W05m1uQNIzNksoWVIN0ieuOwcTJQb1Q9FAuYVQE1pv3hVv0p6puLkQFPTRlFE2yKL
	8/KzLqOtBN25H3RDxA0HYNoqa6zMH6ygkKI/Fl8u30g15jI0A0XN9aNH6321VA==
Message-ID: <014e09e3-f311-46f8-b159-6913bd6bba2f@yoseli.org>
Date: Wed, 4 Dec 2024 12:32:36 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: coldfire: Support resources for UART
To: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20241202-m5441x_uart_resource-v1-1-6b28cb295fb5@yoseli.org>
 <52517849-48ed-4fe8-8638-ec2a4dc2bcbd@linux-m68k.org>
 <a06e4806-8b5a-4073-96d5-2a37103e572f@yoseli.org>
 <cf9cd17a-30d6-43e7-ae59-2f34d6f2dc00@linux-m68k.org>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <cf9cd17a-30d6-43e7-ae59-2f34d6f2dc00@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Greg,

On 04/12/2024 12:15, Greg Ungerer wrote:
> Hi JM,
> 
> On 4/12/24 20:58, Jean-Michel Hautbois wrote:
>> On 04/12/2024 11:54, Greg Ungerer wrote:
>>> On 2/12/24 20:34, Jean-Michel Hautbois wrote:
>>>> In order to use the eDMA channels for UART, the mcf_platform_uart needs
>>>> to be changed. Instead of adding another custom member for the
>>>> structure, use a resource tree in a platform_device per UART. It then
>>>> makes it possible to have a device named like "mcfuart.N" with N the
>>>> UART number.
>>>>
>>>> Later, adding the dma channel in the mcf tty driver will also be more
>>>> straightfoward.
>>>>
>>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>>>> ---
>>>>   arch/m68k/coldfire/device.c | 96 +++++++++++++ 
>>>> +-------------------------------
>>>>   drivers/tty/serial/mcf.c    | 69 +++++++++++++++++++-------------
>>>>   2 files changed, 70 insertions(+), 95 deletions(-)
>>>>
>>>> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
>>>> index 
>>>> b6958ec2a220cf91a78a14fc7fa18749451412f7..fd7d0b0ce7eb2970cb8ffe33589fe8d7e88c268d 100644
>>>> --- a/arch/m68k/coldfire/device.c
>>>> +++ b/arch/m68k/coldfire/device.c
>>>> @@ -24,73 +24,35 @@
>>>>   #include <linux/platform_data/dma-mcf-edma.h>
>>>>   #include <linux/platform_data/mmc-esdhc-mcf.h>
>>>> -/*
>>>> - *    All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
>>>> - */
>>>> -static struct mcf_platform_uart mcf_uart_platform_data[] = {
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE0,
>>>> -        .irq        = MCF_IRQ_UART0,
>>>> -    },
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE1,
>>>> -        .irq        = MCF_IRQ_UART1,
>>>> -    },
>>>> -#ifdef MCFUART_BASE2
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE2,
>>>> -        .irq        = MCF_IRQ_UART2,
>>>> -    },
>>>> -#endif
>>>> -#ifdef MCFUART_BASE3
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE3,
>>>> -        .irq        = MCF_IRQ_UART3,
>>>> -    },
>>>> -#endif
>>>> -#ifdef MCFUART_BASE4
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE4,
>>>> -        .irq        = MCF_IRQ_UART4,
>>>> -    },
>>>> -#endif
>>>> -#ifdef MCFUART_BASE5
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE5,
>>>> -        .irq        = MCF_IRQ_UART5,
>>>> -    },
>>>> -#endif
>>>> -#ifdef MCFUART_BASE6
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE6,
>>>> -        .irq        = MCF_IRQ_UART6,
>>>> -    },
>>>> -#endif
>>>> -#ifdef MCFUART_BASE7
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE7,
>>>> -        .irq        = MCF_IRQ_UART7,
>>>> +static u64 mcf_uart_mask = DMA_BIT_MASK(32);
>>>> +
>>>> +static struct resource mcf_uart0_resource[] = {
>>>> +    [0] = {
>>>> +        .start = MCFUART_BASE0,
>>>> +        .end   = MCFUART_BASE0 + 0x3fff,
>>>> +        .flags = IORESOURCE_MEM,
>>>>       },
>>>> -#endif
>>>> -#ifdef MCFUART_BASE8
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE8,
>>>> -        .irq        = MCF_IRQ_UART8,
>>>> +    [1] = {
>>>> +        .start = 2,
>>>> +        .end   = 3,
>>>> +        .flags = IORESOURCE_DMA,
>>>>       },
>>>> -#endif
>>>> -#ifdef MCFUART_BASE9
>>>> -    {
>>>> -        .mapbase    = MCFUART_BASE9,
>>>> -        .irq        = MCF_IRQ_UART9,
>>>> +    [2] = {
>>>> +        .start = MCF_IRQ_UART0,
>>>> +        .end   = MCF_IRQ_UART0,
>>>> +        .flags = IORESOURCE_IRQ,
>>>>       },
>>>> -#endif
>>>> -    { },
>>>>   };
>>>> -static struct platform_device mcf_uart = {
>>>> +static struct platform_device mcf_uart0 = {
>>>>       .name            = "mcfuart",
>>>>       .id            = 0,
>>>> -    .dev.platform_data    = mcf_uart_platform_data,
>>>> +    .num_resources = ARRAY_SIZE(mcf_uart0_resource),
>>>> +    .resource = mcf_uart0_resource,
>>>> +    .dev = {
>>>> +        .dma_mask = &mcf_uart_mask,
>>>> +        .coherent_dma_mask = DMA_BIT_MASK(32),
>>>> +    },
>>>>   };
>>>>   #ifdef MCFFEC_BASE0
>>>> @@ -485,12 +447,12 @@ static struct platform_device mcf_i2c5 = {
>>>>   static const struct dma_slave_map mcf_edma_map[] = {
>>>>       { "dreq0", "rx-tx", MCF_EDMA_FILTER_PARAM(0) },
>>>>       { "dreq1", "rx-tx", MCF_EDMA_FILTER_PARAM(1) },
>>>> -    { "uart.0", "rx", MCF_EDMA_FILTER_PARAM(2) },
>>>> -    { "uart.0", "tx", MCF_EDMA_FILTER_PARAM(3) },
>>>> -    { "uart.1", "rx", MCF_EDMA_FILTER_PARAM(4) },
>>>> -    { "uart.1", "tx", MCF_EDMA_FILTER_PARAM(5) },
>>>> -    { "uart.2", "rx", MCF_EDMA_FILTER_PARAM(6) },
>>>> -    { "uart.2", "tx", MCF_EDMA_FILTER_PARAM(7) },
>>>> +    { "mcfuart.0", "rx", MCF_EDMA_FILTER_PARAM(2) },
>>>> +    { "mcfuart.0", "tx", MCF_EDMA_FILTER_PARAM(3) },
>>>> +    { "mcfuart.1", "rx", MCF_EDMA_FILTER_PARAM(4) },
>>>> +    { "mcfuart.1", "tx", MCF_EDMA_FILTER_PARAM(5) },
>>>> +    { "mcfuart.2", "rx", MCF_EDMA_FILTER_PARAM(6) },
>>>> +    { "mcfuart.2", "tx", MCF_EDMA_FILTER_PARAM(7) },
>>>>       { "timer0", "rx-tx", MCF_EDMA_FILTER_PARAM(8) },
>>>>       { "timer1", "rx-tx", MCF_EDMA_FILTER_PARAM(9) },
>>>>       { "timer2", "rx-tx", MCF_EDMA_FILTER_PARAM(10) },
>>>> @@ -623,7 +585,7 @@ static struct platform_device mcf_flexcan0 = {
>>>>   #endif /* MCFFLEXCAN_SIZE */
>>>>   static struct platform_device *mcf_devices[] __initdata = {
>>>> -    &mcf_uart,
>>>> +    &mcf_uart0,
>>>>   #ifdef MCFFEC_BASE0
>>>>       &mcf_fec0,
>>>>   #endif
>>>> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
>>>> index 
>>>> 93e7dda4d39acd23daf8c0d4c29ac8d666f263c5..07b8decfdb6005f0265dd130765e45c3fd1715eb 100644
>>>> --- a/drivers/tty/serial/mcf.c
>>>> +++ b/drivers/tty/serial/mcf.c
>>>> @@ -570,31 +570,46 @@ static struct uart_driver mcf_driver = {
>>>>   static int mcf_probe(struct platform_device *pdev)
>>>>   {
>>>> -    struct mcf_platform_uart *platp = dev_get_platdata(&pdev->dev);
>>>>       struct uart_port *port;
>>>> -    int i;
>>>> -
>>>> -    for (i = 0; ((i < MCF_MAXPORTS) && (platp[i].mapbase)); i++) {
>>>> -        port = &mcf_ports[i].port;
>>>> -
>>>> -        port->line = i;
>>>> -        port->type = PORT_MCF;
>>>> -        port->mapbase = platp[i].mapbase;
>>>> -        port->membase = (platp[i].membase) ? platp[i].membase :
>>>> -            (unsigned char __iomem *) platp[i].mapbase;
>>>> -        port->dev = &pdev->dev;
>>>> -        port->iotype = SERIAL_IO_MEM;
>>>> -        port->irq = platp[i].irq;
>>>> -        port->uartclk = MCF_BUSCLK;
>>>> -        port->ops = &mcf_uart_ops;
>>>> -        port->flags = UPF_BOOT_AUTOCONF;
>>>> -        port->rs485_config = mcf_config_rs485;
>>>> -        port->rs485_supported = mcf_rs485_supported;
>>>> -        port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
>>>> -
>>>> -        uart_add_one_port(&mcf_driver, port);
>>>> +    struct mcf_uart *pp;
>>>> +    struct resource *res;
>>>> +    void __iomem *base;
>>>> +    int id = pdev->id;
>>>> +
>>>> +    if (id == -1 || id >= MCF_MAXPORTS) {
>>>> +        dev_err(&pdev->dev, "uart%d out of range\n",
>>>> +            id);
>>>> +        return -EINVAL;
>>>>       }
>>>> +    port = &mcf_ports[id].port;
>>>> +    port->line = id;
>>>> +
>>>> +    base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>>>> +    if (IS_ERR(base))
>>>> +        return PTR_ERR(base);
>>>> +
>>>> +    port->mapbase = res->start;
>>>> +    port->membase = base;
>>>> +
>>>> +    port->irq = platform_get_irq(pdev, 0);
>>>> +    if (port->irq < 0)
>>>> +        return port->irq;
>>>> +
>>>> +    port->type = PORT_MCF;
>>>> +    port->dev = &pdev->dev;
>>>> +    port->iotype = SERIAL_IO_MEM;
>>>> +    port->uartclk = MCF_BUSCLK;
>>>> +    port->ops = &mcf_uart_ops;
>>>> +    port->flags = UPF_BOOT_AUTOCONF;
>>>> +    port->rs485_config = mcf_config_rs485;
>>>> +    port->rs485_supported = mcf_rs485_supported;
>>>> +    port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
>>>> +
>>>> +    pp = container_of(port, struct mcf_uart, port);
>>>> +
>>>> +    uart_add_one_port(&mcf_driver, port);
>>>> +
>>>
>>> This breaks platforms with more than one UART - which is quite a few of
>>> the ColdFire platforms. Numerous boards bring and use more than one 
>>> UART.
>>
>> I don't get why, as I have two uarts here, and each is detected 
>> properly when declaring those in my platform ? I get that it breaks 
>> existing detection (we are parsing all uarts even when only one or two 
>> is used) but it does not prevent it to work ?
> 
> Building and testing on an M5208EVB platform.
> With original un-modified code boot console shows:
> 
> ...
> [    0.110000] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
> [    0.110000] ColdFire internal UART serial driver
> [    0.110000] mcfuart.0: ttyS0 at MMIO 0xfc060000 (irq = 90, base_baud 
> = 5208333) is a ColdFire UART
> [    0.120000] printk: legacy console [ttyS0] enabled
> [    0.120000] mcfuart.0: ttyS1 at MMIO 0xfc064000 (irq = 91, base_baud 
> = 5208333) is a ColdFire UART
> [    0.120000] mcfuart.0: ttyS2 at MMIO 0xfc068000 (irq = 92, base_baud 
> = 5208333) is a ColdFire UART
> [    0.130000] brd: module loaded
> ...
> 
> 
> But with this change applied only the first port is probed:
> 
> ...
> [    0.120000] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
> [    0.120000] ColdFire internal UART serial driver
> [    0.130000] mcfuart.0: ttyS0 at MMIO 0xfc060000 (irq = 90, base_baud 
> = 5208333) is a ColdFire UART
> [    0.130000] printk: legacy console [ttyS0] enabled
> [    0.130000] brd: module loaded
> ...

OK, I see what you mean. Let me try to explain why I did it :-).

The idea is to avoid probing a UART device which may exist as such on 
the core, but not be used as UART at all (on my board, for instance, I 
have uart2 and uart6, I don't need any other UART to be probed).

So, based on what I think is the dts philosophy, you declare the devices 
you really need to probe ?

I can add all the uarts as resources with the ifdefs like before, but on 
the M54418 it will always probe 10 devices, which sounds like a bit 
overkill ?

Thanks !
JM

> 
> Regards
> Greg
> 
> 
> 
>> static struct resource mcf_uart2_resource[] = {
>>      [0] = {
>>          .start = MCFUART_BASE2,
>>          .end   = MCFUART_BASE2 + 0x3fff,
>>          .flags = IORESOURCE_MEM,
>>      },
>>      [1] = {
>>          .start = 6,
>>          .end   = 7,
>>          .flags = IORESOURCE_DMA,
>>      },
>>      [2] = {
>>          .start = MCF_IRQ_UART2,
>>          .end   = MCF_IRQ_UART2,
>>          .flags = IORESOURCE_IRQ,
>>      },
>> };
>>
>> static struct platform_device mcf_uart2 = {
>>      .name            = "mcfuart",
>>      .id            = 2,
>>      .num_resources = ARRAY_SIZE(mcf_uart2_resource),
>>      .resource = mcf_uart2_resource,
>>      .dev = {
>>          .dma_mask = &mcf_uart_mask,
>>          .coherent_dma_mask = DMA_BIT_MASK(32),
>>      },
>> };
>>
>> static struct resource mcf_uart6_resource[] = {
>>      [0] = {
>>          .start = MCFUART_BASE6,
>>          .end   = MCFUART_BASE6 + 0x3fff,
>>          .flags = IORESOURCE_MEM,
>>      },
>>      [1] = {
>>          .start = 22,
>>          .end   = 23,
>>          .flags = IORESOURCE_DMA,
>>      },
>>      [2] = {
>>          .start = MCF_IRQ_UART6,
>>          .end   = MCF_IRQ_UART6,
>>          .flags = IORESOURCE_IRQ,
>>      },
>> };
>>
>> static struct platform_device mcf_uart6 = {
>>      .name            = "mcfuart",
>>      .id            = 6,
>>      .num_resources = ARRAY_SIZE(mcf_uart6_resource),
>>      .resource = mcf_uart6_resource,
>>      .dev = {
>>          .dma_mask = &mcf_uart_mask,
>>          .coherent_dma_mask = DMA_BIT_MASK(32),
>>      },
>> };
>>
>> JM
>>
>>>
>>> Regards
>>> Greg
>>>
>>>
>>>
>>>>       return 0;
>>>>   }
>>>> @@ -603,13 +618,11 @@ static int mcf_probe(struct platform_device 
>>>> *pdev)
>>>>   static void mcf_remove(struct platform_device *pdev)
>>>>   {
>>>>       struct uart_port *port;
>>>> -    int i;
>>>> +    int id = pdev->id;
>>>> -    for (i = 0; (i < MCF_MAXPORTS); i++) {
>>>> -        port = &mcf_ports[i].port;
>>>> -        if (port)
>>>> -            uart_remove_one_port(&mcf_driver, port);
>>>> -    }
>>>> +    port = &mcf_ports[id].port;
>>>> +    if (port)
>>>> +        uart_remove_one_port(&mcf_driver, port);
>>>>   }
>>>>   / 
>>>> ****************************************************************************/
>>>>
>>>> ---
>>>> base-commit: e457f18d7f25288d143c1fe024a620d0b15caec1
>>>> change-id: 20241202-m5441x_uart_resource-729b30c15363
>>>>
>>>> Best regards,
>>

