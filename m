Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQvbJlNX"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919FA18D;
	Wed, 22 Nov 2023 07:32:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so7662602a12.3;
        Wed, 22 Nov 2023 07:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700667138; x=1701271938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0L4DobVapYjmv7NtguLjcox8D49s1eNFYKB/Iz6e+Q=;
        b=VQvbJlNXuV2o6FLOS/jfILf6x5QnB7IIPHfissPjqP4avNTUeDB984YuZpJcNNl0Ex
         sXcDSujP544LG6cv1RI17TKjQIK1i0WeQ00axMgAQ3Ye4nJ4yT5sjRbqm8/p3uZuYsuR
         VssB1qsQE60b5YK4SAgv1u9OLOM+c08HzrYnm7/i6QCC7wsviltbgU9Y3ypnhO/+TWFk
         cl+e/oW8gs6qJBL31dfZ5F+qjnU+qfmxaXSMlK1kUxEayNkGhJSjgS/BEAABVie6wbuA
         tIAT7NoiQNz2sNQP6GVD5Y4njkNpKZbNNRripj1dZ7Dl263A/Rk4bgDFHnmegkUTty6n
         DGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667138; x=1701271938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0L4DobVapYjmv7NtguLjcox8D49s1eNFYKB/Iz6e+Q=;
        b=NehcOGbIXDpBAXUW/l0pSgNy57AjGPvxiVcIrMs6CITTcQatewVgAZUPNBYcYhXPgo
         CFELrc1c4Iwmicl6kQaJW+IRw8gmL+m+HRsKKo2RWXw8YWmSLwGivnTEMmyocuDqmBk8
         1zXOCGOFcPRyYxP6ppg1rYzxgezTWT8JOKWEfBU3Tj5wQk7tbGOJuBAumDB5FTotOFgf
         GYlRUqWARRHzD4YnSFX0wRjze7n1OVrO8qS8I4vcEyIvs9uePC8ym+9S9RtedjaoCvPG
         HJDyvMg/6a/FtkMdLVPcltwNwMYcJIMmmCSYixPyDRl8hJa/gpEOzh6FAz15iGDU5WhQ
         JyEw==
X-Gm-Message-State: AOJu0Yw8CM/PPhs3RYod4g0AHgo3IY3H5wdh/6AyU6wwXwrIkSOQ97BT
	OkloYKDjace6z03/74Vpv/8=
X-Google-Smtp-Source: AGHT+IHxsaKyOX4NcRQJYF2qG8npzWHsk6/ukic10W3K5VlOhsmCRdrjJD9nPXNB4RXD8ePTWHsdzw==
X-Received: by 2002:a17:906:109a:b0:9d5:ecf9:e6b5 with SMTP id u26-20020a170906109a00b009d5ecf9e6b5mr1609514eju.59.1700667137825;
        Wed, 22 Nov 2023 07:32:17 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id e4-20020a17090681c400b009be14e5cd54sm6788227ejx.57.2023.11.22.07.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:32:17 -0800 (PST)
Message-ID: <cac6aa8a-1515-4062-8922-4d1e31e9216e@gmail.com>
Date: Wed, 22 Nov 2023 16:32:15 +0100
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
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <758114a7-0b18-44e8-b3d8-b5aabd244279@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.11.2023 16:00, Krzysztof Kozlowski wrote:
> On 22/11/2023 15:52, Rafał Miłecki wrote:
>>>> +maintainers:
>>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>>> +
>>>> +allOf:
>>>> +  - $ref: serial.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - brcm,bcm4908-hs-uart
>>>> +          - brcm,bcm4912-hs-uart
>>>> +          - brcm,bcm6756-hs-uart
>>>> +          - brcm,bcm6813-hs-uart
>>>> +          - brcm,bcm6846-hs-uart
>>>> +          - brcm,bcm6855-hs-uart
>>>> +          - brcm,bcm6856-hs-uart
>>>> +          - brcm,bcm6858-hs-uart
>>>> +          - brcm,bcm6878-hs-uart
>>>> +          - brcm,bcm47622-hs-uart
>>>> +          - brcm,bcm63138-hs-uart
>>>> +          - brcm,bcm63146-hs-uart
>>>> +          - brcm,bcm63158-hs-uart
>>>> +          - brcm,bcm63178-hs-uart
>>>> +      - const: brcm,bcmbca-hs-uart
>>>
>>> git grep did not find driver for this compatible. Is it in separate
>>> patchset?
>>
>> No. My project based on BCMBCA has been canceled and I don't work on it
>> full time anymore. I just wanted to fill empty bits I can afford
>> handling in my free time and complete hardware description in DTS.
>>
>> I may still work on some BCMBCA drivers from time to time but as a side
>> project.
> 
> This means we cannot use driver to verify whether the fallback is
> actually suitable. Considering that existing UART bindings do not
> fallback (brcm,bcm6345-uart, brcm,bcm7271-uart), I don't understand what
> is the benefit here.

I believed the rule for maintaining bindings and DTS files was to
describe hardware no matter what/if system needs it.

For example a year ago I added binding for BCMBCA SoC timer without
actual driver, see e112f2de151b ("dt-bindings: timer: Add Broadcom's
BCMBCA timers").

I'm not sure if we're going to agree on this, but personally I like
describing hardware as much as I can. So it's well documented /
understood and people may eventually write drivers for it. Maybe it's
partially because I come from Broadcom's world that isn't well known
for upstream efforts in general.

As for verifying this binding against actual driver I can definitely
understand your concerns. Hoping it may help I uploaded Broadcom's HS
UART driver extracted from the RAXE500-V1.0.8.70_2.0.36_gpl SDK/GPL
package: http://files.zajec.net/hs_uart/

Please note it's not much of a clean code and its design would not be
accepted upstream but hopefully you can glance at it to verify this
binding's compatibility.

Let me know if there is anything else (other than rewriting Broadcom's
downstream driver) I could do to get this binding accepted.
