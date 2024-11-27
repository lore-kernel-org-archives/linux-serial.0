Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D301FF7C6
	for <linux-serial@vger.kernel.org>; Wed, 27 Nov 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728796; cv=none; b=eHxEoS37ujk8uDaFLs1xGpbAEvMNYaRzdOh/V3/uq0xL+dUSzz0qM1qzWVDmXS4Zg1KgFgriFRoKnBWz7LhCe6Tq8DgcYSKLuvtU8oE9pvpjwnEYkOROaTVDRD3O5KMfS3Ue5Q0i0LFXA3yvYTXuSjJMK2ESXUyxqgSO13y1cts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728796; c=relaxed/simple;
	bh=WHpE9eR5UhlUSBcB5vf5FzyYI2xQkCKts8Gpzp1P+K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toPGmWx1JP71GKG70iVV/+VxPDCbUaRBGOF/NUEgTDj5cMeYrvQRucQyMubvjaY0qmXN3tlsfLxwarDAD2f4oWkJkTOzOl07L/jNWY0rpDk4vMXNIMqM3zTB9+BrIziy6wGEsxwowzPTad31i59s+1LjFb+kTnCbtllhdwBz0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UfiPBUMI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UfiPBUMI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43497839b80so33698295e9.2
        for <linux-serial@vger.kernel.org>; Wed, 27 Nov 2024 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732728792; x=1733333592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2Dvzpd6/ofo2QAO5d3vYdwlkF2Kp83/EUc916PDQGo=;
        b=UfiPBUMI+WGc2LvyveaWleEzRnGRqEtBSw67Vr2gQtsyOZtwdoP7rUYgxUgwX8F+fM
         /iaFFi15EgWS5fo7lLxBbrUyDGgfIy1MzLj6KWmtpN36MVRH0Cc9wTrTZl7H3LDcQ9Al
         MnmpV9eU/VHQd3otwAwAlZa+FSsWd75iqQIATcryMMsF6VwemiTJ9BZbcz7hmN/uioHo
         CQP2oXuPWw3JSaDEFVO52Z7skiTN4xPLYpHxqgyyUBkMF2xMlK89CENTTLQhq5SedySk
         aDJM7JH/XyZ/CRWU6oVL7Ji+sjF2RKsqsGEudQIF5Hr1cUfbG+EVtydJtQ63coo/3UeF
         HG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728792; x=1733333592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2Dvzpd6/ofo2QAO5d3vYdwlkF2Kp83/EUc916PDQGo=;
        b=pKkjAaj23Lzfh8qxIpfYEYzUFGmAXO7LtQdnWjg0bSTmZ9lhZIOqF+CDYwYLxweWDP
         khLlM9W7WGoXgxNoOdM84Zis4fbvgS0oW/hA+KPY8VVLXJ2MQQDtdbKtIxP5RRsmRZda
         Iw50B8FzPbDW8quI3qOF8MuhzRoESAC4aHxpojhq3YlgMuTCJaaLHc8rgrPP/UcOUuNT
         83doMKig7nEZ3hJl9gp6YYviiG1o4PLv0jd5rswCTDh0dQ0Umu/iyIOMpdAdNg8vneAe
         mSy2Q3Zei9Me1b0x/A6GEuTXaPjeLdjQ7a1elgYboOmw6laEIXdn4NjfnBGKBclA/hAN
         Sg2A==
X-Forwarded-Encrypted: i=1; AJvYcCU1RFVbSs7GbdXPVhnko0AAK+nTTOLTfZn84zKxtNWohMcqlUYN/+k/gAyM3H31SqtoOr3BtMiulfcAcdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfKADmb792FdOVJG5MO1SmW0XonSVVv8ThALu5FIkHAF0o6hK
	xh7FiA8jK9iO3onr44vu4s8gwkWuLCqgDGVUewhkrVVpIyUDqnwxEjyLA7yoieA=
X-Gm-Gg: ASbGncs8WJ72TsSZDtogXlC0+Wy7u5KDDyevKGnnFWEuEGej8XTor+nKOgJZ6AQhTeG
	MkExp5zy80/VzaZ5AvY6/Wmq/UkNY3fi67kI8e/zgR7T+jVNy38DbxD5A7Yd316BLjeFNlL8BWC
	+SCaYdN1/Y0j3aGPyet8w1Ao0BJ1Ej8VkWUKJ0Dd1+Xhkk8xxGcw/+4aieABEhlkCrb8uAEc1FQ
	ZJyGphg+g0y06pdBa1QXe45MJviqPW7gmHcvGMTIjNHcJTx6QW/tb5p+g==
X-Google-Smtp-Source: AGHT+IGtStnjKDVkWM4W4FfoiuUvanyDA4yxgbzn7BtijkP8yZgwoZcYmJJU95zF2wDM50TaHo+h3w==
X-Received: by 2002:a05:6000:2704:b0:382:42c3:83e4 with SMTP id ffacd0b85a97d-385c6ec0a39mr2605026f8f.33.1732728791999;
        Wed, 27 Nov 2024 09:33:11 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafeceesm16864453f8f.37.2024.11.27.09.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 09:33:11 -0800 (PST)
Message-ID: <29b0e509-69a5-4098-bccf-d53cc6593c49@tuxon.dev>
Date: Wed, 27 Nov 2024 19:33:09 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] serial: sh-sci: Clean sci_ports[0] after at earlycon
 exit
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, p.zabel@pengutronix.de,
 lethal@linux-sh.org, g.liakhovetski@gmx.de, ysato@users.sourceforge.jp,
 ulrich.hecht+renesas@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
 <20241106120118.1719888-4-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdX57_AEYC_6CbrJn-+B+ivU8oFiXR0FXF7Lrqv5dWZWYA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdX57_AEYC_6CbrJn-+B+ivU8oFiXR0FXF7Lrqv5dWZWYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 27.11.2024 18:28, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for your patch, which is now commit 3791ea69a4858b81 ("serial:
> sh-sci: Clean sci_ports[0] after at earlycon exit") in tty/tty-next.
> 
> On Wed, Nov 6, 2024 at 1:02 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The early_console_setup() function initializes the sci_ports[0].port with
>> an object of type struct uart_port obtained from the object of type
>> struct earlycon_device received as argument by the early_console_setup().
>>
>> It may happen that later, when the rest of the serial ports are probed,
>> the serial port that was used as earlycon (e.g., port A) to be mapped to a
>> different position in sci_ports[] and the slot 0 to be used by a different
>> serial port (e.g., port B), as follows:
>>
>> sci_ports[0] = port A
>> sci_ports[X] = port B
> 
> Haven't you mixed A and B?
> 
>> In this case, the new port mapped at index zero will have associated data
>> that was used for earlycon.
> 
> Oops, do you have a simple reproducer for this?

It is reproducible with patches:
- [PATCH 6/9] arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
- [PATCH 9/9] arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for
SCIF1

After boot, cat /dev/ttySC0 will lead to the issue described.

> 
>> In case this happens, after Linux boot, any access to the serial port that
>> maps on sci_ports[0] (port A) will block the serial port that was used as
>> earlycon (port B).
> 
> Again, A <-> B?
> 
>> To fix this, add early_console_exit() that clean the sci_ports[0] at
>> earlycon exit time.
>>
>> Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> This causes a crash (lock-up without any output) when
> CONFIG_DEBUG_SPINLOCK=y (e.g. CONFIG_PROVE_LOCKING=y).

I missed to check this. Thank you for testing it.

> 
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -3546,6 +3546,32 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
>>  #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
>>  static struct plat_sci_port port_cfg __initdata;
>>
>> +static int early_console_exit(struct console *co)
>> +{
>> +       struct sci_port *sci_port = &sci_ports[0];
>> +       struct uart_port *port = &sci_port->port;
>> +       unsigned long flags;
>> +       int locked = 1;
>> +
>> +       if (port->sysrq)
>> +               locked = 0;
>> +       else if (oops_in_progress)
>> +               locked = uart_port_trylock_irqsave(port, &flags);
>> +       else
>> +               uart_port_lock_irqsave(port, &flags);
>> +
>> +       /*
>> +        * Clean the slot used by earlycon. A new SCI device might
>> +        * map to this slot.
>> +        */
>> +       memset(sci_ports, 0, sizeof(*sci_port));
> 
> Nit: I'd rather use "*sci_port" instead of "sci_ports".

That would be better, indeed.

> 
>> +
>> +       if (locked)
>> +               uart_port_unlock_irqrestore(port, flags);
> 
> "BUG: spinlock bad magic", as you've just cleared the port, including
> the spinlock.
> 
> I guess we can just remove all locking from this function to fix this?

I'll look to it.

> 
> However, could it happen that the new device taking slot 0 is probed
> before the early console is terminated?

I don't know to answer this. In my testing I haven't encountered it.

> In that case, its active
> sci_ports[] entry would be cleared when early_console_exit() is called.
> 
> Also, what happens if "earlycon keep_bootcon" is passed on the kernel
> command line, and the new device takes slot 0?

I checked it with earlycon and the serial device being on slot 0. In this
case it was OK.

> 
> Thanks!
> 
>> +
>> +       return 0;
>> +}
>> +
>>  static int __init early_console_setup(struct earlycon_device *device,
>>                                       int type)
>>  {
>> @@ -3562,6 +3588,8 @@ static int __init early_console_setup(struct earlycon_device *device,
>>                        SCSCR_RE | SCSCR_TE | port_cfg.scscr);
>>
>>         device->con->write = serial_console_write;
>> +       device->con->exit = early_console_exit;
>> +
>>         return 0;
>>  }
>>  static int __init sci_early_console_setup(struct earlycon_device *device,
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
