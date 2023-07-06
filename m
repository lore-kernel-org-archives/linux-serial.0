Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D4EB64D9
	for <linux-serial@archiver.kernel.org>; Thu,  6 Jul 2023 07:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjGFHKb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Jul 2023 03:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjGFHKa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Jul 2023 03:10:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954971BE8
        for <linux-serial@vger.kernel.org>; Thu,  6 Jul 2023 00:10:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so311538f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 06 Jul 2023 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688627412; x=1691219412;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=moTzOrhP2jv4mEj0XJL18rLy1OehAna2H1R87VD2hYA=;
        b=iqxf4K9V44dY2Z218o6zXfSMSWZr1TwwjgAgOVj7eo0o53YqM68rkRAP83eLvwqv6Z
         5xGzxdOXvApMqU3NGkHHe+KP0aEcZyWVqfakhFTsy7+0FZ/gDbF5OpqIzYPcDwo8sjmr
         9xSjv3G5/9IGlt1lEVhBXRYeD/60scayeO2TPy2tBmjsI71Cymwu9brNEbiS44VWXk/Y
         Pwe22stFsb/n9OgNFXhX7CN3wX0xFq+hQyTD6Dg+OqeDmGgHod35X0OpH0IZpte1ulHL
         GE4FyORKxU/ds/65xpagl6MnV50wtxweW2v6dWuvZLNrSeOVsUe12s5FXa6X1nR5UvQN
         damA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688627412; x=1691219412;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moTzOrhP2jv4mEj0XJL18rLy1OehAna2H1R87VD2hYA=;
        b=HP+/jAm00NJfgzKFIftWxgmgpuIHrAFLbyT28XJsCCujGAfD2b0QoUSskSHeSe6Bg6
         Vcw7f1eGTuOHjR2pmhMpXqLATjg0P5QvJ2enoT0/DKQebEeYQH9MO1+450IefDh5BqGl
         qhRV49J9AeHYVa33boZpzVWFegBDWj7X+Uz3f5t6F3ZeTVWmy5uvoWq2RxMnSiVD8eXr
         zkVlqAyYY9omMl15TJRNxRyhDNFtAjHPZ8rXDr5Q0kPEfMXsP57RVi3012o+XjD1S4zk
         wz2VENDMrvNPmp9PlacDBVlYmQ+mwm+NZ+9DWYzkuekV2oMCsiGxDuhl9oIBASPLEnHK
         N3vw==
X-Gm-Message-State: ABy/qLb/hb56sLEalAlcBGkdRU6c6MJVPVuKZu7jXNgjF+B6HoJy8pza
        r05zJYcU8fJZI2qm1coSjsfH3A==
X-Google-Smtp-Source: APBJJlFueubgKVYMHwOORI74wg8se3YQAVmG40XVt55GH1mYfZakJ47RYWKjZKADuk84VaQcbPAqfQ==
X-Received: by 2002:a5d:6287:0:b0:313:fa0f:3a05 with SMTP id k7-20020a5d6287000000b00313fa0f3a05mr954991wru.14.1688627411939;
        Thu, 06 Jul 2023 00:10:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d1:2748:ead4:bdff? ([2a01:e0a:982:cbb0:15d1:2748:ead4:bdff])
        by smtp.gmail.com with ESMTPSA id z12-20020a056000110c00b0031423a8f4f7sm1027746wrw.56.2023.07.06.00.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 00:10:11 -0700 (PDT)
Message-ID: <d78b2a8e-2e38-e52c-2a2c-308675409a1f@linaro.org>
Date:   Thu, 6 Jul 2023 09:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 7/7] arm64: dts: meson: a1: change uart compatible
 string
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jbrunet@baylibre.com, jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     kelvin.zhang@amlogic.com, xianwei.zhao@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
 <20230705181833.16137-8-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230705181833.16137-8-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/07/2023 20:18, Dmitry Rokosov wrote:
> In the current implementation, the meson-a1 configuration incorporates a
> unique compatibility tag "amlogic,meson-a1-uart' within the meson-uart
> driver due to its usage of the new console device name "ttyS".
> Consequently, the previous compatibility tag designated for the
> 'amlogic,meson-gx-uart' configuration has become obsolete and is no
> longer relevant to the current setup.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index c5567031ba12..6273b9c862b3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -344,7 +344,7 @@ mux {
>   			};
>   
>   			uart_AO: serial@1c00 {
> -				compatible = "amlogic,meson-gx-uart",
> +				compatible = "amlogic,meson-a1-uart",
>   					     "amlogic,meson-ao-uart";
>   				reg = <0x0 0x1c00 0x0 0x18>;
>   				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> @@ -354,7 +354,7 @@ uart_AO: serial@1c00 {
>   			};
>   
>   			uart_AO_B: serial@2000 {
> -				compatible = "amlogic,meson-gx-uart",
> +				compatible = "amlogic,meson-a1-uart",
>   					     "amlogic,meson-ao-uart";
>   				reg = <0x0 0x2000 0x0 0x18>;
>   				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
