Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHk8KQ57"
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957B7193;
	Wed, 22 Nov 2023 07:49:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so5727550a12.2;
        Wed, 22 Nov 2023 07:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700668160; x=1701272960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66Fvu2jBtbHGA+OA8zT0XBQR6rbjEufPChBBkW0MHpY=;
        b=hHk8KQ57c6PPa6u/f5edEtVhwBXtDB/MtNj5MeErXbrgnhoy7ZwBc/VFDu3hyx9YfA
         vRR0e2y1h8K9tH1RXi0IaxJ9nmdd5F4Kk3Yc6WghkKT5HpC8z3+tQ269vjAsOpoqE7ax
         HVtzDeNPlG+oNIuFuvm+qRp4UBu9nJs1JZ9bXkt9fKO+2zbmkFrzAmuBL0x90sDxQi8H
         4EdMhyIcQNl5l9F3Co7c7nQY7HLfrllx2mYU71uNnL1QBBzhQ0YeQ7x8CZvfa1p7B29V
         ITJHvKF0+nmisB9iiHITAE53/rzGaIskhy/sZCOu6Qql40wBWbjq9/kUSgQR2h+lhAaT
         qWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668160; x=1701272960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66Fvu2jBtbHGA+OA8zT0XBQR6rbjEufPChBBkW0MHpY=;
        b=C7S7fluR1GzZsmeZ9Fui5zYJ9XUziYAUZNeFEx2bXchAF5BlhxKDpT3IsseQMp+oyG
         8dkG/oZpfsn8CqNWvSAz8vASJSksLbx/xSDw7PAfT3isUQdhuwsMpA+4i7HWcRZNFbkO
         M3xUbTlAkV/PfdfwmKJX0sOODU2AoP0Fdpcq59pID4SSE2KILGJhB65bd2N4b7WqIKRN
         FRLwiak3OHhXa2/4tiDij9zr+KkL80R8XhLHSifUGfK3vh0C7aMsd0+DiuCMKDJEmQOl
         dH+dalEMoSN+KY4yZgdfZytFYae2Jr/PdOxP0BzZJ8loKMJxwPLjvhc230d9wU1ZOcxs
         Zkog==
X-Gm-Message-State: AOJu0YyeF9ucV9NnJ5PGmrsF/gUdHclAYS9gKALCEwOg007F0IgvxDOS
	tAAjZP0TfDcU2UCOVIySP3PT9MmeU48=
X-Google-Smtp-Source: AGHT+IH44G7WTw5vS4QmWBVYQO3kqIBmj2z3Yk9a9SmoES7q+asEQpJrAui0nmAT5QJFZDhr5eomCw==
X-Received: by 2002:a17:906:2215:b0:a01:8ff7:5f9f with SMTP id s21-20020a170906221500b00a018ff75f9fmr2234079ejs.15.1700668159682;
        Wed, 22 Nov 2023 07:49:19 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id ov13-20020a170906fc0d00b009ff1997ce86sm3768035ejb.149.2023.11.22.07.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:49:19 -0800 (PST)
Message-ID: <57a77c9d-684e-4f5e-977a-4586e15f7c3e@gmail.com>
Date: Wed, 22 Nov 2023 16:49:17 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: serial: add Broadcom's BCMBCA family
 High Speed UART
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <ff32cd00-e26b-4ba6-bb08-a89c702895c9@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <ff32cd00-e26b-4ba6-bb08-a89c702895c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.11.2023 16:37, Krzysztof Kozlowski wrote:
> On 22/11/2023 16:32, Rafał Miłecki wrote:
>> On 22.11.2023 16:00, Krzysztof Kozlowski wrote:
>>> On 22/11/2023 15:52, Rafał Miłecki wrote:
>>>>>> +maintainers:
>>>>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: serial.yaml#
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    items:
>>>>>> +      - enum:
>>>>>> +          - brcm,bcm4908-hs-uart
>>>>>> +          - brcm,bcm4912-hs-uart
>>>>>> +          - brcm,bcm6756-hs-uart
>>>>>> +          - brcm,bcm6813-hs-uart
>>>>>> +          - brcm,bcm6846-hs-uart
>>>>>> +          - brcm,bcm6855-hs-uart
>>>>>> +          - brcm,bcm6856-hs-uart
>>>>>> +          - brcm,bcm6858-hs-uart
>>>>>> +          - brcm,bcm6878-hs-uart
>>>>>> +          - brcm,bcm47622-hs-uart
>>>>>> +          - brcm,bcm63138-hs-uart
>>>>>> +          - brcm,bcm63146-hs-uart
>>>>>> +          - brcm,bcm63158-hs-uart
>>>>>> +          - brcm,bcm63178-hs-uart
>>>>>> +      - const: brcm,bcmbca-hs-uart
>>>>>
>>>>> git grep did not find driver for this compatible. Is it in separate
>>>>> patchset?
>>>>
>>>> No. My project based on BCMBCA has been canceled and I don't work on it
>>>> full time anymore. I just wanted to fill empty bits I can afford
>>>> handling in my free time and complete hardware description in DTS.
>>>>
>>>> I may still work on some BCMBCA drivers from time to time but as a side
>>>> project.
>>>
>>> This means we cannot use driver to verify whether the fallback is
>>> actually suitable. Considering that existing UART bindings do not
>>> fallback (brcm,bcm6345-uart, brcm,bcm7271-uart), I don't understand what
>>> is the benefit here.
>>
>> I believed the rule for maintaining bindings and DTS files was to
>> describe hardware no matter what/if system needs it.
>>
>> For example a year ago I added binding for BCMBCA SoC timer without
>> actual driver, see e112f2de151b ("dt-bindings: timer: Add Broadcom's
>> BCMBCA timers").
>>
>> I'm not sure if we're going to agree on this, but personally I like
>> describing hardware as much as I can. So it's well documented /
>> understood and people may eventually write drivers for it. Maybe it's
>> partially because I come from Broadcom's world that isn't well known
>> for upstream efforts in general.
> 
> The problem is that "brcm,bcmbca-hs-uart" is not describing hardware. It
> is saying that all these devices have similar (compatible) programming
> model, so the OS can use just one compatible. This goes away from pure
> hardware description into interpretation.
> 
> Rob already commented on such non-SoC compatibles multiple times. I do
> not see any reason here to not use specific compatible as fallback.

Do I get it right we should rather have some base specific compatible
like: "brcm,bcm63138-hs-uart" and then if anything use fallback to it
like: "brcm,bcm4908-hs-uart", "brcm,bcm63138-hs-uart"; ?
