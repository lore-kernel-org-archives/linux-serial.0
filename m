Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103363D5226;
	Thu,  9 Jul 2026 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580391; cv=none; b=Rh2Gktc+5XENx2KwWpXtzznUZ58AY2xl3lJQmIE/IhP4OubIvBjeTQ2rwjylSARm8+Zwrt68LYubxWxB3lRYHc17/3V5gwHS0Gl3VVIts7zTZsXn242v3Uau+jTSMcI2C3kXjWE+TSLYOPK14lg4S6vlFyIjZmiE069gY4uicX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580391; c=relaxed/simple;
	bh=jJJgbAW3S7giiSPDNYYxmlhnK68Eg+n0kXkC3TbKXTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4j2lOO1Vo7jutt/at2CakwIHIZmYJfNGXquTDOMS2tCgM+1W4qarYrK/ozpairxBNLSG8wYZlLNdW4KjqtgSuGlhCSyfQ6waLqnh3qIArWC3qG1BVX/mz9L9MapXEdwxk33Ek01FFEm5I9y7oR1+CAxmRx3wgbPXRBRffG1u00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6HbfMHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6HbfMHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEEB1F000E9;
	Thu,  9 Jul 2026 06:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580387;
	bh=unxJiU3o8MfYUzTgGPpKLMYaq7It2z7Ckp4kI4w1OSA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c6HbfMHO83C8jh8Q/JIuviM45cudWvZ/oVRvcC5G6DlG7dTQ++sGeGyj4eOAjqwJJ
	 5PeIasMZITYVX/nzXmmoKjWCoXINO94KCZ8XTIPSCI2BgcJKOaHv5bF1hczGiQuw1x
	 D5QZ3mNliahRGEgH2BK507nJ8Xzy8k0iScsbUhDjOslxwJu3T7IHYFRfbHmvGIkKlP
	 02nOhslljuoAWtp8hTqtJmCuMD2jfGbgtEqJ8vHntJuylBTpLkg9GauCbQ40dG1Dn8
	 4LSvi2syorPJhmQDmGGk/tMgCr0WczV+rYTXIM4ATOSpicg8N2dqtVVpsZ8kOIDpVy
	 iBl8GKfEJXopw==
Message-ID: <9b45a796-9b84-4977-b697-cc91c4c6adbf@kernel.org>
Date: Thu, 9 Jul 2026 08:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] serial: 8250_mxpcie: add custom handle_irq
 callback
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
 <20260709053314.435629-7-crescentcy.hsieh@moxa.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260709053314.435629-7-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09. 07. 26, 7:33, Crescent Hsieh wrote:
...
> --- a/drivers/tty/serial/8250/8250_mxpcie.c
> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
> @@ -266,6 +266,48 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
>   	serial_out(up, UART_IER, up->ier);
>   }
>   
> +static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
> +{
> +	struct uart_port *port = &up->port;
> +
> +	if (!(lsr & (UART_LSR_DR | UART_LSR_BI)))
> +		return lsr;
> +
> +	if (!(port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)))
> +		goto do_rx;
> +	if (lsr & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS))
> +		goto do_rx;
> +	if (port->read_status_mask & UART_LSR_DR)
> +		goto do_rx;

Perhaps extract the tests to a separate function (like bool 
mxpcie8250_should_rx()) to get rid of the goto+label?

mxpcie8250_should_rx() and serial8250_rx_chars() could be called 
directly in the ISR then...

> +	return lsr;
> +
> +do_rx:
> +	return serial8250_rx_chars(up, lsr);
> +}
> +
> +static int mxpcie8250_handle_irq(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	u16 lsr;
> +	u8 iir;
> +
> +	iir = serial_in(up, UART_IIR);
> +	if (iir & UART_IIR_NO_INT)
> +		return 0;
> +
> +	guard(uart_port_lock_check_sysrq_irqsave)(port);
> +
> +	lsr = mxpcie8250_rx_chars(up, serial_lsr_in(up));
> +
> +	serial8250_modem_status(up);
> +
> +	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
> +		serial8250_tx_chars(up);
> +
> +	return 1;
> +}


thanks,
-- 
js
suse labs
