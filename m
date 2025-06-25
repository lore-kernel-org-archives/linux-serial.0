Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4871E9B23;
	Wed, 25 Jun 2025 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750831146; cv=none; b=EuQnYNTbYO0FysnILv+oZiif1JIQ0IBz+l9M5hGEH+5UWo5sNcOrbnuIL0ZlrMGtBOQ3n8DsuSS0OgYCQdwEGL4Xd9FxcmJHQzOdvHc5JWviQYDV3Id3FHnFWQoEFrXdJbgdcyfIf7uFlKcNWlhp8VtWFfT9M8y7qrrDuWo7qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750831146; c=relaxed/simple;
	bh=nYLFlnE1dUAZWvCNMCq0coPB8yfRd/A1ttlDRK/JxjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sk/2DqzEiFdg2dvKtrgvueSibbnd7vcvjLzZ49dBntDAKM0t79+JCizHqXwaPSfevnvg9OQmCVY1lLabnuNM0IYo3fnS+k5x6iCp7Z8v+4nQ+9xeJrCNigmCe7TNkMb87aLyNfkD0wG+OY1d2nJ77gL7pExpPMdjwn4Pq9qy3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEa88tik; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEa88tik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04733C4CEF3;
	Wed, 25 Jun 2025 05:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750831146;
	bh=nYLFlnE1dUAZWvCNMCq0coPB8yfRd/A1ttlDRK/JxjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iEa88tiknwFMJVgxfZw+Syf9KdqYOfcLlxf5IOLvHsrQ4qVNk7MSJ/BU1LWU9Ch7t
	 eMhC5An7vVQBjIH7uCCAyBKiSb43iYLk45Ykq3urxYrYCblajL1178Hr+Gg1+a8s5z
	 h1wB6Zd7F746uF2EzA2w5MpNWTPFMYMjfTWGIIdR0d5O0Nd+fCLM7ZPrK/g6uRhqY7
	 be/jz5hV81ZUu+GgDem+c09/D3YE+6lkzcKuXWuo+a2lP6/FNf5pQbASSHgXCP0a9c
	 uLmrRMT1ld+4VTBoGyQmzxjVzyAkTdsk6D+RHl0/lzp1LX3ZwjtkfI3IgcVCUwc/zq
	 A3QD9nSINnybg==
Message-ID: <b7f6eaa3-f3f0-4cc8-b11a-1bb2daa57f5d@kernel.org>
Date: Wed, 25 Jun 2025 07:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] serial: 8250: extract serial8250_init_mctrl()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20250624080641.509959-1-jirislaby@kernel.org>
 <20250624080641.509959-2-jirislaby@kernel.org>
 <b78023eb-f5ab-6287-1cd7-5db76d905eed@linux.intel.com>
 <4d6b65af-294c-fd02-af91-099e22420472@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <4d6b65af-294c-fd02-af91-099e22420472@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 06. 25, 13:15, Ilpo Järvinen wrote:
> On Tue, 24 Jun 2025, Ilpo Järvinen wrote:
> 
>> On Tue, 24 Jun 2025, Jiri Slaby (SUSE) wrote:
>>
>>> After commit 795158691cc0 ("serial: 8250: extract
>>> serial8250_initialize()"), split serial8250_initialize() even more --
>>> the mctrl part of this code can be separated into
>>> serial8250_init_mctrl() -- done now.
>>>
>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> Heh, I didn't even realize I was suggesting this :-D but it's good
>> nonetheless.
>>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> ---
>>> [v2]
>>> * use port-> directly.
>>> * do not remove curly braces.
>>> Both rebase errors -- noticed by Andy.
>>> ---
>>>   drivers/tty/serial/8250/8250_port.c | 21 +++++++++++++--------
>>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>>> index 48c30e158cb8..0f85a2f292fc 100644
>>> --- a/drivers/tty/serial/8250/8250_port.c
>>> +++ b/drivers/tty/serial/8250/8250_port.c
>>> @@ -2216,15 +2216,8 @@ static void serial8250_THRE_test(struct uart_port *port)
>>>   		up->bugs |= UART_BUG_THRE;
>>>   }
>>>   
>>> -static void serial8250_initialize(struct uart_port *port)
>>> +static void serial8250_init_mctrl(struct uart_port *port)
>>>   {
>>> -	struct uart_8250_port *up = up_to_u8250p(port);
>>> -	unsigned long flags;
>>> -	bool lsr_TEMT, iir_NOINT;
>>> -
>>> -	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
>>> -
>>> -	uart_port_lock_irqsave(port, &flags);
>>>   	if (port->flags & UPF_FOURPORT) {
> 
> I should have also added what I meant with my earlier suggestion. AFAICT,
> this UPF_FOURPORT thing can only occur if SERIAL_8250_FOURPORT is enabled.
> 
> The challenge obviously are the if/else constructs but there are a few
> places that do port->flags & UPF_FOURPORT specific thing and something
> else otherwise. That hw-specific code could be placed into the hw-specific
> 8250_fourport.c file if the hw-specific function is made to return true
> if it did match, and the generic code runs otherwise.

So you can brew a patch for this, right :)? Every time I read some code 
the same you describe, I end up with 10+ patches. I don't want for now :P.

> I also have no idea why serial/sunsu.c checks UPF_FOURPORT, perhaps that's
> copy-paste in action. :-)

Yes, AFAI looked, it was during the switch of sunsu to serial driver. If 
you feel confident (it really appears apparent), drop that too ;).

thanks,
-- 
js
suse labs
