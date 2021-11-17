Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739ABC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 03:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518A561B39
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 03:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhKQDzb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhKQDzb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 22:55:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1EDC061570
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2021 19:52:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h24so1202853pjq.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2021 19:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kHkL29XgFNpySl5Yq3c7u4HrTQCfeOPmtsV2Kk8kwLM=;
        b=1XTHTt8uLepNnbTg3e5Pu8g7ycS39Y9cDm9G+RcpdkZD4MEHKredXuhTIjBpa1RWFj
         ISgi+zYpBo4c7cSJZn198/4liYRkUd8qFWvo0bzhtTJskR/xGwvWz/UG189Dnwbj8FVh
         EX6jqNSd13VoFL3nhFG+PQ+WLlVQoPUCJdEGHi2V+kLfftlvv93QNo2rK/L+XoDyBtfV
         q6GJ7arWgr0jNx0+QjiXGOyDg11cgRgCYeQtRxcdrM402ctF+ws/C75FyBtAs2/94EW3
         MGbOVw58y4qoaidbIPQwCiu44DJSd4Mux5e6WiMuGqJ1GgQ/z7AqcjI8LeK2ZiBL22NS
         IEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kHkL29XgFNpySl5Yq3c7u4HrTQCfeOPmtsV2Kk8kwLM=;
        b=ps7zieBwv06Zv2CmrRRgxpphsn7IrfuQEWW1u1d4UhqopHHiLHBuvK35G/KPxxpwPO
         tJ5lIhUeCg51w42Lkm/yPSnp8UT/iDeonfFrLyDjNXhFRYnatgXCbCGJLk5+rKvvDZLe
         vvlxQFXmptln/NJt93QGdiX4qmhTgFotkfKKtNgl26VQWv+C5twFxHNcp7zP+YG52OSm
         GQZNRMSS0J7k1DdVfWlYuW/MNqtXwO0VgJVcCUOmxjxWdi8CYhjaaNLzCueLMpof/DaF
         LQjZ61i2hdK3YBAyyd4zGwJJZoME6P7Q+VrYbEw11m/GdK/xQGN8GzqIu+vjP5MFRqIq
         CLmQ==
X-Gm-Message-State: AOAM533H4dE9PwjNt0m2zVhVaKKm1xgugfDot3CBuolfrmOoGTVL073z
        +OPhp0wjmadAtqlUhoJ0jp/euL7IrgzL0+HfxVGrt4NQoKcyYttoaSdnJllfbjRxVgvogfc7gH0
        zLZJV10Gpj2Jllb/5btvaez9PHH6OURDRePw6J/uoT1Toiy1Hw7gc/yrM8IgQKEUl44nneAjJZT
        PX9U4=
X-Google-Smtp-Source: ABdhPJz6ECkHwdhWFN1FBSqtNXoEXuxOeuhYfvCU+734+4x8ONg3zvOBa+Y8m6ntVK5wJpiI8IoN8A==
X-Received: by 2002:a17:90b:3ec2:: with SMTP id rm2mr5638332pjb.1.1637121152486;
        Tue, 16 Nov 2021 19:52:32 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id lr6sm4020959pjb.0.2021.11.16.19.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 19:52:32 -0800 (PST)
Subject: Re: [PATCH 0/3] serial: 8250_pci patches to address issues with
 pericom_do_set_divisor()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20211114183908.444923-1-jay.dolan@accesio.com>
 <CAHp75VcLr8MDwQUMgeOWKLP5QwwxGzbso61xJOK7-S=UHfn11w@mail.gmail.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <401a1861-2716-04ec-ddd2-00010cc9c030@accesio.com>
Date:   Tue, 16 Nov 2021 19:52:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcLr8MDwQUMgeOWKLP5QwwxGzbso61xJOK7-S=UHfn11w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/16/21 7:34 AM, Andy Shevchenko wrote:
> On Sun, Nov 14, 2021 at 8:40 PM Jay Dolan <jay.dolan@accesio.com> wrote:
>>
>> A series patches to address three issues one customer managed to hit all at once.
>>
>> 1) Rewrite pericom_do_set_divisor() to always calc divisor and to use the
>> uartclk instead of a hard coded value. Always calculate divisor without passing
>> control to serial8250_do_set_divisor()
>> Tested with 14.7456 and 24 MHz crystals
>>
>> 2) Re-enable higher baud rates on Pericom chips.
>> serial8250_get_baud_rate() added range checking, but Pericom chips have a wider
>> range than what is being enforced. Make use of UPF_MAGIC_MULTIPLIER.
>> Tested with 14.7456 and 24 MHz crystals
>>
>> 3) Fourth port not being setup correctly on some Pericom chips.
>> Fix entries in pci_serial_quirks array
> 
> Can we start from splitting Pericom to its own file, please?
> 
> See my initial work here [1]. And I believe you may do a better job
> than me since you have access to many variants of the hardware.
> 
> [1]: https://gitlab.com/andy-shev/next/-/commit/71fdb8b5d857691031f566daebb1e850b106f46a
That would be great. Breaking it out has been on my wish list for a 
while, but I doubt I was ever going to have time. I'm not familiar with 
GitLab. Is there a way for me to fetch this branch or should I just 
apply the diff I downloaded?
> 
> (As a side note:
> https://gitlab.com/andy-shev/next/-/commit/ac0dc993fa35b5e2fe67e967b6a687b2e47d0edd)
> 
