Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68B3C433DB
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925986502B
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCEKUH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 05:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCEKTs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 05:19:48 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0701AC061760
        for <linux-serial@vger.kernel.org>; Fri,  5 Mar 2021 02:19:48 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y12so2032966ljj.12
        for <linux-serial@vger.kernel.org>; Fri, 05 Mar 2021 02:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDO5cCl4ab76RhZZa944rFupwI7HROFvYkUlweaxUwo=;
        b=qIY3nYPxmlMkINpKQiBMSeeBQTVK8USHlSHQXdncm8KrnyeCScP+mOkJJc5SxnnOBG
         jQepYSTDBoekD8Ui13A+aY7BoB2CPDbd4/2P9hOdzcFH/S9P2sFvm+DW7T/9SlIAU0V+
         LAMf4r1pLGKAaKu20gZpIRUCnscpQSlDRgWFD5lQlUEFE91X1NA196H+w3EIY8gRwE9i
         L7HN9Xy7wUv2zsYrB4TFcOwwBPEHxoADtq1m5VphOvaseh4DZCTG/Clts9h4NiLQmIah
         dGSwL2z9C18/k7BFost9pDSBp4m6exHoXHAvlHQX1ySOMLcAaYdRVTwNK5KR9CF/ca8P
         pqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDO5cCl4ab76RhZZa944rFupwI7HROFvYkUlweaxUwo=;
        b=nsSLkjP3bBC6DwhwtvWyoytTnNHo4pRpt5jQmd1Z4XTTXDnGQ1/fbhZnlneK4yRZBL
         S+ZrPDApWGLWxQLLIv1GVKFIF171tH0h9G2e/cmcRLPrbOQJ0e894N9+4qoOdofxvhIu
         LB66gs4Y4dBey33JqEE80RrLnBRqz0fGXwAPwomSxJq7eb+VEhnaRzb2NC+1gKWuBS6H
         i8u0fo8BuGtv2bFjGVDiBSdVYeiClLDMKImLkCzFzK2mGgLE7Up7tleD/omvdR7eiA1k
         7OK4Y2Y6tbX8Z0/JG7uAKN2JFgL5NRCb/2MKb44sXsJaBUsDW+cdo1wrFssnHBgixMgu
         WFpg==
X-Gm-Message-State: AOAM533ge/U9jluEy2dUGj6A1ul+La7GkSh3TKPiMfnSKxs4dikxldOc
        uszcLZFGsfTpJ8bhCJZGNSw8jBrnbJG++4K0C83XWw==
X-Google-Smtp-Source: ABdhPJwRgUIWxfa2aV8J9wD3ud6vgUSRuFAmd+gtcmSPw1J0W4alY19sVHBN3MdTwWOgNSbglUlPJGdcSNF/1qK6V1A=
X-Received: by 2002:a05:651c:103a:: with SMTP id w26mr2052805ljm.273.1614939586539;
 Fri, 05 Mar 2021 02:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-8-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-8-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Mar 2021 11:19:35 +0100
Message-ID: <CACRpkdbcFzH1eHhEzwxx+x+4TXX-QtJ5kmvLk-GJiuS2YMAzGw@mail.gmail.com>
Subject: Re: [RFT PATCH v3 07/27] arm64: arch_timer: implement support for interrupt-names
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 4, 2021 at 10:40 PM Hector Martin <marcan@marcan.st> wrote:

> This allows the devicetree to correctly represent the available set of
> timers, which varies from device to device, without the need for fake
> dummy interrupts for unavailable slots.
>
> Also add the hyp-virt timer/PPI, which is not currently used, but worth
> representing.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

This is the right solution.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
