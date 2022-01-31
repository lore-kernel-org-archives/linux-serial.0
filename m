Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06ABC4332F
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jan 2022 08:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbiAaItN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jan 2022 03:49:13 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33530
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346972AbiAaItM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jan 2022 03:49:12 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F3E103F1FD
        for <linux-serial@vger.kernel.org>; Mon, 31 Jan 2022 08:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643618950;
        bh=svjshNSefoEJYwgVi4BAg4xIyTtW+DljH24XBOGceLE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=J4mbK4rV4czGz0m3S17DJDhD7DWcwhB8Qfvvf9yFooKKX/z2VgNNSktf8FotwWA3/
         2hp+5t+B6I28nQ3Wt7kOyTpt7hTeWLVAeBdE0xcHl7FF1Mt7sLI3e13Eck3yz2lfNJ
         LAbBWyVKmon7p6W8k9dnJb8RMVSFknsGm3bJXhq1ZYa7o2b2labPYuoZsYlPw21w1q
         A5knLSLdlageVNYEICrcdQGfP2A/WzZMaHbs5rFdsoLvgHieHkCaJRrCY8t7kNiDA5
         ol7yTJyvrI/x+N51OSEj6QpgCShnSYVCSGMEw8TQrv3rAUQt60GXTsNgKreistccT2
         VSYav/lwXs1dQ==
Received: by mail-wr1-f72.google.com with SMTP id a6-20020adfbc46000000b001d7370ace6eso4532036wrh.9
        for <linux-serial@vger.kernel.org>; Mon, 31 Jan 2022 00:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=svjshNSefoEJYwgVi4BAg4xIyTtW+DljH24XBOGceLE=;
        b=7Yrsk8fSfmvUeOlBCDiWGiv4/bKpShDOfnYIwD1hHyV5mf5hgFLhjAokRd/PjwtAHS
         lwceKvQZtk9GK4w8ikEWnnN8uQsVHhAnREEyA+ZId+N2j22rFSXWW0B1F89q79H8tfJ3
         PMTIpgAPE8cd/RnJ30AHYlTca1G7OrDudxEHyc+XZftRG8rVt+h4cSNl+ZYKr95vR/3+
         9EGyDITwQ4BoDSr23e2O429Gk1yjEmltU0mrDBSvbEb27H1PqQD7QjlD3iRq8CpynW5g
         /A5G/mAotQItpzS6Sb+7h7V+ww8/jAeEpu/YLH9yZeKedmNhuVKghMuhu7hdFgRSFUbn
         hmXg==
X-Gm-Message-State: AOAM533+UHG8FtOZj9xK9bIITcGLVRlvuG5wVFQfpw7Zfq9GXz/4FTCN
        wNRczgfjDQIc9rLkDRhBL4JjXPWzeiEAXthiwTOFnT6Aa2T9T/NGhQus1MtrExUbZWlMw8Ba8Ji
        zzvfnbo+cFCANzldMao609JSPh1TDGy4lUZ4QsPa4AA==
X-Received: by 2002:a05:600c:1d85:: with SMTP id p5mr17270875wms.36.1643618949716;
        Mon, 31 Jan 2022 00:49:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTATDXDctIwTtRUD/606FhJvoSauau1EJCnIlBOADEWwRuCy3sgT02rkUzCFPNUfk/CwaMZA==
X-Received: by 2002:a05:600c:1d85:: with SMTP id p5mr17270857wms.36.1643618949560;
        Mon, 31 Jan 2022 00:49:09 -0800 (PST)
Received: from [192.168.0.71] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id y6sm8169021wma.48.2022.01.31.00.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 00:49:08 -0800 (PST)
Message-ID: <0e5263dc-d4ba-45e9-a38f-9db127d67334@canonical.com>
Date:   Mon, 31 Jan 2022 09:49:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] dt-bindings: mfd: samsung,exynos5433-lpass: Convert
 to dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
 <20220129175332.298666-4-krzysztof.kozlowski@canonical.com>
 <1643502137.259074.416953.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1643502137.259074.416953.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/01/2022 01:22, Rob Herring wrote:
> On Sat, 29 Jan 2022 18:53:31 +0100, Krzysztof Kozlowski wrote:
>> Convert the Exynos5433 LPASS bindings to DT schema format.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/mfd/samsung,exynos5433-lpass.txt |  72 -----------
>>  .../mfd/samsung,exynos5433-lpass.yaml         | 119 ++++++++++++++++++
>>  2 files changed, 119 insertions(+), 72 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
>>  create mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dt.yaml: audio-subsystem@11400000: serial@11460000:compatible:0: 'samsung,exynos5433-uart' is not one of ['apple,s5l-uart', 'samsung,s3c2410-uart', 'samsung,s3c2412-uart', 'samsung,s3c2440-uart', 'samsung,s3c6400-uart', 'samsung,s5pv210-uart', 'samsung,exynos4210-uart', 'samsung,exynos850-uart']
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
> Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dt.yaml:0:0: /example-0/audio-subsystem@11400000/serial@11460000: failed to match any schema with compatible: ['samsung,exynos5433-uart']
> 

This is false positive or rather my patch-ordering issue. I fixed it up
in patch 5/5 of this series.


Best regards,
Krzysztof
