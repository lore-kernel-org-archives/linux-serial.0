Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08F231C8C;
	Mon,  9 Dec 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749049; cv=none; b=sxk/jZdmycLefKCtafBybOdLQXWu8QcLd9f4JNGzNN/sv7BFS1zV1bxbyEG142/5LWkMgVvMLdf4ZD/lKVMp8MimIJACBfPSd1Lu7I1zrjDU7SejhVY638DbuIHawc8wvQJ1JNckLBTC2ydPyDOcmWCuEC2Z4l2qERxPpE9CWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749049; c=relaxed/simple;
	bh=tTO2sW9qNOARNV4Y+NbI6RwpCWPBtUu29KvF+rY4X50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYtGwl0AXkhCk88M+aJJJ/8Y2quR0ZreNJVehRHx0Wbpbw9WTv3DxBy5ItkmK4MDdKY8uQZzyeAYwJkgUR5Swb3SrT9AiBGtfcRwg+v77bCFG9W3cUDRQzufDFYvFUMJug41lErq8iH4LnN/HEujVVriteo5AIWWeHtChIGDg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=JTGqIvA4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="JTGqIvA4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22D18C0002;
	Mon,  9 Dec 2024 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733749038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlfEYm3BvK5Vt2vrAAGSu4WHYIxJ7BwmwCzRThXMfc4=;
	b=JTGqIvA4Jk7vBOH6yBBdoAq2PxqJo8a7J0d+8ketVLXI0DC0s9SrCb+1XrT6Efv4dVsbVh
	WTegRNVwB5vC/ZZOFQRN69n6CD4LE8JIHjz/FyiTp3SuNDTHDY1JS589Jrv3VhtcQs+VOF
	p5Y9ElfshxelArsQIvZTq+D1XL7Teuak6pPPwxUUqenjWLIwpASfdmAoF4GPBucOCETSa+
	2AHdXxTfP+L42Huh1CJHNE7atKvrfbEPGWASbmak7ayTn8wPMrAyo9k0W51E5Arca9ADrz
	lOtMQyP/cNYOZ/1OkrydafsYgNcFzHgs2Rjz9/ER8u04MaLozAQJiZuRib2X4A==
Message-ID: <c51e770c-2c97-4050-ae79-7bbc9b64c4e3@yoseli.org>
Date: Mon, 9 Dec 2024 13:57:15 +0100
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
 <014e09e3-f311-46f8-b159-6913bd6bba2f@yoseli.org>
 <d9e9c6a8-8619-4461-a385-5952f50c50ff@linux-m68k.org>
 <8c5ca84d-9a22-4cfa-8267-3d898dac13f4@yoseli.org>
 <a006bf1b-0d61-4954-af6a-1a546bb30984@linux-m68k.org>
Content-Language: en-US, fr
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <a006bf1b-0d61-4954-af6a-1a546bb30984@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Greg,

On 12/9/24 13:30, Greg Ungerer wrote:
> Hi JM,
> 
> On 5/12/24 23:06, Jean-Michel Hautbois wrote:
>> On 05/12/2024 14:01, Greg Ungerer wrote:
>>> On 4/12/24 21:32, Jean-Michel Hautbois wrote:
>>>> On 04/12/2024 12:15, Greg Ungerer wrote:
>>>>> On 4/12/24 20:58, Jean-Michel Hautbois wrote:
>>>>>> On 04/12/2024 11:54, Greg Ungerer wrote:
>>>>>>> On 2/12/24 20:34, Jean-Michel Hautbois wrote:
>>>>>>>> In order to use the eDMA channels for UART, the 
>>>>>>>> mcf_platform_uart needs
>>>>>>>> to be changed. Instead of adding another custom member for the
>>>>>>>> structure, use a resource tree in a platform_device per UART. It 
>>>>>>>> then
>>>>>>>> makes it possible to have a device named like "mcfuart.N" with N 
>>>>>>>> the
>>>>>>>> UART number.
>>>>>>>>
>>>>>>>> Later, adding the dma channel in the mcf tty driver will also be 
>>>>>>>> more
>>>>>>>> straightfoward.
>>>>>>>>
>>>>>>>> Signed-off-by: Jean-Michel Hautbois 
>>>>>>>> <jeanmichel.hautbois@yoseli.org>
>>>>>>>> ---
>>>>>>>>   arch/m68k/coldfire/device.c | 96 +++++++++++++ 
>>>>>>>> +-------------------------------
>>>>>>>>   drivers/tty/serial/mcf.c    | 69 +++++++++++++++++++-------------
>>>>>>>>   2 files changed, 70 insertions(+), 95 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/ 
>>>>>>>> device.c
>>>>>>>> index 
>>>>>>>> b6958ec2a220cf91a78a14fc7fa18749451412f7..fd7d0b0ce7eb2970cb8ffe33589fe8d7e88c268d 100644
>>>>>>>> --- a/arch/m68k/coldfire/device.c
>>>>>>>> +++ b/arch/m68k/coldfire/device.c
>>>>>>>> @@ -24,73 +24,35 @@
>>>>>>>>   #include <linux/platform_data/dma-mcf-edma.h>
>>>>>>>>   #include <linux/platform_data/mmc-esdhc-mcf.h>
>>>>>>>> -/*
>>>>>>>> - *    All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
>>>>>>>> - */
>>>>>>>> -static struct mcf_platform_uart mcf_uart_platform_data[] = {
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE0,
>>>>>>>> -        .irq        = MCF_IRQ_UART0,
>>>>>>>> -    },
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE1,
>>>>>>>> -        .irq        = MCF_IRQ_UART1,
>>>>>>>> -    },
>>>>>>>> -#ifdef MCFUART_BASE2
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE2,
>>>>>>>> -        .irq        = MCF_IRQ_UART2,
>>>>>>>> -    },
>>>>>>>> -#endif
>>>>>>>> -#ifdef MCFUART_BASE3
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE3,
>>>>>>>> -        .irq        = MCF_IRQ_UART3,
>>>>>>>> -    },
>>>>>>>> -#endif
>>>>>>>> -#ifdef MCFUART_BASE4
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE4,
>>>>>>>> -        .irq        = MCF_IRQ_UART4,
>>>>>>>> -    },
>>>>>>>> -#endif
>>>>>>>> -#ifdef MCFUART_BASE5
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE5,
>>>>>>>> -        .irq        = MCF_IRQ_UART5,
>>>>>>>> -    },
>>>>>>>> -#endif
>>>>>>>> -#ifdef MCFUART_BASE6
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE6,
>>>>>>>> -        .irq        = MCF_IRQ_UART6,
>>>>>>>> -    },
>>>>>>>> -#endif
>>>>>>>> -#ifdef MCFUART_BASE7
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE7,
>>>>>>>> -        .irq        = MCF_IRQ_UART7,
>>>>>>>> +static u64 mcf_uart_mask = DMA_BIT_MASK(32);
>>>>>>>> +
>>>>>>>> +static struct resource mcf_uart0_resource[] = {
>>>>>>>> +    [0] = {
>>>>>>>> +        .start = MCFUART_BASE0,
>>>>>>>> +        .end   = MCFUART_BASE0 + 0x3fff,
>>>>>>>> +        .flags = IORESOURCE_MEM,
>>>>>>>>       },
>>>>>>>> -#endif
>>>>>>>> -#ifdef MCFUART_BASE8
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE8,
>>>>>>>> -        .irq        = MCF_IRQ_UART8,
>>>>>>>> +    [1] = {
>>>>>>>> +        .start = 2,
>>>>>>>> +        .end   = 3,
>>>>>>>> +        .flags = IORESOURCE_DMA,
>>>>>>>>       },
>>>>>>>> -#endif
>>>>>>>> -#ifdef MCFUART_BASE9
>>>>>>>> -    {
>>>>>>>> -        .mapbase    = MCFUART_BASE9,
>>>>>>>> -        .irq        = MCF_IRQ_UART9,
>>>>>>>> +    [2] = {
>>>>>>>> +        .start = MCF_IRQ_UART0,
>>>>>>>> +        .end   = MCF_IRQ_UART0,
>>>>>>>> +        .flags = IORESOURCE_IRQ,
>>>>>>>>       },
>>>>>>>> -#endif
>>>>>>>> -    { },
>>>>>>>>   };
>>>>>>>> -static struct platform_device mcf_uart = {
>>>>>>>> +static struct platform_device mcf_uart0 = {
>>>>>>>>       .name            = "mcfuart",
>>>>>>>>       .id            = 0,
>>>>>>>> -    .dev.platform_data    = mcf_uart_platform_data,
>>>>>>>> +    .num_resources = ARRAY_SIZE(mcf_uart0_resource),
>>>>>>>> +    .resource = mcf_uart0_resource,
>>>>>>>> +    .dev = {
>>>>>>>> +        .dma_mask = &mcf_uart_mask,
>>>>>>>> +        .coherent_dma_mask = DMA_BIT_MASK(32),
>>>>>>>> +    },
>>>>>>>>   };
>>>>>>>>   #ifdef MCFFEC_BASE0
>>>>>>>> @@ -485,12 +447,12 @@ static struct platform_device mcf_i2c5 = {
>>>>>>>>   static const struct dma_slave_map mcf_edma_map[] = {
>>>>>>>>       { "dreq0", "rx-tx", MCF_EDMA_FILTER_PARAM(0) },
>>>>>>>>       { "dreq1", "rx-tx", MCF_EDMA_FILTER_PARAM(1) },
>>>>>>>> -    { "uart.0", "rx", MCF_EDMA_FILTER_PARAM(2) },
>>>>>>>> -    { "uart.0", "tx", MCF_EDMA_FILTER_PARAM(3) },
>>>>>>>> -    { "uart.1", "rx", MCF_EDMA_FILTER_PARAM(4) },
>>>>>>>> -    { "uart.1", "tx", MCF_EDMA_FILTER_PARAM(5) },
>>>>>>>> -    { "uart.2", "rx", MCF_EDMA_FILTER_PARAM(6) },
>>>>>>>> -    { "uart.2", "tx", MCF_EDMA_FILTER_PARAM(7) },
>>>>>>>> +    { "mcfuart.0", "rx", MCF_EDMA_FILTER_PARAM(2) },
>>>>>>>> +    { "mcfuart.0", "tx", MCF_EDMA_FILTER_PARAM(3) },
>>>>>>>> +    { "mcfuart.1", "rx", MCF_EDMA_FILTER_PARAM(4) },
>>>>>>>> +    { "mcfuart.1", "tx", MCF_EDMA_FILTER_PARAM(5) },
>>>>>>>> +    { "mcfuart.2", "rx", MCF_EDMA_FILTER_PARAM(6) },
>>>>>>>> +    { "mcfuart.2", "tx", MCF_EDMA_FILTER_PARAM(7) },
>>>>>>>>       { "timer0", "rx-tx", MCF_EDMA_FILTER_PARAM(8) },
>>>>>>>>       { "timer1", "rx-tx", MCF_EDMA_FILTER_PARAM(9) },
>>>>>>>>       { "timer2", "rx-tx", MCF_EDMA_FILTER_PARAM(10) },
>>>>>>>> @@ -623,7 +585,7 @@ static struct platform_device mcf_flexcan0 = {
>>>>>>>>   #endif /* MCFFLEXCAN_SIZE */
>>>>>>>>   static struct platform_device *mcf_devices[] __initdata = {
>>>>>>>> -    &mcf_uart,
>>>>>>>> +    &mcf_uart0,
>>>>>>>>   #ifdef MCFFEC_BASE0
>>>>>>>>       &mcf_fec0,
>>>>>>>>   #endif
>>>>>>>> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
>>>>>>>> index 
>>>>>>>> 93e7dda4d39acd23daf8c0d4c29ac8d666f263c5..07b8decfdb6005f0265dd130765e45c3fd1715eb 100644
>>>>>>>> --- a/drivers/tty/serial/mcf.c
>>>>>>>> +++ b/drivers/tty/serial/mcf.c
>>>>>>>> @@ -570,31 +570,46 @@ static struct uart_driver mcf_driver = {
>>>>>>>>   static int mcf_probe(struct platform_device *pdev)
>>>>>>>>   {
>>>>>>>> -    struct mcf_platform_uart *platp = dev_get_platdata(&pdev- 
>>>>>>>> >dev);
>>>>>>>>       struct uart_port *port;
>>>>>>>> -    int i;
>>>>>>>> -
>>>>>>>> -    for (i = 0; ((i < MCF_MAXPORTS) && (platp[i].mapbase)); i++) {
>>>>>>>> -        port = &mcf_ports[i].port;
>>>>>>>> -
>>>>>>>> -        port->line = i;
>>>>>>>> -        port->type = PORT_MCF;
>>>>>>>> -        port->mapbase = platp[i].mapbase;
>>>>>>>> -        port->membase = (platp[i].membase) ? platp[i].membase :
>>>>>>>> -            (unsigned char __iomem *) platp[i].mapbase;
>>>>>>>> -        port->dev = &pdev->dev;
>>>>>>>> -        port->iotype = SERIAL_IO_MEM;
>>>>>>>> -        port->irq = platp[i].irq;
>>>>>>>> -        port->uartclk = MCF_BUSCLK;
>>>>>>>> -        port->ops = &mcf_uart_ops;
>>>>>>>> -        port->flags = UPF_BOOT_AUTOCONF;
>>>>>>>> -        port->rs485_config = mcf_config_rs485;
>>>>>>>> -        port->rs485_supported = mcf_rs485_supported;
>>>>>>>> -        port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
>>>>>>>> -
>>>>>>>> -        uart_add_one_port(&mcf_driver, port);
>>>>>>>> +    struct mcf_uart *pp;
>>>>>>>> +    struct resource *res;
>>>>>>>> +    void __iomem *base;
>>>>>>>> +    int id = pdev->id;
>>>>>>>> +
>>>>>>>> +    if (id == -1 || id >= MCF_MAXPORTS) {
>>>>>>>> +        dev_err(&pdev->dev, "uart%d out of range\n",
>>>>>>>> +            id);
>>>>>>>> +        return -EINVAL;
>>>>>>>>       }
>>>>>>>> +    port = &mcf_ports[id].port;
>>>>>>>> +    port->line = id;
>>>>>>>> +
>>>>>>>> +    base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>>>>>>>> +    if (IS_ERR(base))
>>>>>>>> +        return PTR_ERR(base);
>>>>>>>> +
>>>>>>>> +    port->mapbase = res->start;
>>>>>>>> +    port->membase = base;
>>>>>>>> +
>>>>>>>> +    port->irq = platform_get_irq(pdev, 0);
>>>>>>>> +    if (port->irq < 0)
>>>>>>>> +        return port->irq;
>>>>>>>> +
>>>>>>>> +    port->type = PORT_MCF;
>>>>>>>> +    port->dev = &pdev->dev;
>>>>>>>> +    port->iotype = SERIAL_IO_MEM;
>>>>>>>> +    port->uartclk = MCF_BUSCLK;
>>>>>>>> +    port->ops = &mcf_uart_ops;
>>>>>>>> +    port->flags = UPF_BOOT_AUTOCONF;
>>>>>>>> +    port->rs485_config = mcf_config_rs485;
>>>>>>>> +    port->rs485_supported = mcf_rs485_supported;
>>>>>>>> +    port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
>>>>>>>> +
>>>>>>>> +    pp = container_of(port, struct mcf_uart, port);
>>>>>>>> +
>>>>>>>> +    uart_add_one_port(&mcf_driver, port);
>>>>>>>> +
>>>>>>>
>>>>>>> This breaks platforms with more than one UART - which is quite a 
>>>>>>> few of
>>>>>>> the ColdFire platforms. Numerous boards bring and use more than 
>>>>>>> one UART.
>>>>>>
>>>>>> I don't get why, as I have two uarts here, and each is detected 
>>>>>> properly when declaring those in my platform ? I get that it 
>>>>>> breaks existing detection (we are parsing all uarts even when only 
>>>>>> one or two is used) but it does not prevent it to work ?
>>>>>
>>>>> Building and testing on an M5208EVB platform.
>>>>> With original un-modified code boot console shows:
>>>>>
>>>>> ...
>>>>> [    0.110000] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
>>>>> [    0.110000] ColdFire internal UART serial driver
>>>>> [    0.110000] mcfuart.0: ttyS0 at MMIO 0xfc060000 (irq = 90, 
>>>>> base_baud = 5208333) is a ColdFire UART
>>>>> [    0.120000] printk: legacy console [ttyS0] enabled
>>>>> [    0.120000] mcfuart.0: ttyS1 at MMIO 0xfc064000 (irq = 91, 
>>>>> base_baud = 5208333) is a ColdFire UART
>>>>> [    0.120000] mcfuart.0: ttyS2 at MMIO 0xfc068000 (irq = 92, 
>>>>> base_baud = 5208333) is a ColdFire UART
>>>>> [    0.130000] brd: module loaded
>>>>> ...
>>>>>
>>>>>
>>>>> But with this change applied only the first port is probed:
>>>>>
>>>>> ...
>>>>> [    0.120000] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
>>>>> [    0.120000] ColdFire internal UART serial driver
>>>>> [    0.130000] mcfuart.0: ttyS0 at MMIO 0xfc060000 (irq = 90, 
>>>>> base_baud = 5208333) is a ColdFire UART
>>>>> [    0.130000] printk: legacy console [ttyS0] enabled
>>>>> [    0.130000] brd: module loaded
>>>>> ...
>>>>
>>>> OK, I see what you mean. Let me try to explain why I did it :-).
>>>>
>>>> The idea is to avoid probing a UART device which may exist as such 
>>>> on the core, but not be used as UART at all (on my board, for 
>>>> instance, I have uart2 and uart6, I don't need any other UART to be 
>>>> probed).
>>>>
>>>> So, based on what I think is the dts philosophy, you declare the 
>>>> devices you really need to probe ?
>>>
>>> You can do this too, with the old style platform setups.
>>>
>>> What you want is to have a separate board file just for your board.
>>> There is a few examples already in arch/m68k/coldfire/ like amcore.c,
>>> firebee.c, nettel.c and stmark2.c. None currently specifically extract
>>> out UARTS - no one really seemed to have a need for that in the past.
>>> Most ColdFire parts have 2 or 3 UARTS, the 5441x family is an out-lier
>>> here with 10.
>>>
>>> Anyway, the device.c entries are really just a catch-all for the most
>>> common devices and their most commonly used configurations.
>>
>> Thanks for answering !
>>
>> I know I can have a dedicated file for my board (which i have tbh) but 
>> device.c is always built when you select CONFIG_COLDFIRE so, I would 
>> end up with 10 UARTs probed anyways ?
>>
>> Is there no way for this patch to find a path ? I mean, I can keep the 
>> existing behavior, and have everything probed in device.c if the BASE 
>> address is declared. But I don't want my board to have all 10 UARTs 
>> and I don't want to locally patch the Makefile to remove the device.c 
>> from the built-in ?
> 
> Here is one example way to do it.
> Compile tested only - but I am sure you get the idea.

Thank you, it is clear. Yes, I get the idea :-).
I will submit a v2 once I have something (very) inspired ;-).
I just have to find a name for this new configuration, and test it.

JM
