Return-Path: <SRS0=PbAg=IF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6810C433DB
	for <linux-serial@archiver.kernel.org>; Sun,  7 Mar 2021 11:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E42365101
	for <linux-serial@archiver.kernel.org>; Sun,  7 Mar 2021 11:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCGLf3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 7 Mar 2021 06:35:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49484 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhCGLe7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 7 Mar 2021 06:34:59 -0500
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lIrgX-0001p5-1u
        for linux-serial@vger.kernel.org; Sun, 07 Mar 2021 11:34:57 +0000
Received: by mail-ed1-f72.google.com with SMTP id q2so3559393edt.16
        for <linux-serial@vger.kernel.org>; Sun, 07 Mar 2021 03:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Op5mu56rLKVeXZ5BYHLLFs3XBf2gdeKehd8++u/6LDA=;
        b=jXejULG4vbvsR/h3T3shoscFfBbkKbcRWo/SQqRutzFUM1eba0X2AcYYHB1VBetjts
         mC+bH22jMAYNv5bu2pfe4H7HD19EP2/FSrGNuC7hgLzwgtf7XKi2lanONVDtwhDiSzSF
         xZ3sN/SZcDLAPu0TscC2dEV5y52qMlf3s7qKAnSi9Mjda33fOiFnNte4Uwl48daGkopF
         3R1vJ2+1ymlHWu8n5KAO0W5Fa9Pmpe/eeLAZ7tyZn3oem76r94ZB/Hx1MD6R4DKyKGLI
         AElYJj2FGQgmKj92WfCXp8jBRTTHJXAnn4UvGlfaitKFE2CXift/MZM9nUbaQj1m8Uok
         6G/w==
X-Gm-Message-State: AOAM530asWooXH4J09+qbrez4ylCWok5fgdw2JfhuSk2fQuCnweb0S7/
        yC4JCBkuokT1tb2hbmQppkRyWuoLuVCmqdjTWp+D+J0E+apQZKcJ5csvJv5W76X0MuKkw0ax6MB
        vw1V7f0GYg6bgyOz1PS9x5E+Q2L+WrtJNu26dkoQdeg==
X-Received: by 2002:a50:fa04:: with SMTP id b4mr17812441edq.293.1615116896805;
        Sun, 07 Mar 2021 03:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwN50SNAvRJvyv1TTGSoHps9ZM3d2RwZosjPBjKJrezHq2PpQu4f0MDG5tTUROmsW8Jne4o4A==
X-Received: by 2002:a50:fa04:: with SMTP id b4mr17812435edq.293.1615116896694;
        Sun, 07 Mar 2021 03:34:56 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id g25sm5016167edp.95.2021.03.07.03.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 03:34:56 -0800 (PST)
Subject: Re: [RFT PATCH v3 21/27] tty: serial: samsung_tty: IRQ rework
To:     Hector Martin <marcan@marcan.st>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-22-marcan@marcan.st>
 <CAHp75Vc+t9_FNHZ0xYNaJ1+Ny+FFeZKA79abxV2NAsZvpBh3Bg@mail.gmail.com>
 <535ff48e-160e-4ba4-23ac-54e478a2f3ee@marcan.st>
 <CAHp75Vd_kwdjbus3iq_39+p_xRk3rum2ek3nLLFbBDzMwggnKA@mail.gmail.com>
 <05ccc09f-ffea-71cd-4288-beed3020bd45@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d33fffec-28bd-99b2-a8b1-cc83b628e4b3@canonical.com>
Date:   Sun, 7 Mar 2021 12:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <05ccc09f-ffea-71cd-4288-beed3020bd45@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/03/2021 17:29, Hector Martin wrote:
> On 06/03/2021 01.20, Andy Shevchenko wrote:
>>> I am just splitting an
>>> existing function into two, where one takes the lock and the other does
>>> the work. Do you mean using a different locking function? I'm not
>>> entirely sure what you're suggesting.
>>
>> Yes, as a prerequisite
>>
>> spin_lock_irqsave -> spin_lock().
> 
> Krzysztof, is this something you want in this series? I was trying to 
> avoid logic changes to the non-Apple paths.

I don't quite get the need for such change (the code will be still
called in interrupt handler, right?), but assuming the "why?" is
properly documented, it can be a separate patch here.

Best regards,
Krzysztof
