Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858227FD68;
	Fri,  5 Sep 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063046; cv=none; b=E2b4PzzftU21eUpkXqP09TKYxppxiyCi8b6HH3JI1eLXFK9rcz35+07aLj23OUMaMxIzuh+9QwC+pmpMJjvIq9d220+9bicZ8fP2i0sDMrE8WD0qLyjn0BQpakA8q5ViymF974LZhvMZEUHfKrfXJMFI4+/Y3DPBMWES0ReaeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063046; c=relaxed/simple;
	bh=wW7SRuZVkG23a2j8DWcn7U5sLsE9KHq3ikpA+hG0BZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkFr6/wknh3kcwq9Xr/Ju0qEFkfHjz6YI4ZSRCBhOrlVAtw+KGfD29BdSO5LRFgYBGOpi0mMe1SJbIexjw/IxMN9kLRiNQ/wakp0Cd2EEOW3G+ORjLKOr3KprdsHTxoHBe9kxclGk1PloRTgayICb4KDDlT5NY1U9Xsn2hBBx60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrqYURiH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrqYURiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A26C4CEF1;
	Fri,  5 Sep 2025 09:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757063046;
	bh=wW7SRuZVkG23a2j8DWcn7U5sLsE9KHq3ikpA+hG0BZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KrqYURiHl9WW3BKNPBpSj4gXA5ntoJNfOTJz1+cDUhzStfHbhy0siSiHRoTJSkGZk
	 vM76jsyVoz0vkSRXHz4aBm+5zOFxOPsegOq03PLL42E4ME22LfPuoPZDT9RPWQcYh9
	 8DsZEhgX2A+9gjCnCZI4BV3y+lETAK0qmUxeOlqw5d+weRxfQeSwcQCK0vHTU9IwSm
	 XivXtD2b4AmOJHFsrTyjF862ZUDx8E6iJw/zMQ/G+lLcbfsMPUyMl1+L9mgeqBdUG5
	 DXnev1QHeW+s8gcorcdFz40r9CaTCfwMOhyriFk5p/EWla2R4A2FqhxXLvIRVXJueI
	 yCwZ72wOEG5iQ==
Message-ID: <3e80ed12-1d47-46f3-968d-c9246c4949c5@kernel.org>
Date: Fri, 5 Sep 2025 11:04:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: max310x: improve interrupt handling
To: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Shiyan <shc_work@mail.ru>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250905-master-max310x-improve-interrupt-handling-v2-1-7387651a5ed2@vaisala.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250905-master-max310x-improve-interrupt-handling-v2-1-7387651a5ed2@vaisala.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05. 09. 25, 10:54, Tapio Reijonen wrote:
> When there is a heavy load of receiving characters to all
> four UART's, the warning 'Hardware RX FIFO overrun' is
> sometimes detected.
> The current implementation always service first the highest UART
> until no more interrupt and then service another UART
> (ex: UART3 will be serviced for as long as there are interrupts
> for it, then UART2, etc).
> 
> This commit handle all individual interrupt sources before
> reading the global IRQ register again.
> 
> This commit has also a nice side-effect of improving the efficiency
> of the driver by reducing the number of reads of the global
> IRQ register.
> 
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
> Changes in v2:
> - Improve content of the commit message
> - Fix a line indention in prevoius patch
> - According review comments, changed to use for_each_clear_bit
>    to simplify serve all IRQs in a loop.
>    NOTE: When a bit in IRQ[n] is set 0 the associated UART’s
>    internal IRQ is generated.
> - Link to v1: https://lore.kernel.org/r/20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com
> ---
>   drivers/tty/serial/max310x.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index ce260e9949c3c268e706b2615d6fc01adc21e49b..464f2828bd304198d79046e79b2a8a0893e5cd77 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -825,14 +825,24 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
>   	if (s->devtype->nr > 1) {
>   		do {
>   			unsigned int val = ~0;
> +			unsigned long irq;
> +			unsigned long port;
> +			bool done = true;
>   
>   			WARN_ON_ONCE(regmap_read(s->regmap,
>   						 MAX310X_GLOBALIRQ_REG, &val));
> -			val = ((1 << s->devtype->nr) - 1) & ~val;
> -			if (!val)
> +
> +			irq = val;
> +
> +			for_each_clear_bit(port, &irq, s->devtype->nr) {

port can be uint, no need for ulong.

> +				done = false;
> +
> +				if (max310x_port_irq(s, port) == IRQ_HANDLED)
> +					handled = true;
> +			}

Hey, this looks to be the order of magnitude saner!

> +
> +			if (done)
>   				break;
> -			if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
> -				handled = true;
>   		} while (1);

So now, this should perhaps be "while (!done)"?

thanks,
-- 
js
suse labs
