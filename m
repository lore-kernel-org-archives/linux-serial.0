Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B086C05027
	for <linux-serial@archiver.kernel.org>; Fri, 10 Feb 2023 09:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjBJJOx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Feb 2023 04:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjBJJOk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Feb 2023 04:14:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B1346D57
        for <linux-serial@vger.kernel.org>; Fri, 10 Feb 2023 01:14:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r18so3300127wmq.5
        for <linux-serial@vger.kernel.org>; Fri, 10 Feb 2023 01:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ku9VL6FSKb9gFMPxdQiucBun4fHwkM9uag4osJcxFjQ=;
        b=zpFhFXVLYIlooFUU8rmXcAkDC+adxJhCuHSkelNbjIJ2DmP8jlwg118JGvPgbkRCKw
         BZMX2FB4Ds2EeVcox5073/bb4xQdDbRUbgXFT93qn2Tce5I+n1w5lvolsfHx9E6ejyvF
         MA5Pgei1Z0mwQHdaZ+LSRIlQkZNw1HdSqARmrKGpbnG0VIu9HpQ6AprWV4WkEE3s9wxM
         yAKVUnhHPq8cS0v8E5yORCAptQTmZWd6K3bkw/+WgZfqKNwqjPwuedVTq67nuRHV7GXH
         wyODILu7O65DKUtpF0OfAtCptNBzyoZYKOZdxJaLMeoRpKNv5VGacNMvwq33GhNkup7Y
         2hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku9VL6FSKb9gFMPxdQiucBun4fHwkM9uag4osJcxFjQ=;
        b=CmU2PPwLiJQ7D0+cCrNAQeuwRlaYNUp94Gb46DOG8yQQrr88IXgFBycjMxKXDEnShK
         mjO86/qB8LRPKeYA4dXCZhuevG+MINqvWHo4StahiUGxz13BjVpZrqi3i297zET3nTep
         UXC2pDa4A0UzuwoJ7UQMwbx/ulq/sxJsiqeJk71u4H4gIaK0wYyYKkMqphrlN3H6RH8C
         UpgQmtdt7b6ohEgM6fCajGFvsmDW8WPExo0ImuPxNm892plCWOun4ptnrINY7TH4zCax
         AzLDzUAyo6Sb0/KJDmjgIO7kgKyX8U59v/xr7azF9jDKFkklI63Y8Rg5ciCcZZh59Syf
         /jtw==
X-Gm-Message-State: AO0yUKXnqdWLXwPOA7hS/kLoLXYvv31mQWG2gqp/e3xoFE5UvyvSnRT9
        ZWaHn4IO5ho0rxVVT0uL8m/b+g==
X-Google-Smtp-Source: AK7set9cCPWlEwC4medSmZPNUYBTeGZ/QbBenDQeIUy/vE+DLny3N/6q1pDUgVbtRT7Pd2+x0zrW7A==
X-Received: by 2002:a05:600c:319d:b0:3df:e1cc:94ff with SMTP id s29-20020a05600c319d00b003dfe1cc94ffmr12077511wmp.28.1676020462376;
        Fri, 10 Feb 2023 01:14:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f24-20020a05600c491800b003dc0cb5e3f1sm4053386wmp.46.2023.02.10.01.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 01:14:22 -0800 (PST)
Message-ID: <db065c0a-6c0e-ebf1-1867-6271b0cb5e8a@linaro.org>
Date:   Fri, 10 Feb 2023 10:14:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/4] ARM: dts: aspeed-g6: Add UDMA node
Content-Language: en-US
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-5-chiawei_wang@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230210072643.2772-5-chiawei_wang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/02/2023 08:26, Chia-Wei Wang wrote:
> Add the device tree node for UART DMA controller.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index cc2f8b785917..3f4e9da8f6c7 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -850,6 +850,13 @@ fsim1: fsi@1e79b100 {
>  				clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
>  				status = "disabled";
>  			};
> +
> +			udma: uart-dma@1e79e000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +				compatible = "aspeed,ast2600-udma";

Please run scripts/checkpatch.pl and fix reported warnings.



Best regards,
Krzysztof

