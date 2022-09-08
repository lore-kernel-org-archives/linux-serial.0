Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A02C38145
	for <linux-serial@archiver.kernel.org>; Thu,  8 Sep 2022 16:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIHQFz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiIHQFy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Sep 2022 12:05:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C16B5302
        for <linux-serial@vger.kernel.org>; Thu,  8 Sep 2022 09:05:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so28560168lfr.2
        for <linux-serial@vger.kernel.org>; Thu, 08 Sep 2022 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jAEzEWGfThUgGqQnHMOL1f5To09yVbEuEWo/Ad2g1YE=;
        b=c/Ng0z6ssSxi+cpYifD3Vfr1VP3RANTiQEUR6gMXz5q7H52V/1QlW79+sQxsIsnigc
         ko+17v26gBwHYzcLiMjPH2aeVRBIJDBsQCgekYeDxDc8yQjoMJJnetu0CXNni8QVpQAf
         aPxxKuLWxU4TG2mZbhutLQV1TAFVwbZDs7ZFnLI2vob89qKTzWOYITOUKDPfhnySnsgA
         6FxC/bofZVHS8qp3Ae+yiikz+7+OMxW5p2gg7qtot7Xw4JADqKB4J63ijWi8A26ndVVa
         zIj6435QZQdKw4GcFpwHOYXSaK1Aexsw58IdCoCqwhrYXC0eAhLxkRBsUV4QZnQV8lpU
         CVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jAEzEWGfThUgGqQnHMOL1f5To09yVbEuEWo/Ad2g1YE=;
        b=xSC/M+bQewlqAPJ33IFEDa583eZtXGGNq4Vk3m7vdfgDcXjDvyfOf3pH5lGAPsPaYP
         e38bnzP8okaNhuNTsudHWd6XQpn27BZDNe3yIkucrVz2pwlFQxN4AuAbzgIvK5lJXgSb
         7wh/D5S29V3TEHjYXh81z6R2rjSz4HSlYtnhCU694t82C8VM/Ulr9RnKX8QEPoVFckNA
         XmdO4vtj8v7JdzGG45cwGPauZtbVu5nyWrpRznsxqa955221Pp1be3etTfPuGVMh9sun
         g4VlBSswyEr1bWmh3oX2+mKuQHysZnIv9FYwpNSPbSJ1trGpewnCuR+XL7PF3fhyPaJk
         3efw==
X-Gm-Message-State: ACgBeo0XDtzEeQtloPTyPGBq08u/V34rDaEHvfeeRIk3dEIcKyHDxAby
        GG42mXSsQ5rt6ljTv2Am4ow8bQ==
X-Google-Smtp-Source: AA6agR6wR8uJbmz0AnOAI2ki1zJ4q03Vfc9sBBd2mOdp+EOPC5CGqg0mWL2FdJ3CzGHLAyt4QEZvEA==
X-Received: by 2002:a05:6512:3765:b0:492:d076:9f77 with SMTP id z5-20020a056512376500b00492d0769f77mr2761185lft.247.1662653149752;
        Thu, 08 Sep 2022 09:05:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b00490b5f09973sm241752lfo.92.2022.09.08.09.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:05:48 -0700 (PDT)
Message-ID: <17d142eb-80c1-0aa5-c4fa-a8e4ccd97f08@linaro.org>
Date:   Thu, 8 Sep 2022 18:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 05/13] dt-bindings: serial: atmel,at91-usart: convert
 to json-schema
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com,
        Tudor.Ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-6-sergiu.moga@microchip.com>
 <e799ca9e-acb0-1bea-1c1a-b2ab79089381@linaro.org>
 <fde16d80-28b4-aae6-363f-ad9dcf87a5e1@microchip.com>
 <1d3904d9-7fec-2e61-f999-61b89c4becb6@linaro.org>
 <753d73d0-44b9-9fba-1ed8-53691ecf2ee7@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <753d73d0-44b9-9fba-1ed8-53691ecf2ee7@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 08/09/2022 17:27, Sergiu.Moga@microchip.com wrote:
> On 08.09.2022 18:10, Krzysztof Kozlowski wrote:
>> On 08/09/2022 17:06, Sergiu.Moga@microchip.com wrote:
>>> On 08.09.2022 15:29, Krzysztof Kozlowski wrote:
>>
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - interrupts
>>>>> +  - clock-names
>>>>> +  - clocks
>>>>> +
>>>>> +allOf:
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        $nodename:
>>>>> +          pattern: "^serial@[0-9a-f]+$"
>>>>
>>>> You should rather check value of atmel,usart-mode, because now you won't
>>>> properly match device nodes called "foobar". Since usart-mode has only
>>>> two possible values, this will nicely simplify you if-else.
>>>>
>>>>
>>>
>>>
>>> I did think of that but the previous binding specifies that
>>> atmel,usart-mode is required only for the SPI mode and it is optional
>>> for the USART mode. That is why I went for the node's regex since I
>>> thought it is something that both nodes would have.
>>
>> I think it should be explicit - you configure node either to this or
>> that, so the property should be always present.
> 
> 
> 
> No DT of ours has that property atm, since they are all on USART mode by 
> default. If I were to make it required. all nodes would fail so I would 
> have to add it to each of them.

Which is a problem because...?

Have in mind that bindings can be changed. ABI here won't be broken.

> 
> 
> 
> 
>> The node name should not
>> be responsible for it, even though we want node names to match certain
>> patterns.
>>
> 
> 
> Does checkig for the node's pattern not make it better then? Since it 
> imposes an additional check? 

Not really, because if it is "foobar" your schema would not be applied
correctly.

> If it would not have a conventional 
> pattern, it would fail through unevaluatedProperies:false at the end, 
> since it would have properties that were contained inside a branch that 
> the validation of the node would not have gone through since it contains 
> a pattern that does not match the conditions of that branch.

Not for properties which are for example missing...


Best regards,
Krzysztof
