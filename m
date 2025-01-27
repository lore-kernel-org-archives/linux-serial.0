Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021EE16F8E9
	for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737967465; cv=none; b=N/3My5y/UklXsbtFfMx8y096iIfO4xNiCCCPi/FyOA+AgPlfWoxQtYDU5ylEASYN765X5Duwo4/U90VaSweUBFO+jW6xmBR4GgBx2MJAEEwIJkBkRw+M7xxKcF3zhOWERgP1lSJtAko6GAmoMYpWIkvq/v6N9oNTY+sSTEMkZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737967465; c=relaxed/simple;
	bh=zc3GYuIa0H/dfDcIjunoGvJt9fBGtnXYVLUu7oC/gXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHGEx9d5q3LHvylvSw/6ZAuHev86zT7cc+Ik9haUq08NpJLBLjKdK69U4ONzL22ws39/YPQGA+s6h/AoFmMMPIwUB2fotrCnD4jK17q7Qrln6YqTb+rkCkU9yshLeD/KVhL1utTNYr4bGIv3GSG65nhsA3EjrzfN8S9gUlxcxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LEyptZD0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LEyptZD0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43624b2d453so44635175e9.2
        for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 00:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737967461; x=1738572261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWMJaQzxK5h0g3wewnNcXE2jLFFY4rflV4Hg+cod/No=;
        b=LEyptZD0VLUYPuxq9z2/3gPST1gMXGuqF0hFiRTzl8sLS3jCiRdslZj/P7Osu1O/TQ
         fE5esMsj0WiPNC9xU5h/uqMThb9Eqcnad1nlTtMpOQdrHL9gIYkw5rrnFDkzdYFJli23
         vQrl++quRMZ74sTOxeqSmwbowRvCCEGm7B08v2qppMX2cyB/l79Ybl22m+WQ5MBqqvQp
         psEwnTfe4VikyWO0A1bIcSq36IJBWc/6mAHP+H78g5GBKE2PWuxQCCt0M5KyPo8aH3F+
         OV/Y91UC9hVu+PsHZUUEn+WCHNKWKKaHGbx2WWy949RFHN2a6XPmeEmu4Ojh57hf9fK7
         K+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737967461; x=1738572261;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWMJaQzxK5h0g3wewnNcXE2jLFFY4rflV4Hg+cod/No=;
        b=N+E6LEtbZWozE98PUX4Iw7xoljgavzWeBmisXF83BeoIjy1+WgmWopYJgdoWoDX3B6
         4GPwnqFjEocFGVSqiwTvNzcDdflkVdr54Wd3DTyPkK9gD/x31K2JcJt44bCVfXJ+7tsb
         w9QkybQTDvUU6ewMOTJyAhT5k5ISdl5+O1mjnzgMNe2z0KyKSQhwb8ci/8TP1xbNidFI
         zM/iBLidDcpw67KNmkIBu9Z03Iv8jVINASA0K85RhVFBPi9lVh+MPcYqvUzkj1zRcVab
         rwFqoD8gqkOTdNs7BlD6vecg+dyuNe2d/k7qvoag+31oZxUrOnRlphO8673ip9LMLfeU
         9/cA==
X-Forwarded-Encrypted: i=1; AJvYcCWtfKAd5seUZ+7myZUpy1BYDHuwiaZPePntPlTvvgYRKU2G2T7m7dxDlsFCQ3qnywNmHNwfMCpGak/MD3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCPQutGiIe4fIap0WEJ3XXhFrr5nAR3vaxgcw5FNZTpxrb8wJ
	ZvMs+fupWTuoGGMRSeWV0OPl2yq85Y1Qb8TuzR94CEVgXUA7GNP4YopRBPVR0Sg=
X-Gm-Gg: ASbGnctB29Z57LcVsZj2owzVHsWeVPCvwGY7e91m1QVkUGubf0Pvi9ZAAd3fBMFMdj6
	yuhyeEpBVlTJFNk8yUUT2Ibgc8UwiSlfg+0+w7jgtZodej+kHEjoNy5IYCqpVYQo1C17NWBWxzA
	QFiawZiZXCuDzwdYEimWzY+VkG+c1kDzVYA4ppKTBwy79NnAYmm39ss7urO6KA7jfipUQzvbMky
	9v6Ub93NuD30LYk3OTVzkdnz7Hq6l3gfqU8O14OpaUMo7dq3P+GFIdfGWpaUir0YzX4xq7NY6g+
	BHlzka9BeByE
X-Google-Smtp-Source: AGHT+IEutVyzYaHJ4V43NcbvbXemrvFhbTC6Ej+E7hfOdKUg5CKomg+sw3Yv79V2O+Liezt/sr8EMQ==
X-Received: by 2002:a05:600c:3d86:b0:436:e751:e436 with SMTP id 5b1f17b1804b1-4389143b372mr339934795e9.19.1737967461239;
        Mon, 27 Jan 2025 00:44:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54c066sm122025505e9.29.2025.01.27.00.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 00:44:20 -0800 (PST)
Message-ID: <c8cbb0ca-f85c-47d7-a581-fbaf2147c807@tuxon.dev>
Date: Mon, 27 Jan 2025 10:44:19 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] serial: sh-sci: Update the suspend/resume support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 p.zabel@pengutronix.de, claudiu.beznea.uj@bp.renesas.com,
 wsa+renesas@sang-engineering.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250120130936.1080069-1-claudiu.beznea.uj@bp.renesas.com>
 <20250120130936.1080069-2-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWYNs2vQTn07Xfx1Misk3Ry5y3PSYPrGbycZdt5LnU_vQ@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWYNs2vQTn07Xfx1Misk3Ry5y3PSYPrGbycZdt5LnU_vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 24.01.2025 12:53, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for your patch!
> 
> On Mon, Jan 20, 2025 at 2:09 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S supports a power saving mode where power to most of the
>> SoC components is turned off. When returning from this power saving mode,
>> SoC components need to be re-configured.
>>
>> The SCIFs on the Renesas RZ/G3S need to be re-configured as well when
>> returning from this power saving mode. The sh-sci code already configures
>> the SCIF clocks, power domain and registers by calling uart_resume_port()
>> in sci_resume(). On suspend path the SCIF UART ports are suspended
>> accordingly (by calling uart_suspend_port() in sci_suspend()). The only
>> missing setting is the reset signal. For this assert/de-assert the reset
>> signal on driver suspend/resume.
>>
>> In case the no_console_suspend is specified by the user, the registers need
>> to be saved on suspend path and restore on resume path. To do this the
>> sci_console_setup() function was added. There is no need to cache/restore
>> the status or FIFO registers. Only the control registers. To differentiate
>> b/w these, the struct sci_port_params::regs was updated with a new member
>> that specifies if the register needs to be chached on suspend. Only the
> 
> cached
> 
>> RZ_SCIFA instances were updated with this new support as the hardware for
>> the rest of variants was missing for testing.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -101,7 +101,7 @@ enum SCI_CLKS {
>>                 if ((_port)->sampling_rate_mask & SCI_SR((_sr)))
>>
>>  struct plat_sci_reg {
>> -       u8 offset, size;
>> +       u8 offset, size, suspend_cacheable;
> 
> This increases the size of sci_port_params[] by 300 bytes.
> Using bitfields would mitigate that:
> 
>     struct plat_sci_reg {
>             u16 offset:8;
>             u16 size:5;
>             u16 suspend_cacheable:1;
>     };
> 
> (if we ever need more bits, the size member can store an enum value
>  instead of the actual size (8 or 16 bits) of the register).
> 
>>  };

OK

>>
>>  struct sci_port_params {
>> @@ -134,6 +134,8 @@ struct sci_port {
>>         struct dma_chan                 *chan_tx;
>>         struct dma_chan                 *chan_rx;
>>
>> +       struct reset_control            *rstc;
>> +
>>  #ifdef CONFIG_SERIAL_SH_SCI_DMA
>>         struct dma_chan                 *chan_tx_saved;
>>         struct dma_chan                 *chan_rx_saved;
>> @@ -153,6 +155,7 @@ struct sci_port {
>>         int                             rx_trigger;
>>         struct timer_list               rx_fifo_timer;
>>         int                             rx_fifo_timeout;
>> +       unsigned int                    console_cached_regs[SCIx_NR_REGS];
> 
> u16, as all registers are 8 or 16 bit wide.

OK.

> 
> We reserve space for 20 registers, but at most 6 will be used.
> This has a rather big impact on the size of sci_ports[], as
> CONFIG_SERIAL_SH_SCI_NR_UARTS defaults to 18.

I agree, but this should keep the suspend/resume code sane in case
extensions will be added to the code. In general people forget about
suspend/resume code when extending. Please let me know if you prefer to
limit it (although, doing like this will complicate the code, I think).

> 
> Also, this space is used/needed only if:
>   - CONFIG_PM_SLEEP=y,
>   - CONFIG_SERIAL_CORE_CONSOLE=y (see uart_console()),
>   - The port is actually used as a console (unfortunately the user
>     can specify multiple console=ttySC<N> command line parameters, in
>     addition to chosen/stdout-path).

Would you prefer to guard the suspend/resume code with these flags?

> 
>>         u16                             hscif_tot;
>>
>>         bool has_rtscts;
>> @@ -300,17 +303,17 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
>>          */
>>         [SCIx_RZ_SCIFA_REGTYPE] = {
>>                 .regs = {
>> -                       [SCSMR]         = { 0x00, 16 },
>> -                       [SCBRR]         = { 0x02,  8 },
>> -                       [SCSCR]         = { 0x04, 16 },
>> +                       [SCSMR]         = { 0x00, 16, 1 },
>> +                       [SCBRR]         = { 0x02,  8, 1 },
>> +                       [SCSCR]         = { 0x04, 16, 1 },
>>                         [SCxTDR]        = { 0x06,  8 },
>>                         [SCxSR]         = { 0x08, 16 },
>>                         [SCxRDR]        = { 0x0A,  8 },
>> -                       [SCFCR]         = { 0x0C, 16 },
>> +                       [SCFCR]         = { 0x0C, 16, 1 },
>>                         [SCFDR]         = { 0x0E, 16 },
>> -                       [SCSPTR]        = { 0x10, 16 },
>> +                       [SCSPTR]        = { 0x10, 16, 1 },
>>                         [SCLSR]         = { 0x12, 16 },
>> -                       [SEMR]          = { 0x14, 8 },
>> +                       [SEMR]          = { 0x14, 8, 1 },
> 
> Note that the driver always writes zero to SEMR.

In case the IP is used on SoCs with sleep states where the resume is done
with the help of bootloader, the bootloader code might interact with
registers that the Linux code writes with zero.

Keeping it for registers where driver writes zero should also help if the
serial IPs power will be off during suspend, thus registers restored to non
zero default values (by HW) after resume.

> 
>>                 },
>>                 .fifosize = 16,
>>                 .overrun_reg = SCLSR,
>> @@ -3374,6 +3377,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
>>         }
>>
>>         sp = &sci_ports[id];
>> +       sp->rstc = rstc;
>>         *dev_id = id;
>>
>>         p->type = SCI_OF_TYPE(data);
>> @@ -3546,13 +3550,34 @@ static int sci_probe(struct platform_device *dev)
>>         return 0;
>>  }
>>
>> +static void sci_console_setup(struct sci_port *s, bool save)
> 
> sci_console_save_restore()?

OK

> 
>> +{
>> +       for (u16 i = 0; i < SCIx_NR_REGS; i++) {
> 
> unsigned int

OK

> 
>> +               struct uart_port *port = &s->port;
>> +
>> +               if (!s->params->regs[i].suspend_cacheable)
>> +                       continue;
>> +
>> +               if (save)
>> +                       s->console_cached_regs[i] = sci_serial_in(port, i);
>> +               else
>> +                       sci_serial_out(port, i, s->console_cached_regs[i]);
>> +       }
>> +}
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

