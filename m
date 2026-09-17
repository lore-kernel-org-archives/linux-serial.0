Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6F4D9558
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650421; cv=none; b=ucTKDiZlJ5fan+xTL2NmivYuWrCqYpiyhb60UUm6XAh3JShyQ7gPYCwJa/vn+GiZ3SQhrRqRfooAluWrnGdTBwcMXos2V2PMZMUbmx7UYErkehSOQk0CiTk1LhNFl0fNbhoMw15LZdWg/sIT3YESvZaCrHcd+UFh/08BpWKmE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650421; c=relaxed/simple;
	bh=A99s6qGzXGsm0xJ39yw3mTC3dYxbI1dGX7ih7zzTNhk=;
	h=Date:Content-Type:To:Subject:Message-Id:In-Reply-To:Mime-Version:
	 References:Cc:From; b=W8IjKQltOhK/nAgKBaS59NUIobi401wpExbUmxaYNO7kcxzWg2o1BQgEqZl+VY9UZ8UC0v1h/rkodK+wU8/zcjAhS6admV9w/Rhw64Y6Y16sj7ULqM7mhFxKL3/ExhB/f88YmgWmDdMrcRogNSTH1HKnK/wgG5bGHHyOxS+aZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=sYBSOhG8; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="sYBSOhG8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1789650390; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+K/fwK8bvxELpb1D1iB7Tjzey3gE1mQsPqJM5hXilTs=;
 b=sYBSOhG8F9ggTDfXjZcy9GmaHBoFZpDBmcQrP5vAkuVxIsruenpevWL3XhFROaSwMXva8g
 hOjg+9/h9Z3O8YUUXV8cd326/jo0xInCsAR+nymvihEoCCuLxjgF2s06MDiQJGFZxgG8GM
 qvFOMH7u9mvbXOx0ONmZ1Xel+oc/m+XDWqNXTWNtZuFEhWTfvzWicgI6/1gsWNvYKuWUkA
 gziiE+eidvtlEdgsibY4OQL9YKwJuQawplmlYuq0S+9hOPjlFRjzf5GPmjuJsLdlt0tbX5
 sWnBdM4E677M3N2HqlbodIsXOhxIwBaKvmRiSE+KwO3oMgtpOD4TfdyiDRslxg==
Date: Thu, 17 Sep 2026 21:06:25 +0800
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Received: from [172.16.155.39] ([120.234.49.250]) by smtp.feishu.cn with ESMTPS; Thu, 17 Sep 2026 21:06:27 +0800
To: "Kumar,  Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH v3] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available
Message-Id: <ab256e4a-a9cc-410e-b889-f75fb01e77c7@picoheart.com>
In-Reply-To: <52822f65-58c4-4def-a1b6-e37055d4c0c6@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26aabe5d4+ae2f41+vger.kernel.org+yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
References: <20260908141524.20302-1-yang.yicong@picoheart.com> <52822f65-58c4-4def-a1b6-e37055d4c0c6@ti.com>
Cc: <ilpo.jarvinen@linux.intel.com>, <andriy.shevchenko@linux.intel.com>, 
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yang.yicong@picoheart.com>, <gregkh@linuxfoundation.org>, 
	<jirislaby@kernel.org>, <geshijian@picoheart.com>, 
	<yangyang.8776@picoheart.com>, <yanligen@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit

On 9/17/26 6:47 PM, Kumar, Udit wrote:
> Hi Yicong,
> 
> On 9/8/2026 7:45 PM, Yicong Yang wrote:
>> The DW uart could get into the cases where a bogus RX timeout
>> interrupt is asserted but no available data. This could be
>> workaround by doing a bogus read.
>>
>> Currently the driver's using the standard RBR (receive buffer
>> register) for this bogus read. However the reading of RBR
>> in this case is allowed to raise a hardware error if vendor
>> choose to implement in this way (our platform). It's also
>> allowed to do the bogus read using SRBR (shadow RBR) for
>> workaround which won't raise the hardware error. So change
>> to use the SRBR to workaround the issue if it's available.
>>
> 
> Thanks for the patch. If I understand correctly, the IP you are using
> does not allow reading an empty FIFO, so you decided to read the SRBR
> instead.

yes but under certain condition, see blow.

> 
> Does this same case applies when you open a port without any data in the
> FIFO:
> https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/tty/serial/8250/8250_port.c#L710
> ?
> 
> If yes then I am wondering, how the condition mentioned above is bypassed

reading an empty FIFO (by RBR) will be fine when the fifo is disabled.
so I think serial8250_clear_interrupts() you referred is always invoked
when the FIFO is disabled.

I also find a similar issue related to serial8250_clear_interrupts()
that trigger the PSLVERR when reading the empty FIFO when the FIFO
is enabled. this is fixed by 7f8fdd4dbffc ("serial: 8250: fix panic due to PSLVERR")

thanks.

> 
> Thanks
> Udit
> 
> 
>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>> ---
>> Change since v1:
>> - refine the comments and type per Andy
>> Link: https://lore.kernel.org/linux-serial/20260907074035.77796-1-yang.yicong@picoheart.com/
>>
>> Change since v1:
>> - simply the workaround path per Ilpo and Andy
>> - run ~48k reboot tests and didn't reproduce the issue
>> Link: https://lore.kernel.org/linux-serial/20260629075510.32854-1-yang.yicong@picoheart.com/
>>
>>  drivers/tty/serial/8250/8250_dw.c    | 9 ++++++++-
>>  drivers/tty/serial/8250/8250_dwlib.c | 5 +++++
>>  drivers/tty/serial/8250/8250_dwlib.h | 5 +++++
>>  3 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> index 51d026f20825..b8a0bca8b536 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -439,8 +439,15 @@ static int dw8250_handle_irq(struct uart_port *p)
>>  	if (!up->dma && rx_timeout) {
>>  		status = serial_lsr_in(up);
>>  
>> +		/*
>> +		 * Do the bogus read from Shadow RBR (SRBR) if provided.
>> +		 * Both RBR and SRBR are supported ways to workaround
>> +		 * this problem. But read RBR can cause hardware error
>> +		 * (PSLVERR) if hardware choose to implement in this way
>> +		 * (implement REG_TIMEOUT_WIDTH to 0), whereas SRBR won't.
>> +		 */
>>  		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>> -			serial_port_in(p, UART_RX);
>> +			serial_port_in(p, d->data.srbr);
>>  	}
>>  
>>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
>> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
>> index 8859e66d2d71..9bb02a4ab11f 100644
>> --- a/drivers/tty/serial/8250/8250_dwlib.c
>> +++ b/drivers/tty/serial/8250/8250_dwlib.c
>> @@ -247,5 +247,10 @@ void dw8250_setup_port(struct uart_port *p)
>>  
>>  	if (reg & DW_UART_CPR_SIR_MODE)
>>  		up->capabilities |= UART_CAP_IRDA;
>> +
>> +	if (reg & DW_UART_CPR_SHADOW)
>> +		pd->srbr = DW_UART_SRBR_0;
>> +	else
>> +		pd->srbr = UART_RX;
>>  }
>>  EXPORT_SYMBOL_GPL(dw8250_setup_port);
>> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
>> index 1fe52332e774..ee7a07fac0f6 100644
>> --- a/drivers/tty/serial/8250/8250_dwlib.h
>> +++ b/drivers/tty/serial/8250/8250_dwlib.h
>> @@ -13,6 +13,7 @@
>>  #include "8250.h"
>>  
>>  /* Offsets for the DesignWare specific registers */
>> +#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
>>  #define DW_UART_USR	0x1f /* UART Status Register */
>>  #define DW_UART_DMASA	0xa8 /* DMA Software Ack */
>>  #define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
>> @@ -90,6 +91,10 @@ struct dw8250_port_data {
>>  
>>  	/* RS485 variables */
>>  	bool			hw_rs485_support;
>> +
>> +	/* Register offsets */
>> +	/* Shadow RBR (if not defined RBR will be used) */
>> +	int		srbr;
>>  };
>>  
>>  void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
