Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A28C433EF
	for <linux-serial@archiver.kernel.org>; Sat,  2 Apr 2022 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbiDBPjw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 Apr 2022 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiDBPjw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 Apr 2022 11:39:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF55A147AC3
        for <linux-serial@vger.kernel.org>; Sat,  2 Apr 2022 08:37:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id yy13so11651961ejb.2
        for <linux-serial@vger.kernel.org>; Sat, 02 Apr 2022 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Om7g1lbZHptt45F5/8EMxdm2FJFfgH0D0EuLInj36vU=;
        b=JVpQL/v5kWGf/e2/0JHBaEUGGw/gj3Ojbu7L/yyxICvL6KyitRYisyaCKKvLuhnzRR
         bAfAQP9PDU2bjs9AqA2JVHTfBGMh8fmWIugeGXrIAu6aDnRrJW7zkBjzeIA3lxhPcJak
         SZkNWnlrUSlK3Rd3vLkZqXMrEcEVjAlK+O5bwuXqMDa1vGIOlmnhvuK68upNgJyomv7G
         sc3KNTc4y9T5EXLE/guXbGP0nyME9ORiSoViSq/PG2SA573R80+wm5VdUkKA1OWYXX0R
         pTnm9LSwLzLb/WXEzClRvpw2rsunxAiftvC1xqcKI18olKG7ZZnq5RGSNnw/MlN5LwvF
         6Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Om7g1lbZHptt45F5/8EMxdm2FJFfgH0D0EuLInj36vU=;
        b=b0JYH65AbM03+ycIpLTyW/rsSdjp9x99zL1I1/4m2RYaa27kV3vN3Lk5bQdvNiF2iP
         G4Xh+WQuSG802b2tYPvfHvfOCrkIOkKYrf70xjlCETeUwzsqQRQhEsffrS592KyCd6Z9
         MmfU5DcZlLmwNDx6CMxDpUWSVxhZtSNJVzDXNFY9uz+Ap6SYNuIlv0Yqq5kcQpclfG7O
         tGBEkruYYXAQNoxNQhQaxq6qzqHnykt13oOMNe2sQtNM/Xxc2tcIqqYmbwXL1CIfQJ4a
         uiXE+EWIDXK50W7xb/KJ7jO/5Cf5K5ZeBmW/+JvSM6H3Dga8ZJmnYVqjPnHT5zGGsX8C
         qXFQ==
X-Gm-Message-State: AOAM531JN3ytShbdIsl0XO7DV3g+HlD9zwR6QdvSXzg3PKdL9vUAnYae
        3x5c7J0lGeJ99nT4ixUygtEreA==
X-Google-Smtp-Source: ABdhPJyxFZOKe4x3u3oQufe6RweNYX1YclatcvzBUnGqI5aWiZseTdOA+bMUDSEEh3I460buuu9lLA==
X-Received: by 2002:a17:907:7f0c:b0:6e1:42ee:3e71 with SMTP id qf12-20020a1709077f0c00b006e142ee3e71mr4248325ejc.127.1648913878505;
        Sat, 02 Apr 2022 08:37:58 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b0041cbaba8743sm434843edk.56.2022.04.02.08.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 08:37:58 -0700 (PDT)
Message-ID: <523c6f46-54eb-22f0-221c-981879b8311e@linaro.org>
Date:   Sat, 2 Apr 2022 17:37:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] dt-bindings: serial: Update Qualcomm geni based QUP
 uart bindings
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
References: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
 <20220402051206.6115-4-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402051206.6115-4-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 02/04/2022 07:12, Kuldeep Singh wrote:
> Similar to i2c controller, move geni based QUP uart controller bindings

s/i2c/I2C/
s/uart/UART/

> out from parent schema to an individual binding and let parent refer to
> child schema later on. Uart bindings also stand incomplete right now

s/Uart/UART/

> similar to i2c, complete it along this process.

s/i2c/I2C/



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
