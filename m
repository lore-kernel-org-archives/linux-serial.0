Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A4C63797
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 13:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbjAQNW6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjAQNW5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 08:22:57 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA8E17CD3
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 05:22:56 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vw16so12162125ejc.12
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Blsf+gRJg9gUo6XZ6jKH4G1dD07rXbT7Kers4IPVu38=;
        b=i1i76At8CN1o+y5VDIMjAKt8L+TVKWExJqf5+xRoSdMYPcxUhduHZsERMp+sUyBwxb
         IgdXIzDMyNX//Dk1ru9Wfxu0yMb9cRTrKgxxYBqR2AF+Vx6aTLfAgDEQNBU2hkuR4hdu
         eCF7gRuebgFcvIFYPmKtY+rDJDgBmae+mtYoM3cRAcU33EL07X+9PPOdUw/jIOTQfppp
         ygd7961AvsFoQYEhWSvV38f7AZJ8VTvdgyE2LxzeSYzw9f98JV1SUmPCcNGOYr2sjAbC
         999qglqf21EkIz+NhTjnP2+VxeeHN03ejLVzHs0mKqqGcUOxw4nnoAVH4vvm7MVa+NEb
         3hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Blsf+gRJg9gUo6XZ6jKH4G1dD07rXbT7Kers4IPVu38=;
        b=GyGXqZDCcvy1NEzBQQiKePB8c3WSw+BneqhqtJ9CCc4Lv1odkUDN3MbQkTSBt0P49v
         9Shc0EHpyuJdhjxjsvU7xh7kmUo03RZXq2RK6W9ihweZ7kRawGqYonVR2AYSLd+qvmVK
         TialmVBxHIaW8ep7r9TsVcrjiH4RpwLxX5WTD5djUHRQyliCFsw01vCtkJgVTvgopgcx
         gqpSpcP7WkHufVLujLvSqW0/qknLDapF/sLzuOnMaXu6prX7K6NyYesX3DXX96k035KB
         yHX8OtSCn6tHyd+kTUFawaDnrGfHIL7Ch8/k8uks0y5A9Hw10V/Q2TQ2ScU4A9075ZVY
         a+2w==
X-Gm-Message-State: AFqh2krKyGSeeuNMzCFEDLQAL/ERUT4FsQ3HYnG8NMEXKdccHBY5Q+nT
        pBvsqwYoly3Fe2ZnK5nsnD0=
X-Google-Smtp-Source: AMrXdXs6GncVHH2THrAn4VgpKJPi53I7rngdKJfQ3n/QlgOAtWxBDqQLJmf4t7aXjSyRynPTiw9MRw==
X-Received: by 2002:a17:907:2587:b0:847:410:ecf0 with SMTP id ad7-20020a170907258700b008470410ecf0mr2730163ejc.20.1673961774554;
        Tue, 17 Jan 2023 05:22:54 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id hp24-20020a1709073e1800b008720c458bd4sm1476682ejc.3.2023.01.17.05.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:22:53 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading loop
References: <87bko4e65y.fsf@osv.gnss.ru>
        <20230113184334.287130-1-sorganov@gmail.com>
        <20230113184334.287130-8-sorganov@gmail.com>
        <20230117113205.l5byaz3srzpagzhz@pengutronix.de>
Date:   Tue, 17 Jan 2023 16:22:51 +0300
In-Reply-To: <20230117113205.l5byaz3srzpagzhz@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 17 Jan 2023 12:32:05
 +0100")
Message-ID: <87bkmx47o4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Fri, Jan 13, 2023 at 09:43:33PM +0300, Sergey Organov wrote:
>> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know
>> we read registers that must not be cached.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index be00362b8b67..f4236e8995fa 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>>  	struct imx_port *sport = dev_id;
>>  	unsigned int rx, flg;
>>  	struct tty_port *port = &sport->port.state->port;
>> +	typeof(sport->port.membase) membase = sport->port.membase;
>>  	u32 usr2;
>>  
>>  	/* If we received something, check for 0xff flood */
>> -	usr2 = imx_uart_readl(sport, USR2);
>> +	usr2 = readl(membase + USR2);
>>  	if (usr2 & USR2_RDR)
>>  		imx_uart_check_flood(sport, usr2);
>>  
>> -	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
>> +	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
>>  		flg = TTY_NORMAL;
>>  		sport->port.icount.rx++;
>
> One of the motivations to introduce imx_uart_readl was to have a single
> place to add a debug output to be able to inspect what the driver is
> doing.
>
> I wonder where your need for higher speed comes from and if the compiler
> really generates more effective code with your change.

Mostly it's because I'm obviously slowing things down a bit with the
patch to fight the flood, so I feel obliged to get things back on par
with the origin. Then, higher speed, let alone the time spent with
interrupts disabled and/or spinlocks taken, is always one of generic
goals for me.

As for the generated code, with this patch I don't aim to affect code
generation, I rather avoid execution of part of existing code while
being on the most critical path. It should be quite obvious that not
executing some code is at least not slower than executing it.

>
> Please either drop the patch from your series or provide the differences
> the compiler produces and a benchmark.

If your only objection against this patch is the desire to keep a single
place to add debug output, I'll be happy to tune the resulting code to
still have one.

That said, before we make a decision, could you please tell why register
shadows that the imx_uart_readl/writel are dealing with are needed in
the first place? It looks like all the registers that are shadowed are
readable as well. What's going on here, and if it happens to be a
speed-up, do we have any benchmarks?

Thanks,
-- Sergey Organov
