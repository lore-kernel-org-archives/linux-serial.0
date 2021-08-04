Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67642C432BE
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 18:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8EA60FC4
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 18:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhHDSg7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Aug 2021 14:36:59 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:44368
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240314AbhHDSg6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Aug 2021 14:36:58 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 40E673F373
        for <linux-serial@vger.kernel.org>; Wed,  4 Aug 2021 18:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628102204;
        bh=kLWUtHA3a5xY5N4esWD+HgIy7cu1PUh6hkksxjyOzDA=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=QEiioed295tlhKw5C0JyTnJTg/9K+9RKyHvE5KwGfbSQmRS9btrYGJdQi5/ofnBbe
         9Fyyu6sl8y/vDp0pbM3g0sO0W1pVWwdvocgJ/GvuLfeJQaHwIteuu/db9j4To3Fujk
         t/Etl26CDchJKRyblq9tPQqanCia0K22e0NTivexFbqxhElGBDalzsQ1T56aH0WZKs
         xsUR8InbVrVdwOhN6Vmqb8n1VMC8a6tPJ22Q+gPLXIN3+0suIhEv7sRifxKH1JcRy1
         rpjLwhf4yZfazOdjOMi6SY1tNDG5ZqmKu7Oop2BazqBSaR5yJK/mthsLnvB0yXNg9i
         ihOajgbuYBcdg==
Received: by mail-ed1-f72.google.com with SMTP id c1-20020aa7df010000b02903bb5c6f746eso1885374edy.10
        for <linux-serial@vger.kernel.org>; Wed, 04 Aug 2021 11:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kLWUtHA3a5xY5N4esWD+HgIy7cu1PUh6hkksxjyOzDA=;
        b=AEQ3erF1WccYEhgPLjDl+l9xmG+puer9UlaxFo0/ZnE6cHrorFrsEdQzVIjB7/qP4L
         SDGcKeiT6pUiaoB5ylHNDcZ/COaaNvSUfc/LnD2IlUxw/gbxx20ghv1Etw2pscZcdZwY
         EPy63BO30yp6cCAm3BXZQvrxPCIWJRx4p63jGsaDRx7DynLTg8HodUU8VyMfrr2NUFM+
         0zGCK5Jl5RqSVb+CcZSQHfpIPWtOC3hKoU3grMg7TCfXON5radB0bfFqR8JU9jVL49s1
         FJmAT3zCgeeZjzk/0lu/8UygnxvVp4VYwMQWVhs5r8NvjezxmIbZRXA8RpE4j7jojTsK
         vaQw==
X-Gm-Message-State: AOAM532eb0C3vp5ic6V+onbbIhnoyceyhDYSX+BVzrJXyGv7ONxgsp8c
        ew4f30V+MxH4RmOqe4oDw8u20MPw2O5zK07zYw3TyInHdCF2IXMgZ9p9rmed01biVzeMWywWVVj
        SzLGIKuDsfKKBkNF/LQv+rgaoYJ5L+Fc/RkjqKBABTg==
X-Received: by 2002:a17:906:9c84:: with SMTP id fj4mr572929ejc.356.1628102203663;
        Wed, 04 Aug 2021 11:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9TZSrCE1ZT+ckWS9kno03EUR0eItVE1fmPjRT2brkptWJ/N8BEt1UTXE4ubRLwSxkR5ISYw==
X-Received: by 2002:a17:906:9c84:: with SMTP id fj4mr572916ejc.356.1628102203469;
        Wed, 04 Aug 2021 11:36:43 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.43.172])
        by smtp.gmail.com with ESMTPSA id cm1sm1248761edb.68.2021.08.04.11.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 11:36:42 -0700 (PDT)
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Marc Zyngier <maz@kernel.org>
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
 <20210730144922.29111-13-semen.protsenko@linaro.org>
 <15871f8ced3c757fad1ab3b6e62c4e64@misterjones.org>
 <CAPLW+4=v4bDcuxGVqs06mobGj34At4cD+vg48b4dPujarS07Tg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 12/12] arm64: dts: exynos: Add Exynos850 SoC support
Message-ID: <bf21badb-804f-45f0-c02b-80ff57ab9931@canonical.com>
Date:   Wed, 4 Aug 2021 20:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPLW+4=v4bDcuxGVqs06mobGj34At4cD+vg48b4dPujarS07Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/08/2021 16:39, Sam Protsenko wrote:
> Hi Marc,
> 
> On Fri, 30 Jul 2021 at 19:50, Marc Zyngier <maz@kernel.org> wrote:
>>
>> On 2021-07-30 15:49, Sam Protsenko wrote:
>>> Samsung Exynos850 is ARMv8-based mobile-oriented SoC.
>>>
>>> Features:
>>>  * CPU: Cortex-A55 Octa (8 cores), up to 2 GHz
>>>  * Memory interface: LPDDR4/4x 2 channels (12.8 GB/s)
>>>  * SD/MMC: SD 3.0, eMMC5.1 DDR 8-bit
>>>  * Modem: 4G LTE, 3G, GSM/GPRS/EDGE
>>>  * RF: Quad GNSS, WiFi 5 (802.11ac), Bluetooth 5.0
>>>  * GPU: Mali-G52 MP1
>>>  * Codec: 1080p 60fps H64, HEVC, JPEG HW Codec
>>>  * Display: Full HD+ (2520x1080)@60fps LCD
>>>  * Camera: 16+5MP/13+8MP ISP, MIPI CSI 4/4/2, FD, DRC
>>>  * Connectivity: USB 2.0 DRD, USI (SPI/UART/I2C), HSI2C, I3C, ADC,
>>> Audio
>>>
>>> This patch adds minimal SoC support. Particular board device tree files
>>> can include exynos850.dtsi file to get SoC related nodes, and then
>>> reference those nodes further as needed.
>>>
>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>> ---
>>>  .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 782 ++++++++++++++++++
>>>  arch/arm64/boot/dts/exynos/exynos850-usi.dtsi |  30 +
>>>  arch/arm64/boot/dts/exynos/exynos850.dtsi     | 245 ++++++
>>>  3 files changed, 1057 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850-usi.dtsi
>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
>>> b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
>>> new file mode 100644
>>> index 000000000000..4cf0a22cc6db
>>
>> [...]
>>
>>> +     gic: interrupt-controller@12a00000 {
>>> +             compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>>
>> One thing for sure, it cannot be both. And given that it is
>> an A55-based SoC, it isn't either. It is more likely a GIC400.
>>
> 
> Yes, it's GIC-400, thanks for pointing that out. Will fix that in v2.
> 
>>> +             #interrupt-cells = <3>;
>>> +             #address-cells = <0>;
>>> +             interrupt-controller;
>>> +             reg = <0x0 0x12a01000 0x1000>,
>>> +                   <0x0 0x12a02000 0x1000>,
>>
>> This is wrong. It is architecturally set to 8kB.
>>
> 
> Nice catch! Actually there is an error (typo?) in SoC's TRM, saying
> that Virtual Interface Control Register starts at 0x3000 offset (from
> 0x12a00000), where it obviously should be 0x4000, that's probably
> where this dts error originates from. Btw, I'm also seeing the same
> error in exynos7.dtsi.

What's the error exactly? The "Virtual interface control register"
offset (3rd region) is set properly to 0x4000 on Exynos7. Also one for
the Exynos5433 looks correct.

> Though I don't have a TRM for Exynos7 SoCs, so
> not sure if I should go ahead and fix that too. Anyway, for Exynos850,
> I'll fix that in v2 series.


However while we are at addresses - why are you using address-cells 2?
It adds everywhere additional 0x0 before actual address.


Best regards,
Krzysztof
