Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12C9C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 20:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE22613C3
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 20:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhDUUBd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244313AbhDUUBc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 16:01:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547EFC06174A;
        Wed, 21 Apr 2021 13:00:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y32so30961402pga.11;
        Wed, 21 Apr 2021 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AReDrWOEZXfvF/s6rcjOJXciEs33E3HMi3ZXRWC77ko=;
        b=d68kX1neFSgr3WmIahqpDr6edfAbLCUyJpu7m9DXUS8jZYqNAB5TdLVQHH7or34fVi
         pxkS2rfNo8HHNKGaf3E5MKTLCEnvz/O0E+O/Gq+hF/KaYplKBzTTbVzkn11HnfeVZRo6
         j7VcrYdXzblpKgbGJr10XwdqpLCFefHkJCjPNvIIKZdV676eeFtOR+XTHQ0TsZLH2/xJ
         gHZ52hTHFOGeeDV0edvImseVqO4EQAjZpR+8yRAjNyqAug+YOqezfRG0TLE+7CcNRNmn
         SyEqO8IrXaaH4o6KLBiRHRIdImgEEHBPuGqeJH/ODKRLnA+Irzc8zMKPytJHJOUXvpGH
         9cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AReDrWOEZXfvF/s6rcjOJXciEs33E3HMi3ZXRWC77ko=;
        b=Y0hbCY0GrG9dUqUaA/PBV47XqCw/9BfxYQAU99XTE17dTrtZFV5sJjCK+H6MkCdgUW
         GHuaEPOUaJuJ061swjMR9Z+EdM5w3aYAB9UtuGN5kTg0aWlo0K5DUVyQcbrHRvwF7pHw
         L0KFIv6Zq7WwFhX3TYh+bPzfHD+O9GfXdLCirvYFI8hlH6gi5b3nHFh+YECMDa8ZJRma
         vLMJNQG6kYNLe0YFMb2MdIfJhPx3IdG0MXAihxUqMkVj9xxlGYjp3z5F6th2PFb/qh9K
         p6ry+ci/Hxn2Avn4e9kHsVzttFLEaImYrqlYdZsSpeo4h/k22qLcquN3Sm5yRHrrh319
         95Pw==
X-Gm-Message-State: AOAM532mUKeE43lAz8imL8XceIefjVEgbx6u0foXbk8XIZ9pEJdU+PGL
        M1gd4cLogWZU4gwbwShYTUj1lKFRpJc=
X-Google-Smtp-Source: ABdhPJwxQt61tc581In1dq1C2NPuS3JK12hpnNEsEBCvb8dKPVhK+UJGMolqD5QaXB21oWvicKzY7Q==
X-Received: by 2002:a63:5814:: with SMTP id m20mr23532782pgb.82.1619035257402;
        Wed, 21 Apr 2021 13:00:57 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id t11sm170756pji.54.2021.04.21.13.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 13:00:56 -0700 (PDT)
Subject: Re: [-next] serial: 8250: Match legacy NS16550A UARTs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alan Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20210414134539.42332-1-alcooperx@gmail.com>
 <CAHp75VfQetCJJZ_U70xEduVBQHEx_GkHeKBs2uzNtvcq9H0BqQ@mail.gmail.com>
 <CAOGqxeUiFE0348Y=yEoD7bnMaGnFkbvNy3WZ2oSZZzR4D-xz_w@mail.gmail.com>
 <CAHp75VfD7i9irKDxk0v+j1c1wFrcu9v+OA-X7+edsg6johhJnQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <072cc4c2-9a63-312a-a4bd-b4aa6d393a7e@gmail.com>
Date:   Wed, 21 Apr 2021 13:00:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfD7i9irKDxk0v+j1c1wFrcu9v+OA-X7+edsg6johhJnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 4/21/2021 12:57 PM, Andy Shevchenko wrote:
> On Wed, Apr 21, 2021 at 10:04 PM Alan Cooper <alcooperx@gmail.com> wrote:
>> On Thu, Apr 15, 2021 at 6:44 AM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Wed, Apr 14, 2021 at 7:13 PM Al Cooper <alcooperx@gmail.com> wrote:
> 
>> The problem is that when both the 8250_of and 8250_bcm7271 drivers
>> were running, occasionally the 8250_of driver would be bound to the
>> enhanced UART instead of the 8250_bcm7271 driver. This was happening
>> because we use SCMI based clocks which come up late in initialization
>> and cause probe DEFER's when the two drivers get their clocks.
>> Occasionally the SCMI clock would become ready between the
>> 8250_bcm7271 probe and the 8250_of probe and the 8250_of driver would
>> be bound. To fix this we decided to config only our 8250_bcm7271
>> driver and added "ns16665a0" to the compatible string so the driver
>> would work on our older system.
> 
> Interesting reading.
> 
> As far as I understand the 8250 approach (*), you blacklist (or
> whatever naming you prefer, b/c 8250_of seems does not have such) the
> binding based on the presence of the specific compatible string.
> 
> I.o.w. in 8250_of you need to check if you are trying to probe the
> device which has both compatible strings. In that case you simply
> return -ENODEV.

Yes we had a downstream patch not submitted that did exactly that:

+       if (IS_ENABLED(CONFIG_SERIAL_8250_BCM7271) &&
+           of_device_is_compatible(ofdev->dev.of_node,
"brcm,bcm7271-uart"))
+               return -ENODEV;
+

but thanks to Al's findings it does not appear to be needed anymore, we
could submit it somehow if you feel like other scenarios like having
SCMI and the UART drivers as modules.
-- 
Florian
