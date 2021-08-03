Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDC3C4320E
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 07:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B401960F8F
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 07:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhHCHlj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Aug 2021 03:41:39 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:54406
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234232AbhHCHlj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Aug 2021 03:41:39 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id B4FC43F356
        for <linux-serial@vger.kernel.org>; Tue,  3 Aug 2021 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627976487;
        bh=+1a5dSrcHG3YYcJ1yRZezWpe6zYrLOk/VkEAKrHxRTg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=hZM1oKuYoXXjCtlDqC1zI+fOcspa2MUJJFJHn48pl8TXic9mSHST/Se9VTG5jOSNP
         EntARqL3SRvX30qdeLetiKMErKKY5beKjsJGnbaCjI1ZflQpYhcxCqweCI2SQxfZLf
         2UJgjVMqarGZ67mhi+NjoNE+1Le+QUaJyECk9xCjjiSY3SIRzJ8fLU7wZRxi9K+Iwn
         g7GiH58RM+s8UnvMCxbYSSQ4+5wXxf0eC2AKV1Yua91vLCLW8CrUmnFhwJq1wiIt1I
         t1dlU0+BjM83nLB2oyiYF2lrnBnjjoFLvSZ+JEbeM1dS3li7BIZi8Nsmm0rar4+1oi
         T+/mOe4V93SXg==
Received: by mail-ed1-f71.google.com with SMTP id d6-20020a50f6860000b02903bc068b7717so10074970edn.11
        for <linux-serial@vger.kernel.org>; Tue, 03 Aug 2021 00:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+1a5dSrcHG3YYcJ1yRZezWpe6zYrLOk/VkEAKrHxRTg=;
        b=KM/dMbK20Vt2fjdwiaoJYRf8i9DTx1esA4d+AsHZYUP8Emih6niDd9odMT2MQ3o7T/
         G10E/M7wRVtjRZFEVrRi3iKLDtG2VEQi7WO7KGGebkNofCNj8azL8pOHgOAHJIVj5wc0
         biBKtRo5Pt6DqEnh4TrSgmxcH71ED8XZADVDpvxjixYQ5W7DudnAeF9CAhBxx9WkSnZY
         vbe0+IEVielBmCOOlHFYAsvDmuivbfnEPFNSxNI719IUyi+uI1wJr2jKlxkm0I/Lq0hc
         o1HbMOz65oR+3jZuiHqel3GWek5HZ/il2ZeAorHRL8k6o29Phs7IFJj6/pFlex0VaSMj
         cRCA==
X-Gm-Message-State: AOAM533kALt2HEGG/J4qFmGjQ9Tc/jIyn+o6TYXv3M3WMJyBvKS6ghSv
        oQud8wBrxs+cgH+cnXzjhupopA9wS6syplfsf/UXVrNRzzd452UUqb7XyGN5pYSl8GGdmumO3+Q
        hnJ+y7y0DCdzTbM6KAuW0jHSL1Pf0refvdvcpgoPIKw==
X-Received: by 2002:aa7:c541:: with SMTP id s1mr24485052edr.327.1627976487079;
        Tue, 03 Aug 2021 00:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwClir8KajrBwLYFa9sxs319qmqBxSIwIvjypQANqh0uaYnlV/i3vAIM/mKfxSOd8kXLutsqw==
X-Received: by 2002:aa7:c541:: with SMTP id s1mr24485042edr.327.1627976486967;
        Tue, 03 Aug 2021 00:41:26 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.43.172])
        by smtp.gmail.com with ESMTPSA id gu2sm5787222ejb.96.2021.08.03.00.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 00:41:26 -0700 (PDT)
Subject: Re: [PATCH 00/12] Add minimal support for Exynos850 SoC
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <5e35b0a7-13aa-3c62-ca49-14af2fcb2a08@canonical.com>
 <c3486111-0ec9-9679-d2a2-68b2f33a2450@canonical.com>
 <CAPLW+4kbnJEBkc0D=RWt59JxBan8X1uDy6sSXBiYAq8N9FDV6A@mail.gmail.com>
 <13f166bb-7103-25d5-35a6-8ec53a1f1817@canonical.com>
 <2dacc205-04ce-c206-a393-50ba0d5aa1a7@canonical.com>
 <CAPLW+4=1Anr6rCWEBL04D81aEAEVKD5cGE+ObXH3q-HNHce07w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0277c701-cc25-cdc5-d3b9-cf2cc2ba4de5@canonical.com>
Date:   Tue, 3 Aug 2021 09:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPLW+4=1Anr6rCWEBL04D81aEAEVKD5cGE+ObXH3q-HNHce07w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 03/08/2021 01:27, Sam Protsenko wrote:
> On Sat, 31 Jul 2021 at 11:12, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 31/07/2021 09:29, Krzysztof Kozlowski wrote:
>>> On 30/07/2021 21:02, Sam Protsenko wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On Fri, 30 Jul 2021 at 20:21, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@canonical.com> wrote:
>>>>>
>>>>> On 30/07/2021 17:18, Krzysztof Kozlowski wrote:
>>>>>> On 30/07/2021 16:49, Sam Protsenko wrote:
>>>>>>> This patch series adds initial platform support for Samsung Exynos850
>>>>>>> SoC [1]. With this patchset it's possible to run the kernel with BusyBox
>>>>>>> rootfs as a RAM disk. More advanced platform support (like MMC driver
>>>>>>> additions) will be added later. The idea is to keep the first submission
>>>>>>> minimal to ease the review, and then build up on top of that.
>>>>>>>
>>>>>>> [1] https://www.samsung.com/semiconductor/minisite/exynos/products/mobileprocessor/exynos-850/
>>>>>>>
>>>>>>
>>>>>> Great work!
>>>>>>
>>>>
>>>> Thanks, Krzysztof! And thank you for reviewing the whole series.
>>>>
>>>>>> What's the SoC revision number (should be accessible via
>>>>>> /sys/bus/soc/devices/soc0/)? Recent wrap in numbering of Exynos chips
>>>>>> might bring confusion...
>>>>
>>>> # cat /sys/devices/soc0/revision
>>>> 0
>>>
>>> soc_id but you're right it won't be set for unknown SoCs. You need to
>>> extend drivers/soc/samsung/exynos-chipid.c to parse new values (E3830000
>>> for product ID) and maybe new register offsets (previous offset is 0x0,
>>> for 3830 is 0x10 I think). Also revision mask might change.
>>>
>>>>> Judging by vendor's sources it is quite confusing. It looks mostly like
>>>>> Exynos3830 but in few other cases it uses Exynos9 compatibles (Exynos9,
>>>>> Exynos9820). Only in few places there is Exynos850. Marketing department
>>>>> made it so confusing...  The revision embedded in SoC would be very
>>>>> interesting.
>>>>>
>>>>
>>>> As I understand, this SoC is called Exynos850 everywhere now.
>>>> Exynos3830 is its old name, not used anymore. As you noticed from
>>>> patch #2, it shares some definitions with Exynos9 SoC, so I guess some
>>>> software is similar for both architectures. Not sure about hardware
>>>> though, never worked with Exynos9 CPUs. Anyway, I asked Samsung
>>>> representatives about naming, and it seems like we should stick to
>>>> "Exynos850" name, even in code.
>>>
>>>
>>> Since the chip identifies itself as E3830000, I would prefer naming
>>> matching real product ID instead of what is pushed by marketing or sales
>>> representatives. The marketing names don't have to follow any
>>> engineering rules, they can be changed and renamed. Sales follows rather
>>> money and corporate rules, not consistency for upstream project.
>>
>> On the other hand we have already two exceptions for naming
>> inconsistency - Exynos3250 identifies itself as 3472 (which is confusing
>> because 3250 is two core and there is a separate quad-core
>> Exyons3472...) and Exynos5800 is actually marketing name for a revision
>> of Exynos5422. Maybe indeed will be easier to go with the branded name
>> 850...
>>
> 
> Well, chip engraving says "3830", but I was specifically told to stick
> to "850" in upstream kernel. I can presume there was some mix ups with
> this naming, and it might be the case it's better to stick to "850"
> exactly to avoid further confusion. Yes, I can see that
> EXYNOS3830_SOC_ID = 0xE3830000 in chipid driver, but we can return
> "EXYNOS850" string for that const, right? If you google "Exynos850"
> and "Exynos3830", it's obvious everybody uses the former, so I'd
> appreciate if we can stick to "850" in the end.

Yeah, let it be. If you have some pushback from some company
representatives about naming, encourage them to speak up here. Otherwise
you will be the guy in the middle bringing arguments between different
parties. :)


Best regards,
Krzysztof
