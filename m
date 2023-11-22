Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7N1HcD1"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F8197
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 10:46:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso344825e9.3
        for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700678790; x=1701283590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtyoQ6tEQBZednx24d8GSJgiJVQWnTTyIcyivWAktmo=;
        b=N7N1HcD15odifOq8Gr5dCQx3Q6i7c6uJH267JSJE8GL+MQzi/V8mkU9GOKq5VJtPDC
         M//90IHn4a8FcquSXuO2jR74NobuS2Qouszl2lqS52S/k+83viJp+cXg2lHgap59s9JU
         sQrDp4W81MljbpNqqQIISPeJDt73df33/ijG5X8yq5KFoh6rmoth69tWb+W6INY/6JHF
         mOa7ynCokvKyaBFSWs7/RAlC4znI4OJf8WzFilmYSx/2MOmObKXY3RoNktBOkYo1WYPJ
         sMm7y9ia0NSB0CcN3HS7V7n/bKaiG4N/70/ehMcIV5t3KBK2wAGVL+8m3LIHoWDSiBcN
         Ym2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700678790; x=1701283590;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtyoQ6tEQBZednx24d8GSJgiJVQWnTTyIcyivWAktmo=;
        b=jHZR2zOA8tCP9EbzLBWmndXmHlK2BweKAJscUO9RGPVZh+yfvDj3LuO/L1sBkj2d/1
         Bwa/yXm54E7hxbngkUxe81zZdzsuho41fAAg3Tbz8xR+fUQHRmwWo910jJIej2jYoSBR
         dF9WQG5T79zmXlL90SD2R4lVDV4qBCYZCAc+kwQ+kVgj77lnQyOd6QS7nkW9tqwDJ/la
         UZxYZKgmOgV1F+MFAvQkmhnBGR3mtv7TwX3jogVT8RVUEax/E1pXLSEK/cisDSz9Ok0H
         PKHMYIOtvbOCFPooKXkmPhWMtvKKIsgn3/zAnBenkDQ6o026t/h94MaACtVOx7Y/jBIH
         v/zg==
X-Gm-Message-State: AOJu0YwgbXGY9bjSqD+ayrlbi+DkkEc3NBQwnHsd1Z8f7wugotIYqHKU
	/Sm2QCJi+bfu91Z7juP6/DkbnA==
X-Google-Smtp-Source: AGHT+IFpdR2363d91ltLEnwpK9h9MMShOgLkMBwkuwkDbC+MeegQ1KnreOUEhLB4i38e3ST7jRbz1Q==
X-Received: by 2002:a05:600c:5493:b0:405:7b92:453e with SMTP id iv19-20020a05600c549300b004057b92453emr2537592wmb.37.1700678790040;
        Wed, 22 Nov 2023 10:46:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d64c5000000b00332ce0d7300sm71471wri.92.2023.11.22.10.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 10:46:29 -0800 (PST)
Message-ID: <525384ca-f84e-471c-bc82-0029db6ccb77@linaro.org>
Date: Wed, 22 Nov 2023 19:46:26 +0100
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
To: William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
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
 <57a77c9d-684e-4f5e-977a-4586e15f7c3e@gmail.com>
 <141deca9-6017-4e3f-a237-8dacc67662de@linaro.org>
 <03ad42c0-1648-43e1-bbd0-9ed02bdf4073@gmail.com>
 <b1f06f81-9248-73f3-b586-24e29bb9ab32@broadcom.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b1f06f81-9248-73f3-b586-24e29bb9ab32@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/11/2023 19:39, William Zhang wrote:
> Hi,
> 
> On 11/22/2023 07:52 AM, Rafał Miłecki wrote:
>> On 22.11.2023 16:50, Krzysztof Kozlowski wrote:
>>> On 22/11/2023 16:49, Rafał Miłecki wrote:
>>>>>> For example a year ago I added binding for BCMBCA SoC timer without
>>>>>> actual driver, see e112f2de151b ("dt-bindings: timer: Add Broadcom's
>>>>>> BCMBCA timers").
>>>>>>
>>>>>> I'm not sure if we're going to agree on this, but personally I like
>>>>>> describing hardware as much as I can. So it's well documented /
>>>>>> understood and people may eventually write drivers for it. Maybe it's
>>>>>> partially because I come from Broadcom's world that isn't well known
>>>>>> for upstream efforts in general.
>>>>>
>>>>> The problem is that "brcm,bcmbca-hs-uart" is not describing 
>>>>> hardware. It
>>>>> is saying that all these devices have similar (compatible) programming
>>>>> model, so the OS can use just one compatible. This goes away from pure
>>>>> hardware description into interpretation.
>>>>>
> It is the same hardware IP block used in bcmbca SoCs.  To me, it 
> perfectly describe the hardware IP block and it does not need fallback 
> because there is no fallback.  We did that for SPI controller although 
> it has two revisions of that IP block so we have brcm,bcmbca-hsspi-v1.0 
> and 1.1
> 
>>>>> Rob already commented on such non-SoC compatibles multiple times. I do
>>>>> not see any reason here to not use specific compatible as fallback.
>>>>
> Sorry I missed Rob's comments.  If we have any new rule or notes about 
> this, I would like to check it out.
> 
>>>> Do I get it right we should rather have some base specific compatible
>>>> like: "brcm,bcm63138-hs-uart" and then if anything use fallback to it
>>>> like: "brcm,bcm4908-hs-uart", "brcm,bcm63138-hs-uart"; ?
>>>
>>> Yes, or the other way around, depends which is probably the oldest.
> If we absolutely can not use bcmbca-hs-uart, I would suggest to use 

We can, but I am surprised that you want without any driver. What's the
point of generic compatible?

> bcm63xx-hs-uart to be more soc specific and in fact the oldest SoC have 

What is xx? Wildcard? I mean... ehhh...

Best regards,
Krzysztof

