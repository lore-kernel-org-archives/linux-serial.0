Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E072595;
	Sun, 11 Aug 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723412365; cv=none; b=WInCTdXUSFg+frJUW4ODEY2J05+SSrs6Pxjp4UuGUsw0Sn3VA1wUUQGnb+wco+RlEBz3up8LNZMAaK90/uSggvmB8n6D81RDHcsbzbyk5wlezAKfSZL7jwtIAElcQrKMjnNul3+5sMbXiUa5YcsVJBBZlF5rKUVxJVMsfUx0iVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723412365; c=relaxed/simple;
	bh=qU/itABNJeaKFcMZ4doGWHX/sg0T3a0Nim6U+UJTQys=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PO/wuRALM59UiMHMdD+u5Hu7zlN3bN34rM/CaWR+AItlorUyy5BWjlPy+RoIBwj+exjfzkHUiRGt6aMdpiD4mInyDmD34vsqOAFqeU/mboV+CRW0p7ZMYd9WEp3EeJ63lWvtoZ6yrL/Xr8pfQFZ/76HuUW5jFSYyhx8/2OeLxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MPZ8/K7c; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MPZ8/K7c"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723412360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGqo9g+SoFcjlWadP87QaHf5NGtLpnQnXJR1D/7cuxI=;
	b=MPZ8/K7cwyh8O1rdyBMHPpJBpUJ3GhleN0lB+wiKtRdfRp0s59rpfwvaNHjxzFttKBiajL
	eNk5TxDldhTVM1e8zzEXNA42bk0mZVT36cTj/DB+oMVEldppwZofuySef8lFmUyJNiw+EM
	CTQ21ZlgRn4lEkqPSLZgjhjYoFQ5RFGzEJCzVblUzAydVtlAT8/ilCDFLjs6OYsZpGaTwU
	Q14hYse8UTv6xeWXCH+zheyyt9s9PBCtIfar+/szkH8cJWiIs/6JLzIZyYCRXLCZhIKtld
	esCkD5TA3ReMB59NU2lfppJCfhTHfWspyYLF05pD97lR4Dm/nWP1eJEPVwwW/A==
Date: Sun, 11 Aug 2024 23:39:18 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>, Andy Yan
 <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>, Jagan Teki
 <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>, Celeste Liu
 <CoelacanthusHex@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
In-Reply-To: <20240811140725.64866-4-ziyao@disroot.org>
References: <20240811140725.64866-1-ziyao@disroot.org>
 <20240811140725.64866-4-ziyao@disroot.org>
Message-ID: <24e2b1d2c970e894afd8849d501bcddd@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Yao,

Please see one comment below.

On 2024-08-11 16:07, Yao Zi wrote:
> This initial device tree describes CPU, interrupts and UART on the chip
> and is able to boot into basic kernel with only UART. Cache information
> is omitted for now as there is no precise documentation. Support for
> other features will be added later.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 182 +++++++++++++++++++++++
>  1 file changed, 182 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> new file mode 100644
> index 000000000000..0596cdc38737
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "rockchip,rk3528";
> +
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +		serial6 = &uart6;
> +		serial7 = &uart7;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | 
> IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	xin24m: clk-24m {

Please use "xin24m: clock-xin24m { ... }" instead, because that follows
the recently established revised pattern for clock names.  We should 
have
come consistency in the new SoC dtsi additions.

> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xin24m";
> +		#clock-cells = <0>;
> +	};
