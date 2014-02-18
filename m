From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v3 4/7] tty/serial: at91: use mctrl_gpio helpers
Date: Tue, 18 Feb 2014 16:09:28 +0100
Message-ID: <CACQ1gAhOxMdjMGUFS68LijMTdZdsOX0zzww2QBVVsDdPYMEh_g@mail.gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
 <1392656247-3351-5-git-send-email-richard.genoud@gmail.com> <20140218190442.b5f5668e02e2dda0bf45d0b4@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:57230 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699AbaBRPJu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 10:09:50 -0500
Received: by mail-la0-f49.google.com with SMTP id y1so12247540lam.36
        for <linux-serial@vger.kernel.org>; Tue, 18 Feb 2014 07:09:49 -0800 (PST)
In-Reply-To: <20140218190442.b5f5668e02e2dda0bf45d0b4@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-02-18 16:04 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> On Mon, 17 Feb 2014 17:57:24 +0100
> Richard Genoud <richard.genoud@gmail.com> wrote:
>
>> On sam9x5, dedicated CTS (and RTS) pins are unusable together with the
>> LCDC, the EMAC, or the MMC because they share the same line.
>>
>> Moreover, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
>> so we have to control them via GPIO.
>>
>> This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
>> signals.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ...
>> diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
>> index 605add05af7e..6dd386e3d9fe 100644
>> --- a/arch/arm/mach-at91/at91rm9200_devices.c
>> +++ b/arch/arm/mach-at91/at91rm9200_devices.c
> ...
>> @@ -961,7 +961,14 @@ static struct resource uart0_resources[] = {
>>  static struct atmel_uart_data uart0_data = {
>>       .use_dma_tx     = 1,
>>       .use_dma_rx     = 1,
>> -     .rts_gpio       = -EINVAL,
>> +};
>> +
>> +struct gpiod_lookup_table uart0_gpios_table = {
>
> static
arg ! I missed this one !
good catch !

>> +     .dev_id = "atmel_usart",
>> +     .table = {
>> +             GPIO_LOOKUP("pioA", 21, "rts", GPIO_ACTIVE_LOW),
>> +             { },
>> +     },
>>  };
> ...
>
> --
> Alexander Shiyan <shc_work@mail.ru>



-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
