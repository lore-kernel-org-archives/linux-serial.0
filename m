Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFXbsxPl"
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F065CAC
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:38:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-334b2ffaa3eso5307093f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702409924; x=1703014724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5/mmDf6i4WSE8pvdnXAwPgmxiFf8Q1EZ+f4zzgn/a4=;
        b=uFXbsxPllrLv5vfQPnuuIcRh7rEJFjP1pceRpcqzjS0MbnTMNYVn5AIGnewbVi3396
         WLPSf/77yoRIJ1O24O4Ur2auIvhNjukRZ5ioddK3jP7nc+zIJ+wNas5aunMjd8Nd62wc
         Z+fqC7QlOn/Erhzxe/YuNG26L3wCpTZqFRPzTfk8h9UytTeervx1qHcODTUWMBNvRY79
         SOxQDier8qToRzvOFXzHCVRtVRma16ZT8No5+e8m0quxT4CEXIulZr05lxjG7tOOi9dy
         6mGxeQB7gGBobL7rWZGJ3OQea10qvEmdUnqhDCX8S3KWJ/xj17y0jsK4WCCaopypb3sP
         fNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409924; x=1703014724;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5/mmDf6i4WSE8pvdnXAwPgmxiFf8Q1EZ+f4zzgn/a4=;
        b=fYdXSLEiiyuTNj3b0X4njNEeGh3V1uSPZpJs1Fk/xav526gOHziGXrY90Uv5syzGYj
         KYfaajwSTy/R0hrydR79HIaNDM3nj8atrEAxRanCMBo+irS4IPkUDtGjfDBJWxYUt+Hu
         qnP6Jm37go4d37GPo2zYCH3beMhgPty9mURm0dTXW9v2cJ/RQiZE2G8wucYTrGXRUPfo
         chozyVsM4MsfCa5AldBg3/84trF3MXz5Rcb177pDcliZ7fP+vmjTeePOKepx9AumPRPt
         12QND2AgYYsr9P0MSCS/xOs8EMJqmMNEk7BAWuwuDJr+cR3iGVBnMMvoCtk8cz0Xbcsn
         s0mw==
X-Gm-Message-State: AOJu0YzhxBEGQEUd9jLhpipUxhjHAThRoUEkZvJbjD/5KuapxIxq5g83
	+Sxj180B8p3dlQvSnzdgTS5xlw==
X-Google-Smtp-Source: AGHT+IFhyWGCr5h5CFGNV1gHohIztgHhXgReWMkDqR+t1DoYs9PgLZGTJWhHHlBSS3UF+699jmriQQ==
X-Received: by 2002:a5d:560e:0:b0:333:2fd2:68c3 with SMTP id l14-20020a5d560e000000b003332fd268c3mr2994299wrv.86.1702409924437;
        Tue, 12 Dec 2023 11:38:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id h11-20020adffd4b000000b003333298eb4bsm11609609wrs.61.2023.12.12.11.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 11:38:44 -0800 (PST)
Message-ID: <d23cc32c-8a5b-48aa-be4d-608fbbb9ac3a@linaro.org>
Date: Tue, 12 Dec 2023 20:38:40 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/16] clk: samsung: clk-gs101: Add cmu_top, cmu_misc
 and cmu_apm support
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 conor+dt@kernel.org, sboyd@kernel.org, tomasz.figa@gmail.com,
 s.nawrocki@samsung.com, linus.walleij@linaro.org, wim@linux-watchdog.org,
 linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 olof@lixom.net, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 cw00.choi@samsung.com, alim.akhtar@samsung.com, tudor.ambarus@linaro.org,
 andre.draszik@linaro.org, semen.protsenko@linaro.org, saravanak@google.com,
 willmcvicker@google.com, soc@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-watchdog@vger.kernel.org, kernel-team@android.com,
 linux-serial@vger.kernel.org
References: <20231211162331.435900-1-peter.griffin@linaro.org>
 <20231211162331.435900-9-peter.griffin@linaro.org>
 <CAL_JsqJ_NUajmQs8ZYiE2GpvNxBwtkLRE2jvWDU3hKtztt92Ug@mail.gmail.com>
 <CADrjBPrkso2cM8zKq-WU8WC3P3A9YoS6nqX-f6XvSNS-EofK9g@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADrjBPrkso2cM8zKq-WU8WC3P3A9YoS6nqX-f6XvSNS-EofK9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2023 20:46, Peter Griffin wrote:
>>> +#include <linux/platform_device.h>
> 
> You are correct, this header isn't required. If a new series is
> required I will remove it.

I dropped it while applying.

> 
> Whilst you're here I'd like to draw your attention to [PATCH 2/16]
> where I've removed your reviewed-by tag in v7 because I added the ect
> node documentation in google.yaml. The empty ect node is required to
> be present by the bootloader or the device will boot loop. Can you
> re-review that patch?
> 
> The alternative is to remove the empty ect node, and the binding
> documentation for it and add your Reviewed-by tag back again. But then
> an upstream kernel won't boot 'out the box' on a pixel 6 which seems
> less than ideal default behaviour.

Best regards,
Krzysztof

