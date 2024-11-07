Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69791E8825
	for <linux-serial@vger.kernel.org>; Thu,  7 Nov 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974099; cv=none; b=ZEKCWektKS/b2ENPyfJYndbn0tIu6yiNPVI4YdqQ6hCWQTyygj8knCbq+Ek2I7E3yNnbvuFmU1HqVKaAOVJGNcKNvi3gIq0r8fAJxgjhjHEcCHaWoCzHxlvY3mllQi7Jz+8padnyvAUsUK1auXzKXHRlRwxtssPmrLOyCpx3go4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974099; c=relaxed/simple;
	bh=xXUQOBT01T3MRKyJrdapfNykchj8nZNKVHCLYH+d/Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmnilt/ITmCX1JDN/E5Xu79D6ptxOc67Uzgewk0fs/YCMPR6iQhkXchCjKC3kOVAR/AGbSbmpNHWdtGHpWwCvGBYh05YXS5qNhbhcGUzuFy7wmgbR5ugS1ygqTz/r7vAKBEV+uOUPWF/Dk88CLWifZknF2hP2JTtiIiLqewycR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=B6oc96/Y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="B6oc96/Y"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so6719525e9.2
        for <linux-serial@vger.kernel.org>; Thu, 07 Nov 2024 02:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730974094; x=1731578894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3aX9aU5kbUCffF9rM+ueXGTR+/RvfCfDMyT/aMZR86s=;
        b=B6oc96/YAgpINz8oJmoArIRKtTbM1I/msINUpD3GOp2QDUCDmIVgtb2eYefgwYOmwv
         /GEvgdGbKFIUq3zl1VJzKVUfONUAUrOOXyD4ZrKMvTPBYZftJHxVpUrbSfCDR1NqklLu
         cGhP80CqcZ6idRjOY2ymYfAvDFifw7v0K0yozumbmS5t1Tj16Fwrp6TjIcfTSKf5Y2k9
         pzrHj3CZ58diIepema7cQ8A0QshAVczkm9Z1ZyddGYwBuKaSBMrCrPcjKVeUMlptgtIH
         J/1Fneyuw7nbqVaVbxi27c+DLG8pZiY2RftShSDO/jItH58VoD3nkSAw2I+iIy+emFSR
         pcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974094; x=1731578894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aX9aU5kbUCffF9rM+ueXGTR+/RvfCfDMyT/aMZR86s=;
        b=tXoh71/bbfoX1dgyiolnBgDlrN6jV9UfR8o8jjqosdBt5o8MUQAhOGv1BLExdY2wAH
         BNop2/ArFqokKnnJyS+30DA6nJ5YcsAY6cdaYVLkwBxCkXZCvjODhfMUuhxtUDh/HnP1
         brg0CV5H6rvbgssdW7zBxmxzBwUS8ty9mjK/T5glR4k29uMs1s2GXHRY/IFrOwByUlWA
         uSFliYjRwLJypQSfTX0CYxi3W86Ze3Vbomcigs1ibRzw25D//U6FucMHvUaOKB56+O+j
         W8xALItrvYFyqrpdjCyxJ9Oi6+yffgxVLej+lp0hoAs46zVxAqVccdux0yxjBsz/atU4
         CqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyCl3b0zgLhK+rkZxoYZE82QZJ7jbRv2tN/QCuz1triqzd1mBCos1PvfdgYUCM9LcGcH/HNmJ7CfRXYmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQHW/CKJQtfUa+ftqE6kC8Lrbkyyki5biTUTBoT6P3D2js7bo
	n9/E3/v4Se+cjTmAjpqzQmg6YbB/eQ2R1WfgPxf6M749pR/mIRJL3qxJYl3e3og=
X-Google-Smtp-Source: AGHT+IGWGYFHOONG1Xs6QvgE6Y/vND7Lhs5RD0DMYTtylzW3x3ufq+tfvPgtCHz10wJS3sE+Pr8Zbg==
X-Received: by 2002:a05:6000:1865:b0:37d:5129:f45e with SMTP id ffacd0b85a97d-381ef6ba599mr518574f8f.20.1730974093942;
        Thu, 07 Nov 2024 02:08:13 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ec9fsm1304952f8f.42.2024.11.07.02.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 02:08:13 -0800 (PST)
Message-ID: <26618787-7eb7-40a6-b849-33016956ef03@tuxon.dev>
Date: Thu, 7 Nov 2024 12:08:10 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] serial: sh-sci: Check if TX data was written to
 device in .tx_empty()
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: geert+renesas@glider.be, magnus.damm@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, jirislaby@kernel.org, p.zabel@pengutronix.de,
 lethal@linux-sh.org, g.liakhovetski@gmx.de, ysato@users.sourceforge.jp,
 ulrich.hecht+renesas@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
 <20241106120118.1719888-3-claudiu.beznea.uj@bp.renesas.com>
 <2024110747-kite-pacemaker-6216@gregkh>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <2024110747-kite-pacemaker-6216@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Greg,

On 07.11.2024 10:47, Greg KH wrote:
> On Wed, Nov 06, 2024 at 02:01:11PM +0200, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On the Renesas RZ/G3S, when doing suspend to RAM, the uart_suspend_port()
>> is called. The uart_suspend_port() calls 3 times the
>> struct uart_port::ops::tx_empty() before shutting down the port.
>>
>> According to the documentation, the struct uart_port::ops::tx_empty()
>> API tests whether the transmitter FIFO and shifter for the port is
>> empty.
>>
>> The Renesas RZ/G3S SCIFA IP reports the number of data units stored in the
>> transmit FIFO through the FDR (FIFO Data Count Register). The data units
>> in the FIFOs are written in the shift register and transmitted from there.
>> The TEND bit in the Serial Status Register reports if the data was
>> transmitted from the shift register.
>>
>> In the previous code, in the tx_empty() API implemented by the sh-sci
>> driver, it is considered that the TX is empty if the hardware reports the
>> TEND bit set and the number of data units in the FIFO is zero.
>>
>> According to the HW manual, the TEND bit has the following meaning:
>>
>> 0: Transmission is in the waiting state or in progress.
>> 1: Transmission is completed.
>>
>> It has been noticed that when opening the serial device w/o using it and
>> then switch to a power saving mode, the tx_empty() call in the
>> uart_port_suspend() function fails, leading to the "Unable to drain
>> transmitter" message being printed on the console. This is because the
>> TEND=0 if nothing has been transmitted and the FIFOs are empty. As the
>> TEND=0 has double meaning (waiting state, in progress) we can't
>> determined the scenario described above.
>>
>> Add a software workaround for this. This sets a variable if any data has
>> been sent on the serial console (when using PIO) or if the DMA callback has
>> been called (meaning something has been transmitted).
>>
>> Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/tty/serial/sh-sci.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index df523c744423..8e2d534401fa 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -153,6 +153,7 @@ struct sci_port {
>>  	int				rx_trigger;
>>  	struct timer_list		rx_fifo_timer;
>>  	int				rx_fifo_timeout;
>> +	atomic_t			first_time_tx;
> 
> Don't use an atomic variable for an informational thing like this, it is
> racy and doesn't work properly.  Either use a real lock (because you
> care about the locking stuff here), or just use a boolean and live with
> any potential races.

OK, I'll drop it and use a boolean.

> 
> 
> 
>>  	u16				hscif_tot;
>>  
>>  	bool has_rtscts;
>> @@ -850,6 +851,7 @@ static void sci_transmit_chars(struct uart_port *port)
>>  {
>>  	struct tty_port *tport = &port->state->port;
>>  	unsigned int stopped = uart_tx_stopped(port);
>> +	struct sci_port *s = to_sci_port(port);
>>  	unsigned short status;
>>  	unsigned short ctrl;
>>  	int count;
>> @@ -885,6 +887,7 @@ static void sci_transmit_chars(struct uart_port *port)
>>  		}
>>  
>>  		sci_serial_out(port, SCxTDR, c);
>> +		atomic_set(&s->first_time_tx, 1);
>>  
>>  		port->icount.tx++;
>>  	} while (--count > 0);
>> @@ -1241,6 +1244,8 @@ static void sci_dma_tx_complete(void *arg)
>>  	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>>  		uart_write_wakeup(port);
>>  
>> +	atomic_set(&s->first_time_tx, 1);
>> +
>>  	if (!kfifo_is_empty(&tport->xmit_fifo)) {
>>  		s->cookie_tx = 0;
>>  		schedule_work(&s->work_tx);
>> @@ -2076,6 +2081,10 @@ static unsigned int sci_tx_empty(struct uart_port *port)
>>  {
>>  	unsigned short status = sci_serial_in(port, SCxSR);
>>  	unsigned short in_tx_fifo = sci_txfill(port);
>> +	struct sci_port *s = to_sci_port(port);
>> +
>> +	if (!atomic_read(&s->first_time_tx))
>> +		return TIOCSER_TEMT;
> 
> See, what happens here if the value changes right after you check it?

I agree. I am aware if it.

I chose this approach (w/o locking) as I noticed (as of my code checking)
that this function is called in kernel through uart_ioctl(),
uart_wait_until_sent(), uart_suspend_port().

The uart_wait_until_sent(), uart_suspend_port() are implementing a multiple
try approach when checking the ops::tx_timeout() return value.

I haven't checked any user space application but considered that it might
work in a similar way.

I will switch to a boolean in the next version.

Thank you,
Claudiu Beznea


> Being an atomic doesn't mean anything :(
> 
> thanks,
> 
> greg k-h
