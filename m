Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE5C4338F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 18:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A7A60560
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 18:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbhHDShu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Aug 2021 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbhHDSht (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Aug 2021 14:37:49 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06FCC06179B
        for <linux-serial@vger.kernel.org>; Wed,  4 Aug 2021 11:37:36 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id y1so1564819vsc.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Aug 2021 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4v3mD/G2snz9EPb0n2yEtj1B1wrpxfXSkVM/rZ+bK44=;
        b=UiEa1uta1KUv8TDKZIseoNOvN58KiK/nQxRPJnKuD5lTZrBcITzinwOi4xZm8Cf4H7
         UiXfhR3HHnQsZdXRk1ePk1j0+K+W3KAgbIxU6qZuLGNoAozeTSlsHGPoM7wZY5MDzNcr
         nveFZTkbRVI2YLs8FY39dWLY7KkMtLVbsWaz+tBzVbl9V8lH0yCJF0cQPx2vikXmRrG2
         nUuq5oRb71+g/PXYHLEFMPSy6yT9mfdb8ACD9+l7s9e9iPFbUwtqj7AiMeAevCmCZCCb
         JjlI17bXqD6S7+vljkvff8HX3byQ9kVXLeGHgLOhEdUm9VXdFRVnY2TRpbfwZKlBgO1i
         O3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4v3mD/G2snz9EPb0n2yEtj1B1wrpxfXSkVM/rZ+bK44=;
        b=scZnX5T5zWFXYyxTIO9ihhO/oKKWKcMqeRgwdRDY5kaN6mn6uB0PU2UooUMTO9lpsy
         x6VS/7OdFp5/kaw4eYtUfSj5whwiOjxTfPT6T7xW7M3RBs7W1KW2N0SNWzf59ADDfDLK
         9V6SIRsAFyLWmubDbLwoZ6qNufWVcNUxdDLT9PIBN1pyjGXJpmliJToV/8xMkMArtd+y
         mNn9ZTqnUzP6AitZp0vg0Tsj+QHvQ9Ur4E8xs2sSUQLjOWLKq4tg5rJEhH80EjbDu4ym
         D10ORER1yC8pxMRME7EkKGCvi9XTaBQOYlaZFOdNBuN5MLvSxcuIxk3KCr1QcE2xyFSV
         7BQQ==
X-Gm-Message-State: AOAM530XXbJapoeX302Yifjhtan9palNUQnGBLHdvwSKbyMdKe4QYMiR
        ea1YwiBU8Es3+gVC75SC43949f+4rfsoCg7qXZJeTA==
X-Google-Smtp-Source: ABdhPJxf7txyKVStc9ONgBFPDBEr31m+shBvV8OvMRDu9d7Qql+uwVOjtKWRAB+wjysr6bHm+4qOzLKEIRe9Sx5O90o=
X-Received: by 2002:a67:f60e:: with SMTP id k14mr1496697vso.30.1628102255703;
 Wed, 04 Aug 2021 11:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-13-semen.protsenko@linaro.org> <15871f8ced3c757fad1ab3b6e62c4e64@misterjones.org>
 <CAPLW+4=v4bDcuxGVqs06mobGj34At4cD+vg48b4dPujarS07Tg@mail.gmail.com> <87k0l1w8y5.wl-maz@kernel.org>
In-Reply-To: <87k0l1w8y5.wl-maz@kernel.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 4 Aug 2021 21:37:24 +0300
Message-ID: <CAPLW+4mMF9B2BiY2hTgHz5=DNbDJZ7TDzt=Xefb5tDKwQhpEew@mail.gmail.com>
Subject: Re: [PATCH 12/12] arm64: dts: exynos: Add Exynos850 SoC support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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

On Wed, 4 Aug 2021 at 18:01, Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 04 Aug 2021 15:39:38 +0100,
> Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> > > You are also missing the hypervisor virtual timer interrupt.
> > >
> >
> > Checked SoC TRM, there is no PPI for hypervisor virtual timer
> > interrupt, and no mentioning of it at all. Likewise, I checked ARMv8
> > ARM and TRM, almost no description of it. Also, I checked other
> > platforms, and seems like everyone does the same (having only 4
> > interrupts). And I wasn't able to find any documentation on that, so I
> > guess I'll leave it as is, if you don't mind.
>
> I *do* mind, and other DTs being wrong isn't a good enough excuse! ;-)
>
> From the ARMv8 ARM (ARM DDI 0487G.b)
> <quote>
> D11.2.4 Timers
>
> In an implementation of the Generic Timer that includes EL3, if EL3
> can use AArch64, the following timers are implemented:
>
> * An EL1 physical timer, that:
>   - In Secure state, can be accessed from EL1.
>   - In Non-secure state, can be accessed from EL1 unless those
>     accesses are trapped to EL2.
>     When this timer can be accessed from EL1, an EL1 control
>     determines whether it can be accessed from EL0.
> * A Non-secure EL2 physical timer.
> * A Secure EL3 physical timer. An EL3 control determines whether this
>   register is accessible from Secure EL1.
> * An EL1 virtual timer.
> * When FEAT_VHE is implemented, a Non-secure EL2 virtual timer.
> * When FEAT_SEL2 is implemented, a Secure EL2 physical timer.
> * When FEAT_SEL2 is implemented, a Secure EL2 virtual timer.
> </quote>
>
> Cortex-A55 being an ARMv8.2 implementation, it has FEAT_VHE, and thus
> it does have a NS-EL2 virtual timer. This is further confirmed by the
> TRM which documents CNTHV*_EL2 as valid system registers[1].
>
> So the timer exists, the signal is routed out of the core, and it
> is likely that it is connected to the GIC.
>
> If the designers have omitted it, then it needs to be documented as
> such.
>

Ok, I've checked thoroughly all docs again, and it seems like there is
no dedicated PPI number for this "EL2 Hypervisor Virtual Timer" in
Exynos850 SoC. The timer instance itself might exist of course, but
interrupt line is probably wasn't connected to GIC by SoC designers,
at least it's not documented.

Moreover, from [1,2] it looks like if it were existing it would have
been PPI=12 (INTID=28). But in GIC-400 TRM this PPI is assigned to
"Legacy FIQ signal", and all there is no PPI for Hypervisor Virtual
Timer documented there as well. In Exynos850 TRM the source for this
PPI's interrupt source is marked as "-", which means it's not used.

So if you know something that I don't know -- please point me out the
doc where this PPI line is documented. Otherwise I can add the comment
to device tree, stating that this interrupt line is not present in
SoC's GIC, i.e. something like this:

8<------------------------------------------------------------------------------->8
    timer {
        compatible = "arm,armv8-timer";
        interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) |
                      IRQ_TYPE_LEVEL_LOW)>,
                 <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) |
                      IRQ_TYPE_LEVEL_LOW)>,
                 <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) |
                      IRQ_TYPE_LEVEL_LOW)>,
                 <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) |
                      IRQ_TYPE_LEVEL_LOW)>;
        /* Hypervisor Virtual Timer PPI is not present in this SoC GIC */
    };
8<------------------------------------------------------------------------------->8

Is that ok with you?

[1] https://developer.arm.com/documentation/102379/0000/The-processor-timers?lang=en
[2] https://gem5.googlesource.com/public/gem5/+/refs/heads/master/src/arch/arm/fastmodel/CortexA76/FastModelCortexA76.py#150

> Thanks,
>
>         M.
>
> [1] https://developer.arm.com/documentation/100442/0100/register-descriptions/aarch64-system-registers/aarch64-architectural-system-register-summary
>
> --
> Without deviation from the norm, progress is not possible.
