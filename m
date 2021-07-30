Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B239AC432BE
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 19:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9733860F9B
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 19:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhG3TCd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhG3TCa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 15:02:30 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71983C0613D5
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 12:02:24 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id k124so2233574vke.5
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBCAezsRz+diDpubea9ipqu5sk3T7ijBYsLpPq9JW6g=;
        b=bDgWF2lqGMUdyCyKt7IN7yXqW3h+wIKUz+MPEaJhXXpzBEp0DfQjh9CuOEjG0CzTM/
         d6go/2disbc51wRYj5T56dCFF7xi2Rz1b2FVK3dHv6J18v1pdUDD/alM4dyrmFzkPCVA
         pP2PTVAS15KrTJIylWJrNUaLIw9s/j/JfrkmfrXlXajpC+0My7997AyW3R5J/44mKOOD
         nrdt1iHUwHO5PLk/3S8/L/SSLcWT+jC4zfOY46O7rmUAcjmKFHEE6P0UkaKf0pB+CJ9J
         X9SBMLKBTsJ+2Oq0jxxtMYwnzVaEmgz0h/cJoTjfTTFS3JhqVDJAxAVuUCMp6LLFiBD1
         mfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBCAezsRz+diDpubea9ipqu5sk3T7ijBYsLpPq9JW6g=;
        b=GjiYUsj8K67m6F7dQBB3GPsK+zelHbk6Sec5nHx6LJqq/tuhVedt9RY8zoSaB1fruh
         lVVUrG7a/+3ibqti7tRS4Y1OkcZqX0w00fo0YwG7/QjtinoNhmtAsebdGZyGTXtAcMkg
         omE3rd0tnXKgqkHoRiOil2JEYHIQ/LJJ2b5f7mTuk+4PW7VhoWulkWlM9nd29RmRYvmz
         xOK/LRszpY2b5T/yb9mdEKL7jVAuLkre14Nqdghxz5K6LYxWtTpsjqGzWsKO9P/f66L+
         /tBa0196TQBpo7nt6uxOwzikcSVfostAOUBqGYMiTSJyCoc6ZHmouS/lR7wYQ32tWFrk
         t5TA==
X-Gm-Message-State: AOAM532/ba7tkIOn1qVIuspzQ6EXiG8hk51lbn9h0vvaUry0hANV5BuK
        ACyBxE88tjy7cEyMxb+tcmLjOJqNYCkz+K49VKLBVg==
X-Google-Smtp-Source: ABdhPJy6d7W9hl2/7EtbdW42ci7f/PLQYOiCiB8PwC/au40+bBBTWt2EtWiXxIl/RIdt37Nw/MAlL2jVYoYJ1eEgjXE=
X-Received: by 2002:a1f:3651:: with SMTP id d78mr3095853vka.0.1627671743462;
 Fri, 30 Jul 2021 12:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <5e35b0a7-13aa-3c62-ca49-14af2fcb2a08@canonical.com> <c3486111-0ec9-9679-d2a2-68b2f33a2450@canonical.com>
In-Reply-To: <c3486111-0ec9-9679-d2a2-68b2f33a2450@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 30 Jul 2021 22:02:12 +0300
Message-ID: <CAPLW+4kbnJEBkc0D=RWt59JxBan8X1uDy6sSXBiYAq8N9FDV6A@mail.gmail.com>
Subject: Re: [PATCH 00/12] Add minimal support for Exynos850 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Krzysztof,

On Fri, 30 Jul 2021 at 20:21, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 30/07/2021 17:18, Krzysztof Kozlowski wrote:
> > On 30/07/2021 16:49, Sam Protsenko wrote:
> >> This patch series adds initial platform support for Samsung Exynos850
> >> SoC [1]. With this patchset it's possible to run the kernel with BusyBox
> >> rootfs as a RAM disk. More advanced platform support (like MMC driver
> >> additions) will be added later. The idea is to keep the first submission
> >> minimal to ease the review, and then build up on top of that.
> >>
> >> [1] https://www.samsung.com/semiconductor/minisite/exynos/products/mobileprocessor/exynos-850/
> >>
> >
> > Great work!
> >

Thanks, Krzysztof! And thank you for reviewing the whole series.

> > What's the SoC revision number (should be accessible via
> > /sys/bus/soc/devices/soc0/)? Recent wrap in numbering of Exynos chips
> > might bring confusion...

# cat /sys/devices/soc0/revision
0

>
> Judging by vendor's sources it is quite confusing. It looks mostly like
> Exynos3830 but in few other cases it uses Exynos9 compatibles (Exynos9,
> Exynos9820). Only in few places there is Exynos850. Marketing department
> made it so confusing...  The revision embedded in SoC would be very
> interesting.
>

As I understand, this SoC is called Exynos850 everywhere now.
Exynos3830 is its old name, not used anymore. As you noticed from
patch #2, it shares some definitions with Exynos9 SoC, so I guess some
software is similar for both architectures. Not sure about hardware
though, never worked with Exynos9 CPUs. Anyway, I asked Samsung
representatives about naming, and it seems like we should stick to
"Exynos850" name, even in code.

> Anyway, judging by current versioning, there is a risk Samsung will come
> with a new chipset name conflicting with existing ones. It already
> overflowed.
>
> It's even worse with a thingy called "Exynos9 auto" which hides
> numbering even more.
>
>
> Best regards,
> Krzysztof
