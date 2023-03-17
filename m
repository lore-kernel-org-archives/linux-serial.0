Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76A0C76195
	for <linux-serial@archiver.kernel.org>; Fri, 17 Mar 2023 09:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCQJOJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Mar 2023 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCQJOH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Mar 2023 05:14:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7099D55
        for <linux-serial@vger.kernel.org>; Fri, 17 Mar 2023 02:13:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so17707315ede.8
        for <linux-serial@vger.kernel.org>; Fri, 17 Mar 2023 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679044417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cpBYnKN5+YMFMw4tpn2s+6a2wFSz7gO8ZG313XuCv4=;
        b=FnqJnDfJTBi41p9JHh2V4t9548s1xSHZk6EhJKO2KgFARu+eOEDIROmxBeCN72zWEt
         rXKKFkFnh7MaSbygTcYQnQw6DomruPVc97RonbsScgLiLBHhBhFTor3ygxEcHDPFT0zM
         +SmoboRs+Es/JA9Gij/nX0aRL8Evwsbe6Nr6E7/xS3j8UKi2zFWJB8mP2lzoaXB7UyOM
         ptLx8MyGxhtb15z9T4IxnHMN7ZjjnBuPS9vdjAwXjoJ7Ha4YFVudkyW4XEEtUNKzI7sf
         H6yhIQ3F+2pB4qjLD+VNUGHSJ3hKVEOLwEvIPDHWG2H4U2t8GeR5Pg1FJgcxFH6lPUZI
         /0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679044417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cpBYnKN5+YMFMw4tpn2s+6a2wFSz7gO8ZG313XuCv4=;
        b=xRgW0pRf0gU+nYsU9M6CoIARHR+QsTu1jSum4qSyA5XQRyrdvlxPbou2g5XDI1Plat
         8W0wi0+lDBRxQqtQ2Z0XZ7eholda5sJb11WU2lpnx+CCVN9iNHxwWff005hENZbL5JJh
         4mar2essxEIBJ7ofWNc+2XvRYRATg9NDw9ZnwYe8pLgcExYWS1MQ4Owa3RntF7Gkg7D2
         vQt5+3zTxmJlWp8fKCKbR2azXd1RqDHA2d2sFcAaFhiOH74e/N0WR8T4HPs1bgvr8GMf
         b+NclRG6NHt3AWiREGjUeJ4MeQK7boURQZVxYPUOS/HEqDyjM/XUPH36r5fqWyU7hEoU
         VRvg==
X-Gm-Message-State: AO0yUKUNb73UeJgpRYLRCNLbaIhc+zwRLliFSnHzsvDxfTKBhkBdQnRo
        84v4OJk0F8m90g62XSKqa0ZRIA==
X-Google-Smtp-Source: AK7set8AbOUSg9RLLGhVLscb7j5DdC0tsCnYce7R6YkcgOcQcZDKJYLl8/4X0z9PrsNAsTJb0yyzGw==
X-Received: by 2002:a17:906:56:b0:91f:7455:cb1d with SMTP id 22-20020a170906005600b0091f7455cb1dmr13023353ejg.57.1679044416747;
        Fri, 17 Mar 2023 02:13:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709066b9400b0093114ce0837sm740814ejr.51.2023.03.17.02.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:13:36 -0700 (PDT)
Message-ID: <b9753d54-6605-e3cb-2943-795b4d58cd83@linaro.org>
Date:   Fri, 17 Mar 2023 10:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock
 controller bindings
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-9-ychuang570808@gmail.com>
 <0ad8521d-90b9-29c7-62e6-2d65aa2a7a27@linaro.org>
 <00423efa-d4ca-5d76-d0b2-11853a49c5e9@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <00423efa-d4ca-5d76-d0b2-11853a49c5e9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 17/03/2023 04:47, Jacky Huang wrote:
> 
>>
>>> +
>>> +  nuvoton,pll-mode:
>>> +    description:
>>> +      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
>>> +      EPLL, and VPLL in sequential. The operation mode value 0 is for
>>> +      integer mode, 1 is for fractional mode, and 2 is for spread
>>> +      spectrum mode.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    maxItems: 5
>>> +    items:
>>> +      minimum: 0
>>> +      maximum: 2
>> Why exactly this is suitable for DT?
> 
> I will use strings instead.

I have doubts why PLL mode is a property of DT. Is this a board-specific
property?

> 
>>
>>> +
>>> +  nuvoton,sys:
>>> +    description:
>>> +      Phandle to the system management controller.
>>> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
>> Drop quotes.
>>
>> You need here constraints, look for existing examples.
>>
> 
> I would like to modify this as:
> 
> 
>    nuvoton,sys:
>      description:
>        Use to unlock and lock some clock controller registers. The lock
>        control register is in system controller.
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        - items:
>            - description: phandle to the system controller.

In such case you do not have array. Just make it phandle and drop the items.



Best regards,
Krzysztof

