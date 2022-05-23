Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71CC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 23 May 2022 14:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbiEWOQw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 May 2022 10:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiEWOQv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 10:16:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC7459B94
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 07:16:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m11so5936682ljc.1
        for <linux-serial@vger.kernel.org>; Mon, 23 May 2022 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CrtzL5zhabiqk9hD9lwI7Uy9maiCHi/zq6y5oUpElJM=;
        b=C2Mvl3XTTCqhkSjVzD0w2l9QO2Kn/IFOE5QeIR4irQJY0qRRtW1uDP9cK+fqbtMCee
         NbsTU1+WzhV3s9eH/SeQkPpmX8yzNP8l3OnYwOFdcW2fIWvrw7IT9SBtSdW6eBdBCug6
         HAONZInHaFsuPPXCFGxuP1/sWF9NswH+Pw1dnbHeoFRZzPmGsflzMWSxcPangWcHDSsO
         rZm0pBvhu713hy49A2WG5mm76Vny7U3nMaKdq4bSUiV4bZ7RDUS8P6aVm7Swiy/0UUFV
         DoeekOeV9OK804PmbLXnTkvg5kcRzpxtl7H50hc4UyuhrnRk6oNWnHWbJmgECt775Fo8
         29+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CrtzL5zhabiqk9hD9lwI7Uy9maiCHi/zq6y5oUpElJM=;
        b=Ww0NEFVJQ+Qqeg1eNHqSacP/a27Xy5G62Q3Zho5TzapHKB4Ujmmx1OV1Y745rn8WQQ
         /4k4H9hgh6/apdVI/+6cvTACN/38Fh6mN/5yptJvoVHQZZewraRbdbdnpU0eJFgAG8fh
         qhwdDzr77qaKA6P9xDQjKdw+2AmTrEUqaNNOYXthrKg9NEKMSy0s/AcJpiRdl6YWTLp9
         3oPeMGI48S5zR50BQGp02Jr+N23VjLpTKZnA2joGg9xKbOcKq7poq4LxU3dpXEKOcxdt
         wBmMQKyZ60vnjuGbbWrV6XzPzIzUidUFDnvn/+mIL+Nv4AjIgx2Y096nVYcPuRPjuCnf
         lKuw==
X-Gm-Message-State: AOAM5305A9IsVTVznzma+uCqA70CqFn67AKRfqCRI59MEL9RW4cxeDft
        qrVn8OiKrcS9C2lsR2tgfTkxMA==
X-Google-Smtp-Source: ABdhPJwX/mZu6eFiAZ1cvg/gMqvNE9X+QhTX6dyxNuJuDiE5oHk1QB7YKhqv9Em/pqf1jVGBl9AlTQ==
X-Received: by 2002:a2e:a801:0:b0:24a:ff0b:ae7a with SMTP id l1-20020a2ea801000000b0024aff0bae7amr12728605ljq.287.1653315408587;
        Mon, 23 May 2022 07:16:48 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b9-20020a056512024900b0047255d21148sm1999270lfo.119.2022.05.23.07.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 07:16:48 -0700 (PDT)
Message-ID: <03f0e3b5-8007-2731-62be-6e9fd18b949b@linaro.org>
Date:   Mon, 23 May 2022 16:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 17/19] arm64: dts: nuvoton: Add initial NPCM8XX device
 tree
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
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
        =?UTF-8?Q?Bj=c3=b6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod <vkoul@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, arm-soc <soc@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-18-tmaimon77@gmail.com>
 <c1b86493-d82d-a639-07af-4c979d733786@linaro.org>
 <CAMuHMdWSccO3J5OYrFUn+azKyzYBP1wmuHZoRU2t3PUbkZx1wA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdWSccO3J5OYrFUn+azKyzYBP1wmuHZoRU2t3PUbkZx1wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 23/05/2022 15:58, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Mon, May 23, 2022 at 11:08 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 22/05/2022 17:50, Tomer Maimon wrote:
>>> This adds initial device tree support for the
>>> Nuvoton NPCM845 Board Management controller (BMC) SoC family.
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> The NPCM845 based quad-core Cortex-A35 ARMv8 architecture and
>>> have various peripheral IPs.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> 
>>> +             l2: l2-cache {
>>> +                     compatible = "cache";
>>
>> Is this a real compatible? What bindings are you using here?
> 
> The compatible value and related properties are defined in the
> Devicetree Specification, v0.4-rc1, Section 3.9 ("Multi-level and
> Shared Cache Nodes (/cpus/cpu*/l?-cache)").

Indeed, thanks!

> 
> The properties are handled by
> dtschema/schemas/cache-controller.yaml, but the latter seems to lack
> any checking on the compatible value?


Best regards,
Krzysztof
