Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GF17+Uxh"
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D4C4C3D
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 07:37:39 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c887d1fb8fso35400251fa.0
        for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 07:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700667458; x=1701272258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIruWVCLW08kCmdc2JJdnr8xviqqWWOURPiSNoVbDyo=;
        b=GF17+UxhEQvG0ErODEt9ds+yb+OhVlKUrxsVIsiD7vXbX6kUQuBU1P4GlpI5lZwgga
         IzYKE1W5S+04WO1ACOI4Ou+cnAGOOMtKoXLt7R/Z/TFHClq2AmDfrFPAbiQQmuS1H9u/
         KE+32CiMd4eEoX0iONKdXXaJE+XEo/sBbfxolqXJmuKzmDrEDMYrkHk3J6Y8cTIcLQnG
         uOjDLC+LvEDmUgl+c4Sn83iumUWnp6L+aHhdH8vNkc0vqTyohpG1/32e/sX9k5wrMFfp
         WKaxAG7Ijya2CyqGp5r5TzBjzJopkTKWnGzWP22+doFaw3q7atzsK5fWFpQeHIetseXX
         vNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667458; x=1701272258;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIruWVCLW08kCmdc2JJdnr8xviqqWWOURPiSNoVbDyo=;
        b=Rqf6IvDd4uLR4mOIBE46qYq419b6oGNMi/mQgBQc0OGK7OLsuU7Scx4le8kse0TOlp
         FgoK/nW1d4uE2zXxs8pAaFmaDyICBGaNMKaQXkPZHefWjWoF1eXjDhaNYwSC16ry7lB7
         sjWeX5xI9v4lh/+tLxRM4Cts1KPzp1lbPfVb53IkU1EzU6mr9bwJNIuaCWnxuT5cXwuX
         eiLaP6NbHqjQGaIhtFWblYxPjo8ApF8UE1uLd0tfTbzRjgnTOjsOXlzecCsWOyF+2geG
         X/0pjNyLEqtuseEWfH3jYo7h/mvAiJvpoSGg0x/UBUNElYq1AFRSUih1Ef8a8XjfH7od
         jbAg==
X-Gm-Message-State: AOJu0Yy44MZmSWenny42I0iQvnKbqQVOFO+o3n/e+FRvBIFUa3VkGJWV
	kGgKF123K9+nlucJIwyhjQ5COg==
X-Google-Smtp-Source: AGHT+IF4FVkD3Cj5xMZ6bQgUdM6mVHsHTU430ZlyujhIEcCHKOW0UP9aBB0zIJtCP/bxmBnfrPCulA==
X-Received: by 2002:a2e:9842:0:b0:2c8:8025:1c8e with SMTP id e2-20020a2e9842000000b002c880251c8emr1792803ljj.17.1700667457874;
        Wed, 22 Nov 2023 07:37:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0040651505684sm2556620wmo.29.2023.11.22.07.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:37:37 -0800 (PST)
Message-ID: <ff32cd00-e26b-4ba6-bb08-a89c702895c9@linaro.org>
Date: Wed, 22 Nov 2023 16:37:35 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: serial: add Broadcom's BCMBCA family
 High Speed UART
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney
 <kursad.oney@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20231122144208.21114-1-zajec5@gmail.com>
 <66c4b54b-7631-484a-9f7d-31542284e620@linaro.org>
 <08fcb328-fe4b-40c7-a01e-8a0b527b1c71@gmail.com>
 <758114a7-0b18-44e8-b3d8-b5aabd244279@linaro.org>
 <cac6aa8a-1515-4062-8922-4d1e31e9216e@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <cac6aa8a-1515-4062-8922-4d1e31e9216e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/11/2023 16:32, Rafał Miłecki wrote:
> On 22.11.2023 16:00, Krzysztof Kozlowski wrote:
>> On 22/11/2023 15:52, Rafał Miłecki wrote:
>>>>> +maintainers:
>>>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: serial.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - brcm,bcm4908-hs-uart
>>>>> +          - brcm,bcm4912-hs-uart
>>>>> +          - brcm,bcm6756-hs-uart
>>>>> +          - brcm,bcm6813-hs-uart
>>>>> +          - brcm,bcm6846-hs-uart
>>>>> +          - brcm,bcm6855-hs-uart
>>>>> +          - brcm,bcm6856-hs-uart
>>>>> +          - brcm,bcm6858-hs-uart
>>>>> +          - brcm,bcm6878-hs-uart
>>>>> +          - brcm,bcm47622-hs-uart
>>>>> +          - brcm,bcm63138-hs-uart
>>>>> +          - brcm,bcm63146-hs-uart
>>>>> +          - brcm,bcm63158-hs-uart
>>>>> +          - brcm,bcm63178-hs-uart
>>>>> +      - const: brcm,bcmbca-hs-uart
>>>>
>>>> git grep did not find driver for this compatible. Is it in separate
>>>> patchset?
>>>
>>> No. My project based on BCMBCA has been canceled and I don't work on it
>>> full time anymore. I just wanted to fill empty bits I can afford
>>> handling in my free time and complete hardware description in DTS.
>>>
>>> I may still work on some BCMBCA drivers from time to time but as a side
>>> project.
>>
>> This means we cannot use driver to verify whether the fallback is
>> actually suitable. Considering that existing UART bindings do not
>> fallback (brcm,bcm6345-uart, brcm,bcm7271-uart), I don't understand what
>> is the benefit here.
> 
> I believed the rule for maintaining bindings and DTS files was to
> describe hardware no matter what/if system needs it.
> 
> For example a year ago I added binding for BCMBCA SoC timer without
> actual driver, see e112f2de151b ("dt-bindings: timer: Add Broadcom's
> BCMBCA timers").
> 
> I'm not sure if we're going to agree on this, but personally I like
> describing hardware as much as I can. So it's well documented /
> understood and people may eventually write drivers for it. Maybe it's
> partially because I come from Broadcom's world that isn't well known
> for upstream efforts in general.

The problem is that "brcm,bcmbca-hs-uart" is not describing hardware. It
is saying that all these devices have similar (compatible) programming
model, so the OS can use just one compatible. This goes away from pure
hardware description into interpretation.

Rob already commented on such non-SoC compatibles multiple times. I do
not see any reason here to not use specific compatible as fallback.

> 
> As for verifying this binding against actual driver I can definitely
> understand your concerns. Hoping it may help I uploaded Broadcom's HS
> UART driver extracted from the RAXE500-V1.0.8.70_2.0.36_gpl SDK/GPL
> package: http://files.zajec.net/hs_uart/
> 
> Please note it's not much of a clean code and its design would not be
> accepted upstream but hopefully you can glance at it to verify this
> binding's compatibility.
> 
> Let me know if there is anything else (other than rewriting Broadcom's
> downstream driver) I could do to get this binding accepted.



Best regards,
Krzysztof

