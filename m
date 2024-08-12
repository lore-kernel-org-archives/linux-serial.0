Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777D14EC53;
	Mon, 12 Aug 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467073; cv=none; b=hlHCPr+YWWqPH0xKf5vHIs0Xds2LiNa3eNgax4R8hcqOyJ+ZpLMgM+dBaHC4rAZF4+S14d8p8/WzXa0qqV+NxP7UnLIt4eJ4ndLLvKCJTY9s91Xd09Pv9r2oz2KlcffpZV9+5HrgxloZA7c9XR+2awvRz4TiinIyeT/QhDDG89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467073; c=relaxed/simple;
	bh=CVNKSbLYEeSmnP+OvcToyXEeMut4bzfxHpnr90eyLe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHg0gcCM/hm3AH65asrJ/WlEACBeRxbSLMojcrLGPOQQDdRjST41YCyALvFYrRovlRROTYzJnW3er/i8CQ/mT7cp/iJwGSjmumv+lK2rsHrjum5ooZAB+BO4YoH3dno4Tq989LjQhdshSa6QTVxFYQW4XFNJPDMEoNVnXgf3YpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Mesmbd63; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Mesmbd63"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8A3E041515;
	Mon, 12 Aug 2024 14:51:06 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LMZAk-i2Lzoa; Mon, 12 Aug 2024 14:51:05 +0200 (CEST)
Date: Mon, 12 Aug 2024 20:50:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723467065; bh=CVNKSbLYEeSmnP+OvcToyXEeMut4bzfxHpnr90eyLe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mesmbd63hEeaQoftBXPQoJynz88NwARw7G72V5f155OtTf9cmFmu0+9037fxZN8YL
	 uNs/Q+hjRyc1ETLg2ZNVx6tHZ5rLh3VjPexDkgU1pXOTXQcxgttkbUyDX0S9EfUfy+
	 Myne47pt6dB9DuZGOW2bazzStrDfZpzXdMuMnsBugg1umSrHKeXZGlvMbtYQKbRQG3
	 a23Cp2XSyevt/fyeqKSad1ZXpl/eN3KSn9Lg0eMysRPG0cpcfHJBpptcCobW4gwkXB
	 B/HcLx5CpTBYKpr/+lwcfUj9IAu42HO1SHJstRn0MPycJbZdLEd4HO1TvYkSMirumR
	 V+Mqub8U7NXJQ==
From: Yao Zi <ziyao@disroot.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>,
	Celeste Liu <CoelacanthusHex@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Message-ID: <ZroDTp6Y6ueODB0g@ziyaolaptop.my.domain>
References: <20240811140725.64866-1-ziyao@disroot.org>
 <20240811140725.64866-4-ziyao@disroot.org>
 <24e2b1d2c970e894afd8849d501bcddd@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24e2b1d2c970e894afd8849d501bcddd@manjaro.org>

On Sun, Aug 11, 2024 at 11:39:18PM +0200, Dragan Simic wrote:
> Hello Yao,
> 
> Please see one comment below.
> 
> On 2024-08-11 16:07, Yao Zi wrote:
> > This initial device tree describes CPU, interrupts and UART on the chip
> > and is able to boot into basic kernel with only UART. Cache information
> > is omitted for now as there is no precise documentation. Support for
> > other features will be added later.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 182 +++++++++++++++++++++++
> >  1 file changed, 182 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > new file mode 100644
> > index 000000000000..0596cdc38737
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > @@ -0,0 +1,182 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
> > + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +	compatible = "rockchip,rk3528";
> > +
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +		serial1 = &uart1;
> > +		serial2 = &uart2;
> > +		serial3 = &uart3;
> > +		serial4 = &uart4;
> > +		serial5 = &uart5;
> > +		serial6 = &uart6;
> > +		serial7 = &uart7;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu-map {
> > +			cluster0 {
> > +				core0 {
> > +					cpu = <&cpu0>;
> > +				};
> > +				core1 {
> > +					cpu = <&cpu1>;
> > +				};
> > +				core2 {
> > +					cpu = <&cpu2>;
> > +				};
> > +				core3 {
> > +					cpu = <&cpu3>;
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu0: cpu@0 {
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x0>;
> > +			device_type = "cpu";
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x1>;
> > +			device_type = "cpu";
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu2: cpu@2 {
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x2>;
> > +			device_type = "cpu";
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu3: cpu@3 {
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x3>;
> > +			device_type = "cpu";
> > +			enable-method = "psci";
> > +		};
> > +	};
> > +
> > +	psci {
> > +		compatible = "arm,psci-1.0", "arm,psci-0.2";
> > +		method = "smc";
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> > IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> > +	};
> > +
> > +	xin24m: clk-24m {
> 
> Please use "xin24m: clock-xin24m { ... }" instead, because that follows
> the recently established revised pattern for clock names.  We should have
> come consistency in the new SoC dtsi additions.

It's a careless typo, sorry for the noise. Will be fixed in next version.

Best regards,
Yao Zi
