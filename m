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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892C8C63777
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E533F208C3
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSumSqVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgKYI6Z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgKYI6Y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Nov 2020 03:58:24 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6BC0613D4
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2020 00:58:23 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id z1so1469342ljn.4
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2020 00:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Jti7ekh8j2X3cg3hxH19wL6lxMhKXipjQ+TDBLSaqA=;
        b=mSumSqVnvNvoqkhuUUrxnbDZP4kwdliWEcLKXvJU4r247Espof9Eh1kbkAy0f8f2Ro
         75odOlw+JlWa5s5t5cn39qgZtVRvj+pb6hm/d2Wmm4c7oHM62Ay/xw3J8I9b4/jUuWfi
         j+ORJAmjdly7swy00muEBlqOF89GJZsAD/P7R3HNRFfajiV+vFLsXVZpVPtqIda2Opa8
         iEMLdLoROI57Jg3IJPDQ1QQSbOf25eDIe9jrFLWi5RrmdEAv95TmQ2fAtCFFJ+uvzPwA
         agmHBujIXdz4pEc84iDeLz6EnI5YvYNfHn4xpNPpbpxpYaFih96BUCmD08/aPGisqFXy
         ynwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Jti7ekh8j2X3cg3hxH19wL6lxMhKXipjQ+TDBLSaqA=;
        b=uXK4vgX9bvxa0Ck7CEcrFbqMiBuE4lZbIv0WnGeW3AoAgEqMR96tkPEPTuqyDKltQI
         +8I8Yl/l/DNQDFtS7U3bwoisO1+9VperRsVjZ/J7S6+fZOjMVOwXllPJ1Hw+v7GRsCyJ
         UfXMtVGJPE3lA7oxQatKCqVzyMBjSGP/5Y9KIbHqheOIXTYBcZmk44TD41X1oN9qEHOi
         +DKpxV13fDo7mwudRP14KFZvLDINyKmr3+lpRmJ64PEqh2n3J235lHdEyjdo6g+oGMr+
         t85RmtNSAi8Wx8ed+Rb6KQiei5xLBl5XuViuCn1qF4X+b0bbekhuNv9+XOpRLCGBu199
         gG4g==
X-Gm-Message-State: AOAM533Ws6YsoqsDi2KDOd9V2GC/ep+SHtb0Yee0+S6Ky8sq5TlJ77lG
        ArGs7BY6tTaO2rG4wzaNPOw=
X-Google-Smtp-Source: ABdhPJw9tjCW1mExah/3zI1W285462023HuTq4M+ttY4QVeU8uZbGd3RkLziCGzgbIzdtHJGG8ciFw==
X-Received: by 2002:a2e:81d2:: with SMTP id s18mr1012964ljg.272.1606294702107;
        Wed, 25 Nov 2020 00:58:22 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id p19sm149720lfh.82.2020.11.25.00.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 00:58:21 -0800 (PST)
Subject: Re: [PATCH] tty: serial: bcm63xx: allow building on ARM64
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201125081352.25409-1-zajec5@gmail.com>
 <X74Uanu26sx4Hait@kroah.com> <6b107933-9ab1-7c46-c383-ed39b71b4ecb@gmail.com>
 <X74bxfji0uTZV8y9@kroah.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <8ad5aea0-bf47-acde-2c96-e15d59a2bf54@gmail.com>
Date:   Wed, 25 Nov 2020 09:58:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <X74bxfji0uTZV8y9@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25.11.2020 09:54, Greg Kroah-Hartman wrote:
> On Wed, Nov 25, 2020 at 09:38:50AM +0100, Rafał Miłecki wrote:
>> On 25.11.2020 09:23, Greg Kroah-Hartman wrote:
>>> On Wed, Nov 25, 2020 at 09:13:52AM +0100, Rafał Miłecki wrote:
>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
>>>> is ARM64.
>>>>
>>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>>> ---
>>>>    drivers/tty/serial/Kconfig | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>> index 28f22e58639c..6907c5b17a0e 100644
>>>> --- a/drivers/tty/serial/Kconfig
>>>> +++ b/drivers/tty/serial/Kconfig
>>>> @@ -1133,7 +1133,8 @@ config SERIAL_TIMBERDALE
>>>>    config SERIAL_BCM63XX
>>>>    	tristate "Broadcom BCM63xx/BCM33xx UART support"
>>>>    	select SERIAL_CORE
>>>> -	depends on MIPS || ARM || COMPILE_TEST
>>>> +	depends on MIPS || ARM || ARM64 || COMPILE_TEST
>>>
>>> Why do we have an arch dependancy at all now?
>>
>>  From my experience "depends" is often used to limit symbol visibility to
>> applicable platforms only. I don't think Broadcom has any x86, risc, etc.
>> platforms so it's useless there.
>>
>> As for testing driver compilation on unused arch-s I thought that's what
>> COMPILE_TEST is for.
>>
>> Am I wrong there? I'm afraid we don't have clear Documentation on that.
>> Please kindly point me to some info if I'm wrong.
> 
> If COMPILE_TEST is working for this driver, then trying to restrict it
> to a specific arch is usually pointless and the arch dependency can be
> removed, keeping patches like this from having to be made over time to
> add it to new arches :)
> 
>>>> +	default ARCH_BCM4908
>>>
>>> Really?  I thought we were getting rid of these "ARCH_platform_type" of
>>> things.  That's what a defconfig file is for, right?
>>
>> I had to miss something, last time I checked Linus called defconfigs a
>> garbage and wanted to get rid of them:
>> https://lwn.net/Articles/391372/
>>
>> There are also no platform defconfigs in arch/arm64/ at all. Should I
>> handle it with arch/arm64/Kconfig.platforms and "select SERIAL_BCM63XX"?
> 
> I thought we were trying to get rid of arm64 "platforms" as well.  My
> point being, why is this needed at all?

I find it useful for getting working kernel config for buildoot. It's
simpler to look in arch/ than either:
1. Getting list of all required drivers manually (by looking at DT?)
2. Checking for config used by OpenWrt
3. Checking for config used by Linaro
4. Checking for config used by Foo
