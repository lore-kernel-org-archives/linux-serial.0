Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1D8C433E0
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F61E65023
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEKa5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 05:30:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50057 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCEKac (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 05:30:32 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI7j5-0007D2-TI
        for linux-serial@vger.kernel.org; Fri, 05 Mar 2021 10:30:31 +0000
Received: by mail-wr1-f69.google.com with SMTP id h5so859096wrr.17
        for <linux-serial@vger.kernel.org>; Fri, 05 Mar 2021 02:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kJu6iNTkK4wSmf0pqRfj82yyDdC0OqRkZT1hSBnQXr8=;
        b=jdwLxl9755zTc8icfepQPSpNbRScFADY0Ku4MJMAYsukzL91s50OKDeynv/IFwCGkM
         Fc9KP2gZ0whpWsA52FE+OXSJlSHlIVCNFAYwDt6HadLYMUkeB7RdaBfrl0j/INgGIFIm
         wvPw0335R1oYwecaM6WzdQeRUZ2WM3ejlsQNRPnp6b0gN8KUXOrZGrvXXpeOa+K7cm+N
         sQOIT9N/dmGDVVE6yAVpSa1hBHcmzbujk4kDMdy86KjvRILwoM2MpMFUr5YtFNgRd9Ui
         f26M/clwHzsbjFBu81PEWTAueVRzochP3L9h2/L0TKA4J/TFONAklD3yOjfVoLjzTMly
         QZKw==
X-Gm-Message-State: AOAM531IEoh8Q6yAll18/lXnwTtmC1lUULYdH8K5UZ1QCHs5vRDyEKpa
        W4ZnUj1Fa8rYzM1YW2ZayzYf960qggkMMGmlI2l757rKo1PagId3YojxeQ6R8tQ+oHVPq0pOYWe
        GTTaMRNKAV1XPzoPzaJt+IN7j9x6uLAVrjZRmUV+e6g==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr7981751wmi.107.1614940230676;
        Fri, 05 Mar 2021 02:30:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy800OFDrvV/rynegL9gdp5sOoCnfFTAFviFAiUlwZkphbdPaIzFS7W/py4nWV80SKpjFhzmQ==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr7981727wmi.107.1614940230567;
        Fri, 05 Mar 2021 02:30:30 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id 1sm3878530wmj.2.2021.03.05.02.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:30:30 -0800 (PST)
Subject: Re: [RFT PATCH v3 18/27] tty: serial: samsung_tty: Separate S3C64XX
 ops structure
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
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-19-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <cf61a889-b84d-f788-52f2-9b68bcc83d52@canonical.com>
Date:   Fri, 5 Mar 2021 11:30:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-19-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/03/2021 22:38, Hector Martin wrote:
> Instead of patching a single global ops structure depending on the port
> type, use a separate s3c64xx_serial_ops for the S3C64XX type. This
> allows us to mark the structures as const.
> 
> Also split out s3c64xx_serial_shutdown into a separate function now that
> we have a separate ops structure; this avoids excessive branching
> control flow and mirrors s3c64xx_serial_startup. tx_claimed and
> rx_claimed are only used in the S3C24XX functions.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 71 ++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 17 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
