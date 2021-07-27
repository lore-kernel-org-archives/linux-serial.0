Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D20BC4338F
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 02:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7CC60FED
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 02:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhG0CQp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 22:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbhG0CQo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 22:16:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06612C061757;
        Mon, 26 Jul 2021 19:57:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso2893327pjo.1;
        Mon, 26 Jul 2021 19:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tl3UAZ2Cc/eCMUBpbP0JXWr/l/wrFj7n/51He5le3OY=;
        b=vRhuMTfQ/GivIcUvtaE4reXjI6yYgwLgYMspVfWdKsjQZUJ4bgGC6qaVc61qXgaiMq
         xSmTW97B/Ut+GzE75OhwxrQtankL6Y9dPiVTQBDetk3kA4sIX7/qREE+jPzTTtzH4e1t
         slUqbgzYWNFQOtFJ2Rsf2ZrKdtMqiOSPs/+l7Y4c4/of7L7p0AKGXr3ae9AXmyfZpg3o
         2n6nst7RKXBXeZYwuGf1iglaFCh4Q9UfmmRhLQ+MWx4b9aEuQfjfsjXiE4H3zC1oau0n
         RyTQY0KZMdCV1PW4tbx8HhGXFxAN9TkUn2nZYGbk2BajAvkmQYnTKwHwW3tCSrK2BnE+
         dAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tl3UAZ2Cc/eCMUBpbP0JXWr/l/wrFj7n/51He5le3OY=;
        b=C0iA4A3yhn6eNMhytKTdY+a2M5y+ZO3z5H/q11seA8PdVTFUVDhDAj3BQEq5j7t8qE
         3FckDkhY/f+EbbuIkuIO9K3GaGr5sgXrjiJCIanNsSh0qUAo+R+kLLH2VCQU+Ptt34QF
         cQZyh3QQ5zHl8Q2nErtzqKO6PidsulxFvkG0LULizYNfB2r4ey+xH/2ubzmtA6uAkJb/
         ajdLrMLlefb7KMVORLGH2s01P97bFRCUbjXckJKFA12XHmDvTHLNbx8yc+GHb2DBRR6E
         CGeWGC0GHRlDHBst8CGsuMqpwQUe99KQXNAtkN7ybKoCTFt2LRMaobBvytreJiyupIUa
         KfCg==
X-Gm-Message-State: AOAM530yfyGGtHeYKCFN5aGpbohko8bGwvbLx43WAh7m5n6wmfKGwmpd
        yGz3pJqX4Re2oyRkYsCDW2s=
X-Google-Smtp-Source: ABdhPJwUXMr5p7cLkFqxHcmoBl9hrxidWsM9LFS2NWM61ibKJ0gh1cwu7kXHdnNuzwvVkbDw+4/0NQ==
X-Received: by 2002:a17:90b:4c92:: with SMTP id my18mr19726636pjb.167.1627354631568;
        Mon, 26 Jul 2021 19:57:11 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id k8sm1347028pfu.116.2021.07.26.19.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 19:57:11 -0700 (PDT)
Subject: Re: [PATCH v5] arm pl011 serial: support multi-irq request
To:     Robin Murphy <robin.murphy@arm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        gregkh@linuxfoundation.org, Bing Fan <tombinfan@tencent.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
 <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
 <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
 <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
 <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
 <290c01ec-173f-755f-788e-2a33a69586e8@quicinc.com>
 <e98962f3-9232-4abf-ec27-a7524a9e786d@arm.com>
From:   Bing Fan <hptsfb@gmail.com>
Message-ID: <bddf2712-72f4-2e20-da17-33b3de08f769@gmail.com>
Date:   Tue, 27 Jul 2021 10:57:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e98962f3-9232-4abf-ec27-a7524a9e786d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

hello,

Thanks very much for analysis. And i have get the cause of the problem.

I will add pl011_allocate_multi_irqs/pl011_release_multi_irqs functions 
for amba drivers,

and call them in pl011_startup/pl011_shutdown respectively.


Reserved pl011_allocate_irq/pl011_release_irq functions for platform 
drivers.

Please help to confirm, is this ok?





在 7/27/2021 5:14, Robin Murphy 写道:
> On 2021-07-26 21:56, Qian Cai wrote:
>>
>>
>> On 7/26/2021 4:36 PM, Robin Murphy wrote:
>>> The important point you're missing, but which the KASAN dump does 
>>> hint at, is
>>> that that is a machine with SBSA generic UARTs booting via ACPI - I 
>>> know it
>>> doesn't do DT at all because I have one too. What matters there is 
>>> that pl011
>>> binds as a platform driver, *not* an amba driver.
>>
>> Thanks for pointing out, Robin. I just yet to see an ARM server 
>> booting from DT
>> those days.
>
> Unlikely in production datacentre/cloud environments, indeed, although 
> some of the mid-range kit like LX2160 does start to blur the line of 
> what might be considered "server", and that's one example which *does* 
> have full-featured DT support (even if it also aspires to ACPI...)
>
> What I thought was worth clarifying for the general audience is that 
> the relevant aspects of "server" here should in fact still be possible 
> to reproduce on something like a Raspberry Pi or a tiny QEMU VM, if 
> one can figure out the ACPI runes :)
>
> Thanks,
> Robin.
