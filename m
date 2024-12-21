Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8291EE7D9
	for <linux-serial@vger.kernel.org>; Sat, 21 Dec 2024 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774896; cv=none; b=DUJ0wfs6E9wvMup1mMHvExg1YhYd3mEql6+IqH7y4hT/YT1RgDXcn0B2yjSd6F7ucQYlSnxqNM333sar5h6REeh/9QIydG9S8gHbJ/Py9RU9bc2pFWIGaybeX+u9jmjLvR2aYMjSQMSou2d/Uhmoy8Ej5AafcynI/yYpWJYe+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774896; c=relaxed/simple;
	bh=21yFNzwfr0UlLcKGuuUepm3ZtReVGYrYIeKxCX+f3bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDrDQdYhLp9UpBmB3elH8H5zd2cKfpgJUWseFd+Th61pwW3Lj/DNC5RLOwXluuAekzKUxvdXQmJogmW6zVQt6RXxwyPs87fuS1RqocB/2Us+Bwb4NYRsY79rh9Nk8dDgybUU0xltG8+W6jQT1wu4Ku45e1DWiY6FD7irbtTAUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dsvOAYGb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dsvOAYGb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43622267b2eso27558295e9.0
        for <linux-serial@vger.kernel.org>; Sat, 21 Dec 2024 01:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734774893; x=1735379693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwAZFmUQt4eB0rDP0wgTLdFM56hhqo5cdun9nc3XWhI=;
        b=dsvOAYGbBPA3Eext4/AfcijmAjAxFI7Kyik0hZa0kIqinm8lslPnVsaWhYeR48j1vC
         9W+h/wXbuBDtycvZGFPCDTl5ln1ch+mGeev205g9H1s5T+iRK1cU/RVwQe20FsD6WGWq
         OEUwBpwll+dB4xRhShtiP5pOLuaZQ5sMy6XazFdVaGdilM0011Q0I12DDuu0ZZG8tO9F
         ywf1vdq5FHMZgT7tXMy1PZjp9GR4tJjqjgTOoggKHqLHxEA8HLg9vrmZwg/jSW6ip1Jf
         wg/mCnbFHj5iQNJnJW57Nx5wujIEYcKgOADc+/zWYyZUuNxB85EDzjeQVFBwtSqo+TIb
         KPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734774893; x=1735379693;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwAZFmUQt4eB0rDP0wgTLdFM56hhqo5cdun9nc3XWhI=;
        b=h/zQbjfHI0RXCK0sPARo4fJFlYqkM+nb1VLyvW/bYEEmV0BgRFk1J4P91hY60Vdd8o
         jJoKl2pIEUI0HbZOoY1k15Nr6weeOobyqTfYDX/D002y3oDMFecVPCLwntzdjeclI6Gp
         31Q9TlrBU1P9egTMpesT9oPyC4oHd9Pkh5zf4vx3+M78pX6za4dEB/a02McvMBiYTK9K
         mjGoVPbn8217CeYXZciX58DmKWQGVHDQSAiBa8hTmsI4aNcsB6A5b4I668A1X2/Gg1Rm
         gamWUy8/ESYy6QiqyfClNa0RCZ9dlCQen64P0TdzOFbiLrnwoR8YvJn4DeMq/dbLbaL2
         jSPA==
X-Forwarded-Encrypted: i=1; AJvYcCU5dcnepM8z7TqzKVl+MZHfpGDw0NkCjJM9gPUOdxXJBhzVAuDsev6qz+SwG+jeHiuSNIxFIo/54Navkso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwyoDOoZnWqYTuNlxi3JdJFsie/vhCHZo8/ouSS6FtAfPa/dn
	vZe4nRK6IA5RScV71IBzoRynumQTdszfBfLLKJGR2Z8fs7RzQDP7LJma725yzcc=
X-Gm-Gg: ASbGnctfleWhgAJgefJCbDuu14LndpTcuzCbeBwndsW0xZY8VI19U0CW6BUx+gsWENX
	K22aOzDrLoNNgNz9DXJ2NFdYY6L1HZHhN9Hhws8417rVL29PvvftJ4wUrYs5wgee2LCkffR5iJK
	FB+iU6BCH8liIm0ah1UT6My8uuSVrdcMFdgT9H5ZWbKMUgBUd09EatavxA2a7j2UKtYbkQ1Z3uP
	PimhSyppPlazhVxyjNekPKKu3fPtfWY0J3NCEJITU6L3hg7nYnQpU/cQqwiIxja2A==
X-Google-Smtp-Source: AGHT+IHcKoHkfYzPKUW32sn+bxr45pcsRO8/E29M/H30qFi/thG67nRERccO7sSQQ0/VwWFJDwPcFQ==
X-Received: by 2002:a05:600c:1c12:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-4366d356dfcmr48118195e9.31.1734774893024;
        Sat, 21 Dec 2024 01:54:53 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366128a44fsm70694785e9.43.2024.12.21.01.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 01:54:52 -0800 (PST)
Message-ID: <c2b64230-f038-4da7-bc07-235072535ae1@tuxon.dev>
Date: Sat, 21 Dec 2024 11:54:51 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/6] serial: sh-sci: Fixes for earlycon and
 keep_bootcon
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 gregkh@linuxfoundation.org, jirislaby@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lethal@linux-sh.org,
 g.liakhovetski@gmx.de, groeck@chromium.org, mka@chromium.org,
 ulrich.hecht+renesas@gmail.com, ysato@users.sourceforge.jp,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
 <Z1DLyQdzUzJzRUJJ@shikoro> <b6c7b4d3-021c-4a4b-9e91-316603b348c1@tuxon.dev>
 <CAMuHMdWx97OnPWnQn78oL+vVuQXmeaJP-byc_4ZwBMZhMOorxw@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWx97OnPWnQn78oL+vVuQXmeaJP-byc_4ZwBMZhMOorxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 19.12.2024 17:11, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, Dec 5, 2024 at 9:39 AM Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 04.12.2024 23:38, Wolfram Sang wrote:
>>>> in the following scenarios:
>>>>
>>>> 1/ "earlycon keep_bootcon" were present in bootargs
>>>> 2/ only "earlycon" was present in bootargs
>>>> 3/ none of the "earlycon" or "earlycon keep_bootcon" were present in
>>>>    bootargs
>>> ...
>>>> Please give it a try on your devices as well.
>>>
>>> Will happily do so. Is there something to look for? Except for "it
>>> works"?
>>
>> As this code touches the earlycon functionality, of interest are the 3
>> cases highlighted above:
>>
>> 1/ "earlycon keep_bootcon" are both present in bootargs
>> 2/ only "earlycon" is present in bootargs
>> 3/ none of the "earlycon" or "earlycon keep_bootcon" are present in
>>    bootargs
>>
>> One other thing, that I was currently able to test only on RZ/G3S, is to
>> see how it behaves when the debug serial is described in DT with an alias
>> other than zero. E.g., on [1] the debug serial alias on RZ/G3S was changed
>> from 0 to 3. With the new alias (3) there were issues that I've tried to
>> fix with this series.
> 
> I gave this a try on Koelsch, which has two easily-accessible usb-serial
> ports, for all three cases above.  Originally, I had CONFIG_VT_CONSOLE=y
> (tty0 takes over from earlycon rather early), but I had to disable
> that to exercise all code paths (ttySC0 takes over much later).
> 
>   A. CONFIG_VT_CONSOLE=y: OK
>   B. CONFIG_VT_CONSOLE=y earlycon: OK
>        early_console_setup: mapbase 0x00000000e6e60000
>        earlycon: scif0 at MMIO 0x00000000e6e60000 (options '115200n8')
>        printk: legacy bootconsole [scif0] enabled
>        printk: legacy console [tty0] enabled
>        printk: legacy bootconsole [scif0] disabled
>        early_console_exit: Clearing sci_ports[0]
>   C. CONFIG_VT_CONSOLE=n earlycon: OK
>        early_console_setup: mapbase 0x00000000e6e60000
>        earlycon: scif0 at MMIO 0x00000000e6e60000 (options '115200n8')
>        printk: legacy bootconsole [scif0] enabled
>        printk: legacy console [ttySC0] enabled
>        printk: legacy bootconsole [scif0] disabled
>        early_console_exit: Not clearing sci_ports[0]
>   D. CONFIG_VT_CONSOLE=y earlycon keep_bootcon: OK
>        early_console_setup: mapbase 0x00000000e6e60000
>        earlycon: scif0 at MMIO 0x00000000e6e60000 (options '115200n8')
>        printk: legacy bootconsole [scif0] enabled
>        printk: legacy console [tty0] enabled
> 
> So all good, but note that these cases worked fine without your
> series, too.
> 
> The real troublesome cases involve using earlycon on a different
> serial port than serial0.  As I don't have any Renesas boards where
> chosen/stdout-path does not use serial0, I tried exchanging the serial0
> and serial1 DT aliases, and updating chosen/stdout-path accordingly.
> 
>   E. CONFIG_VT_CONSOLE=y: OK
>   F. CONFIG_VT_CONSOLE=y earlycon: OK
>        early_console_setup: mapbase 0x00000000e6e60000
>        earlycon: scif0 at MMIO 0x00000000e6e60000 (options '115200n8')
>        printk: legacy bootconsole [scif0] enabled
>        printk: legacy console [tty0] enabled
>        printk: legacy bootconsole [scif0] disabled
>        early_console_exit: Clearing sci_ports[0]
>   G. CONFIG_VT_CONSOLE=y earlycon keep_bootcon: SCIF1 missing
>        early_console_setup: mapbase 0x00000000e6e60000
>        earlycon: scif0 at MMIO 0x00000000e6e60000 (options '115200n8')
>        printk: legacy bootconsole [scif0] enabled
>        printk: legacy console [tty0] enabled
>        sh-sci e6e68000.serial: error -EBUSY: sci_port[0] is used by earlycon!
>   H. CONFIG_VT_CONSOLE=n earlycon: SCIF1 missing
>        early_console_setup: mapbase 0x00000000e6e60000
>        earlycon: scif0 at MMIO 0x00000000e6e60000 (options '115200n8')
>        printk: legacy bootconsole [scif0] enabled
>        printk: legacy console [ttySC1] enabled
>        printk: legacy bootconsole [scif0] disabled
>        early_console_exit: Not clearing sci_ports[0]
>        sh-sci e6e68000.serial: error -EBUSY: sci_port[0] is used by earlycon!
> 
> Case G gives a missing SCIF1, because sci_port[0] is still
> used for earlycon, as expected.
> Case H also gives a missing SCIF1, but should succeed IMHO, as earlycon
> is no longer active.  I think early_console_exit() should clear the
> earlycon flag regardless.

I'll double check it.

> 
> Note that before your series, cases E-F worked too, but cases G-H gave
> an initialized but broken SCIF1 instead.
> 
> Now, can we improve?
>   - Can we use a proper id instead of zero for earlycon, e.g.
>     sci_probe_earlyprintk() does fill in early_serial_console.index?

I looked into that but, as of my investigation, index zero is the one used
in the earlyprintk initialization process. sci_probe_earlyprintk() is
called from sci_probe(). I'll double checked it though, anyway.


>   - Alternatively, can we use a separate sci_port structure instead
>     of abusing sci_ports[0]?

I explored this too, but didn't manage to make it work.

Thank you for running all these tests,
Claudiu

> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

