Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6F2482EB;
	Wed,  3 Dec 2025 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793560; cv=none; b=RMhfmGKILGcr0zbC/A88rATuU1+OM7v88u9wAR6kOnUa0+g040thQxXyRz2jDzATL1d74eO3XvTvzQoXHvykbyAuqTrLqZLfoWWgN+U09UWo+rOtahFCTA/2Qe2cX7x2UgK+MKXy0rKlfL6lJqOBX5LiuySSYXTS6aaqJSEpsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793560; c=relaxed/simple;
	bh=1dHiE50PARVA55BHa12b+LSSa7hK9g+a5iEtRcxDlp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9MYnzbvEVUKbag+f1k6ycfyMcjxCHoMKtZiBSb1g1YtwKeLeyLGYN9hDscTlef6MElPkBKfS9DsP+pMTyuVbL8hNOu6lbwTmL04WMb1EUMM0QknoSfKssmXSs6QW+bDqRV4kxp8TineACJISvO+Op7gq8TdAusxSLv3fxsUfik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqM1T9IG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqM1T9IG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAB2C4CEF5;
	Wed,  3 Dec 2025 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764793558;
	bh=1dHiE50PARVA55BHa12b+LSSa7hK9g+a5iEtRcxDlp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uqM1T9IGYpEfm3flEc6acjxt+jcMe1uCjtU7vIfGWEfzgkawFt7BTe1yGll+QeEEk
	 W088Sxp/enJhCOfGkk+seRmTQJaOj52oYR3WCf8mJ6uZOdBMq9wASvh9VHzYrMN/FU
	 o5IPUtvO1fkd9EqSAsTMPhDgNHQrwnNIQ9N3kmRTSWBcGU9rIZmyVXFlYqf9a89VNE
	 +ykjhbq3EgILzXIog8n1JocFR8AmcUBNluHAPTz9bmsEcOId6H9NSw7K6bdm/sk6GY
	 gRCJcmZ6QKJIQynMpq9rTJfqkHPusRPi0m4qaxb2xhaSHGgTUr60c6k6w4ONy8WXj2
	 f8ovhSmPdVr7g==
Message-ID: <87db9b43-ceae-47b9-9435-9fa297054fc2@kernel.org>
Date: Wed, 3 Dec 2025 21:25:53 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: add device-tree for Genio
 720-EVK board
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sean Wang <sean.wang@mediatek.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com>
 <20251203-add-mediatek-genio-520-720-evk-v1-3-df794b2a30ae@collabora.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251203-add-mediatek-genio-520-720-evk-v1-3-df794b2a30ae@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/12/2025 14:59, Louis-Alexis Eyraud wrote:
> Add support for MediaTek MT8189 SoC and its variants, and a device-tree
> for the basic hardware enablement of the Genio 720-EVK board, based on
> MT8391 SoC.
> 
> MT8391 SoC is a variant of MT8189 SoC with a difference for the Arm
> Cortex-A78 CPU core maximum frequency (2.6 Ghz for MT8391, 3 Ghz for
> MT8189). MT8391 hardware register maps are identical to MT8189.

Subject: drop redundant "device-tree for" (not mentioning not correct
name even...).

> 
> The Genio 720-EVK board has following features:
>   - MT8391 SoC
>   - MT6365 PMIC
>   - MT6319 Buck IC
>   - MT6375 Charger IC
>   - 8GB LPDDR5 RAM
>   - 64GB eMMC 5.1
>   - 128GB UFS
>   - 20V DC Jack
>   - USB Type-C Power Adapter
>   - Micro SD card slot
>   - Push Button x 4 (Power, Reset, Download and Home Key)
>   - LED x 3 (System Power, Reset, DC-IN Power)
>   - USB Type-C Connector (USB 3.2) x 2
>   - USB Type-C Connector (USB 2.0) x 1
>   - 3.5mm Earphone Jack x 1 (with Microphone Input)
>   - 3.5mm Line Out Audio Jack x 1
>   - Analog Microphone x 1
>   - Digital Microphone x 2
>   - Gigabit Ethernet with RJ45 connector
>   - DP x 1 (Mode over USB Type-C)
>   - LVDS port x 1
>   - eDP port x 1
>   - UART x2 with serial-to-usb converters and USB Type-C connectors
>   - UART Port x 2 on Pin Header
>   - M.2 Slot x 2
>   - I2C Capacitive Touch Pad
>   - 4-Lane DSI x 1
>   - 4-Data Lane CSI x 2
>   - I2S Pin header
>   - 40-Pin 2.54mm Pin Header x 1
>   - CAN Bus x 1 (RS232 Connector)
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile              |   1 +
>  arch/arm64/boot/dts/mediatek/mt8189.dtsi           | 860 +++++++++++++++++++++
>  .../boot/dts/mediatek/mt8391-genio-720-evk.dts     |  15 +
>  .../boot/dts/mediatek/mt8391-genio-common.dtsi     | 555 +++++++++++++
>  4 files changed, 1431 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index c5fd6191a925ad8fcea401712f7a686e8b0a57c8..e3b63085c0608b86dc8638c9d5e0b73441e9ed7b 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk-ufs.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-grinn-genio-700-sbc.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8391-genio-720-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-kontron-3-5-sbc-i1200.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l-8-hd-panel.dtbo
> diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..bf8a232bcaf10cdf4c590109aea68c9a3e82cc42
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
> @@ -0,0 +1,860 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *
> + * Copyright (c) 2025 Collabora Ltd.
> + * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mediatek,mt8189-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "mediatek,mt8189";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
> +		i2c8 = &i2c8;
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		serial0 = &uart0;

None of above are aliases of the soc. Please move them to the board,
because these are properties of the board currently (we did not finish
the discussion about soc-aliases, so it cannot be used as reason for above).



> +	};
> +
> +	clk32k: oscillator-clk32k {

Either oscillator or clock (clk). Not both. "clock-clk" makes no sense
and this is implied by oscillator.

Please use name for all fixed clocks which matches current format
recommendation: 'clock-<freq>' (see also the pattern in the binding for
any other options).

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml


Best regards,
Krzysztof
