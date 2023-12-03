Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGqfhvn8"
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2FFD
	for <linux-serial@vger.kernel.org>; Sun,  3 Dec 2023 08:44:00 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ca0288ebc5so2050331fa.0
        for <linux-serial@vger.kernel.org>; Sun, 03 Dec 2023 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701621838; x=1702226638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYe4UchOTOmx+IhhiWhl7PSA8a9tRcASEzVNEwAW0C4=;
        b=KGqfhvn8GMFFoXJLKX4FqeGcXHDz5iKLlZQLhOkjJgLXw6WCa1cwUEH22XSLR0v7Nj
         M1zH0Sf2GW0NuDiF3YO+5gAv/VgZf0uZc1mFv/s73rxX/8hZjHVXP0eMEkZ5GYduvHtl
         lZKZF3HpuA1wuzBvyqXgzfT9863rLeStTiXHx6mKaxXZ0Pr1XSc2jwp+3jABaLQMN2u5
         MH6ja4s48+7DP8LJhT5aTF7k3eEVCcw3II3+2TXAuFHbDr87IRqRN6EcrOzmioSR0dJH
         5dCRHHpepuE5ueNdrQTyp7vb+35799+e9qoeebDwuFI0NN4tiSObHHt6+9J5v2KrKmHF
         DAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701621838; x=1702226638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYe4UchOTOmx+IhhiWhl7PSA8a9tRcASEzVNEwAW0C4=;
        b=cNHVoD+q9b1boE/fN/KtYjAgA0hkJTcW+QcfK8SJA2/SWG0obGcSUYNRcgl9ME8dY/
         J/rKoPpGlAZM9v1vTN88VJvUtc1LV3RhYekvEFM0eSJ8Yih4COGNxRLammPLcQaqW4fU
         YGPOtE22B4YochgowRZufp/pgGpgSunrypOSv0Foj3qQ76jM3HackwVJowTNyJN/qqW+
         SjVKI4XJ8cwx1v0pLIyvF7MJATaO47mlWVngDVH+B5PTv3kNGBf9gvGB8rrNxlFKl7O2
         xJ3uRr/S6DbGBQgpaiftPA4BmWvGy9yiO7Kzdra3g9NDbje81HxNC0uq+8ohjX4H37eX
         iwKQ==
X-Gm-Message-State: AOJu0YxEjPkBR/FJdjwR94HLfdasv85d0DA/sFEg3aNzb2uItsbYrGbC
	ANpmb9ZJUl7wf3A1h+bYCpeEqQ==
X-Google-Smtp-Source: AGHT+IGV61Jaz37aBiVe7xImrwL2VardAEpYityQQUDantYExUbIq8oWHSX9zBc+oS4/HPYq058png==
X-Received: by 2002:a2e:9911:0:b0:2c9:fd89:8099 with SMTP id v17-20020a2e9911000000b002c9fd898099mr308871lji.64.1701621838524;
        Sun, 03 Dec 2023 08:43:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id pj21-20020a170906d79500b00a188fe9563esm4265046ejb.131.2023.12.03.08.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 08:43:57 -0800 (PST)
Message-ID: <b1e6f756-bda4-43e8-a49d-5c46f2c9150c@linaro.org>
Date: Sun, 3 Dec 2023 17:43:55 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: snps-dw-apb-uart: include rs485
 schema
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, quentin.schulz@theobroma-systems.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20231201140542.323564-1-heiko@sntech.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231201140542.323564-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/12/2023 15:05, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The dw-apb-uart also can emulate rs485, so include the rs485
> schema to allow validating rs485 properties.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

