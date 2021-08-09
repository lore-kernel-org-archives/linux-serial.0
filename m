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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AA7C43214
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 10:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DC161055
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 10:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhHIKqS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Aug 2021 06:46:18 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:40276
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234752AbhHIKqR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 06:46:17 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 19DF73F361
        for <linux-serial@vger.kernel.org>; Mon,  9 Aug 2021 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628505956;
        bh=pwc/Ajo5YOokojxDuHXAQR0/29n7VNaZg9Jjhi/i3UA=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Q60ZbUFna7/QG2AIEyZlcDh3f0TKnwyJKHWNcWUFkNxkErBMOfm+XgETSbd7I+Eol
         zhZ7xbNz9JhviTaVJLCvVzSb4tQ1Z/qNVYh8Q2q2z1F2yeU2yehL5xdxoxPdEWMpcn
         YOfznve5yt6VY3ItuI4bVt6iFSEVtmPOcFwBtKFkZOVEPc4UxQacRrNpO8lrAki2qP
         SLHOZgB0mv9l8/M1GzkMOcG2AAjEIRuBDUa+3F7bFpZaa7Boasvx4F0dAJTfyEyCOj
         OQu3POhBIyxXnNC+A8+X+rN3hZycW1iz+Es0fAWu6iXKnF9hEDd3lXXhGjU+OUS85+
         sPAec+CNQdxrg==
Received: by mail-ed1-f70.google.com with SMTP id e3-20020a50ec830000b02903be5be2fc73so2657399edr.16
        for <linux-serial@vger.kernel.org>; Mon, 09 Aug 2021 03:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pwc/Ajo5YOokojxDuHXAQR0/29n7VNaZg9Jjhi/i3UA=;
        b=nQF4hpAdKJl/w2mU1/ouxkMcaish9sMJdtHkEKh8PkmkUBsXa5g1iEqp3QfMYgxeKi
         JOkZYMmCDvWljOk6HCDCikOw3LT3zft0/A5tEe/2Br6165F92s1p18MPmSJZexFOFXdL
         0TTirY24MoHyVYlvwg41OHvY6ICXItETPlTrCKrM8bA9JrvMZFzREV3P5oBZKuBsNXv7
         rVWUiCGftf4apt0KfxvkwxdCbeb/KSEj5N8xoU98Io6mu2SJT2z0PaUAqkDCiQxBa11M
         ofCHta58ByWawxneyN69xJBNYbgGzji/P3Cx5B1ELjtTKHi/hhYT4zj0ucd137Nn4s0Y
         e60Q==
X-Gm-Message-State: AOAM532G2ivteh4IlGfKVvwO02OYRjJ1EWvzhdcyfROAmXTZVsLunKDm
        RYpdWdVRC+XcsEvgrWQa0r/ORNtbg3imp6xsvwbXwmssX2GbumQSaOyYhd5g2Ve3DR4nlM9Az5y
        YE0mTo5jEaPJGee+Ad/70DPPIg4DfOMwO62ipRPPrlQ==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr5179315eds.108.1628505953486;
        Mon, 09 Aug 2021 03:45:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFSBcXzH8i0TbMJa2dVdWnWI4e22vKyQF/gVsYMDX7OTcWMN3P9vHHAxa6pmNrrW6QiFGZ8w==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr5179300eds.108.1628505953372;
        Mon, 09 Aug 2021 03:45:53 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id m25sm2212168edv.81.2021.08.09.03.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 03:45:53 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] tty: serial: samsung: Init USI to keep clocks
 running
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
 <20210806152146.16107-5-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <85df3188-0227-f926-61bf-30db1a5ef41d@canonical.com>
Date:   Mon, 9 Aug 2021 12:45:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806152146.16107-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06/08/2021 17:21, Sam Protsenko wrote:
> UART block is a part of USI (Universal Serial Interface) IP-core in
> Samsung SoCs since Exynos9810 (e.g. in Exynos850). USI allows one to
> enable one of three types of serial interface: UART, SPI or I2C. That's
> possible because USI shares almost all internal circuits within each
> protocol. USI also provides some additional registers so it's possible
> to configure it.
> 
> One USI register called USI_OPTION has reset value of 0x0. Because of
> this the clock gating behavior is controlled by hardware (HWACG =
> Hardware Auto Clock Gating), which simply means the serial won't work
> after reset as is. In order to make it work, USI_OPTION[2:1] bits must
> be set to 0b01, so that HWACG is controlled manually (by software).
> Bits meaning:
>   - CLKREQ_ON = 1: clock is continuously provided to IP
>   - CLKSTOP_ON = 0: drive IP_CLKREQ to High (needs to be set along with
>                     CLKREQ_ON = 1)
> 
> USI is not present on older chips, like s3c2410, s3c2412, s3c2440,
> s3c6400, s5pv210, exynos5433, exynos4210. So the new boolean field
> '.has_usi' was added to struct s3c24xx_uart_info. USI registers will be
> only actually accessed when '.has_usi' field is set to "1".
> 
> This feature is needed for further serial enablement on Exynos850, but
> some other new Exynos chips (like Exynos9810) may benefit from this
> feature as well.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Non-intrusive modification of USI registers
>   - Improved comments
>   - Rearranged USI register definitions to conform with existing style
> 
>  drivers/tty/serial/samsung_tty.c | 32 +++++++++++++++++++++++++++++++-
>  include/linux/serial_s3c.h       |  9 +++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>



Best regards,
Krzysztof
