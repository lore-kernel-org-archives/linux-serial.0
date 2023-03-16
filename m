Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00AC6FD1F
	for <linux-serial@archiver.kernel.org>; Thu, 16 Mar 2023 07:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCPHcn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCPHcj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Mar 2023 03:32:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8884C898E4
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:32:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so3879389edb.6
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678951918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GnScg0d+XUCiCIAUOYj6NtmRf8jyxKbyqx95uNvhbUU=;
        b=C8NY87SkEYUArxDsUsCL2+2x4wbKNGgk8J2KjTCHYJX2tGfBfGyaUaA+yR6G2k3GPi
         ntQR5iRQGJQJfNsTxPCPAHzxCOtgDpw1XlvSZMw5b5E6Cyc1SIi93jWsNH1WurMlxH+Q
         nQBRV4QfNn+BvvLym+/qM0BxHCCkGxr0brEb2kKGGskrMaa3cqZQsbAwiUE57zCaMf5G
         j2yim5dDqLzLK7NtLzPPLsxP3AI+jCIvtOb4xliA9ywIgPtQT4CU4/vMGydtzFFto0kd
         dZ3RkmGd9VQWxJWeTZBciOQ+T+N6c9IPvmOqI6vD9SGpEx2ZhUWpT4kxwC1tzAj2wROa
         XoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678951918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnScg0d+XUCiCIAUOYj6NtmRf8jyxKbyqx95uNvhbUU=;
        b=fJy7n6FjQjqYojdt4vbX7GZZ4pI7YjnA89o1owqs4zo2Jzl+8hIc8I0cazqLJRW1JR
         DY0hRQHbf7plVeFuKy67XCRHmvzfWEtCDuSVMCX3aGjm7u0RoETlw4RYGWIroAVFc30v
         DDJ4Ma/lVXr4le1/rb0Do2a7+G4ni5mDd+sovF0/lPRa8OMAEWupbH3QhmWyelpzU+o4
         KMSrGnIAS4f1Lm478XEIt2w83jNwXyga/rUpMghsoPDl5hKGbimnMJON1p1cbSKUWnnE
         +0B8335hEQkDvoxVpVsxTJRnTX8p6319IFFXrhjClEvh+cUi0kxtYmMSUp96rxreQYYZ
         S1aQ==
X-Gm-Message-State: AO0yUKXCNcQGgBSYkXEQhDoWdBUOUHImBNIs3H+dXUkr5MwVFe/fyprc
        K9Nplez2ILSSAPhT9HudVMsXxQ==
X-Google-Smtp-Source: AK7set+7hxtHDmQV+OKIM/3ytJUsWaADhOhEP6f9Q7wl66uIR0rSLRCYBTN7JKldf1W6259Si4MQPg==
X-Received: by 2002:a17:907:6297:b0:930:7324:2766 with SMTP id nd23-20020a170907629700b0093073242766mr1186457ejc.35.1678951918362;
        Thu, 16 Mar 2023 00:31:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id jz26-20020a17090775fa00b008e309da3253sm3462074ejc.202.2023.03.16.00.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:31:58 -0700 (PDT)
Message-ID: <84805483-b20a-8dd7-6efe-904f59e063dc@linaro.org>
Date:   Thu, 16 Mar 2023 08:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/15] dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys
 compatible
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-7-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-7-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add Nuvoton ma35d1 system registers compatible

Missing full stop.

> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index c828c4f5e4a7..e7a3c6e1e77f 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -57,6 +57,7 @@ properties:
>                - microchip,sparx5-cpu-syscon
>                - mstar,msc313-pmsleep
>                - nuvoton,wpcm450-shm
> +              - nuvoton,ma35d1-sys

Wrong order

Best regards,
Krzysztof

