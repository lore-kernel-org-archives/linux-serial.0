Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F822DF96;
	Fri, 25 Apr 2025 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563280; cv=none; b=B9LZhPmRMzjeojHWRVFUv3BcVdenayjYT5XRhkZPk6RMnq0BisVK29nb9SRPQxG4eQe49rnc9Bd79dOKF+kneWnFTdP7AG1acEE655WhCrnu/nuX/gzSj1Jh2nzg6/ICj4q7aT2/Y7dAfEK3XNVZGCLKRb/VGPogquvLhKB09DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563280; c=relaxed/simple;
	bh=caqDoDHC4N/BJwCN/vbQlVrvvBBi9e4J4az3N5xkiR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n3V4CcvzLMgNE/62GQcB4ADyEOsZnin302Tc+yY7TS2qcBIT5PFaq1UCPsayc6RgRkepJDBj4dpjjVgG3m53imI1btI9AejFilwHoOe3N+lrz8p/wj8JnvgrJPv1iKEXcMQP4+m49FR1b/obwK0VLBWfqYyzOUhxzsbU2Qaw55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syalvRI9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syalvRI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D94DC4CEEB;
	Fri, 25 Apr 2025 06:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745563279;
	bh=caqDoDHC4N/BJwCN/vbQlVrvvBBi9e4J4az3N5xkiR8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=syalvRI92jI128TlTG3R7wRPGu5QOr9AJAV9xqhmx91jNPc1rxepzKb7ljimfFSQn
	 vVhhTA6Plurrw7oRqCoVOA4krUajhFIX9tB0qnl3Dv/uo8/NpN6Ch280TPelYY+Jx+
	 DcmcYXPWIY2SLx1z9vao5S+DA7tj6fbam0ud+so5N+JAM3qh3LGC64b2iVov2Yr5IY
	 ITbWsBfrnPlxTGKyT3YtTnxmK7GkHARYWXs3fqj7bGxykNjHRBjb+F1zkTztFJY2xk
	 X7xBqeaAUmJ2mfxYI3+ZafU8XmCHrvvPNt9cclxhztlfVvT8Jdh/nQB903FBm4g+qG
	 tN8TsxfR1rK9w==
Message-ID: <57d75d55-81e3-445f-a705-e8c116281515@kernel.org>
Date: Fri, 25 Apr 2025 08:41:14 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
To: Yunhui Cui <cuiyunhui@bytedance.com>, arnd@arndb.de,
 andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu,
 gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, jkeeping@inmusicbrands.com,
 john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, markus.mayer@linaro.org,
 matt.porter@linaro.org, namcao@linutronix.de, paulmck@kernel.org,
 pmladek@suse.com, schnelle@linux.ibm.com, sunilvl@ventanamicro.com,
 tim.kryger@linaro.org
References: <20250425062425.68761-1-cuiyunhui@bytedance.com>
 <20250425062425.68761-4-cuiyunhui@bytedance.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250425062425.68761-4-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 04. 25, 8:24, Yunhui Cui wrote:
> In the case of RX_TIMEOUT, to avoid PSLVERR, disable the FIFO
> before reading UART_RX when UART_LSR_DR is not set.
> 
> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/tty/serial/8250/8250_dw.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 07f9be074b4b..1e364280a108 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -273,6 +273,7 @@ static int dw8250_handle_irq(struct uart_port *p)
>   	unsigned int quirks = d->pdata->quirks;
>   	unsigned int status;
>   	unsigned long flags;
> +	unsigned char old_fcr;

No more unsigned char, please. Use u8.

> @@ -288,9 +289,19 @@ static int dw8250_handle_irq(struct uart_port *p)
>   		uart_port_lock_irqsave(p, &flags);
>   		status = serial_lsr_in(up);
>   
> -		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> +		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> +			/* To avoid PSLVERR, disable the FIFO first. */
> +			if (up->fcr & UART_FCR_ENABLE_FIFO) {
> +				old_fcr = serial_in(up, UART_FCR);
> +				serial_out(up, UART_FCR, old_fcr & ~1);

s/1/UART_FCR_ENABLE_FIFO/

> +			}
> +
>   			(void) p->serial_in(p, UART_RX);
>   
> +			if (up->fcr & UART_FCR_ENABLE_FIFO)
> +				serial_out(up, UART_FCR, old_fcr);
> +		}
> +
>   		uart_port_unlock_irqrestore(p, flags);
>   	}
>   


-- 
js
suse labs
