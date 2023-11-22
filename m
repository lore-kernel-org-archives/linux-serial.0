Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayNQNmg+"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3A092;
	Wed, 22 Nov 2023 07:52:21 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50abb83866bso989523e87.3;
        Wed, 22 Nov 2023 07:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700668340; x=1701273140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6HLdFWqjzgmADZk5za43c1oAHTKMJ5+QxapNhDsCkgU=;
        b=ayNQNmg+7GyUfLhmA2AGYTMNbjuRaOwLhSDvT6DAK+sLBWXrjAdRUQ9lr+JliSL8pe
         yPKhc2ykhuz8ER/xWpkrAZwU6TsXNv1mhJIH6lqjCoCIhhnAF1zh6IFjarJjEyJd/yXP
         MoSuYImxo6QFIfEeEVsQLx+BO24WS6TlbS16JqDu+gqvfGw5jRLXzDTZCOiJ2jKYunQH
         qC3GpjoWEYz3WyihZ94J5qarIYGMOazbVLNdojrEHlC1PZ+nsujjaY7BRsIKvIiAgo6k
         HBPrItoDGwHWHZ7/JriHnZKVA8Avi7rd+p8BZSk5+PHh047UD1TSxg15/k0yTlIq7JBs
         crzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668340; x=1701273140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HLdFWqjzgmADZk5za43c1oAHTKMJ5+QxapNhDsCkgU=;
        b=RlSy82xHWE2iWPXTin0NrsAWZ6r1xfIgHGaSvCdiViyzRyiPT4tc+OoHmPjqPd4jdR
         Cnc9DjlrUwc5UznuA7KqgDnLLLvROrlSl2UtRIqh45/ciKzJC4U42rf2iOdfG82h7anj
         GCtf9odvK2yTgEtGTCXjc/kBTBDJmfd+yYw0+Az2bfn58ag33PA56yiFIPSNX1p6j5yp
         8NCY50oZPJ5CeOdj8UPeBg9OYva76oFF1wxSccrSEgDEDTJR/Tpjd+007nuEDm6n/21Z
         j4h1EOCOWPwlWIfv1CQrop24SsZSNZr4nfdswMVvi3rO7HZRj3NabUq/o4bsdekZNQp5
         GgIQ==
X-Gm-Message-State: AOJu0YwEUtD9kB784RbR0R3eCvctHVH98ilM/RYcq4poI1hN1hP4IDkt
	hpWjHyYLk0o58ju9sjuntXo=
X-Google-Smtp-Source: AGHT+IFz8bHL5A9409Qb8y8YTBVeAHkgSDyqr67fzO1oNMQAhenPxUbUY/ZUHzL9iZDvBODsm9MveQ==
X-Received: by 2002:a05:6512:1256:b0:507:96c7:eb1a with SMTP id fb22-20020a056512125600b0050796c7eb1amr2724201lfb.54.1700668339546;
        Wed, 22 Nov 2023 07:52:19 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id g11-20020aa7d1cb000000b005488703d13fsm4726431edp.82.2023.11.22.07.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:52:19 -0800 (PST)
Message-ID: <03ad42c0-1648-43e1-bbd0-9ed02bdf4073@gmail.com>
Date: Wed, 22 Nov 2023 16:52:17 +0100
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
 <57a77c9d-684e-4f5e-977a-4586e15f7c3e@gmail.com>
 <141deca9-6017-4e3f-a237-8dacc67662de@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <141deca9-6017-4e3f-a237-8dacc67662de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.11.2023 16:50, Krzysztof Kozlowski wrote:
> On 22/11/2023 16:49, Rafał Miłecki wrote:
>>>> For example a year ago I added binding for BCMBCA SoC timer without
>>>> actual driver, see e112f2de151b ("dt-bindings: timer: Add Broadcom's
>>>> BCMBCA timers").
>>>>
>>>> I'm not sure if we're going to agree on this, but personally I like
>>>> describing hardware as much as I can. So it's well documented /
>>>> understood and people may eventually write drivers for it. Maybe it's
>>>> partially because I come from Broadcom's world that isn't well known
>>>> for upstream efforts in general.
>>>
>>> The problem is that "brcm,bcmbca-hs-uart" is not describing hardware. It
>>> is saying that all these devices have similar (compatible) programming
>>> model, so the OS can use just one compatible. This goes away from pure
>>> hardware description into interpretation.
>>>
>>> Rob already commented on such non-SoC compatibles multiple times. I do
>>> not see any reason here to not use specific compatible as fallback.
>>
>> Do I get it right we should rather have some base specific compatible
>> like: "brcm,bcm63138-hs-uart" and then if anything use fallback to it
>> like: "brcm,bcm4908-hs-uart", "brcm,bcm63138-hs-uart"; ?
> 
> Yes, or the other way around, depends which is probably the oldest.

Thank you for helping me on that!
