Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728310958
	for <linux-serial@vger.kernel.org>; Mon,  5 Feb 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118887; cv=none; b=RrlsBAsyjqxWTrYIrhIrU4DyL8bkBPgQAIrvePOB4HDaPR8NhcY+igQCDHa0/YwHH4R6x9NjSsMXGbr15CGTyw7+rlEeItv6Bsv4/AKPP8lWwlkaRFwQrI3a5kS7oO99v+GkI7yHZfwmGfzNyiUEN+cEM4/Khk26UuTJFhE9q2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118887; c=relaxed/simple;
	bh=m3s8CvOnRVDd4A/sHox9BjffimSzPmxuvHxo7w6XeF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1DTNWem9tPVzlaeYRZQC/lol32tRn+cIHAmXmzTjjgLRXHAWGd5ZD612bTXqxiLJT9Y5/Rciype+Q3uB0xknN6pNp8Yg41RhRuce+wfYkztaOX2baLvDPcG5/aiZFUeFRUIXERtulvxpQx8b4SnumNMFltl+P7qbC7XXWeItgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OJykxiLA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJykxiLA"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a30f7c9574eso543600366b.0
        for <linux-serial@vger.kernel.org>; Sun, 04 Feb 2024 23:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707118884; x=1707723684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlKQQZ10mTGzXpOpSYWOXKuFRQr7h89RLpabq7fR/IM=;
        b=OJykxiLA7rwtHbDP8N4ieHRTPaJgBsenL+rxy0/Q+GJuMDKxEXND5A8wsVwuLN3ztK
         9i23hNULMKykHgEZwgzMCIOULEMmtLOkPkd2l9EOFza6k/KKUR9VJ1BCeU6N3WLoyUGn
         aHZLQfxiPzu8N4jEwGGZ+d4AViCpSf0RhWjZspC6fUQgBNnD4YzVZmKOYNLJ9XB07Drm
         uvcwA3HQGncXJmVgdF4wlDc/c03mGA942qhpPhZxafe2v9N08uaovP7WTBosVV99hPZk
         6KnTCLf9mGWihgT8cvAieStMLp59YNY5WVacKPbgBB7GOCDDlTbZtn96NxvaD/5GeCqq
         xLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707118884; x=1707723684;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlKQQZ10mTGzXpOpSYWOXKuFRQr7h89RLpabq7fR/IM=;
        b=Zprp4gOK9vwYShVNW/R/f7b2wTZ80MtVhZEuCsQQNOoQAM+pBU75QadmREGvYYCb6z
         8YWDCcQtkH05BZO9usfZVHCnfo41ay68BbhE1nBGAFXKitCgf9GinKxF8dV7YZxjZDQT
         Ca6PJACQmgRY/oNKXS71t5M8fbDAZPUldju6nJfIjivuyT8ZhOuRcZOnYwp9AGqGl1h0
         6imj4HvtLuWgWRVyVwDC3AV3ybgHJGTbawO6oCw1+3k6IfOPtZeQHZMo15f6Dge8jgcB
         6EeQHtE+Bqutm+Yh9ajGYFed8jvZ6z6Ux3EMumSFSAmGyxX83ijn1N5NWPG1aBXq8Mn8
         3AHQ==
X-Gm-Message-State: AOJu0YyVO3E7ZEsOb5Prx3llxOBQWXb+3I7wyZZnyH608x0PITWkBNnZ
	hNWsKXoBVL18gQgg4RWOE61MkysQed69ug+00m3oArE+jzjUZ+ts4v86PaYuios=
X-Google-Smtp-Source: AGHT+IFsfLx61Hv2XlhZphvnONlM8hwvn6dKB4tEqBvk1rMW54gPE504ItAlIkcTvdvpM9IYn7urvA==
X-Received: by 2002:a17:907:100b:b0:a37:c159:60a8 with SMTP id ox11-20020a170907100b00b00a37c15960a8mr1111425ejb.29.1707118884053;
        Sun, 04 Feb 2024 23:41:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX9xSUpxkOD0tREL0sDBvK0ofJvUWVdN/yAYCSI1I87SYMvYZE69rRJFj1VmKFIV9VYcMOwV9AEAogK10oX8K9AKs4DXyHt+eSU5LMZi6VXd6+aopUB4VEraJ6PZcX+S/jJdCirdHylovgfnsYO5E3HaFzcGJ3cS+y9rJ8nwZvIk4EEmZlIJZlhbfmndivjSFb5odduKI4SJLabcgnTcUevqgBXYroil7V6IGRy0jKZopPV3BmyHqRkg1TxnYnAOM1SOLysaGQPm+Izs/3Aj7EABPHt/zhtfAGOs68XSRCn0hkTS1/shxD7ofOvo801fkadh6RA1N/tcHY5j1AwoVy5xdJEdUb2ym4u3xnXOl6fMX2y0U3xphR+A6tzKsRLr4cjK/nZTUb/2QaIQR2iZ6GAaB0pLZLUNT9qPqYQcExkH8H+7Nup+s3jku0+jEDvyl2X/rCYBQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id st1-20020a170907c08100b00a35aaa70875sm4017567ejc.42.2024.02.04.23.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 23:41:23 -0800 (PST)
Message-ID: <6980c4d5-78a2-4c14-b21e-a5ed1e4d5675@linaro.org>
Date: Mon, 5 Feb 2024 08:41:22 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: fsd: Add fifosize for UART in Device Tree
Content-Language: en-US
To: Tamseel Shams <m.shams@samsung.com>, alim.akhtar@samsung.com,
 linux-fsd@tesla.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240202212448.74840-1-m.shams@samsung.com>
 <CGME20240202212459epcas5p2e1703c35ebe9302ac5b2f3d3fcd853c0@epcas5p2.samsung.com>
 <20240202212448.74840-2-m.shams@samsung.com>
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
In-Reply-To: <20240202212448.74840-2-m.shams@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 22:24, Tamseel Shams wrote:
> UART in FSD SoC has fifosize of 64 bytes.
> Set fifosize as 64 bytes for UART from Device Tree.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd.dtsi | 2 ++

Please split SoC changes from patches sent to serial, so it will be easy
to apply for Greg and others.

Unless you want to say that there is dependency, but there cannot be
such - it would be a NAK.

Best regards,
Krzysztof

