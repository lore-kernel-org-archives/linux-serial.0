Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43B2C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9856960F5E
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 17:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhG3RdK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 13:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhG3RdJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 13:33:09 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A3C061765
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 10:33:04 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id v3so4272439uau.3
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JaBel+Wk+Pmj/m/QWG3pSV0rzgtGPwsESburA6QnpC0=;
        b=FhUt38mUtFIiLDdQIxIQoXNxNSSACz3P74Pvf9/7tfNd8lCP3n5L4F56oUZaI/XE5V
         VcqKCElVfJuA/8oM6UGQK6sz7nMLW0t2jyS8v2hTI9ATj9QJ1Mm5j0IdoPtG8WGUTHri
         bHCYKViNYMOvw9g/VW7ic19rZqIkUI4xxqyM0rO8XMhuczGIv7VRf2mcRAgVM7P9Gso2
         OUkF/iq1VjVvWMFYpIS5oktLhycz5Jh6/HVhTj23eOvlu1NziMVqzv//yRtE05spLPIr
         btZhS+eZkiePZdnRCNd74CRuy5GcuaHwzmLrhulokA1WpsDAY1yVDhkurmc+Nt7dKDHA
         Z7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaBel+Wk+Pmj/m/QWG3pSV0rzgtGPwsESburA6QnpC0=;
        b=kQoYJx8ScHO6tr9iQFqjcpd8XJYvoRdsPi8idMWLyffdjiHXrfaDZqAY35KkOqqRrW
         pCYX2kJj1ZuV9CRCN8QnW8ssOKVfz9G9XljPrFBFcSwjVp6OiUxdIFe+7VNJNP46MB00
         qg/K7j7sM1VuxaqkI90/bp2+yl7MOuaBLnv32y8MTSXnPGAAC/7t/zrOw9hEaVWK96Xp
         /6yFTLYGPmDu5JOIpNMjSO5jN+EjXdtJvPJ161uMW/Em29dlng4m8vZNZJlEfeJ2Bni1
         rgfHIzDWs//EuB/hxiZFJs4stStRmt+kfe2ZH1YSogl+nIRl8o52HOvS9WthRqXQbL2F
         X+GQ==
X-Gm-Message-State: AOAM530cm8hHHvVF+T6f066yROHFn6RRsFBsOIWZOk+LUW5ChKPVOmaC
        E9ZrJWlevvWvbtHXvGJkd4KMDs9hBaTtZ+0NNBZI8w==
X-Google-Smtp-Source: ABdhPJw43II2PhFksB0jmNqxACJZWx9bpShJeIvnmuKr7qKhtUKe+219lDwvOwfyXr4EiYyBAsjydof5yY2K1WxqSb8=
X-Received: by 2002:ab0:6392:: with SMTP id y18mr3251539uao.139.1627666384076;
 Fri, 30 Jul 2021 10:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-9-semen.protsenko@linaro.org> <CAHp75VcugLnV6D8xhkMHuW-X6LCtHDDnghD2G+vqwYmRvFP9Nw@mail.gmail.com>
 <8202e9f9-06f4-f1ba-4f30-e1a0c8340450@canonical.com>
In-Reply-To: <8202e9f9-06f4-f1ba-4f30-e1a0c8340450@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 30 Jul 2021 20:32:52 +0300
Message-ID: <CAPLW+4mB1NpswMDVThEiOgn0ce29xckV5ZHo=85+ia9d5=x-6A@mail.gmail.com>
Subject: Re: [PATCH 08/12] MAINTAINERS: Cover Samsung clock YAML bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
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
> On 30/07/2021 17:06, Andy Shevchenko wrote:
> > On Fri, Jul 30, 2021 at 5:50 PM Sam Protsenko
> > <semen.protsenko@linaro.org> wrote:
> >>
> >> New device tree bindings are usually added in YAML format. Fix "SAMSUNG
> >> SOC CLOCK DRIVERS" entry to cover both txt and yaml docs for Exynos
> >> clock drivers.
> >
> > Fixes tag?
>
> No need because the pattern is correct at the moment. The patch does not
> make sense on its own and should be squashed with the next one.
>

Nice catch. Will do in v2, thanks!

>
> Best regards,
> Krzysztof
