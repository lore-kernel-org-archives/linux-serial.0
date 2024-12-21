Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF51EC4E4
	for <linux-serial@vger.kernel.org>; Sat, 21 Dec 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734773960; cv=none; b=E95qVCeq8wtsrT8M+kjk1GHguIjWeAX1SarQx2/EuZh/bDhybFRFYgIbV43UFLvs1e/hPhamyrW2CHSnndYmcOI55r9xM/jSjrbIpEbVCEfjaFC7BEeFxqBhH8pkmmcXsJf1vztPJfmk8000X+0CeODaiasWwlwxhSrRuGHBLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734773960; c=relaxed/simple;
	bh=9pXezadzbls94KOnx5e1shcBTjOjycAt9+CEapX5iQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm+aFi2QDVyVF/sJR5ogEDTHe26PhNp5lxXaI+7EM5hn1+l1BY33aEkhF2YE3Hi9hqr21ALpSd1uXnOrSXriaMpILoeib3/MGsZC5jNvJIdZ87rysQEytPcw00Ev7AaYI16WGDWn0rVkokH1UcIa6l5JrAEuyho/Pb+mvIY3J0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WE4ECmGy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WE4ECmGy"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361815b96cso18443395e9.1
        for <linux-serial@vger.kernel.org>; Sat, 21 Dec 2024 01:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734773956; x=1735378756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZNmeX86n+9HAVwGE3m2ohvACsxbMW0Tp1k1MFwLUd0=;
        b=WE4ECmGy3hEwhGM6VA6mi09Ba8Y6dGTdngrqFhT40TkPSXuABfvPMqKRLO6BuORupG
         SNrSJkfKua5DWWPV3v7bKwcS5LWaar41N8bdk6QrJTKW7qst4Isu4ijTysvGmh0hSDfV
         Atnj6N4mQOA4DoIwVlxFqvW8JAbCRKuovfMfMJ5YYgY+HNT8r2dYswq+8fIDT1vmMiOx
         UTAcuBGI7lrNPxKYA3K4EWYpfgWVBcUJgmREpOD8idaQ4+lE+5jBFfZLdBEhGHV0Pdxw
         XHrjPL4TglhDO1IB7c91NOmrdb+lLrn1/38atEePoLkXYZiCvBUvY3PsFvm7aB46/fF1
         SqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734773956; x=1735378756;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZNmeX86n+9HAVwGE3m2ohvACsxbMW0Tp1k1MFwLUd0=;
        b=l45CcsU+N/AMtrhq8a+2ExtOozs/8FbB34xk4NimNlAKphStIoj5RaEKvqsS7kLec+
         s+z04+vYm8qzl57/3o+z/0Lq2J3fdY/+v+LsWsghErqyN2Om7pzuJ0UU8NOymDN3qd0S
         TlbVE2YFfcPQRy7WH28/4Kzt0epy9huv0qEuFSaK5wL7SZDPuR95OWi2QJ6hadOxRyRE
         aBLUT9HLftNRbb6Q0/+te9Rtabv6qtXVuwCBbOgWUWzsvfUyxQrcXzlgf/DS4f2P5EG7
         uikdFkATdzxwRmrAqTn/fxBzfysBA7j4OttJTxIAdAwOMVvkAJaCf6oWfl47p5o6SpFV
         YrJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrDaoPdkFr2iJfmbCzfByZDd25o5RGv9ekC+vnZ9B0pH9vXgh7xWkKcDEIxvko6N07ZkNDOU9qWrGeR3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTWoUlkO3EgNLdNCXWV29EmoodSVrpxHYMTbzMRhUu2D8Zpaz
	fLa6Fi6B/RvbqBjy771sByFlwXrk3ZE+lBz/ZevC8VlMibqY1gkvktHaYl+3tvY=
X-Gm-Gg: ASbGncttjdc+tcnKW8PbcACPpGSMAQ00f5s8NdBWLjQmLnNpoKAzeKZ54aRKJZRfiPQ
	UHoKUCTZ19vBdlnyK4MrD6PIXX0XEK0Pr+nBrnLdMgaTbzxN1g7f8C8UyoOGW0V9GIE1qmIw651
	fkf3guzDqKscf2iqzsNoRQL0sc0IaD94fIvObZCPbAf0ynnYnCpLp9aJIdGJWISY39zdzfTk80E
	b1H+TrZSw04aburtM70rMGlszq3+/fNhTogFjKkDTSfeCCpcnEDPlfUkTu6nxlNcg==
X-Google-Smtp-Source: AGHT+IG8twa3ijqelDvSJmER6b60k1PJMF5eCL0R2PWjIHs59EYuNofh4YiC0RKcXmuH21YXBrNjBQ==
X-Received: by 2002:a05:600c:1d07:b0:434:f335:83b with SMTP id 5b1f17b1804b1-43668548780mr49940765e9.5.1734773955002;
        Sat, 21 Dec 2024 01:39:15 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656a0b361sm104827355e9.0.2024.12.21.01.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 01:39:14 -0800 (PST)
Message-ID: <d59a3140-b701-4443-b160-a880fc7fc824@tuxon.dev>
Date: Sat, 21 Dec 2024 11:39:12 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 5/6] serial: sh-sci: Clean sci_ports[0] after at
 earlycon exit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 wsa+renesas@sang-engineering.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 lethal@linux-sh.org, g.liakhovetski@gmx.de, groeck@chromium.org,
 mka@chromium.org, ulrich.hecht+renesas@gmail.com,
 ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
 <20241204155806.3781200-6-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXz8FHRLPOuHPKvjmq2FCidY20MrCmSsq+pK1QUg-fk2A@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdXz8FHRLPOuHPKvjmq2FCidY20MrCmSsq+pK1QUg-fk2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 19.12.2024 16:26, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Dec 4, 2024 at 4:58 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The early_console_setup() function initializes sci_ports[0].port with an
>> object of type struct uart_port obtained from the struct earlycon_device
>> passed as an argument to early_console_setup().
>>
>> Later, during serial port probing, the serial port used as earlycon
>> (e.g., port A) might be remapped to a different position in the sci_ports[]
>> array, and a different serial port (e.g., port B) might be assigned to slot
>> 0. For example:
>>
>> sci_ports[0] = port B
>> sci_ports[X] = port A
>>
>> In this scenario, the new port mapped at index zero (port B) retains the
>> data associated with the earlycon configuration. Consequently, after the
>> Linux boot process, any access to the serial port now mapped to
>> sci_ports[0] (port B) will block the original earlycon port (port A).
>>
>> To address this, introduce an early_console_exit() function to clean up
>> sci_ports[0] when earlycon is exited.
>>
>> To prevent the cleanup of sci_ports[0] while the serial device is still
>> being used by earlycon, introduce the struct sci_port::probing flag and
>> account for it in early_console_exit().
>>
>> Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes since the integrated patch:
>> - adjust the commit message to address Geert comments at [1]
>> - Introduce the struct sci_port::probing flag to prevent the cleanup
>>   of sci_ports[0] while the serial device is still being used by earlycon
> 
> Thanks for the update!
> 
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -159,6 +159,7 @@ struct sci_port {
>>         bool autorts;
>>         bool tx_occurred;
>>         bool earlycon;
>> +       bool probing;
> 
> This is only used in sci_ports[0], so it can be a single global flag,
> instead of a flag embedded in each sci_port structure.
> 
>>  };
>>
>>  #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
>> @@ -3386,7 +3387,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
>>  static int sci_probe_single(struct platform_device *dev,
>>                                       unsigned int index,
>>                                       struct plat_sci_port *p,
>> -                                     struct sci_port *sciport)
>> +                                     struct sci_port *sciport,
>> +                                     struct resource *sci_res)
>>  {
>>         int ret;
>>
>> @@ -3433,12 +3435,15 @@ static int sci_probe_single(struct platform_device *dev,
>>                 sciport->port.flags |= UPF_HARD_FLOW;
>>         }
>>
>> -       ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
>> -       if (ret) {
>> -               return ret;
>> +       if (sci_ports[0].earlycon && sci_ports[0].port.mapbase == sci_res->start) {
>> +               /*
>> +                * Skip cleanup up the sci_port[0] in early_console_exit(), this
> 
> Double up
> 
>> +                * port is the same as the earlycon one.
>> +                */
>> +               sci_ports[0].probing = true;
>>         }
>>
>> -       return 0;
>> +       return uart_add_one_port(&sci_uart_driver, &sciport->port);
>>  }
>>
>>  static int sci_probe(struct platform_device *dev)
>> @@ -3496,7 +3501,7 @@ static int sci_probe(struct platform_device *dev)
>>
>>         platform_set_drvdata(dev, sp);
>>
>> -       ret = sci_probe_single(dev, dev_id, p, sp);
>> +       ret = sci_probe_single(dev, dev_id, p, sp, res);
>>         if (ret)
>>                 return ret;
>>
>> @@ -3579,6 +3584,20 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
>>  #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
>>  static struct plat_sci_port port_cfg;
>>
>> +static int early_console_exit(struct console *co)
>> +{
>> +       struct sci_port *sci_port = &sci_ports[0];
>> +
>> +       /*
>> +        * Clean the slot used by earlycon. A new SCI device might
>> +        * map to this slot.
>> +        */
>> +       if (sci_port->earlycon && !sci_port->probing)
>> +               memset(sci_port, 0, sizeof(*sci_port));
> 
> Aha, so this clears sci_port.earlycon, too (cfr. my comment on
> PATCH 4/6). Still, I don't think this is sufficient: shouldn't
> sci_port.earlycon be cleared unconditionally?

I remember I had failures with unconditional clear. I'll double check it
though and adjust accordingly, if needed.

Thank you,
Claudiu

> 
>> +
>> +       return 0;
>> +}
>> +
>>  static int __init early_console_setup(struct earlycon_device *device,
>>                                       int type)
>>  {
>> @@ -3596,6 +3615,8 @@ static int __init early_console_setup(struct earlycon_device *device,
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
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

