Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CAFC43216
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 17:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7AB60F46
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 17:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhG3RVj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 13:21:39 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56118
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230210AbhG3RVj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 13:21:39 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 6F1753F243
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627665693;
        bh=o5z17HicOMnibSKxbfutUtdmQTlkkNRFgUGIEJq9A5o=;
        h=From:To:Cc:References:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=iP1hWkWZT5MwdLvttmMex0l/IDza+w9yJmXaClovbGuDZQk3A2vKh1UBx7N6XEXUf
         GNXXL8D5F3rXZ5Gk+bybOiO4/AKiZ7BIjrf5nXR6f/srdiMQJrjD9ug4gTS6YHKUel
         ZAj8ig1/r+6/u6DxOfF5AWYwJ7EZ2kdNKbLo5orIKO84lDxlBO6O/uitwevsCqDyXt
         KSvAX6pY3v035Z1khVp0+xT81wAuBHXccX256pOfkSlKBKQItACijOQLvezemEmR2e
         acouAcnqVlz5aWFP0O0Kz/JaVgqa2l5eApzLQ07eyR6uNpREj44eMVSq34ifNmACXo
         xIKWVdmtXeorQ==
Received: by mail-ed1-f69.google.com with SMTP id de5-20020a0564023085b02903bb92fd182eso4966716edb.8
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 10:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o5z17HicOMnibSKxbfutUtdmQTlkkNRFgUGIEJq9A5o=;
        b=IhdXEvZ0+0GPOk7xugqPjnvWhlw5DgKoYloyCwMS6oMjdZnnwtGN4+CxoP69L7X79b
         MWaAlkLurPpfb+nCKd2B8csnnW6UgiGokCuznWIXXyQBWB6W+kXMjl2Dat6w5MkvblMF
         Wa97wZSUwYC4gr2SnWK4O4QurctvdpDFK2HiOuKfHslmag+8DDHyDmdRBxUT+amNWY9m
         IeDatLylebm1fbAkYfVctKX76wVJPm2NqJgYRvjsx/3MZP/IWk/n8POymrWFiI8GIgeZ
         gd1asKkfHVoyTzxmfmrzRt8jBmSj4IcbTXqSMg4pvKHd16ThGhh+iojBaOM48fWU09yV
         nh5A==
X-Gm-Message-State: AOAM530+cDOmGN+nykl6v1JQyVtf57K2fnjmknTInLXBxmLe7jOyXKnp
        UtU4mnjztkIiiBQyYMeW9FCW1qJqLnMFkl2kyicjeyPmKs+mMVRIPZMOgDKhfMQlkFwUc6ZF/RT
        Pwv4CBv/RgxXRvcDa8JWj9N4KqD+AOvDIAC2fylBOLA==
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr3758096ejc.192.1627665692500;
        Fri, 30 Jul 2021 10:21:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFiKJlif1uhqb84VdmehIjJr5DEUQdSGnnvL110bm0Y0Y4Awj/aQgY4XpZWPb/ITBePmMBnw==
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr3758080ejc.192.1627665692316;
        Fri, 30 Jul 2021 10:21:32 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id p16sm944758eds.73.2021.07.30.10.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 10:21:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <5e35b0a7-13aa-3c62-ca49-14af2fcb2a08@canonical.com>
Subject: Re: [PATCH 00/12] Add minimal support for Exynos850 SoC
Message-ID: <c3486111-0ec9-9679-d2a2-68b2f33a2450@canonical.com>
Date:   Fri, 30 Jul 2021 19:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5e35b0a7-13aa-3c62-ca49-14af2fcb2a08@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/07/2021 17:18, Krzysztof Kozlowski wrote:
> On 30/07/2021 16:49, Sam Protsenko wrote:
>> This patch series adds initial platform support for Samsung Exynos850
>> SoC [1]. With this patchset it's possible to run the kernel with BusyBox
>> rootfs as a RAM disk. More advanced platform support (like MMC driver
>> additions) will be added later. The idea is to keep the first submission
>> minimal to ease the review, and then build up on top of that.
>>
>> [1] https://www.samsung.com/semiconductor/minisite/exynos/products/mobileprocessor/exynos-850/
>>
> 
> Great work!
> 
> What's the SoC revision number (should be accessible via
> /sys/bus/soc/devices/soc0/)? Recent wrap in numbering of Exynos chips
> might bring confusion...

Judging by vendor's sources it is quite confusing. It looks mostly like
Exynos3830 but in few other cases it uses Exynos9 compatibles (Exynos9,
Exynos9820). Only in few places there is Exynos850. Marketing department
made it so confusing...  The revision embedded in SoC would be very
interesting.

Anyway, judging by current versioning, there is a risk Samsung will come
with a new chipset name conflicting with existing ones. It already
overflowed.

It's even worse with a thingy called "Exynos9 auto" which hides
numbering even more.


Best regards,
Krzysztof
