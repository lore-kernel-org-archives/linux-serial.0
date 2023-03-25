Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BD1C6FD1C
	for <linux-serial@archiver.kernel.org>; Sat, 25 Mar 2023 19:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCYTAa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Mar 2023 15:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCYTA3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Mar 2023 15:00:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E6CC04
        for <linux-serial@vger.kernel.org>; Sat, 25 Mar 2023 12:00:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s8so6326919lfr.8
        for <linux-serial@vger.kernel.org>; Sat, 25 Mar 2023 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679770826;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNSNQHiJruuk+O1hCrFKL1wyio5CYnytaf4dbpeDgFY=;
        b=EWIyx3YM6vIJ9ONLKTJykSnsWgvaTzHsvXW41cV5YZHzTr/BbPuDLZhUHjFPQKLhFU
         tmwK5HhT/Ex3gF/67nMI1fM/0NtjO0mitDDEAik7xDLwl7RPC84/77KC9m22qVVbwHgJ
         ncgXAZeqPAD3omhzZh/L7JRT+NII+RaP7mEik7/Mfva4ZxN4Sn5lTWA3KL0iE2RFvHhh
         sjhSC5G9AWSrkrSIIX0YZ32qEPIdRc6HqQLy1ZxsYNxCntPJMml9M8YQSaiCTf0tMZj2
         +cENYXchea7Cu/ZWjubMHsDxJtMoTDF+5ya7z8dgcjRi/IWYH81tEaVj74JjvCKWHCR/
         BAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679770826;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNSNQHiJruuk+O1hCrFKL1wyio5CYnytaf4dbpeDgFY=;
        b=PYWB56mG1pIzw+AJITJnqwkviBj8HRhu56ZcTz215NudbUAL8OCrZLYNt8XUECfUu5
         pNqIVayxmD7z4FWxIzNFIs29pEEs2ENO5buoKm5rTat5QpYDGuKmptulrhCnZ34ShR41
         xVA1UMipFTUY/5jVmXITnlYjymMl1RhzEtOzI8G6J++9EfO3L+Bq+zCu7h6fjGkfpuE1
         wYFQ41CjsKkcIFKJiICqxONFUyp1zlLGrR2kWTXX9hrqC3UmHn8CKjVupxN3ygFX0T9x
         u/IBAbRCgmvuYoAZWg9MrhS76a2ag6sbV6s/lqAmuuCTj4SBxVLtTnSSzeLjvebXheA5
         rRPg==
X-Gm-Message-State: AAQBX9dv5pumk34ibaNS1TLXKSxWFfLbWJxs6ltyZKqfInoP4F29srJv
        6zKxCmL+yFYytuIHAY7xsek=
X-Google-Smtp-Source: AKy350YngVFUxD7u09eEZEJfOPCWgh0ZtJzsky3j1HfF2NZO07bL1q48DZDxI+9PY9ZPQtDBSR69nQ==
X-Received: by 2002:ac2:446f:0:b0:4dd:a61c:8f74 with SMTP id y15-20020ac2446f000000b004dda61c8f74mr2262939lfl.51.1679770826063;
        Sat, 25 Mar 2023 12:00:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t18-20020ac243b2000000b004e92c0ed7a0sm3907519lfl.100.2023.03.25.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 12:00:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
        <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
        <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
        <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
        <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
        <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
        <07d37e3e-dfe2-9e6e-a981-8d3c6a9fc5f5@i2se.com>
Date:   Sat, 25 Mar 2023 22:00:24 +0300
In-Reply-To: <07d37e3e-dfe2-9e6e-a981-8d3c6a9fc5f5@i2se.com> (Stefan Wahren's
        message of "Sat, 25 Mar 2023 18:05:10 +0100")
Message-ID: <878rfk64hj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Uwe,
>
> Am 25.03.23 um 16:11 schrieb Uwe Kleine-König:
>> Hello,
>> On Sat, Mar 25, 2023 at 12:31:01PM +0100, Stefan Wahren wrote:
>>> Am 24.03.23 um 16:00 schrieb Stefan Wahren:
>>>> Am 24.03.23 um 13:57 schrieb Fabio Estevam:
>>>>> On Fri, Mar 24, 2023 at 8:48 AM Ilpo Järvinen
>>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>>
>>>>>> This has come up earlier, see e.g.:
>>>>>>
>>>>>> https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
>>>>>>
>>>>>> My somewhat uninformed suggestion: if the overrun problems
>>>>>> mostly show up
>>>>>> with console ports, maybe the trigger level could depend on the port
>>>>>> being a console or not?
>>>>> Does the change below help? Taking Ilpo's suggestion into account:
>>>> this breaks the boot / debug console completely, but i got the idea.
>>>>>
>>>
>>> based on your patch, i successfully tested this:
>>>
>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>> index f07c4f9ff13c..1aacaa637ede 100644
>>> --- a/drivers/tty/serial/imx.c
>>> +++ b/drivers/tty/serial/imx.c
>>> @@ -1277,6 +1277,7 @@ static void imx_uart_clear_rx_errors(struct imx_port
>>> *sport)
>>>   }
>>>
>>>   #define TXTL_DEFAULT 2 /* reset default */
>>> +#define RXTL_DEFAULT_CONSOLE 1 /* reset default */
>>>   #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
>>>   #define TXTL_DMA 8 /* DMA burst setting */
>>>   #define RXTL_DMA 9 /* DMA burst setting */
>>> @@ -1286,6 +1287,9 @@ static void imx_uart_setup_ufcr(struct imx_port
>>> *sport,
>>>   {
>>>   	unsigned int val;
>>>
>>> +	if (uart_console(&sport->port))
>>> +		rxwl = RXTL_DEFAULT_CONSOLE; // fallback
>>> +
>>>   	/* set receiver / transmitter trigger level */
>>>   	val = imx_uart_readl(sport, UFCR) & (UFCR_RFDIV | UFCR_DCEDTE);
>>>   	val |= txwl << UFCR_TXTL_SHF | rxwl;
>> So the current theory that the issue occurs because of a combination of:
>>   - With a higher watermark value the irq triggers later and so there is
>>     less time the until the ISR must run before an overflow happens; and
>>   - serial console activity disables irqs for a (relative) long time
>> right?
>> So on an UP system the problem should occur also on a non-console port?
>
> This is less likely, because UART applications usually need some kind
> of flow control (either from hardware or protocol side). For a
> non-console application the receiver usually wait until the end and
> then starts to transmit.

Only CTS/RTS hardware handshake could help, as otherwise printk() output
is typically entirely async with respect to transmissions on another
port, and software protocol(s) then are irrelevant, unless they enforce
extremely short chunks of data (less than FIFO size).

> Sure you can flood the UART with characters and it's only a question
> of time until the RX FIFO is full and data get lost.

In correctly working RT system this doesn't typically happen, as CPUs
are way faster than typical UART speeds, and are able to handle the
loads easily, provided UART has decent FIFO. It's disabling IRQs for
prolonged times that makes shit happen.

[...]

>
> According to these lines in imx.c DMA is never used for console:
>
>   /* Can we enable the DMA support? */
>   if (!uart_console(port) && imx_uart_dma_init(sport) == 0)
>     dma_is_inited = 1;
>
> At the end the patch above only restores the old console behavior, but
> keep Tomasz Moń's optimization for non-console (which was indented
> for).

So this will likely only be of help for this particular case, and will
leave the problem there on other DMA-disabled ports. To "fix" this, the
old threshold is to be returned on all DMA-disabled ports, and then the
Tomasz original patch would be entirely reverted, it seems.

Disclaimer: all the above is said on the assumption that it's printk
that is core cause of the problem in this case, that has not yet been
shown in testing, as far as I know.

Best regards,
-- Sergey
