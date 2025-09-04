Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163D242D92;
	Thu,  4 Sep 2025 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972409; cv=none; b=Ukk3zbeOEloJthkR/apqn0XHMoA/Z3YwTRY9O8s+Irn7ha1sFZozHEJh+iOPfxCaJ9qKq7gP5Dd0sqB78lz1PRVX9qQb5GT6kVMHhr67XDnj9LMLZJ+jhYkPwWzII6NZlFbCQHU17HPQrM/miyONrpvPcLIF8olXIpXO8bRU6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972409; c=relaxed/simple;
	bh=9s/42F0Gq7Ks2NERTbJK59XBbcqqqLVgnwg8Gtc4l0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKJ+wZUpSBy1fxuCDfC8NhatQobWAF+gPgZxyIzzC23LxJUCmZOaC4HUfh6y4fhCKYZW6xCNZE0PzKeZP+cax8PTkKnJFDmMsJ0VzQjny1qwU2YIcD+COZ6yeVNvlFRJo/7+vbnnmBTVsQkGgGQ9fvTazj5eOdUO38BFFiCgGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxwhBIOe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxwhBIOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDCBC4CEF0;
	Thu,  4 Sep 2025 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972408;
	bh=9s/42F0Gq7Ks2NERTbJK59XBbcqqqLVgnwg8Gtc4l0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IxwhBIOeDcl3TPSFhg6NrQPBDzjSsxaX4s4BNTedSM+tS93dkU0Jh6RdNi09DyKMI
	 lh3eGi6FZ2Y05CoTGFW31udOEs95ffqkS3T1XQ8BzUr9+uhOb7mgwrBeXVgUD/YpxW
	 6b8ldhgXcnhbg0Z4aokfFb21JMI1ghjH5LqfKClA61raKRTh8xI/245t2/DcV0XFXI
	 tuHt1jtvCPMbc/cDZVvFZAzoVAX920puzlM6miwtgmbbANyaLbl1SZRoDGMtt2z8RX
	 LDfa09z5rfiF8Rc9AWFTs3CQsjxax8Pm8jkE5VHjyINOiWUtK+xJuYCHsyZacKcQ7+
	 3mtpzRaDYc6ng==
Message-ID: <214edb7a-2631-4f7f-9516-a38a3796cc0b@kernel.org>
Date: Thu, 4 Sep 2025 09:53:25 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: max310x: improve interrupt handling
To: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Shiyan <shc_work@mail.ru>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03. 09. 25, 11:23, Tapio Reijonen wrote:
> When there is a heavy load of receiving characters to all
> four UART's, the warning 'Hardware RX FIFO overrun' is
> sometimes detected.
> The current implementation always service first UART3 until
> no more interrupt and then service another UARTs.
> 
> This commit improve interrupt service routine to handle all
> interrupt sources, e.g. UARTs when a global IRQ is detected.
> 
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>   drivers/tty/serial/max310x.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index ce260e9949c3c268e706b2615d6fc01adc21e49b..3234ed7c688ff423d25a007ed8b938b249ae0b82 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -824,15 +824,26 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
>   
>   	if (s->devtype->nr > 1) {
>   		do {
> -			unsigned int val = ~0;
> +			unsigned int val;
> +			unsigned int global_irq = ~0;
> +			int port;
>   
>   			WARN_ON_ONCE(regmap_read(s->regmap,
> -						 MAX310X_GLOBALIRQ_REG, &val));
> -			val = ((1 << s->devtype->nr) - 1) & ~val;
> +				MAX310X_GLOBALIRQ_REG, &global_irq));
> +
> +			val = ((1 << s->devtype->nr) - 1) & ~global_irq;

This is horrid. Use GENMASK() (or BIT() below) instead. Likely, you want 
a local var storing the mask (the first part before the &).

>   			if (!val)
>   				break;
> -			if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
> -				handled = true;
> +
> +			do {
> +				port = fls(val) - 1;
> +				if (max310x_port_irq(s, port) == IRQ_HANDLED)
> +					handled = true;
> +
> +				global_irq |= 1 << port;
> +				val = ((1 << s->devtype->nr) - 1) & ~global_irq;
> +			} while (val);

Actually, does it have to be from the end? I am thinking of 
for_each_and_bit()...

>   		} while (1);
>   	} else {
>   		if (max310x_port_irq(s, 0) == IRQ_HANDLED)

thanks,
-- 
js
suse labs
