Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A73CCA47B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jun 2022 09:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348142AbiFJJ7K (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jun 2022 05:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348119AbiFJJ7J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jun 2022 05:59:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C8B043E
        for <linux-serial@vger.kernel.org>; Fri, 10 Jun 2022 02:59:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z7so34545808edm.13
        for <linux-serial@vger.kernel.org>; Fri, 10 Jun 2022 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wq9gVVdD1/J4q1/EmaJv8aMnFa3KHaLmU1Qz7ppGNhE=;
        b=sESAYG8k3Sf9OIqWLT4EVVR1tdBRPzoeATKW1Bbr2Qec6XgtDTd0dLvf3JxpbsdtiN
         haM4S5D0p35YqjS96SRhlhV9PmgIBeJZRFmqLI2mTKsHDeogxhZjOgQrxOnzy+1/2XtD
         0eX4ckZuGDw9VkCsjWhZCr46CF8UjrkgRy6bgK/5g382J+YFtdU43gWuOYUyzULLe/G5
         0oLO+Ocf8dUlYZC2cquCijGI6UDKjYA4U3w5eOjWMvkknznKAeuz19JOqsRhoOxhN3jy
         C83YXicE7j8ja6i/EwLN5oSrZBoRFP5A1cJViH3BlNc9kFVxMxQaduFcPkr6w8n090DN
         bvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wq9gVVdD1/J4q1/EmaJv8aMnFa3KHaLmU1Qz7ppGNhE=;
        b=raFZiqQir3h+LRC2etuXXsbSnTLRLGRJPP2EYQHeNkhNxjdmRVh+J0WBHS0xfmg+K0
         N2NGm55Q8TkXblY2wRwlqE9tHOK88ro4/7vvfiqjZmnT+cchQ0nTR3UIF34VTjrUU+hP
         hcZem2qC7t7ATXAIgvx70VTbyNOS1nbSpKtrWPcgqM0z3/awwf8gvZO/yDtrJj9zxswQ
         00yt6bYxsVl7wYLtmDKFHf/h0iQw3M6BIH/Bk+KtkwVjL/By2v1SSUGSM/sHjXfFiR+2
         mSFtY17S2xPdZsM4X63e4XWI/+NZy95Hs3YDh5bprZpHraPcn1C4VLkN32xpImWssE6o
         yUTw==
X-Gm-Message-State: AOAM532WK8f+tXTI6+3SjBRSE9dVlYJoWLCLXLG9uckj68q399ojIrMs
        Y6OaE4CnrjQsF458Vinn+gvqaQ==
X-Google-Smtp-Source: ABdhPJznPfBVrxm6drYBka7ZGOrt2dIG3zy2ti6SB08YUWNwJwfIafeTfcbr7B/2U8M4buh900aY3w==
X-Received: by 2002:a05:6402:500b:b0:431:78d0:bf9d with SMTP id p11-20020a056402500b00b0043178d0bf9dmr22935174eda.184.1654855143357;
        Fri, 10 Jun 2022 02:59:03 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090615cf00b006f3ef214dd9sm11969760ejd.63.2022.06.10.02.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 02:59:02 -0700 (PDT)
Message-ID: <11245d23-76a2-1008-eac6-f396954857c7@linaro.org>
Date:   Fri, 10 Jun 2022 11:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 18/20] arm64: dts: nuvoton: Add initial NPCM8XX device
 tree
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-19-tmaimon77@gmail.com>
 <24ad8ba0-4244-1159-328d-12d0e67951e1@linaro.org>
 <CAP6Zq1iXaN8D-g2O=cD-XERGj3BROQO=NJ66mquVsOw8nSM=0A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1iXaN8D-g2O=cD-XERGj3BROQO=NJ66mquVsOw8nSM=0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/06/2022 00:29, Tomer Maimon wrote:
>>> +     clk_refclk: clk-refclk {
>>> +             compatible = "fixed-clock";
>>> +             #clock-cells = <0>;
>>> +             clock-frequency = <25000000>;
>>
>> Ignored comment.
> Could we use it as a default clock-frequency?

In DTS? If my assumption, that this clock is not on SoC itself, is
correct, then the answer is no, you cannot. The clock physically sits on
the board, so it is defined by board DTS. Feel free to embed in SoC DTSI
most of the clock properties, but the core property - frequency - must
be outside.

>>
>>> +             clock-output-names = "refclk";
>>> +     };
>>> +
>>> +     /* external reference clock for cpu. float in normal operation */
>>> +     clk_sysbypck: clk-sysbypck {
>>> +             compatible = "fixed-clock";
>>> +             #clock-cells = <0>;
>>> +             clock-frequency = <1000000000>;
>>
>> Ignored comment.
> same as above
>>
>>> +             clock-output-names = "sysbypck";
>>> +     };
>>> +
>>> +     /* external reference clock for MC. float in normal operation */
>>> +     clk_mcbypck: clk-mcbypck {
>>> +             compatible = "fixed-clock";
>>> +             #clock-cells = <0>;
>>> +             clock-frequency = <1050000000>;
> same as above
>>> +             clock-output-names = "mcbypck";
>>> +     };
>>> +
>>> +     soc {
>>> +             #address-cells = <2>;
>>> +             #size-cells = <2>;
>>> +             compatible = "simple-bus";
>>> +             interrupt-parent = <&gic>;
>>> +             ranges;
>>> +
>>> +             gcr: gcr@f0800000 {
> I understand it sounds generic but I try to be as much compatible with NPCM7XX
> https://elixir.bootlin.com/linux/v5.19-rc1/source/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi#L91

Then fix NPCM7XX. Please do not multiple bad choices because it looks
similar. Fix the other wrong one.

>>
>> Ignored comment.
>>
>>> +                     compatible = "nuvoton,npcm845-gcr", "syscon",
>>> +                             "simple-mfd";
>>
>> This is not a simple-mfd... I see original bindings defined it that way,
>> but why? I think they should be corrected - remove simple-mfd from the
>> bindings and DTS.
> will remove in both places in V3
>>
>>
>>> +                     reg = <0x0 0xf0800000 0x0 0x1000>;
>>> +             };
>>> +
>>> +             gic: interrupt-controller@dfff9000 {
>>> +                     compatible = "arm,gic-400";
>>> +                     reg = <0x0 0xdfff9000 0x0 0x1000>,
>>> +                           <0x0 0xdfffa000 0x0 0x2000>,
>>> +                           <0x0 0xdfffc000 0x0 0x2000>,
>>> +                           <0x0 0xdfffe000 0x0 0x2000>;
>>> +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>> +                     #interrupt-cells = <3>;
>>> +                     interrupt-controller;
>>> +                     #address-cells = <0>;
>>> +                     ppi-partitions {
>>> +                             ppi_cluster0: interrupt-partition-0 {
>>> +                                     affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
>>> +                             };
>>> +                     };
>>> +             };
>>> +     };
>>> +
>>> +     ahb {
>>> +             #address-cells = <2>;
>>> +             #size-cells = <2>;
>>> +             compatible = "simple-bus";
>>> +             interrupt-parent = <&gic>;
> 
>>> +             ranges;
>>> +
>>> +             rstc: rstc@f0801000 {
>>
>> Ignored comment.
>>
> I understand it sounds generic but I try to be as much compatible with NPCM7XX
> https://elixir.bootlin.com/linux/v5.19-rc1/source/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi#L109

Fix 7xx.


Best regards,
Krzysztof
