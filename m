Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gml/7Qtx"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D076E100
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 07:50:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso31706145e9.1
        for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 07:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700668251; x=1701273051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2tmhjvcsKiHnKgWm6vU0iHrvHQIkiyBJl0MTc6QsuE=;
        b=gml/7QtxKUN51ZMTcdo6jLX37Yzs/RbOLDxvpr80BjOXxMAjtZpXuDOcU3dVd52QDX
         ZeX/jFcVn+9jhKnzKz3d3hpQhpiczd0D3PGuNdLXnKUfg5/kSYCt8cw0HEGuBdj+FUVK
         JcNIUBAMzxccfS7iiENh+Sb7N6AS536P8rPf7fD9H6HHtlhflPQJhuYHUCGlrnrrqUZZ
         Cp3HMms9rRKgYYtpZMuj4BjgZ/PLbsSXScI43V/278EYTI/X+BPrqBqQIZ4035oNPK5S
         GiZx96FXN39NRBZi09zIt2gLemeyDAGIvypq3mLBW7FEKMl7ap7vg16sdhJ4K260tMgi
         JVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668251; x=1701273051;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2tmhjvcsKiHnKgWm6vU0iHrvHQIkiyBJl0MTc6QsuE=;
        b=LlY/l0Pqni4TOHs7HKJvAUzLNtYFqfhbOrdz6Syo6an1FRoqzhutpscKIwfygaDBvq
         5uaFob5qk15UoxbJ6oP3+gmFAAZLzuxF8lkbDTVsdFpeGSzF8+wUEJKVBWQqySwJdBsV
         Nuwdcu1RzW2ptfb37WTJpYXnhk3t4SoOeCZb1QbKEggRj4etCWhOA28kouG/u+DgR+Wj
         CmkjFfcWvNgify0Nmh5nsaWYvDIQRuprWi912NUcvsO37K/3dG94l6KzK8mnXhYk+JzJ
         OIO0Yln5eDI0mrEYPLwbHHT1nFcuGHiG8Yy0wduoB5B4KVyzBqJ0wRfVHDlmJ598XaJu
         geBw==
X-Gm-Message-State: AOJu0Yx4upCkkQ66A7N2nk0soXA3Bl6qv87vZGvoR7jfde1fdcCaphx9
	6WYRYJ9Q1AnilSW2Zt55WSz7Hw==
X-Google-Smtp-Source: AGHT+IHxD3Cfy6VkEi0krar/OZkatiLnkCkuN5a4C37JZLMCc6aPy3RBkbZ20GJowNsCewtePAOu8A==
X-Received: by 2002:a05:600c:3144:b0:405:7400:1e3d with SMTP id h4-20020a05600c314400b0040574001e3dmr2430595wmo.32.1700668251058;
        Wed, 22 Nov 2023 07:50:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c469300b0040b3027ddc5sm2641552wmo.37.2023.11.22.07.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:50:50 -0800 (PST)
Message-ID: <141deca9-6017-4e3f-a237-8dacc67662de@linaro.org>
Date: Wed, 22 Nov 2023 16:50:48 +0100
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
 <ff32cd00-e26b-4ba6-bb08-a89c702895c9@linaro.org>
 <57a77c9d-684e-4f5e-977a-4586e15f7c3e@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <57a77c9d-684e-4f5e-977a-4586e15f7c3e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/11/2023 16:49, Rafał Miłecki wrote:
>>> For example a year ago I added binding for BCMBCA SoC timer without
>>> actual driver, see e112f2de151b ("dt-bindings: timer: Add Broadcom's
>>> BCMBCA timers").
>>>
>>> I'm not sure if we're going to agree on this, but personally I like
>>> describing hardware as much as I can. So it's well documented /
>>> understood and people may eventually write drivers for it. Maybe it's
>>> partially because I come from Broadcom's world that isn't well known
>>> for upstream efforts in general.
>>
>> The problem is that "brcm,bcmbca-hs-uart" is not describing hardware. It
>> is saying that all these devices have similar (compatible) programming
>> model, so the OS can use just one compatible. This goes away from pure
>> hardware description into interpretation.
>>
>> Rob already commented on such non-SoC compatibles multiple times. I do
>> not see any reason here to not use specific compatible as fallback.
> 
> Do I get it right we should rather have some base specific compatible
> like: "brcm,bcm63138-hs-uart" and then if anything use fallback to it
> like: "brcm,bcm4908-hs-uart", "brcm,bcm63138-hs-uart"; ?

Yes, or the other way around, depends which is probably the oldest.

Best regards,
Krzysztof

