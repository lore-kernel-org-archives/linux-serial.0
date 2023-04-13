Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC8AC77B6C
	for <linux-serial@archiver.kernel.org>; Thu, 13 Apr 2023 07:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDMHj7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Apr 2023 03:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDMHj6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Apr 2023 03:39:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AC47D96
        for <linux-serial@vger.kernel.org>; Thu, 13 Apr 2023 00:39:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94a4a898649so253270366b.2
        for <linux-serial@vger.kernel.org>; Thu, 13 Apr 2023 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681371595; x=1683963595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGy4HBarfM72hZTVhOjtXUdZ8TuFEu3oubw4vKdYByQ=;
        b=qd9i/yVPGiDwt4BNJ51NNkUM7hBO+Cwq2lxUg6ukWGf4iBzouOOoFGM+kQH3gq6lD8
         ZgWIesS2fGI1yAHeRFp/a0z4zzEAqIM1MVkmKh0A8yT6UF3XCE4wF8MaCS7BpWnRQrPX
         spZaKlBicaZp3QVHr4rGUQQG8/zipwJieLinPUXxGCJ0SX1HcKr3MEDPmNiovC58URNW
         na0HY/hoK7GDYQz4i5CSz/jJ+icMqCta2jpeF2yoLHhsYm5Vv0Hm+apfc8btXPBksHJg
         66gsRMX4pOGm7TAYpJkC7pO07og3Q0FzkJnFpgjd83ManckJsw+EhY4eQq6drtm8LpGW
         e85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681371595; x=1683963595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGy4HBarfM72hZTVhOjtXUdZ8TuFEu3oubw4vKdYByQ=;
        b=kE6pReSzPLSjGhQ9zpa3zX0IwWt9Zvjikav0Q5Z6IpDEEdFPzvCskfMynZA9bAV1hn
         Td/59N7Sgc4yEYABR31Cm7bZB0HwBy8HAadRdbjokqP2XiG1kDOunb3aPglTdc0jhTvt
         sXf8jsg3iqpvw10v7p6dytsH+wfYH1nze5lx1bquccWI18kHH7jlrsvzu1lCqUL6TQ4I
         xcexdmHi0BHKU5EpMzJCtWag9bZ6kvCR/sNLT9P5OxJi7yO7zbMzEvK/NmCCO9iUQ4wt
         EORZzbKH1HYvZahApAygPfpv8cZYCl6cKue84Y4CgfGW1BP4WoFUZg6Q61LpLYTRIY70
         QKCw==
X-Gm-Message-State: AAQBX9flzVJ2j9Xh3DsiPCnRjYEp1oFhuaEvKrzfOFq3eiBEAHp5ovo/
        n5qejPmty5zqjHFuBsS3WIrf9Q==
X-Google-Smtp-Source: AKy350YAwJxhiYk1fOtdU9gXgD7dFyWTc/2rPsmFguVv+T4riyUj4g0k+KvxuXDDRadeJKCjIxGJ4w==
X-Received: by 2002:aa7:cb19:0:b0:502:6e48:65ea with SMTP id s25-20020aa7cb19000000b005026e4865eamr1130878edt.12.1681371595509;
        Thu, 13 Apr 2023 00:39:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7? ([2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7])
        by smtp.gmail.com with ESMTPSA id a19-20020a50e713000000b004fbdfbb5acesm453899edn.89.2023.04.13.00.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 00:39:55 -0700 (PDT)
Message-ID: <6f9cfd54-c8cf-7395-e7bd-c350a06c8f16@linaro.org>
Date:   Thu, 13 Apr 2023 09:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230410211152.94332-1-brenda.streiff@ni.com>
 <20230410211152.94332-2-brenda.streiff@ni.com>
 <b2f81c57-9b7c-9ad6-6ce6-cc94703599db@linaro.org>
 <b92e2f18-4fd0-0510-4a85-36d7a200c9fe@ni.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b92e2f18-4fd0-0510-4a85-36d7a200c9fe@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13/04/2023 00:24, Brenda Streiff wrote:
> On 4/11/23 00:44, Krzysztof Kozlowski wrote:
>> On 10/04/2023 23:11, Brenda Streiff wrote:
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clock-frequency: true
>>
>> I missed it last time - why do you need this property? You do not have
>> any clock input, so which clock's frequency is it?
>>
> 
> This is the clock frequency of the UART; on our x86-based platforms this
> comes from the LPC clock, on Zynq-7000 it's derived from a clock in the
> FPGA. This is used to set struct uart_port::uartclk in the serial core,
> as it is for other UARTs.
> 
> This clock frequency can vary based on board design (especially on the
> x86 side, due to different LPC clocks) but for a given design is fixed-
> frequency.

So you must have clock input - clocks property. Once you add this, use
assigned-clocks to get the rate you want.

> 
> Would you prefer this be documented further? I was following 8250.yaml's
> lead here with the simple `true`.

I prefer to drop it. It is not correct and a legacy property. Without
clock inputs how can you even configure some clock?

Best regards,
Krzysztof

