Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FAC77B7C
	for <linux-serial@archiver.kernel.org>; Thu,  4 May 2023 06:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjEDGc7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 May 2023 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDGc6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 May 2023 02:32:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB72128
        for <linux-serial@vger.kernel.org>; Wed,  3 May 2023 23:32:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso69231a12.3
        for <linux-serial@vger.kernel.org>; Wed, 03 May 2023 23:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683181975; x=1685773975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RBEhpd3xEUlZ6Us/X/cjuw9/V+kcP7bYejuz1B4OPg=;
        b=IhGqbZGuMUF4xJ8W9u/Pr1NiZ3uruaJUW/ekux+SG7T1u60WXizi9DkjVmlg+9J96c
         fkwWuvCI4mb4POHNlsUxFJ07dd4xIPTeYzVpq1RmCFeTCsiGXNsSdJyc4dLZQWPLLkYC
         n5BQXDGfVnCYnTtk+k57tCmH+y0/CxM2MWvQAm9VDTOhazq9RcZMhNfAo+9FIGhKdNHZ
         mqzH8pPxTbOju4k7zJYeOSJO8mX0IQLfHLooxIflhBum1dmDmqxROVVncQEljT/CCJpS
         ZfGIpjR1stIiaEEc06rHAzIT+Ix9bxibCMdIH8N+TJWIQDfI3cGdNcq+Zpml9ExW38w5
         XaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181975; x=1685773975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RBEhpd3xEUlZ6Us/X/cjuw9/V+kcP7bYejuz1B4OPg=;
        b=hdusvHuKHbUq9xkviIzzCrqznlrZPsYiL2zgXpHrYAFX+IjK1m/tlgUWvPRdFWUfmH
         x26lWVdFuOFo3d5c1+aYWL7h5hYqIzT2+Tt+RLQTCna6u9rn2sdxrG/JPxdJQOt96EOe
         kn68HZ/DJouMRi/JRmxzCOXjBpkxQYBlgWEtsCzBm4F+S84tPryIEx5tYmIvbAFhsCDB
         9b80hxgjq3kXgGVb1jwfywDBa171Gb12xCJZ2PfCFvjRx45eK/0buaUHHvHWnZHK76rj
         wOWdFIRnjnvFciwGoBYO8lGcInVX+eOdsIhD3w3PUsJDsslTySpHwwCqRCEJKh9dGKdl
         x4mg==
X-Gm-Message-State: AC+VfDwjMXVA3l9zqE2FADNi+g4Zyc/nfE3BftHpIwhgRobwJuB9b8RN
        73ZunV8Y8rXe1Kb94VClT3NEBw==
X-Google-Smtp-Source: ACHHUZ6cU1GIx7gdw1AGNelLdQi0YhZ6hCvTdTZP7dgeRkG1vnyMmM+bjaey386+6gjK3w0+zCTr6Q==
X-Received: by 2002:a17:907:31c4:b0:94f:e00:c8c9 with SMTP id xf4-20020a17090731c400b0094f0e00c8c9mr4344851ejb.34.1683181975206;
        Wed, 03 May 2023 23:32:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id vh7-20020a170907d38700b0094f31208918sm18056053ejc.108.2023.05.03.23.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:32:54 -0700 (PDT)
Message-ID: <8ce93998-84c3-0640-a6e1-76ff17b3953c@linaro.org>
Date:   Thu, 4 May 2023 08:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v9 01/10] arm64: Kconfig.platforms: Add config for Nuvoton
 MA35 platform
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230504033726.93-1-ychuang570808@gmail.com>
 <20230504033726.93-2-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504033726.93-2-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/05/2023 05:37, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  arch/arm64/Kconfig.platforms | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 89a0b13b058d..c1f277c05569 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -236,6 +236,15 @@ config ARCH_NPCM
>  	  General support for NPCM8xx BMC (Arbel).
>  	  Nuvoton NPCM8xx BMC based on the Cortex A35.
>  
> +config ARCH_NUVOTON

Either this should be ARCH_MA35 or you should integrate it with NPCM.
ARCH_NUVOTON means all Nuvoton platforms.


Best regards,
Krzysztof

