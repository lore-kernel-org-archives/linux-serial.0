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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C0C43214
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B04A60F46
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhG3PZJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:25:09 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47392
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239759AbhG3PZI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 11:25:08 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 0A58C3F114
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627658703;
        bh=x+6pX9ZPyUiM1Rt9roeiBBTX1oDHG2m/9+XL3uN84UM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=OPX0PR1knesfNULsuGUn0/Z2U8fBLZt8akNQbaZl4UFZw6IDPYhCz/wYNgS7dRhWt
         igAT9PobbL6ZENqudJEQEPwBnPT8cxdVj+hvW2/gF7qSOmZ6zlHI51RxdGvVi6zQ6u
         wGT7Avs2QTCdQdEewEX+Znmdn+CgCga5TFx6k+pKXtGo8LZM/3EN/ak9S5T3PRGekh
         GT3RI47AeBLa47k52aTk3Qgak/Zy874IgQY1//wLIB1uekArNE8tlSXDalPqwPu/ru
         5uxFuv9lPRQVhsZLUhFtiWfeJ38BZPYH3KyX8fB3PaN445ZlttMnrQTLVHmJQLyguw
         UjvkrdcoXlodw==
Received: by mail-ej1-f70.google.com with SMTP id x5-20020a1709064bc5b02905305454f5d1so3200356ejv.10
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 08:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+6pX9ZPyUiM1Rt9roeiBBTX1oDHG2m/9+XL3uN84UM=;
        b=PuNYk0cs+PnaTbwxJ1ZLjFkoclyLAuzHgeAAUOJShOKSpxxLM+xGs1pW3pm1bsjFS/
         WzxJAUQMW9IzWWaQYjIfxRu+A0zYTKjaTdGEWsBA5IFG6+vvcNLe8aK9kpiIZo50ywQE
         Vo9tR5gT0bPknXLdWzQDpzjsC/87/fdpdaxMdYxhvUpTB1vrQ2uAOEQp2X1Vu8KRC23C
         rFNuOju3jpK8EY/3xNRpKgeAAFey3JFeqjyDzRWxSe6+NhCa2ThTBgAcNLP0MwqR30TW
         q8LuUUyMRcjNzFdPd9HmeyIVjel8344TSgIToui4Jj7bFITRFYEPtHu+wbqyTezmdyts
         3Pew==
X-Gm-Message-State: AOAM531J5TpaTrSJchTKaD7onNebcz34lrQ5aNGR6ftp4ITnn7I1Hs31
        aoX81ijcZjP7KazLLC/VP/INrMmrYc8Q1MOWPE2XIOFDtj5ugOTNmf9eQucsQugsZQbSaWrjuZg
        3X9uTrqmMZAfmmHrnY9MisPIMbiDr8zzU1mOuckGE9Q==
X-Received: by 2002:a17:907:75cd:: with SMTP id jl13mr2947109ejc.327.1627658702302;
        Fri, 30 Jul 2021 08:25:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqqUP+KIIGoq9q1WH1X67AGbVHunzdzYqA1b+ewcbCdTxqa8OY5fibzCtJefglr1Ece6TTig==
X-Received: by 2002:a17:907:75cd:: with SMTP id jl13mr2947093ejc.327.1627658702183;
        Fri, 30 Jul 2021 08:25:02 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id p3sm699984ejy.20.2021.07.30.08.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 08:25:01 -0700 (PDT)
Subject: Re: [PATCH 03/12] dt-bindings: pinctrl: samsung: Add Exynos850 doc
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <61a6c636-6f72-d086-79b8-e87dbab6b456@canonical.com>
Date:   Fri, 30 Jul 2021 17:24:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730144922.29111-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/07/2021 16:49, Sam Protsenko wrote:
> Document compatible string for Exynos850 SoC. Nothing else is changed,
> as Exynos850 SoC uses already existing samsung pinctrl driver.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

The patch should be first in the series - dt-bindings go at beginning.
Although no need to resend just for this.
If the resend happens, the fix ("pinctrl: samsung: Fix pinctrl bank pin
count") should be sent separately (no mixing fixes and new features)
because they are independent and usually easier for review.


Best regards,
Krzysztof
