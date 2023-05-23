Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00EBC7EE2D
	for <linux-serial@archiver.kernel.org>; Tue, 23 May 2023 15:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjEWPOM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 May 2023 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjEWPOB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 May 2023 11:14:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75237E72
        for <linux-serial@vger.kernel.org>; Tue, 23 May 2023 08:13:43 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6H7o-1q3fYI1H3Y-006eJT; Tue, 23 May 2023 17:12:34 +0200
Message-ID: <af86a1d9-cdf5-f72d-3aea-ced37d3e7c2b@i2se.com>
Date:   Tue, 23 May 2023 17:12:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
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
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <203ce87f-2898-eb10-2f8c-f237859d75e6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sEbmaW1JDon0+hqyoaTCNWWmbTDHXLIHs3rlX986ChIrl9Lvl2F
 H+h4G+OjM+Ns6kIH+7ZgcpAF+5uHObK0o16nqzs5h/0qHZC4ZZ3eUtrOhOhlu4aO4xqAk4Q
 FCbhMWKAmg92QylpFCSUoAsTolc9hBxhbJ38TBfFJgvWPyzDJS2kNJbdg34roTa1CatPKKM
 epGj5m545mZ4tzv8ryYAA==
UI-OutboundReport: notjunk:1;M01:P0:GH6w6FREy9M=;6S3n9umgjaGIWcy8cTLMGm960ep
 rrCKJAXIwpvPOdRFqeMJUWw10MBlIW/1NFhJ8bOlb+rELgt29/TUngMNBS+2Z+pOXjryGf0Lj
 hdqNMyg4W/SdgJYzCazCUKrWZqLkjh1V9UHx8AHbn/brvAngnOfKs42XpX0ZgpWJdVGpGn/+r
 Hk45P2yl+Qv9A7CYdYUGDVekuKhN7Fu8AyNrngum5XsyCbkwp+JP6RA4xROJi8LwZs8rUi4wj
 8LsuCzS6mWVRyBK92uE6/wMPQDFXGiQWpcoTsKOk72wnQhBVPwIOROOgYqGLDDg7XeoVUb0uY
 /WrqyYUGzdRdTF+ksFsjiHC76y/M+jb5csrdT9xxaj5IOlHl0Bog1me5aSREy4XOa/TwewMA6
 sk3aRa6DTGoQb3Br1L1pkiNGCltjZ6mFK8ooQXcqWnGrBQ3c30XswFfvk/R5IyomQ3kihbcxS
 zqRnTGEvvOZpt5zK2Dqv3Z26hAqwp0EDw0FhXJ/rnY26T7RQ+yJHjCJSO5r31Px8sdltHooFK
 nJd9w3HiwgcpRhwdUCDbSdbzxMYCD/gfL3HLtPUoZCYahjGPKgfXEU/4lHHvnbtmgrRft6L4N
 BLRtD8vtUPWDwo514xDfcgy6ihp2gSu9AKZjK6TQCgkglWK3G2TGXehGzpcHI/wwtMcDAPFsT
 hVIx9hVpS+wyyhmBW5RNWXC6h8bfS7gv6xoOx8gNWw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Thorsten,

Am 22.05.23 um 11:25 schrieb Linux regression tracking (Thorsten Leemhuis):
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Stefan, was this regression ever solved? It doesn't look like it, but
> maybe I'm missing something.
> 
> If it wasn't solved: what needs to be done to get this rolling again?

thanks for the reminder. From a user point of view this issue hasn't 
been fixed so far. For our product we just reverted the commit in a 
downstream repo.

 From my understanding there was already an issue there and the 
optimizing commit by Tomasz just make the situation worse. Unfortunately 
my time budget to investigate this issue further is exhausted, so i 
stopped working at this.

In case someone can give clear instructions to investigate this further, 
i will try to look at it in my spare time. But i cannot make any promises.

Best regards

> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
> 
