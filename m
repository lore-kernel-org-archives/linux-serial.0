Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E37C43219
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 10:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350806AbiFAKNG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351992AbiFAKMp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 06:12:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8CC4C7BC
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 03:12:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o10so1498959edi.1
        for <linux-serial@vger.kernel.org>; Wed, 01 Jun 2022 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OGHEh5EflFJ5JP3LQKty6QMpN7VhyP1gug8Yda8OW5A=;
        b=RdNA06eZU3yur7GOEDYb/UfDCCZsD85cyaXv5fd/COilGbz32N1RnyYy1z8gcwDzkY
         mAVL49ZJa57+GiLqP6rh2AGmpF8gqhrRsXiys799/vPHu0F2re5olFzUntYNr45K98Of
         IvfZ0COVWTtulHvL2/uNU/wARd3MbMn8PJMnhD9FDes0cd4hB4Fm01kmWpL7n/2TsKN1
         6Y6UL1QXpu5HgehbvpAToUxztbyruB1E0Jw53mKfHg9a4gGeZcz4G5lMKLn67rO8ipla
         QAu5clsvjq2bNfKqwPAXMTT8nA1D22YnF30L1q5El2UGtHD+vSF1E0cIoVf36llXBhl3
         ff2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OGHEh5EflFJ5JP3LQKty6QMpN7VhyP1gug8Yda8OW5A=;
        b=U8Virt4JeW5c7DKV90sjkYk4ItMgL3wzmydwRAp8ld1gL0ky1zxQU4Ora6VJMkfDRD
         7WqPM0qRB4yODuYhMfLd+k6bh+gxsxE8iUHBPzprKSTO65bVcX5lqZaWa2rpEdQl25rN
         BzPafaDeVI9Fpw9NsITmg7c7f+6B4DCOgihHRnIRkMaTe1tqCGHQ1CWX0pc8pAgKgKVC
         59HCKD+4doO4Up6FP9qzJQVt422GND2Cdg1LuFb/JXYSGv3r+7uyLUPW+3TvawS4HVh8
         3DeToo9rPrpCaTvF/Y07gCAkARBQWFYlxLauLJRN70lyouIyoq+GcJqrXje9gvI7ebjc
         doGg==
X-Gm-Message-State: AOAM531h9EB0V0lQIBsCqetKmg7NokFNxzR6RJ1bkVfO7WQU2vk5a5zs
        SfBsHxgF3XJUi6TMiTVnJuhlUQ==
X-Google-Smtp-Source: ABdhPJz1Iw3aklyf+Hl4aU2S4N3wtkB5v1M5a6xE+R+Ctu54ed/8biBVX/Tgf6wfycHD4EafkrobCg==
X-Received: by 2002:a05:6402:424b:b0:42b:3871:75fa with SMTP id g11-20020a056402424b00b0042b387175famr58104048edb.92.1654078355157;
        Wed, 01 Jun 2022 03:12:35 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e26-20020a50ec9a000000b0042ad0358c8bsm721575edr.38.2022.06.01.03.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:12:34 -0700 (PDT)
Message-ID: <c6b6b255-0793-c833-8af5-2e2c98c71db7@linaro.org>
Date:   Wed, 1 Jun 2022 12:12:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/17] dt-bindings: serial: mediatek: add MT8365 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-11-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-11-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
