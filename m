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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EE7C43214
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 16:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B39B60EE6
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 16:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhG3QgB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:36:01 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52956
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhG3QgA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 12:36:00 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id A20073F248
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627662954;
        bh=r6WBOzzzU71Avbpbkb7MJv5FMhuteThAgMvx7ePk7s4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ezwLRmvHQ/MfPcVmQT1RbewuFDc5ZpJ/mMgMzx32gPb7jSD4dNQkO343EUQDi1j3y
         WEPsuTiNDBICn+1SSt7auYbrfp7tpP+diR626Es2wITargm0m2FEOPcH1Tu16ycUmF
         r2vbfpc+iHEtkjrGN49cHa27aNrWU7ziocUj4dvsfCXkq6Qv/Vlq2j2Pdoro1TDmVF
         nJ78AzLKgJfwg0KWjFpQyzXrhRnyPD5vdVa7tn6Xm75HD9cZK7tocPWGAX9FsQb8Hq
         4mgOnJtDtUpmbUNjVNICkOVatBnHvV/tykFZP+9Fl5T6vou8PqBHkDZrIFzlKb8a7S
         +truZ6NHC7QPQ==
Received: by mail-ed1-f69.google.com with SMTP id x1-20020a05640218c1b02903bc7f97f858so3267081edy.2
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 09:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r6WBOzzzU71Avbpbkb7MJv5FMhuteThAgMvx7ePk7s4=;
        b=EjpHPZdFjY+55Q4jA4o1z5hq/dkSqRL4jwGogLj8Z2KZjJg6ebM4ry8G6uBRh+FGi5
         OLyYEkjFMHGIGhsRfQUWzzMvzuPWIblPkUr/irxDzkwIJdL7A1PFTD/hvfkqQPdfQZKU
         enLCMzwZRtvrXZ5ulzvZTC8aU4WompLOyZ2jWZFEmPYTR4XgF5ehFG5gRW3yqJ95xpdq
         IVLjv22vupqNrffUkmuyZ85M572ORSYiLSI1ldrO/5gBvDweH4/G/z1j/CuTID7jd/EV
         JhV+vDaIYliDp4WfuikJBP+pez1pvLqA51/w1YT5MCmlKv8uXyDXUe8WvFiaNDa26rpz
         xAVg==
X-Gm-Message-State: AOAM531EeRhhWoHkVWJGLMLelJm/E4TFm97Fm2xr17bbZidJwLgsPFS2
        +FrY5Yld2BhFfGLJkeRWAis3jYrTgKofWJIvtfP/Uo7+PUw4ZGHbJLE8rA50olhglk3HoHg3GP4
        zyu5CNfRw6wvWDCpUuDQ2hv+h4+qsXOijS2oONlhZQw==
X-Received: by 2002:a17:907:766c:: with SMTP id kk12mr3257240ejc.525.1627662954042;
        Fri, 30 Jul 2021 09:35:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWkxEaV8vcHXDuB7QVly4oizqMQCUQ0S+bTlZqlWe7m7kMOzOsno/9k+vpyqKWr+t6iPU+7A==
X-Received: by 2002:a17:907:766c:: with SMTP id kk12mr3257225ejc.525.1627662953841;
        Fri, 30 Jul 2021 09:35:53 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id la23sm734067ejc.63.2021.07.30.09.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 09:35:53 -0700 (PDT)
Subject: Re: [PATCH 07/12] dt-bindings: serial: samsung: Add Exynos850 doc
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
 <20210730144922.29111-8-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <45da758c-d32d-293b-f4c7-12b58ebca8ac@canonical.com>
Date:   Fri, 30 Jul 2021 18:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730144922.29111-8-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/07/2021 16:49, Sam Protsenko wrote:
> Add compatible string for Exynos850 SoC.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Thanks for the patches!

Please put this one before other serial changes but does not have to be
first in the entire series.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
