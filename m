Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAB25A321;
	Tue,  1 Sep 2026 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240788; cv=none; b=MJF/rTJI5hmGwHdsngN2bT8GgOBQ4jSYbfsSCXtsgdKVp+syAChYULiNn+OsEtPsainspVNIv6zOYStz+1fXW3eqTsa5h14S4ZJe/AAt+SPFYd6n2PRs3S5Jf+1zWUbSGIJlL17/LoGnRM1aJEiuwieoyi1X72a9/ViJqPaeVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240788; c=relaxed/simple;
	bh=5vcoJ8AO/cySm9bp2yDK3GUIlsc1AOb0ydLyZa28uTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G87Slzd9SqTmxMYa/0k3bYhcc8RDfuyV+weplSVU+Mmd/MT6OarnxJ0rcn8yRV7S5/AXdxW06MwvuisHtYU2SGysv2vOOQ5wv5dr3O3JINCNKZw7Yfea4MvE0u9IHkMzRu+fjJ5rtSNqm2ajPOB0bmbV/5V8nBgKsdBm2SGI9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieT9qjUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieT9qjUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555051F000E9;
	Tue,  1 Sep 2026 05:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788240787;
	bh=ZjUDUieFw3qEpklR8NkqsmcdGESAV2KdFsPmKNcH9pU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ieT9qjUHRUJO5pu1XcW7ZaXZGv3MH7gTMz3OMV1gphb72DFpvN9c2mlmHDaOlGXRN
	 GTIRuGNyfUnVel5fFD6rs1aSuxHZKD8jY4iLqoOnGcKZuEN1+F3g56WHHyrWvcsjGp
	 nKg5jQgvamWF7fvQCRIa8ozL2mQXzvNU5A4oto2v/W/CzK5KHul4820jJIVUkDVE0G
	 gXEwfYm5fDpVb52OLaoKUEfOBt7DRmVatAjaXuGJ7yMVPaZYSwsfssEh+K2ar/TKGr
	 uUTZv4/NjEU+S1LXto5BKHgz4i0mB6XUWWzovppOR+yiDns8iRlED5/haGPvQ02mXr
	 LQxlYmGp7qXzg==
Message-ID: <e11fdfbb-31f8-4fda-82e9-ddf390a2ec8a@kernel.org>
Date: Tue, 1 Sep 2026 07:33:04 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] serial: 8250_mxpcie: take the line settings from
 the new termios
To: sashiko-reviews@lists.linux.dev, Linmao Li <lilinmao@kylinos.cn>
Cc: linux-serial@vger.kernel.org,
 Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
 <20260901041519.114737-4-lilinmao@kylinos.cn>
 <20260901042326.F3AE41F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260901042326.F3AE41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

CC Crescent as well.

On 01. 09. 26, 6:23, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Hardware registers and port status are modified without holding the port lock or a Runtime PM reference.
> --
> 
> commit cc8d50f2957c7d540f5a4840cf6ed31ccd1bed47
> Author: Linmao Li <lilinmao@kylinos.cn>
> 
> serial: 8250_mxpcie: take the line settings from the new termios
> 
> mxpcie8250_set_termios() reads the line settings out of port->state->port.tty,
> which is only set once the port has been opened. This commit fixes a NULL
> dereference during console setup or kgdboc attach by reading the settings
> from the termios the serial core passes in instead.
> 
>> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
>> index ef2516ec16da0..19f1f51eec477 100644
>> --- a/drivers/tty/serial/8250/8250_mxpcie.c
>> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
>> @@ -218,8 +218,6 @@ static void mxpcie8250_set_termios(struct uart_port *port,
>>   				   const struct ktermios *old)
>>   {
>>   	struct uart_8250_port *up = up_to_u8250p(port);
>> -	struct tty_struct *tty = port->state->port.tty;
>> -	unsigned int cflag = tty->termios.c_cflag;
>>   	u8 efr, val;
>>   
>>   	serial8250_do_set_termios(port, new, old);
>> @@ -229,23 +227,25 @@ static void mxpcie8250_set_termios(struct uart_port *port,
>>   	efr = serial_in(up, MOXA_PUART_EFR);
> 
> [Severity: High]
> This is a pre-existing issue, but is it safe to modify the port status and
> access hardware registers here after serial8250_do_set_termios() has
> already released the port lock and runtime PM reference?
> 
> Modifying up->port.status in mxpcie8250_set_termios() without holding the
> port lock creates a data race that can corrupt flow control flags
> (e.g., UPSTAT_AUTOCTS). This directly violates the locking contract
> documented in include/linux/serial_core.h.
> 
> Furthermore, accessing UART hardware registers via serial_in() and
> serial_out() without a port lock or a Runtime PM reference can lead to
> concurrent register access races with IRQ handlers, or bus faults if the
> device enters a suspended state. This sequence occurs every time
> mxpcie8250_set_termios() is called, for instance when userspace calls
> tcsetattr to change flow control on the TTY device.
> 
>>   	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
>>   
>> -	if (cflag & CRTSCTS) {
>> +	if (new->c_cflag & CRTSCTS) {
>>   		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
>>   		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
>>   	}
> 


-- 
js
suse labs
