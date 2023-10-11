Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00269CD8C9F
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 08:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjJKImw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 04:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjJKImv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 04:42:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A332FDD
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 01:42:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ba081173a3so740910166b.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697013768; x=1697618568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQVblcaazyZyyU0Xz3jnKqUUTme4HT3sP0gqd9Rl6LQ=;
        b=nGskIy8t17VQGUMqu+P1RGj8PpN/Cncib72u3CzB1TeWEWCjp11pkjflmMwI9VTxhx
         1PGwA8U2r4l6UCuXh26mNq3ZM6ZBHtnXlSEW+FjPg0C7XtjJsfziE1NGkdI5dK0AMBNu
         Y+z/BgKyuME17W3hraarej06cbrDSvQGQBA2WGvs2mSTqQAYzyVVeBi7SXYrrMfw4HP8
         +Q7Wh2tJxu21x06a84E4CdhcGIakC3bOncY+rJoHtbBStsgGQIcnQWLbZRhdGPgr5VqF
         2LsFuWupNM7ywYzskw3SlV4GNvBlA7p4iaOjUcegLHia+o8htd6K2NrCyzYzKpZl7zdD
         LCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697013768; x=1697618568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQVblcaazyZyyU0Xz3jnKqUUTme4HT3sP0gqd9Rl6LQ=;
        b=wWdB8YXdbHgv+LjtKDWiBh8xGoqmkY1g/rhOly+LJfqXuQvvc7Q3RYFcCOuMCLFEAP
         dW7SaAssvPi3434pRVPYO1GILhsXBo3SZ3+XtHoPVA4SgLOaDGWA4kK3MpZMaXuIsk+9
         sxtxEAgVRwu6uQsSiz61o9qv6u7RwBn91nEIlWvKBNpul7fFL8MkVS6XTKa4Q0LW4j8p
         T3zgDNaSBxH8iHbM00JvTyuSF5Lzp030bq40zmiIdPJAjDbBJAO8E1V5ToFDt87HWlFy
         yrKRWER0a/65CQORX5xcU1D+btmq+cqVHA4Jn8XvbeJXm3mXl2WqRSNGysI3xH224cpz
         Evdw==
X-Gm-Message-State: AOJu0Ywkx68oBZTWmBzppSGW0maQmNDHaVg5c98XzBIyYpflcKcKm8UC
        n3taUKfQ64cIr9gxuL530mrX3Q==
X-Google-Smtp-Source: AGHT+IFFg9jr8zTjiY0TW0V0idrabs2Pvc3T+NkXfL0RZxNQvIFEQsPwLLN6izM2Z3nlnBAnK9uYbg==
X-Received: by 2002:a17:906:1097:b0:9b2:b786:5e9c with SMTP id u23-20020a170906109700b009b2b7865e9cmr17958158eju.28.1697013767910;
        Wed, 11 Oct 2023 01:42:47 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090681cc00b009a9fbeb15f2sm9536588ejx.62.2023.10.11.01.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:42:47 -0700 (PDT)
Message-ID: <14bb7d8d-0f99-4a5e-aee6-b0db1d17c1e6@linaro.org>
Date:   Wed, 11 Oct 2023 09:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] Add minimal Tensor/GS101 SoC support and
 Oriole/Pixel6 board
Content-Language: en-US
To:     Peter Griffin <peter.griffin@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, cw00.choi@samsung.com,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
 <92de302a-f6b5-465c-a5da-2a711861089e@linaro.org>
 <CADrjBPqOmGEzeVEKiysxQNo9+B0=zD3Z+G24fPDKrFsgUXYJjQ@mail.gmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CADrjBPqOmGEzeVEKiysxQNo9+B0=zD3Z+G24fPDKrFsgUXYJjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 10/11/23 09:16, Peter Griffin wrote:
> Hi Tudor,
> 
> Thanks for your reply.
> 
> On Wed, 11 Oct 2023 at 07:10, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Hi, Peter,
>>
>> On 10/10/23 23:49, Peter Griffin wrote:
>>> Note 3: In `dt-bindings: pinctrl: samsung: add google,gs101-pinctrl
>>> compatible` I tried to narrow the interrupts check to
>>> google,gs101-pinctrl but I still see a warning: gs101-oriole.dtb:
>>> pinctrl@174d0000: interrupts: [[0, 0, 4],[..] is too long If anyone can
>>> educate me on what I've done wrong here it would be most appreciated!
>>
>> I guess the initial definition of the number of interrupts should
>> include the largest min/maxItems. I no longer see the warning with this
>> change:
> 
> Yes that is how it was in v1. The review feedback though was to narrow
> the scope to just google,gs101-pinctrl compatible using if: then: else: which
> is what I can't get to work properly.
>

Right. The diff that I sent is on top of your changes (patch 6/20).
I expect that when the interrupts property is defined it should include
the min/maxItems of all the available SoCs. Then use "if Soc" to narrow
the range.
