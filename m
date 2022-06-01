Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E914DC433FE
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 09:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351220AbiFAJhV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 05:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351156AbiFAJhK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 05:37:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B0EE00D
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 02:36:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gi33so2553335ejc.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Jun 2022 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BvJY1lFnsr0Ymr0p7fEBBy1zBdInDHqv2gZieFwic/w=;
        b=H9oMDfi9FTLslshDgNUeUCSTiDMS6SPqQwQ4xmvp2YZvpk8mRC3cDlTC3xpYhnqMtp
         nPH5zKM7d+MOUcflu/CWX3v4wWpaT9OposzSM/Dxx78jsQELZDS5MGcQrSkywIX6o5Uh
         4MpGtaojX5vTHNuVIp8cnOB/0ztfpdpeB3mh/avFuWHvaJ19hKjRBAfWOWCvpf81qUhb
         PX1Cb+q3YAxaR3A5LiSjRG9kjKmrWrFqrOgbDUopVp1qK7P6ID4hzxjnsii4gTsV3W5k
         rOX8IHcJbZ2vzaD1PmxLhGXES4FfrspfYMIIDx5GmxITFiWW0RHW7uODZtl6Lpz4t4Xu
         p4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BvJY1lFnsr0Ymr0p7fEBBy1zBdInDHqv2gZieFwic/w=;
        b=fumjv8j85lG5bteDul9dAcuCYMFMMprwWsGKx0woMew5F/hQBLbVYizOr58oHClI/P
         Afd2h6+V8sN5yWOepiovnFCFwfkvhvweEjME1o7kUSA1KMjAiRxWCV6ZMhx4XowRbZGF
         jx69eV9cXEMIBIjCs90qqjlVo5HyglUn8R0Cx9vYOSf3LNDSXrn2triXcjZGqvVkTk/p
         4LtppHjZE9eWJgRDHBIj/Nx9RF28dOQpHAwxf+CDnZzQiL2s3iH/LddH7M+klKIXRi7v
         kfC4NBwOsVKlexWuITOHCQsq4GhCnTfWfGyP85haiu0QNTflTumjKlLOu9581nMS6u86
         QG4w==
X-Gm-Message-State: AOAM532ktsXSZmjRzl8QZTyoAhjD2CSnOTE7lX3AS3911P0Mt+q/KPqe
        fLVLdYLKLwbU++ZbSVPZS3FU0Q==
X-Google-Smtp-Source: ABdhPJw2rvaPJFhu2OJTcgjX9RCpncnnG8SPTMWTUMQWrgzBxKr8ze5Lrm8qBjOHLVpPw2RtdL3afA==
X-Received: by 2002:a17:907:97d2:b0:6ff:288d:1bf2 with SMTP id js18-20020a17090797d200b006ff288d1bf2mr26274477ejc.664.1654076217545;
        Wed, 01 Jun 2022 02:36:57 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906069200b006f3ef214e13sm494920ejb.121.2022.06.01.02.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:36:57 -0700 (PDT)
Message-ID: <8924ef92-d8f7-1f10-b1f7-7f9bc1e2d444@linaro.org>
Date:   Wed, 1 Jun 2022 11:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 05/17] dt-bindings: dma: mediatek,uart-dma: add MT8365
 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Long Cheng <long.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-6-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-6-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation in order to support the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
