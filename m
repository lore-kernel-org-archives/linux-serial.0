Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27A1C7619A
	for <linux-serial@archiver.kernel.org>; Tue, 11 Apr 2023 05:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjDKFsA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Apr 2023 01:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDKFrj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Apr 2023 01:47:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAF430D8
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 22:47:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jg21so17111764ejc.2
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681192031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVh755DKDNmveu85FDiALetnqXyLZJdSZZC58t6k7ZI=;
        b=w90KoYAZQND2DqJ/iBjBd6yWNI4zSEgciruIcBm6srEoZKqLWmyk2qTvfM/CiQwCeu
         SCZNTXVHLnr9Y93ZmqQHs+zW80GwZnahVY09ZksGCVrn/FVccFOyYpQsI9EWHeFosagN
         nWWWHwk4Z4hk9S9evSU7h55Oa5vBb4OTXtztBIId7dPyT3P55h7b4Si/Uza6wq890kj1
         voLL8AkRu4zSJnT2OFRFpfnyxcrd1abfxWF30HGV8X4ej2IRwCy7AgkJT5As7T+NzP/9
         YIlFssqYDFuejHp02b6XFZRLoi87llY6clibxinXE+RjtGMWfzpsWyxJLS81enEMVH50
         UTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681192031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVh755DKDNmveu85FDiALetnqXyLZJdSZZC58t6k7ZI=;
        b=Q8XLqJuPtPRuiVY8p7amysR6pusPG+b4++yzfpoeGtVs57lqvWTjJpVZoIZKfQG+7v
         Rubzg1cYWz9WlIl2M9f4xbTMwmJ2Nc6NJpbwiNmxUi3orfyssZ8j3vG331vQTxRqdV03
         /gooB6W4zTjTXKcop3XGAImDSiCEwN/Ba8b99i9vrPkfaZODJbIhT5d3bk0qCVxQWw81
         PhwDp5geHKl9lCTLtZxKO3gnGNXCGoPrwS2UVn1Ujrc6CaCoQh93s0uEZwBJcDcIcZ6B
         6mlxrf2QBvRt2XYjDjDM+mkoB7eVBj9QMA1EdldIrpGnaOV8v4qYQyDSy6i8D+M2tCBi
         AFDw==
X-Gm-Message-State: AAQBX9eX5dnlIDYBt1d+RzDneDtnYEAd15CVJVFfu3QLVLyRpio3K93B
        PtLjD3kEoSJIgNitq4lwjZ852w==
X-Google-Smtp-Source: AKy350ZUAGxpvhR4romk+59laXw1jS7kpNVeZaxQmbOsaNlEvHIU4tTd8ZbvnbFRkhNSMQoUO4Gtbg==
X-Received: by 2002:a17:907:76eb:b0:93b:2d0b:b60e with SMTP id kg11-20020a17090776eb00b0093b2d0bb60emr1582180ejc.74.1681192031168;
        Mon, 10 Apr 2023 22:47:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906840600b0094a7d367554sm1943521ejx.32.2023.04.10.22.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:47:10 -0700 (PDT)
Message-ID: <b3287bb9-2127-4d00-8679-b4b30968191e@linaro.org>
Date:   Tue, 11 Apr 2023 07:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 2/6] dt-bindings: crypto: fsl-dcp: add imx6sl and
 imx6ull compatible
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
 <20230410205803.45853-3-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410205803.45853-3-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/04/2023 22:57, Stefan Wahren wrote:
> Currently the dtbs_check for imx6 generates warnings like this:
> 
> 'fsl,imx6sl-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
> ['fsl,imx6sl-dcp', 'fsl,imx28-dcp'] is too long
> 
> or
> 
> 'fsl,imx6ull-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
> ['fsl,imx6ull-dcp', 'fsl,imx28-dcp'] is too long
> 
> So add them to the devicetree binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

