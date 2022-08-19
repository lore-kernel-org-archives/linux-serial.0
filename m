Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D22C32773
	for <linux-serial@archiver.kernel.org>; Fri, 19 Aug 2022 12:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348880AbiHSMGb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Aug 2022 08:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348681AbiHSMG2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Aug 2022 08:06:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A307F10096E
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2022 05:06:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l1so5334185lfk.8
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2022 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/Sb3w6Y1BeOgZMrIBk6x8kpTOxRss537p36tvRmvnAg=;
        b=dH9RyMR3lKC/qZOXxXjEafcK7XBKChilHFvq0LsT4iA780RiPQKoXew3aujRndsSfM
         9WHc33SEm49OFB78kb/hStFA6mKaEQmQlBw0XJ04mfvWdymVok5fsh1xOFJEHLgvgLPm
         Yp3uOpwElmcoTR2sh6KeSZ/zf/HMZ3YG2IFsWbexZPGa4OtUlAXXQ2uLt+pJ5vFNB9zm
         bbB9S8SzHl9EIDkvMetWJVwb4LexM/85N+ZGrEXtUv1PipNEw7aTnQEAwi6PSREWjHh6
         w99N2AtiTCixlxSc8KvbnhCDiUEtlgSqXHjRkqz0qbINVJgGwrblkZwfXu/5VAqYwKFy
         JmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/Sb3w6Y1BeOgZMrIBk6x8kpTOxRss537p36tvRmvnAg=;
        b=aEiIpkwyGU3ub7z95UIwdScTJ6RSfHi1s2t5ueL6R2oxJsDWEHgon9E36f3JuLNRTP
         J0EImOWDiOSu0M3fY8bISo5x9R3nu8XJ6RCqvH5pLJoxJUpX+06HP7cYIFRqCLliEcZP
         4/Doyn7ym0T4LJJ4EwdCjTKDWUiknmJZ/DwLdi6lVif/vEI6r/WctbPLKvszmWsYzXdK
         pm/JPn6pbdd2fiUhNfn8Z0Vl9vcODPLth6Z/F4ymEAFw5b9/fOanPIAt13rDTXVaSGG2
         ky+s7IwL9N2ibgjqh/JNJnXxShNmjYnm1JF9Kgp8BImzZr9PfDduG/TuMeMhBJhwD8gq
         kBuA==
X-Gm-Message-State: ACgBeo2sCSv+nh10+OiNoQ0QKu1UaJxpNJD+5HEOuoIxeOFoqOUG1TLc
        XzRWV/PormfgUEeELsSYzWpcnw==
X-Google-Smtp-Source: AA6agR4UDDM3tfvRJzYG1IzCN1p3rR1zz78x4mZxht+ZjrTuTapl3U/WvyNHyNKsLsCkmdOM4E5jTg==
X-Received: by 2002:a05:6512:358d:b0:48b:37f:dce2 with SMTP id m13-20020a056512358d00b0048b037fdce2mr2131532lfr.267.1660910784888;
        Fri, 19 Aug 2022 05:06:24 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac258d8000000b00492cebbeefbsm115021lfo.59.2022.08.19.05.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:06:24 -0700 (PDT)
Message-ID: <0871f3af-cb37-e490-f0b3-88703652b089@linaro.org>
Date:   Fri, 19 Aug 2022 15:06:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <c1a98a3e-609e-7783-b1b7-3bb39caa8c65@linaro.org>
 <ddd8ca9a-1fc1-7d37-07e8-f6f7f4617eef@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ddd8ca9a-1fc1-7d37-07e8-f6f7f4617eef@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19/08/2022 12:25, Sergiu.Moga@microchip.com wrote:
> On 18.08.2022 11:38, Krzysztof Kozlowski wrote:
>> On 17/08/2022 10:55, Sergiu Moga wrote:
>>> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
>>> json-schema format.
>>>
>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>> ---
>>>   .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
>>>   .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
>>>   2 files changed, 190 insertions(+), 98 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>> new file mode 100644
>>> index 000000000000..cf15d73fa1e8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>> @@ -0,0 +1,190 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/atmel,at91-usart.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
>>> +
>>> +maintainers:
>>> +  - Richard Genoud <richard.genoud@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>> This looks quite different than bindings and you commit msg is saying it
>> is only a conversion. Mention any changes against original bindings.
>>
>>> +      - const: atmel,at91rm9200-usart
>>> +      - const: atmel,at91sam9260-usart
>>> +      - const: microchip,sam9x60-usart
>> That's an enum
>>
>>> +      - items:
>>> +          - const: atmel,at91rm9200-dbgu
>>> +          - const: atmel,at91rm9200-usart
>>> +      - items:
>>> +          - const: atmel,at91sam9260-dbgu
>>> +          - const: atmel,at91sam9260-usart
>>> +      - items:
>>> +          - const: microchip,sam9x60-dbgu
>>> +          - const: microchip,sam9x60-usart
>>> +      - items:
>>> +          - const: microchip,sam9x60-usart
>>> +          - const: atmel,at91sam9260-usart
>> This is not correct - contradicts earlier one.
>>
>>> +      - items:
>>> +          - const: microchip,sam9x60-dbgu
>>> +          - const: microchip,sam9x60-usart
>>> +          - const: atmel,at91sam9260-dbgu
>>> +          - const: atmel,at91sam9260-usart
>> What? You wrote above that microchip,sam9x60-dbgu is compatible only
>> with microchip,sam9x60-usart. Now you write it is also compatible with
>> other ones?
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    contains:
>>> +      const: usart
>> No, this has to be specific/fixed list.
>>
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 2
>> Not really - define the items. One item could be optional, though.
>>
>>> +
>>> +  dmas:
>>> +    items:
>>> +      - description: TX DMA Channel
>>> +      - description: RX DMA Channel
>>> +
>>> +  dma-names:
>>> +    items:
>>> +      - const: tx
>>> +      - const: rx
>>> +
>>> +  atmel,usart-mode:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>> No need for |
>>
>>> +      Must be either 1 for SPI or 0 for USART.
>> Mention the header.
>>
>>> +    enum: [ 0, 1 ]
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clock-names
>>> +  - clocks
>>> +
>>> +if:
>> Put it under allOf.
> 
> 
> I missed this in the first read, but what do you mean by under allOf? 
> The only allOf's in this file are under the then:'s.
> 

It means that "if:" is preferred to be under allOf, just like example
schema is showing:
https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml

Not some other allOf, which could be many in your bindings. The one
allOf in top-level, just like example schema.


Best regards,
Krzysztof
