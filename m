Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7419284B49
	for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331899; cv=none; b=RqMZjGCiqEJj/tfXFvRueQv96EoiBq4Elcf/Y17GL5BBiXYTgyyXcRsziiA4dZ0Y7HZNKzCyCrnlZBYencqdvLr3MVKff16cAYU7I1PqRuuK4kC+EBbO2/4xTQXeiPSpXJvZEgbsEtSKaEGwNLuEOOZF7d7QBtQ/ec57DLO5mp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331899; c=relaxed/simple;
	bh=xTUfvuKK3CXOlCmv6ULKR27CtF4luRCZUB3LOCIZ7Q0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YuuFYVzdRp6Tx5W2T6gY3c/tIXEapsUWg4uVUlKQ02acf6rmIhc+rYqTl0nAFQEccW4EiivxUCzl6UOcoivTT5r1Hkp2i3dHg9+K15dmXlNT7NmTzPVfSvVcgsX8gjibvIoLl3lruoN43v2jOggm+vfwgPFG9l68ffBHjKuKscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TGsoT4C7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGsoT4C7"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso3771616f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2025 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745331896; x=1745936696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Jdsjo/xqjalOgmmmiDVixlLCvZSDipVTEuGlq4N+fo=;
        b=TGsoT4C73yCkwGFhTdpCEBq9rB4k6qf5Wy3oCkGbTuRnSxn7yolRSI3K6wxG48+ydj
         dLdf+WrnakMpBtkoIrI1kubWsPqv3HJl/Z7B1/9N64O58qLkKdY3Els44V7ImJgTQZIa
         yaI6CbCUCIlgMDgXXdaJfyCEX0Ba2QjcAgPnXqBWS0ojkcWMBYaMf2RbAVggj+zMxAQf
         MJq3Qv0rsFkkpCLgTgpu5s3afpbpD0UaNSXF2odfUN3sOYh90sZEjO4ElTcfhD54sUgW
         E4h72iArkT/5b5TUgtYztNG2MMdTuYzK3ANMCRnldJiRj1O1dX/hZw0IDfEApyq1ijih
         77Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331896; x=1745936696;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Jdsjo/xqjalOgmmmiDVixlLCvZSDipVTEuGlq4N+fo=;
        b=Y0S00IslXM9DIqhRWUJG4KM3VxEN9K+D6zX5CTykUnEvqvyd7kyCYRS3xWsyVQHO/H
         3anfMSMnByQe8qf0pycUcSVLIcDEG73TOZSDXS24baBuUvJLV/K7/bnUYpY4MDfAO/o9
         gtwcN4f7RVYxuCu5hRBo8vWb3fPWi2EMq0CD0GL49GO86+DmACzbtRvTVeDDvm6R3/+T
         jUmoQo0tMHKCZANpYPk2EO4xBi+deMzzWdVSVmt0ILUCBLyAtJ5pAlTG/lsDO9VstFso
         8iWyxIwCyP7d/23rdAhqRGzuXLQ54QkWP0kvsb8leUZmB3G8eU9pZP+6t1HTaGu0FWKr
         2d0w==
X-Forwarded-Encrypted: i=1; AJvYcCVEIjKIsFKu1tkIRhJK77IJla+Flt+8qxWaSqhhKDZ93ASrQg57ceWD3rdOMV+obCdq3wqqLHIIyRsBvEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfudRtmEDcIY6w6tSHFN14iLWKNECnSbfJvcW4jfQBzHUR3la
	PCTYGZouLpIhJfPfOZ5UCxguwGnH5dnCS1/R5nfOZmAm8Efra364DGlkaKnuFv0=
X-Gm-Gg: ASbGncv6+tcrruZaKUjhvLcHNa8RRNVdSeufGNbL+u19LcUSpy1pmpBnOCt0MkOg3Pe
	7wuGnUVYHH6LyJqLxQhyt1x6HcnCGacnYwOL9xi/OQyiXGHnUFrsRj7/HQ8lhFdAb+UZfCAjJGO
	ZC1Jx+8lXmdN+DksJwxSl2sTWC0JfOpl7sQDG68h1gWZqFbltsZGwDGKB3D6B/PIKsWKjGykheW
	GyQG6bm9T00Nw9n3nDxD2ZSzzH2jS4VXitfsTFkp4psvchbbV0M9PQDIPVWJ8QcE+/loXpUp9xF
	GhSwWzySFl/YWzuqBD/oFQ6qlO1LdJJK/s6PR9SUHwH7g0f1+13vASI2x3bdxC6p8rmI9QTzTv+
	X73fsyjrNqn0NMbqnUg==
X-Google-Smtp-Source: AGHT+IEMq6D90tumtgiQfuL2iL5ojy1eqb4ZpCOQZ/eL/OvCUSv21+5Nv4KHfhG+kRfhKAADVI9aCQ==
X-Received: by 2002:a05:6000:4201:b0:39a:ca0c:fb0c with SMTP id ffacd0b85a97d-39efba5f80amr12032095f8f.28.1745331895992;
        Tue, 22 Apr 2025 07:24:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b137:7670:8eb9:746f? ([2a01:e0a:3d9:2080:b137:7670:8eb9:746f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6e05d6sm181482765e9.40.2025.04.22.07.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 07:24:55 -0700 (PDT)
Message-ID: <71a6cd6a-cb2b-4628-b558-01c2172a94f9@linaro.org>
Date: Tue, 22 Apr 2025 16:24:54 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/7] Baisc devicetree support for Amlogic S6 S7 and S7D
To: xianwei.zhao@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/03/2025 08:16, Xianwei Zhao via B4 Relay wrote:
> Amlogic S6 S7 and S7D are application processors designed for
> hybrid OTT/IP Set Top Box and high-end media box applications.
> 
> Add the new S6 SoC/board device tree bindings.
> Add the new S7 SoC/board device tree bindings.
> Add the new S7D SoC/board device tree bindings.
> 
> Add basic support for the S6 based Amlogic BL209 board, which describes
> the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
> booting up into the serial console.
> 
> Add basic support for the S7 based Amlogic BP201 board, which describes
> the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
> booting up into the serial console.
> 
> Add basic support for the S7D based Amlogic BM202 board, which describes
> the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
> booting up into the serial console.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Xianwei Zhao (7):
>        dt-bindings: arm: amlogic: add S6 support
>        dt-bindings: arm: amlogic: add S7 support
>        dt-bindings: arm: amlogic: add S7D support
>        dt-bindings: serial: amlogic,meson-uart: Add compatible string for S6/S7/S7D
>        arm64: dts: add support for S6 based Amlogic BL209
>        arm64: dts: add support for S7 based Amlogic BP201
>        arm64: dts: add support for S7D based Amlogic BM202
> 
>   Documentation/devicetree/bindings/arm/amlogic.yaml | 18 ++++
>   .../bindings/serial/amlogic,meson-uart.yaml        |  3 +
>   arch/arm64/boot/dts/amlogic/Makefile               |  3 +
>   .../boot/dts/amlogic/amlogic-s6-s905x5-bl209.dts   | 42 +++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 97 +++++++++++++++++++++
>   .../boot/dts/amlogic/amlogic-s7-s805x3-bp201.dts   | 41 +++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        | 99 ++++++++++++++++++++++
>   .../boot/dts/amlogic/amlogic-s7d-s905x5m-bm202.dts | 41 +++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 99 ++++++++++++++++++++++
>   9 files changed, 443 insertions(+)
> ---
> base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
> change-id: 20250221-s6-s7-basic-f300c30877e6
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
