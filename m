Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFACC3DA79
	for <linux-serial@archiver.kernel.org>; Mon, 26 Dec 2022 13:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLZNMB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Dec 2022 08:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLZNMB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Dec 2022 08:12:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555882645
        for <linux-serial@vger.kernel.org>; Mon, 26 Dec 2022 05:11:59 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p9nGk-00019V-MM; Mon, 26 Dec 2022 14:11:54 +0100
Message-ID: <e153e57f-8ab5-7e06-0e9b-09b7d5299547@leemhuis.info>
Date:   Mon, 26 Dec 2022 14:11:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] earlycon: Fix compile error when SERIAL_CORE is m
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        robh@kernel.org, ztong0001@gmail.com, peter@hurleysoftware.com,
        =?UTF-8?Q?Erich_L=c3=b6w?= <Erich.Loew@outlook.com>
References: <20221020032722.3263846-1-zhangxiaoxu5@huawei.com>
 <Y1DW9Q5HLsh4kBnm@kroah.com>
 <74352a7a-2a3a-c26d-9687-c31eed699a4e@huawei.com>
 <Y2MnX4nlpKookDx5@kroah.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y2MnX4nlpKookDx5@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672060319;c99acd5f;
X-HE-SMSGID: 1p9nGk-00019V-MM
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 03.11.22 03:28, Greg KH wrote:
> On Thu, Oct 20, 2022 at 09:20:24PM +0800, zhangxiaoxu (A) wrote:
>>
>>
>> On 2022/10/20 13:04, Greg KH wrote:
>>> On Thu, Oct 20, 2022 at 11:27:22AM +0800, Zhang Xiaoxu wrote:
>>>> When set CONFIG_SERIAL_EARLYCON=y and CONFIG_SERIAL_CORE=m, there is
>>>> a compile error as below:
>>>>
>>>>    ld: vmlinux.o: in function `parse_options.constprop.0':
>>>>    earlycon.c:(.init.text+0xba5a3): undefined reference to `uart_parse_earlycon'

Zhang Xiaoxu, was this ever addressed? Doesn't look like it, but maybe I
misse dsomething. I'm asking because I noticed a regression report with
a similar failure msg:
https://bugzilla.kernel.org/show_bug.cgi?id=216847

To quote:
```
> Kernel: 6.1.1
> Observed: since 6.1.0
> Fail: "ld vmlinux" complaines on unresolved symbol"
> Tested compilers: clang 16.0.0.0 and gcc 13.0.0.0 show same picture.
> Tested link modes: standard as well as thin LTO.
> 
> Interesting: the symbol is correctly marked as module export like many others.
> But only this symbol fails at link stage.
> 
> Mitigation: compiling option "8250/16550 and compatible serial support" into the kernel.
> [...]
> Linker: ld.lld
> 
> Error messages:
> 
> LD vmlinux.o
> vmlinux.o: warning: objtool: early_init_dt_scan_memory+0x1ab: unreachable instruction
> OBJCOPY modules.builtin.modinfo
> GEN modules.builtin
> GEN .vmlinux.objs
> 
> LD      vmlinux
> ld.lld: error: undefined symbol: uart_parse_earlycon
>>>> referenced by usercopy_64.c
>>>>               vmlinux.o:(parse_options)
> 
> So the INTERESTING symbol is uart_parse_earlycon
```

Or is that a totally different issue?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

>>>> Since the SERIAL_EARLYCON use 'uart_parse_earlycon' which defined in
>>>> SERIAL_CORE, so should select rather than depends on.
>>>
>>> No, please try to never use "select".
>>>
>>>>
>>>> Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
>>>
>>> So this has been a problem for a very very long time and never been
>>> seen until now?  That feels wrong, what changed to cause this to not
>>> ever be hit before with all of the tens of thousands of random configs
>>> that have been built since this very old kernel?
>>>
>> Yes, 0fb9342d06b0 ("tty: serial: earlycon dependency") already fix the
>> same issue with add "depends on SERIAL_CORE".
>>
>> But there are some other scenarios can trigger the same issue.
>>
>> Use the config file in the bugzilla can reproduce the problem.
>> https://bugzilla.kernel.org/show_bug.cgi?id=216611
>>
>> Bisect with this config, find out the following commit introduce the issue:
>>   cdcc41a256efe8 ("tty: serial: Kconfig: Allow SERIAL_QCOM_GENI_CONSOLE to be enabled if SERIAL_QCOM_GENI is a module")
>>
>>  config SERIAL_QCOM_GENI
>>         tristate "QCOM on-chip GENI based serial port support"
>>         depends on ARCH_QCOM || COMPILE_TEST
>>         depends on QCOM_GENI_SE
>>         select SERIAL_CORE
>>
>>  config SERIAL_QCOM_GENI_CONSOLE
>>         bool "QCOM GENI Serial Console support"
>> -       depends on SERIAL_QCOM_GENI=y
>> +       depends on SERIAL_QCOM_GENI
>>         select SERIAL_CORE_CONSOLE
>>         select SERIAL_EARLYCON
>>         help
>>           Serial console driver for Qualcomm Technologies Inc's GENI based
>>           QUP hardware.
> 
> Then this is an issue with that driver Kconfig options, not with the tty
> core options.  Please fix it up there.
> 
> thanks,
> 
> greg k-h
