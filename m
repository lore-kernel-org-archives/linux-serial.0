Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3E64CF9
	for <linux-serial@vger.kernel.org>; Fri, 12 Apr 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927362; cv=none; b=SkVy0bl21VhY9LyDONhgHYkjk/dHZIenSJ4HLp/FJI2iMPwcRpzi83svBxbm65+Kqarmn3gMQfM0Yz2UtGnjJcPoIyDR1C9gM/PCbqDBySUVuc2xPMmyVNXPZZTZGfU+RV0lxISE1ymB7NSD5AEJc41IWah5zDTAbPDVLgRxVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927362; c=relaxed/simple;
	bh=SudR6AJ+t1I99GYlhWex5QRCgcTgbdlUZZ+b4umDBxs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=krJz5yq9W+PcQ3q9w8cedeMzV7I9SGhJgLyime/z/CTAgn+QKh3cXE5M/he2CnE4TbaADfyVSwrZZ7zQVzS7iSR/+7e5OTVUSY9/QG3af0BJmMfV/3heeDo8EhiYi1ld3jykW/2vra3MGS+MoMbUGPtsyBQZzEWntB8QR3A44Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rctKXgMW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rctKXgMW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41802f985baso3070085e9.3
        for <linux-serial@vger.kernel.org>; Fri, 12 Apr 2024 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712927360; x=1713532160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mV7BMke1UIa5mb95gKPd8HhIzp2MCcM69xRq4po3gY=;
        b=rctKXgMWm0+0NaOoYTnm+d11SGs8U1uE4lHxpkKhgT+84QmwbbWJWalcPXKIdAYPzj
         ae8FYltS0tIiBzvFRkhJ70Kkgh1lNMDbi/gUgEZ3BgwWUFfOPHSLi3KvuPuN0dgo7jhv
         EpHrLVVuQgRLOKcg/gLRVv2+ID98hxkKeQwxKsIFTXlpOkOw6ND8zCjbHiQuTIQHrpR9
         i9kuyEJOZM4Vd9ldr+beJBE1TMvbTmoUU7cIIwhTWoq+o0BZ7XyeY3FMUFhWQWoTs4dG
         LOFt6Hn3rhc0D7nr49xG9fr90hp9/g9RVh9MQaoLeFMnjfupJnHHlctCSft3NfIL9ulB
         Z35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927360; x=1713532160;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/mV7BMke1UIa5mb95gKPd8HhIzp2MCcM69xRq4po3gY=;
        b=tYzGtrA16PKO3H39FD3WNspJHDpk+q+NTJ6ocyqb0kCHrhaSf4Bt7GdQkEgOZ3VYlj
         zk8WTbe79n/ixnFgYYVVp56kPAGUKcRiHl2DDk71XhwydBtuDQbBUKMh3uQxie6A2Wym
         t1OyVrTakhA4FHXxBp7rBDcE9p6uXsER99CU/XHsRxd9SIfGySAXJsJmnC1qqNkv2U4N
         vDa7OtghWNmVHD2HNBzKeN9QMRiXPfl95t+riLaqbRNxac72jnz248py9pRUkNWZBWZi
         vueTxCeGJcU77krLz5tfsAO5ksaRJNfoGsHEbpq95G39LxH/Q026n4QpVA+npu1hKXci
         JT0w==
X-Forwarded-Encrypted: i=1; AJvYcCUnOB2oGUGf//FLrIWB8fSr1AI+vzLHEybimLoJMOAZfw2mpY2Ly1nHdNj0Q58oq2AK8NE7fDufrovVK5W7QoLh8gl5OXSqVb+39f7F
X-Gm-Message-State: AOJu0Yxp6jes4DHy0k3Wb4yiaampStqXeXXZmgQTGTCAl4jJx1PtZ94J
	cjJ8jBlUNGc2MeaFjFXTliafpHOvb5f2ah/v2oo9unqih6TNNdsJvoKXcjPCCfo=
X-Google-Smtp-Source: AGHT+IEAyK9cKqRWpSgxfI0K1PfDcNfIPSuyV7Xa16+5eyFSd02DJFnbu/C6yLCsxNJauPE0X8SWWg==
X-Received: by 2002:a05:600c:1f93:b0:416:bc18:2a00 with SMTP id je19-20020a05600c1f9300b00416bc182a00mr1973759wmb.38.1712927359295;
        Fri, 12 Apr 2024 06:09:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:986c:54c:12ce:a121? ([2a01:e0a:982:cbb0:986c:54c:12ce:a121])
        by smtp.gmail.com with ESMTPSA id j24-20020a05600c1c1800b0041643c9cb0dsm8907068wms.42.2024.04.12.06.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:09:18 -0700 (PDT)
Message-ID: <ea89f2c5-c9da-46d8-b431-5fc83b1a1738@linaro.org>
Date: Fri, 12 Apr 2024 15:09:18 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/5] arm64: dts: add support for A5 based Amlogic AV400
To: xianwei.zhao@amlogic.com, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-serial@vger.kernel.org
References: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com>
 <20240401-basic_dt-v3-5-cb29ae1c16da@amlogic.com>
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
In-Reply-To: <20240401-basic_dt-v3-5-cb29ae1c16da@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2024 12:10, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Amlogic A5 is an application processor designed for smart audio
> and IoT applications.
> 
> Add basic support for the A5 based Amlogic AV400 board, which describes
> the following components: CPU, GIC, IRQ, Timer and UART.
> These are capable of booting up into the serial console.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/Makefile               |  1 +
>   .../boot/dts/amlogic/amlogic-a5-a113x2-av400.dts   | 42 ++++++++++++++++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 40 +++++++++++++++++++++
>   3 files changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 9a50ec11bb8d..154c9efb26e4 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
> +dtb-$(CONFIG_ARCH_MESON) += amlogic-a5-a113x2-av400.dtb
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts b/arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts
> new file mode 100644
> index 000000000000..11d8b88c1ce5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "amlogic-a5.dtsi"
> +
> +/ {
> +	model = "Amlogic A113X2 av400 Development Board";
> +	compatible = "amlogic,av400", "amlogic,a5";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart_b;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 10 MiB reserved for ARM Trusted Firmware */
> +		secmon_reserved: secmon@5000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x05000000 0x0 0xa00000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&uart_b {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
> new file mode 100644
> index 000000000000..43f68a7da2f7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include "amlogic-a4-common.dtsi"
> +/ {
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +		};
> +	};
> +};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
