Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010432F771;
	Wed, 15 Oct 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543379; cv=none; b=bLOcYMJwRrrz90uAH8XTYcIYfUYrcI7WN8tIHJ3MIoVu/GjT1EB9i/XHKfYlWuInN49xKBBr8x4fQSTtUAZSMmJCjEuhqJWVzmK8l/p6qWXwU0Be5hEGve3uiNNNIkSkDDCDWF68Ia1d7r4fii24zJjIdqGB+ovIb9fWE95htTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543379; c=relaxed/simple;
	bh=SvJQkrxK8S2FzNYqFRInIPoqJAGTOO1/f98SdCFBCtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/6RZif0+BHyE+MTmB6seGK3Ix5t0pb9BbK8ziSDeQGJyVuECa6KF65VhDwiQL2T6Ykk6tDfIiOvzaAPL7XkJ7TH/doG8j0yK7FWRuIPkKSYz2O1sHEPh1u06yQPu7dGsJu0+tUZwNjhokCHB5MpOCAYXyM0+f4oGQUqIzHvez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttyfpz0d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttyfpz0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39411C4CEF8;
	Wed, 15 Oct 2025 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760543378;
	bh=SvJQkrxK8S2FzNYqFRInIPoqJAGTOO1/f98SdCFBCtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ttyfpz0d22MFc/WgqeuQ8VFQn6uGy9JK9dsvqaD3esJ6yrCwGhnD6IIa3LdZu22jE
	 td5ZqWtRx+nBq30Q5ihELYPpQCO03WatZ+NIQ1Qc/52pOY5ZBMLmMoHrSrRo6Kgoq9
	 2k82RaLJoAaQSCjdD90QX9GAZfCc12No1us3ylGTCTN3wUupOjY42X2G5PhplZbJ8H
	 2fmWV860hNDNJjyXp83gNbDV2KcpKmOwSSvtyIA27EuLmxj+hu1KQllN2NcL7pkjDk
	 Mtpf1ciOvbkJWhVAXrsONBa0hFyn9DYe/1IEybzb6MojkaaedNJZARErJHvS0ykjDs
	 y4Daadk2JiIlQ==
Message-ID: <0eb4c357-aafd-42bd-a4fd-687a91831bf4@kernel.org>
Date: Wed, 15 Oct 2025 17:49:34 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250: always disable IRQ during THRE test
To: Peng Zhang <zhangpeng.00@bytedance.com>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 songmuchun@bytedance.com, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, buytenh@arista.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20251014114727.1186-1-zhangpeng.00@bytedance.com>
 <94d19d6d-5bb5-4156-8499-0be3d227f478@bytedance.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <94d19d6d-5bb5-4156-8499-0be3d227f478@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14. 10. 25, 14:19, Peng Zhang wrote:
> 
> 
> 在 2025/10/14 19:47, Peng Zhang 写道:
>> commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
>> has been set up") moved IRQ setup before the THRE test, so the interrupt
>> handler can run during the test and race with its IIR reads. This can
>> produce wrong THRE test results and cause spurious registration of the
>> serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
>> short duration of the test and re-enable it afterwards to avoid the race.
>>
>> Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq 
>> has been set up")
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   drivers/tty/serial/8250/8250_port.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/ 
>> serial/8250/8250_port.c
>> index 719faf92aa8a..addeef7a0d59 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct 
>> uart_port *port)
>>       if (up->port.flags & UPF_NO_THRE_TEST)
>>           return;
>> -    if (port->irqflags & IRQF_SHARED)
>> -        disable_irq_nosync(port->irq);
>> +    disable_irq_nosync(port->irq);
> disable_irq_nosync() may need to be changed to disable_irq() to prevent 
> interrupts that are currently being handled.

Make sense to me. Care to Cc the people from 039d4926379b next time, so 
that they can comment?

>>       /*
>>        * Test for UARTs that do not reassert THRE when the transmitter 
>> is idle and the interrupt
>> @@ -2170,8 +2169,7 @@ static void serial8250_THRE_test(struct 
>> uart_port *port)
>>           serial_port_out(port, UART_IER, 0);
>>       }
>> -    if (port->irqflags & IRQF_SHARED)
>> -        enable_irq(port->irq);
>> +    enable_irq(port->irq);
>>       /*
>>        * If the interrupt is not reasserted, or we otherwise don't 
>> trust the iir, setup a timer to
> 


-- 
js
suse labs
