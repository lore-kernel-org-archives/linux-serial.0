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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB3CC43214
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 16:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F52260F4A
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 16:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhG3Qe7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:34:59 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:40970
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhG3Qe6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 12:34:58 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 249703F24F
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627662893;
        bh=LOZkX2Gn1AlaUpgTb3/KKeIofvF4AshHz3LJwLGMhDk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=NPQ+KU4iCL7fvE3s9FKGfAC4SHla0KCOsGPHtY8ewTRaglRYNH041fct6BzwMw7cY
         dP657bb0JQqWrjCB2GD/Iwfy2o2q6Zj+juBAJCaipfzf6eTUoo2OEpamt8OvTmfTOe
         Ybbf+WRem6IAvhJQBVMc9fftBiTOp/Zz03CDN6i02rQdeOxulSqrabSGGB8DZ3+a8X
         IVM2Mh/ulhZLyWJQGB5VI8HqplRJB0wnvuy8/8SyL7opc3BS6dSIgS0d/j00NNT4mU
         bPew+ProxjhEWJa71d09pA1ksA47cdm55eFKqF+hDYpiqLx+1zeeokoUeo4+XcJo7F
         L5j9Q80NZiFLQ==
Received: by mail-ej1-f69.google.com with SMTP id kq12-20020a170906abccb0290591922761bdso2018947ejb.7
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 09:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOZkX2Gn1AlaUpgTb3/KKeIofvF4AshHz3LJwLGMhDk=;
        b=o+CqmullrlXAI2UjsPqlvWQJxbn4uh5M7rw1K4f3Tfy+OETjWM6Xth3oO5s52BFz4e
         VRDjCCZbIjg8dYRW/9o3+MvuUKSPaWf+IP+zT/DyvvGorNZBpPsalXO2HcutlV1sHceD
         3ApBixtFlGobahm+6YrfSRFgj2i0F1TgK5urAZcseJ8cMaITMl3NL5nF2WdxoaWq1zZo
         /mDYno8Q1C3Oz2WZx6q34divvcH9/Ogqx9N0XGwa2zL6RMtQT8MtdSQItipFoqmezfZb
         afNCmdTYz48e3l04If+TnJYMqTJsgSmhPWChT72/dKDpyTcObB7K6je4WTd9dqQSMU14
         O6aQ==
X-Gm-Message-State: AOAM5321pN6waoQucJqwNUBSzLahuLV5fT0/LJKHmzNVsHWdogNLoBXG
        V/RAovv35gRNC1wtANbn5XkuKu89Xb+CFivL2xrIK/YnuLaUJSbxeIUtqXP5p3N4X5cvDalZ7D+
        3TQPOtC/y2BF2V1wiBMrwjnM3tRpeg23RxhvgEcaQnA==
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr3262420ejb.511.1627662892671;
        Fri, 30 Jul 2021 09:34:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAQ3oDEvssRhYOquKsKs0awtj++lTiixkq4+khiYVFew5afUiOqz586WxPl24Q2+jJCRUS5Q==
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr3262411ejb.511.1627662892551;
        Fri, 30 Jul 2021 09:34:52 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id b25sm928440edv.9.2021.07.30.09.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 09:34:51 -0700 (PDT)
Subject: Re: [PATCH 05/12] tty: serial: samsung: Fix driver data macros style
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
 <20210730144922.29111-6-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e11d0e60-9bbc-16d2-c8ea-42d3d93e97d1@canonical.com>
Date:   Fri, 30 Jul 2021 18:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730144922.29111-6-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/07/2021 16:49, Sam Protsenko wrote:
> Make checkpatch happy by fixing this error:
> 
>     ERROR: Macros with complex values should be enclosed in parentheses
> 
> Although this change is made to keep macros consistent with consequent
> patches (adding driver data for new SoC), it's intentionally added as a
> separate patch to ease possible porting efforts in future.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
