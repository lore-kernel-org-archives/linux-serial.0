Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55646C77B61
	for <linux-serial@archiver.kernel.org>; Thu, 13 Apr 2023 16:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjDMQro (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Apr 2023 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDMQrn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Apr 2023 12:47:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674BA5DA
        for <linux-serial@vger.kernel.org>; Thu, 13 Apr 2023 09:47:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c9so140615ejz.1
        for <linux-serial@vger.kernel.org>; Thu, 13 Apr 2023 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681404450; x=1683996450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51DVCd/h3/cJO7cjSlyrYI32aoEqdT9dgNs9Eih2opE=;
        b=nwu0GWON8U6TXZ3AT7gmRhnXNlY7lxqUiwgRLU2Uw3ieZXA+uUVn8nCJ7nbTT46IVu
         wwLwRAaXeAkQoRk45Ctu06Gj5+w2VTE0sNRhlPVtvb+AVprqq6Mdk+suH2aNI6BYPsiB
         6cNLN8+zEtGyNX/KyEoBvn46OtTtt2tlVT85GHip2cSO1/PBq/JhKMCRQNv9eIztyRY5
         w0q2os13wwQcZx6p0frcHHUtOiYimZakYu6fNc8RLvh0Y24ZX/hjuJYP7ELV1yb5wJJC
         25g8s6YrMZYnPPeLL4eVKHQqkfBw8CBaCSw83aYue3fTj6hcTSKEfMrhPzS81jXREH2C
         PvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681404450; x=1683996450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51DVCd/h3/cJO7cjSlyrYI32aoEqdT9dgNs9Eih2opE=;
        b=aDzQnI4E/Bny4rM69tE74+cnemtB/lztHWuMm0Hp+7883EebFe+fLSZpY7I31TB7T/
         kK8h8YPoyi0jQ6Cge1w+RU28ZE310dyRRh9FLXs5xO+oI/SHB/GtId2wHxSmnFMUEVJR
         6+ZUvXKO9JGIOxmAnrR4pO5sjI+H0BZtnG7L0HBQsemPnAR2srflBkmlOfsufIAhAsJB
         sAB6QUOCwBSBTcEmwp5QrWxZZmt6n7M/FEY2My4ZUYBsk5uVy96UcAdGHDgvOI80Hj4A
         cLw5r4Rk9pS1YCKqwZtRq/usHuClKmulFCZoHBsyE3KZzC62khvg3yLEaep2Bek+xjU0
         fuiA==
X-Gm-Message-State: AAQBX9eeq5za3HtA694HRnu4gRLDEUjnR6HzreWASUGs/tSY/8eGbVou
        gtDRfrxG4vnmybZQxdhG6atSOw==
X-Google-Smtp-Source: AKy350b4Jz7APW0X824PXsHeC5e1sHTqjV9UgCwCrxjufPBWxBtgGffJCq1hAMMiXPCq9xLeN0mhEA==
X-Received: by 2002:a17:907:3f16:b0:930:f953:962c with SMTP id hq22-20020a1709073f1600b00930f953962cmr4155726ejc.1.1681404450522;
        Thu, 13 Apr 2023 09:47:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id ka20-20020a170907991400b0094c67e537c8sm1208815ejc.38.2023.04.13.09.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 09:47:29 -0700 (PDT)
Message-ID: <d11b6acb-b072-9496-5ad6-0635357394f1@linaro.org>
Date:   Thu, 13 Apr 2023 18:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 05/12] dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys
 compatible
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-6-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412053824.106-6-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/04/2023 07:38, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add Nuvoton ma35d1 system registers compatible.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>

What about the tag? Why did you ignore it?

Also, wasn't this applied? Why do you resend (incorrect version)?

Best regards,
Krzysztof

