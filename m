Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32724C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 21 Nov 2022 10:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKUKLi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiKUKL0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Nov 2022 05:11:26 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB51B45
        for <linux-serial@vger.kernel.org>; Mon, 21 Nov 2022 02:11:25 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u2so13964265ljl.3
        for <linux-serial@vger.kernel.org>; Mon, 21 Nov 2022 02:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vkbm4Bxn5eLnjPj3/tOUOnl04OhPLdTSTUnYDiGnDgo=;
        b=bR/nvBGSZjElA8QI/+tH/765a4y1M2Z+4n0UDqntO79EVlF1v7gSzOkFqB0mmLdDNj
         hOt6Kx6yDqk6TdNyNxegPDA45Yx0nzjaOTEyfn5KrZCMGNutG2of+2wV6Dms1L1GqR8N
         pmkSNKO4mEJkwD+7YrtKCJ5mpfGXgV+ccv4g3F1JKKPsYfFBwyubXPB9b6pFq8f2suft
         VlfBiXfLZpUvsDkWsrN/6JOKGF8TgBap+757VGyxsw8qk/HjB/ML/O8tXBfwYxkKj5CS
         JselQKZ24Kxskv+/m9hOFQjCXcc6/YfJexxtCPLux/6+Cd1+bYWrzG1aIIRgzzmb/fsw
         axJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkbm4Bxn5eLnjPj3/tOUOnl04OhPLdTSTUnYDiGnDgo=;
        b=oD7t08SW380u4z7E6yY3vGusNTH84LBHB4FSWMRH7LKGUMzu+RqwDWGVZ0Dgiwnihy
         iu988RYK/z/ADs2GMa1gPMWQqPfGvXQPSavtLK7XS5NTxopEtrGG+DwzsC7plTsJ2ddL
         UzeXD5nPHYD9N+HpSHiHGcvEgb5+8IImyGOU+zQ/GWZgTZ3VSw/mbMqsaPMlCp/9Dtr0
         9v3EzArAngVP/pucg7ZGljhPc2ut0NhlyHYHfwO7A2+ymH84uTk30LFZd4aCdGqyAn/f
         4pG0nYOPXtlfaTQwy4ggWPq7s5t9WoWMF3AmCxcfQauZk4vSbxGhDUtWhfGEuF6PjUjL
         V9ZQ==
X-Gm-Message-State: ANoB5pkiYmMW5XBcAbYpHYHMbgym/tOaUkjq2RoAARMtHzw5EP1HSfJC
        Kh36WaQArCq0Ji+hUntJHUF1Ew==
X-Google-Smtp-Source: AA0mqf68/n19Rjf7V+oTQiueK1njPoKnq0nXUA6E151V5mffE88KckL4M3G268YOmAXtMqrcnqK5hQ==
X-Received: by 2002:a05:651c:1510:b0:277:75fb:1fc5 with SMTP id e16-20020a05651c151000b0027775fb1fc5mr5398278ljf.405.1669025483901;
        Mon, 21 Nov 2022 02:11:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v4-20020a056512348400b0048af397c827sm1974128lfr.218.2022.11.21.02.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:11:23 -0800 (PST)
Message-ID: <9cc705dd-191d-ddf9-9e26-403d5124c77c@linaro.org>
Date:   Mon, 21 Nov 2022 11:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 7/7] MAINTAINERS: add myself as Bouffalolab SoC entry
 maintainer
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-8-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221120082114.3030-8-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20/11/2022 09:21, Jisheng Zhang wrote:
> I want to maintain this Bouffalolab riscv SoC entry from now on.

Use 3rd person narrative, so:
1. Subject: MAINTAINERS: riscv: add entry for Bouffalolab SoC
2. Commit: Add Jisheng Zhang as Bouffalolab SoC maintainer.

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92451834b940..3564b27d7da4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17738,6 +17738,12 @@ F:	arch/riscv/
>  N:	riscv
>  K:	riscv
>  
> +RISC-V BOUFFALOLAB SOC SUPPORT
> +M:	Jisheng Zhang <jszhang@kernel.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	arch/riscv/boot/dts/bouffalolab/
> +
>  RISC-V MICROCHIP FPGA SUPPORT
>  M:	Conor Dooley <conor.dooley@microchip.com>
>  M:	Daire McNamara <daire.mcnamara@microchip.com>

Best regards,
Krzysztof

