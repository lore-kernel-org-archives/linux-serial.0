Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DA4C77B7D
	for <linux-serial@archiver.kernel.org>; Tue, 18 Apr 2023 16:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjDRQXU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Apr 2023 12:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjDRQXJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Apr 2023 12:23:09 -0400
X-Greylist: delayed 326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 09:22:49 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC783A5CD
        for <linux-serial@vger.kernel.org>; Tue, 18 Apr 2023 09:22:49 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mz9hF-1qajnb367X-00wGzH; Tue, 18 Apr 2023 18:16:36 +0200
Message-ID: <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
Date:   Tue, 18 Apr 2023 18:16:34 +0200
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
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TWJ6CDAn732QR4+ItVKpPbc4PPAmXeKnmSzB503BRmaNe7KyLcq
 3pi8LSsmB4dDqAHj/a5dTpC6KwnDu0KW0tzK0FahWUIPPqVLnTHwJm0euWA//YujNPlJ734
 ESMvQgGiKMON06w6Ci56dieub61vMgx9S01/OSgPWTb3owgfsR7ElJPMIx2U4CQosGORTy3
 Pm9rJkBumpMNKPjTJC4Vg==
UI-OutboundReport: notjunk:1;M01:P0:WCz/lx8+YIg=;xTjm4L/jzSNpSyPSgc2AWPWQOxN
 dTe7Ma/2czpNRJaioTnQTP9k7F0pPJFJljh9PrrJ9w6y2oVhLA8fEUw3UxHQDgG+aQeKJX24Y
 QLLNByNHwi24Qfd4LvdSQBS9p5wmt56ig2Kd+/Vnz/EBkRHlHrNyKs3nocApOuPXa6ttB6xSy
 1va1oq+TByMf4V3DATtKKPTkEbJFe8It6VBzwofA5Kl6+1Vrpyxl80Xbkyde5P5mfaQTkGEM5
 TQGD18uhHgo89e/+4/KafWuwyw+g6lpfw5AYKc+rXgC/WyA70/Q95Ykcq1qScF3E5APl8PGRW
 bRt2OHJ1fD5OOXrkggz5xtPFloYh880o5Fs+WvTa83wKXdVpRtiL0LeX9eOI4u4A1FjzSCfsq
 MzNMkMLPM/qwl1fR3jSCRh1wEqkxAlAT9WuuYn+jlUbRxmJcfPN3JLyjvMkN81OJKYK/dt3at
 Hnd13HZP6+HsEcQK4qb//ROL+6SwGDz7+XmfbLnwWtfzXkv2SriTVlGRemWnkZUlXzvP9VPFI
 sPd/8aUhFHSyQWMby8S+UPV7/OOMKTDawY5BqL22o6zTxU3D6FCUtXvRAkZbNYK9MnGYYv6Iz
 ExYT0o8wq2mKmdSyMI8hnFdblY1t67Kb/m6r9seIXXTGeo4eVRlrPGTH8DTyqjIygFptU5e3o
 8vB9FDQyfR8vXTWz/UMwTf92DxPO8zHu/SIhbEyk9g==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sergey,

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
> What's the baud rate? 115200? If so, it means that interrupts are
> apparently blocked in your system for up to about 28/(115200/10)=2.4
> milliseconds. This is very large number, and it may negatively affect
> system performance in other places as well, I'm afraid.

i forgot to mention that i also measured the time around 
printk_safe_(enter|exit)_irqsave in console_emit_next_record() which had 
a maximum of 24721 µs. But uncommenting these functions doesn't fixed 
the problem. This seems to be used only by printk.

Best regards

> 
> Best regards,
> -- Sergey Organov
