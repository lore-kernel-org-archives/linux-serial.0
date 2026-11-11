Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389834;
	b=HDdMv/DCHQQ7/Rgsehl9WzaWRbETQ7tavF9qadHtmXNPsd0bVOD+3qWtn8N817P2vbXf
	 6fS9xxACKB7DZEYkn5paNzTH5A0vkmP2Z5NS4I5qRjP0CQ6LmkPNaLxQYW5IdsEoqJz6o
	 TMlnFDO42i20jTR+Bfx28tD6/paBM+UuZN2Ltp91pWt328l0UoUUuUxMahApkrrvKfbTG
	 7lNa2oAU9RUMnY7diDfXkL5V2EDqJncAnlKl+pngZFz5u/5cKXJUhNpZzRf5cGA1GvdXw
	 bo+fPOxR80Dgcy6bos0IxtIuxuCNI/CVIf4GHh2t9Mqvznf5bnPH0PbQa22iHBlSZrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389834;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=d/ibkP7+lTRUcDgJvi0eIEOCUA+mfoFLErH7+1n7auM=;
	b=3Z5/ru6WLr/UAHePNPmlp7cX4kMPQPIA6eb4OzO/0skRVnUQ7H13JAH1k+qiBJHUqQKy
	 /hyPmd89c0JNA+deWfKg1W4k31/JDJ7Q7FIOcwuj0KfvaiUs+iUG+bTBb7+GZS9Vho+B2
	 j0XfQqBgeTE6WCt0n7GyO8uxf+x+8Tmn+dWuWIEH1iRFhcDHBI+A0Td8kxrIQ2e1jmoLK
	 KTYW7SOwBhx+safSlPZB7sGazRrnxXY4KlJYaRJUPzert1SY2XsXJF3iZC3AMd9zPnt6i
	 Eb88bEiRmYVI4lGCvAFYT0yVWFTPRzmQm3iHURslPv0XwYQJvWEZyKoh2KkO9O3I6yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrFZ8YXT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B2606A33A;
	Wed, 11 Nov 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrFZ8YXT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FF61F00A08;
	Wed, 11 Nov 2026 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794389833;
	bh=d/ibkP7+lTRUcDgJvi0eIEOCUA+mfoFLErH7+1n7auM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=QrFZ8YXTjKJrdUG+P34j0sFZm1UN3grl9CREEdauvFS4drBYUbvVqO8z3F2YdhlC8
	 taL5QKtQP4X2x4Nqp7mMW5dEmO5yJiqGukfC+UsC/Ic2WaDIp4taNUSNuSutdd30Ek
	 MgjYOPYKXGsqhFePxBbiVJWMItHBwRV9fjAX4w7AAciJVRqRUE7to9SUlOVnNcekeK
	 Bhf5tLQ4mNRJgRGnt+66c31SvLheV5ULu6tQMygkG67YVXIVaH6jbyL6MtZsExgGmN
	 BACwq2K9hyhd9c51K2UN34xiShvCQ2+zJYNoTdUr37lxVgWGjlTuCfmbwZ+UJh0Bwz
	 nRF128V7MFxgg==
Message-ID: <bf33966c-f200-47f7-b2ac-09e17b8f2ceb@kernel.org>
Date: Wed, 11 Nov 2026 10:37:10 +0100
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
Subject: Re: [PATCH] tty: serial: imx: return error when clk_per fails in
 imx_uart_poll_init()
From: Jiri Slaby <jirislaby@kernel.org>
To: Gu Bin <gubin@cmss.chinamobile.com>, gregkh@linuxfoundation.org
Cc: Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, danielt@kernel.org
References: <20261110105456.1563-1-gubin@cmss.chinamobile.com>
 <1e584df0-c74a-454f-a580-75dc7567abe1@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <1e584df0-c74a-454f-a580-75dc7567abe1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

One more try using .mailmap.

On 11. 11. 26, 10:21, Jiri Slaby wrote:
> On 10. 11. 26, 11:54, Gu Bin wrote:
>> In imx_uart_poll_init(), when clk_prepare_enable(sport->clk_per) fails
>> the error branch only disables the previously enabled clk_ipg and then
>> falls through: the function keeps programming the UART 
>> (imx_uart_setup_ufcr
>> and the register writes below) with both clocks disabled and eventually
>> returns 0, reporting success for a port that never came up.
>>
>> The sibling imx_uart_startup() handles the same situation by returning
>> the error after the rollback.
>>
>> Return the error after rolling back clk_ipg, matching
>> imx_uart_startup().
>>
>> Fixes: 6b8bdad96164 ("serial: imx: add imx_poll_init()")
>> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
> 
> I am not sure this is correct at all.
> 
> Ccin the author of the code would've helped. Done now.
> 
>> ---
>>   drivers/tty/serial/imx.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 0831bd5ee3dc..2a931361d17c 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1954,8 +1954,10 @@ static int imx_uart_poll_init(struct uart_port 
>> *port)
>>       if (retval)
>>           return retval;
>>       retval = clk_prepare_enable(sport->clk_per);
>> -    if (retval)
>> +    if (retval) {
>>           clk_disable_unprepare(sport->clk_ipg);
>> +        return retval;
>> +    }
>>       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
> 
> 

-- 
js
suse labs

