Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5537CCA47E
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jun 2022 13:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376631AbiFPNm4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377162AbiFPNm4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jun 2022 09:42:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DD215829
        for <linux-serial@vger.kernel.org>; Thu, 16 Jun 2022 06:42:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so261209pjm.4
        for <linux-serial@vger.kernel.org>; Thu, 16 Jun 2022 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aNEeKuprTbTs5LWWfeMDjy1KZmrz1EiAxXm6JSqXnbU=;
        b=AtLPdduL5q5b2YWCXSxu/s0KWycSnUha2yes+KuNgoj+MI0badVhC6uG83O5867Yqq
         3Yf/wqsNPawZn2q34DI9FdzVHmnUMppElAyOKygqRFaNM4vpt3gvNjCdIesBdQb9lLWP
         OOjzODwWOx7k1tBExXpcJzf+ZULGERqNptgKw3xKFCKun6tEEsZQqErgxy+y9fbwRk+c
         Q1pLGwXF2mVxiuLfEbGgHQM68raYem8K8h8T9PhsWwOUB3qKn56p7Wafz0+YaQ48qL8U
         u9hcjHSRkMcRKB88ZXLfN1B4GkTDNCC689K8WcTHOLnr3S6ML111WPyr5DI31g2t/D2W
         5HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aNEeKuprTbTs5LWWfeMDjy1KZmrz1EiAxXm6JSqXnbU=;
        b=IqI2mXsm15Jklk4vaTNODLHvDhdunBBGGGS9SYdqtUWl4CMdp3/T/lZkXdNaXfoTdE
         5aaizgzkuahdgXgqItnr3QrSz6wLi6B8aAvmkAZC79832sHQUTAd1qWGN7tIIQBZ4kRw
         F1QHcvrGTogVbcznNEcawOjp3gYyA8r0Df8nYGw9gD9xh8/ci/DmLSdQjeC/ruH7MbM2
         chRJR87kT0yKSoJePx2guGTg4aaCVSA+4JLFerRVOERDBxbgYzi5TNBgWEfsM5Sx6kfB
         iTIbrEO/F041xITp4y9tFTi3qufvzKoDWwhTzsk1Zl8cqiBnjRw9e4l0441fd9GCc6nN
         yJBA==
X-Gm-Message-State: AJIora+XfjU3JJEC4DBwd9E/qCCtyn0rKWAbV/Lf2P21ttQLEnlXxfwG
        6h1jj4U2OSf0CxKIA635xyzKfA==
X-Google-Smtp-Source: AGRyM1uOiNZH9+Db6fJogZkx01+5krAEqlx/kpcj5J7iOOcLUTZi02KkxtOsyTtdg6Sg5lx9L6FqFw==
X-Received: by 2002:a17:90b:4c4e:b0:1e3:368b:c09c with SMTP id np14-20020a17090b4c4e00b001e3368bc09cmr5181474pjb.140.1655386971761;
        Thu, 16 Jun 2022 06:42:51 -0700 (PDT)
Received: from [172.20.0.255] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id c2-20020a639602000000b003fb098151c9sm1775868pge.64.2022.06.16.06.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:42:51 -0700 (PDT)
Message-ID: <ff933448-433c-30a5-765b-4a86069c239c@linaro.org>
Date:   Thu, 16 Jun 2022 06:42:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 12/20] dt-bindings: reset: npcm: Add support for
 NPCM8XX
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
 <20220608095623.22327-13-tmaimon77@gmail.com>
 <add025b6-c622-b204-d39e-67b31878d37f@linaro.org>
 <CAP6Zq1iDbB+X5QPE4Nsqk4nV41bZiVzQZExS1pQTuKEBz-iYew@mail.gmail.com>
 <381ff739-e898-8812-d549-df7101f0eaa2@linaro.org>
 <CAP6Zq1j=x3OcOPSOjJJmOcze7ziM=oWcKdbYzoHhGnvZipu_UQ@mail.gmail.com>
 <e6e478a5-9080-fb2f-9ccd-2490cdfab4c7@linaro.org>
 <CAP6Zq1gy=rj-wyqqNQF+Pt1dtHsf+90AnTGTqt-v9madj8tfGA@mail.gmail.com>
 <d3432cce-079e-3d6d-91df-6da10bd69d08@linaro.org>
 <CAP6Zq1jdMN_vB1Uoi6rb_E1DydS7+-A0sWMRNUhDPF4pzkr2kA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1jdMN_vB1Uoi6rb_E1DydS7+-A0sWMRNUhDPF4pzkr2kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16/06/2022 06:41, Tomer Maimon wrote:

>>>> What is NPCM-ADC document file? What do you want to describe there?
>>>> Again - how is it different than interrupts?
>>> It is not different from the interrupts.
>>> I will remove the dt-binding reset include file, the reset property
>>> will use numbers and not macro's.
>>
>> I have no clue what are you referring now... This is NPCM8xx and it has
>> no binding header with reset values. What to remove then?
> I refer nuvoton,npcm8xx-reset.h file, we don't need it.

There is no such file in kernel, I believe. If you refer to the patchset
here, then of course it should not be sent.


Best regards,
Krzysztof
