Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19589C6FA8B
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 08:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiIMI6k (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiIMI6d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 04:58:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D53DF1F
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 01:58:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e16so19644073wrx.7
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=u4ofErT5hOMpQGT6cywWVhLXqVmQE7e7Op5vJ0iCaOQ=;
        b=CUrH1MyfvoQBLVS+1bNqDxagpk8da2WmGc2X1jrklxStrvrUxn++Ywcgqx4VN4roZP
         3JoWE/S1P5XiPpC1x88uK2gd5f0n8/2AErWwpORKgOYDSO2QX1BLfa/TV+WZ3ETxZqjZ
         yA9oaHKWEQxh7RsoMinCS3UG31NCTBqZYQhGwrTXRnezldgzViR9B1WBGt3Yo+k45Sc7
         V6+CA9AfLN/TYasyOOx2E5RtQHlLqaJtRmrJlVBn+rP5yC2Eerbum8v9QWZGx3QEogNa
         UvTH9AogHf5pSxhoPDcUR45WAChcbzM+/LcF1ed7SQeaShR1U0Bf5VnBC/fNhhcCsQqX
         T2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u4ofErT5hOMpQGT6cywWVhLXqVmQE7e7Op5vJ0iCaOQ=;
        b=FsLG2r11uINvv2B9TslLWRpB/VZHmOAN8nmbXohpE9YHJVJc3cVS0IWAEMOfasST8z
         mscpcL7PxSqdslTilw00ZbjcpoGYcGNjc9lVRcnqsh3+13CnejToYgTEIqz5Dj+gi5/B
         KwlO9harZYCXp3KKjzowAf62tRJ4bFMl1pvf1jWsZiukRXnS8+BY3BLDtlavCrORaBhe
         81APZpqn4f2vFidO1yG4ysgGYJUrvY6FpBpxoEwAlVyvIa2wrzBi0jyGkTZIQSxf7zyn
         qElP4a8mFwTvM7sTsazLEmCsryJCLy3RiGRJUFWsYuO+zUKR+JZAnHDXmPCeV9Y8F3pf
         i4zg==
X-Gm-Message-State: ACgBeo0rPlWcArWNbhVBadq9PbOkE17i2DVmeqP6eYW6qsAjAXLX0/LL
        SOMTn2HhTg8bP3XfNP6iQaAuxg==
X-Google-Smtp-Source: AA6agR7NJFeL1td8GL5y3jCMjrfmIttwAxs8dqRjcGTJeYaHGfS5MNlGiXG2PnvftRkB5RfgEcW7rQ==
X-Received: by 2002:a5d:5c08:0:b0:228:e139:43f3 with SMTP id cc8-20020a5d5c08000000b00228e13943f3mr17794182wrb.396.1663059510234;
        Tue, 13 Sep 2022 01:58:30 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb12000000b00226f0a00348sm9726306wrr.111.2022.09.13.01.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 01:58:29 -0700 (PDT)
Message-ID: <5f8ca612-5a89-db3a-42f3-a0613c192a87@linaro.org>
Date:   Tue, 13 Sep 2022 10:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, robh@kernel.org
Cc:     lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, richard.genoud@gmail.com,
        radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        Kavyasree.Kotagiri@microchip.com, Tudor.Ambarus@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-7-sergiu.moga@microchip.com>
 <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
 <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
 <20220909013644.GA3731620-robh@kernel.org>
 <b6b044f6-de87-e85b-0b51-e957b90622ab@microchip.com>
 <aa6d8c7d-1723-7674-2142-a5aafe30e570@linaro.org>
 <77d38e3f-6d8c-dbb1-2e66-c768d95b5e35@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <77d38e3f-6d8c-dbb1-2e66-c768d95b5e35@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/09/2022 15:09, Sergiu.Moga@microchip.com wrote:
> On 12.09.2022 13:44, Krzysztof Kozlowski wrote:
>> On 12/09/2022 09:45, Sergiu.Moga@microchip.com wrote:
>>> On 09.09.2022 04:36, Rob Herring wrote:
>>>> On Thu, Sep 08, 2022 at 03:15:44PM +0000, Sergiu.Moga@microchip.com wrote:
>>>>> On 08.09.2022 15:30, Krzysztof Kozlowski wrote:
>>>>>> On 06/09/2022 15:55, Sergiu Moga wrote:
>>>>>>> Add the AT91SAM9260 serial compatibles to the list of SAM9X60 compatibles
>>>>>>> in order to highlight the incremental characteristics of the SAM9X60
>>>>>>> serial IP.
>>>>>>>
>>>>>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>>>>>> ---
>>>>>>>
>>>>>>>
>>>>>>> v1 -> v2:
>>>>>>> - Nothing, this patch was not here before
>>>>>>>
>>>>>>>
>>>>>>>     Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 2 ++
>>>>>>>     1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>>>>>>> index b25535b7a4d2..4d80006963c7 100644
>>>>>>> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>>>>>>> @@ -26,6 +26,8 @@ properties:
>>>>>>>           - items:
>>>>>>>               - const: microchip,sam9x60-dbgu
>>>>>>>               - const: microchip,sam9x60-usart
>>>>>>> +          - const: atmel,at91sam9260-dbgu
>>>>>>> +          - const: atmel,at91sam9260-usart
>>>>>>
>>>>>> This is weird. You say in commit msg to "highlight the incremental
>>>>>> characteristics" but you basically change here existing compatibles.
>>>>>
>>>>>
>>>>> Does "show that they are incremental IP's" sound better then?
>>>>>
>>>>>
>>>>>> This is not enum, but a list.
>>>>>>
>>>>>
>>>>>
>>>>> What do you mean by this? I know it is a list, I specified so in the
>>>>> commit message.
>>>>
>>>> You are saying that compatible must be exactly the 4 strings above in
>>>> the order listed. You need another entry with another 'items' list.
>>>>
>>>> Rob
>>>
>>>
>>> That is what was intended though: a list of the 4 compatibles in that
>>> exact order. The 4th patch of this series also ensures that all 9x60
>>> nodes have that exact list of 4 compatibles.
>>
>> The commit msg suggest otherwise - two options, because it is
>> incremental... But this one is not really incremental - you require this
>> one, only one, configuration. It's in general fine, but commit msg
>> should reflect what you are really intend to do here and why you are
>> doing it.
>>
>>
>> Best regards,
>> Krzysztof
> 
> 
> My apologies, I still do not understand what is wrong with the commit 
> message. My intention was to ensure that every 9x60 usart compatible is 
> followed by the 9260 compatibles because the 9x60 serial IP is an 
> improvement over the 9260 one. Would you prefer it to be just the first 
> part of the commit message: `Add the AT91SAM9260 serial compatibles to 
> the list of SAM9X60 compatibles`? That way it would really only be what 
> the commit does.

Let me rephrase it:

What your commit is doing is requiring additional fallback compatibles.
Therefore the commit msg should answer - why do you require additional
fallback compatibles?

Incremental characteristics sound to me optional. I can increment
sam9x60 with something or I can skip it. But you are not doing it...
sam9x60 was already there and now you require a fallback.

Best regards,
Krzysztof
