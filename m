Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4471C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 10:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351696AbiFAKCC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351644AbiFAKBo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 06:01:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F273E88
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 03:01:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gi33so2679633ejc.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Jun 2022 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vbUaLzVSugxs2v7OnNZbCsv3RN8rW0zxbgQMgNkMQlY=;
        b=qCpD1ecykxdeE6o3r8Cl/HN+JB2JFyigbZJlrKP52lBfoHDsyA2xb2PBziwMaOLe1L
         +ewbx3IykafZ+LJtO4B8BKDB2IyrfzINE1zuJk//fmotP6JwSkeIpQcUF6mLq2dfbnUT
         id45AXNxrujLTYpyw6jP2QDYJIzr9BY0N3s8HJ238smwiIBOOd9ssD51XVXvgidg4pFU
         vtlr+5crCYAwwfwFD4D7rMKRHbYqcm/jk/pCkCAVWj4hcJSDsRu/1oRg2Xqyf0xeIbSs
         DPFJuENPrJcJctlpOrgVppdtX/s1hl29N4snrnSQtwvXRS5g6iTzs2pTXRgpYDe80yDo
         QNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vbUaLzVSugxs2v7OnNZbCsv3RN8rW0zxbgQMgNkMQlY=;
        b=wxItWdQf6YJYuE2qM0vILawhf06DOuwud181hVZwaTHhAc07acfDGzVyywd2RPzwNm
         ytgTEBmlbGiGE+eSObMDACnqWNz9crebteScVpTxC4nUygWNjVKvRsU/jqyJ1yDK2i4a
         vPkd+TsW+MLL3JZ+6ASDqNE1FavOrTAS6uNmE8csXmazruGZ4NqVXXr3VKHrf4jKnNH2
         dS21pr3oEwshtwhIXt5ODilvTSYhwZ71Qw+fhAJxH/IKq4TEXnXKeelwNRlxRaWutrVq
         dI/IjZ4L2gt7+Mf2VUu2x3eWMp7HeLGX78eGjLKK1rg2DJR0yq9dpnzhPgxp03+xPoJS
         Cp+Q==
X-Gm-Message-State: AOAM531P6Q8/C2C5+14whm0x8Lf78ilS9vwkPW0WaiJtALuwyqMIagVN
        gcrHiHgC07x3klTcPDilcLHkXw==
X-Google-Smtp-Source: ABdhPJwyvVq0TPWBllaxxHglMZiV85mpdMH40cNFM5d4DKr4ArZwz+H/GQSSEeH1Ljb0CVHQAWEnQA==
X-Received: by 2002:a17:907:7248:b0:6fe:a121:d060 with SMTP id ds8-20020a170907724800b006fea121d060mr53409161ejc.9.1654077699553;
        Wed, 01 Jun 2022 03:01:39 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906359600b007041e969a8asm511703ejb.97.2022.06.01.03.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:01:38 -0700 (PDT)
Message-ID: <d6f2531d-2869-92b0-4c46-f2cf84990d35@linaro.org>
Date:   Wed, 1 Jun 2022 12:01:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 07/17] dt-bindings: nvmem: mediatek,efuse: add MT8365
 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-8-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-8-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add bindings documentation for the efuse driver on MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index 7c7233e29ecf..444875264493 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -32,6 +32,7 @@ properties:
>                - mediatek,mt8192-efuse
>                - mediatek,mt8195-efuse
>                - mediatek,mt8516-efuse
> +              - mediatek,mt8365-efuse

Order please


Best regards,
Krzysztof
