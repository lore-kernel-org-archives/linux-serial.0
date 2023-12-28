Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E063AB
	for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ir6VXvSj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso5434457f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 27 Dec 2023 23:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703749789; x=1704354589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPH9AYxPTCLROk2PqQ2BSAenaIiGgIq9psooBBXVlnA=;
        b=Ir6VXvSj6Q2YmuuXfEtr7zhoYnTM/agKZmxicD+QkP7KPa076YuFKZpobYgDjHYecU
         AqpSd/sZR88FI/TSbbvW3pwknSH3VTrCahBpLFDkzpJlIU0I7/6rzBPBajt7zcZRUVPf
         NTVovPo1THNtz2Nm87IXC4I3C4MJNP0/EfS+Vm5AJC8YdDIHsyr35aG76EYF8AfdBgdt
         KrZWCCZIVWfTnsKaXQmjdkLpdvqZmackD3hjdvVxct+jxWRa6n811ADMusJJHRKV38hI
         8vWhLyL9+PcejwJkG/zlK4UxsFREBTYMvBtwHyGpqf8yHQAuFPZoV2rJ8M0FNNxU4NZ4
         arfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703749789; x=1704354589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPH9AYxPTCLROk2PqQ2BSAenaIiGgIq9psooBBXVlnA=;
        b=se5p287UHu/jEjR7nVImiOVOpRRIgNbpodKBRPGd8GZfzUcimclNZRXBHAH7tQ6PIR
         WlOjWm5jjeWZeWobomrknvcrhAqz8ZgBi2gPH/5dAEX1TKtT8MWznoETfSkR7O+8X35Z
         o+3ZgZWo/M9dRNb/kADU9Ry5RPoFKA5EBHNURfhc2TSB82c7s+El4NE1M7U9T74aTpgw
         AofSlKgJ1bfCJIelB7ejJBjc1iFqGcbC+UOlKnBzQM6VJYN8SjkAG4xux2Fnz97SQ3sI
         n7po81aABJth2WekVp7nAYpb/NXCK4ZcRGPInpJqHs+X7EWoEJBKFfg84ZofbI2CHN1G
         5nKQ==
X-Gm-Message-State: AOJu0YzYYrTIY9q1w5X3rEMq0/mdEhqtnogCnt5Ei89ZZ3WYW3+yZtGn
	EQHbYB1Mp36LtUM+GpDu0fxxOMNDnEdRdQ==
X-Google-Smtp-Source: AGHT+IHuuf6SKbSYGy72wo6zNB6tHC+YGDelclJWtS6iyk2u5tfkq2RRgqJShnKZ27R45rO7VF6WWQ==
X-Received: by 2002:a05:600c:4b1b:b0:40d:27e9:b5ca with SMTP id i27-20020a05600c4b1b00b0040d27e9b5camr2529125wmp.365.1703749789063;
        Wed, 27 Dec 2023 23:49:49 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c3b8200b0040d5ab35657sm7908475wms.4.2023.12.27.23.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 23:49:48 -0800 (PST)
Message-ID: <68b64171-6548-44b0-b5c9-8a5343b57828@linaro.org>
Date: Thu, 28 Dec 2023 07:49:46 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] dt-bindings: clock: google,gs101-clock: add PERIC0
 clock management unit
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
 alim.akhtar@samsung.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com, arnd@arndb.de,
 semen.protsenko@linaro.org, andre.draszik@linaro.org, saravanak@google.com,
 willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-3-tudor.ambarus@linaro.org>
 <20231220150726.GA223267-robh@kernel.org>
 <173b06ab-2518-49ee-a67f-85256bc5b6a7@linaro.org>
 <425a228e-b2d3-4b19-9bcb-6ee1a90cd2ef@linaro.org>
 <7b39f962-8040-48b0-8580-abf5970bfad0@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <7b39f962-8040-48b0-8580-abf5970bfad0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/28/23 07:30, Krzysztof Kozlowski wrote:
> On 27/12/2023 13:38, Tudor Ambarus wrote:
>> Hi, Rob,
>>
>> On 12/21/23 07:20, Tudor Ambarus wrote:
>>>
>>>
>>> On 12/20/23 15:07, Rob Herring wrote:
>>>> On Thu, Dec 14, 2023 at 10:52:32AM +0000, Tudor Ambarus wrote:
>>>>> Add dt-schema documentation for the Connectivity Peripheral 0 (PERIC0)
>>>>> clock management unit.
>>>>>
>>>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>>> ---
>>>>>  .../bindings/clock/google,gs101-clock.yaml    | 25 +++++-
>>>>>  include/dt-bindings/clock/google,gs101.h      | 86 +++++++++++++++++++
>>>>>  2 files changed, 109 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
>>>>> index 3eebc03a309b..ba54c13c55bc 100644
>>>>> --- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
>>>>> +++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
>>>>> @@ -30,14 +30,15 @@ properties:
>>>>>        - google,gs101-cmu-top
>>>>>        - google,gs101-cmu-apm
>>>>>        - google,gs101-cmu-misc
>>>>> +      - google,gs101-cmu-peric0
>>>>>  
>>>>>    clocks:
>>>>>      minItems: 1
>>>>> -    maxItems: 2
>>>>> +    maxItems: 3
>>>>>  
>>>>>    clock-names:
>>>>>      minItems: 1
>>>>> -    maxItems: 2
>>>>> +    maxItems: 3
>>>>>  
>>>>>    "#clock-cells":
>>>>>      const: 1
>>>>> @@ -88,6 +89,26 @@ allOf:
>>>>>              - const: dout_cmu_misc_bus
>>>>>              - const: dout_cmu_misc_sss
>>>>>  
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            const: google,gs101-cmu-peric0
>>>>> +
>>>>> +    then:
>>>>> +      properties:
>>>>> +        clocks:
>>>>> +          items:
>>>>> +            - description: External reference clock (24.576 MHz)
>>>>> +            - description: Connectivity Peripheral 0 bus clock (from CMU_TOP)
>>>>> +            - description: Connectivity Peripheral 0 IP clock (from CMU_TOP)
>>>>> +
>>>>> +        clock-names:
>>>>> +          items:
>>>>> +            - const: oscclk
>>>>> +            - const: dout_cmu_peric0_bus
>>>>> +            - const: dout_cmu_peric0_ip
>>>>
>>>> 'bus' and 'ip' are sufficient because naming is local to the module. The 
>>>> same is true on 'dout_cmu_misc_bus'. As that has not made a release, 
>>>> please fix all of them.
>>>>
>>>
>>> Ok, will fix them shortly. Thanks, Rob!
>>
>> I tried your suggestion at
>> https://lore.kernel.org/linux-arm-kernel/c6cc6e74-6c3d-439b-8dc1-bc50a88a3d8f@linaro.org/
>>
>> and we noticed that we'd have to update the clock driver as well.
>> These CMUs set the DT clock-name of the parent clock in the driver in
>> struct samsung_cmu_info::clk_name[]. The driver then tries to enable the
>> parent clock based on the clock-name in exynos_arm64_register_cmu().
>>
>> In order to enable the parent clock of the CMU the following would be
>> needed in the driver:
>>
>> diff --git a/drivers/clk/samsung/clk-gs101.c
>> b/drivers/clk/samsung/clk-gs101.c
>> index 68a27b78b00b..e91836ea3a98 100644
>> --- a/drivers/clk/samsung/clk-gs101.c
>> +++ b/drivers/clk/samsung/clk-gs101.c
>> @@ -2476,7 +2476,7 @@ static const struct samsung_cmu_info misc_cmu_info
>> __initconst = {
>>         .nr_clk_ids             = CLKS_NR_MISC,
>>         .clk_regs               = misc_clk_regs,
>>         .nr_clk_regs            = ARRAY_SIZE(misc_clk_regs),
>> -       .clk_name               = "dout_cmu_misc_bus",
>> +       .clk_name               = "bus",
> 
> Yes, obviously, the names are used...
> 
> The entire point was that a week ago Rob said:
> "As that has not made a release,  please fix all of them."
> but if you keep waiting, like 8 days for this simple patch, his
> statement is not true anymore.
> 

I saw the problem at the end of Thursday, reported it, and after that I
entered vacation.

> The only point was to send a fix *the next day*, so I would apply it and
> send further. You kind of solved that problem by waiting entire week for
> a simple driver and DTS change.
> 
Why can't we queue the name fix as a patch for v6.8-rc1? Of course if
you consider that the change is worth it. As I said, I lean towards not
changing it.

Thanks,
ta
