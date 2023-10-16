Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C269CDB474
	for <linux-serial@archiver.kernel.org>; Mon, 16 Oct 2023 08:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJPIsa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJPIsa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 04:48:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858559B
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 01:48:27 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qsJH0-00014n-1j; Mon, 16 Oct 2023 10:48:26 +0200
Message-ID: <edd0bc66-b4b3-4c12-a4b9-25a7357f38d7@leemhuis.info>
Date:   Mon, 16 Oct 2023 10:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: serial: 8250_omap: error during suspend if
 no_console_suspend is set
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     linux-serial@vger.kernel.org, thomas.richard@bootlin.com
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <8a856171-e743-737e-eb9d-42852e4e4f19@bootlin.com>
 <33bf96d0-fbe0-dfb4-a791-233f49f9080d@leemhuis.info>
In-Reply-To: <33bf96d0-fbe0-dfb4-a791-233f49f9080d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697446107;6e0bb11c;
X-HE-SMSGID: 1qsJH0-00014n-1j
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 20.09.23 16:36, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 14.09.23 18:26, Thomas Richard wrote:
>>
>> After switching to Linux 6.6-rc1, i met an issue during suspend to idle
>> with 8250_omap driver (no_console_suspend is set).
>> The driver fails to suspend the uart port used for the serial console so
>> the suspend sequence is stopped.

#regzbot fix: 560706eff7c8e5621b0
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
