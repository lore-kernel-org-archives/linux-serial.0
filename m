Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B570AEB64D7
	for <linux-serial@archiver.kernel.org>; Wed, 21 Jun 2023 06:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjFUGYL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Jun 2023 02:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFUGYK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Jun 2023 02:24:10 -0400
X-Greylist: delayed 50006 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 23:24:09 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25249B4
        for <linux-serial@vger.kernel.org>; Tue, 20 Jun 2023 23:24:08 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.63]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MacjC-1peBC32RsQ-00c8CR; Wed, 21 Jun 2023 08:23:41 +0200
Message-ID: <85d374a9-37c7-5980-3151-1ee32d35a550@i2se.com>
Date:   Wed, 21 Jun 2023 08:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
 <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
 <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
 <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com> <87mt3ynsa7.fsf@osv.gnss.ru>
 <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com> <87sfcy8ncu.fsf@osv.gnss.ru>
 <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
 <203ce87f-2898-eb10-2f8c-f237859d75e6@leemhuis.info>
 <87ttw2vnn0.fsf@osv.gnss.ru> <d1b6209d-a174-406a-cc81-86b391940c0c@i2se.com>
 <3853881c-976f-dadc-b64b-4ffd8cc88cf0@leemhuis.info>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <3853881c-976f-dadc-b64b-4ffd8cc88cf0@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i6JjwkvxW/zbBPIQIrQuc/udIDRD7ls3eBSxT6F18PKPPIydutd
 lhO0SZ8zyswwg9clYBgPkNr3NFG3zbTf+vpOO08xuSnZ4xx2gM6JlaMXXaN4GmfadtSydQh
 puoyqcZd2jONSOf14Gtbt9x6e0E8IuD7BBRElYkTG4MXoyUPKeDNyVtvwApoXYZG/jvUWUT
 X4q7ogtPZ2vP5nB8pS9OQ==
UI-OutboundReport: notjunk:1;M01:P0:s5fngwyW5Xc=;VqpgxXUTsZQEYsdtXNvH4ARVqEx
 lbMHRL2w9Nn0F91TK5jGXY6bcKwzUbPwQk3psyzTNTKFAGdvbcGC9jRSrGew13q2nfaMiBYrM
 65zShde8//TvNIPkzW0qlKcjoqO+K8KU8lD9ZfaEGtKlt+1uhz63xmGdVpXnfCH4EDCI++C4n
 qQCwl7PfIhoKRG61zdPoGP2omfBiwEOTe7SglQB3iYbO7QXyKCzF9BxHC7GFUBDuv8harda41
 vQsEuz3l6itgBv9Nx1UfI6GwW0PA0161jFzQKQQ0HU1pFIjgbWtulw9QWhJkF/xJS+4rlUeGM
 Q/Z2VrW7bVkfhabxAvG5+9vH4L0jChzafMEE77HvAu0lgVOdJCYXVUt2NJKZBH/Uxy71Axk2j
 LFHiz9rgZz99zv5jhT3RXWCQZqAgBlvANQ+lZjW39smgh8SwLYssCj2aWnoa0l13/oqDGb+8+
 8UGcnZevyzPwgFcr1kR8gXt4i/1jACLY2WqYKbBOYH6vCXjiAXfvmchc+8zmASl9auzWIgTTJ
 XQlnSlyEMGq9LoIC1uW3A+WD4hfcEXb7nG7VDZthDJ9JsN56h3DvnQPryVwHVmlfkfcezhd5k
 HUZSG/+DJXWRi6ZwfxW4Tf9VjUasA8jr/oGDg9iNa2LUpexx253kI/757IYo3iHw0ABSgTjFk
 MnWTyBkTsX+k+cbPVclpDsiYIE4LG71/CnyIExAyCw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Thorsten,

Am 20.06.23 um 16:47 schrieb Linux regression tracking (Thorsten Leemhuis):
> On 24.05.23 15:07, Stefan Wahren wrote:
>>
>> Am 23.05.23 um 21:44 schrieb Sergey Organov:
>>> "Linux regression tracking (Thorsten Leemhuis)"
>>> <regressions@leemhuis.info> writes:
>>>
>>> Solving this would need to identify the cause of interrupts being
>>> disabled for prolonged times, and nobody volunteered to investigate this
>>> further. One suspect, the Linux serial console, has been likely excluded
>>> already though, as not actually being in use for printk() output.
>>>
>>
>> I don't think that we can exclude the serial console as a whole, i never
>> made such a observation. But at least we can exclude kernel logging on
>> the debug UART.
> 
> Stefan, just wondering: was this ever addressed upstream? I assume it's
> not, just wanted to be sure.
> 
> I'm a bit unsure what to do with this and consider asking Greg for
> advice, as he applied the patch. On one hand it's *IMHO* clearly a
> regression (but for the record,  some people involved in the discussion
> claim it's not). OTOH the culprit was applied more than a year ago now,
> so reverting it might cause more trouble than it's worth at this point,
> as that could lead to regressions for other users.

thanks for tracking this issue, but in my opinion the discussion goes in 
circles. So i don't see a point in reanimating this again.

Articles like [1] suggests me this is a general issue.

Best regards

[1] - https://www.phoronix.com/news/Printk-Threaded-Atomic-v1

> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
