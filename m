Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434CBEB64D8
	for <linux-serial@archiver.kernel.org>; Tue, 20 Jun 2023 16:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFTQz6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Jun 2023 12:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjFTQz4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Jun 2023 12:55:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D5E42
        for <linux-serial@vger.kernel.org>; Tue, 20 Jun 2023 09:55:54 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.63]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mc02Z-1pftFk1wNT-00dUG6; Tue, 20 Jun 2023 18:55:23 +0200
Message-ID: <b25a03d2-3916-6c98-4dac-785f335c09bc@i2se.com>
Date:   Tue, 20 Jun 2023 18:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
 <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com> <87mt3ynsa7.fsf@osv.gnss.ru>
 <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com> <87sfcy8ncu.fsf@osv.gnss.ru>
 <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
 <203ce87f-2898-eb10-2f8c-f237859d75e6@leemhuis.info>
 <87ttw2vnn0.fsf@osv.gnss.ru> <d1b6209d-a174-406a-cc81-86b391940c0c@i2se.com>
 <3853881c-976f-dadc-b64b-4ffd8cc88cf0@leemhuis.info>
 <2023062046-jersey-facecloth-7a5d@gregkh>
 <ce8ab025-cdc9-b3fc-7628-0ea2018d4561@i2se.com>
 <36f8e93b2659c7edc4d937d21b44c38e3b972d15.camel@pengutronix.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <36f8e93b2659c7edc4d937d21b44c38e3b972d15.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:l96gFm+0W7S98rXb2X03NXE2X0wRIOCxaP//XezekVtKYQNfBlf
 czV3++w04VoJdy4Ri8YtndAcmir9bg+h/DbjjAxxrYtVdlkqmI2yvyYMqCbvmhK5dVZhK3B
 XK1QviAyFqEeoCSk6S6BpHPjssWh0hOaY6do7izqx+VpSLBU0CF5ESDs5M/paTLjn/AHjVE
 nw0WH76GxqAHYOi73iumQ==
UI-OutboundReport: notjunk:1;M01:P0:2rdNJa9g/Eg=;ouds26XIRSH2squH47LNh3pA7Vk
 sNTi64NE3doclPsOoZ0o9tv+zdqpcBJXnYm4dW+TD8u2QlpXNI7G91tTkwcmbIu0HVEZxyBnz
 9uyAwxpnqmzKI/7Pk7Ipyd6a4TlOA5ywPHDW9CzKfzKcwba8z9SedYRF2hMtGi71bWOL1Kh9m
 FUJXyyo9PfwU4YS3AA1UkgqI2FID2GF/nV4aZaQ7e/fs8pAEsTnslBUIZww0Xzs0vjHSXHKq1
 HA7LuRwW+47JJUAYg9MP8nT+P8nwycJRebloJdhWmzVBRb4rJztUIhPn2r7Lxd+z85xOHN7eF
 M/Txb2u0mGT8RzKHp7bVOCEgUhy2s8OJ3AYagqgBcx5CaEBIVl3LaYOnkWyu1E2uwqIRJL9xJ
 H36gSXIxAfECdk1rgGvTXlnOxwKzD0D9ZLtoHDATXDVz7yCQ/4rGfzUUxyf0ZXyPoXBlM+0QF
 K1DlxVWYJfEdIPIAQTCFOtBwSRvSsQmUMbi8gthOFq1D864rga3AS0uzgeP6Zt8/XR8tJkkMn
 2ETk1nVujqtm0qW5Jm9BWmHL/Mc1A+a8ViXG+Yvab3mRzv9uNrKv1tzsP4beoZwVy10iMJR2e
 mulTkV600G5ATKlvVNNpyyOifRvoGlFYVMsNm+3h059UOzLoeK/Fy/WWxoerv0ANIWEH36cd1
 k2Lo8TxCStVbBQ4ajTKhWVMWd4BI6CSjMvHwY/6O4g==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lucas,

Am 20.06.23 um 18:40 schrieb Lucas Stach:
> Am Dienstag, dem 20.06.2023 um 18:30 +0200 schrieb Stefan Wahren:
>> Hi Greg,
>>
>> Am 20.06.23 um 16:59 schrieb Greg Kroah-Hartman:
>>> On Tue, Jun 20, 2023 at 04:47:10PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 24.05.23 15:07, Stefan Wahren wrote:
>>>>>
>>>>> Am 23.05.23 um 21:44 schrieb Sergey Organov:
>>>>>> "Linux regression tracking (Thorsten Leemhuis)"
>>>>>> <regressions@leemhuis.info> writes:
>>>>>>
>>>>>> Solving this would need to identify the cause of interrupts being
>>>>>> disabled for prolonged times, and nobody volunteered to investigate this
>>>>>> further. One suspect, the Linux serial console, has been likely excluded
>>>>>> already though, as not actually being in use for printk() output.
>>>>>>
>>>>>
>>>>> I don't think that we can exclude the serial console as a whole, i never
>>>>> made such a observation. But at least we can exclude kernel logging on
>>>>> the debug UART.
>>>>
>>>> Stefan, just wondering: was this ever addressed upstream? I assume it's
>>>> not, just wanted to be sure.
>>>>
>>>> I'm a bit unsure what to do with this and consider asking Greg for
>>>> advice, as he applied the patch. On one hand it's *IMHO* clearly a
>>>> regression (but for the record,  some people involved in the discussion
>>>> claim it's not). OTOH the culprit was applied more than a year ago now,
>>>> so reverting it might cause more trouble than it's worth at this point,
>>>> as that could lead to regressions for other users.
>>>
>>> I'll be glad to revert this, but for some reason I thought that someone
>>> was working on a "real fix" here.  Stefan, is that not the case?
>>
>> i can only repeat the statements from 23.5.:
>>
>> Unfortunately my time budget to investigate this issue further is
>> exhausted, so i stopped working at this.
>>
>> In case someone can give clear instructions to investigate this further,
>> i will try to look at it in my spare time. But i cannot make any promises.
>>
> If the cause is simply interrupts not being serviced for a long period
> of time, the irqsoff tracer is usually a very good start to investigate
> the issue. It might point to a smoking gun already.

thanks the hint, i can try that.

AFAIR there was a kernel comment which pointed out that console IO (or 
at least parts) is excluded from the irqoff tracer?

> 
> Regards,
> Lucas
> 
>> I'm not aware that some else is working on this.
>>
>> Best regards
>>
>>>
>>> thanks,
>>>
>>> greg k-h
>>
> 
