Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E8C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 23:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E60564FCE
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 23:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhCJXMF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Mar 2021 18:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhCJXLf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Mar 2021 18:11:35 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB92DC061764
        for <linux-serial@vger.kernel.org>; Wed, 10 Mar 2021 15:11:34 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id m11so27814127lji.10
        for <linux-serial@vger.kernel.org>; Wed, 10 Mar 2021 15:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fsUvZGKYC5fgx4oei9Q5/ic2uEIxVNyjDNMh2AgyO6I=;
        b=YFJ7SMDaL74sPgY4t2M2TveLoai2GpxFH7T+w02cY0yAPfz4d7STzMXwN2LMQ2iEoZ
         AC3wFDsX/B+jYJXVNzs+y4D9tGf/wEA3njzRA4m7PPgqfVi486jFs5jC4rjhpItvLjMl
         feX0SL4sSjFQxxMpaHtUG3m/yP5ZsWGY2bHZ1JzjeRWLuH3LgTM/weeATOW14t4za+lM
         0oejehpKlmlwaemoSaXKHgvkv/wgRR/MCed4z76h2TRaPLDfBO1rpazJRuqEpn9HXUuZ
         gZsRlyCIDNbKHWfuIFLOxVswPmSPuq2apnjiVRCSHJ7mbVzB2AtDRB2jPCfVazu7Yozu
         i7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsUvZGKYC5fgx4oei9Q5/ic2uEIxVNyjDNMh2AgyO6I=;
        b=TN1RS3XV2sOKesr4e6zHuFirSqlQgO2ZCbn+hyLsk/vL3YGuVN2FV6qaORnJ64PrBy
         dj3FCxpZd3PMFePxz2BG1w9lbBC7RnDDYy5Bf6MSduwreU+XmpmPxaIx8PPRIXjW329b
         kTw+knpOiQoOkTpbGmKafDlA2Ab+p2v4WopmbayTIOokgsJO4jiVsmrCfYUK9jGZhzXp
         94M/2akvZZOuRyLBiI5azPcFiYn2enUALzPMZJlxM6o+7LzeVZvCswo2v0xla+0VprFE
         JP1GCxwsuzj7/9n+W7NLStlo99XvI9mfsSbREEiwj8Woms8xpsHN7LhNwHHleH3mIVnB
         UUbg==
X-Gm-Message-State: AOAM5326tEMKZypryI9MpNMsYnl6lyywhU9ygcySIYBZTTE42yLusqr8
        LwDBt5Jj55VhmJHGi2Mm4arOAaOP9hFwx36cxtN63w==
X-Google-Smtp-Source: ABdhPJzmo5G8NylnSmgEyDfdbat9eWDptGx3+8/H3Ywrq5Z5I67GtCUd0mY3fRoJZXOwQZI5bSexUvc4wSg5BOhWX4M=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr3125411ljc.200.1615417892988;
 Wed, 10 Mar 2021 15:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-26-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-26-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 00:11:22 +0100
Message-ID: <CACRpkdZrFfP3nx=eU-hKKVUfxHHX2J2-__6tjV8hTPgX3qtBDA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 25/27] tty: serial: samsung_tty: Add earlycon
 support for Apple UARTs
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 4, 2021 at 10:42 PM Hector Martin <marcan@marcan.st> wrote:

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

This is as elegant as it gets!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
