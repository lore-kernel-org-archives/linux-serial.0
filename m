Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0SAMHP3"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFAF19E;
	Wed, 22 Nov 2023 06:52:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00b01955acso398133066b.1;
        Wed, 22 Nov 2023 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700664749; x=1701269549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjduiYvtWvj6YfqCLtNYU3x26czSa8Mvw7FpNlOUzfw=;
        b=h0SAMHP3E/5ZfoEz181XTbv0Upspdw5XLZDk19crcyTYpBz3nWG2t5xDnO9KsoHDhl
         xdsSRyBQLbYwRJVObqUzASqGSM7xf8zz5K6KJS5IfSTBx+ZK9VSroESLUcflp4BJydH9
         ZzGSSY3dGnMrpmCO5MiweWztV2lqxZXfh2P0YGEPyLQhKQuYfvYjgOzghCOzfv1lLtBK
         sMdM2D4GUm0CXhTOluR6ISybGhd4xDuOPiZZZn3QI1Q8kt4q9tUAd9h9bkb0kdmdVQB7
         sujU08MBbPZ+rGJ2GmOfDGm8kNJxOTqao5sVcO5ZDecNQddexqedkc/RmLbYlnkhKHzc
         EAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664749; x=1701269549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjduiYvtWvj6YfqCLtNYU3x26czSa8Mvw7FpNlOUzfw=;
        b=mehQsga2FhfhlmlGazd5+hwiec55f+7/AczLN4cOIYkJ3ooqGgyPxKrN0SvhxJCono
         F/JNhn3IHYRORXxab9JUAYXnCQKP7P7n19vHKBDfeff5OjXEPsfaZjdrCN6aXcdIIEcO
         8196R6rBVmN6A5NKFu1bqrRRP+uuk4An1eHJCkjPEr0KZdmQA87DTaCytYYXtzfTaIjL
         UxLBVp7pUSnvyZozm77AXg3LixvlAilKumpULDm5hTRV0wMlOXzcwwizOKVe8xZcGcRb
         nR+wtAwF8iCx4dMr2ohkooE9yD2dZsny3quAKIQ+KL1/N5/531Jc1kWZS/mWAvR5IW6b
         mP4Q==
X-Gm-Message-State: AOJu0YytWv0DDYUI57q33p47qvsZYoXbU24XD9uxHdHALaolXamI69u1
	+3YZfkTUsJpPRi7gaXOUl84=
X-Google-Smtp-Source: AGHT+IEMqcQRUFdGWkrI5L/etTet6J5g1onGDwU5S0VBdtp9imvnm61FdFt01Jydi1cxH7hImfxeCQ==
X-Received: by 2002:a17:906:4e90:b0:9fa:caf3:fb17 with SMTP id v16-20020a1709064e9000b009facaf3fb17mr2097185eju.51.1700664748743;
        Wed, 22 Nov 2023 06:52:28 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id u19-20020a1709063b9300b009e5db336137sm6724182ejf.196.2023.11.22.06.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 06:52:28 -0800 (PST)
Message-ID: <08fcb328-fe4b-40c7-a01e-8a0b527b1c71@gmail.com>
Date: Wed, 22 Nov 2023 15:52:27 +0100
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
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <66c4b54b-7631-484a-9f7d-31542284e620@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.11.2023 15:46, Krzysztof Kozlowski wrote:
> On 22/11/2023 15:42, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> It's an UART controller that first appeared on BCM63138 SoC and then was
>> reused on other bcmbca familiy chipsets.
> 
> If there is going to be a new version, typo: family
> 
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> V2: Extend "compatible" and rename YAML file accordingly
>>
>> Krzysztof: since I reworked "compatible" I didn't want to carry on your
>> Reviewed in case there is sth wrong with the updated schema.
> 
> Thanks for letting me know.
> 
>> +
>> +maintainers:
>> +  - Rafał Miłecki <rafal@milecki.pl>
>> +
>> +allOf:
>> +  - $ref: serial.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - brcm,bcm4908-hs-uart
>> +          - brcm,bcm4912-hs-uart
>> +          - brcm,bcm6756-hs-uart
>> +          - brcm,bcm6813-hs-uart
>> +          - brcm,bcm6846-hs-uart
>> +          - brcm,bcm6855-hs-uart
>> +          - brcm,bcm6856-hs-uart
>> +          - brcm,bcm6858-hs-uart
>> +          - brcm,bcm6878-hs-uart
>> +          - brcm,bcm47622-hs-uart
>> +          - brcm,bcm63138-hs-uart
>> +          - brcm,bcm63146-hs-uart
>> +          - brcm,bcm63158-hs-uart
>> +          - brcm,bcm63178-hs-uart
>> +      - const: brcm,bcmbca-hs-uart
> 
> git grep did not find driver for this compatible. Is it in separate
> patchset?

No. My project based on BCMBCA has been canceled and I don't work on it
full time anymore. I just wanted to fill empty bits I can afford
handling in my free time and complete hardware description in DTS.

I may still work on some BCMBCA drivers from time to time but as a side
project.
