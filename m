Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcuML4ag"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ADD19E;
	Tue, 21 Nov 2023 22:17:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a00d5b0ec44so295975066b.0;
        Tue, 21 Nov 2023 22:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700633867; x=1701238667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZWHrDJjBzioVxFvVfoOYSDud+iYI4PeTh/okXrEDYQ=;
        b=fcuML4agBBAmp50EXoo3YItZA2E1kxRFpvPxnyhrVOhrQkTcWtIp7C0p0fUMQEnzr1
         FnMtrZgJ//UQhJbsSoigS8lqZxpyI34G2mu1eEmoRat5rwDpd8zBYNfNktPsevxUijqF
         NBTHL8FVk/KZFxvCNWnAtrP4SJl+ucIsNYDmxLddsTS4BXtg3AS0u7D6TBFprTX18eHK
         O4d6mTxUFzQRtctHskvBPI4ZrXQIr404V+RH7wrll8fGfGf/WU0p6rXB4ZPmJBYWN3FI
         cDxcZpQOmPpQEJPkzAt4IHaEh5z2YIFd3ZZ9fcf0XwacgTJEphAOLVw7/tf202P/b+x4
         CpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700633867; x=1701238667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZWHrDJjBzioVxFvVfoOYSDud+iYI4PeTh/okXrEDYQ=;
        b=OkzkXfL8ffx8rIbXYY9PF+GGgLy/QpQIX7lERSOVV2Y7Bu36D14HTDoKwh7zaSVSIZ
         xaLEFIOCL/4slvYkNDooRXsOixtfBX2qg+Jrx0+SX9Qz3J27UzjW4tB8gZPK+gK78xKR
         fAG2SWFKNVMmKR/AL1gIiCDoZFPeyRFHS++qmwT5aDbscww3cLNfhxXaZNhfcMrCMqKS
         iRcSLjcz4Odl3DrT/fx0bauJ/GlUIhEaYqaHSdM/S762+QE7wXQvessqacpGRihEZj7D
         qRKvufy6fJqhGMWq13Vj8AJudiZsRw43bui/gBhH/Osf1wtnFt28CPO1qDnCbh9BqC2D
         YgiA==
X-Gm-Message-State: AOJu0YxnyQe7hdi2J4/yESPKOs3pSEyxJDAD2wbQDoc8t8L7OqKKzvUz
	CPV4ArT+arbw3HR7XS5Ny6g=
X-Google-Smtp-Source: AGHT+IHpvXGS9IdYCdbZLW1SmZLzFO3i8foSwxeGk8BDZ1Smoa1wL9buHBST+Spf2HSZ+/fNH57xHg==
X-Received: by 2002:a17:907:20d8:b0:a03:69e:f616 with SMTP id qq24-20020a17090720d800b00a03069ef616mr775457ejb.57.1700633867123;
        Tue, 21 Nov 2023 22:17:47 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id gx20-20020a170906f1d400b00a0290da4a50sm1451042ejb.186.2023.11.21.22.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 22:17:46 -0800 (PST)
Message-ID: <3a2880a4-cdf5-4032-9cae-be2916237d29@gmail.com>
Date: Wed, 22 Nov 2023 07:17:44 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: add Broadcom's BCM63138 High
 Speed UART
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
References: <20231121121324.23268-1-zajec5@gmail.com>
 <26d71302-ebb0-4b2b-802e-0b3ebf75d68f@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <26d71302-ebb0-4b2b-802e-0b3ebf75d68f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.11.2023 23:38, Krzysztof Kozlowski wrote:
> On 21/11/2023 13:13, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: brcm,bcm63138-hs-uart
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
> 
> Missing compatible.

I stopped putting "compatible" in "required" in schemas back in 2020 :O

Back then I received a comment from Rob [0] in discussion on
[PATCH] dt-bindings: mtd: convert "fixed-partitions" to the json-schema
telling to drop it:

On 10.12.2020 03:48, Rob Herring wrote:
 > And drop 'compatible' as required. It's redundant anyways because the
 > schema will only be applied if compatible matches.

So I'll need some help here please. Should I start including
"compatible" in "required" after all? Or is that situation specific
(could you explain what does it depend on)?

[0] https://lore.kernel.org/linux-devicetree/20201210024840.GA1510718@robh.at.kernel.org/
