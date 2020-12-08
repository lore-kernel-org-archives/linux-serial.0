Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA99C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 11:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C4923AAA
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 11:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgLHLAg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Dec 2020 06:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgLHLAg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Dec 2020 06:00:36 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7CC0613D6
        for <linux-serial@vger.kernel.org>; Tue,  8 Dec 2020 02:59:55 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y19so10277992lfa.13
        for <linux-serial@vger.kernel.org>; Tue, 08 Dec 2020 02:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4tYnT/iTZzYz2r3ZWJTvMZ+4drGUcytTPp1FSw6X98Y=;
        b=BELUBXUhd4l304VMFRYo1PhnML7NqviuuakosxXt9A960Ad51uyOyQSUKAhzZ+Amns
         Hje6S/SRqMXfp2U2n1AhdxrbNof2+yrqFPOQRnlLyACD2G/tvdubOU+ksvk5gspciY9W
         G4kfhqjsE8cZFEyboGWlLKyLvIHwi/2Nrk9XNSGhIeD6+7/LBl0ySkDF2RcPYMme6x25
         XIqTHM6p7i2XUDC8IhsGeeCiary1Dpq7i9Cy0PcInBx8viIvI4rVIOfgOQ0pYkk/CIa2
         WMh1nodsrfGAEkzkZCQS1cd0ydhyGbywjQhwJ70UkQsAAA51CICqBZG7lJo9hnP4U9Lx
         ZOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4tYnT/iTZzYz2r3ZWJTvMZ+4drGUcytTPp1FSw6X98Y=;
        b=pRjldxwRDn5ACtxiAeTD8+v8skemKz1HOW/heRWievcI5tfb3qje2q8/r7CF5TPU1J
         pYQaNfXpATupfN+FxuE+6XrjhPgqSymSVgFgVcFiuW6drpHCPgB9EcQN7Bipq9+7VtlN
         wfUFE5A7oG27tUhFxJXU2ELNp33wWQ9HufkzaQRThZZRzLk4CLObr7umXyDLbSdhU7bN
         oS1atPOqkmQmxH+Vh0FFHBFL/iLh5VVTRG5+ksTG1scBgXw7QwqtyILIEH7ts+X9F1iR
         G38lOWt4SBA4kesE0p5y89JllUKnMCuWI+xMdSL5gsFPcYlE+0e8JODz8YjBTJYPHt0a
         q4Pw==
X-Gm-Message-State: AOAM531RjOEfEO7fYuTZXPzkkbRLw/RDab0flPu9eSnik3qY8yZUMQbg
        zIeupWUNi0a8210mLu9zpnqrgAsvqHc=
X-Google-Smtp-Source: ABdhPJyx9hA7cGd2hFSTGW9iwudiO8nn6rTkwHcZWEugJfXTzZ69e4zE7wQIdIfJ6fuqXlY4zNS91w==
X-Received: by 2002:ac2:47f4:: with SMTP id b20mr10736439lfp.339.1607425194050;
        Tue, 08 Dec 2020 02:59:54 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id c136sm629905lfg.306.2020.12.08.02.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 02:59:53 -0800 (PST)
Subject: Re: [PATCH] tty: serial: bcm63xx: allow building on ARM64
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Arnd Bergmann <arnd@arndb.de>
References: <20201125081352.25409-1-zajec5@gmail.com>
 <X74Uanu26sx4Hait@kroah.com> <6b107933-9ab1-7c46-c383-ed39b71b4ecb@gmail.com>
 <X74bxfji0uTZV8y9@kroah.com>
 <CAMuHMdXA+B_=abXAzCt5m3djjhLpzuDEtEhF_8UYkm95hu_4PA@mail.gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <805a393a-73c2-6016-da65-681ddbebebb3@gmail.com>
Date:   Tue, 8 Dec 2020 11:59:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXA+B_=abXAzCt5m3djjhLpzuDEtEhF_8UYkm95hu_4PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[Scroll down]

On 08.12.2020 11:45, Geert Uytterhoeven wrote:
> On Wed, Nov 25, 2020 at 9:53 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Wed, Nov 25, 2020 at 09:38:50AM +0100, Rafał Miłecki wrote:
>>> On 25.11.2020 09:23, Greg Kroah-Hartman wrote:
>>>> On Wed, Nov 25, 2020 at 09:13:52AM +0100, Rafał Miłecki wrote:
>>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>>
>>>>> Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
>>>>> is ARM64.
>>>>>
>>>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>>>> ---
>>>>>    drivers/tty/serial/Kconfig | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>>> index 28f22e58639c..6907c5b17a0e 100644
>>>>> --- a/drivers/tty/serial/Kconfig
>>>>> +++ b/drivers/tty/serial/Kconfig
>>>>> @@ -1133,7 +1133,8 @@ config SERIAL_TIMBERDALE
>>>>>    config SERIAL_BCM63XX
>>>>>            tristate "Broadcom BCM63xx/BCM33xx UART support"
>>>>>            select SERIAL_CORE
>>>>> - depends on MIPS || ARM || COMPILE_TEST
>>>>> + depends on MIPS || ARM || ARM64 || COMPILE_TEST
> 
> Why not s/ARM64/ARCH_BCM4908/?
> 
>>>>
>>>> Why do we have an arch dependancy at all now?
>>>
>>>  From my experience "depends" is often used to limit symbol visibility to
>>> applicable platforms only. I don't think Broadcom has any x86, risc, etc.
>>> platforms so it's useless there.
>>>
>>> As for testing driver compilation on unused arch-s I thought that's what
>>> COMPILE_TEST is for.
>>>
>>> Am I wrong there? I'm afraid we don't have clear Documentation on that.
>>> Please kindly point me to some info if I'm wrong.
>>
>> If COMPILE_TEST is working for this driver, then trying to restrict it
>> to a specific arch is usually pointless and the arch dependency can be
>> removed, keeping patches like this from having to be made over time to
>> add it to new arches :)
>>
>>>>> + default ARCH_BCM4908
>>>>
>>>> Really?  I thought we were getting rid of these "ARCH_platform_type" of
> 
> No we are not.
> 
>>>> things.  That's what a defconfig file is for, right?
> 
> FWIW, the arm64 defconfig file enables about everything, for all arm64
> platforms.
> 
>>> I had to miss something, last time I checked Linus called defconfigs a
>>> garbage and wanted to get rid of them:
>>> https://lwn.net/Articles/391372/
>>>
>>> There are also no platform defconfigs in arch/arm64/ at all. Should I
>>> handle it with arch/arm64/Kconfig.platforms and "select SERIAL_BCM63XX"?
>>
>> I thought we were trying to get rid of arm64 "platforms" as well.  My
>> point being, why is this needed at all?
> 
> To prevent asking the user about a driver that is completely useless for
> the system(s) the user is compiling a kernel for.
> 
> Do you want to let distros compile all arm/arm64-only SoC drivers for x86, too?

Could you suggest & send some Documentation on that so we have a global rule
instead of per-tree / per-maintainer preferences, please? I'd really
appreciate that.
