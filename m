Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922433EE
	for <linux-serial@vger.kernel.org>; Mon, 20 May 2024 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716187320; cv=none; b=hVLVUeehXOT2MTTU/IBl40NBp1/obtdkHLUEYcDvcPGpq7vdFx34ayKO8vVGiZItW8PvOeq+73EDVt/eTVbw47rNYxJ9X7KCo+Sk7GjCHb9GY4wFyJvKtn/l536Rd4d/KBJT4KUegMo5wNAsA2ZhFC/avp15WzA5q2p2mZypjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716187320; c=relaxed/simple;
	bh=rByNX+dJfFLNcl7pMvAdXIKt1DWfMvvzQ6wiuZOyKwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGWHrwrLYIVMphzQ0y4H64SrscAs0nddMlGXgTBl5QLper0A1gE6L7Iz1fjoHVuPIMZndjzN1SeS6pw7KbcIVxuBqZOUuOKBu2l42W5tISX6vr1wMlqamr+OefSMo6Jl4layXEe7RhuyVcUerHjI631FJhh+y2Qqr90vUBpQFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-523b017a5c6so5817361e87.1
        for <linux-serial@vger.kernel.org>; Sun, 19 May 2024 23:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716187317; x=1716792117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GYE/9YBLjlPUwvQBDlioCYmFiT7k9/Z8ABOnGPFNC0=;
        b=vwVsUxz746GZcbAHP8o3KEn69lCwEmuMEJZKB5HQ5LuK6P5vT/IoQV4/LZjIL0G2mj
         Y9Pt0x1azsctMAlALENST9dL0pm11WK4VgxuTiWcdMEfgMqA4xmfdbFm9bhMBA+PtAie
         FiegIwE5Cpew0KM7HOI04PrX6i4w7UOgUajUIe80nyaJykH7QqwZJtAztLQ33UdLBrQq
         6ION7fi7bZkxqHKS/lyx3U4U1gN2T+pUvMyUA4cOP+E63bwcZSDl+pJie3RQH/GXeyWs
         75OwVKW6SvjNhVPn9pVivExpzuuEUUL3XCbfp/SnScQzpdP5KNYkpz089zLd/XdaAONU
         HlKw==
X-Forwarded-Encrypted: i=1; AJvYcCUchlP2M+sUlbD3An0aPh/94ethpXBEdlWhqdk7P2oYbzuRDyIn4dcTcGrTGd+b08tyaHwItUQdaSA2qFBwjLkFDk4n/yZSy/EIUpRC
X-Gm-Message-State: AOJu0YwSAfy7dRJOQbkHkOgTzqT3sX4Z7jdxbK5uKKGq1L35CB1Ga6wt
	z8D9xdxQtL7b0HWiS/2bYpZHJE3Fe0F+HX1ink09oqgmooCaSRmQ
X-Google-Smtp-Source: AGHT+IEYy8+SBUc+U1edz47bS5pKkIG+OZGQbpZkJPIlXiUVNZZuAJB6yGHKo+Qfq5YiLfHFIU2SOg==
X-Received: by 2002:a05:6512:238a:b0:51a:c7d0:9e84 with SMTP id 2adb3069b0e04-5220fc7c57bmr32092191e87.12.1716187316411;
        Sun, 19 May 2024 23:41:56 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cdd444323sm579151366b.183.2024.05.19.23.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 23:41:56 -0700 (PDT)
Message-ID: <207771fc-294a-4810-a3a2-52ea0e27360f@kernel.org>
Date: Mon, 20 May 2024 08:41:55 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: pxa: Disable TX interrupt if there is no more
 data to transmit
To: Doug Brown <doug@schmorgal.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>
References: <20240519193109.122466-1-doug@schmorgal.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240519193109.122466-1-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 05. 24, 21:31, Doug Brown wrote:
> If a TX interrupt occurs and no new data gets loaded into the TX FIFO,
> the UART will never fire another TX interrupt until the UART_IER_THRI
> flag is toggled off and back on. If nothing ever calls stop_tx(), this
> effectively results in transmissions getting hung up until another
> unrelated UART IRQ occurs, such as an RX interrupt.
> 
> The driver used to do this correctly until the transition to
> uart_port_tx_limited(). This didn't matter until the behavior of
> __uart_port_tx changed in commit 7bfb915a597a ("serial: core: only stop
> transmit when HW fifo is empty").
> 
> Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
> 
> Note: I based this on v6.9 instead of tty-next since it's a fix; please
> let me know if that was the wrong move and I would be happy to resubmit
> it based on tty-next. The patch changes ever so slightly because of the
> circ_buf -> kfifo transition. The only difference is it needs this
> condition in the "if" statement instead:
> 
> kfifo_is_empty(&up->port.state->port.xmit_fifo)
> 
> This has been tested to work properly on tty-next as well.
> 
>   drivers/tty/serial/pxa.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index e395ff29c1a2..8abb85bee87c 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -176,6 +176,14 @@ static void transmit_chars(struct uart_pxa_port *up)
>   {
>   	u8 ch;
>   
> +	/* If there is nothing left to transmit, disable the TX interrupt.
> +	 * Otherwise we can get stuck waiting for another IRQ that never happens.
> +	 */
> +	if (uart_circ_empty(&up->port.state->xmit)) {
> +		serial_pxa_stop_tx(&up->port);
> +		return;
> +	}

This does not make sense. If the circ buf is empty, 
uart_port_tx_limited() should stop the TX already. You simply revert to 
the state before 7bfb915a597a, but on a per-driver basis.

IOW all drivers using the helper would have exactly this issue after 
7bfb915a597a.

What driver was 7bfb915a597a about after all? The commit log of the 
commit is hopeless (it's very vague) in this respect:
commit 7bfb915a597a301abb892f620fe5c283a9fdbd77
Author: Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sun Mar 3 16:08:07 2024 +0100

     serial: core: only stop transmit when HW fifo is empty

     If the circular buffer is empty, it just means we fit all characters to
     send into the HW fifo, but not that the hardware finished transmitting
     them.

     So if we immediately call stop_tx() after that, this may abort any
     pending characters in the HW fifo, and cause dropped characters on the
     console.

     Fix this by only stopping tx when the tx HW fifo is actually empty.

     Fixes: 8275b48b2780 ("tty: serial: introduce transmit helpers")



(And it barely fixes 8275b48b2780 per se. 8275b48b2780 only moved the 
processing to a single place, most/all of the drivers already did it 
that way.)

/me confused.

Perhaps, it should be reverted and the affected driver should just pass 
UART_TX_NOSTOP instead?

>   	uart_port_tx_limited(&up->port, ch, up->port.fifosize / 2,
>   		true,
>   		serial_out(up, UART_TX, ch),

thanks,
-- 
js
suse labs

