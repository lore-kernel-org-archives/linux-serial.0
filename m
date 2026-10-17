Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809346F4A4
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792228072; cv=none; b=HtvfFRx4GwYfHxt/3C6VMLh1jJeB09IEzGb7ELHjoB+kRyuYg0SCrsESOIRYh95cxxFaSzxnuqOGxoDH4KPXD7OTMb5GcZys6zeW7DR8P8LvRuiaVaVimzkZbN6SGQQ745O796ysRCU/A74R5lZrO34gglWpXtT6rmL9EYDDMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792228072; c=relaxed/simple;
	bh=gaMMUvSzpKODw+BMmNte1gSFoGv6Eaf9sQ1dWebmgO8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DSZ+YTPER5d1TqGhNDL7wCsSnh1YQOwtPrL0vYTOIpniOXzlRPyXtjBlrt+RDMUwpSPxPFz8J+91Iioyn88PiklTEu3UYvgsKF6P8HE1jIHHfeyxYYiexpjEH7LSWgC2ocB4o2j7DFr69Nwb1GUQE4lYnt3gjZ3QC+9WetEHHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Oz5uomeM; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Oz5uomeM"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25089A157E;
	Sat, 17 Oct 2026 11:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792228058; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jlIbxif+VD4Y+A4zap/XlwInjrq9x4H7M20dtoeoZ5Y=;
	b=Oz5uomeMQwApVeTghohxKoOwMRf4RYU+Ske3yxsg2QkfdMmAf6bqPJG3zohvBVgSsmxBmD
	EKtlnBV0k0h3oxDAT187uncV301NE+yz0ygMgu+GwRik7Ci6nuvA7xvlSNLDEagR7TppaG
	1A8okIjs4UiQGijzC5Htj38iS0BV5aUSdHynMZTD9FYQEYN/QoNMDNSjCLzjLSBWT28gYp
	+FM7jTSUWBvpOTd7viObQj6g1qOHaDyi2DiF+BNk2CraU8KxFozkNRzjjZoaP3hyEDcb28
	mikVaugiE6kVBQ9swq6awtZ14g8+Yo4wNgTKD5xUc7Z5H/n82Q30dnlWHy4FhQ==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 11:07:37 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: amba-pl011: keep RS485 transmission
 running on reconfiguration
In-Reply-To: <sashiko-outbox-175339@kernel.org>
References: <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-0-6f457a1ee527@tipi-net.de>
 <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-2-6f457a1ee527@tipi-net.de>
 <sashiko-outbox-175339@kernel.org>
Message-ID: <b07a35b9f41ab5f312c4c5439e0dab42@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 17.10.2026 08:45, sashiko-bot@kernel.org wrote:

> [...]

> [Severity: Medium]
> What happens if RS485 is enabled via TIOCSRS485 while a break is active 
> on
> the port (or if RS485 is disabled during a break, clearing 
> uap->rs485_break
> above while UART01x_LCRH_BRK remains set in REG_LCRH_TX, and then 
> re-enabled)?
> 
> While UART01x_LCRH_BRK is set, the PL011 keeps UART01x_FR_BUSY asserted 
> in
> REG_FR, so pl011_tx_pending() returns true via !pl011_tx_empty() and 
> enters
> pl011_rs485_tx_resume():
> 
> drivers/tty/serial/amba-pl011.c:pl011_rs485_tx_resume() {
>     ...
> 	if (stopped ||
> 	    (kfifo_is_empty(&tport->xmit_fifo) && !pl011_dma_tx_queued(uap))) 
> {
> 		uap->rs485_tx_state = WAIT_AFTER_SEND;
> 		hrtimer_start(&uap->trigger_stop_tx, uap->rs485_tx_drain_interval,
> 			      HRTIMER_MODE_REL);
> 	} else {
> 		uap->rs485_tx_state = SEND;
> 	}
> }
> 
> Because pl011_rs485_tx_resume() does not check REG_LCRH_TX for
> UART01x_LCRH_BRK and set uap->rs485_break = true, uap->rs485_break 
> stays
> false. Could this cause pl011_trigger_stop_tx() -> 
> pl011_rs485_tx_stop() to
> bypass the uap->rs485_break check and continuously re-arm 
> trigger_stop_tx
> every character interval in hardirq context for the entire duration of 
> the
> break?
> 
>> -	} else if (port->rs485.flags & SER_RS485_ENABLED) {
>> +	} else if ((port->rs485.flags & SER_RS485_ENABLED) &&
>> +		   uap->rs485_tx_state == OFF) {
>> +		/* Set the idle level now, a transmission sets it when done */
>>  		pl011_rs485_tx_stop(uap);
>>  	}
> 

Agree. I verified on my CM4 that BUSY stays set during a break and the 
drain timer
keeps polling until the break ends. Will fix this in v3.


> [Severity: Medium]
> During TIOCSRS485, uart_ioctl() -> uart_set_rs485_config() invokes
> port->rs485_config() before storing the new configuration into 
> port->rs485:
> 
> drivers/tty/serial/serial_core.c:uart_set_rs485_config() {
>     ...
> 		ret = port->rs485_config(port, &tty->termios, &rs485);
> 		if (!ret) {
> 			port->rs485 = rs485;
>     ...
> }
> 
> And pl011_rs485_tx_stop() -> pl011_rs485_tx_stop_now() also reads
> port->rs485.flags:
> 
> drivers/tty/serial/amba-pl011.c:pl011_rs485_tx_stop_now() {
>     ...
> 	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> 		cr &= ~UART011_CR_RTS;
> 	else
> 		cr |= UART011_CR_RTS;
>     ...
> }
> 
> Because port->rs485 still holds the old settings here, can this cause 
> two
> issues when configuring an idle port (uap->rs485_tx_state == OFF and
> !pl011_tx_pending()) via TIOCSRS485:
> 
> 1. When enabling RS485 for the first time, port->rs485.flags & 
> SER_RS485_ENABLED
>    is still false, so pl011_rs485_tx_stop() is skipped, leaving 
> UART011_CR_TXE
>    enabled while uap->rs485_tx_state == OFF and leaving UART011_CR_RTS 
> at its
>    RS232 level?
> 
> 2. When RS485 is already enabled and TIOCSRS485 changes the RTS 
> polarity
>    (SER_RS485_RTS_ON_SEND vs SER_RS485_RTS_AFTER_SEND),
>    pl011_rs485_tx_stop_now() programs UART011_CR_RTS using the old
>    port->rs485.flags instead of the new rs485->flags, driving the wrong 
> RTS
>    idle level?
> 
> Should this branch check rs485->flags & SER_RS485_ENABLED and apply the 
> new
> rs485->flags when setting the idle state?

IMHO this is a pre-existing issue. I even have a fix for this in my 
local RS485
rework series, I plan to send for next cycle. So if there aren't any 
objections,
I will skip this for v3.

Thanks,
Nicolai
