Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06B1EA84;
	Sun,  4 Aug 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722777681; cv=none; b=VFqzHcK5eYVMYLv4PfopYUvlvy124VhgWOu9DZbdNDdySWminIfEyypXMkDFQZaQo1GzgVqPKG4ppnl1U1lBDbA+MnsJ4HQ3uwuccpGfJAffsAFVDtl3FejEuIabZnQuchxEhO5o509negUI/xxwc9beaMQskVb+vH+TQLpCt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722777681; c=relaxed/simple;
	bh=G/uPcnpBqI+s3ISHwUMI67Yv9MNHULgt9fA5st8EqjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfSF0HgZrIQ8iiQ8epjK4qUo8ANPMSPR9997KZCHMgGtOfjeZprF3wnAiJtM5enVTpjV7blP5wgpOM36EEg561eMBNxn1VPOF3NLfUe8FR/YfThxD1Czdz4Nyznll7ICrN9ftk1vSdOEsB5f3mwyCaOdmo89dkIN+dbP8I9msak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Vq5AYFEM; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Vq5AYFEM"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9A83141837;
	Sun,  4 Aug 2024 15:21:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3CTz3J9dJQ3A; Sun,  4 Aug 2024 15:21:08 +0200 (CEST)
Date: Sun, 4 Aug 2024 21:20:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722777668; bh=G/uPcnpBqI+s3ISHwUMI67Yv9MNHULgt9fA5st8EqjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vq5AYFEMExG7hVajp7HkalzaK5eYLARsqunAEv72vGryV1WDr9CX50jLSGAiJsMnX
	 VrrsTf8BVDuqLcxvx9cnfOU/62EUJq+j5GDYTBUGS1AgNIC6ibsAscQuqPWX/SsG52
	 8vdiyxabi6EA2hnbCutQOns9hXKUcV9v7kj6LRxQND8dbiMEf/44Vuu+KvZmb1SCPY
	 Z4I3un8+PtVM9X6uIXUITtnsZAZGXV7ExqPTqP5vLYJ5ak8ZZ1dQ6t02OprTD3K/Hi
	 VKnrmh92d49yTxQigl5weFVQZXR6HOAh1oyD6Fh3zR+e5YhH4sdTyQWWEBOYilVXon
	 vDuxn8/eFM33w==
From: Yao Zi <ziyao@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Message-ID: <Zq-AFWYaqu7zGuz-@ziyaolaptop.my.domain>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <20240803125510.4699-5-ziyao@disroot.org>
 <56bd1478-ce8c-4c1d-ab16-afe4ad462bf5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bd1478-ce8c-4c1d-ab16-afe4ad462bf5@kernel.org>

On Sun, Aug 04, 2024 at 12:05:11PM +0200, Krzysztof Kozlowski wrote:
> On 03/08/2024 14:55, Yao Zi wrote:
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
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > new file mode 100644
> > index 000000000000..77687d9e7e80
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
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x0>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x1>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu2: cpu@2 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x2>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu3: cpu@3 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x3>;
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
> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> > +	};
> > +
> > +	xin24m: xin24m {
> 
> Please use name for all fixed clocks which matches current format
> recommendation: 'clock-([0-9]+|[a-z0-9-]+)+'

Will be fixed in next revision.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1
> 
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <24000000>;
> > +		clock-output-names = "xin24m";
> > +	};
> > +
> > +	gic: interrupt-controller@fed01000 {
> 
> Why this all is outside of SoC?

Just as Heiko says, device tree for all other Rockchip SoCs don't have
a "soc" node. I didn't know why before but just follow the style.

If you prefer add a soc node, I am willing to.

Best regards,
Yao Zi
