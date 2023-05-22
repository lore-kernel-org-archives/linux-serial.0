Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CDCC7EE26
	for <linux-serial@archiver.kernel.org>; Mon, 22 May 2023 09:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjEVJ0G (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 May 2023 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEVJ0G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 May 2023 05:26:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4370B3
        for <linux-serial@vger.kernel.org>; Mon, 22 May 2023 02:26:01 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q11ne-0004q1-HI; Mon, 22 May 2023 11:25:54 +0200
Message-ID: <203ce87f-2898-eb10-2f8c-f237859d75e6@leemhuis.info>
Date:   Mon, 22 May 2023 11:25:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Content-Language: en-US, de-DE
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Sergey Organov <sorganov@gmail.com>
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
 <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
 <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
 <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com> <87mt3ynsa7.fsf@osv.gnss.ru>
 <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com> <87sfcy8ncu.fsf@osv.gnss.ru>
 <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684747561;217653c7;
X-HE-SMSGID: 1q11ne-0004q1-HI
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Stefan, was this regression ever solved? It doesn't look like it, but
maybe I'm missing something.

If it wasn't solved: what needs to be done to get this rolling again?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 18.04.23 18:16, Stefan Wahren wrote:
> Hi Sergey,
> 
> Am 17.04.23 um 18:50 schrieb Sergey Organov:
>> Hi Stefan,
>>
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>>> Hi Sergey,
>>>
>>
>> [...]
>>
>>> i had some time today to investigate this a little bit. I thought it
>>> would be a good idea to use debugfs as a ugly quick hack:
>>>
>>
>> [...]
>>
>>> Using this i was able to better compare the behavior with RXTL_DEFAULT
>>> 1 (without overrun errors) and RXTL_DEFAULT 8 (with overrun errors) on
>>> my i.MX6ULL test platform. After doing my usual test scenario (copy
>>> some text lines to console) i got the following results:
>>>
>>> RXTL_DEFAULT 1
>>> 21f0000.serial/stats:total_duration_us: 61
>>> 21f0000.serial/stats:rx_duration_us:    36
>>> 21f0000.serial/stats:tx_duration_us:    48
>>> 21f0000.serial/stats:received:          28
>>> 21f0000.serial/stats:send:              33
>>>
>>> RXTL_DEFAULT 8
>>> 21f0000.serial/stats:total_duration_us: 78
>>> 21f0000.serial/stats:rx_duration_us:    46
>>> 21f0000.serial/stats:tx_duration_us:    47
>>> 21f0000.serial/stats:received:          33
>>> 21f0000.serial/stats:send:              33
>>>
>>> So based on the maximum of received characters on RX interrupt, i
>>> consider the root cause of this issue has already been there because
>>> the amount is near to the maximum of the FIFO (32 chars). So finally
>>> increasing RXTL_DEFAULT makes the situation even worse by adding
>>> enough latency for overrun errors.
>>
>> Yep, looks like an issue.
>>
>> What's the baud rate? 115200? If so, it means that interrupts are
>> apparently blocked in your system for up to about 28/(115200/10)=2.4
>> milliseconds. This is very large number, and it may negatively affect
>> system performance in other places as well, I'm afraid.
> 
> i forgot to mention that i also measured the time around
> printk_safe_(enter|exit)_irqsave in console_emit_next_record() which had
> a maximum of 24721 µs. But uncommenting these functions doesn't fixed
> the problem. This seems to be used only by printk.
> 
> Best regards
> 
>>
>> Best regards,
>> -- Sergey Organov
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
