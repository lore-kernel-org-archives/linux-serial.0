Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936E8C77B7A
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 11:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjEXLUx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEXLUw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 07:20:52 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD4C5
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 04:20:50 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q1mXv-0006TT-Nh; Wed, 24 May 2023 13:20:47 +0200
Message-ID: <e9b1039c-253f-d7be-fcf3-40fdbddd53d9@leemhuis.info>
Date:   Wed, 24 May 2023 13:20:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Possible regression in 8250_dw driver
Content-Language: en-US, de-DE
To:     Richard Tresidder <rtresidd@electromag.com.au>,
        linux-serial@vger.kernel.org
References: <f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684927250;ce0a9fb6;
X-HE-SMSGID: 1q1mXv-0006TT-Nh
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 23.05.23 10:59, Richard Tresidder wrote:
>    We seem to be getting corruption of received data from a ublox GPS unit
> To me it looks like a fifo overrun of some sort??
> 
> background:
> I'm attempting to use 6.3.3 as a new base for one of our systems.
> Previously it was using 5.1.7 as a base.
> The uart in question is one of the two in the Cyclone V SOC HPS.
> And to muddy the waters the linux console TTYS0 is the other Uart from
> the same HPS core
> Yet the console appears to be working ok.
> Note all other libs and apps are at the same revision and build, it is
> only the kernel that is different.
> Both versions of the kernel are also built using the same bitbake bsdk..
> 
> Seeing the following with 6.3.3:
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 57e9af7831dcf211c5c689c2a
#regzbot title serial: 8250_dma: data corruption with ublox GPS unit
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
