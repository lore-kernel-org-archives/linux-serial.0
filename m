Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67351C4320E
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F68B60FA0
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 12:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhHCM7C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Aug 2021 08:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbhHCM7C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Aug 2021 08:59:02 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D465C06175F
        for <linux-serial@vger.kernel.org>; Tue,  3 Aug 2021 05:58:50 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id t26so8130957uao.12
        for <linux-serial@vger.kernel.org>; Tue, 03 Aug 2021 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNSRpZlFlkmyaZcGeRCdqzNpmwaM/CsxmQZTU5Q+xqI=;
        b=JTvNoxAfXZ9vd1+wTKKiK81cryvFYXUGiGJWt11dtugSKCRZzRqEhcPYJix7xbxCp3
         YKo8vQZvgq9xZzfTHfarl0LQRITIaB4flkRr46M/PM11DUdJZCYJj4JHzB1m4bqx5bK8
         EtJobyfZ5hYhOHAmCcTk1L77+1UWYJBdyJGjdJ30Ntetl239/qIi+Fiv0aETt/cPMddI
         ms9C8NsZJic+woCQWggmqJrKuEW+FhJ3tl1PWC1C8h6wEZIajpUf5wuiwiZo6WQaNEmA
         JlftDOWGep6h0KpoD8jIiUEJIHA707wXiVqyP72XfW2jJC1M40uKyybpRAtzIlzWGXYI
         vljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNSRpZlFlkmyaZcGeRCdqzNpmwaM/CsxmQZTU5Q+xqI=;
        b=cICJlpGipu8ltK8FZZCLOaTKwhk1LZwwLehe5/9jcHkHH5vc9UQvNrpQITgfK5nR6R
         sc/fKSdMM4knlqESem7BKG/74VzuM0bal/EB7WCKMKjnHlTFV6bzze0yZ+xeeDL2rTAK
         3CAw2l6hpBrm6//MtraTRliNn8sb+wUaFew3BMul/Lwsg4hrBZMJL5bTKKkiSOTQ8R1x
         yspDaurAuu+wIPWyFi5xr4RQ9NDLcv3dDtPTxOhAD0iKz5YDAWBodZTaIIIeXOmjx8gT
         Zueyi35EE/K+Pav7DMqzzHzQpj2xY6x8DM7wDM0hsOUY7yIQE+6tzVsi+CbR017tXeve
         ieUA==
X-Gm-Message-State: AOAM531e7qs9VjMmaVxLYRoMj+OB1Vj0mdMeN5Df6qu2Xlqrwkob/Hzo
        DIuHdmnTLASTjq1pCCv2GKsK1HhVqEuKmitksa8yWw==
X-Google-Smtp-Source: ABdhPJwmT+9f8+SVTRLGGJ8jMXd1p1owMfyXKEFiXfIxd5UXzXpXp2cbHPwsCzFyYJ/B7mnJE2eGb95SBJDpnGdNpVs=
X-Received: by 2002:ab0:6f4b:: with SMTP id r11mr4698819uat.104.1627995529623;
 Tue, 03 Aug 2021 05:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-12-semen.protsenko@linaro.org> <d603be80-4fb6-1bad-1963-c9fa7d1e63fb@canonical.com>
In-Reply-To: <d603be80-4fb6-1bad-1963-c9fa7d1e63fb@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 3 Aug 2021 15:58:38 +0300
Message-ID: <CAPLW+4mPeSOuiQ1iYTVXqTzmPP7o1uPX8Gapzr7Es0wRBpYt6g@mail.gmail.com>
Subject: Re: [PATCH 11/12] dt-bindings: interrupt-controller: Add IRQ
 constants for Exynos850
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 31 Jul 2021 at 11:45, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 30/07/2021 16:49, Sam Protsenko wrote:
> > Add external GIC interrupt constants for SPI[479:0] for Exynos850 SoC.
> > Interrupt names were taken from TRM without change, hence double
> > underscore in const namings.
>
> I am not sure what is the benefit of defining these in header. Unlike
> other DT consts (e.g. clock IDs) drivers do not us them at all. Using
> them in DT does not reduce chance of mistakes in numbers - instead of in
> DTS you can make a mistake here in header file. In the same time, they
> grow the interrupt property in DTS making it more difficult to read.
>
> I also did not see anyone else using this approach, so it's not only me
> (Marc also find it confusing).
>
> If vendor kernel did similar, it's not an argument. Samsung LSI /.
> vendor kernel has terrible code quality so usually it is not a good example.
>

Agreed. I'll use IRQ numbers in dts directly, in v2. I probably
thought that IRQ header might replace missing public TRM, but that's a
poor substitute anyway.

>
> Best regards,
> Krzysztof
