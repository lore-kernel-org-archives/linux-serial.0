Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NB/GO3FT"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD9419D
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 06:46:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4083f613275so34651055e9.2
        for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700664415; x=1701269215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hT4gwDbs3O7BYvQXCc9YUYVeI1kWDO4jgcz26m3HltU=;
        b=NB/GO3FTj8eocNGoCJZsrq4ooKJ4sKVKBiHEDSrrb8LP4tPDjn+gNeY5NRshD/3AAD
         bFfy+9QrWDZRc7LQdgYkf8au6uxVAsRdkq54NuQTLPK2z9SyS5ix2nd++j+82rTw528e
         Nexog23V/nhDdDLJE4rCx4qbnds7cpniiYHdT7qXKmkjXpfmhUKZk+UZ7SQsD5OSu94e
         18BT9Y5YY1qbsq2oxmDPbpVw7697kCi6DEHo5P72Ehjd2UzdzOwXT3oo+yUMTbfl58Hn
         JNqxh8sHp0tFVJOR0f7KjzIaCAkD3+VbEuzxFX9GGZPcRTfvO1K3BOcZVokzb1QvS4e9
         1glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664415; x=1701269215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT4gwDbs3O7BYvQXCc9YUYVeI1kWDO4jgcz26m3HltU=;
        b=dyN/Nj4oH72cXuxT6d/tV5ZnndMDnK2YA9PZH8qyXR5cVUvRvsRHSBZzR8CrB6Ojd/
         F+XIkL2hm+NIUNmtCOdpmBXriz/itycA/wQMphtWOwF28CGRqEG6gujMOi4H94DLBbGO
         G10Tq09i+l0NUcKYfiWIJzI9CoGtHmHXMIQuq71GXxD0PYetMVFZEmZIc4PLzJZ4KNRI
         LovuQI+x58MwOA/wiom+UodDZ4nzOiUMKCHjODLkP8ctNpL6cWR4jqPscgQaK4kF+k1S
         avrBfBGiN0imQCoca5V+o34lwlvgj1JtOf9I0esusW44in56BwWCavbxdq4gp7f3zyld
         d4QA==
X-Gm-Message-State: AOJu0YxlOblPYWi9lxo9/6T5+Xb8XOcWYo7aW4JKsefkAEOfYTMPNnl2
	rws/VeBFLq6PmkXJipvAJykXaA==
X-Google-Smtp-Source: AGHT+IHydvoBEeVASsaJa1LJeEqmfweGZEyyteKBKCBmWenH4DK67q10WlOv+uBVYydKtjwndew4HA==
X-Received: by 2002:a05:600c:3510:b0:408:2b:3ae with SMTP id h16-20020a05600c351000b00408002b03aemr1527793wmq.6.1700664415452;
        Wed, 22 Nov 2023 06:46:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id bg36-20020a05600c3ca400b00406443c8b4fsm2426918wmb.19.2023.11.22.06.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 06:46:55 -0800 (PST)
Message-ID: <66c4b54b-7631-484a-9f7d-31542284e620@linaro.org>
Date: Wed, 22 Nov 2023 15:46:52 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: serial: add Broadcom's BCMBCA family
 High Speed UART
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
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231122144208.21114-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/11/2023 15:42, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> It's an UART controller that first appeared on BCM63138 SoC and then was
> reused on other bcmbca familiy chipsets.

If there is going to be a new version, typo: family

> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Extend "compatible" and rename YAML file accordingly
> 
> Krzysztof: since I reworked "compatible" I didn't want to carry on your
> Reviewed in case there is sth wrong with the updated schema.

Thanks for letting me know.

> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bcm4908-hs-uart
> +          - brcm,bcm4912-hs-uart
> +          - brcm,bcm6756-hs-uart
> +          - brcm,bcm6813-hs-uart
> +          - brcm,bcm6846-hs-uart
> +          - brcm,bcm6855-hs-uart
> +          - brcm,bcm6856-hs-uart
> +          - brcm,bcm6858-hs-uart
> +          - brcm,bcm6878-hs-uart
> +          - brcm,bcm47622-hs-uart
> +          - brcm,bcm63138-hs-uart
> +          - brcm,bcm63146-hs-uart
> +          - brcm,bcm63158-hs-uart
> +          - brcm,bcm63178-hs-uart
> +      - const: brcm,bcmbca-hs-uart

git grep did not find driver for this compatible. Is it in separate
patchset?

Best regards,
Krzysztof

