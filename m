Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FF5C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 07:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386080AbiDUHoO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbiDUHoM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 03:44:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB4613E23
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:41:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z99so5383662ede.5
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Uv7cPKaUArzIITMcA4aXXtgjHbTkK+doRZ3K15+Bmlo=;
        b=hEOdozmXH3eaNDgD/oRHrc2xyadazXOIopE1mPkGfP/inUNms8Ac/2w3hzc+Hm2+Gb
         UW1MyqxUquuMBdVIvhOlWnWkIO1GEM8aq3Ga9z8Xva98irEa8LF3oyHdOG96CZSuPyXB
         KrMO/j/R6XMDFH928uvnZcUeQmmrKqXEaUzSy1QpC1dkdbP7YyiDNB6zmFr7klSD8Nw8
         fjY17XZ8Bo05L5vz2b5OTZM1xm/j9djH7SNudYUvYhq5k3ULBC4CQA3H6fhMW12HLe82
         llX7Kq4oQ76RO9rJGwAVydNvDSpPtR+RKWV71petPg314S6+d1qFLn+eNE/fTttsBzAX
         iz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uv7cPKaUArzIITMcA4aXXtgjHbTkK+doRZ3K15+Bmlo=;
        b=qmIWAaDqm/3AAyxPGVjE8MkDCJnaAQoTPhUWJWq6k0xOugOZS3c4e43kLc63StAqMC
         Iy6obVdEdoLVXa1ZSASUiH69vfYk0oIjPUX9EjAeLfe3rUsi1Hu/HTtEfzgqDYnNeXPb
         6sm1OWI9ZksbO5ovozkw4LNjfyXreyRYKlhh9MDiT3kRQxFqmbGN/zSDr30OeqvcGdeF
         Hk5W+hJPl6yXo4iGp9jioDXj0oXH7/Z+zMq1GyZoKcGvXNK2LJwJEXz38HR9uy37MkAj
         CnzmATClBLAM1Rra5IyL9PVZnsIl/EmUBaOTPNAWj989m/cgcBHewvDIbcGOfOPYqD+T
         sxCQ==
X-Gm-Message-State: AOAM532co9ItPXUqVXCMlMm/E9gW24+1aJ1OhhTRkpT18TP8KoiYY5+6
        Emba6+wp3zX8y7LrQewRLMVe7g==
X-Google-Smtp-Source: ABdhPJyDSIJPWtDreUktJgwGwA4rnrToJQn+4WMfPlbwKSwdvhGWyc6rjslk3+RKyhdEolriw4H+lw==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr27030007edw.113.1650526882501;
        Thu, 21 Apr 2022 00:41:22 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q2-20020a056402032200b00423d4516387sm7633157edw.75.2022.04.21.00.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:41:21 -0700 (PDT)
Message-ID: <e5dabb07-eb0f-539d-12da-784ef0096e34@linaro.org>
Date:   Thu, 21 Apr 2022 09:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/15] dt-bindings: arm: renesas: Document Renesas White
 Hawk boards
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20220420084255.375700-1-yoshihiro.shimoda.uh@renesas.com>
 <20220420084255.375700-3-yoshihiro.shimoda.uh@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220420084255.375700-3-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20/04/2022 10:42, Yoshihiro Shimoda wrote:
> Add device tree bindings documentation for Renesas R-Car V4H
> White Hawk CPU and BreakOut boards.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/renesas.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Squash it with your previous patch, please. Documenting just SoC and
immediately later the board compatibles is too big split.


Best regards,
Krzysztof
