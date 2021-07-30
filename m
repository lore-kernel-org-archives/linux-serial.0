Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB53C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 19:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C997460F36
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 19:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhG3Tbj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 15:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhG3Tbg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 15:31:36 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB4CC0613CF
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 12:31:30 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id x66so3530707vsb.1
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTwg3ftZdEkrZwjfbTZZgZqiWtz0ELEQs7iMOHDjt2g=;
        b=HKmhgCdKit1ByfXm1vUXRBJaKei6NULPm63n6c2KVb9iuaElf59ZwnTL02wsd6NPws
         QwRQhNvHf0+lQ+Gm8OYtFYztLcHhEC+X0QX5nkGRcXiFgCUyLlQdcPISgIvUJVytwgqD
         kN8qBrat9s/S8OIvWKC1rRafR+WObVT5PuMa0/KFpXCOMnsGoimMqXEDfc9tWsKVSKMB
         UEjF9O0ttCakSUWYdn/aWrDLBqz4LMcniW8wFEmsPP+JYrt/ghGxsyAclVeZYeGWMwlq
         iEiN5NyiTS+2U5zr5EW3zLCTojChAVdXNSQzzW81jX1zjIBUVtdn8WQ66U3w5Q5Pm0M0
         CvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTwg3ftZdEkrZwjfbTZZgZqiWtz0ELEQs7iMOHDjt2g=;
        b=OaBT9hEBxEzhQ5IccdxXt3rm1argPpYdyxPE/5qDkzLnMcPif74lRQ63cscDTfqz+Y
         EGFxI7EN78cd/RpraUsCM8+fcChwLtDQbtqZUTxCG1cvHYREloMy4VKA0q1/IJjR5yhT
         1r7mu0Gi2lwchZ3u0QIaRfFtTxSKpnqY/UF9QJ21GIyTqq743Phr+0x0vVnGFwqdi3G/
         nATSLxF6Jp97fqJsmuPUbCyD+AqzTsgKMz+vco+G0CgiJ9TvLEaZcyagjNZieVmPGKxq
         NcNWnprabsnXMnbmNQDrPsX5GNPpfa6g1qmoyx4bMeefzV9QixMLUjJrylGWBoLijxwN
         Vuuw==
X-Gm-Message-State: AOAM5339JXW0AELLCFj+vrKGpKUtML+P1Ak7vCXu0YPMU86a4v+HPTeR
        3PaeR0L+uAvvg7KM8lHmEHd9zGoEnXOTyox96sVN3A==
X-Google-Smtp-Source: ABdhPJwzN5k9K9wcPdG8qks1LUn6IIYRhNxortw/xuZYWjsFGojdp/CFbFwlotzlaZrTcQ0+7fQjW+AwzT3YGLiK5+Y=
X-Received: by 2002:a67:16c1:: with SMTP id 184mr3619118vsw.14.1627673489430;
 Fri, 30 Jul 2021 12:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-4-semen.protsenko@linaro.org> <61a6c636-6f72-d086-79b8-e87dbab6b456@canonical.com>
In-Reply-To: <61a6c636-6f72-d086-79b8-e87dbab6b456@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 30 Jul 2021 22:31:18 +0300
Message-ID: <CAPLW+4kCuFGYdrkTuXFaGgPy-EyENkBZMGV-BaY6qn2_j+ABTw@mail.gmail.com>
Subject: Re: [PATCH 03/12] dt-bindings: pinctrl: samsung: Add Exynos850 doc
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

On Fri, 30 Jul 2021 at 18:25, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 30/07/2021 16:49, Sam Protsenko wrote:
> > Document compatible string for Exynos850 SoC. Nothing else is changed,
> > as Exynos850 SoC uses already existing samsung pinctrl driver.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> The patch should be first in the series - dt-bindings go at beginning.
> Although no need to resend just for this.
> If the resend happens, the fix ("pinctrl: samsung: Fix pinctrl bank pin
> count") should be sent separately (no mixing fixes and new features)
> because they are independent and usually easier for review.
>

Thanks, will be done in v2. Also, just re-sent ("pinctrl: samsung: Fix
pinctrl bank pin count") fix separately, as you recommended.

>
> Best regards,
> Krzysztof
