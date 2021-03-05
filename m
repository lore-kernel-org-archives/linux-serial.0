Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646F7C433DB
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 11:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356A664F52
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 11:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCELqE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 06:46:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52455 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCELp6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 06:45:58 -0500
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI8u4-0004KV-Bq
        for linux-serial@vger.kernel.org; Fri, 05 Mar 2021 11:45:56 +0000
Received: by mail-ed1-f72.google.com with SMTP id q1so805893edv.5
        for <linux-serial@vger.kernel.org>; Fri, 05 Mar 2021 03:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2TleSw0QiCwuJ7skQQModBnCrT+uYovU4V6hKBAXhss=;
        b=R2yvkHWPF2S+Bh+O2cNfVDq67iqYmFKzYHj3OXUXV3ZFqmuBkVhEYgDRQIOJe91Ws0
         qaUQ3wUu9WJfUUNe12M10UBDT0h1lIBfYlcBp953ndCGamZy/BxDQx8ld64wEULdBGcQ
         kIruBGbiSfL/T6RdSSh/coFwB3KmJtF308IRZOSyRqhJn1ooBUBN31dxToI2VK7m/R3b
         uU4YLO80gNUU6AfKypyqZv6aJylWoMDLIxGEKRVRuu9J46mwfAtU0KoY6RlhCTMKiNju
         17yM3EnFivF/zPvOTZ9VLEilaomaQroh7JG9endW26wzfbp3Ctio/NK99Yc6AaKwrUA+
         X3kw==
X-Gm-Message-State: AOAM5311yZ+/jBLTaBkBsmUhtMblElefW1TxBeEbD5fWN27W8x74hFge
        Aw0tskhUYU4yQ4iTeXNcM27yRVKATSaNB7tr10OxSW9hjwml8fIX5ubWEwAoSGu/0XVA2LAxViK
        +ZCV4mEoSqEN3r1ntqgMjMEBJf4XR4sCu1qlju6lO/A==
X-Received: by 2002:a50:da8b:: with SMTP id q11mr8953747edj.352.1614944756169;
        Fri, 05 Mar 2021 03:45:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKeo3Q/o1g2HQg4LFqmEh5BntZBVMe2z8slgQtUV9JbA5vQAZ8ZZGavMyBJMDCCXlKF5n8Tw==
X-Received: by 2002:a50:da8b:: with SMTP id q11mr8953731edj.352.1614944756036;
        Fri, 05 Mar 2021 03:45:56 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id s2sm1431854edt.35.2021.03.05.03.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 03:45:55 -0800 (PST)
Subject: Re: [RFT PATCH v3 27/27] arm64: apple: Add initial Apple Mac mini
 (M1, 2020) devicetree
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
 <20210304213902.83903-28-marcan@marcan.st>
 <e45c15ae-ee81-139c-5da1-a6759e39fd71@canonical.com>
 <2a4c461a-51d1-60b7-b698-edb3c0bfb243@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <32c136df-f4d4-4fbe-6605-5366b06d9f0a@canonical.com>
Date:   Fri, 5 Mar 2021 12:45:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2a4c461a-51d1-60b7-b698-edb3c0bfb243@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/03/2021 12:14, Hector Martin wrote:
> On 05/03/2021 20.03, Krzysztof Kozlowski wrote:
>>> +	memory@800000000 {
>>> +		device_type = "memory";
>>> +		reg = <0x8 0 0x2 0>; /* To be filled by loader */
>>
>> Shouldn't this be 0x800000000 with ~0x80000000 length (or whatever is
>> more common)? Or did I miss some ranges?
> 
> The base model has 8GB of RAM, and RAM always starts at 0x800000000, 
> hence that reg property.

Ah, I messed up the unit addressing and number of zeros... it's OK.

Best regards,
Krzysztof
