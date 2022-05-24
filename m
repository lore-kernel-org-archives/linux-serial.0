Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F34C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 24 May 2022 20:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiEXUOJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 May 2022 16:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiEXUOI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 May 2022 16:14:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F482177
        for <linux-serial@vger.kernel.org>; Tue, 24 May 2022 13:14:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q15so1325243edb.11
        for <linux-serial@vger.kernel.org>; Tue, 24 May 2022 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fm1tpFca2YWIuBpxTTGZclIqJvsNWlMgZzoZ+c6L03Y=;
        b=b2xojrV+9PHgmFBI5/KZgSAhUS6qJGPSbk0j023/DmgkixIJ82kiPaixoGsAceFnPU
         tmLhJG5uFbhpEQFyCoCqxi+ONAQtwawp3km4d+FSGp0XNsH2t3JltLDqkxzgxegOCVSQ
         HAIMqwagKJMLCuEMJTTrTyYdY1duBRichZylDdPbAl/4zor/WB1YEAidS22+JxNs28tU
         BryV29mbgMbFif0NNdDe6R5mLgsY0HBdGdeKreX4/f10bQyKlN6qAjTVFJxKWRY/UJMk
         7W519LPilUuaMQknyi4G0+O8RKAkVzph87M90NU7bmPhtwra+wGAubTv+ezsSoOaf4MR
         OY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fm1tpFca2YWIuBpxTTGZclIqJvsNWlMgZzoZ+c6L03Y=;
        b=UpAwbY5KKhTTo7kkqunATIRAEwZ06Hgrczj2+Xk/qclLZykTxMdGlTslJKvXQS/Wzs
         a1BUoVQOSnimNzR3eOmBPUAV2KMUTqiTd6OmVotTjS62tl+xszApS0rO9Spz1b2D4ekj
         zlRHgqF2x/3Gk18I0fQS0O+o+xkl9v0V4FEnZZ6kWmVEt+Hts2cNUJafzes2t7JjDWtL
         s7izlC/+f0RKAq7J/TY4Kn0IwvKU5haemRQTvh9rD8P9xn+CgDHY2UcEAI7eEOqi8I1h
         9X0SWyK+0LbM9AfSVOoXPOX5M2i5cqW9KZN+Syw2VKTN/jdwFIKk0VwqAdHcdRRfiTe7
         JBww==
X-Gm-Message-State: AOAM53261qIKWdhCLRSYVmyMAW4M00K+grBjQ6D5x0HNr2Cdj3s/ly1g
        4Tmrlghq2nh7pNVV6GG+1OgvIg==
X-Google-Smtp-Source: ABdhPJxYconPOKdPTtXM3P9lkUnV1bFUE4Pa1l2up9yo4tsa/rU7pkuKObtyf6INae21cJZAZHhOKA==
X-Received: by 2002:a05:6402:388d:b0:42a:ba9f:f85c with SMTP id fd13-20020a056402388d00b0042aba9ff85cmr31318770edb.292.1653423245180;
        Tue, 24 May 2022 13:14:05 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090601d000b006f3ef214db3sm7555530ejj.25.2022.05.24.13.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 13:14:03 -0700 (PDT)
Message-ID: <b70a58ef-af3a-f4d9-37fe-688c600523a2@linaro.org>
Date:   Tue, 24 May 2022 22:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] dt-bindings: serial: mtk-uart: Convert txt to
 json-schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220524115019.97246-1-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220524115019.97246-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 24/05/2022 13:50, AngeloGioacchino Del Regno wrote:
> Convert the mtk-uart documentation from freeform text to a json-schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
