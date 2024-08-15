Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466EB1714BB;
	Thu, 15 Aug 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740223; cv=none; b=gmmsgUfIAiRe1cDaSunXH+BeF6WmAKOGeXFRcWxWtTNIA6Y+a8nmu7Ds/IqC+3xKjMRDLg//s/+Zw6yRva+EntIoSRqhA8h2KJqWFZKv6exO8B80ryME+nMya0s9+2Tb74EjDYA1ZRWreZaJUm78c+jlOwB1W6jSytvyrGlYzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740223; c=relaxed/simple;
	bh=sT04QvnLEsoGXewaUEmLWMYdjXWOQ/Qe16TyWFy9crE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=somuc9W/8qz2pyAz/TZ9oPMhPR7l3jxdVrCzLFuUvj8vjHwNzADKfTwgRqfSEc6UqwBOmPLRPkelw0SQwhkJm7HEffFgnrTkmTTDfe4hRylII2hGiMIYE+C5O/s9HQrX+UWsWfeNA5pE2Pa+xOu2RXnyhvgiXjdcxTFSnGV/494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MBos0nqn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MBos0nqn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dq8puxKj0ZeN7IVpwGFCF5x6k5LykH5w1x10HHPN5Sg=; b=MBos0nqnRP7dkdT8OBgJI4MLbr
	86XxcH61JoKPx3Lh9ripFgnIMZyaYuC2ajT6obDwySQfgVdtnNMqY4Z0hrkfaxWmMBW+r+c0OCMSN
	0oHKHHCSm26Y0ZSb93NDXMoy8rC8opEiEyiJjy9nC1f7audLXYD3xgh+raPufldKTHKYSHKH+3WQz
	/AuiBIEtcgLHBeGQHhvUIclFBmpt2vUG38M/9LJmdA1P3tLPG6ynRObk6ypfXQ7uvIkhzrAdZuj/P
	lDZPDtBlieidCYjYDG7d06u0uf8YSEcthqNGD8m9KtWVy7SVbgROFbSb7TGXpIPc+HjwtxiDHy26J
	6G1ymHlw==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sedZJ-0005XG-K6; Thu, 15 Aug 2024 18:43:21 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
 Ondrej Jirman <megi@xff.cz>, Yao Zi <ziyao@disroot.org>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH v3 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Date: Thu, 15 Aug 2024 18:43:20 +0200
Message-ID: <10324095.IZOipudI63@diego>
In-Reply-To: <20240814155014.18097-4-ziyao@disroot.org>
References:
 <20240814155014.18097-1-ziyao@disroot.org>
 <20240814155014.18097-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Mittwoch, 14. August 2024, 17:50:13 CEST schrieb Yao Zi:
> This initial device tree describes CPU, interrupts and UART on the chip
> and is able to boot into basic kernel with only UART. Cache information
> is omitted for now as there is no precise documentation. Support for
> other features will be added later.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>

not sure if you have seen Krzysztof's comment yesterday, that he found
the soc node getting documented in 2019 [0].

I guess that counts as a strong suggestion. Not sure how you're feeling
about that, but I guess we could move to that scheme for new socs.

So would you be willing to move the mmio-devices to a soc node?
(stuff with mmio addresses in the node name)


Thanks
Heiko

[0] https://lore.kernel.org/all/6320e4f3-e737-4787-8a72-7bd314ba883c@kernel.org/

> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 182 +++++++++++++++++++++++
>  1 file changed, 182 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> new file mode 100644
> index 000000000000..816573c5fe9d
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
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	xin24m: clock-xin24m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xin24m";
> +		#clock-cells = <0>;
> +	};
> +
> +	gic: interrupt-controller@fed01000 {
> +		compatible = "arm,gic-400";
> +		reg = <0x0 0xfed01000 0 0x1000>,
> +		      <0x0 0xfed02000 0 0x2000>,
> +		      <0x0 0xfed04000 0 0x2000>,
> +		      <0x0 0xfed06000 0 0x2000>;
> +		interrupts = <GIC_PPI 9
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		interrupt-controller;
> +		#address-cells = <0>;
> +		#interrupt-cells = <3>;
> +	};
> +
> +	uart0: serial@ff9f0000 {
> +		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xff9f0000 0x0 0x100>;
> +		clock-frequency = <24000000>;
> +		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-io-width = <4>;
> +		reg-shift = <2>;
> +		status = "disabled";
> +	};
> +
> +	uart1: serial@ff9f8000 {
> +		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xff9f8000 0x0 0x100>;
> +		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-io-width = <4>;
> +		reg-shift = <2>;
> +		status = "disabled";
> +	};
> +
> +	uart2: serial@ffa00000 {
> +		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xffa00000 0x0 0x100>;
> +		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-io-width = <4>;
> +		reg-shift = <2>;
> +		status = "disabled";
> +	};
> +
> +	uart3: serial@ffa08000 {
> +		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xffa08000 0x0 0x100>;
> +		reg-io-width = <4>;
> +		reg-shift = <2>;
> +		status = "disabled";
> +	};
> +
> +	uart4: serial@ffa10000 {
> +		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xffa10000 0x0 0x100>;
> +		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-io-width = <4>;
> +		reg-shift = <2>;
> +		status = "disabled";
> +	};
> +
> +	uart5: serial@ffa18000 {
> +		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xffa18000 0x0 0x100>;
> +		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-io-width = <4>;
> +		reg-shift = <2>;
> +		status = "disabled";
> +	};
> +
> +	uart6: serial@ffa20000 {
> +		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xffa20000 0x0 0x100>;
> +		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-io-width = <4>;
> +		reg-shift = <2>;
> +		status = "disabled";
> +	};
> +
> +	uart7: serial@ffa28000 {
> +		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xffa28000 0x0 0x100>;
> +		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-io-width = <4>;
> +		reg-shift = <2>;
> +		status = "disabled";
> +	};
> +};
> 




