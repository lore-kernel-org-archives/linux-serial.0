Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583248405D
	for <linux-serial@vger.kernel.org>; Tue, 23 Apr 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874257; cv=none; b=mcCoqABojnRdj6ZjKxT7tBpX5fG9kh+cVRSc6HbOXs6p8HoanV8zbJdPqt153wvpZmP0WxMJiaJE8+uzAm0vbfMHEJQjnCCToB3xlu1YzNUiHYtQWCLB+hcJczvXeAxlA/6pkwYP6BH40SQRxKDhfoJLAaHShxizonkeb7xLSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874257; c=relaxed/simple;
	bh=yPA0VbuDugXAyhUBMF7SNGGOl4MsvDgi2noQ/f+p+s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNNN/p+WI9skEoR2jqiJidmrrNbGNYYXmyy/m8Up8GQPyfRUUMG9NHQsay8vEhOEuoITWDwNQznrhihlZAwtlTe5bH2AtCzbWbYBn8FY8HSaahwbaiJSab6FGv878h9fSOyh34jQMnn1i/XWUEn8a75ViKVs0snjPT12QTWRxUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UWTl7xH1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UWTl7xH1"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-346406a5fb9so4469072f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 23 Apr 2024 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713874254; x=1714479054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kV5g9dBqJQB3acwPivqgb+A6yJex6eirm5nXSFy64Yw=;
        b=UWTl7xH1qlg/6CmZOfMcqotaF3sj2DLT5IndhJokVzfLuNqvXQa/+OKZyQmUInuy9f
         lgMmHT3wvEBuytJlDmka3yMqwaJFT4fgyAdzK8tOwANx1gBl4ShlvXcnYMM8VSazzrq/
         gNunBf3X0v0rqZJPWKCSNq2K4ETggUsZtlWzBdUAWI7HTCSq1lY2q8wa7UP42tJazotS
         gza6W3n9MzFBdIdhxKm3KGN5oKjnPMP9jYr/5ca5HC+akKQcjafJS6xcwt2eBAS1WGNr
         auEoVwTUeovN4LCYCStlPRbfurJ4fZ3QWQt6Psq/CtnNZ1l11Nf9WB3pUuESH8srB6Cx
         qREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874254; x=1714479054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kV5g9dBqJQB3acwPivqgb+A6yJex6eirm5nXSFy64Yw=;
        b=cl6QDMiPc0emKoBlIh+F9GEJKpf4wPihW0I6fyfGnzIiihqR95UNo1BtSVrlXu6lzH
         Nn9JkIZGj+Dk/DONxkvxsklxD5ajYS8qFrBLYLPUDCP0fIA5l0d79fIT0HqQ+rUFnaMU
         TPyslBzaUi2Ale5niXXlgoJCJkKyI3xsIo1t0LvotWKQfLbTvGSCJ4tanLtUzDdIwrYQ
         R0GIy9EdOq83kIFO56gL4HAPtjOfFGCGgcmsf/6R9yQG1K0cNig3lmdrCdJFjyiAFXOx
         9vd+kHDqb9tJ9JyAgeaghVgQGwuixkdP/YNMNEHtDLDXz8NUxr89vRMDRK17eq1z/kA/
         kLFA==
X-Forwarded-Encrypted: i=1; AJvYcCXFR8Oaid9PMSlmPIvegZDY4lsNndjMjcQXcTv3cyYT9iMFA4wNgcvK1hpRsbDHXLmgc9V/xCY5W0C1C6Etm/n+uKpqOfoHt3GPncjZ
X-Gm-Message-State: AOJu0Yz31fhBpKkQ/81tOKpPyfj/PdJ/L5WAE9m468bvczPHmt5/6TAG
	DK2CsY0bSYa0K4g43fu/NGCS0Msw75OjYGYrwDNy3pWjIDvER4+CXFD0cIv8EaQ=
X-Google-Smtp-Source: AGHT+IGzjXzz+JJVTsxvS1Lqw4gbV3f0mMHeGZ3kfY+oB0Rlj+Sv933prehjjydshXh5isd5epyUOQ==
X-Received: by 2002:adf:eb0b:0:b0:349:cc20:2030 with SMTP id s11-20020adfeb0b000000b00349cc202030mr7842203wrn.51.1713874253453;
        Tue, 23 Apr 2024 05:10:53 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id jg23-20020a05600ca01700b004189cf6bd6esm23281278wmb.22.2024.04.23.05.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:10:52 -0700 (PDT)
Message-ID: <3d8925a8-32ee-467a-aca7-d4a04f26821f@tuxon.dev>
Date: Tue, 23 Apr 2024 15:10:50 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sh-sci: Call device_set_wakeup_path() for serial
 console
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20240422111123.1622967-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUXRx1-95PD_WG4X=y4UefYXzTqm7T2mi+di+ZdKGUXYA@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUXRx1-95PD_WG4X=y4UefYXzTqm7T2mi+di+ZdKGUXYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 23.04.2024 10:27, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> CC Peng
> 
> Thanks for your patch!
> 
> On Mon, Apr 22, 2024 at 1:11 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> In case the SCI is used as a UART console, no_console_suspend is
>> available in bootargs and SCI is part of a software-controlled power
>> domain we need to call device_set_wakeup_path(). This lets the power
>> domain core code knows that this domain should not be powered off
> 
> know
> 
>> durring system suspend. Otherwise, the SCI power domain is turned off,
> 
> during
> 
>> nothing is printed while suspending and the suspend/resume process is
>> blocked. This was detected on the RZ/G3S SoC while adding support
>> for power domains.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/tty/serial/sh-sci.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index 97031db26ae4..57a7f18e16e4 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -3441,8 +3441,12 @@ static __maybe_unused int sci_suspend(struct device *dev)
>>  {
>>         struct sci_port *sport = dev_get_drvdata(dev);
>>
>> -       if (sport)
>> +       if (sport) {
>> +               if (uart_console(&sport->port) && !console_suspend_enabled)
>> +                       device_set_wakeup_path(dev);
> 
> device_set_awake_path(), as of commit 10bb4e4ab7dd3898 ("PM: sleep:
> Add helpers to allow a device to remain powered-on") in v6.6
> (although I'm still a bit puzzled about the difference).

Ok, I wasn't aware of it. I'll switch to this one.

> 
>> +
>>                 uart_suspend_port(&sci_uart_driver, &sport->port);
> 
> I think it would be better to make this more general, and move the call
> to the existing console_suspend_enabled handling in uart_suspend_port().

Ok, I'll try this way.

> 
>> +       }
>>
>>         return 0;
>>  }
> 
> If this works, we can remove the console_suspend_enabled handling
> from drivers/pmdomain/renesas/rmobile-sysc.c, and revert commit
> 309864dcf92b76fc ("genpd: imx: scu-pd: do not power off console if
> no_console_suspend").

OK, first I'll go with this patch and after things settles down with it
I'll propose changes for rmobile-sysc and imx. Is this ok for you?

Thank you,
Claudiu Beznea

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
