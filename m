Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FD2C6FD1F
	for <linux-serial@archiver.kernel.org>; Sat, 25 Mar 2023 17:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCYRFh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Mar 2023 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYRFg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Mar 2023 13:05:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9EC7AA9
        for <linux-serial@vger.kernel.org>; Sat, 25 Mar 2023 10:05:34 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.35]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MX0TX-1pzgOH2Bkv-00XOSX; Sat, 25 Mar 2023 18:05:12 +0100
Message-ID: <07d37e3e-dfe2-9e6e-a981-8d3c6a9fc5f5@i2se.com>
Date:   Sat, 25 Mar 2023 18:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
 <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
 <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UGQ0fic29pUhCcTMPNcevQp3022P8rFUxluMsaK1/PqlTUFrZRu
 f91veX0iFawTy6Q899NeaNppu0xJUHEQqJk/SacCMHRmfLJ2otFYuOFw+WwPa68gWEThWL6
 6fcanNz1I45YXzvf5RKICIuh6Oy305YjBr8ePcve+2WwZf1RGVoSoTAlso5N1dcGf6pwyqs
 ivLqalzQVka3RWmwNoSVg==
UI-OutboundReport: notjunk:1;M01:P0:jep8OXvgyow=;c4J2+Xwu+EEoj9tYGiK3ybe5RXn
 lqgUcxuS2P5RbkUXvjV4ixKmfI9JWep5wLubsExiCp7/3RCrO6TWEcnFogCpUsDqAeC8iX5vN
 PFMqKFsM+EDjBbuuW92bm9mVEe+ZtRsV1v/qmEoAMaSmVwet/DdyuFW20M0tRr/K5NnNjUhfK
 B5mU6rDRbkCa0c/WQZyPH35ldIJYexITlpAnG3t2RxesB5FImr93ft1YZoa4Zk883X7xmEXOT
 7/6AFWxIJWWt0bFgF92dVb3CT+wM1eaGWYVjZogjeaIaoZmUgbDnXkLEo699upqtrBpIdqovO
 YC+lU96mY0N/oZSSnfW+y2LE287y/O0jlXZ5GkVcKVHVXYilNp3e371datqv57rLUzQS9yf3P
 oYUbZqJw10NT221/8wXTbwDlbjO87qwSbM/NtaOCTKJ+s5pOGMzZdd34QMOiHNZhZE5Q6XeAL
 8+HZ0OgyIHsm2UAgkrfL90FVGQ7U2jybN1SdtOOwFtIgxbFkcqWzCSoX895iebd4u1CBWyX8F
 4CLEQvAsPK+zMJ0RAl1b69yokb3eMpzch+fBrb8Z6EBz8ObNcLG+zc8ukLwzPeamz0Rc6yqe+
 tKjII6c0eEqdubqCb1VY623pjqRaBoRl8JDNyvSaZO53fxx2Yt1bReFOFPvdL0QPAqTYIZO/k
 8lqLDIg5tx7fZuDZYW87Ea68JIKYoH8qWO3EeyyPpw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Uwe,

Am 25.03.23 um 16:11 schrieb Uwe Kleine-König:
> Hello,
> 
> On Sat, Mar 25, 2023 at 12:31:01PM +0100, Stefan Wahren wrote:
>> Am 24.03.23 um 16:00 schrieb Stefan Wahren:
>>> Am 24.03.23 um 13:57 schrieb Fabio Estevam:
>>>> On Fri, Mar 24, 2023 at 8:48 AM Ilpo Järvinen
>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>
>>>>> This has come up earlier, see e.g.:
>>>>>
>>>>> https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
>>>>>
>>>>> My somewhat uninformed suggestion: if the overrun problems
>>>>> mostly show up
>>>>> with console ports, maybe the trigger level could depend on the port
>>>>> being a console or not?
>>>> Does the change below help? Taking Ilpo's suggestion into account:
>>> this breaks the boot / debug console completely, but i got the idea.
>>>>
>>
>> based on your patch, i successfully tested this:
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index f07c4f9ff13c..1aacaa637ede 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1277,6 +1277,7 @@ static void imx_uart_clear_rx_errors(struct imx_port
>> *sport)
>>   }
>>
>>   #define TXTL_DEFAULT 2 /* reset default */
>> +#define RXTL_DEFAULT_CONSOLE 1 /* reset default */
>>   #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
>>   #define TXTL_DMA 8 /* DMA burst setting */
>>   #define RXTL_DMA 9 /* DMA burst setting */
>> @@ -1286,6 +1287,9 @@ static void imx_uart_setup_ufcr(struct imx_port
>> *sport,
>>   {
>>   	unsigned int val;
>>
>> +	if (uart_console(&sport->port))
>> +		rxwl = RXTL_DEFAULT_CONSOLE; // fallback
>> +
>>   	/* set receiver / transmitter trigger level */
>>   	val = imx_uart_readl(sport, UFCR) & (UFCR_RFDIV | UFCR_DCEDTE);
>>   	val |= txwl << UFCR_TXTL_SHF | rxwl;
> 
> So the current theory that the issue occurs because of a combination of:
> 
>   - With a higher watermark value the irq triggers later and so there is
>     less time the until the ISR must run before an overflow happens; and
> 
>   - serial console activity disables irqs for a (relative) long time
> 
> right?
> 
> So on an UP system the problem should occur also on a non-console port?

This is less likely, because UART applications usually need some kind of 
flow control (either from hardware or protocol side). For a non-console 
application the receiver usually wait until the end and then starts to 
transmit.

Sure you can flood the UART with characters and it's only a question of 
time until the RX FIFO is full and data get lost. But i think we should 
focus on the real use case and don't try find the perfect solution. At 
the end it's always a compromise between latency and throughput.

> Local irqs are only disabled if some printk is about to be emitted,
> isn't it? Does this match the error you're seeing?

Yes, that's the typical "problem" of a console application.

> That makes me wonder if the error doesn't relate to the UART being a
> console port, but the UART being used without DMA?! (So the patch above
> fixes the problem for you because on the console port no DMA is used?)

As i said the issue only occured on the console. My problem is that the 
other UARTs on Tarragon are used for RS485 which means they are just 
half duplex.

According to these lines in imx.c DMA is never used for console:

   /* Can we enable the DMA support? */
   if (!uart_console(port) && imx_uart_dma_init(sport) == 0)
     dma_is_inited = 1;

At the end the patch above only restores the old console behavior, but 
keep Tomasz Moń's optimization for non-console (which was indented for).

Best regards
Stefan

> 
> Best regards
> Uwe
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
