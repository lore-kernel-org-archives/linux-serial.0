Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0CEB64D7
	for <linux-serial@archiver.kernel.org>; Tue, 20 Jun 2023 14:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjFTOrR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjFTOrQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Jun 2023 10:47:16 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D521B7
        for <linux-serial@vger.kernel.org>; Tue, 20 Jun 2023 07:47:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBcdT-00050I-K2; Tue, 20 Jun 2023 16:47:11 +0200
Message-ID: <3853881c-976f-dadc-b64b-4ffd8cc88cf0@leemhuis.info>
Date:   Tue, 20 Jun 2023 16:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Content-Language: en-US, de-DE
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
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
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <d1b6209d-a174-406a-cc81-86b391940c0c@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687272435;55254714;
X-HE-SMSGID: 1qBcdT-00050I-K2
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 24.05.23 15:07, Stefan Wahren wrote:
> 
> Am 23.05.23 um 21:44 schrieb Sergey Organov:
>> "Linux regression tracking (Thorsten Leemhuis)"
>> <regressions@leemhuis.info> writes:
>>
>> Solving this would need to identify the cause of interrupts being
>> disabled for prolonged times, and nobody volunteered to investigate this
>> further. One suspect, the Linux serial console, has been likely excluded
>> already though, as not actually being in use for printk() output.
>>
> 
> I don't think that we can exclude the serial console as a whole, i never
> made such a observation. But at least we can exclude kernel logging on
> the debug UART.

Stefan, just wondering: was this ever addressed upstream? I assume it's
not, just wanted to be sure.

I'm a bit unsure what to do with this and consider asking Greg for
advice, as he applied the patch. On one hand it's *IMHO* clearly a
regression (but for the record,  some people involved in the discussion
claim it's not). OTOH the culprit was applied more than a year ago now,
so reverting it might cause more trouble than it's worth at this point,
as that could lead to regressions for other users.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
