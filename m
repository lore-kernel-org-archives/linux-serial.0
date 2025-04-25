Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95B18D;
	Fri, 25 Apr 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563741; cv=none; b=HTMfUbsK1FXeaVcHwi1cbCvROZIP4ebNs17u9OBIztQ4XRoCwS2lyifNBwtpJNEhFbiXplxY9g0mRlCYaosQvJVn12jauFriki2tIULoiKYcLxDHNclqZIbZ32HIS6S2bnEw85ULOmtU/ii1dgWmwWQJCv64VFi0XKiHJZNqNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563741; c=relaxed/simple;
	bh=nJp8JM4fL6QtNcTdsC4q8EJI22PRtigoS547HoWALCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K4i8dR9V1HzWqxW1v2A4eNEnY/ob4ZWUIlO06oqH+sIaM3cNLh+lNHPstP1+U/0YU/z5QGc+f9Dr9mFonZDmYRWmKPK6XzNQuEa2xjvmDURSyqaFedUSjVxwKYpC8PXtzaQVGMobyfIqNHkTci8M3sClRfdO8Rte8rRuA7Z75uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkPndDs5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkPndDs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D19C4CEE4;
	Fri, 25 Apr 2025 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745563740;
	bh=nJp8JM4fL6QtNcTdsC4q8EJI22PRtigoS547HoWALCg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HkPndDs5AJ4n1x88Pn7bhGYHPQq0ceF9gF3LD7g3sjGLtmZIR7y5SpeLDhLyYojPj
	 F0uC3p28Ew75e3bd4XgkV1oLIU3Vh1vqZe22gX+SXL6V8BjrKAkTD06u2CdTxgbBhF
	 MVQMbx7SFbeBLbm1yzhv9nvNyjykbIGin1m+ISD+ututAqxF92kALGWFrAawmcrwjl
	 1aLT+WYhbXDgAaLIngkt0/gpqUKSI1FAohCBGthD2XQq3Epl0yTeUmdFezHF547YjT
	 chA+pwC3GSh+fwtHEKdDptYNOFz2OruQGHnjDGUh7x1pKLjbi2v/QS6T6mY0QMxvkJ
	 offpn6QczJmvw==
Message-ID: <3a24d3ab-9567-4a0c-b904-4225ab4c489b@kernel.org>
Date: Fri, 25 Apr 2025 08:48:54 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] serial: 8250: introduce serial8250_discard_data()
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
 <20250425062425.68761-2-cuiyunhui@bytedance.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250425062425.68761-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 04. 25, 8:24, Yunhui Cui wrote:
> To prevent triggering PSLVERR, it is necessary to check whether the
> UART_LSR_DR bit of UART_LSR is set before reading UART_RX.
> Ensure atomicity of UART_LSR and UART_RX, put serial8250_discard_data()
> under port->lock.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/tty/serial/8250/8250.h      | 15 +++++++++++
>   drivers/tty/serial/8250/8250_port.c | 42 ++++++++++++++---------------
>   2 files changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index b861585ca02a..5a106cf88207 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -162,6 +162,21 @@ static inline u16 serial_lsr_in(struct uart_8250_port *up)
>   	return lsr;
>   }
>   
> +/*
> + * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
> + * reading UART_RX.
> + */
> +static inline unsigned int serial8250_discard_data(struct uart_8250_port *up)
> +{
> +	u16 lsr;

Is lsr really 16-bit?

> +
> +	lsr = serial_in(up, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		return serial_in(up, UART_RX);

Why does a discard function return a value at all?

> +
> +	return 0;
> +}
> +
>   /*
>    * For the 16C950
>    */
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index a913135d5217..802ac50357c0 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
...
> @@ -2137,25 +2136,21 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>   static int serial8250_get_poll_char(struct uart_port *port)
>   {
>   	struct uart_8250_port *up = up_to_u8250p(port);
> -	int status;
> +	int status = NO_POLL_CHAR;
>   	u16 lsr;
>   
>   	serial8250_rpm_get(up);
>   
> +	uart_port_lock_irqsave(port, &flags);
>   	lsr = serial_port_in(port, UART_LSR);
> -
> -	if (!(lsr & UART_LSR_DR)) {
> -		status = NO_POLL_CHAR;
> -		goto out;
> -	}
> -
> -	status = serial_port_in(port, UART_RX);
> +	if ((lsr & UART_LSR_DR))

Too many parentheses.

> +		status = serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);

thanks,
-- 
js
suse labs
