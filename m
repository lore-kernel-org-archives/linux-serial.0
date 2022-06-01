Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EB3C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 10:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351796AbiFAKDE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351802AbiFAKC4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 06:02:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651F2338B5
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 03:02:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b8so1429453edf.11
        for <linux-serial@vger.kernel.org>; Wed, 01 Jun 2022 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SCHPOUMOkaORGlqy58IkS3kpUvVCYFXurWLIORn2AWE=;
        b=R+zX7kVN/rZH7znS8QEbRvDrZjdPSwyJ5JfWczekV05ct6k21Z+QNzRMQ4DT3lLH+P
         YGv+8cYMFCE+D6IKLUrFn0DDIz71NsUdzk0zCCbyKq5E88agPjfsSq/Stk0xXIj1kmbu
         R58MwH3N19BBhqt0epKSgNdhfQsoePTIPnN8tfb4PZgrSxWCngSmYVPbhn8zSOLfO409
         feZfytnIiNSrXWHr1t1ObzSgHFHYxacwrK6r+j43OWyQGwuyGosxBPFpDypkatmsjm79
         Wd/4BZ4RoctSTUApmv410sKQkDwOKVwtvq7OE+MPQNZEl+gZynFZ8eQRrS/wc0PmvUHH
         6JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SCHPOUMOkaORGlqy58IkS3kpUvVCYFXurWLIORn2AWE=;
        b=J0xqcuQmLOL4o58CDwiXBsYHVV0S3Hn7IrnjCFMKZzcothXqP9l5i009xey8p+oZS+
         m980o070tVBizsMHrNm4HHU//TLRPKRUPCdk+R/QixWCQ6Kkp9zDw6oFe3j3PlVZX1ff
         gLek7avil6HWUaQuyBc6Q+MHwwgEuJpixCcGu2h3H5grxbSIUbDYaOuv2ZTt3jT2j518
         0MbV1PGzWFRvRgeaRneMtTDCA3y/fPoGg//GIRj3HKzB/0xLfbZGiFB+NQ9mRb0AQt1m
         XpkMd0JFU1ZpbiqXqrJMnWs6BFn/UYwETDMXwKFdJfwuril+yNG81alqC3Lk/cyHTjLf
         dJgQ==
X-Gm-Message-State: AOAM530pi4IavAhWNtMa9FuLjLg581fkl+4eQKP0K+vilK9DB6VvoOMX
        tnULQM142iXG+eNsRW8qxUZUsQ==
X-Google-Smtp-Source: ABdhPJxLqP7ex7CWmzekAAXsNfAbzxWW5D6xCr+9fxNRGYNHw1oPaWfu/s0TxV2jD4YRSiBzoXwjbA==
X-Received: by 2002:a05:6402:3585:b0:42d:d6d9:385d with SMTP id y5-20020a056402358500b0042dd6d9385dmr12945900edc.334.1654077736859;
        Wed, 01 Jun 2022 03:02:16 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lo27-20020a170906fa1b00b006fe9209a9edsm505541ejb.128.2022.06.01.03.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:02:16 -0700 (PDT)
Message-ID: <8507d1c2-125b-0753-b97a-5d2b8e790dd2@linaro.org>
Date:   Wed, 1 Jun 2022 12:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/17] dt-bindings: spi: mt65xx: add MT8365 SoC bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Leilk Liu <leilk.liu@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-10-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-10-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
