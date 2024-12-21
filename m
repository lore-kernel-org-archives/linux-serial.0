Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245BC1EC4E2
	for <linux-serial@vger.kernel.org>; Sat, 21 Dec 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774028; cv=none; b=GN64gW1nDbwvcMvuZBtWAlmVrd2kTfPLvw9MWfK44tdYEXOrBLOM6akIBg1uqmF2riKknrMgtIXcKxHHePmkHP3xrVhiRC8NiIP42/X/EYpVd7asl5NMUNVbBHxVteB0f7pm+ibp5Js/I8wvqLaPy0H0vt9k5tonw6kcOpxUHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774028; c=relaxed/simple;
	bh=QtSPJr5dnw06t/X8uoWn8Tq53GlF4BWXzKW3aahojdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LibS2e+r1PR05Y2eyhyt+2q4MrZW2NalcMn1cfnN6ZBjLHhHGvBUpZujvgHaDS9F6dHBWWVM2WFjKV95luWBb4QqQDy7XtGydAV/vxKWwXbKdGaDoloQ/btCE9h3yMBTEGqFnZqkh1oCOtoAycMQif6gcLPTUKgD9Jggah4DKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kBjW+FHF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kBjW+FHF"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso1608511f8f.0
        for <linux-serial@vger.kernel.org>; Sat, 21 Dec 2024 01:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734774025; x=1735378825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIwB/oZQl4g7ieJFtTHNp5DE7Eonl9+QTD4Sz6RGG6k=;
        b=kBjW+FHFKP2t9NmIoFhCCFxdxikgJyEUbTrsOqy6ZE5D3wC3Codx0eT/GnEM2ushb1
         kKH58gYzJgK14lyqs3HVRv1pKpjpYZG+0Wy6gnGs26qRuOSGGqivPAAqCEEbkdbvhjm6
         ri8xODhAsaykoB4rUmLITbGJ5Q/J4lTi7sZ+0/VmYRqi+GevdvXmtcNwFrOpsgJT1aS6
         RWBHC8dPJ20OREZhA04Xd9C6xuX+IYuZregPtVDFRWou197SiF7diFyd2zNCDUD0VhqZ
         JmRFl/x3kuV7ZRuJwNSGYKvpPt1emAZq4qKCXqPHLtF1j8axPsyc5HtFs8CQ4s80MYm4
         MPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734774025; x=1735378825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIwB/oZQl4g7ieJFtTHNp5DE7Eonl9+QTD4Sz6RGG6k=;
        b=iUr6vysPVlstjr10Bc0VKI3R9sAotzFPMfY6wj/5WO/Ae+ac0JV6FjSpJHStA9tKRq
         A2IkL/ywNy3ggEA4SU9IqRSBkoLyv/npmeRGBsxamzxxtqebn9ORuTZ2R9lqVYoHy4kB
         5ux+KRMV1LRMgQ0Vrpjzbf5tFq0rwnR4oEztzraF1yz4gorsrI2pAQMKUWPwpkF9olYJ
         xtKaPoGyXWSGZy7v6zA2PxPe+TgP3BI0sOiL3YXTAggjCUr6x+tJXd+zo9bOLipRQzyz
         u8ekl8A3APp/0IVyqUJDol+9+4vU8e7fCv6S5G+jgHwUIJ+mkCkBi1rGAjBmv8j5i/h/
         bJtA==
X-Forwarded-Encrypted: i=1; AJvYcCXt+zU92ndSdqe0w0215usa9wIE2QLtaaS8+osZ1GKYb2cZ/QUbwKS1ugfjcLHqYF1pATXCvkY3s6LUOGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxY6nR/cKz5GSqoq7fDFtYxV6gm1QuTa4C9A+K1XHpDDBSyYSc
	H3Zo6rtpZ3sJKlG13hraRdCn/Uc90atk2B3eAeAZLPB3XhiJE/+V5oqw5QgXVKA=
X-Gm-Gg: ASbGncv0MD7Cr8tYDjcU+CbJAJ4M3Gb4o8gj4bjX8ilcKnl2ckwQ9pWj+a1F2CONmh0
	NjNSn9oSeukWmUc0oy5PgJ4JqrpR33OSE3cPoxwCIZXwakEXTor9Uq69a3QbQXhs1al9rFZ/2/V
	FtcwNjGjF47zZ5qQWPAzRlRz/8XrtI8EqmE43SmEHYCNPCZvUbwaHATI31rLLUkm7xhPIKqBtfJ
	bPsaGvBjclfWRMUKXCH/lM4TndurehD7Bih9MaH3KYjFTDNxtpm2xxnm1VnLherYQ==
X-Google-Smtp-Source: AGHT+IHq5KVl/zqdJubE8s9A3F+aeH47eWLbCb3zyQd2iMVbVph3maumX8hfuBUW6E7CE87SwbGqEw==
X-Received: by 2002:a05:6000:713:b0:382:4115:1ccb with SMTP id ffacd0b85a97d-38a221f2ec7mr5968387f8f.7.1734774025442;
        Sat, 21 Dec 2024 01:40:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a2311b3c8sm3643925f8f.25.2024.12.21.01.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 01:40:24 -0800 (PST)
Message-ID: <0ef6c596-92c1-4d02-b589-f5e9aee96088@tuxon.dev>
Date: Sat, 21 Dec 2024 11:40:23 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 6/6] serial: sh-sci: Increment the runtime usage
 counter for the earlycon device
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 wsa+renesas@sang-engineering.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 lethal@linux-sh.org, g.liakhovetski@gmx.de, groeck@chromium.org,
 mka@chromium.org, ulrich.hecht+renesas@gmail.com,
 ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
 <20241204155806.3781200-7-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWB2q7=gkHUsmVWwZMCWaj-htUpOQCr24y5HsbQvM+HMA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWB2q7=gkHUsmVWwZMCWaj-htUpOQCr24y5HsbQvM+HMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19.12.2024 16:30, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Dec 4, 2024 at 4:58 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
>> with earlycon mapped at index zero.
>>
>> The uart_add_one_port() function eventually calls __device_attach(),
>> which, in turn, calls pm_request_idle(). The identified code path is as
>> follows:
>>
>> uart_add_one_port() ->
>>   serial_ctrl_register_port() ->
>>     serial_core_register_port() ->
>>       serial_core_port_device_add() ->
>>         serial_base_port_add() ->
>>           device_add() ->
>>             bus_probe_device() ->
>>               device_initial_probe() ->
>>                 __device_attach() ->
>>                   // ...
>>                   if (dev->p->dead) {
>>                     // ...
>>                   } else if (dev->driver) {
>>                     // ...
>>                   } else {
>>                     // ...
>>                     pm_request_idle(dev);
>>                     // ...
>>                   }
>>
>> The earlycon device clocks are enabled by the bootloader. However, the
>> pm_request_idle() call in __device_attach() disables the SCI port clocks
>> while earlycon is still active.
>>
>> The earlycon write function, serial_console_write(), calls
>> sci_poll_put_char() via serial_console_putchar(). If the SCI port clocks
>> are disabled, writing to earlycon may sometimes cause the SR.TDFE bit to
>> remain unset indefinitely, causing the while loop in sci_poll_put_char()
>> to never exit. On single-core SoCs, this can result in the system being
>> blocked during boot when this issue occurs.
>>
>> To resolve this, increment the runtime PM usage counter for the earlycon
>> SCI device before registering the UART port.
>>
>> Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -3435,7 +3435,24 @@ static int sci_probe_single(struct platform_device *dev,
>>                 sciport->port.flags |= UPF_HARD_FLOW;
>>         }
>>
>> +       /*
>> +        * In case:
>> +        * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
>> +        * - it now maps to an alias other than zero and
>> +        * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
>> +        *   available in bootargs)
>> +        *
>> +        * we need to avoid disabling clocks and PM domains through the runtime
>> +        * PM APIs called in __device_attach(). For this, increment the runtime
>> +        * PM reference counter (the clocks and PM domains were already enabled
>> +        * by the bootloader). Otherwise the earlycon may access the HW when it
>> +        * has no clocks enabled leading to failures (infinite loop in
>> +        * sci_poll_put_char()).
>> +        */
>> +
>>         if (sci_ports[0].earlycon && sci_ports[0].port.mapbase == sci_res->start) {
> 
> Now there are two tests for mapbase: here and in sci_probe()...

I'll adjust it!

Thank you for your review,
Claudiu

> 
>> +               pm_runtime_get_noresume(&dev->dev);
>> +
>>                 /*
>>                  * Skip cleanup up the sci_port[0] in early_console_exit(), this
>>                  * port is the same as the earlycon one.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

