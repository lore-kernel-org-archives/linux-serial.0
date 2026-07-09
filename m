Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA45407CF4;
	Thu,  9 Jul 2026 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593667; cv=none; b=R8lprzlY5Sz4q4kHBFPxPiCHxyrpOLD/pAJI1V0hFyOvrZaFqRwTns/Ko+SZyWiuebnZZOwy3EVNNk128DtWeSzFtt/JBSN9mhNWHG5dsHDL8RdohcfdR1ND2DvjzKsC0SSMMqPgawWRVR9Zkj0ejYENszjnAy4GdpUJssjle5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593667; c=relaxed/simple;
	bh=/UYcyk4xSHZW2Za0icB5gjH5AfgATKKeiMDzb2mPIJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPxhPrMh3zlIECc07Mfe+5p7POmuquFJlAz9HjAQE6WT0ihzp7cIpEK+blRejHUKEpeNUNO1hfxxEoIvfkEw4NP/TxPfIYPQQf16nElHelCKDr3wCHV3Pp8y5DVJfpQ0LbyGcNeBT0aL5/lOve7K7cIhUTmudStqMU9J0kwZO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STkRj/LJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STkRj/LJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E7A1F000E9;
	Thu,  9 Jul 2026 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783593665;
	bh=Ok8nCG+5ZUFZj4SNj3aC5QZ5vEPt/YStIDSNq8/fAF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=STkRj/LJzMV0y33mat/04iL/Rkp9jnDa3B37IZtIN4rJZrUZc3xZijpHBNGMCVJQQ
	 JosSQ6bPHF2MqwrsNxG+Kqh06g6Zrh3OFM2uLjiDinxxiHmeq0NH33uslRWHXTC3/w
	 o2rYidt8u3440u3k+mQUh7VQsDWKHdZ4oswBxhmzDfOzZd38dIZTYOKW0ocwebHlvO
	 DolFRIp+SWmeduVF8/YY+8zOW5vHGI/h0RXtcmiuXrpoeESQ99Gwe9szLR7yl0ai/X
	 dAKS+GrEpwow5fzTnRBGoR8PtlqhN/PogcYBZmDEbm5rbzqH5mWXzpWkgYHP/jTxct
	 bAiOINJDJykmQ==
Message-ID: <158e6123-46fe-4a8c-9de4-093009a22a02@kernel.org>
Date: Thu, 9 Jul 2026 12:41:03 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: max310x: drive RTS in software when hardware
 delays are too short
To: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260709-max310x-rs485-sw-delay-v1-1-454ac10b937a@vaisala.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260709-max310x-rs485-sw-delay-v1-1-454ac10b937a@vaisala.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09. 07. 26, 10:46, Tapio Reijonen wrote:
> max310x_rs485_config() rejected delay_rts_before_send and
> delay_rts_after_send values larger than 0x0f with -ERANGE, which made
> the UART core wipe port->rs485 in uart_rs485_config() and silently
> disable RS485. The HDPIXDELAY register holds the setup and hold
> delays in 4-bit-per-direction bit-times, so even values inside that
> range only encode a fraction of a millisecond at typical baud rates
> and the chip's hardware auto-RTS path cannot cover the millisecond
> range the kernel UART layer expresses.
...
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
...
> @@ -324,6 +345,21 @@ static struct uart_driver max310x_uart = {
>   
>   static DECLARE_BITMAP(max310x_lines, MAX310X_UART_NRMAX);
>   
> +static ktime_t max310x_get_character_duration(const struct ktermios *termios,
> +					      unsigned int baud)
> +{
> +	const unsigned int startstop = 2;
> +	const unsigned int char_bits = startstop +
> +		(((termios->c_cflag & CSIZE) == CS5) ? 5 : 0) +
> +		(((termios->c_cflag & CSIZE) == CS6) ? 6 : 0) +
> +		(((termios->c_cflag & CSIZE) == CS7) ? 7 : 0) +
> +		(((termios->c_cflag & CSIZE) == CS8) ? 8 : 0) +
> +		((termios->c_cflag & PARENB) ? 1 : 0) +
> +		((termios->c_cflag & CSTOPB) ? 1 : 0);

Is this an open-coded tty_get_frame_size()?

> +
> +	return us_to_ktime(DIV_ROUND_UP(USEC_PER_SEC * char_bits, baud));
> +}
> +
>   static u8 max310x_port_read(struct uart_port *port, u8 reg)
>   {
>   	struct max310x_one *one = to_max310x_port(port);
> @@ -680,6 +716,39 @@ static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int l
>   	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
>   }
>   
> +static void max310x_rts_ctl(struct uart_port *port, bool rts_state)
> +{
> +	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_RTS_BIT,
> +			    rts_state ? MAX310X_LCR_RTS_BIT : 0);
> +}
> +
> +/*
> + * Drive the RS485 RTS line to match the current tx_state. This is the only
> + * place that touches RTS, and it reads tx_state rather than a fixed
> + * assert/deassert intent, so a newer assert is never clobbered by a stale
> + * release. It also arms the before-send timer once the RTS edge is on the wire,
> + * so data is never shifted before RTS is asserted.
> + */
> +static void max310x_rts_work_proc(struct work_struct *ws)
> +{
> +	struct max310x_one *one = container_of(ws, struct max310x_one, rts_work);
> +	struct uart_port *port = &one->port;
> +	unsigned long flags;
> +	bool rts_on = READ_ONCE(one->tx_state) != MAX310X_TX_OFF;
> +
> +	max310x_rts_ctl(port, rts_on ?
> +			(port->rs485.flags & SER_RS485_RTS_ON_SEND) :
> +			(port->rs485.flags & SER_RS485_RTS_AFTER_SEND));
> +
> +	spin_lock_irqsave(&port->lock, flags);

We use guard()s these days.

> +	if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_BEFORE_SEND &&
> +	    !one->cancel_tx_delay_tmr && !hrtimer_active(&one->tx_delay_tmr))
> +		hrtimer_start(&one->tx_delay_tmr,
> +			      ms_to_ktime(port->rs485.delay_rts_before_send),
> +			      HRTIMER_MODE_REL);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
>   static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
>   {
>   	struct max310x_one *one = to_max310x_port(port);
> @@ -776,6 +845,75 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
>   	tty_flip_buffer_push(&port->state->port);
>   }
>   
> +static enum hrtimer_restart max310x_tmr_tx(struct hrtimer *timer)
> +{
> +	struct max310x_one *one = container_of(timer, struct max310x_one,
> +					       tx_delay_tmr);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&one->port.lock, flags);

guard() on more places.

> +	if (!one->cancel_tx_delay_tmr) {
> +		if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_AFTER_SEND) {
> +			/* After-send hold elapsed: drop RTS via the rts worker. */
> +			WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
> +			schedule_work(&one->rts_work);
> +		} else {
> +			WRITE_ONCE(one->tx_state, MAX310X_TX_SEND);
> +			schedule_work(&one->tx_work);
> +		}
> +	}
> +	spin_unlock_irqrestore(&one->port.lock, flags);
> +
> +	return HRTIMER_NORESTART;
> +}

thanks,
-- 
js
suse labs
