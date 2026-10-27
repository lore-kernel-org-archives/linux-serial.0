Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100432;
	b=0hi746EAaDxaJZ0NXhWl16MRmnSRGD85Uu/MZlsUUbkbqB9uLJi+FclsNIrW0Y+jibH0
	 ybYyufag3OD4iUSliEA9pfT4hU83U6ILhnMHMROI5NQKAh/TxqLtC4Y7zeZFe7dRgOcgo
	 OWIaJjNK5Q2utpKAKFw37fSwyUB6SpzeTZYWsEIsfF/DNyV8IDutMAzKuogM/wqK+vAqU
	 oiVZQlSfU5/JvbTvz6t3ez5NSBiGg56fdzIivipJgDfxrj7ZRx6fQcq+TjKXHQZ8GR5gI
	 7+kbjF0aVfLjdEvPIwqmPrgstLK/qTxj05ZTQ9VEgbUvKJKsh9dTImzSxmeXWfXFScQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100432;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GbQ0MT6Xqpot2fekosyGQ6/rCmYxlnIL0o9qnEGTdeY=;
	b=Ek2Y8WuuHtBnwmYca/hsmhcX1AZ3CXQhauNGGs6/PXg9h9gPM+qxJ2V+MWJVnRddCFlu
	 9VH7YacGblKqqbHtNn6LS6LtxutJKf0SAy5eI4/EguVzSQXXXQghcb+dhqZKaG6nTIgwJ
	 GOct9kYDPvZNePYdhgcSnypP4TV9GBbZCx1AGt8L2TbWhP0rY+DwQ+qUxnb5XwvwBF8MP
	 MdWBLl3ZRTPJRzvdL0GVvYduPrbMJWgp56Po3zWUUaej8UxYuovJ39XWApnu1UN+/zgEz
	 nSSCAtQzNxf4zaXinIrOJzJOHzNCMLhqnVv7TZORYDCjxJF6+Fb7ouM5/8EgptoG3ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrPot6Og;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAFC606A336;
	Tue, 27 Oct 2026 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrPot6Og
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC97D1F01825;
	Tue, 27 Oct 2026 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100431;
	bh=GbQ0MT6Xqpot2fekosyGQ6/rCmYxlnIL0o9qnEGTdeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RrPot6Og8C+qKJM4R9pkgT6wVuQmvbG4jKmBzTVk1CCz2mqWPsWPXvzOm2Yj17brv
	 IoXQJf0vefmP/TPNz5OZqwOrfLEwpucaWatI+NpQFj3jTvzd7Og8owID/ajakn+3O0
	 AQnS9zRU+Nj6zY0skMkm+5Iy5WbVKPjVDsJ103e/A0NW6GWcaQtEGkMjJ66cBVWaZj
	 +LBlhRzDRw+sCDqGeAm0fd8YRjfJe4O+soo6T8TF6usyyorMyjRb2NGozs86heRLVA
	 EZtrEWFkjdHvlHbPx7tksxLg+gQwSkAzHeYyiwLz4eN6CPCrs41t+3IYz95dy24DKn
	 jWtww4NLJVvkw==
Message-ID: <614ae12a-4ac2-4a3d-a49e-78b69d457915@kernel.org>
Date: Tue, 27 Oct 2026 12:27:09 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] serial: 8250: ioc3: store registered line number in
 driver data
To: sashiko-reviews@lists.linux.dev,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-14-99b0202ae546@linuxfoundation.org>
 <sashiko-outbox-186414@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <sashiko-outbox-186414@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 10. 26, 12:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] serial: 8250: ioc3: undeclared identifiers in serial8250_ioc3_probe()
> --
> 
> commit 42c7c91e0766573099398067e430ef38776baba0
> Author: Joshua Rogers <linux@joshua.hu>
> 
> serial: 8250: ioc3: store registered line number in driver data
> 
> This commit attempts to save the registered line number into data->line in
> serial8250_ioc3_probe() so the remove path unregisters the proper port.
> 
>> diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
>> index 088242de2eff9..3ab50e04be451 100644
>> --- a/drivers/tty/serial/8250/8250_ioc3.c
>> +++ b/drivers/tty/serial/8250/8250_ioc3.c
>> @@ -63,6 +63,7 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
>>   	if (IS_ERR(uport))
>>   		return PTR_ERR(uport);
>>   
>> +	data->line = line;
> 
> [Severity: Low]
> Does this break compilation when CONFIG_SERIAL_8250_IOC3 is enabled because
> neither data nor line is declared in serial8250_ioc3_probe()?
> 
> Prior commit d6a0791098bede ("serial: 8250: make port operations work on
> struct uart_8250_port") refactored drivers/tty/serial/8250/8250_ioc3.c to
> remove struct ioc3_8250_data, data, and line:
> 
> drivers/tty/serial/8250/8250_ioc3.c:serial8250_ioc3_probe() {
> 	struct uart_8250_port *uport, up;
> 	struct resource *r;
> 	void __iomem *membase;
> 	int irq;
> 	...
> 	uport = serial8250_register_8250_port(&up);
> 	if (IS_ERR(uport))
> 		return PTR_ERR(uport);
> 
> 	platform_set_drvdata(pdev, uport);
> 	return 0;
> }
> 
> and updated serial8250_ioc3_remove() to pass uport directly to
> serial8250_unregister_port():
> 
> drivers/tty/serial/8250/8250_ioc3.c:serial8250_ioc3_remove() {
> 	struct uart_8250_port *uport = platform_get_drvdata(pdev);
> 
> 	serial8250_unregister_port(uport);
> }
> 
> Since the driver now stores and unregisters uport directly rather than
> tracking a line number in data->line, is this change obsolete on top of
> commit d6a0791098bede?

It is. And I did not notice this bug prior to d6a0791098bede, so there 
is no "preparatory" fix before that commit. Therefore, this might be a 
fix for older (stable) kernels, actually.

thanks,
-- 
js
suse labs
