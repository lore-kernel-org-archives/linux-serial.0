Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C124AEB64DC
	for <linux-serial@archiver.kernel.org>; Wed, 21 Jun 2023 13:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFUNmX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFUNmX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Jun 2023 09:42:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0D1712
        for <linux-serial@vger.kernel.org>; Wed, 21 Jun 2023 06:42:21 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBy6B-000289-S1; Wed, 21 Jun 2023 15:42:15 +0200
Message-ID: <f27d47e9-96c9-a711-1e46-a0201b13e47c@leemhuis.info>
Date:   Wed, 21 Jun 2023 15:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Content-Language: en-US, de-DE
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
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
 <85d374a9-37c7-5980-3151-1ee32d35a550@i2se.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <85d374a9-37c7-5980-3151-1ee32d35a550@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687354941;a1a9ddf7;
X-HE-SMSGID: 1qBy6B-000289-S1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21.06.23 08:23, Stefan Wahren wrote:
> Am 20.06.23 um 16:47 schrieb Linux regression tracking (Thorsten Leemhuis):
>> On 24.05.23 15:07, Stefan Wahren wrote:
>>>
>>> Am 23.05.23 um 21:44 schrieb Sergey Organov:
>>>> "Linux regression tracking (Thorsten Leemhuis)"
>>>> <regressions@leemhuis.info> writes:
>>>>
>>>> Solving this would need to identify the cause of interrupts being
>>>> disabled for prolonged times, and nobody volunteered to investigate
>>>> this
>>>> further. One suspect, the Linux serial console, has been likely
>>>> excluded
>>>> already though, as not actually being in use for printk() output.
>>>
>>> I don't think that we can exclude the serial console as a whole, i never
>>> made such a observation. But at least we can exclude kernel logging on
>>> the debug UART.
>>
>> Stefan, just wondering: was this ever addressed upstream? I assume it's
>> not, just wanted to be sure.
>>
>> I'm a bit unsure what to do with this and consider asking Greg for
>> advice, as he applied the patch. On one hand it's *IMHO* clearly a
>> regression (but for the record,  some people involved in the discussion
>> claim it's not). OTOH the culprit was applied more than a year ago now,
>> so reverting it might cause more trouble than it's worth at this point,
>> as that could lead to regressions for other users.
> 
> thanks for tracking this issue, but in my opinion the discussion goes in
> circles. So i don't see a point in reanimating this again.  [...]

Yup. Sadly. I don't think Linus would agree with the "this is not a
regression" claim from various people here. But well, due to your
statement, Gregs mail from earlier today, and the fact that reverting
the culprit at this point might lead to regression that would hit more
people, I agree:

#regzbot inconclusive: unresolved, but stuck, and revert likely a bad
option - and reporter is fine with not perusing this further

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
