Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4341EC4338F
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 10:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E1C60EE9
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 10:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhHIKqv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Aug 2021 06:46:51 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:40388
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234741AbhHIKqp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 06:46:45 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id B3E7E3F358
        for <linux-serial@vger.kernel.org>; Mon,  9 Aug 2021 10:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628505984;
        bh=yt7czbeHRo3zFzMadQuUQl5b/q3O9yrC7ug3tMqy3VU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=uOeLNVLV6il96pv+W8JgENhSP5m/6X1fWqvKyDdU/Vx2kZzsgCgD+vSqFdBZbRR72
         OTayRglhsyUgip244HoZ6g3PF36OLcIPHTFy5BRIyQkiVOdH5Vdj6y1f7El8uYUjNe
         6BsGb7oNTkcdXd5yOxcjqTQOUY6Y3HcSmPtWWRKlFgO4OGn3Oj0cME61lD5KBKIXKg
         S5yu77gIoDyEstCK0t64TlGp1g1uvak/MAI+RTLDdHmTpdZFdT9nMp4nZ6ngHxqK/M
         oCe4ezMdDWv12Y53t8dxxJGGrCQy2OqhghGXvvJpovD4i3lqojq5sIO+m/Cm1ILv28
         +rJDgYrLVmajg==
Received: by mail-ed1-f69.google.com with SMTP id dh21-20020a0564021d35b02903be0aa37025so6426603edb.7
        for <linux-serial@vger.kernel.org>; Mon, 09 Aug 2021 03:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yt7czbeHRo3zFzMadQuUQl5b/q3O9yrC7ug3tMqy3VU=;
        b=YoF082745YSWH9R8Md54Na9mu9cEoUw3XelOwBI0Vw9kxsEo7ET01eJnu00WDqWyjl
         UO7YuYLpPTmV0oHQkbF6GNj71+cufhuh5OQIbfvM6OIwcqPRD7/Es7vYeEsyMiv31AS0
         WKHm/XpAwkPg3GoDNqyMKsOWp9As8fQFYcDw8csaWHvCucS0seFE4pB2wyZoGgYcy2WK
         OU6pWZA73jDd3+3EJSHJ1RB0ERH987EaF2zvjCHEWRCPH26wYj8D11XkE21p4jOGY5cq
         3NyhGogw6Y2sQVG698DAoSdI2RyL/sAmQh1DH0qcK2RkOUB8x1ApZvnwRL6MdpmPA3+V
         37XQ==
X-Gm-Message-State: AOAM532S2CQWKQbl1POhylpiABx57HMEz3k8WUbmbNiZbICCsi5v0yeq
        sqb5L1AjHwyz3AE9NuV6GxnsNgs6DSvsXTmRCuXjB2pRmAiMLsc8zCoBKPc+jCDBm4jA8Fo4Cb9
        HFEV0LoUZFdJ8q9dFEDIULrrS9FWjJbxRhV0UH1p5WA==
X-Received: by 2002:a17:906:4346:: with SMTP id z6mr2946648ejm.403.1628505982425;
        Mon, 09 Aug 2021 03:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwilRElb69ECVZp5XBCmIh/rGOdeWiuwyHyABm9gfRG9GvWksDs334T+DetejTgQ1+PQ9rACw==
X-Received: by 2002:a17:906:4346:: with SMTP id z6mr2946634ejm.403.1628505982295;
        Mon, 09 Aug 2021 03:46:22 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f5sm5733019ejj.45.2021.08.09.03.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 03:46:21 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] tty: serial: samsung: Add Exynos850 SoC data
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20210806152146.16107-1-semen.protsenko@linaro.org>
 <20210806152146.16107-7-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6169e25b-2829-628a-f910-348ddd4b3030@canonical.com>
Date:   Mon, 9 Aug 2021 12:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806152146.16107-7-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06/08/2021 17:21, Sam Protsenko wrote:
> Add serial driver data for Exynos850 SoC. This driver data is basically
> reusing EXYNOS_COMMON_SERIAL_DRV_DATA, which is common for all Exynos
> chips, but also enables USI init, which was added in previous commit:
> "tty: serial: samsung: Init USI to keep clocks running".
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Fixed default fifo sizes
> 
>  drivers/tty/serial/samsung_tty.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
