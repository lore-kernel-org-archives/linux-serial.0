Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E31C7EE23
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 10:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjEXKtN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 06:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjEXKtJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 06:49:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600601AC
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 03:49:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q1m32-0006BQ-9b; Wed, 24 May 2023 12:48:52 +0200
Message-ID: <80207a43-6047-4493-da5d-8bd87ef74551@leemhuis.info>
Date:   Wed, 24 May 2023 12:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Content-Language: en-US, de-DE
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
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
 <87ttw2vnn0.fsf@osv.gnss.ru>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87ttw2vnn0.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684925347;093e36d6;
X-HE-SMSGID: 1q1m32-0006BQ-9b
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 23.05.23 21:44, Sergey Organov wrote:
> "Linux regression tracking (Thorsten Leemhuis)"
> <regressions@leemhuis.info> writes:
> 
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Stefan, was this regression ever solved? It doesn't look like it, but
>> maybe I'm missing something.
>>
>> If it wasn't solved: what needs to be done to get this rolling again?
> 
> Not Stefan,

Thx to both you and Stefan for the update.

> but as far as I can tell, the problem is that on Stefan's
> build the kernel has rather large periods of interrupts being disabled,
> so any attempt to decrease IRQs frequency from UART by raising FIFO IRQ
> threshold causes "regression" that manifests itself as missing
> characters on receive. I'm not sure if it's tuning FIFO level that is in
> fact a regression in this case.

Not totally sure, but I guess Linus stance in this case would be along
the lines of "commit 7a637784d517 made an existing issue worse; either
the people involved in it fix it, or we revert that commit[1], as it's
causing a regression". At least we *iirc* had situations he handled like
that.

[1] of course unless a revert would cause regressions for others --
which i guess might be the case here, as that was added in 5.18 already.
So let's not bring Linus in.

> Solving this would need to identify the cause of interrupts being
> disabled for prolonged times, and nobody volunteered to investigate this
> further. 

Well, Stefan kind of did to do so in his spare time, but asked for
"clear instructions to investigate this further". Could you maybe
provide those? If not: who could?

> One suspect, the Linux serial console, has been likely excluded
> already though, as not actually being in use for printk() output.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
