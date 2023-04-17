Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA42C77B7A
	for <linux-serial@archiver.kernel.org>; Mon, 17 Apr 2023 18:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDQSlF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Apr 2023 14:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDQSlE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Apr 2023 14:41:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09846AF
        for <linux-serial@vger.kernel.org>; Mon, 17 Apr 2023 11:41:01 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MG9Pg-1pY0hn0jdM-00GV4g; Mon, 17 Apr 2023 20:40:39 +0200
Message-ID: <ec6b89cf-91fc-f7cb-e934-c58f2613b57a@i2se.com>
Date:   Mon, 17 Apr 2023 20:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
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
 <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com> <87mt3ynsa7.fsf@osv.gnss.ru>
 <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com> <87sfcy8ncu.fsf@osv.gnss.ru>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <87sfcy8ncu.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:H/Lpb2ALEF/aoBYcVAS3im3ghqMoE08jRvi9RMG0+8RhWZb+834
 BATV5zI+0LYEXE8G/hjguBVEbWqGiLAbcVibni1h7Zr0SdYhhON98N32Nv8MLmkI3uFhCLn
 3ANmAFEhydtA9YmIzEHh14ChC+MpsWEOL7nN+2BaHLtnW2zcXYP/3O7mYUgoSPXSyoQJpAX
 i38fhLh2X8KVlldu39AlA==
UI-OutboundReport: notjunk:1;M01:P0:F/zN/uh0lf4=;TWWErC1u83fff/b3rsPbtXcoCB1
 VZLUIq7XL3SbtQoo9I9SWAtgXe0IYPWBoi5MhSJ3Map0ig4P4q+22ksfUASD4Qun0ZsaPrLN2
 gnmm7aDRZ9zb3AQCIDUWtf/sHI9stsWzC9CLHHV/47yYwmJhCZ9ppNznbu1wrEhlUbqgyKdLa
 uedgaksQEk/JIGWv+7dU6zAyqg144U+oNnYKikPVZ0dsGlXRvuzKQgKclnTooiWBs2k/j5Sz2
 FMOiKW6YkN+GKaBPSpOJiTPlMsT6h25Tysg+b95ka+zZh1dL7O6j7vT1LAzVJi1xY81yYkya/
 W+8SEa56e+O8dp/Wxy2lgLdb7g1gv+DH5MtWFA64v2EfXdIs5sgwwFE9PJgn9UH8nqNYy8UoJ
 8n19KoQOMGQiQT0Nq9Lt21Lq7GP3kxeHq7rk2Bh8etkwacEmCBz2hufLtIS+UfvJRlasWLazL
 LVyQDYJWQ+C9k6TSqfumWPsCsrSE7JirDaHekrlQPmppwTnoeYXczfGDS3ujD5WhUi+w3bqno
 OtxjoTIbaKOjAwHCifd0CKfcFr3sPLnjCRXbNpctwEhSCtDThZM/ZSXLcv9gN3PJKYoUN7xGe
 oSq0S299zFsHb7y5jqbFJCTl29fjyxxiJCqYmdRsMNQYEURlBS2sGgj6ltlGULaAKiscWFgGE
 HwkjRJdwlGVhQ8vL5DdQf8TRId9vJTRs0aL2lL+I4Q==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 17.04.23 um 18:50 schrieb Sergey Organov:
> Hi Stefan,
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
>> Hi Sergey,
>>
> 
> [...]
> 
>> i had some time today to investigate this a little bit. I thought it
>> would be a good idea to use debugfs as a ugly quick hack:
>>
> 
> [...]
> 
>> Using this i was able to better compare the behavior with RXTL_DEFAULT
>> 1 (without overrun errors) and RXTL_DEFAULT 8 (with overrun errors) on
>> my i.MX6ULL test platform. After doing my usual test scenario (copy
>> some text lines to console) i got the following results:
>>
>> RXTL_DEFAULT 1
>> 21f0000.serial/stats:total_duration_us: 61
>> 21f0000.serial/stats:rx_duration_us:    36
>> 21f0000.serial/stats:tx_duration_us:    48
>> 21f0000.serial/stats:received:          28
>> 21f0000.serial/stats:send:              33
>>
>> RXTL_DEFAULT 8
>> 21f0000.serial/stats:total_duration_us: 78
>> 21f0000.serial/stats:rx_duration_us:    46
>> 21f0000.serial/stats:tx_duration_us:    47
>> 21f0000.serial/stats:received:          33
>> 21f0000.serial/stats:send:              33
>>
>> So based on the maximum of received characters on RX interrupt, i
>> consider the root cause of this issue has already been there because
>> the amount is near to the maximum of the FIFO (32 chars). So finally
>> increasing RXTL_DEFAULT makes the situation even worse by adding
>> enough latency for overrun errors.
> 
> Yep, looks like an issue.
> 
> What's the baud rate? 115200?

Correct

> If so, it means that interrupts are
> apparently blocked in your system for up to about 28/(115200/10)=2.4
> milliseconds. This is very large number, and it may negatively affect
> system performance in other places as well, I'm afraid.
> 
> Best regards,
> -- Sergey Organov
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
