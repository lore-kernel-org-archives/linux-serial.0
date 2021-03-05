Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E44CC433E0
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086456501E
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEK4P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 05:56:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50973 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCEKz4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 05:55:56 -0500
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI87e-0000zX-Ii
        for linux-serial@vger.kernel.org; Fri, 05 Mar 2021 10:55:54 +0000
Received: by mail-wm1-f70.google.com with SMTP id y9so266071wma.4
        for <linux-serial@vger.kernel.org>; Fri, 05 Mar 2021 02:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OZMqvPAg3jF+C2BA1ImILhvUZWoYn1pEgrAzLL3Zn+M=;
        b=Y9NvgcXE8NyQT5Y00rqhQ02a7ENuk3hpTfIo6M/KdKjGN0ZaCR7td8LHhfoMAmhf+G
         DTTSa+wA/KgyNIho9L1otf/Xzt2EfpLHPPvxFiWicCNOwDiGOh/EeYNh1zemZxAFqB6I
         PRQdOP3KIylBSDklHhSmX2OfhmvMLWLmX1oYDRTVoP/c/cbHBGPh0dHdMIclMciGgS6C
         BvjugnGpsaab+HTGUEbNS867JV+snwwQ6xhfTN7irP5N4BcraRdBPxK4HKpMYGB3IIFb
         cFPG2x5hpAjMv1l3YqDCExh97BUTBysdZZIsuT24xOWh9G3lnDScHlTgmoN4HAluQbiP
         YP7Q==
X-Gm-Message-State: AOAM530/jfiNziMFm9/tmojm2QlD/I1qbxmSQppG99MoXHFNa3PHSGVi
        ScM5yDTAHPh8opG+AHMqgd/044jben/RMTUYQgl/dlQTUQODtxlxY7DdxEzZeOvXLG6mSl9iDiJ
        bKLi7a7qPWM4zs/QVx0bAQKbnF6R+rUNVZTnI3u/nig==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr8277744wma.18.1614941754204;
        Fri, 05 Mar 2021 02:55:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB10RjsZA/b+LOBLHOFgBxXrz38OatZE1qDwuc8TyZ6RBnwYZWFn3nzUFRUssHcDn4zFTc0g==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr8277714wma.18.1614941754065;
        Fri, 05 Mar 2021 02:55:54 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id y8sm3921881wmi.46.2021.03.05.02.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:55:53 -0800 (PST)
Subject: Re: [RFT PATCH v3 25/27] tty: serial: samsung_tty: Add earlycon
 support for Apple UARTs
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-26-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d315bcd3-db89-a100-5e4f-a4c51a48aed5@canonical.com>
Date:   Fri, 5 Mar 2021 11:55:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-26-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/03/2021 22:39, Hector Martin wrote:
> Earlycon support is identical to S3C2410, but Apple SoCs also need
> MMIO mapped as nGnRnE. This is handled generically for normal drivers
> including the normal UART path here, but earlycon uses fixmap and
> runs before that scaffolding is ready.
> 
> Since this is the only case where we need this fix, it makes more
> sense to do it here in the UART driver instead of introducing a
> whole fdt nonposted-mmio resolver just for earlycon/fixmap.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
