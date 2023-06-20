Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574E6EB64D7
	for <linux-serial@archiver.kernel.org>; Tue, 20 Jun 2023 16:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjFTQgy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Jun 2023 12:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjFTQgo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Jun 2023 12:36:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570741FC4
        for <linux-serial@vger.kernel.org>; Tue, 20 Jun 2023 09:36:21 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.63]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mv3I0-1ptqNK0mzw-00r2Uk; Tue, 20 Jun 2023 18:30:06 +0200
Message-ID: <ce8ab025-cdc9-b3fc-7628-0ea2018d4561@i2se.com>
Date:   Tue, 20 Jun 2023 18:30:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
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
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <2023062046-jersey-facecloth-7a5d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Hvg1nnR0gyMueJiif3E6u1lqHozMUmRuFvcyxVqpIgO5/1Nb8pt
 OCkvLOL6vuotxFRGWzrjdjpQfdZKf6rqPjaQHy7wBn6Aq35wObVlER9YchE3/UCwtAYID2h
 z7RivhmDWvhwV4MdpBnLLgDOh7y2foHhtLVd3saNe1vYUbqpwuH8brvS6PvDJkDoZNYj4LW
 Nr/yM20REJIhwK0ziYyMA==
UI-OutboundReport: notjunk:1;M01:P0:4s+PmxfMN8c=;2u5KYq3BHp89e3zSgDJOl6MFjdD
 iH3m18tcIk33FJ0QkXg+6lsGx3aq79mPRMTZMTzEbTZFSLe91vJaW1zwjDmi2pYWbdOoabrrA
 PATAPvJgDYyVYOyoy3+WSSX9no+qT7Vaohg4CyQaCORuZLgdtOLhn9+2CU1CldQwmAIvwfug8
 aJsURs6l6fQtMTF3op434hn/WFjAMZH+QhJskC3XmNs84aKL/lWytNB+v+g6mAlgwIxJ16LQO
 1HOWF0U/uTODIb96BJd5cNorKVdxXQeg6g9QQKKFb+p5bnYQDuvJNWQMY1FuJBUOntLTdudy9
 YxggwHzbbajQAd49AZ42L1KZ6rhMq2jTpmrwb+ErZUJiHDO7nzcCT+qRmKeSQZPiQZsPEhjcM
 OV0IFQCE+YQOYjez0Ot1C2DPRQKPx3FVBfjtR8JRChcY5fM6K4zTp/gWTSQM4sOirmrbUogPA
 odYXvISIeHlgAv81GrOcjJgJebS+tTFjzTCICjgGwedYotwYYiBDUzFFcs+rVnF567RYl2GW4
 Ra05GTxF/3E5rkRp31LwpLiHHq5lird4NKLWTpWqxNuMCymtmU7AvEBE7+SjOZzOqvHoVPBwR
 vdsi/YuqszGfaxBn+RImOMJUaT2YKlQScOKBwXJ2qUgF/DgkOZ4O84QR4qmXYRLzJuPzdUSqX
 ngQUJsKXAdHWq2CvHS6PL2bEbr8bTxLaiK+oOenI1w==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

Am 20.06.23 um 16:59 schrieb Greg Kroah-Hartman:
> On Tue, Jun 20, 2023 at 04:47:10PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 24.05.23 15:07, Stefan Wahren wrote:
>>>
>>> Am 23.05.23 um 21:44 schrieb Sergey Organov:
>>>> "Linux regression tracking (Thorsten Leemhuis)"
>>>> <regressions@leemhuis.info> writes:
>>>>
>>>> Solving this would need to identify the cause of interrupts being
>>>> disabled for prolonged times, and nobody volunteered to investigate this
>>>> further. One suspect, the Linux serial console, has been likely excluded
>>>> already though, as not actually being in use for printk() output.
>>>>
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
>> regression (but for the record,  some people involved in the discussion
>> claim it's not). OTOH the culprit was applied more than a year ago now,
>> so reverting it might cause more trouble than it's worth at this point,
>> as that could lead to regressions for other users.
> 
> I'll be glad to revert this, but for some reason I thought that someone
> was working on a "real fix" here.  Stefan, is that not the case?

i can only repeat the statements from 23.5.:

Unfortunately my time budget to investigate this issue further is 
exhausted, so i stopped working at this.

In case someone can give clear instructions to investigate this further, 
i will try to look at it in my spare time. But i cannot make any promises.

I'm not aware that some else is working on this.

Best regards

> 
> thanks,
> 
> greg k-h
